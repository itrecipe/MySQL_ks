/*Ch10 예제*/
/*예제10-1*/
DELIMITER $$
CREATE PROCEDURE proc_if()
    BEGIN
        DECLARE x INT;
        DECLARE y INT DEFAULT 5;
        SET x = 10;

        IF x > y THEN
            SELECT 'x는 y보다 큽니다.' AS 결과;
        ELSE
            SELECT 'x는 y보다 작거나 같습니다.' AS 결과;
        END IF;
    END $$
DELIMITER ;

CALL proc_if()

/*예제10-2*/
DELIMITER $$
CREATE PROCEDURE proc_case()
    BEGIN
        DECLARE x INT DEFAULT 10;
        DECLARE y INT;
        SET y = 10 mod 2;

        CASE
            WHEN y = 0 THEN
                SELECT 'x는 짝수입니다' AS '결과';
        ELSE
            SELECT 'x는 홀수입니다' AS '결과';
        END CASE;
    END $$
DELIMITER ;

CALL proc_case()

/*예제10-3*/
DELIMITER $$
CREATE PROCEDURE proc_while()
    BEGIN
        DECLARE x INT DEFAULT 0;
        DECLARE y INT DEFAULT 0;
 
        WHILE x < 10 DO
            SET x = x + 1;
            SET y = y + x;
        END WHILE;
        SELECT x, y;
    END $$
DELIMITER ;

CALL proc_while()

/*예제10-4*/
DELIMITER $$
CREATE PROCEDURE proc_loop()
    BEGIN
        DECLARE x INT DEFAULT 0;
        DECLARE y INT DEFAULT 0;

        loop_sum:LOOP
            SET x = x + 1;
            SET y = y + x;
            IF x > 10 THEN
                LEAVE loop_sum;
    END IF;
		SELECT x, y;
    END LOOP;
    END $$
DELIMITER ;

CALL proc_loop()

/*예제10-5*/
DELIMITER $$
CREATE PROCEDURE proc_repeat()
    BEGIN
        DECLARE x INT DEFAULT 0;
        DECLARE y INT DEFAULT 0;

        REPEAT
            SET x = x + 1;
            SET y = y + x;
        UNTIL x >= 10 END REPEAT;
        SELECT x, y;
END $$
DELIMITER ;

CALL proc_repeat()

/*예제10-6*/
DELIMITER $$
CREATE PROCEDURE proc_공주시_고객정보()
BEGIN
    SELECT *
    FROM 고객;
    SELECT COUNT(*) AS 고객수
    FROM 고객;
END $$
DELIMITER ;

CALL proc_공주시_고객정보();

/*예제10-7*/
DELIMITER $$
CREATE PROCEDURE proc_도시고객정보
    (
	 IN city VARCHAR(50)
    )
BEGIN
    SELECT *
    FROM 고객
    WHERE 도시 = city;

    SELECT COUNT(*) AS 고객수
    FROM 고객
    WHERE 도시 = city;
END $$
DELIMITER ;

CALL proc_도시고객정보('부산광역시');

/*예제10-8*/
DELIMITER $$
CREATE PROCEDURE proc_주문년도시_고객정보
    (
     IN order_year INT,
     IN city VARCHAR(50) 
    )
BEGIN
    SELECT 고객.고객번호
          ,고객회사명
          ,도시
          ,COUNT(*) AS 주문건수
    FROM 고객 JOIN 주문
    ON 고객.고객번호 = 주문.고객번호
    WHERE YEAR(주문일) = order_year
    AND 도시 = city
    GROUP BY 고객.고객번호
            ,고객회사명;
END $$
DELIMITER ;

CALL proc_주문년도시_고객정보(2021, '공주시');

/*예제10-9*/
DELIMITER $$
CREATE PROCEDURE proc_고객회사명_마일리지추가
    (
     IN company VARCHAR(50),
     IN add_mileage INT
    )
BEGIN
    SELECT 고객번호
          ,고객회사명
          ,마일리지 AS 변경전마일리지
    FROM 고객
    WHERE 고객회사명 = company;
  
    UPDATE 고객
    SET 마일리지 = 마일리지 + add_mileage
    WHERE 고객회사명 = company;
    
    SELECT 고객번호
          ,고객회사명
          ,마일리지 AS 변경후마일리지
    FROM 고객
    WHERE 고객회사명 = company;
END $$
DELIMITER ;

CALL proc_고객회사명_마일리지추가('진영무역',1000);

/*예제10-10*/
DELIMITER $$
CREATE PROCEDURE proc_고객회사명_평균마일리지로변경
    (
     IN company VARCHAR(50)
    )
