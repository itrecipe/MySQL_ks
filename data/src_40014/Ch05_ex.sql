/*ch05_문제1*/
/*ANSI SQL*/
SELECT 제품명
      ,SUM(주문수량) AS 주문수량합
      ,SUM(주문수량 * 주문세부.단가) AS 주문금액합
FROM 제품
INNER JOIN 주문세부
ON 제품.제품번호 = 주문세부.제품번호
GROUP BY 제품명;

/*Non-ANSI SQL*/
SELECT 제품명
      ,SUM(주문수량) AS 주문수량합
      ,SUM(주문수량 * 주문세부.단가) AS 주문금액합
FROM 제품
    ,주문세부
WHERE 제품.제품번호 = 주문세부.제품번호
GROUP BY 제품명;

/*ch05_문제2*/
/*ANSI SQL*/
SELECT YEAR(주문일) AS 주문년도
      ,제품명
      ,SUM(주문수량) AS 주문수량합
FROM 제품
INNER JOIN 주문세부
ON 제품.제품번호 = 주문세부.제품번호
INNER JOIN 주문
ON 주문.주문번호 = 주문세부.주문번호
WHERE 제품명 LIKE '%아이스크림'
GROUP BY YEAR(주문일)
         ,제품명
ORDER BY 1, 2;

/*Non-ANSI SQL*/
SELECT YEAR(주문일) AS 주문년도
      ,제품명
      ,SUM(주문수량) AS 주문수량합
FROM 제품
    ,주문세부
    ,주문
WHERE 제품.제품번호 = 주문세부.제품번호
AND 주문.주문번호 = 주문세부.주문번호
AND 제품명 LIKE '%아이스크림'
GROUP BY YEAR(주문일)
        ,제품명;

/*ch05_문제3*/
SELECT 제품명
      ,SUM(주문수량) AS 주문수량합
FROM 제품
LEFT OUTER JOIN 주문세부
ON 제품.제품번호 = 주문세부.제품번호
GROUP BY 제품명;

SELECT 제품명
      ,SUM(주문수량) AS 주문수량합
FROM 주문세부
RIGHT OUTER JOIN 제품
ON 제품.제품번호 = 주문세부.제품번호
GROUP BY 제품명;

/*ch05_문제4*/
/*ANSI SQL*/
SELECT 고객번호
      ,고객회사명
      ,담당자명
      ,등급명
      ,마일리지
FROM 고객
INNER JOIN 마일리지등급
ON 마일리지 BETWEEN 하한마일리지 AND 상한마일리지
WHERE 등급명 = 'A';

/*Non-ANSI SQL*/
SELECT 고객번호
      ,고객회사명
      ,담당자명
      ,등급명
      ,마일리지
FROM 고객
    ,마일리지등급
WHERE 마일리지 BETWEEN 하한마일리지 AND 상한마일리지
AND 등급명 = 'A';      