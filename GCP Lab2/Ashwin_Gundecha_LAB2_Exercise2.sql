SELECT distinct 
visitId,visitStartTime,hit.page.pageTitle,hit.page.pagePath FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`,
unnest(hits) as hit
where date="20170801"
limit 10 