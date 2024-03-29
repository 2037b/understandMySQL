CREATE DATABASE day3_homework;
USE day3_homework;

CREATE TABLE tb_dept
(
    id       INT(11) PRIMARY KEY,
    name     VARCHAR(22) NOT NULL,
    location VARCHAR(50)
);

CREATE TABLE tb_emp
(
    id     INT(11) PRIMARY KEY,
    name   VARCHAR(25),
    deptId INT(11),
    salary FLOAT
);

-- 修改tb_emp表，创建外键约束，使用tb_dept中的id作为外键，关联deptId。
ALTER TABLE tb_emp
    ADD FOREIGN KEY (id) REFERENCES tb_dept (id);

-- 使用SHOW CREATE TABLE查看表tb_emp的结构
SHOW CREATE TABLE tb_emp;

-- 建立名为tb_emp1的表，结构和tb_emp一样，直接在建表的时候声明外键关联tb_dept的id
CREATE TABLE tb_emp1
(
    id     INT(11) PRIMARY KEY,
    name   VARCHAR(25),
    deptId INT(11),
    salary FLOAT,
    FOREIGN KEY (id) REFERENCES tb_dept (id)
);

-- 建立名为tb_dept1的表，结构和tb_dept表结构一致，将tb_emp外键删除，关联到tb_dept1上
CREATE TABLE tb_dept1
(
    id       INT(11) PRIMARY KEY,
    name     VARCHAR(22) NOT NULL,
    location VARCHAR(50)
);
ALTER TABLE tb_emp
    DROP FOREIGN KEY tb_emp_ibfk_1;
ALTER TABLE tb_emp
    ADD FOREIGN KEY (id) REFERENCES tb_dept1 (id);

CREATE TABLE fruits
(
    f_id    CHAR(10)      NOT NULL,
    s_id    INT           NOT NULL,
    f_name  CHAR(255)     NOT NULL,
    f_price DECIMAL(8, 2) NOT NULL,
    PRIMARY KEY (f_id)
);

-- -------------------------

INSERT INTO fruits (f_id, s_id, f_name, f_price)
VALUES ('a1', 101, 'apple', 5.2),
       ('b1', 101, 'blackberry', 10.2),
       ('bs1', 102, 'orange', 11.2),
       ('bs2', 105, 'melon', 8.2),
       ('t1', 102, 'banana', 10.3),
       ('t2', 102, 'grape', 5.3),
       ('o2', 103, 'coconut', 9.2),
       ('c0', 101, 'cherry', 3.2),
       ('a2', 103, 'apricot', 2.2),
       ('l2', 104, 'lemon', 6.4),
       ('b2', 104, 'berry', 7.6),
       ('m1', 106, 'mango', 15.6),
       ('m2', 105, 'xbabay', 2.6),
       ('t4', 107, 'xbababa', 3.6),
       ('m3', 105, 'xxtt', 11.6),
       ('b5', 107, 'xxxx', 3.6);

CREATE TABLE customers
(
    c_id      INT       NOT NULL AUTO_INCREMENT,
    c_name    CHAR(50)  NOT NULL,
    c_address CHAR(50)  NULL,
    c_city    CHAR(50)  NULL,
    c_zip     CHAR(10)  NULL,
    c_contact CHAR(50)  NULL,
    c_email   CHAR(255) NULL,
    PRIMARY KEY (c_id)
);

INSERT INTO customers(c_id, c_name, c_address, c_city,
                      c_zip, c_contact, c_email)
VALUES (10001, 'RedHook', '200 Street ', 'Tianjin',
        '300000', 'LiMing', 'LMing@163.com'),
       (10002, 'Stars', '333 Fromage Lane',
        'Dalian', '116000', 'Zhangbo', 'Jerry@hotmail.com'),
       (10003, 'Netbhood', '1 Sunny Place', 'Qingdao', '266000',
        'LuoCong', NULL),
       (10004, 'JOTO', '829 Riverside Drive', 'Haikou',
        '570000', 'YangShan', 'sam@hotmail.com');
SELECT COUNT(*) AS cust_num
FROM customers;

CREATE TABLE orderitems
(
    o_num      INT           NOT NULL,
    o_item     INT           NOT NULL,
    f_id       CHAR(10)      NOT NULL,
    quantity   INT           NOT NULL,
    item_price DECIMAL(8, 2) NOT NULL,
    PRIMARY KEY (o_num, o_item)
);

