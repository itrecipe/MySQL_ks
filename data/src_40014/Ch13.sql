/*Ch13 예제*/
/*예제13-1*/
SELECT * 
FROM 지하철공기질;

/*예제13-2*/
SELECT COUNT(*) AS 총건수
      ,ROUND(AVG(미세먼지), 1) AS  평균미세먼지
      ,ROUND(AVG(초미세먼지), 1) AS 평균초미세먼지
      ,ROUND(AVG(이산화탄소), 1) AS 평균이산화탄소
      ,ROUND(AVG(폼알데하이드), 1) AS 평균폼알데하이드
      ,ROUND(AVG(일산화탄소), 1) AS 평균일산화탄소
FROM 지하철공기질;

/*예제13-3*/
SELECT 호선명 
      ,ROUND(AVG(미세먼지), 1) AS  평균미세먼지
      ,ROUND(AVG(초미세먼지), 1) AS 평균초미세먼지
      ,ROUND(AVG(이산화탄소), 1) AS 평균이산화탄소
      ,ROUND(AVG(폼알데하이드), 1) AS 평균폼알데하이드
      ,ROUND(AVG(일산화탄소), 1) AS 평균일산화탄소
FROM 지하철공기질
GROUP BY 호선명;

/*예제13-4*/
SELECT RANK() OVER(ORDER BY 미세먼지 DESC) AS 순위
      ,역명
      ,미세먼지
FROM 지하철공기질
WHERE 호선명 = '1호선'
LIMIT 10;

/*예제13-5*/
SELECT 호선명
      ,역명
      ,미세먼지
FROM 지하철공기질
WHERE 미세먼지 > (
                  SELECT AVG(미세먼지)
                  FROM 지하철공기질
                  WHERE 호선명 = '1호선'
                  );  
                  
/*예제13-6*/
SELECT 시군구명
      ,COUNT(*) AS 역개수
      ,ROUND(AVG(미세먼지), 1) AS  평균미세먼지
      ,ROUND(AVG(초미세먼지), 1) AS 평균초미세먼지
      ,ROUND(AVG(이산화탄소), 1) AS 평균이산화탄소
      ,ROUND(AVG(폼알데하이드), 1) AS 평균폼알데하이드
      ,ROUND(AVG(일산화탄소), 1) AS 평균일산화탄소
FROM 지하철공기질
GROUP BY 시군구명
ORDER BY 2 DESC;

/*예제13-7*/
SELECT 시군구명
      ,COUNT(DISTINCT 역명) AS 역개수
      ,GROUP_CONCAT(DISTINCT 역명) AS 역명
FROM 지하철공기질
GROUP BY 시군구명
ORDER BY 역개수 DESC;

/*예제13-8*/
SELECT 역명 AS 환승역
      ,COUNT(*) AS 역개수 
      ,GROUP_CONCAT(호선명) AS 호선명
FROM 지하철공기질
GROUP BY 역명
HAVING COUNT(*) >= 2
ORDER BY 2 DESC;

/*예제13-9*/
WITH 환승역 AS
(
	SELECT 역명
	      ,COUNT(*) AS 환승역수 
	FROM 지하철공기질
	GROUP BY 역명
	HAVING COUNT(*) >= 2
)

SELECT '환승역' AS 구분
      ,ROUND(AVG(미세먼지), 1) AS  평균미세먼지
      ,ROUND(AVG(초미세먼지), 1) AS 평균초미세먼지
      ,ROUND(AVG(이산화탄소), 1) AS 평균이산화탄소
      ,ROUND(AVG(폼알데하이드), 1) AS 평균폼알데하이드
      ,ROUND(AVG(일산화탄소), 1) AS 평균일산화탄소
FROM 지하철공기질
WHERE 역명 IN (
               SELECT 역명
               FROM 환승역
               )

UNION

