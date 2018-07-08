# 新建表
CREATE TABLE user1_skills (
  user_id     INTEGER(2) UNSIGNED,
  user_name   VARCHAR(50),
  skill       VARCHAR(50),
  skill_level INTEGER(2)
);
INSERT INTO user1_skills VALUES
  (1, '唐僧', '念经', 5), (2, '猪八戒', '变化', 4), (3, '孙悟空', '变化', 5),
  (3, '孙悟空', '念经', 2), (4, '沙僧', '变化', 2), (4, '沙僧', '念经', 1);


SELECT
  a.user_name,
  b.skill,
  b.skill_level
FROM user1 a
  JOIN user1_skills b ON a.id = b.user_id
  JOIN user1_skills c ON c.user_id = b.user_id AND c.skill = '变化'
WHERE b.skill_level > 0 AND c.skill_level > 0