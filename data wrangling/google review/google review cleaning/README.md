# 📝 Google Reviews Data Cleaning & Exploration – Python

This project involves parsing, cleaning, preprocessing, and exploring large-scale **Google Maps review data**.
It was developed as part of **FIT5196: Data Wrangling** coursework.

---

## 📋 Tasks Completed

### ✅ Task 1: Parsing Raw Files
- Extracted reviews and metadata from semi-structured `.txt` and `.xlsx` files
- Cleaned, transformed, and exported structured data into:
  - CSV summary (review counts, responses)
  - JSON review structure (text, ratings, time, images, responses)

### ✅ Task 2: Text Preprocessing
- Performed tokenization using custom regex
- Removed context-independent and dependent stopwords
- Applied Porter stemming, removed rare tokens and short words
- Generated:
  - `vocab.txt`: indexed list of unigrams + PMI-based bigrams
  - `countvec.txt`: sparse matrix representation of token frequencies

### ✅ Task 3: Exploratory Data Analysis (EDA)
- Explored patterns in review frequency, sentiment, and business response behavior
- Combined auxiliary metadata with reviews to derive insights

### ✅ Task 4: Video Presentation
- Summarized EDA insights in a clear and engaging presentation format (5–8 minutes)

### ✅ Task 5: Development History
- Documented progress over time, collaboration notes, and version changes

---

## 🛠 Technologies Used

- Python (Pandas, Regex, NLTK, Scikit-learn)
- JSON & CSV formatting
- Jupyter Notebook & Google Colab
- Visualizations: matplotlib, seaborn
- NLP: stemming, vocabulary construction, sparse matrix output

---

## 🧠 Skills Demonstrated

- Raw text extraction & regular expression parsing
- Text normalization and vocabulary engineering
- JSON structure generation
- NLP pipeline for real-world reviews
- Exploratory data storytelling

