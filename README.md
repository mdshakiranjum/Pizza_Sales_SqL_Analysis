# 🍕 Pizza Sales SQL Analysis

## 📌 Project Overview

This project analyzes pizza sales data using **PostgreSQL and SQL** to identify important business insights related to orders, revenue, pizza sizes, pizza categories, and customer ordering patterns.

The project contains **13 SQL business questions**, divided into Basic, Intermediate, and Advanced analysis.

The main objective is to demonstrate practical **SQL and Data Analytics skills** by transforming raw pizza sales data into meaningful business insights.

---

## 🎯 Project Objectives

The project aims to:

- Analyze total orders and revenue
- Identify the highest-priced pizza
- Find the most popular pizza size
- Identify the best-selling pizza types
- Analyze pizza sales by category
- Analyze orders by hour of the day
- Calculate average pizzas ordered per day
- Identify top revenue-generating pizzas
- Calculate revenue contribution by pizza type
- Analyze cumulative revenue over time
- Find the top-performing pizzas within each category

---

# 🗂️ Dataset

The project uses four datasets:

### 1. `orders`

Contains information about customer orders.

**Important columns:**
- `order_id`
- `order_date`
- `order_time`

### 2. `order_details`

Contains information about pizzas included in each order.

**Important columns:**
- `order_details_id`
- `order_id`
- `pizza_id`
- `quantity`

### 3. `pizzas`

Contains information about pizza products.

**Important columns:**
- `pizza_id`
- `pizza_type_id`
- `size`
- `price`

### 4. `pizza_types`

Contains information about pizza names and categories.

**Important columns:**
- `pizza_type_id`
- `name`
- `category`
- `ingredients`

---

# 🔗 Dataset Relationships

The datasets are connected through the following relationships:

```text
orders
   │
   │ order_id
   ▼
order_details
   │
   │ pizza_id
   ▼
pizzas
   │
   │ pizza_type_id
   ▼
pizza_types
