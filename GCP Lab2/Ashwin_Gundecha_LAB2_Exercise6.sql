SELECT users.id as userid,
count(ans.owner_user_id) as count
FROM `bigquery-public-data.stackoverflow.users` as users
inner join `bigquery-public-data.stackoverflow.posts_answers` as ans
on users.id=ans.owner_user_id
inner join `bigquery-public-data.stackoverflow.stackoverflow_posts` as posts
on posts.accepted_answer_id=ans.id
where posts.accepted_answer_id is not null and extract(YEAR FROM posts.creation_date)=2010
group by userid
order by count desc
