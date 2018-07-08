# 行转列方法

# 汇总 kills (未转换数据)
SELECT
  a.user_name,
  sum(kills)
FROM user1 a
  JOIN user_kills b ON a.id = b.user_id
GROUP BY a.user_name;

# 行显示 转换为 列显示

# 方法1：使用 CROSS JOIN 方法
SELECT
  ab孙.孙悟空,
  ab沙.沙僧,
  ab猪.猪八戒
FROM (
    (SELECT sum(kills) AS '孙悟空'
     FROM user1 a
       JOIN user_kills b ON a.id = b.user_id AND user_name = '孙悟空') AS ab孙
    CROSS JOIN
    (SELECT sum(kills) AS '猪八戒'
     FROM user1 a
       JOIN user_kills b ON a.id = b.user_id AND user_name = '猪八戒') AS ab猪
    CROSS JOIN
    (SELECT sum(kills) AS '沙僧'
     FROM user1 a
       JOIN user_kills b ON a.id = b.user_id AND user_name = '沙僧') AS ab沙);

# 方法2：使用 CASE 方法

SELECT
  sum(CASE WHEN user_name = '孙悟空'
    THEN kills END) AS '孙悟空',
  sum(CASE WHEN user_name = '猪八戒'
    THEN kills END) AS '猪八戒',
  sum(CASE WHEN user_name = '沙僧'
    THEN kills END) AS '沙僧'
FROM user1 a
  JOIN user_kills b ON a.id = b.user_id;
