/*Ch11 예제*/
/*예제11-1*/
SELECT 고객번호
      ,고객회사명
      ,마일리지
      ,AVG(마일리지) OVER() AS 평균마일리지 
FROM 고객
WHERE 도시 = '부산광역시';

/*예제11-2*/
SELECT 고객번호
      ,고객회사명
      ,마일리지
      ,AVG(마일리지) OVER() AS 평균마일리지
      ,마일리지 - AVG(마일리지) OVER() AS 차이
FROM 고객
WHERE 도시 = '부산광역시';

/*예제11-3*/
SELECT 고객번호
      ,도시
      ,마일리지 AS 고객마일리지
      ,AVG(마일리지) OVER(PARTITION BY 도시) AS 도시평균마일리지
      ,마일리지 - AVG(마일리지) OVER(PARTITION BY 도시) AS 차이
FROM 고객
WHERE  = '경기도';

/*예제11-4*/
SELECT 고객번호
      ,마일리지 AS 고객마일리지 
      ,SUM(마일리지) OVER() AS 마일리지합
      ,SUM(마일리지) OVER(ORDER BY 고객번호) AS 누적마일리지
FROM 고객
WHERE 도시 = '부산광역시';

/*예제11-5*/
SELECT 고객번호
      ,고객회사명
      ,담당자명
      ,마일리지
      ,RANK() OVER(ORDER BY 마일리지 DESC) AS 순위
FROM 고객
WHERE 도시 = '부산광역시';

/*예제11-6*/
SELECT 고객번호
      ,고객회사명
      ,도시
      ,마일리지
      ,RANK() OVER(PARTITION BY 도시 ORDER BY 마일리지 DESC) AS 순위
FROM 고객
WHERE 지역 = '경기도';

/*예제11-7*/
SELECT 제품명
      ,단가
      ,PERCENT_RANK() OVER(ORDER BY 단가) AS 백분율순위
 FROM 제품
 WHERE 제품명 LIKE '%시럽%';
 
/*예제11-8*/
SELECT 고객번호
      ,고객회사명
      ,마일리지
      ,CUME_DIST() OVER(ORDER BY 마일리지) AS 누적분포
FROM 고객
WHERE 도시 = '부산광역시';

/*예제11-9*/
SELECT 고객번호
      ,도시
      ,마일리지
      ,NTILE(3) OVER(ORDER BY 마일리지) AS 그룹
 FROM 고객
 WHERE 도시 = '인천광역시';
 
/*예제11-10*/
SELECT 고객번호
      ,도시
      ,마일리지
      ,NTILE(2) OVER(PARTITION BY 도시 ORDER BY 마일리지) AS 그룹
 FROM 고객;
 
/*예제11-11*/
SELECT 고객회사명
      ,마일리지
      ,FIRST_VALUE(고객회사명) OVER(ORDER BY 마일리지) AS 최소마일리지보유고객
      ,	FIRST_VALUE(마일리지) OVER(ORDER BY 마일리지) AS 최소마일리지
      ,마일리지 - FIRST_VALUE(마일리지) OVER(ORDER BY 마일리지) AS 차이  
FROM 고객
WHERE 도시 = '부산광역시';

/*예제11-12*/
SELECT 도시
      ,고객회사명
      ,마일리지
      ,FIRST_VALUE(고객회사명) OVER(PARTITION BY 도시 ORDER BY 마일리지) AS 최소마일리지보유고객
      ,FIRST_VALUE(마일리지) OVER(PARTITION BY 도시 ORDER BY 마일리지) AS 최소마일리지
      ,마일리지 - FIRST_VALUE(마일리지) OVER(PARTITION BY 도시 ORDER BY 마일리지) AS 차이
FROM 고객;

/*예제11-13*/
SELECT 고객회사명
      ,마일리지
      ,LAST_VALUE(고객회사명) OVER(ORDER BY 마일리지) AS 최대마일리지보유고객
      ,LAST_VALUE(마일리지) OVER(ORDER BY 마일리지) AS 최대마일리지
FROM 고객
WHERE 도시 = '부산광역시';

SELECT 고객회사명
      ,마일리지
      ,LAST_VALUE(마일리지) OVER(ORDER BY 마일리지 
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 최대마일리지
FROM 고객
WHERE 도시 = '부산광역시';

SELECT 고객회사명
      ,마일리지
      ,LAST_VALUE(마일리지) OVER(ORDER BY 마일리지 
            ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS 최대마일리지
FROM 고객
WHERE 도시 = '부산광역시';

/*예제11-14*/
SELECT LAG(고객번호) OVER(ORDER BY 고객번호) AS 이전행고객번호
      ,고객번호 
      ,LEAD(고객번호) OVER(ORDER BY 고객번호) AS 다음행고객번호 
FROM 고객;

/*예제11-15*/
SELECT 고객번호
      ,고객회사명
      ,마일리지
      ,NTH_VALUE(고객회사명, 3) OVER(ORDER BY 마일리지) AS "3번째로 마일리지가 적은 고객"
      ,NTH_VALUE(마일리지, 3) OVER(ORDER BY 마일리지) AS "3번째 마일리지"
FROM 고객
WHERE 도시 = '부산광역시';