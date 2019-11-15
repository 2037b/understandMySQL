DROP DATABASE day4_homework;
CREATE DATABASE day4_homework;
USE day4_homework;

CREATE TABLE stu
(
    s_id   INT PRIMARY KEY,
    s_name VARCHAR(20),
    addr   VARCHAR(50),
    tel    VARCHAR(50)
);
INSERT INTO stu
VALUES (1, 'XiaoWang', 'Henan', '0371-12345678'),
       (2, 'XiaoLi', 'Hebei', '13889072345'),
       (3, 'XiaoTian', 'Henan', '0371-12345670');

CREATE TABLE sch
(
    sch_id   INT PRIMARY KEY,
    sch_name VARCHAR(20)
);
INSERT INTO sch
VALUES (1, '清华大学'),
       (2, '北京大学');


CREATE TABLE stu_mark
(
    mark_id INT PRIMARY KEY,
    s_id    INT,
    sch_id  INT
);
INSERT INTO stu_mark
VALUES (1, 1, 1),
       (2, 2, 2),
       (3, 3, 2);
DROP TABLE IF EXISTS user_log;
CREATE TABLE user_log
(
    log_id     INT AUTO_INCREMENT PRIMARY KEY,
    user_id    INT,
    last_login DATE
);

INSERT INTO user_log (user_id, last_login)
VALUES (1, DATE_SUB(CURDATE(), INTERVAL 1 DAY)),
       (2, DATE_SUB(CURDATE(), INTERVAL 20 DAY)),
       (3, DATE_SUB(CURDATE(), INTERVAL 40 DAY)),
       (1, DATE_SUB(CURDATE(), INTERVAL 15 DAY)),
       (2, DATE_SUB(CURDATE(), INTERVAL 13 DAY)),
       (3, DATE_SUB(CURDATE(), INTERVAL 1 MONTH));

-- 创建考上北京大学的学生的视图
CREATE VIEW v_Peking AS
SELECT stu.s_name,stu.s_id
FROM stu
         INNER JOIN stu_mark ON stu.s_id = stu_mark.s_id
         INNER JOIN sch ON sch.sch_id = stu_mark.sch_id
WHERE sch_name = '北京大学';
-- 将创建的视图更改为考上清华的学生的视图
DROP view IF EXISTS day4_homework.v_Peking;
CREATE VIEW v_Qsinghua AS
SELECT stu.s_name,stu.s_id
FROM stu
         INNER JOIN stu_mark ON stu.s_id = stu_mark.s_id
         INNER JOIN sch ON sch.sch_id = stu_mark.sch_id
WHERE sch_name = '清华大学';
-- 删除创建的视图。
drop view v_Qsinghua;
--  创建一个存储过程用来统计表sch中的记录数,将记录数作为out输出到传入变量
CREATE
    DEFINER = root@localhost PROCEDURE count_sch(OUT count INT)
BEGIN
    select count(*) into count from sch;
END;
--  创建存储过程，实现 查询stu表中所有的s_id大于传入值的数据
CREATE
    DEFINER = root@localhost PROCEDURE Bigger(IN num INT)
BEGIN
    SELECT * FROM stu WHERE stu.s_id > num;
END;
--  创建一个存储过程，通过调用存储函数的方法来获取表sch表中sch_id的和，作为out输出到传入变量
CREATE
    DEFINER = root@localhost PROCEDURE sum_sch_id(OUT sum_of_id INT)
BEGIN
    SELECT count(sch_id) INTO sum_of_id FROM sch;
END;
--  创建存储过程，用于清理user_log，存储过程接收两个参数，
--  userId 和 dayNum,根据传入的清理天数清理dayNum这些天之前的所有数据，
--  如果userId不为null，则清理时userId指定的数据不能被清理掉，如果为null则仅需要根据dayNum进行清理


