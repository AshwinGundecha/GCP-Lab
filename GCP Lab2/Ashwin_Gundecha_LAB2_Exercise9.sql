select 
repo_name,
diff.old_path AS file,
committer.date AS date,
LAG(commit,1,"No Commit") OVER(PARTITION BY repo_name ORDER BY committer.date) AS Previous_commit,
commit,
LEAD(commit,1,"No Commit") OVER(PARTITION BY repo_name ORDER BY committer.date) AS Next_commit
FROM `bigquery-public-data.github_repos.sample_commits`,
UNNEST(difference) AS diff
WHERE diff.new_path LIKE 'kernel/acct%.c'