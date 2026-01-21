/* =========================================================
   YELP DATA ANALYSIS USING SNOWFLAKE SQL
   ---------------------------------------------------------
   This script answers key business and analytical questions
   using Yelp reviews and business data.
   ========================================================= */


/* =========================================================
   1. Find the number of businesses in each category
   ========================================================= */

-- CTE to split comma-separated categories into individual rows
WITH cte AS (
    SELECT 
        business_id,                               -- Unique business identifier
        TRIM(A.value) AS category                 -- Cleaned individual category
    FROM tbl_yelp_businesses,
         LATERAL SPLIT_TO_TABLE(categories, ',') A
)

-- Count number of businesses per category
SELECT 
    category,
    COUNT(*) AS no_of_business                   -- Total businesses in each category
FROM cte
GROUP BY category
ORDER BY no_of_business DESC;



/* =========================================================
   2. Find the top 10 users who have reviewed the most
      businesses in the "Restaurants" category
   ========================================================= */

-- Count distinct businesses reviewed by each user
SELECT 
    r.user_id,                                   -- User identifier
    COUNT(DISTINCT r.business_id) AS business_count
FROM tbl_yelp_reviews r
INNER JOIN tbl_yelp_businesses b 
    ON r.business_id = b.business_id
WHERE b.categories ILIKE '%restaurants%'         -- Filter only restaurant businesses
GROUP BY r.user_id
ORDER BY business_count DESC
LIMIT 10;



/* =========================================================
   3. Find the most popular business categories
      (based on number of reviews)
   ========================================================= */

-- CTE to explode categories into individual rows
WITH cte AS (
    SELECT 
        business_id,
        TRIM(A.value) AS category
    FROM tbl_yelp_businesses,
         LATERAL SPLIT_TO_TABLE(categories, ',') A
)

-- Count reviews per category
SELECT 
    category,
    COUNT(*) AS no_of_reviews                    -- Total reviews per category
FROM cte
INNER JOIN tbl_yelp_reviews r
    ON cte.business_id = r.business_id
GROUP BY category
ORDER BY no_of_reviews DESC;



/* =========================================================
   4. Find the top 3 most recent reviews for each business
   ========================================================= */

-- Assign ranking to reviews based on recency per business
WITH cte AS (
    SELECT 
        r.*,                                      -- All review columns
        b.name,                                  -- Business name
        ROW_NUMBER() OVER (
            PARTITION BY r.business_id 
            ORDER BY review_date DESC
        ) AS rn                                  -- Rank reviews by date
    FROM tbl_yelp_reviews r
    INNER JOIN tbl_yelp_businesses b
        ON r.business_id = b.business_id
)

-- Select only the top 3 recent reviews per business
SELECT *
FROM cte
WHERE rn <= 3;



/* =========================================================
   5. Find the month with the highest number of reviews
   ========================================================= */

-- Aggregate reviews by month
SELECT 
    MONTH(review_date) AS review_month,          -- Extract month from review date
    COUNT(*) AS no_of_reviews                    -- Total reviews per month
FROM tbl_yelp_reviews
GROUP BY review_month
ORDER BY no_of_reviews DESC;



/* =========================================================
   6. Find the percentage of 5-star reviews for each business
   ========================================================= */

SELECT 
    b.business_id,                               -- Business identifier
    b.name,                                      -- Business name
    COUNT(*) AS total_reviews,                   -- Total reviews
    SUM(CASE 
        WHEN r.review_stars = 5 THEN 1 
        ELSE 0 
    END) AS star5_reviews,                       -- Count of 5-star reviews
    (SUM(CASE 
        WHEN r.review_stars = 5 THEN 1 
        ELSE 0 
    END) * 100.0 / COUNT(*)) AS percent_5_star   -- Percentage of 5-star reviews
FROM tbl_yelp_reviews r
INNER JOIN tbl_yelp_businesses b
    ON r.business_id = b.business_id
GROUP BY b.business_id, b.name;



/* =========================================================
   7. Find the top 5 most reviewed businesses in each city
   ========================================================= */

-- Aggregate total reviews per business per city
WITH cte AS (
    SELECT 
        b.city,                                  -- City name
        b.business_id,
        b.name,
        COUNT(*) AS total_reviews                -- Total reviews per business
    FROM tbl_yelp_reviews r
    INNER JOIN tbl_yelp_businesses b
        ON r.business_id = b.business_id
    GROUP BY b.city, b.business_id, b.name
)

-- Rank businesses within each city by number of reviews
SELECT *
FROM cte
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY city 
    ORDER BY total_reviews DESC
) <= 5;



/* =========================================================
   8. Find the average rating of businesses
      that have at least 100 reviews
   ========================================================= */

SELECT 
    b.business_id,
    b.name,
    COUNT(*) AS total_reviews,                   -- Total number of reviews
    AVG(r.review_stars) AS avg_rating            -- Average rating
FROM tbl_yelp_reviews r
INNER JOIN tbl_yelp_businesses b
    ON r.business_id = b.business_id
GROUP BY b.business_id, b.name
HAVING COUNT(*) >= 100;                          -- Only businesses with 100+ reviews



/* =========================================================
   9. List the top 10 users who have written the most reviews,
      along with the businesses they reviewed
   ========================================================= */

-- Identify top 10 users by review count
WITH cte AS (
    SELECT 
        r.user_id,
        COUNT(*) AS total_reviews
    FROM tbl_yelp_reviews r
    GROUP BY r.user_id
    ORDER BY total_reviews DESC
    LIMIT 10
)

-- List businesses reviewed by these top users
SELECT 
    r.user_id,
    r.business_id
FROM tbl_yelp_reviews r
WHERE r.user_id IN (SELECT user_id FROM cte)
GROUP BY r.user_id, r.business_id
ORDER BY r.user_id;



/* =========================================================
   10. Find top 10 businesses with the highest
       number of positive sentiment reviews
   ========================================================= */

SELECT 
    r.business_id,
    b.name,
    COUNT(*) AS total_reviews                    -- Count of positive reviews
FROM tbl_yelp_reviews r
INNER JOIN tbl_yelp_businesses b
    ON r.business_id = b.business_id
WHERE sentiments = 'Positive'                    -- Filter positive sentiment
GROUP BY r.business_id, b.name
ORDER BY total_reviews DESC
LIMIT 10;
