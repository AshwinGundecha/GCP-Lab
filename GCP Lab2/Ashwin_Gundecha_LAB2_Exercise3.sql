SELECT 
PARSE_DATE("%Y%m%d",date) as date,
hit.page.pagePath as pagePath,
count(hit.page.pagePath) as counter
 FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
unnest(hits) as hit
group by date,pagePath
order by date,counter desc