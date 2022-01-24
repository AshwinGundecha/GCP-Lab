with row as(
SELECT 
geoNetwork.country as country,
device.operatingSystem as os,
device.browser as browser,
ROW_NUMBER() over (PARTITION BY geoNetwork.country
                   order by (count(device.browser)+count(device.operatingSystem))) as rank
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`
where device.isMobile=true 
and not geoNetwork.country='(not set)'
and not device.operatingSystem='(not set)'
and not device.browser='(not set)'
group by country,os,browser
)
select country,
ARRAY_AGG(struct (os,browser,rank)) as country_rank
from row 
where rank<=3
group by country 
order by country 