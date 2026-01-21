# Data Analytics Project using Python, Snowflake, and SQL

<img width="1144" height="405" alt="image" src="https://github.com/user-attachments/assets/58375041-0a53-40d7-b501-02bdaf0ca4fc" />

## 📌 Project Description
This is an **end-to-end data analytics project** built using **Python, Amazon S3, Snowflake, and SQL** on the **Yelp Open Dataset**.

The primary objective of this project is to design and implement a **real-world data analytics pipeline** and answer key **business and analytical questions** using large-scale review data.  
All data ingestion, transformation, sentiment analysis, and analytics were performed to derive insights that answer the questions listed below.

---

## 🎯 Business Questions Answered
This project was designed specifically to answer the following analytical questions:

1. Find the number of businesses in each category.
2. Find the top 10 users who have reviewed the most businesses in the **Restaurants** category.
3. Find the most popular business categories based on the number of reviews.
4. Find the top 3 most recent reviews for each business.
5. Find the month with the highest number of reviews.
6. Find the percentage of 5-star reviews for each business.
7. Find the top 5 most reviewed businesses in each city.
8. Find the average rating of businesses that have received at least 100 reviews.
9. List the top 10 users who have written the most reviews along with the businesses they reviewed.
10. Find the top 10 businesses with the highest number of **positive sentiment** reviews.

All data processing and analysis steps were implemented to answer these questions efficiently using SQL on Snowflake.

---

## 🏗️ Architecture & Data Flow
1. Raw Yelp JSON datasets are processed using **Python**
2. Processed data is uploaded to **Amazon S3**
3. Data is loaded from S3 into **Snowflake**
4. Semi-structured JSON data is flattened and transformed into relational tables
5. **Sentiment Analysis** is performed using a Snowflake UDF
6. Analytical queries are written in **SQL** to extract insights

---

## 📂 Dataset Used
- **Yelp Reviews Dataset** (~5GB, ~7 million records)
- **Yelp Businesses Dataset** (~100MB)

Format: JSON  
Source: Yelp Open Dataset

---

## 🛠️ Technologies Used
- **Python** – Data preprocessing and ingestion
- **Amazon S3** – Cloud storage for raw and processed data
- **Snowflake** – Cloud data warehouse
- **SQL** – Data transformation and analytics
- **Snowflake UDF** – Sentiment analysis
- **Git & GitHub** – Version control and project hosting

---

## 📊 Key Analysis & Features
- Category-level business analysis
- User activity and engagement analysis
- Review trend analysis over time
- City-wise business popularity
- Rating-based business evaluation
- Sentiment-based review analysis
- Use of CTEs, window functions, aggregations, and filtering
- Optimized analytical SQL queries on large datasets

---

## 🚀 Key Learnings
- Designing cloud-based data pipelines
- Handling and flattening semi-structured JSON data
- Loading large datasets into Snowflake
- Writing optimized SQL for analytics
- Applying sentiment analysis within a data warehouse
- Translating business questions into analytical queries

---

## 📌 Conclusion
This project demonstrates a **modern data analytics workflow**, starting from raw data ingestion to actionable insights using cloud-native tools.  

