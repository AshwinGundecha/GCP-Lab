SELECT users.id as userid,
count(ans.owner_user_id) as count
FROM `bigquery-public-data.stackoverflow.users` as users
inner join `bigquery-public-data.stackoverflow.posts_answers` as ans
on users.id=ans.owner_user_id
where extract(YEAR from ans.creation_date)=2010
group by userid
order by count desc
limit 10