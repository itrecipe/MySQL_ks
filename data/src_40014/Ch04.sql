/*Ch04 예제*/
/*예제4-1*/
SELECT COUNT(*)
	  ,COUNT(고객번호)
      ,COUNT(도시)
      ,COUNT(지역)
FROM 고객;

/*예제4-2*/
SELECT SUM(마일리지)
      ,AVG(마일리지)
      ,MIN(마일리지)
      ,MAX(마일리지)
FROM 고객;

/*예제4-3*/
SELECT SUM(마일리지)
      ,AVG(마일리지)
      ,MIN(마일리지)
      ,MAX(마일리지)
FROM 고객
WHERE 도시 = '서울특별시';

/*예제4-4*/
SELECT 도시
      ,COUNT(*) AS 고객수
      ,AVG(마일리지) AS 평균마일리지
FROM 고객
GROUP BY 도시;

SELECT 도시
      ,COUNT(*) AS 고객수
      ,AVG(마일리지) AS 평균마일리지
FROM 고객
GROUP BY 1;

/*예제4-5*/
SELECT 담당자직위
      ,도시
      ,COUNT(*) AS 고객수
      ,AVG(마일리지) AS 평균마일리지
FROM 고객
GROUP BY 담당자직위
		,도시
ORDER BY 1, 2;

/*예제4-6*/
SELECT 도시
      ,COUNT(*) AS 고객수
      ,AVG(마일리지) AS 평균마일리지
FROM 고객
GROUP BY 도시
HAVING COUNT(*) >= 10;

/*예제4-7*/
SELECT 도시
      ,SUM(마일리지)
FROM 고객
WHERE 고객번호 LIKE 'T%'
GROUP BY 도시
HAVING SUM(마일리지) >= 1000;

/*예제4-8*/
SELECT 도시
      ,COUNT(*) AS 고객수
      ,AVG(마일리지) AS 평균마일리지
FROM 고객
WHERE 지역 IS NULL
GROUP BY 도시
WITH ROLLUP;

SELECT IFNULL(도시,'총계') AS 도시
      ,COUNT(*) AS 고객수
      ,AVG(마일리지) AS 평균마일리지
FROM 고객
WHERE 지역 IS NULL
GROUP BY 도시
WITH ROLLUP;

/*예제4-9*/
SELECT 담당자직위
      ,도시
      ,COUNT(*) AS 고객수
FROM 고객
WHERE 담당자직위 LIKE '%마케팅%'
GROUP BY 담당자직위
        ,도시
WITH ROLLUP;

/*예제4-1*/
SELECT 지역
      ,COUNT(*) AS 고객수
FROM 고객
WHERE 담당자직위 = '대표 이사'
GROUP BY 지역
WITH ROLLUP;

SELECT 지역
      ,COUNT(*) AS 고객수
      ,GROUPING(지역) AS 구분
FROM 고객
WHERE 담당자직위 = '대표 이사'
GROUP BY 지역
WITH ROLLUP;

/*예제4-11*/
SELECT GROUP_CONCAT(이름)
FROM 사원;

/*예제4-12*/
SELECT GROUP_CONCAT(DISTINCT 지역)
FROM 고객;

/*예제4-13*/
SELECT 도시
      ,GROUP_CONCAT(고객회사명) AS 고객회사명목록
FROM 고객
GROUP BY 도시;
