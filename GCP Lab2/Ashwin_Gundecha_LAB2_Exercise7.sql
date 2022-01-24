SELECT
lang.name AS Language_name,
COUNT(lang.name) AS Counter
FROM `bigquery-public-data.github_repos.languages`,
UNNEST(LANGUAGE) AS lang
GROUP BY Language_name
ORDER BY Counter DESC
limit 1
