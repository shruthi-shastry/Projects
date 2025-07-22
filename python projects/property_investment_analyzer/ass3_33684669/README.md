# 🏘️ Property Investment Analyzer – Python (FIT9136 Assignment 3)

This project is a data analysis and visualization tool developed for a fictional property investment company in Melbourne, Australia.
Built as part of **FIT9136: Algorithms and Programming Foundations**, it showcases data manipulation, statistical analysis, and interactive plotting using Python libraries.

---

## 🎯 Assignment Objectives

- Investigate useful Python packages for scientific computing and data analysis  
-  Experiment with data manipulation, analysis, and visualisation techniques to formulate business insight

---

## 🧾 Project Context

As a developer at a growing real estate consultancy, your task is to automate administrative and analytical functions for property data using Python. The application provides suburb-wise insights, pricing trends, and visual dashboards to help overseas clients make informed investment decisions in Melbourne.

---

## 🛠 Key Functionalities

- 📥 `extract_property_info(file_path)`  
  Load property data from a CSV and return it as a Pandas DataFrame

- 💱 `currency_exchange(dataframe, exchange_rate)`  
  Convert property prices from AUD to the selected currency using NumPy

- 🏘️ `suburb_summary(dataframe, suburb)`  
  Print descriptive statistics (mean, std, median, min, max) for bedrooms, bathrooms, parking

- 📏 `avg_land_size(dataframe, suburb)`  
  Calculate average land size for a suburb, handling mixed units and missing values

- 📊 `prop_val_distribution(dataframe, suburb, target_currency='AUD')`  
  Generate and save a histogram of property values by suburb in selected currency

- 📈 `sales_trend(dataframe)`  
  Plot and save a line chart showing yearly property sales trends

- 🔍 `locate_price(target_price, data, target_suburb)`  
  Check if a given price exists in a suburb using reverse insertion sort and recursive binary search

---

## 🧰 Technologies Used

- Python 3.10
- Pandas
- NumPy
- Matplotlib
- Object-Oriented Programming
- CLI text-based interface

---


## 🚀 How to Run

1. Open the project in PyCharm or any Python IDE  
2. Run `main.py` from the root folder  
3. Follow the on-screen menu to:
   - Load a dataset
   - Select suburb
   - Generate charts
   - Convert currencies
   - Check price match

---

## 📊 Learning Outcomes Demonstrated

- File I/O and structured data handling
- Exception handling and validation
- Modular OOP structure (Single Responsibility Principle)
- Data visualization for business insights
- Clean code following PEP8

---




