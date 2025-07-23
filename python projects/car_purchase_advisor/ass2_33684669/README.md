# 🚗 Car Purchase Advisor System – Python

This project implements a terminal-based **Car Purchase Advisor** using Python’s object-oriented programming principles.
Created as part of **Algorithms and Programming Foundations**, it simulates operations for car retailers, stock tracking, and order placement.

---

## 🎯 Assignment Objectives

-  Apply object-oriented design to modularize a computational program
-  Demonstrate file I/O handling (read/write from `.txt`)
-  Implement testing and exception handling best practices

---

## 📚 Project Overview

The application simulates a car purchasing workflow through a text interface. It includes functionality for:

- Managing **retailer and car inventory**
- Recommending vehicles based on license type
- Tracking **business hours**, stock availability, and orders
- Generating **test data**, maintaining `stock.txt` and `order.txt`

---

## 🛠 Features

- 📂 **Object-Oriented Design**:
  - `Car`, `Retailer`, `CarRetailer` (inherits from Retailer), `Order`
- 📋 **User Menu**:
  - Find nearest retailer by postcode
  - View stock by type/license
  - Get car recommendations
  - Place orders (time-based validation)
- 🧾 **Order & Stock Tracking**:
  - Unique order ID generation
  - Order and inventory persistence with text files
- 🧪 **Exception handling & validation**
  - Invalid input, out-of-hours orders, stock mismatch

---

## 🛠 Technologies Used

- Python 3.10
- PyCharm IDE
- Standard libraries: `os`, `random`, `time`, `string`, `re`
- Text-based storage: `stock.txt`, `order.txt`

---

## 📁 File Structure

- `main.py` – Main control logic, user menu
- `car.py` – Car class definition
- `retailer.py` – Retailer base class
- `car_retailer.py` – Inherits from Retailer; stock logic
- `order.py` – Order creation and ID generation
- `data/stock.txt` – Inventory file (auto-generated)
- `data/order.txt` – Order log
- `userManual_33684669.pdf` – Instructions for running the program
- `README.md` – This file

---

## 🚀 How to Run

1. Ensure you have Python 3.10 installed.
2. Open the project folder in PyCharm or any IDE.
3. Run `main.py`.
4. Follow the menu prompts in the terminal.

---

## 🧠 Learning Outcomes Demonstrated

- Class and inheritance design in Python
- File reading/writing, path handling
- Defensive programming with validation
- Simulating real-world system logic
- Adhering to PEP8 and modular programming

---

