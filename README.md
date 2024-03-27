# Budget Pilot App

Budget Pilot

* Accounts: allows multiple accounts in different currencies.


## Data Model

Smaller pieces of data are recorded locally with the shared_preferences package.

Keys:

currency: stores the default currency abbreviation according to the three letters ISO 4217
   e.g. USD, GBP, ...


Structured data is stored in a SQLite database accessed with the sqflite Flutter package.

Table account: (id INTEGER, name: TEXT, currency: TEXT)
  Eg. {'id': 4, name': 'Cash', 'currency': 'GBP'}

Table transaction: (WiP)

   Each element is of type Transaction and it contains the following fields:
      budgetId: Nullable for non expenses
      accountId: 
      type: InitialBalance, Income, Expense, InternalTransfer
      transactionDate:
      amount:
