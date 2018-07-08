#
# Join操作的类型 —— Inner Join
SELECT
  a.user_name,
  a.over,
  b.over
FROM user1 a
  INNER JOIN user2 b ON a.user_name = b.user_name;

# Join操作的类型 —— Left Outer Join
# 查询取经四人组中哪些人不是悟空的结拜兄弟？
SELECT
  a.user_name,
  a.over,
  b.over
FROM user1 a
  LEFT JOIN user2 b ON a.user_name = b.user_name
WHERE b.user_name IS NULL;

# Join操作的类型 —— Right Outer Join
# 查询悟空的结拜兄弟中哪些人没有去取经
SELECT
  b.user_name,
  b.over,
  a.over
FROM user1 a
  RIGHT JOIN user2 b ON a.user_name = b.user_name
WHERE a.user_name IS NULL;

# Join操作的类型 —— Full Outer Join
SELECT
  a.user_name,
  a.over,
  b.over
FROM user1 a
  LEFT JOIN user2 b ON a.user_name = b.user_name
UNION ALL
SELECT
  b.user_name,
  b.over,
  a.over
FROM user1 a RIGHT
  JOIN user2 b ON b.user_name = a.user_name;

# Join操作的类型 —— Cross Join
SELECT
  a.user_name,
  a.over,
  b.user_name,
  b.over
FROM user1 a
  CROSS JOIN user2 b;

# 使用 join 更新表

#  错误写法
UPDATE user1
SET over = '齐天大圣'
WHERE user1.user_name IN (SELECT b.user_name
                          FROM user1 a
                            JOIN user2 b ON a.user_name = b.user_name);
#  You can't specify target table 'user1' for update in FROM clause

# 使用 Join 来解决问题
UPDATE user1 a
  JOIN (SELECT b.user_name
        FROM user1 a
          JOIN user2 b ON a.user_name = b.user_name)
       b ON a.user_name = b.user_name
SET a.over = '齐天大圣';

# 使用 join 优化子查询
SELECT
  a.user_name,
  a.over,
  (SELECT over
   FROM user2 b
   WHERE a.user_name = b.user_name)
    AS over2
FROM user1 a;

# 优化后
SELECT
  a.user_name,
  a.over,
  b.over
FROM user1 a
  LEFT JOIN user2 b
    ON a.user_name = b.user_name;

# 使用JOIN优化聚合子查询
#如何查询出四人组中打怪最多的日期
SELECT
  a.user_name,
  b.timestr,
  b.kills
FROM user1 a
  JOIN user_kills b
    ON a.id = b.user_id
WHERE b.kills = (SELECT max(c.kills)
                 FROM user_kills c
                 WHERE c.user_id = b.user_id);

# 优化后
SELECT
  a.user_name,
  b.timestr,
  b.kills
FROM user1 a
  JOIN user_kills b ON a.id = b.user_id
  JOIN user_kills c ON b.user_id = c.user_id
GROUP BY a.id, b.timestr, b.kills
HAVING b.kills = max(c.kills);

