create or replace table yelp_businesses (business_text variant); -- raw staging table for business JSON data

COPY INTO yelp_businesses
FROM 's3://yelodata-bucket-pythin-project/yelp_academic_dataset_business.json' -- S3 path for business dataset
CREDENTIALS = (
    AWS_KEY_ID = 'enter your key id here' -- AWS access key
    AWS_SECRET_KEY = 'enter your seceret key here' -- AWS secret key
)
FILE_FORMAT = (TYPE = JSON); -- JSON file format

select * from yelp_businesses limit 100; -- validate raw business data load

create or replace table tbl_yelp_businesses as  -- create structured business table
select 
    business_text:business_id::string as business_id, -- extract business id
    business_text:name::string as name, -- extract business name
    business_text:city::string as city, -- extract city
    business_text:state::string as state, -- extract state
    business_text:review_count::string as review_count, -- extract review count
    business_text:stars::number as stars, -- extract business rating
    business_text:categories::string as categories -- extract business categories
from yelp_businesses
limit 100; -- sample limit (can be removed for full load)

select * from tbl_yelp_businesses; -- preview transformed business data
