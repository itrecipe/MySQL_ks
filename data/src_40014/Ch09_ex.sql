/*ch09_문제1*/
CREATE VIEW view_도시_직위별_고객수
AS
SELECT 도시
      ,SUM(CASE WHEN 담당자직위 = '대표 이사' THEN 1 ELSE 0 END) AS '대표 이사'
      ,SUM(CASE WHEN 담당자직위 LIKE '영업%' THEN 1 ELSE 0 END) AS '영업'
      ,SUM(CASE WHEN 담당자직위 LIKE '마케팅%' THEN 1 ELSE 0 END) AS '마케팅'
      ,SUM(CASE WHEN 담당자직위 LIKE '회계%' THEN 1 ELSE 0 END) AS '회계'
FROM 고객
GROUP BY 도시;