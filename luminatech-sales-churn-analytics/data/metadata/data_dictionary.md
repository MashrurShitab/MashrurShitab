# Data Dictionary

This dictionary describes the transaction-level LuminaTech dataset and the engineered fields used in the portfolio analysis. Original field descriptions are based on the supplied project metadata where available.

| Column | Description | Data type | Business meaning | Used in EDA/modelling |
|---|---|---|---|---|
| `accounting_date` | The date when the financial transaction is recorded in the accounting system. | int64 | Time-series analysis, seasonality, and operational timing. | Context / identifier |
| `fiscal_year` | The year in which the transaction occurs, based on the company's fiscal calendar. | int64 | Time-series analysis, seasonality, and operational timing. | Yes |
| `fiscal_month` | The month of the fiscal year during which the transaction takes place. | int64 | Time-series analysis, seasonality, and operational timing. | Yes |
| `calendar_year` | The year in which the transaction occurs, based on the standard calendar. | int64 | Time-series analysis, seasonality, and operational timing. | Context / identifier |
| `calendar_month` | The month of the year during which the transaction takes place, based on the standard calendar. | int64 | Time-series analysis, seasonality, and operational timing. | Context / identifier |
| `calendar_day` | The specific day of the month on which the transaction occurs. | int64 | Time-series analysis, seasonality, and operational timing. | Context / identifier |
| `company_code` | A unique identifier for the company conducting the transaction. | int64 | Operational context for transaction-level business analysis. | Yes |
| `customer_code` | A unique identifier for the customer involved in the transaction. | object | Customer segmentation and geographic performance analysis. | Context / identifier |
| `customer_district_code` | A code representing the geographical district of the customer. | int64 | Customer segmentation and geographic performance analysis. | Yes |
| `item_code` | A unique identifier for the item being sold. | object | Product mix and product profitability analysis. | Context / identifier |
| `business_area_code` | A code representing the specific area of business related to the transaction. | object | Commercial channel, segment, and portfolio analysis. | Context / identifier |
| `item_group_code` | A code indicating the group to which the item belongs. | object | Product mix and product profitability analysis. | Context / identifier |
| `item_class_code` | A code categorizing the item based on its characteristics or type. | object | Product mix and product profitability analysis. | Yes |
| `item_type` | A descriptor indicating the nature or category of the item. | int64 | Product mix and product profitability analysis. | Yes |
| `bonus_group_code` | A code identifying the group related to bonuses or incentives for sales. | object | Operational context for transaction-level business analysis. | Context / identifier |
| `environment_group_code` | A code denoting the environmental category related to the product. | object | Operational context for transaction-level business analysis. | Context / identifier |
| `technology_group_code` | A code representing the technology category associated with the item or service. | object | Operational context for transaction-level business analysis. | Context / identifier |
| `commission_group_code` | A code identifying the group that determines commission structures for sales. | object | Operational context for transaction-level business analysis. | Context / identifier |
| `reporting_classification` | A classification used for reporting purposes, indicating how the transaction should be categorized. | object | Operational context for transaction-level business analysis. | Context / identifier |
| `light_source` | A code indicating the source of lighting related to the item, if applicable. | object | Product mix and product profitability analysis. | Context / identifier |
| `warehouse_code` | A code identifying the warehouse where the item is stored or shipped from. | object | Operational context for transaction-level business analysis. | Context / identifier |
| `abc_class_code` | A classification code used in inventory management to indicate the importance of an item (e.g., A, B, C categories). | object | Operational context for transaction-level business analysis. | Context / identifier |
| `abc_class_volume` | The volume of goods associated with the ABC classification. | object | Operational context for transaction-level business analysis. | Context / identifier |
| `business_chain_l1_code` | A code representing the first level of the business chain for tracking and analysis. | object | Commercial channel, segment, and portfolio analysis. | Context / identifier |
| `business_chain_l1_name` | The name corresponding to the business chain level 1 code. | object | Commercial channel, segment, and portfolio analysis. | Context / identifier |
| `contact_method_code` | A code indicating the contact used. | object | Operational context for transaction-level business analysis. | Context / identifier |
| `salesperson_code` | A unique identifier for the salesperson associated with the transaction. | object | Operational context for transaction-level business analysis. | Context / identifier |
| `order_type_code` | A code that categorizes the type of order. | object | Operational context for transaction-level business analysis. | Yes |
| `market_segment` | A descriptor of the specific market segment targeted by the transaction. | object | Commercial channel, segment, and portfolio analysis. | Yes |
| `value_sales` | The monetary value of sales generated from the transaction. | float64 | Revenue, cost, demand, and profitability measurement. | Yes |
| `value_cost` | The cost associated with the transaction. | float64 | Revenue, cost, demand, and profitability measurement. | Yes |
| `value_quantity` | The quantity of items sold or transacted. | int64 | Revenue, cost, demand, and profitability measurement. | Yes |
| `value_price_adjustment` | Any adjustments made to the price during the transaction (discounts, surcharges, etc.). | int64 | Operational context for transaction-level business analysis. | Context / identifier |
| `currency` | The currency in which the transaction is conducted. | object | Operational context for transaction-level business analysis. | Context / identifier |
| `item_source_class` | A classification indicating the source or origin of the item. | float64 | Operational context for transaction-level business analysis. | Context / identifier |
| `invoice_number` | A unique identifier for the invoice related to the transaction. | object | Operational context for transaction-level business analysis. | Context / identifier |
| `line_number` | The line item number on the invoice, indicating specific items. | object | Operational context for transaction-level business analysis. | Context / identifier |
| `invoice_date` | The date the invoice is issued. | int64 | Time-series analysis, seasonality, and operational timing. | Context / identifier |
| `customer_order_number` | A unique identifier for the customer's order. | object | Operational context for transaction-level business analysis. | Context / identifier |
| `order_date` | The date when the order was placed. | int64 | Time-series analysis, seasonality, and operational timing. | Context / identifier |
| `dss_update_time` | The timestamp indicating when the data was last updated in the system. | object | Time-series analysis, seasonality, and operational timing. | Context / identifier |
| `profit` | Transaction-level gross profit calculated as value_sales minus value_cost. | engineered | Revenue, cost, demand, and profitability measurement. | Yes |
| `profit_margin` | Profitability ratio calculated as profit divided by value_sales, with invalid divisions handled as missing values. | engineered | Revenue, cost, demand, and profitability measurement. | Yes |
| `time_gap` | Number of days between order_date and invoice_date, used as an order processing efficiency measure. | engineered | Operational context for transaction-level business analysis. | Yes |
| `customer_district_names` | Human-readable customer district label mapped from customer_district_code. | engineered | Customer segmentation and geographic performance analysis. | Context / identifier |
| `first_purchase` | Earliest invoice_date observed for each customer in the transaction history. | engineered | Operational context for transaction-level business analysis. | Context / identifier |
| `customer_type` | Customer status indicating whether the transaction is the first observed purchase or a returning purchase. | engineered | Operational context for transaction-level business analysis. | Yes |
| `invoice_month` | Month extracted from invoice_date for seasonality and regression analysis. | engineered | Time-series analysis, seasonality, and operational timing. | Yes |
| `recency` | Number of days since the customer most recently purchased, measured from the latest invoice date in the dataset. | engineered | Customer retention and churn-risk modelling. | Yes |
| `order_frequency` | Customer-level purchase frequency metric derived from order count and observed recency window. | engineered | Customer retention and churn-risk modelling. | Yes |
| `spending_score` | Composite customer value score combining total spend and profit contribution. | engineered | Customer retention and churn-risk modelling. | Yes |
| `churn` | Customer churn label indicating inactivity beyond the selected threshold, typically three months. | engineered | Customer retention and churn-risk modelling. | Yes |
| `churned` | Binary version of the churn label used for classification modelling. | engineered | Customer retention and churn-risk modelling. | Yes |
