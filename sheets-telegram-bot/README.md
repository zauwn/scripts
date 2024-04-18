# Google Sheets integration with a telegram bot

## Featues
- Google Sheet to Import that has the necessary sheets (Overview, Categories, History)
- Javascript script for telegram integration

## Missing
- Sheet - Overview table compute information from history by year
- Sheet - Overview add some graphs

## Sources
[Google Sheets](https://docs.google.com/spreadsheets/)

[Apps Script](https://script.google.com/)

[Telegram Bot Father](https://core.telegram.org/bots/#how-do-i-create-a-bot)

[Telegram Bots Tutorial](https://core.telegram.org/bots/tutorial)

[Google Sheets SUMIFS](https://support.google.com/docs/answer/3238496?hl=en)


## How-to

1- Create new bot on telegram using @botFather and get bot token ( check sources)

2- Get your user telegram ID
    - on the telegram app message `/start` to @userinfobot to get your user ID

3- Import [Budget - Telegram](telegram-bot-budget.ods) to google sheets
    - Blank spreadsheet -> File -> Import -> Upload

4- ~~ Get Google Sheets ID ~~
    - ~~ From the URL https://docs.google.com/spreadsheets/d/[GOOGLE_SHEET_ID]/edit# ~~

5- Create Apps Script linked to the google sheet
    - Extensions (From Menu) -> Apps Script

6- Copy the [budget-bot.js](budget-bot.js) content to the Code.js File

7- Make a new Deployment -> Select Type (Web app)
    - Give access to anyone (
    - Go over the authorize access (This is your app so it is normal the not verified by google alert)
    - Save the App URL

8- Head over to Project Settings and create 4 Script Properties
    - ~~ sheets_id (3.) ~~
    - telegram_id (id from 2.)
    - telegram_token (token from 1.)
    - webapp_url (URL from 7.)

9- Head over to the Code.js Editor View and run the `setWebhook` funtion to create the webhook for your telegram bot

10- Everything should be ready to start interacting with your bot
    - Send message to bot
        - Fitness Class, 20, gym

## How it works
- Missing gifs/vids


## Extras
Google Sheets - SUM by month/year Formula

#### Sheet Example
```
A           B               C       D           E
Date        Description     Value   Category    Sub-Category
2024/01/29  Rent            1000    House       Rent
2024/01/30  Workshop        400     Car         Maintenance
(...)
```
#### Formula - Sum filtered by Month & Year & Category & Sub-Category
```
Category        - House
Sub-Category    - Rent
Month           - January (1)
Year            - 2024

# Using Sheets Locale US - January(1) and February(2) / 2024
=SUMIFS(C:C,D:D,"House",E:E,"Rent",ARRAYFORMULA(YEAR(A:A)),2024,ARRAYFORMULA(MONTH(A:A)),1)
=SUMIFS(C:C,D:D,"House",E:E,"Rent",ARRAYFORMULA(YEAR(A:A)),2024,ARRAYFORMULA(MONTH(A:A)),2)

# Using Sheets Locale EU/PT - January (1) and February(2) / 2024
=SUMIFS(C:C;D:D;"House";E:E;"Rent";ARRAYFORMULA(YEAR(A:A));2024;ARRAYFORMULA(MONTH(A:A));1)
=SUMIFS(C:C;D:D;"House";E:E;"Rent";ARRAYFORMULA(YEAR(A:A));2024;ARRAYFORMULA(MONTH(A:A));2)
```
