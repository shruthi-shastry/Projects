# 📈 Stock Volatility Prediction – Machine Learning Project

This project applies supervised machine learning techniques to predict **monthly stock price volatility** using a rich set of financial and trading features.

The project simulates the responsibilities of a **quantitative analyst**, covering EDA, feature engineering, model development, and statistical reasoning on a real-world financial dataset.

---

## 📋 Objective

- Predict monthly volatility (standard deviation of daily returns × 100) for over 600 publicly listed stocks
- Use historical trading and financial statement data (22 months) to forecast volatility in month 23
- Evaluate models based on **Root Mean Squared Error (RMSE)**

---

## 📊 Dataset Overview

**Training Data:**
- 13,486 labeled records across 613 stocks (22 months each)
- Features include:
  - Price data: Open, Close, High, Low, Volume, Amount, Return, Avg Price
  - Financials: Revenue, EPS, Assets, Liabilities, Equity, Cash Flow (quarterly and cumulative)

**Prediction Data:**
- 613 unlabeled records for month 23 (submission)
- Optional Kaggle challenge for month 24 (not assessed)

---

## 🧠 Methodology

### 📌 1. Data Preprocessing
- Normalization and log-transform for skewed features (Volume, Revenue)
- Time-based feature extraction (Month, Quarter, Year)
- Encoding of stock IDs using One-Hot Encoding

### 📌 2. Feature Engineering
- Rolling means and lagged volatility
- Cyclical features for seasonality (e.g., sine/cosine of month)
- Derived ratios: Equity-to-Asset, Return on Assets, EPS growth

### 📌 3. Model Development
We compared and tuned 3+ regression models:
- 📐 **Linear Regression**
- 🌳 **Random Forest Regressor**
- 🔺 **Gradient Boosted Trees (XGBoost)**

**Best Model:** Random Forest (lowest RMSE on hold-out set)

### 📌 4. Evaluation
- Used cross-validation and hold-out set (Month 22) for tuning
- Analyzed **feature importance scores** to identify top predictors of volatility

---

## 🔍 Key Insights

- **Volume**, **return**, and **past volatility** are strong predictors
- Combining financial and trading features improves prediction accuracy
- Data leakage avoided by respecting temporal relationships in features

---

## 🧰 Technologies Used

- Python 3.10
- Pandas, NumPy
- scikit-learn, XGBoost
- Matplotlib, Seaborn
- Jupyter Notebook

---
Predict Volatility of Stock

You are provided with monthly and quaterly  historical stock data. The task is to predict the volatility of a stock in November 2023 when given historical data from January 2022 to October 2023 for 613 stocks.

Programming environment  Python 3.9.12;

Versions of packages used : 

- Numpy version: 1.26.4
- Pandas version: 2.1.4
- Seaborn version: 0.13.1
- Scikit-learn version: 1.3.2
- MLXtend version: 0.23.1
- SciPy version: 1.13.1
- Statsmodels version: 0.14.2

Steps to Run Final Model : The ipynb file is divided into the following sections 

1.Data Pre Processing 
2.Exploratory Data Analysis 
3.Feature Engineering
4.Data Transformation 
5.Feature Selection
6.Lagged Feature 
7.Model Tuning 
8.Model Training 

In order to train model and generate predictions you can run the sections from Step 1 to Step 6 and then run the code under Step 8.

Model Tuning involves Hyper-parameter tuning with Cross Validation and can take sometime to run , to avoid a long wait time you skip the code block under this step 7 only.

All other code blocks have to run in order to generate predictions accurately.