INSERT INTO orderitems(o_num, o_item, f_id, quantity, item_price)
VALUES (30001, 1, 'a1', 10, 5.2),
       (30001, 2, 'b2', 3, 7.6),
       (30001, 3, 'bs1', 5, 11.2),
       (30001, 4, 'bs2', 15, 9.2),
       (30002, 1, 'b3', 2, 20.0),
       (30003, 1, 'c0', 100, 10),
       (30004, 1, 'o2', 50, 2.50),
       (30005, 1, 'c0', 5, 10),
       (30005, 2, 'b1', 10, 8.99),
       (30005, 3, 'a2', 10, 2.2),
       (30005, 4, 'm1', 5, 14.99);

CREATE TABLE suppliers
(
    s_id   INT      NOT NULL AUTO_INCREMENT,
    s_name CHAR(50) NOT NULL,
    s_city CHAR(50) NULL,
    s_zip  CHAR(10) NULL,
    s_call CHAR(50) NOT NULL,
    PRIMARY KEY (s_id)
);

INSERT INTO suppliers(s_id, s_name, s_city, s_zip, s_call)
VALUES (101, 'FastFruit Inc.', 'Tianjin', '300000', '48075'),
       (102, 'LT Supplies', 'Chongqing', '400000', '44333'),
       (103, 'ACME', 'Shanghai', '200000', '90046'),
       (104, 'FNK Inc.', 'Zhongshan', '528437', '11111'),
       (105, 'Good Set', 'Taiyuang', '030000', '22222'),
       (106, 'Just Eat Ours', 'Beijing', '010', '45678'),
       (107, 'DK Inc.', 'Zhengzhou', '450000', '33332');

CREATE TABLE orders
(
    o_num  INT      NOT NULL AUTO_INCREMENT,
    o_date DATETIME NOT NULL,
    c_id   INT      NOT NULL,
    PRIMARY KEY (o_num)
);
INSERT INTO orders(o_num, o_date, c_id)
VALUES (30001, '2008-09-01', 10001),
       (30002, '2008-09-12', 10003),
       (30003, '2008-09-30', 10004),
       (30004, '2008-10-03', 10005),
       (30005, '2008-10-08', 10001);

-- 查询供应f_id= ‘a1’的水果供应商提供的其他水果种类，内连接
SELECT f1.f_id,
-- 	f1.f_name,
       f2.f_name
FROM fruits f1,
     fruits f2
WHERE f1.f_id = 'a1'
  AND f1.s_id = f2.s_id;

SELECT f1.f_id,-- 	f1.f_name,
       f2.f_name
FROM fruits f1
         INNER JOIN fruits f2 ON f1.s_id = f2.s_id
WHERE f1.f_id = 'a1';

-- 在customers表和orders表中，查询所有客户，包括没有订单的客户，左连接
SELECT *
FROM customers
         LEFT JOIN orders o ON customers.c_id = o.c_id;

-- 在customers表和orders表中，查询所有订单，包括没有客户的订单，右连接
SELECT *
FROM customers
         RIGHT JOIN orders o ON customers.c_id = o.c_id;

-- 在customers表和orders表中，使用INNER JOIN语法查询customers表中ID为10001的客户的订单信息
SELECT o.*
FROM customers
         INNER JOIN orders o ON customers.c_id = o.c_id AND customers.c_id = 10001;

SELECT o.*
FROM customers
         INNER JOIN orders o ON customers.c_id = o.c_id
WHERE customers.c_id = 10001;

-- 查询fruits表所有信息附加一列suppliers的供应商名称，使用INNER JOIN语法进行内连接查询，并对查询结果排序
SELECT fruits.*, s_name
FROM fruits
         INNER JOIN suppliers s ON fruits.s_id = s.s_id
ORDER BY s.s_name;

-- 查询所有价格小于9的水果的信息，查询s_id等于101和103所有的水果的信息，使用UNION连接查询结果
SELECT *
FROM fruits
WHERE f_price < 9
UNION
SELECT *
FROM fruits
WHERE s_id IN (101, 103);

-- 查询所有价格小于9的水果的信息，查询s_id等于101和103的所有水果的信息，使用UNION ALL连接查询结果
SELECT *
FROM fruits
WHERE f_price < 9
UNION ALL
SELECT *
FROM fruits
WHERE s_id IN (101, 103);

-- 为orders表取别名o，查询30001订单的下单日期
SELECT o.o_date
FROM orders o
WHERE o_num = 30001;

-- 查询fruits表，为f_name取别名fruit_name，f_price取别名fruit_price，为fruits表取别名f1，查询表中f_price < 8的水果的名称
SELECT f1.f_name fruit_name, f1.f_price fruit_price
FROM fruits f1
WHERE f_price < 8;

-- 查询suppliers表中字段s_name和s_city，使用CONCAT函数连接这两个字段值，并取列别名为suppliers_title。
SELECT concat(suppliers.s_name, '_', suppliers.s_city) suppliers_title
FROM suppliers;

SELECT concat_ws('_', suppliers.s_name, suppliers.s_city) suppliers_title
FROM suppliers;

-- ---------------------------

CREATE TABLE student
(
    id         INT(10)     NOT NULL PRIMARY KEY,
    name       VARCHAR(20) NOT NULL,
    sex        VARCHAR(4),
    birth      YEAR,
    department VARCHAR(20),
    address    VARCHAR(50)
);

CREATE TABLE score
(
    id     INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    stu_id INT(10) NOT NULL,
    c_name VARCHAR(20),
    grade  INT(10)
);
INSERT INTO student
VALUES (901, '张老大', '男', 1985, '计算机系', '北京市海淀区');
INSERT INTO student
VALUES (902, '张老二', '男', 1986, '中文系', '北京市昌平区');
INSERT INTO student
VALUES (903, '张三', '女', 1990, '中文系', '湖南省永州市');
INSERT INTO student
VALUES (904, '李四', '男', 1990, '英语系', '辽宁省阜新市');
INSERT INTO student
VALUES (905, '王五', '女', 1991, '英语系', '福建省厦门市');
INSERT INTO student
VALUES (906, '王六', '男', 1988, '计算机系', '湖南省衡阳市');

INSERT INTO score
VALUES (NULL, 901, '计算机', 98);
INSERT INTO score
VALUES (NULL, 901, '英语', 80);
INSERT INTO score
VALUES (NULL, 902, '计算机', 65);
INSERT INTO score
VALUES (NULL, 902, '中文', 88);
INSERT INTO score
VALUES (NULL, 903, '中文', 95);
INSERT INTO score
VALUES (NULL, 904, '计算机', 70);
INSERT INTO score
VALUES (NULL, 904, '英语', 92);
INSERT INTO score
VALUES (NULL, 905, '英语', 94);
INSERT INTO score
VALUES (NULL, 906, '计算机', 90);
INSERT INTO score
VALUES (NULL, 906, '英语', 85);

-- 查询李四的考试科目（c_name）和考试成绩（grade）
SELECT name, grade, c_name
FROM score,
     student
WHERE stu_id = student.id
  AND name = '李四';

-- 查询所有学生的信息和考试信息
SELECT *
FROM score,
     student
WHERE student.id = stu_id;

SELECT s.*, sc.*
FROM score sc
         JOIN student s ON s.id = sc.stu_id;

-- 计算每个学生的总成绩
SELECT student.*, sum(score.grade)
FROM score
         INNER JOIN student ON stu_id = student.id
GROUP BY stu_id;

-- 计算每个考试科目的平均成绩
SELECT score.c_name, avg(grade)
FROM score
GROUP BY c_name;

-- 查询计算机成绩低于95的学生信息
SELECT student.*, c_name, grade
FROM student
         LEFT JOIN score ON student.id = stu_id AND score.c_name = '计算机' AND grade < 95;

SELECT s.*, c_name, grade
FROM student s
         LEFT JOIN score sc ON sc.stu_id = s.id
WHERE sc.c_name = '计算机'
  AND sc.grade < 95;

-- 查询同时参加计算机和英语考试的学生的信息
SELECT s.*, sc.c_name, scc.c_name
FROM student s
         INNER JOIN score sc ON sc.stu_id = s.id AND sc.c_name = '计算机'
         INNER JOIN score scc ON s.id = scc.stu_id AND scc.c_name = '英语';

-- 从student表和score表中查询出学生的学号，然后合并查询结果
SELECT id stu_id
FROM student
UNION
SELECT stu_id
FROM score;

-- 查询姓张或者姓王的同学的姓名、院系和考试科目及成绩
SELECT student.*, c_name, grade
FROM student
         INNER JOIN score ON stu_id = student.id
