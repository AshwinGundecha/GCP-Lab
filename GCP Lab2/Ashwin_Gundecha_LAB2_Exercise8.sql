SELECT commits.committer.name as name,
count(L.name) as count
FROM `bigquery-public-data.github_repos.languages` as languages,
unnest(language) as L
inner join `bigquery-public-data.github_repos.sample_commits` as commits
on languages.repo_name=commits.repo_name
where L.name="Java" and extract(YEAR from commits.committer.date)=2016
group by name
order by count desc 
limit 10
  