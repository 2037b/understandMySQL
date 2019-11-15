DROP PROCEDURE IF EXISTS Exchange;
# select * from crushcourse.student;
CREATE PROCEDURE Exchange()
BEGIN
    DECLARE id_seq INT DEFAULT 0;
    DECLARE id_rev INT DEFAULT 0;
    DECLARE name_seq VARCHAR(50);
    DECLARE name_rev VARCHAR(50);
    DECLARE done INT DEFAULT 1;
    DECLARE sequence CURSOR FOR SELECT student_name FROM student ORDER BY student_id;
    DECLARE reverse CURSOR FOR SELECT student_id FROM student ORDER BY student_id DESC;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 0;
    OPEN sequence;OPEN reverse;
    FETCH sequence INTO name_seq;
    FETCH reverse INTO id_rev;

    REPEAT
        UPDATE student SET student_name = name_seq WHERE student_id = id_rev;
#     UPDATE student SET student_name = name_rev  WHERE student_id = id_seq;
        FETCH sequence INTO name_seq;
        FETCH reverse INTO id_rev;
    UNTIL done = 0 END REPEAT;
    CLOSE sequence;CLOSE reverse;

END
CALL EXCHANGE( );