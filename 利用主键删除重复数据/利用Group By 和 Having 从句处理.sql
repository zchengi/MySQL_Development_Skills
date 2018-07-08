CREATE TABLE user1_test (
  id        INT AUTO_INCREMENT NOT NULL,
  user_name VARCHAR(3),
  over      VARCHAR(5),
  mobile    VARCHAR(100),
  PRIMARY KEY (id)
);
DESC user1_test;

# 限制插入
INSERT INTO user1_test (user_name, over, mobile) SELECT
                                                   user_name,
                                                   over,
                                                   mobile
                                                 FROM user1
                                                 LIMIT 2;
SELECT *
FROM user1_test
ORDER BY user_name;

#  判断重复数据
SELECT
  user_name,
  over,
  count(*)
FROM user1_test
GROUP BY user_name, over
HAVING count(*) > 1;

# 删除重复数据，对于相同数据保留ID最大的
DELETE a FROM user1_test a
  JOIN (SELECT
          user_name,
          count(*),
          max(id) AS id
        FROM user1_test
        GROUP BY user_name, over
        HAVING count(*) > 1
       ) b ON a.user_name = b.user_name
WHERE a.id < b.id;

SELECT *
FROM user1_test;