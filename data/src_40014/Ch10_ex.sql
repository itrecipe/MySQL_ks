/*ch10_문제1*/
DELIMITER $$
CREATE PROCEDURE proc_제품명_주문내역
    (
     IN product_name VARCHAR(50)
    )
BEGIN
    SELECT 제품명
          ,SUM(주문수량) AS 주문수량합
          ,SUM(주문세부.단가 * 주문수량) AS 주문금액합
    FROM 제품
        ,주문세부
    WHERE 제품.제품번호 = 주문세부.제품번호
    AND 제품명 LIKE CONCAT('%', product_name,'%')
    GROUP BY 제품명;
END $$
DELIMITER ;

CALL proc_제품명_주문내역('캔디');

/*ch10_문제2*/
DELIMITER $$
CREATE FUNCTION func_연령구분(birthday DATE)
    RETURNS VARCHAR(20)
BEGIN
    DECLARE 나이 INT;
    DECLARE 연령구분 VARCHAR(20);

    SET 나이 = YEAR(NOW()) - YEAR(birthday);

    SET 연령구분 = (SELECT CASE
						  WHEN 나이 < 20 THEN '미성년'
                          WHEN 나이 < 30 THEN '청년층'
                          WHEN 나이 < 55 THEN '중년층'
                          WHEN 나이 < 70 THEN '장년층'
                          ELSE '노년층'
                  END);
    RETURN 연령구분;
END $$
DELIMITER ;

SELECT 이름
      ,생일
      ,YEAR(생일)
      ,DATE_FORMAT(생일, '%Y')
      ,SUBSTRING(생일,1,4)
FROM 사원;

SELECT func_연령구분('2000-01-01');

SELECT 사원번호
      ,이름
      ,생일
      ,YEAR(NOW( )) - YEAR(생일) AS 나이
      ,func_연령구분(생일) AS 연령구분
FROM 사원;