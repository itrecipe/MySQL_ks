/*ch04_문제1*/
SELECT COUNT(도시)
      ,COUNT(DISTINCT 도시)
FROM 고객;

/*ch04_문제2*/
SELECT YEAR(주문일) AS 주문년도
       ,COUNT(*) AS 주문건수
FROM 주문
GROUP BY YEAR(주문일);

/*ch04_문제3*/
SELECT YEAR(주문일) AS 주문년도
      ,QUARTER(주문일) AS 분기
      ,COUNT(*) AS 주문건수
FROM 주문
GROUP BY YEAR(주문일)
        ,QUARTER(주문일)
WITH ROLLUP;

/*ch04_문제4*/
SELECT MONTH(주문일) AS 주문월
      ,COUNT(*) AS 주문건수
FROM 주문
WHERE 요청일 < 발송일
GROUP BY MONTH(주문일)ORDER BY MONTH(주문일);

/*ch04_문제5*/
SELECT 제품명
      ,SUM(재고) AS 재고합
FROM 제품
WHERE 제품명 LIKE '%아이스크림%'
GROUP BY 제품명;

SELECT 제품명
      ,SUM(재고) AS 재고합
FROM 제품
GROUP BY 제품명
HAVING 제품명 LIKE '%아이스크림%';

/*ch04_문제6*/
SELECT IF(마일리지 >= 50000, 'VIP고객', '일반고객') AS 고객구분
	  ,COUNT(*) AS 고객수
      ,AVG(마일리지) AS 평균마일리지
FROM 고객
GROUP BY IF(마일리지 >= 50000, 'VIP고객', '일반고객');