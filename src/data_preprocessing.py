"""Simple optional data-cleaning helper functions.

The main analysis is written directly in the notebooks. These functions are
kept only as small examples of reusable code.
"""

import pandas as pd


def load_csv(file_path):
    return pd.read_csv(file_path, encoding="ISO-8859-1", engine="python")


def convert_dates(df):
    df = df.copy()
    for col in ["accounting_date", "invoice_date", "order_date"]:
        if col in df.columns:
            df[col] = pd.to_datetime(df[col].astype(str), format="%Y%m%d", errors="coerce")
    return df


def add_profit(df):
    df = df.copy()
    df["profit"] = df["value_sales"] - df["value_cost"]
    return df


def add_time_gap(df):
    df = df.copy()
    df["time_gap"] = (df["invoice_date"] - df["order_date"]).dt.days
    return df
