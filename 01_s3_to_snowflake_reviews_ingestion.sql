create or replace table yelp_reviews (review_text variant); -- raw staging table to store JSON reviews

COPY INTO yelp_reviews
FROM 's3://yelodata-bucket-pythin-project/' -- source S3 bucket location
CREDENTIALS = (
    AWS_KEY_ID = 'use your id here ' -- AWS access key
    AWS_SECRET_KEY = 'use your key here' -- AWS secret key
)
FILE_FORMAT = (TYPE = JSON); -- JSON file format

select * from yelp_reviews limit 10; -- validate raw data load

create or replace table tbl_yelp_reviews as  -- create structured analytics table
select  
    review_text:business_id::string as business_id, -- extract business id
    review_text:date::date as review_date, -- extract review date
    review_text:user_id::string as user_id, -- extract user id
    review_text:stars::number as review_stars, -- extract star rating
    review_text:text::string as review_text, -- extract review text
    analyze_sentiment(review_text) as sentiments -- apply sentiment analysis
from yelp_reviews;

select count(*) from tbl_yelp_reviews; -- total number of processed reviews

select * from tbl_yelp_reviews limit 10; -- preview transformed review data
select * from tbl_yelp_businesses limit 10; -- preview business data

