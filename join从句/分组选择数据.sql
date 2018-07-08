SELECT
  a.user_name,
  b.timestr,
  b.kills
FROM user1 a
  JOIN user_kills b
    ON a.id = b.user_id
# WHERE user_name = '孙悟空'
WHERE user_name = '猪八戒'
# WHERE user_name = '沙僧'
ORDER BY b.kills DESC
LIMIT 2;

# 优化
SELECT
  d.user_name,
  c.timestr,
  kills
FROM (SELECT
        user_id,
        timestr,
        kills,
        (SELECT count(*)
         FROM user_kills b
         WHERE b.user_id = a.user_id AND a.kills <= b.kills) AS cnt
      FROM user_kills a
      GROUP BY user_id, timestr, kills) c
  JOIN user1 d ON c.user_id = d.id
WHERE cnt <= 2;

