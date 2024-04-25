/*ch03_문제1*/
SELECT 고객회사명
      ,CONCAT('**', SUBSTR(고객회사명, 3)) AS 고객회사명2
      ,전화번호
,REPLACE(SUBSTR(전화번호,2), ')', '-') AS 전화번호2
FROM 고객;

/*ch03_문제2*/
SELECT *
      ,단가 * 주문수량 AS 주문금액
      ,TRUNCATE(단가 * 주문수량 * 할인율, -1) AS 할인금액
      ,단가 * 주문수량 - TRUNCATE(단가 * 주문수량 * 할인율, -1) AS 실주문금액
FROM 주문세부;

/*ch03_문제3*/
SELECT 이름
      ,생일
      ,TIMESTAMPDIFF(YEAR, 생일, CURDATE()) AS 만나이
      ,입사일
      ,DATEDIFF(CURDATE(), 입사일) AS 입사일수
      ,ADDDATE(입사일, 500) AS '500일후'
FROM 사원;

/*ch03_문제4*/
SELECT 담당자명
      ,고객회사명
      ,도시
      ,IF(도시 LIKE '%특별시' OR 도시 LIKE '%광역시', '대도시', '도시') AS 도시구분
      ,마일리지
      ,CASE WHEN 마일리지 >= 100000 THEN 'VVIP고객'
WHEN 마일리지 >= 10000 THEN 'VIP고객'
ELSE '일반고객'
END AS 마일리지구분
FROM 고객;

/*ch03_문제5*/
SELECT 주문번호
      ,고객번호
      ,주문일
      ,YEAR(주문일) AS 주문년도
      ,QUARTER(주문일) AS 주문분기
      ,MONTH(주문일) AS 주문월
      ,DAY(주문일) AS 주문일
      ,WEEKDAY(주문일) AS 주문요일
      ,CASE WEEKDAY(주문일) WHEN 0 THEN '월요일'
                          WHEN 1 THEN '화요일'
                          WHEN 2 THEN '수요일'
                          WHEN 3 THEN '목요일'
                          WHEN 4 THEN '금요일'
                          WHEN 5 THEN '토요일'
                          ELSE '일요일'
	  END AS 한글요일
FROM 주문;

/*ch03_문제6*/
SELECT *
       ,DATEDIFF(발송일, 요청일) AS 지연일수
FROM 주문
WHERE DATEDIFF(발송일, 요청일) >= 7;
