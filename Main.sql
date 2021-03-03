/* do not change the following three lines! */
.header on
.mode column
.read GoGoGadget.sql
/* do not change the above three lines! */

/* Searching and Sorting*/

/* Task One:	A list of all of the items that belong to the category ‘Boys Toys’. The list should include all item details.*/
SELECT Item.itemID, Item.description, Item.category, Item.price
FROM Item
WHERE category = "Boys Toys";

/* Task Two:	A list of all items in each order. The list should show the order number, item description and price and should be in ascending order of order number.*/
SELECT OrderItem.orderNo, Item.description, Item.price
FROM Item, OrderItem
WHERE Item.itemID = OrderItem.itemID
ORDER BY OrderItem.orderNo ASC;

/* Task Three:	A list of all the full names of all customers with a surname containing the letters 'em' along with the dates of their orders. The list should be in alphabetical order of surname; when two or more surnames are the same, they should be listed in alphabetical order of first name.*/
SELECT Customer.forename, Customer.surname, CustOrder.orderDate
FROM Customer, CustOrder
WHERE Customer.surname LIKE "%em%"
ORDER BY Customer.surname ASC, Customer.forename ASC;

/*Computed Fields*/

/* Task Four:	A list showing the order number, order date, item descriptions, quantities ordered and prices. A calculated field should be used to work out the total cost of each item (quantity x price in each order). The details should be listed in order of date, from oldest to most recent.*/
SELECT CustOrder.orderNo, CustOrder.orderDate, Item.description, OrderItem.quantity, Item.price, (OrderItem.quantity * Item.price) AS 'Total Item Cost'
FROM CustOrder, Item, OrderItem
WHERE CustOrder.orderNo = OrderItem.orderNo AND OrderItem.itemID = Item.ItemID;

/* Task Five:	The company has decided to apply a 5% discount to any items whenever the minimum order quantity is 4. Create a list showing the relevant order numbers, the description of qualifying item, the quantity of the item ordered, the original price, the value of the discount and the discounted price.*/
SELECT OrderItem.orderNo, Item.description, OrderItem.quantity, Item.price, (Item.price * 0.05) AS 'Discount Value', (Item.price * 0.95) AS 'Discounted Price'
FROM OrderItem, Item
WHERE OrderItem.quantity >= 4;

/*Grouping Data and Aggregate Functions*/

/* Task Six: A list showing details of all orders placed by Mari Singer. The list should show the order number, order date, description, quantity ordered, price and the total price of each item in the order. The list should be displayed with details of the most recent order first.*/
SELECT CustOrder.orderNo, CustOrder.orderDate, Item.description, OrderItem.quantity, Item.price, (OrderItem.quantity * Item.price) AS 'Total Item Price'
FROM CustOrder, Item, OrderItem, Customer
WHERE Customer.customerID = CustOrder.customerID AND CustOrder.orderNo = OrderItem.orderNo AND OrderItem.itemID = Item.itemID AND Customer.forename = "Mari" AND Customer.surname = "Singer"
ORDER BY CustOrder.orderDate DESC;

/* Task Seven: A list showing each category with the number of items in each category. Details of the largest category should be listed first.*/
SELECT Item.category, COUNT(Item.itemID) AS 'Number of items in category'
FROM Item
GROUP BY Item.category
ORDER BY COUNT(Item.itemID) DESC;

/* Task Eight: A list showing each order number, order date and the total cost of the order for all orders placed in January 2008. The details of the oldest order should be listed first.*/
SELECT CustOrder.orderNo, CustOrder.orderDate, SUM(Item.price*OrderItem.quantity) AS "Total Order Cost"
FROM CustOrder, Item, OrderItem
WHERE CustOrder.orderNo = OrderItem.orderNo AND OrderItem.itemID = Item.ItemID AND CustOrder.orderDate LIKE "2008-01-%"
GROUP BY CustOrder.orderNo
ORDER BY CustOrder.orderDate ASC;

/*Additional Queries*/

/* Task Nine: A list showing the full name of all customers who have an email address provided by MobileLife.*/
SELECT Customer.forename, Customer.surname, Customer.customerEmail
FROM Customer
WHERE customerEmail LIKE "%mobilelife%";

/* Task Ten: A list showing the category, the number of orders placed and the total quantity of items in the 'Office Distractions' category that have been ordered.*/

SELECT Item.category, COUNT(OrderItem.orderNo) AS 'Number of Orders Placed', SUM(OrderItem.quantity) AS 'Total Quantity'
FROM Item, OrderItem
WHERE Item.itemID = OrderItem.itemID AND Item.category = 'Office Distractions'
GROUP BY Item.category;

/* Task Eleven: A list showing the name of each category and the average price of items that belong to that category.*/
SELECT Item.category, ROUND(AVG(Item.price), 2) AS 'Average Price'
FROM Item
GROUP BY Item.category;

/* Task Tweleve: A list showing each order number with the customer’s full name and the number of items ordered. The only orders shown should be those placed by customers whose surname contains the letters 'i' and 'g' separated by one other letter (the letter 'g' is not the last letter).*/
SELECT CustOrder.orderNo, Customer.forename, Customer.surname, SUM(OrderItem.quantity) AS 'Number of Items Ordered'
FROM CustOrder, Customer, OrderItem
WHERE Customer.surname LIKE '%i_g%' AND Customer.customerID = CustOrder.customerID AND CustOrder.orderNo = OrderItem.orderNo
GROUP BY CustOrder.orderNo;

/* Task Thirteen: A list showing the customerID and postcode and the number of orders placed by the customer in 2008. Arrange the list so that the customer who placed the most orders is listed first; customers who placed the same number of orders should be listed alphabetically by postcode.*/
SELECT Customer.customerID, Customer.postcode, COUNT(CustOrder.orderNo) AS 'Number of Orders Placed'
FROM Customer, CustOrder
WHERE CustOrder.orderDate LIKE '2008%' AND CustOrder.customerID = Customer.customerID
GROUP BY Customer.customerID
ORDER BY COUNT(CustOrder.orderNo) DESC, Customer.postcode ASC;

/* Task Fourteen:	The company is offering a 5% discount on all orders placed in December 2007.*/
/* Produce a list to show each order number and order date, the order totals before discount, the value of each order’s 5% discount and the overall totals after discount. Orders should be listed with the oldest order first. Where two or more orders are placed on the same day, they should be sorted by OrderNo in ascending order.*/
SELECT CustOrder.orderNo, CustOrder.orderDate, SUM(Item.price * OrderItem.quantity) AS 'Original Order Total', (SUM(Item.price * OrderItem.quantity) * 0.05) AS 'Value of 5% Discount', (SUM(Item.price * OrderItem.quantity) * 0.95) AS 'Final Total'
FROM CustOrder, Item, OrderItem
WHERE CustOrder.orderDate LIKE "2007-12-%" AND CustOrder.orderNo = OrderItem.orderNo AND OrderItem.itemID = Item.itemID
GROUP BY CustOrder.orderNo
ORDER BY CustOrder.orderDate DESC, CustOrder.orderNo ASC;


