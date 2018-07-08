# 添加列
ALTER TABLE user1
  ADD COLUMN mobile VARCHAR(100);

# 添加新数据
UPDATE user1
SET user1.mobile = '121123456,141123456,161123456'
WHERE id = 1;
UPDATE user1
SET user1.mobile = '12144643321,14144643321'
WHERE id = 2;
UPDATE user1
SET user1.mobile = '1216666666,1416666666,1616666666,1816666666'
WHERE id = 3;

# 查询所有数据
SELECT *
FROM user1;

# 创建新表
CREATE TABLE tb_sequence (
  id INT AUTO_INCREMENT NOT NULL,
  PRIMARY KEY (id)
);
# 添加数据
INSERT INTO tb_sequence VALUES (), (), (), (), (), (), (), (), ();
SELECT *
FROM tb_sequence;

# 1.利用序列表处理列转行的数据

SELECT
  user_name,
  concat(mobile, ',') AS                                mobile,
  length(mobile) - length(replace(mobile, ',', '')) + 1 size
FROM user1 b;

SELECT
  user_name,
  replace(substring(substring_index(mobile, ',', a.id),
                    char_length(substring_index(mobile, ',', a.id - 1)) + 1), ',', '') AS moble
FROM tb_sequence a CROSS JOIN (SELECT
                                 user_name,
                                 concat(mobile, ',') AS                                mobile,
                                 length(mobile) - length(replace(mobile, ',', '')) + 1 size
                               FROM user1 b) b
    ON a.id <= b.size;

# 新建装备表
CREATE TABLE user1_equipment (
  id       TINYINT UNSIGNED AUTO_INCREMENT NOT NULL,
  user_id  SMALLINT UNSIGNED,
  arms     VARCHAR(10) CHARACTER SET utf8 DEFAULT NULL,
  clothing VARCHAR(10) CHARACTER SET utf8 DEFAULT NULL,
  shoe     VARCHAR(10) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (id)
);

# 添加装备数据
INSERT INTO user1_equipment VALUES (NULL, 3, '金箍棒', '梭子黄金甲', '藕丝步云履'),
  (NULL, 2, '九齿钉耙', '僧衣', '僧鞋'),
  (NULL, 4, '降妖宝仗', '僧衣', '僧鞋'),
  (NULL, 1, '九环锡杖', '锦斓袈裟', '僧鞋');

SELECT
  user_name,
  arms
FROM user1 a
  JOIN user1_equipment b ON a.id = b.user_id;
SELECT
  user_name,
  'shoe' AS equipment,
  shoe
FROM user1 a
  JOIN user1_equipment b ON a.id = b.user_id;

# 2.使用UNION方法
SELECT
  user_name,
  'arms' AS equipment,
  arms
FROM user1 a
  JOIN user1_equipment b ON a.id = b.user_id
UNION SELECT
        user_name,
        'clothing' AS equipment,
        clothing
      FROM user1 a
        JOIN user1_equipment b ON a.id = b.user_id
UNION SELECT
        user_name,
        'shoe' AS equipment,
        shoe
      FROM user1 a
        JOIN user1_equipment b ON a.id = b.user_id
ORDER BY user_name, equipment;

# 3.使用序列化表的方法

SELECT
  user_name,
  arms,
  clothing,
  shoe
FROM user1 a
  JOIN user1_equipment b
    ON a.id = b.user_id
  CROSS JOIN tb_sequence c
WHERE c.id <= 3
ORDER BY user_name;

SELECT
  user_name,
  CASE WHEN c.id = 1
    THEN 'arms'
  WHEN c.id = 2
    THEN 'clothing'
  WHEN c.id = 3
    THEN 'shoe'
  END                       AS equipment,
  coalesce(CASE WHEN c.id = 1
    THEN arms END,
           CASE WHEN c.id = 2
             THEN clothing END,
           CASE WHEN c.id = 3
             THEN shoe END) AS eq_name
FROM user1 a
  JOIN user1_equipment b
    ON a.id = b.user_id
  CROSS JOIN tb_sequence c
WHERE c.id <= 3
ORDER BY user_name,equipment;