WHERE name LIKE ('张%')
   OR name LIKE ('王%');

-- 查询都是湖南的学生的姓名、年龄、院系和考试科目及成绩
SELECT student.*, c_name, grade
FROM student
         INNER JOIN score ON stu_id = student.id
WHERE address LIKE ('%湖南%');

SELECT s.name,
       2019 - s.birth age,
       s.department,
       sc.c_name,
       sc.grade # 求年龄的方法
FROM student s
         INNER JOIN score sc ON sc.stu_id = s.id
WHERE s.address LIKE '湖南%';

-- ------------------

DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept`
(
    `deptno` INT(2) NOT NULL,
    `dname`  VARCHAR(14) DEFAULT NULL,
    `loc`    VARCHAR(13) DEFAULT NULL,
    PRIMARY KEY (`deptno`)
);
INSERT INTO `dept`
VALUES (10, 'ACCOUNTING', 'NEW YORK'),
       (20, 'RESEARCH', 'DALLAS'),
       (30, 'SALES', 'CHICAGO'),
       (40, 'OPERATIONS', 'BOSTON'),
       (50, 'HR', 'SY'),
       (60, NULL, 'MARKET');

DROP TABLE IF EXISTS `emp`;
CREATE TABLE `emp`
(
    `empno`    INT(4) NOT NULL,
    `ename`    VARCHAR(20)  DEFAULT NULL,
    `job`      VARCHAR(9)   DEFAULT NULL,
    `mgr`      INT(4)       DEFAULT NULL,
    `hiredate` DATE         DEFAULT NULL,
    `sal`      DOUBLE(7, 2) DEFAULT NULL,
    `comm`     DOUBLE(7, 2) DEFAULT NULL,
    `deptno`   INT(2)       DEFAULT NULL,
    PRIMARY KEY (`empno`)
);

INSERT INTO `emp`
VALUES (7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800.00, NULL, 20),
       (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600.00, 300.00, 30),
       (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250.00, 500.00, 30),
       (7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975.00, NULL, 20),
       (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250.00, 1400.00, 30),
       (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850.00, NULL, 30),
       (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450.00, NULL, 10),
       (7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19', 3000.00, NULL, 20),
       (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000.00, NULL, 10),
       (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500.00, 0.00, 30),
       (7876, 'ADAMS', 'CLERK', 7788, '1987-05-23', 1100.00, NULL, 20),
       (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950.00, NULL, 30),
       (7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000.00, NULL, 20),
       (7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300.00, NULL, 10);

DROP TABLE IF EXISTS `salgrade`;
CREATE TABLE `salgrade`
(
    `grade` INT(11) DEFAULT NULL,
    `losal` INT(11) DEFAULT NULL,
    `hisal` INT(11) DEFAULT NULL
);
INSERT INTO `salgrade`
VALUES (1, 700, 1200),
       (2, 1201, 1400),
       (3, 1401, 2000),
       (4, 2001, 3000),
       (5, 3001, 9999);

-- 取得每个部门最高薪水的人员名称
SELECT e1.deptno, e1.ename, e1.sal
FROM emp e1
         INNER JOIN (SELECT deptno, max(sal) sal FROM emp GROUP BY deptno) e2
                    ON e2.sal = e1.sal AND e1.deptno = e2.deptno;

-- 哪些人的薪水在部门的平均薪水之上
SELECT e1.deptno, e1.ename, e1.sal, e2.avg
FROM emp e1
         INNER JOIN (SELECT deptno, avg(sal) avg FROM emp GROUP BY deptno) e2 ON e1.deptno = e2.deptno
WHERE e1.sal > e2.avg;

-- 取得部门中(所有人)平均薪水的等级
SELECT e1.deptno, salgrade.grade, avg
FROM (SELECT deptno, avg(emp.sal) avg FROM emp GROUP BY deptno) e1
         LEFT JOIN salgrade ON avg BETWEEN losal AND hisal;

-- 取得部门中(所有人)薪水的平均等级
SELECT deptno, avg(salgrade.grade)
FROM emp
         INNER JOIN salgrade ON emp.sal BETWEEN losal AND hisal
GROUP BY deptno;

-- 取得平均薪水最高的部门的编号
SELECT deptno, avg(emp.sal)
FROM emp
GROUP BY deptno
ORDER BY avg(emp.sal) DESC
LIMIT 1;

-- 求平均薪水的等级最高的部门的部门名称
SELECT dname, s.x
FROM dept
         INNER JOIN (
    SELECT deptno, avg(sal) x
    FROM emp
    GROUP BY deptno
    ORDER BY x DESC
    LIMIT 1) s ON s.deptno = dept.deptno;

-- 取得比普通员工的最高薪水还要高的领导人姓名
SELECT ename, sal
FROM emp
         INNER JOIN (
    SELECT DISTINCT mgr
    FROM emp
    WHERE mgr IS NOT NULL
) emp1 ON emp1.mgr = emp.empno
WHERE emp.sal > (
    SELECT max(sal)
    FROM emp
    WHERE empno NOT IN (
        SELECT DISTINCT mgr
        FROM emp
        WHERE mgr IS NOT NULL
    )
);

-- 取得每个薪水等级有多少员工
SELECT grade, count(emp.ename)
FROM salgrade sl
         INNER JOIN emp ON emp.sal BETWEEN sl.losal AND sl.hisal
GROUP BY grade;

-- 列出受雇日期早于其直接上级领导的所有员工编号，姓名、部门名称
SELECT e1.empno, e1.ename, dname
FROM emp e1
         RIGHT JOIN emp e2 ON e2.empno = e1.mgr AND e1.hiredate < e2.hiredate
         INNER JOIN dept ON e1.deptno = dept.deptno;

-- 列出部门名称和这些员工信息同时列出那些没有员工的部门
SELECT dept.deptno, dname, e1.ename
FROM emp e1
         RIGHT JOIN dept ON e1.deptno = dept.deptno
ORDER BY dname;

-- 列出至少有五个员工的部门详细信息
SELECT dept.deptno, dept.dname, dept.loc, count(e1.empno)
FROM emp e1
         INNER JOIN dept ON e1.deptno = dept.deptno
GROUP BY dept.deptno, dept.dname, dept.loc
HAVING count(e1.empno) >= 5
ORDER BY dname;

-- 列出所有“CLERK”(办事员)的姓名及其部门名称，部门人数
SELECT e.ename,
       d.dname,
       t.totalEmp
FROM dept d
         INNER JOIN
     emp e
     ON
         e.deptno = d.deptno
         INNER JOIN
         (SELECT deptno, count(*) AS totalEmp FROM emp GROUP BY deptno) t
         ON
             t.deptno = d.deptno
WHERE e.job = 'CLERK';

-- 列出最低薪金大于1500的各种工作及从事此工作的全部雇员人数
SELECT job, min(sal), count(*) AS totalEmp
FROM emp
GROUP BY job
HAVING min(sal) > 1500;

-- 列出部门在“SALES”<销售部>工作的姓名
SELECT ename
FROM emp
         INNER JOIN dept ON dept.deptno = emp.deptno AND dept.dname = 'SALES';

-- 列出薪金高于公司平均薪金的所有员工、所在的部门、上级领导、雇员的工资等级
SELECT e1.ename, dname, e2.ename, s.grade
FROM emp e1
         LEFT JOIN emp e2 ON e1.mgr = e2.empno
         INNER JOIN dept ON dept.deptno = e1.deptno
         INNER JOIN salgrade s ON e1.sal BETWEEN s.losal AND s.hisal
WHERE e1.sal > (SELECT avg(sal) FROM emp);

-- 列出所有与“SCOTT”从事相同工作的所有员工及部门名称
SELECT e.ename,
       e.job,
       d.dname
FROM emp e
         INNER JOIN
     dept d
     ON
         e.deptno = d.deptno
WHERE e.job = (SELECT job FROM emp WHERE ename = 'SCOTT')
  AND ename != 'SCOTT';

-- 列出每个部门工作的员工数量，平均工资、平均服务期限
SELECT dept.deptno,
       count(emp.empno),
       avg(emp.sal),
       avg((to_days(now()) - to_days(emp.hiredate)) / 365)
FROM emp
         RIGHT JOIN dept ON dept.deptno = emp.deptno
GROUP BY dept.deptno;

-- 列出各个部门MANAGER的最低薪金
SELECT dept.deptno, min(sal)
FROM dept
         LEFT JOIN emp ON dept.deptno = emp.deptno AND emp.job = 'MANAGER'
GROUP BY dept.deptno;