BEGIN
    DECLARE 평균마일리지 INT;
    DECLARE 보유마일리지 INT;
    
    SELECT 고객회사명
          ,마일리지 AS 변경전마일리지
    FROM 고객
    WHERE 고객회사명 = company;

    SET 평균마일리지 = (SELECT AVG(마일리지)
                    FROM 고객);
    SET 보유마일리지 = (SELECT 마일리지
                    FROM 고객
                    WHERE 고객회사명 = company);

    IF (보유마일리지 > 평균마일리지) THEN
        UPDATE 고객
        SET 마일리지 = 마일리지 + 100
        WHERE 고객회사명 = company;
    ELSE
        UPDATE 고객
        SET 마일리지 = 평균마일리지
        WHERE 고객회사명 = company;
    END IF;

    SELECT 고객회사명
          ,마일리지 AS 변경후마일리지
    FROM 고객
    WHERE 고객회사명 = company;
END $$
DELIMITER ;

CALL proc_고객회사명_평균마일리지로변경('굿모닝서울');

/*예제10-11*/
DELIMITER $$
CREATE PROCEDURE proc_고객등급
   (
    IN company VARCHAR(50),
    OUT grade VARCHAR(20)
   )
BEGIN
    DECLARE 보유마일리지 INT;

    SELECT 마일리지
    INTO 보유마일리지 
    FROM 고객
    WHERE 고객회사명 = company;

    IF 보유마일리지 > 100000 THEN
       SET grade = '최우수고객회사';
    ELSEIF 보유마일리지 >= 50000 THEN
       SET grade = '우수고객회사';
    ELSE
       SET grade = '관심고객회사';
    END IF;
END $$
DELIMITER ;

CALL proc_고객등급('그린로더스', @그린로더스등급);
CALL proc_고객등급('오뚜락', @오뚜락등급);
SELECT @그린로더스등급, @오뚜락등급;

/*예제10-12*/
DELIMITER $$
CREATE PROCEDURE proc_인상금액
    (
     IN increate_rate INT,
     INOUT price INT
    )
BEGIN
    SET price = price * (1 + increate_rate / 100);
END $$
DELIMITER ;

SET @금액 = 10000;
CALL proc_인상금액(10, @금액);
SELECT @금액;

/*예제10-13*/
DELIMITER $$
CREATE FUNCTION func_금액(quantity INT, price INT)
    RETURNS INT
BEGIN
    DECLARE amount INT;
    SET amount = quantity * price;
    RETURN amount;
END $$
DELIMITER ;

SELECT func_금액(100, 4500);

SELECT *
      ,func_금액(주문수량, 단가) AS 주문금액
FROM 주문세부;

/*예제10-14*/
CREATE TABLE 제품로그 
    (
     로그번호 INT AUTO_INCREMENT PRIMARY KEY,
     처리 VARCHAR(10),
     내용 VARCHAR(100),
     처리일 TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
    );
    
DELIMITER $$
CREATE TRIGGER trigger_제품추가로그
AFTER INSERT ON 제품
FOR EACH ROW
BEGIN
    INSERT INTO 제품로그(처리, 내용)
    VALUES('INSERT', CONCAT('제품번호:', NEW.제품번호, '제품명:', NEW.제품명));
END $$
DELIMITER ;

INSERT INTO 제품(제품번호,제품명,단가,재고)
VALUES(99, '레몬캔디', 2000, 10);

SELECT *
FROM 제품
WHERE 제품번호 = 99;

SELECT *
FROM 제품로그;

/*예제10-15*/
DELIMITER $$
CREATE TRIGGER trigger_제품변경로그
AFTER UPDATE ON 제품
FOR EACH ROW
BEGIN
    IF (NEW.단가 <> OLD.단가) THEN
        INSERT INTO 제품로그(처리, 내용)
        VALUES ('UPDATE', CONCAT('제품번호:', OLD.제품번호,' 단가:', OLD.단가, '->', NEW.단가));
    END IF;

    IF (NEW.재고 <> OLD.재고) THEN
        INSERT INTO 제품로그(처리, 내용)
        VALUES ('UPDATE', CONCAT('제품번호:', OLD.제품번호,' 재고:', OLD.재고, '->', NEW.재고));
    END IF;
END $$
DELIMITER ;

UPDATE 제품
SET 단가 = 2500
WHERE 제품번호 = 99;

SELECT *
FROM 제품로그;

/*예제10-16*/
DELIMITER $$
CREATE TRIGGER trigger_제품삭제로그
AFTER DELETE ON 제품
FOR EACH ROW
BEGIN
    INSERT INTO 제품로그(처리, 내용)
    VALUES ('DELETE', CONCAT('제품번호:', OLD.제품번호, ' 제품명:', OLD.제품명));
END $$
DELIMITER ;

DELETE FROM 제품
WHERE 제품번호 = 99;

SELECT * FROM 제품로그;