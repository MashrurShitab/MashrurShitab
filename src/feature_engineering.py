"""Simple optional feature engineering helpers.

The notebooks show these steps directly. This file keeps small helper versions
for reference only.
"""

import numpy as np
import pandas as pd


def add_profit_margin(df):
    df = df.copy()
    df["profit_margin"] = (df["value_sales"] - df["value_cost"]) / df["value_sales"]
    df["profit_margin"] = df["profit_margin"].replace([np.inf, -np.inf], np.nan)
    return df


def create_customer_features(df):
    customer_features = df.groupby("customer_code").agg(
        last_purchase_date=("invoice_date", "max"),
        total_spent=("value_sales", "sum"),
        total_profit=("profit", "sum"),
        order_count=("invoice_date", "count"),
        customer_district_code=("customer_district_code", "first"),
        value_sales=("value_sales", "sum"),
        value_quantity=("value_quantity", "sum"),
        profit_margin=("profit_margin", "mean"),
        time_gap=("time_gap", "mean"),
    ).reset_index()

    most_recent_date = df["invoice_date"].max()
    customer_features["recency"] = (
        most_recent_date - customer_features["last_purchase_date"]
    ).dt.days
    customer_features["spending_score"] = (
        customer_features["total_spent"] * 0.7
        + customer_features["total_profit"] * 0.3
    )
    customer_features["order_frequency"] = customer_features["order_count"] / (
        (customer_features["recency"] / 30).replace(0, np.nan)
    )

    return customer_features


def add_churn_label(customer_features, months_inactive=3):
    customer_features = customer_features.copy()
    most_recent_date = customer_features["last_purchase_date"].max()
    cutoff_date = most_recent_date - pd.DateOffset(months=months_inactive)
    customer_features["churned"] = (
        customer_features["last_purchase_date"] < cutoff_date
    ).astype(int)
    return customer_features
