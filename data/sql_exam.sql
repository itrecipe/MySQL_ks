  -- 24.04.25 mySQL 수업  
  
  -- 전체 테이블 조회
  show tables;
  
  -- 전체 DB(스키마) 조회
  show databases;
  
  -- select문 사용하기
  
  -- 고객 테이블에 있는 전체컬럼 조회하기
  select * from 고객;
  
  -- select로 별칭을 붙여서 마일리지가 10% 인상된 데이터들을 조회하기
  select 고객번호, 담당자명, 마일리지 AS 포인트, 마일리지 * 1.1 AS "10% 인상된 마일리지"
  FROM 고객;
  
  -- 고객 테이블에서 마일리지가 100,000점 이상인 고객의 고객번호, 담당자명, 마일리지를 조회하기 (select, from, where)
  select 고객번호
  ,담당자명
  ,마일리지
  from 고객
  where 마일리지 >= 100000;
  
  -- 서울특별시에 사는 고객에 대해 고객번호, 담당자명, 도시, 마일리지를 조회 (마일리지가 많은 고객부터 순서대로 보인다) / (order by, desc)
  select 고객번호
  ,담당자명
  ,도시
  ,마일리지 AS 포인트
  from 고객
  where 도시 = "서울특별시"
  order by 마일리지 desc;
  
  -- 고객 테이블에서 1행부터 시작하여 3개 고객 정보를 조회 (limit)
  select * from 고객 limit 3;
  
  -- 마일리지가 많은 고객부터 상위 3명의 고객에 대한 모든 정보를 조회 (order by, desc)
  select *
  from 고객 
  order by 마일리지 
  desc;
  
  -- 고객 테이블의 도시 컬럼에 들어있는 값 중 중복되는 도시 데이터를 한번만 보여라 (distinct)
  select distinct 도시 from 고객;
  
  -- SQL 연산자
  
  -- 두 개의 숫자 23과 5로 산술 연산자 +, -, *, /, %를 사용한 결과를 나타내라. div, mod 연산자의 사용 결과도 함께 확인
SELECT 23 + 5 AS 더하기
      ,23 - 5 AS 빼기
      ,23 * 5 AS 곱하기
      ,23 / 5 AS 실수나누기
      ,23 DIV 5 AS 정수나누기
      ,23 % 5 AS 나머지1
      ,23 MOD 5 AS 나머지2;
       
-- 비교 연산자 (and, or, not)
select 5 = 5 as 비교하기, 5 != 5 as 비교하기;

-- ex2-10 담당자가 '대표 이사가 아닌 고객의 모든 정보를 보이시오
select *
from 고객
where 담당자직위 != '대표 이사';

-- 2-11 도시가 '부산광역시' 이면서 마일리지가 1,000점보다 작은 고객의 모든 정보를 보여라
select *
from 고객
where 도시 = "부산광역시"
AND 마일리지 < 1000;

select *
from 고객
where 도시 = "부산광역시"
or 마일리지 < 1000;

-- 2-12 부산광역시에 살다가 마일리지가 1,000점 보다 작은 고객에 대하여 고객번호,담당자명, 마일리지, 도시를 보여라
-- (이때 결과는 고객번호 순으로 정리한다.)

-- union (합집합)
select 고객번호
,담당자명
,마일리지
,도시
from 고객
where 도시 = '부산광역시'
union
select 고객번호
,담당자명
,마일리지
,도시
from 고객
where 마일리지 < 1000
order by 1; -- order by절은 제일 마지막에 넣는다.

-- or
SELECT 고객번호, 담당자명, 마일리지, 도시
FROM 고객
WHERE 도시 = '부산광역시'
UNION
SELECT 고객번호, 담당자명, 마일리지, 도시
FROM 고객
WHERE 마일리지 < 1000
ORDER BY 1; -- ORDER BY 절은 제일 마지막에 넣습니다.

-- ex) 2-13 지역에 값이 들어있지 않은 고객 정보를 보여라
select *
from 고객
where 지역 is null;

-- 빈 문자열을 검색하면 레코드가 검색된다.
select *
from 고객
where 지역 = '';

-- ex) 2-13 지역에 값이 들어있지 않는 고객의 정보를 보여라 (update)
update 고객
set 지역 = null
where 지역 = '';

-- ex) 2-14 담당자직위가 '영업 과장' 이거나 '마케팅 과장'인 고객에 대해 고객번호, 담당자명, 담당자직위를 보여라 (in)
select 고객번호
,담당자명
,담당자직위
from 고객
where 담당자직위 = '영업 과장'
or 담당자직위 = '마케팅 과장';

select 고객번호
,담당자명
,담당자직위
from 고객
where 담당자직위 in ('영업과장', '마케팅 과장');

-- ex)2-15 마일리지가 100,000점 이상 200,000이점 이하인 고객에 대해 담당자명, 마일리지를 보여라
select 담당자명
,마일리지
from 고객
where 마일리지 >= 100000
and 마일리지 <= 200000;

-- between ~ and를 사용해 해결하기
select 담당자명
,마일리지
from 고객
where 마일리지 between 100000 and 200000;

-- ex)2-16 도시가 '광역시' 이면서 고객번호 두 번째 글자 또는 세 번째 글자가 'C'인 고객의 모든 정보를 보이시오.
select *
from 고객
where 도시 like '%광역시'
and (고객번호 like '_C%' or 고객번호 like '___C%');