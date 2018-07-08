SELECT user_name
FROM user1
WHERE id IN (SELECT user_id
             FROM user_kills);

SELECT *
FROM user_kills;

# 子查询去重 DISTINCT
SELECT DISTINCT a.user_name
FROM user1 a
  JOIN user_kills b ON a.id = b.user_id;

# 多列过滤的使用场景
# 查询出每一个取经人打怪最多的日期，并列出取经人的姓名，打怪最多的日期和打怪的数量
SELECT
  user_id,
  max(kills) AS cnt
FROM user_kills
GROUP BY user_id;

# 普通方法
SELECT
  a.user_name,
  b.timestr,
  kills
FROM user1 a
  JOIN user_kills b ON a.id = b.user_id
  JOIN (SELECT
          user_id,
          max(kills) AS cnt
        FROM user_kills
        GROUP BY user_id) c ON b.user_id = c.user_id AND b.kills = c.cnt;

# 多列过滤
SELECT
  a.user_name,
  b.timestr,
  kills
FROM user1 a
  JOIN user_kills b ON a.id = b.user_id
WHERE (b.user_id, b.kills) IN (SELECT
                                 user_id,
                                 max(kills)
                               FROM user_kills
                               GROUP BY user_id);
