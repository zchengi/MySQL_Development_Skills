-- 注意自己是否需要建库
-- create database if not exists mysqldv1;

-- 新建 user1 表
create table if not exists user1 (
  id smallint unsigned primary key auto_increment,
  user_name varchar(40),
  over varchar(40)
);
-- 新建 user2 表
create table if not exists user2 (
  id smallint unsigned primary key auto_increment,
  user_name varchar(40),
  over varchar(40)
);
-- 新建 user_kills 表
create table if not exists user_kills (
  id smallint unsigned primary key auto_increment,
  user_id smallint unsigned,
  timestr timestamp default CURRENT_TIMESTAMP,
  kills smallint unsigned
);
-- 插入 user1 表数据
insert into user1(user_name,over) values ('唐僧', '旃檀功德佛');
insert into user1(user_name,over) values ('猪八戒', '净坛使者');
insert into user1(user_name,over) values ('孙悟空', '斗战胜佛');
insert into user1(user_name,over) values ('沙僧', '金身罗汉');
-- 插入 user2 表数据
insert into user2(user_name,over) values ('孙悟空', '成佛');
insert into user2(user_name,over) values ('牛魔王', '被降服');
insert into user2(user_name,over) values ('蛟魔王', '被降服');
insert into user2(user_name,over) values ('鹏魔王', '被降服');
insert into user2(user_name,over) values ('狮驼王', '被降服');
-- 插入 user_kills 表数据
insert into user_kills(user_id, timestr, kills) values (2, timestamp('2013-01-10'), 10);
insert into user_kills(user_id, timestr, kills) values (2, timestamp('2013-02-01'), 2);
insert into user_kills(user_id, timestr, kills) values (2, timestamp('2013-02-05'), 12);
insert into user_kills(user_id, timestr, kills) values (4, timestamp('2013-01-10'), 3);
insert into user_kills(user_id, timestr, kills) values (4, timestamp('2013-02-11'), 5);
insert into user_kills(user_id, timestr, kills) values (2, timestamp('2013-02-06'), 1);
insert into user_kills(user_id, timestr, kills) values (3, timestamp('2013-01-11'), 20);
insert into user_kills(user_id, timestr, kills) values (2, timestamp('2013-02-12'), 10);
insert into user_kills(user_id, timestr, kills) values (3, timestamp('2013-02-07'), 17);