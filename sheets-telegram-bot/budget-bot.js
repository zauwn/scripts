/**
 * @OnlyCurrentDoc
 */

// Get tokens from properties
var userProperties = PropertiesService.getScriptProperties();
var token = userProperties.getProperty('telegram_token');
var telegramUrl = "https://api.telegram.org/bot" + token;
var webAppUrl = userProperties.getProperty('webapp_url');
var telegramId = userProperties.getProperty('telegram_id');

// Helper function - get telegram info
function getMe() {
  var url = telegramUrl + "/getMe";
  var response = UrlFetchApp.fetch(url);
  Logger.log(response.getContentText());
}

// Initialize telegram webhook
function setWebhook() {
  var url = telegramUrl + "/setWebhook?url=" + webAppUrl;
  var response = UrlFetchApp.fetch(url);
  Logger.log(response.getContentText());
}

// Send simple msg
function sendMsg(id, text) {
  var url = telegramUrl + "/sendMessage?chat_id=" + id + "&text=" + encodeURIComponent(text);
  var response = UrlFetchApp.fetch(url);
  Logger.log(response.getContentText());
}

// Send keyboard msg
function sendText(id, text, keyBoard){
  var data = {
    method:'post',
    payload: {
      method:'sendMessage',
      chat_id:String(id),
      text:text,
      parse_mode:'HTML',
      reply_markup: JSON.stringify(keyBoard)
    }
  };
  UrlFetchApp.fetch(telegramUrl+'/', data);
}

// Helper function to list categories from a dic using telegram inline keyboards
function listCat(id, dict) {
  // generic keyboard
  var k = { "inline_keyboard": [] } ;
  // For each category build inline keyboard with each own callback
  for (c in dict["category"]) {
  // sub-category special string with category attached
    var sub = "/sub-" + String(c);
    // Update inline keyboar with category
    inline = [{"text": c , "callback_data": sub }];
    k["inline_keyboard"].push(inline);
  }
  // Send inline keyboard
  sendText(id, "Categories List", k);
}

// Helper function to list subcategories from a dic using telegram inline keyboards
function listSub(id, dict, data) {
  // generic keyboard
  var k = { "inline_keyboard": [] } ;
  // Split string to get category
  var cat = data.split('-');
  // Get the list of sub-categories for the choosen category
  for (s in dict["category"][cat[1]]) {
    inline = [{"text":  dict["category"][cat[1]][s], "callback_data": 'noop' }];
    k["inline_keyboard"].push(inline);
  }
  // Send list to user
  sendText(id, "SubCategories List", k);
}

// HTTP GET Method
function doGet(e) {
  return HtmlService.createHtmlOutput("Hi there");
}

// HTTP POST Method
function doPost(e) {
  try {
    // Get categories & history sheets data
    var sheet_categories = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('Category');
    var sheet_history = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('History');

    // Initialize spend dictionary
    var spendDict = { "category": {} };

    var spendRange = sheet_categories.getRange("A3:C70");
    var spendValues = spendRange.getValues();
    var spendRows = spendRange.getNumRows();
    //Logger.log('Number of Rows: ' + spendRows)

    // For each row on categories sheet update spend dictionary
    for (var i = 0; i < spendRows; i++)
    {
      // get each row value from categories sheet
      var cat = spendValues[i][0];
      var sub = spendValues[i][1];
      var sym = spendValues[i][2];
      var v = {};

      // Ignore if no symbol for category
      if ( sym == '-') {
        Logger.log('No symbol:' + sym + ' for cat: ' + cat + ' with sub: ' + sub );
      }
      else {
        // Create dictionary with symbols & Categories
        // {
        //   symbol: { Category: CAT1, Subcategory: SUB1 },
        //   (...)
        //   category: {
        //     CAT1: [ "SUB1 (SYM1)", (...) ],
        //     (...)
        //   }
        // }
        v = {
          "Category": cat,
          "Subcategory": sub
        };
        spendDict[sym] = v ;
        spendDict["category"][cat] ?? (spendDict["category"][cat] = []);
        spendDict.category[cat].push((String(sub) + ' (' + sym + ')'));
      }
    }

    // Helper debug code
    // Logger.log('Spend Categories' + JSON.stringify(spendDict));
    // return

    // this is where telegram works
    var contents = JSON.parse(e.postData.contents);

    // Check if callback or simple message
    if (contents.callback_query){
      var id = contents.callback_query.from.id;
      var data = contents.callback_query.data;
      var callback = true
    }
    // Otherwise check if user message
    else if (contents.message){
      var id = contents.message.from.id;
      var text = contents.message.text;
    }

    // Verify that post is from telegram user
    if ( id != telegramId ) {
      throw new Error("Wrong ID: " + id );
    }

    // If getting a callback
    if (callback) {
      // If option to list categories
      if ( data == '/listCategories') {
        return listCat(id, spendDict);
      }
      // If option to list sub-categories
      else if ( data.startsWith('/sub-')) {
        return listSub(id, spendDict, data);
      }
      // Option when sub-categories are selected - just print usage
      else if(data == 'noop') {
        return sendMsg(id, 'Update Budget Format: Description, Value, Symbol');
      }
      // Everything not expected throw exception with error|
      else {
        sendMsg(id, 'Invalid Callback');
        throw new Error("Wrong Callback: " + data );
      }
    }
    // If getting a regular msg
    else {
      // test helper
      if (text == 'test') {
        return sendMsg(id, "Hello! Welcome to your budget bot.");
      }
      // If getting possible budget update test if all required fields are present
      else if (text.indexOf(",")!==-1) {
        // Get date of today/now()
        var dateNow = new Date;
        var date = dateNow.getFullYear() + '/' + ('0' + (dateNow.getMonth() + 1)).slice(-2) + '/' + ( '0' + dateNow.getDate()).slice(-2);
        // Split msg by `,`
        var item = text.split(",");
        // valid format requires at least 3 values
        // Description, Value, Symbol
        if ( item.length > 2 ) {
          var desc = item[0].trim();
          var val = item[1].trim().replace(/\./g, ',');
          var sy = String(item[2].trim());
          Logger.log("Received Desc: " + desc + " Val:" + val + " Symbol: " + sy);
          // Ensure symbol points to valid Category/Sub-Category
          try {
            var cat = spendDict[sy]["Category"];
            var sub = spendDict[sy]["Subcategory"];
          } catch(e) {
            sendMsg(id,"Cat/Sub Symbol does not exist");
            throw e;
          }
          // If all ok, update sheet and return msg to user
          sheet_history.appendRow([date, desc, val, cat, sub]);
          return sendMsg(id,"Budget updated with: " + desc + " (" + val + "€)" + " categorized as: " + cat + "/" + sub);
        }
        // If not enough symbols list categories/sub-categories symbols
        else {
          sendMsg(id, "Missing Cat/Sub Symbol");
          return listCat(id, spendDict);
        }
      }
    }
  } catch(e) {
    Logger.log("Exception: " + e);
    sendMsg(telegramId, "Error: " + e);
  }
}