SELECT '단일역' 
      ,ROUND(AVG(미세먼지), 1) AS  평균미세먼지
      ,ROUND(AVG(초미세먼지), 1) AS 평균초미세먼지
      ,ROUND(AVG(이산화탄소), 1) AS 평균이산화탄소
      ,ROUND(AVG(폼알데하이드), 1) AS 평균폼알데하이드
      ,ROUND(AVG(일산화탄소), 1) AS 평균일산화탄소
FROM 지하철공기질
WHERE 역명 NOT IN (
               SELECT 역명
               FROM 환승역
               );
               
/*예제13-10*/
SELECT 호선명
      ,역명
      ,미세먼지                   
FROM 지하철공기질
WHERE (호선명, 미세먼지) IN (SELECT 호선명
                                    ,MAX(미세먼지)
						 FROM 지하철공기질
			             GROUP BY 호선명);

/*예제13-11*/
SELECT 호선명
      ,SUM(승차승객수) AS 승차승객수합
      ,SUM(하차승객수) AS 하차승객수합
      ,SUM(승차승객수 + 하차승객수) AS 승하차승객수합
FROM 지하철승하차
GROUP BY 호선명;

/*예제13-12*/
SELECT 호선명
      ,COUNT(DISTINCT 역명) AS 역개수
      ,GROUP_CONCAT(DISTINCT 역명) AS 역명
      ,SUM(승차승객수 + 하차승객수) AS 승하차승객수합
      ,ROUND(SUM(승차승객수 + 하차승객수) / COUNT(DISTINCT 역명), 0) AS 역당_평균승하차승객수
FROM 지하철승하차
GROUP BY 호선명
ORDER BY 5 DESC; 

/*예제13-13*/
SELECT MONTH(사용일자) AS 월
      ,호선명
      ,SUM(승차승객수 + 하차승객수) AS 승하차승객수합
FROM 지하철승하차
GROUP BY MONTH(사용일자), 호선명
ORDER BY 1, 2;

/*예제13-14*/
SELECT 역명
      ,호선명
      ,SUM(승차승객수 + 하차승객수) AS 승하차승객수합
FROM 지하철승하차
GROUP BY 역명
        ,호선명
ORDER BY 3 DESC
LIMIT 10;

/*예제13-15*/
SELECT MONTH(사용일자) AS 월
      ,WEEKDAY(사용일자) AS 정수요일
      ,CASE WEEKDAY(사용일자)
            WHEN 0 THEN '월요일'
            WHEN 1 THEN '화요일'
            WHEN 2 THEN '수요일'
            WHEN 3 THEN '목요일'
            WHEN 4 THEN '금요일'
            WHEN 5 THEN '토요일'
            ELSE '일요일'
	END AS 요일
      ,SUM(승차승객수 + 하차승객수) AS 승하차승객수합
FROM 지하철승하차
WHERE 호선명 = '2호선'
GROUP BY MONTH(사용일자)
        ,WEEKDAY(사용일자)
        ,CASE WEEKDAY(사용일자)
            WHEN 0 THEN '월요일'
            WHEN 1 THEN '화요일'
            WHEN 2 THEN '수요일'
            WHEN 3 THEN '목요일'
            WHEN 4 THEN '금요일'
            WHEN 5 THEN '토요일'
            ELSE '일요일'
	END
ORDER BY 1,2 ;

/*예제13-16*/
SELECT 역명
      ,사용일자
      ,SUM(승차승객수 + 하차승객수) AS 승하차승객수합
      ,SUM(승차승객수 + 하차승객수) 
           OVER(PARTITION BY 역명 ORDER BY 사용일자) 승하차승객수누적합
FROM 지하철승하차
WHERE 역명 IN ('강남','홍대입구','잠실','명동')
AND MONTH(사용일자) = 12
GROUP BY 역명
  	 ,사용일자
ORDER BY 1, 2;

/*예제13-17*/
WITH 환승역 AS
(
SELECT 역명
      ,COUNT(*) AS 역개수
FROM (
           SELECT DISTINCT 호선명
	         ,역명
           FROM 지하철승하차
      ) AS t
GROUP BY 역명
HAVING COUNT(*) >= 2
)

