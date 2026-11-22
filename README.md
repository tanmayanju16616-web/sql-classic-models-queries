# SQL Analysis: Classic Models Sales Database

SQL queries on a retail sales database (the "Classic Models" model-car company). The repo has an 8-question assessment and a second file of advanced business queries, covering data modification, joins, aggregation, subqueries, CTEs and window functions. It also handles invalid data in the products table.

## Skills Demonstrated

| Topic | Examples |
|---|---|
| **Joins** | Inner, left (outer) and **self joins** across up to 4 tables |
| **Aggregation** | `COUNT`, `SUM`, `AVG`, `MAX`, `GROUP BY`, `HAVING`, date functions |
| **Subqueries** | Correlated subquery: products priced above their own product line's average |
| **CTEs** | Customers above the average payment; offices above the average headcount |
| **Window functions** | `DENSE_RANK` per country, `LAG` for growth, running totals |
| **Data quality** | Found 4 corrupted product rows (text `NULL`, misplaced values) and excluded them so averages and maximums are correct |

## File 1: `classic_models_queries.sql` (8 assessment questions)

| # | Question | Result |
|---|---|---|
| 1 | Delete the unused `Boats` product line, then count rows | **7** rows |
| 2 | Order lines with product code `S18%` and price above 150 | **26** |
| 3 | Top 3 countries by customers | **USA (35), Germany (13), France (12)** |
| 4 | Average credit limit, Singapore | **67,233.33** |
| 5 | Total paid by "Euro+ Shopping Channel" | **715,738.98** |
| 6 | Month with highest total payments | **December**, 1,645,923.26 (all years combined) |
| 7 | Average credit limit of customers handled by the Tokyo office | **83,900.00** |
| 8 | Customer who paid the lowest total | **Boards & Toys Co.** (7,918.60) |

## File 2: `classic_models_advanced_queries.sql` (business analysis)

| Query | Result |
|---|---|
| Top 5 customers by shipped sales | Euro+ Shopping Channel (189.8K), Mini Gifts Distributors (167.8K), Dragon Souveniers (150.1K), Muscle Machine (117.6K), Mini Creations (93.6K) |
| Product lines: product count, average buy price, highest MSRP | e.g. Classic Cars: 36 products, avg 64.65, max MSRP 214.30 |
| Offices above the average headcount | Offices 1, 4 and 6 |
| Managers with more than 3 direct reports | Mary Patterson (4), Gerard Bondur (6), Anthony Bow (6) |
| Customers who never ordered | 24 |
| Products priced above their product line's average | 54 |
| Customers whose total payments exceed the average | 32 |

## Data Quality Note
Four rows in `products` are corrupted: `quantityInStock` holds the text `NULL` and prices are missing or misplaced (for example a buy price of 6125). The price columns are also stored as text. Left alone, this gives wrong averages (e.g. Classic Cars 168 instead of 65) and a text-based "highest MSRP". The product queries cast prices to `DECIMAL` and exclude these rows.

## Database
Eight tables: `offices`, `employees`, `customers`, `orders`, `orderdetails`, `payments`, `productlines`, `products`, in a database named `company`. The database and its data are **not included** in this repository.

## How to Run
1. Create and load the `company` database in MySQL.
2. Run `classic_models_queries.sql` first. It adds employee 1102 (Gerard Bondur) with an `INSERT`, which the advanced queries depend on.
3. Then run `classic_models_advanced_queries.sql`. Run the queries one at a time in MySQL Workbench.

## Tech Stack
SQL (MySQL) · MySQL Workbench

## Author
**Anju Kanwar**
