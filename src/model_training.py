"""Simple optional modelling helpers.

The notebooks train and evaluate models directly. These helper functions are
kept as short examples only.
"""

import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.linear_model import LinearRegression
from sklearn.metrics import accuracy_score, mean_absolute_error, mean_squared_error


def train_linear_regression(X_train, y_train):
    model = LinearRegression()
    model.fit(X_train, y_train)
    return model


def print_regression_metrics(y_test, predictions):
    rmse = np.sqrt(mean_squared_error(y_test, predictions))
    mae = mean_absolute_error(y_test, predictions)
    print("RMSE:", rmse)
    print("MAE:", mae)


def train_random_forest(X_train, y_train):
    model = RandomForestClassifier(random_state=42)
    model.fit(X_train, y_train)
    return model


def print_accuracy(y_test, predictions):
    print("Accuracy Score:", accuracy_score(y_test, predictions))


def make_feature_importance_table(model, feature_columns):
    return pd.DataFrame({
        "Feature": feature_columns,
        "Importance": model.feature_importances_,
    }).sort_values(by="Importance", ascending=False)
