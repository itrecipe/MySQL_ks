/*Ch09 예제*/
/*예제9-1*/
CREATE OR REPLACE VIEW view_사원
AS
SELECT 이름
      ,집전화 AS 전화번호
      ,입사일
      ,주소
FROM 사원;

CREATE OR REPLACE VIEW view_사원(이름, 전화번호, 입사일, 주소)
AS
SELECT 이름
      ,집전화 AS 전화번호
      ,입사일
      ,주소
FROM 사원;

SELECT *
FROM view_사원;

/*예제9-2*/
CREATE OR REPLACE VIEW view_제품별주문수량합
AS
SELECT 제품명
      ,SUM(주문수량) AS 주문수량합
FROM 제품
INNER JOIN 주문세부
ON 제품.제품번호 = 주문세부.제품번호
GROUP BY 제품명;

SELECT *
FROM view_제품별주문수량합;

/*예제9-3*/
CREATE OR REPLACE VIEW view_사원_여
AS
SELECT 이름
      ,집전화 AS 전화번호
      ,입사일
      ,주소
      ,성별
FROM 사원
WHERE 성별 = '여';

SELECT *
FROM view_사원_여;

/*예제9-4*/
SELECT *
FROM view_사원_여
WHERE 전화번호 LIKE '%88%';

/*예제9-5*/
SELECT *
FROM view_제품별주문수량합
WHERE 주문수량합 >= 1200;

/*예제9-6*/
SELECT *
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_NAME = 'view_사원';

SHOW CREATE VIEW view_사원;

/*예제9-7*/
DROP VIEW view_사원;

/*예제9-8*/
INSERT INTO view_사원_여(이름, 전화번호, 입사일, 주소, 성별)
VALUES('황여름','(02)587-4989','2023-02-10','서울시 강남구 청담동 23-5','여');

CREATE OR REPLACE VIEW view_사원_여
AS
SELECT 사원번호
      ,이름
      ,집전화 AS 전화번호
      ,입사일
      ,주소
      ,성별
FROM 사원
WHERE 성별 = '여';

ALTER VIEW view_사원_여
AS
SELECT 사원번호
      ,이름
      ,집전화 AS 전화번호
      ,입사일
      ,주소
      ,성별
FROM 사원
WHERE 성별 = '여';

INSERT INTO view_사원_여(사원번호, 이름, 전화번호, 입사일, 주소, 성별)
VALUES('E12','황여름','(02)587-4989','2023-02-10','서울시 강남구 청담동 23-5','여');

SELECT *
FROM view_사원_여
WHERE 사원번호 = 'E12';

SELECT *
FROM 사원
WHERE 사원번호 = 'E12';

/*예제9-9*/
INSERT INTO view_제품별주문수량합
VALUES('단짠 새우깡', 250);

/*예제9-10*/
INSERT INTO view_사원_여(사원번호, 이름, 입사일, 주소, 성별)
VALUES('E13', '강겨울','2023-02-10','서울시 성북구 장위동 123-7','남');

SELECT *
FROM view_사원_여
WHERE 사원번호 = 'E13';

SELECT *
FROM 사원
WHERE 사원번호 = 'E13';

CREATE OR REPLACE VIEW view_사원_여
AS
SELECT 사원번호
	  ,이름
      ,집전화 AS 전화번호
      ,입사일
      ,주소
      ,성별
FROM 사원
WHERE 성별 = '여'
WITH CHECK OPTION;

INSERT INTO view_사원_여(사원번호, 이름, 성별)
VALUES('E14', '유봄','남');

UPDATE view_사원_여
SET 성별 = '남'
WHERE 이름 = '황여름';

/*예제 9-11*/
CREATE TABLE 날씨
    (
       년도 INT
      ,월 INT
      ,일 INT 
      ,도시 VARCHAR(20)
      ,기온 NUMERIC(3,1)
      ,습도 INT
      ,PRIMARY KEY(년도, 월, 일, 도시)
      ,INDEX 기온인덱스(기온)
      ,INDEX 도시인덱스(도시)
    );

/*예제 9-12*/
EXPLAIN FORMAT = TREE
SELECT 고객회사명
      ,COUNT(*) AS 주문건수
FROM 고객
INNER JOIN 주문
ON 고객.고객번호 = 주문.고객번호
GROUP BY 고객회사명
ORDER BY COUNT(*) DESC;

/*예제 9-13*/
EXPLAIN ANALYZE
SELECT 고객회사명
	  ,COUNT(*) AS 주문건수
FROM 고객
INNER JOIN 주문
ON 고객.고객번호 = 주문.고객번호
GROUP BY 고객회사명
ORDER BY COUNT(*) DESC;