SELECT 역명
      ,SUM(승차승객수 + 하차승객수) AS 승하차승객수합
      ,GROUP_CONCAT(DISTINCT 호선명) AS 호선명
FROM 지하철승하차
WHERE 역명 IN (
                  SELECT 역명
                  FROM 환승역
               )
GROUP BY 역명
ORDER BY 2 DESC ;

/*예제13-18*/
CREATE VIEW 지하철승하차뷰
AS 
SELECT 호선명
      ,역명
      ,SUM(승차승객수) AS 승차승객수합
      ,SUM(하차승객수) AS 하차승객수합
      ,SUM(승차승객수+하차승객수) AS 승하차승객수합
FROM 지하철승하차
GROUP BY 호선명
        ,역명;
        
/*예제13-19*/
SELECT 승하차.*
      ,공기질.미세먼지
      ,공기질.초미세먼지
      ,공기질.이산화탄소
      ,공기질.폼알데하이드
      ,공기질.일산화탄소
FROM 지하철승하차뷰 AS 승하차
JOIN 지하철공기질 AS 공기질
ON 승하차.호선명 = 공기질.호선명
AND 승하차.역명 = 공기질.역명
ORDER BY 호선명
        ,역명;
        
/*예제13-20*/
SELECT COUNT(*) AS 공기질미측정역개수
FROM 지하철승하차뷰 AS 승하차
WHERE NOT EXISTS (
                  SELECT *
                  FROM 지하철공기질 AS 공기질
                  WHERE 공기질.호선명 = 승하차.호선명
                  AND 공기질.역명 = 승하차.역명
                  );  
                  
                  
SELECT 호선명
      ,역명 
FROM 지하철승하차뷰 AS 승하차
WHERE NOT EXISTS (
                  SELECT *
                  FROM 지하철공기질 AS 공기질
                  WHERE 공기질.호선명 = 승하차.호선명
                  AND 공기질.역명 = 승하차.역명
                  );
                  
/*예제13-21*/
/*ANSI SQL*/
SELECT 승하차.호선명
      ,COUNT(승하차.역명) AS 역개수
      ,SUM(승하차승객수합) AS 승하차승객수합
      ,ROUND(승하차승객수합 / COUNT(승하차.역명), 0) AS 역당_평균_승하차인원수
      ,ROUND(AVG(미세먼지), 1) AS  평균미세먼지
      ,ROUND(AVG(초미세먼지), 1) AS 평균초미세먼지
      ,ROUND(AVG(이산화탄소), 1) AS 평균이산화탄소
      ,ROUND(AVG(폼알데하이드), 1) AS 평균폼알데하이드
      ,ROUND(AVG(일산화탄소), 1) AS 평균일산화탄소
FROM 지하철승하차뷰 AS 승하차
JOIN 지하철공기질 AS 공기질
ON 승하차.호선명 = 공기질.호선명
AND 승하차.역명 = 공기질.역명
GROUP BY 승하차.호선명
ORDER BY 4 DESC;

/*Non-ANSI SQL*/
SELECT 승하차.호선명
      ,COUNT(DISTINCT 승하차.역명) AS 역개수
      ,SUM(승하차승객수합) AS 승하차승객수합
      ,ROUND(승하차승객수합 / COUNT(승하차.역명), 0) AS 역당_평균_승하차인원수
      ,ROUND(AVG(미세먼지), 1) AS  평균미세먼지
      ,ROUND(AVG(초미세먼지), 1) AS 평균초미세먼지
      ,ROUND(AVG(이산화탄소), 1) AS 평균이산화탄소
      ,ROUND(AVG(폼알데하이드), 1) AS 평균폼알데하이드
      ,ROUND(AVG(일산화탄소), 1) AS 평균일산화탄소
FROM 지하철승하차뷰 AS 승하차
    ,지하철공기질 AS 공기질
WHERE 승하차.호선명 = 공기질.호선명
AND 승하차.역명 = 공기질.역명
GROUP BY 승하차.호선명
ORDER BY 4 DESC;

