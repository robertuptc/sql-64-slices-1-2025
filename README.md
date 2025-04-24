# 64 Slices of Pizza

## Goals

64 Slices of Pizza! Practice working with CSV files and designing schema based on the CSV data.

## Scenario

Severina Snap has a side-hustle running a pizza store. She's not very personable, so the stores are delivery-only. The stores are known for having magical combinations of rare and various toppings.

Severina and [Daldus, the owner of 32 Flavors Ice Cream](https://github.com/GroupWorkInternational/sql-32-flavors-1), go way back and have always talked about combining to form their dream establishment, Dogweed's 1024 Calories of Pizza and Ice Cream (named after [a special ingredient they both use](https://texasbeyondhistory.net/ethnobot/images/dogweed.html) for an ice cream flavor and pizza topping), but, it has yet to happen.

Now that 32 Flavors is switching over to computers though, 64 Slices is following suit. Severina heard great things about you from Daldus and has hired you as well to build their inventory system!

64 Slices is a bit more modern - they actually have been using spreadsheets to manage their inventory - but Severina is very busy and doesn't have time to help you. So all you have is CSV files from the spreadsheets.

## Project

Severina has given you csv exports of their existing spreadsheets. This is their current inventory, driver, and delivery information. There may or may not be a bit more information in there or some gaps - they're not sure, to be honest, as they're always working quite hard.

Your task is, based on these CSV files, to build their data model and system.

### Deliverables

For each stage ...

- A schema diagram
- SQL files to create the postgres data schema and for all queries
- A working postgres database with the data imported

*Recommendation: Do each stage on a separate git branch so you can refer back easily to previous work.*

## Stage 1

Just getting the data in will require a bit of work! Design a conceptual data model - make an Entity-Relationship diagram - and then use that and the data itself to design your data schema and create a Postgres database and import the data into it.

## Stage 2

Continue work on your data schema, so it is complete and has all the data in it so you'll be ready to write SQL Queries for Stage 3. 

## Stage 3

If you have not, Severina would like some basic analytics about her business:

- How many drivers she has.
- How many deliveries has each store made?
- How many deliveries has each driver made?
- Which driver did the shortest delivery?
- Which driver did the longest delivery?

... she would also like to know:

- How much did money did they make on each order?
- Which store made the most money?
- Which customer spent the most money?
- How much money did they make each month?
  
Severina is also curious about her drivers ...

- Which driver, on average, takes the longest?
- Which driver, on average, is the quickest?
