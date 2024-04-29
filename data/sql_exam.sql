  -- 24.04.25 mySQL 수업  
  
  -- 전체 테이블 조회
  show tables;
  
  -- 전체 DB(스키마) 조회
  show databases;
  
  -- select문 사용하기
  
  -- ex)고객 테이블에 있는 전체컬럼 조회하기
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

-- 24.04.26 수업
-- ex) 3-2 concat() 함수와 concat_ws()함수를 사용해 문자열을 연결했을떄의 결과값을 비교하라
select concat('DREAMS', 'COME', 'TRUE')
	,CONCAT_WS('-', '2023', '01', '29');
    
-- ex)3-3 'SQL 완전정복' 지정한 길이만큼의 문자열을 반환하기
select left('SQL 완전정복', 3) -- 왼쪽부터 3문자
	,RIGHT('SQL 완전정복', 4) -- 오른쪽부터 4문자
    ,SUBSTR('SQL 완전정복', 2, 5) -- 
    ,SUBSTR('SQL 완전정복', 2); -- 

-- substring_index() : 지정한 구분자를 기준으로 문자열을 분리해 가져올때 사용한다.
-- substring_index(문자열, 구분자, 인덱스)
-- ex) 3-4 
select substring_index('서울시 동작구 흑석로', ' ', 2)
,substring_index('서울시 동작구 흑석로', ' ', -2);

-- LPAD(), RPAD() : 지정한 길이에서 문자열을 제외한 빈칸을 특정 문자로 채울때 쓰는 함수
-- ex)3-5 'SQL' 문자열의 앞 7칸에 # 기호를 채우고, SQL 뒤 2칸에는 * 기호를 채우시오
select lpad('SQL', 10, '#')
,rpad('sql', 5, '*');

-- LTRIM(), RTRIM()
-- ex)3-6 'SQL' 문자열의 앞/뒤에 있는 공백을 제거 결과를 문자열의 길이로 확인하라
select length(ltrim(' sql '))
,length(rtrim(' sql '))
,length(trim(' sql '));

-- ex)3-7
select trim(both 'abc' from 'abcSQLacabc')
,trim(LEADING 'abc' from 'abcSQLacabc')
,trim(TRAILING 'abc' from 'abcSQLacabc');

-- ex) 3-8 문자열의 위치를 찾는 4가지 함수 field(), find_inset(), instr(), locate()를 사용하고 결과를 확인
select field('java', 'sql', 'java', 'c')
,find_in_set('java', 'sql,java,c')
,instr('네 인생을 살아라', '인생')
,locate('인생', '네 인생을 살아라');

-- ex)3-9 문자열 위치를 찾는 4가지 함수 field(), find_in_set(), instr(), locate()를 사용하고 결과를 확인하시오.
select elt(2, 'java', 'sql');

-- ex)3-10 repeat()를 사용해 '*' 5개를 반복하시오.
select repeat('*', 5);

-- Replace() : 문자열 일부를 다른 문자열로 대체하고자 할 떄 사용하는 함수
-- ex)3-11 '.'로 구분되어 있는 전화번호의 구분자를 '-'로 대체하라
select replace('010-1234-5678', '.', '-');

-- REVERSE() : 문자열을 거꾸로 뒤집을 때 쓰는 함수
-- ex)3-12 'OLLEH'를 맨 뒤쪽 문자부터 나타내라
select reverse('OLLEH');

-- ex)3-13 123.56에 대해 CEILING(), FLOOR(), ROUND(), TRUNCATE()를 사용한 결과를 확인해라
select ceiling(123.56)
,floor(123.56)
,round(123.56)
,round(123.56, 1)
,truncate(123.56, 1);

-- ABS() : 절댓값을 반환하는 함수, SIGN() : 양수의
-- ex)3-14 -120과 120의 절댓값과 음수, 양수 여부를 판별하라
select abs(-120)
,abs(120)
,sign(-120)
,sign(120);

-- ex)3-16 제곱근과 제곱근, 랜덤값을 구하는 함수를 사용하고, 그 결과를 보여라
select power(2, 3)
,sqrt(16)
,rand()
,rand(100)
,round(rand() * 100); -- 0과 100 사이의 정수

-- ex)3-17 현재 날짜와 시간을 다양한 형태로 변환하라
select now()
,sysdate()
,curdate()
,curtime();

-- ex)3-18 날짜에 관한 다양함 함수의 결과를 확인해라
select now()
,year(now())
,quarter(now()) -- 분기
,month(now())
,day(now())
,hour(now())
,minute(now())
,second(now());

-- ex)3-19 현재 날짜를 기준으로 날짜 사이의 기간을 확인해라
select now()
,datediff('2025-12-20', now())
,datediff(now(), '2025-12-20')
,timestampdiff(year, now(), '2025-12-20')
,timestampdiff(month, now(), '2025-12-20')
,timestampdiff(day, now(), '2025-12-20');

-- ADDDATE() : 지정한 날짜를 기준으로 그 기간만큼 더한 날짜를 반환하는 함수
-- SUBDATE() : 
-- ex)3-20 오늘 날짜 및 오늘 날짜로부터 50일 후, 50개월 후, 50시간 전의 날짜를 확인해라
select now()
,adddate(now(), 50) -- 50일떄
,adddate(now(), interval 50 day) -- 50일후
,adddate(now(), interval 50 month) -- 50개월 후
,subdate(now(), interval 50 hour); -- 50시간 전

-- ex)3-21 오늘 날짜를 기준으로 이번 달 마지막 날짜와 일 년 중 몇 일째인지, 그리고 월 이름과 요일을 확인해라
select now() -- now() 함수는 별 다섯개, 날짜 관련 함수는 계산 앱? 그런거 만들때 많이 씀.
,last_day(now())
,dayofyear(now())
,monthname(now())
,weekday(now());

-- ex)3-22 문자 '1'을 부호 없는 숫자 형식으로, 숫자 2를 문자 형식으로 변환해라
select cast('1' as unsigned)
,cast(2 as char(1))
,convert('1', unsigned)
,convert(2, char(1));

-- ex)3-23 12,500원짜리 제품을 450개 이상 주문한 금액이 5,000,000원 이상이면 '초과달성' 이하이면 '미달성' 으로 표현하라
select if(12500 * 450 > 5000000, '초과달성', '미달성');

-- ex)3-24 ifnull()의 첫 매개변수 값이 null인지 아닌지 비교
select ifnull(1, 0) -- 첫 조건이 1이면 true
,ifnull(null, 0) -- flase
,ifnull(1/0, 'OK'); -- flase

-- ex)3-25 nullif()을 사용해 두결 과를 비교


-- ex)3-26 주문 금액이 5,000,0000원
select case when 12500 * 450 > 5000000 then '초과달성'
when 2500 * 450 > 4000000 then '달성' else '미달성' end;

-- ex)4-1 고객 테이블에서 고객번호, 도시, 지역의 개수를 조회
select count(*)
,count(고객번호)
,count(도시)
,count(지역)
from 고객;

-- ex)4-2 고객 테이블의 마일리지 컬럼에 대한 마일리지 합과 평균 마일리지, 최소 마일리지 & 최대 마일리지를 조회 (집계함수 사용)
select sum(마일리지)
,avg(마일리지)
,min(마일리지)
,max(마일리지)
from 고객;

-- ex)4-3 고객 테이블에서 '서울특별시' 고객에 대해 마일리지합, 평균마일리지, 최소마일리지, 최대마일리지 조회
select sum(마일리지)
,avg(마일리지)
,min(마일리지)
,max(마일리지)
from 고객
where 도시 = '서울특별시';

-- ex)4-4 고객 테이블에서 도시별 고객수와 해당 도시 고객들의 평균마일리지를 조회하라
select 도시
,count(*) AS 고객수
,avg(마일리지) as 평균마일리지
from 고객
group by 도시;

-- group by절에 컬럼명 대신 select절에 나열되어 있는 컬럼의 순번을 넣을 수도 있다.
select 도시
,count(*) AS 고객수
,avg(마일리지) as 평균마일리지
from 고객
group by 1;

-- ex)4-5 담당자직위별로 묶고, 같은 담당자직위에 대해서는 도시별로 묶어서 집계한 결과(고객수와 평균마일리지)를 보여라
-- (이때 담당자직위 순, 도시 순으로 정렬할것)
select 담당자직위, 도시
,count(*) as 고객수
,avg(마일리지) as 평균마일리지
from 고객
group by 담당자직위, 도시
order by 1, 2;

-- having절 : 젤 중요함
-- ex)4-6 고객테이블에서 도시별로 그룹을 묶어 고객수와 평균마일리지를 구하고, 이 중 고객수가 10명 이상인 레코드만 걸러내라
select 도시 -- 조건
,count(*) as 고객수 -- 집계 (총 갯수를 세주는 부분) as는 고객수라는 별칭
,avg(마일리지) as 평균마일리지
from 고객
group by 도시
having count(*) >= 10;

-- ex)4-7 고객번호가 'T'로 시작하는 고객에 대해 도시별로 묶어 고객의 마일리지 합을 구해라(이때 마일리지 합이 1,000점 이상인 레코드만 보여라)
select 도시, sum(마일리지)
from 고객
where 고객번호 like 'T%'
group by 도시
having sum(마일리지) >= 1000;

-- c가 중간에?
select 도시, sum(마일리지)
from 고객
where 고객번호 like '_C_%'
group by 도시
having sum(마일리지) >= 1000;

-- with rollup
-- ex)4-8 지역이 null인 고객에 대해 도시별 고객수와 평균마일리지를 보여라 (이때 맨 마지막 행에 전체 고객수와 전체 고객에 대한 평균 마일리지도 함께 볼 수 있도록 작성해라)
select 도시
,count(*) as 고객수
,avg(마일리지) as 평균마일리지
from 고객
where 지역 is null
group by 도시
with rollup;

update 고객
set 지역 = null
where 지역 = '';

-- ex)4-8을 보완한 sql문 (IFNULL문을 추가)
select ifnull(도시, '총계') as 도시
,count(*) as 고객수
,avg(마일리지) as 평균마일리지
from 고객
where 지역 is null
group by 도시
with rollup;

-- ex)4-9 담당자직위에 '마케팅'이 들어가 있는 고객에 대해 고객(담당자직위, 도시) 별 고객수를 보여라.
-- (담당자직위별 고객수와 전체 고객수도 함께 볼 수 있도록 조회할것)
select 담당자직위
,도시
,count(*) as 고객수
from 고객
where 담당자직위 like '%마케팅%'
group by 담당자직위
,도시
with rollup;

-- ex)4-10 담당자직위가 '대표 이사'인 고객에 대해 지역별로 묶어 고객수를 보이고, 전체 고객수도 함께 보여라
select 지역
,count(*) as 고객수
from 고객
where 담당자직위 = '대표 이사'
group by 지역
with rollup;

-- ex)4-11 group_concat()을 사용해 사원 테이블에 들어있는 이름을 한 행에 나열해라
select group_concat(이름)
from 사원;

-- ex)4-12 고객 테이블에 들어있는 지역을 한 행에 나열하되 중복되는 지역은 한번씩만 보여라
select group_concat(distinct 지역)
from 고객;

-- ex)4-13 고객 테이블에서 도시별로 고객회사명을 나열하라
select 도시
,group_concat(고객회사명) as 고객회사명목록
from 고객
group by 도시;

-- ex5-1 사원테이블과 부서테이블을 모두 합치는거 cross join (별로 많이 쓸일은 없다고 하셨다)

-- ANSI SQL 조인
select 부서.부서번호
,부서명
,이름
,사원.사원번호
from 부서
cross join 사원
where 이름 = '배재용';

-- Non-ANSI SQL 조인
select 부서.부서번호
,부서명
,이름
,사원.사원번호
from 부서
,사원
where 이름 = '배재용';

-- 내부 조인(Inner Join)

-- ex)5-2 '이소미' 사원의 사원번호, 직위, 부서번호, 부서명을 보이시오
-- ANSI SQL 조인
select 사원번호
,직위
,사원.부서번호
,부서명
from 사원
inner join 부서
on 사원.부서번호 = 부서.부서번호
where 이름 = '이소미';

-- Non-ANSI SQL 조인
select 사원번호부서
,직위
,사원.부서번호
,부서명
from 사원
inner join 부서
where 사원.부서번호 = 부서.부서번호
and 이름 = '이소미';

-- ex)5-3 고객 회사들이 주문한 주문건수를 주문건수가 많ㅇ른 순섣로 보이시오 (이때 고객 회사 정보로는 고객번호, 담당자명, 고객회사명을 보여라
-- ANSI SQL 조인
SELECT 고객.고객번호
    ,담당자명
    ,COUNT(*) AS 주문건수
FROM 고객
INNER JOIN 주문
ON 고객.고객번호 = 주문.고객번호
GROUP BY 고객.고객번호
    ,담당자명
    ,고객회사명
ORDER BY COUNT(*) DESC;

-- Non-ANSI SQL 조인
SELECT 고객.고객번호
    ,담당자명
    ,고객회사명
    ,COUNT(*) AS 주문건수
FROM 고객, 주문
WHERE 고객.고객번호 = 주문.고객번호
GROUP BY 고객.고객번호
    ,담당자명
    ,고객회사명
ORDER BY COUNT(*) DESC;

-- ex)5-4 고객별(고객번호, 담당자명, 고객회사명)로 주문금액 합을 보이되, 주문금액 합이 많은 순서대로 보이시오.

-- ANSI SQL 조인
select 고객.고객번호
,담당자명
,고객회사명
,sum(주문수량 * 단가) as 주문금액합
from 고객
inner join 주문
on 고객.고객번호 = 주문.고객번호
inner join 주문세부
on 주문.주문번호 = 주문세부.주문번호
group by 고객.고객번호
,담당자명
,고객회사명
order by 4 desc;

-- Non-ANSI SQL 조인
select 고객.고객번호
,담당자명
,고객회사명
,sum(주문수량 * 단가) AS 주문금액합
from 고객
,주문
,주문세부
where 고객.고객번호 = 주문.고객번호
and 주문.주문번호 = 주문세부.주문번호
group by 고객.고객번호
,담당자명
,고객회사명
order by 4 desc;

-- ex)5-5 고객테이블과 마일리지등급 테이블을 크로스 조인하라. 그 다음 고객테이블에서 담당자가 '이은광'인 고객에 대해 고객번호, 담당자명, 마일리지, 마일리지등급을 보여라
-- ANSI SQL 조인
select 고객번호
,담당자명
,마일리지
,등급.*
from 고객
cross join 마일리지등급 as 등급
where 담당자명 = '이은광';

-- Non-ANSI SQL 조인
select 고객번호
,담당자명
,마일리지
,등급.*
from 고객
,마일리지등급 as 등급
where 담당자명 = '이은광';

-- ex)5-6 고객테이블에서 담당자가 '이은광'인 경우의 고객번호, 고객회사명, 담당자명, 마일리지와 마일리지등급을 보이시오.
-- ANSI SQL 조인
select 고객번호
,고객회사명
,담당자명
,마일리지
,등급명
from 고객
inner join 마일리지등급
on 마일리지 >= 하한마일리지 -- on절 다음과 같이 작성도 가능 on 마일리지 between 하한마일리지 and 상한마일리지
and 마일리지 >= 상한마일리지
where 담당자명 = '이은광';

-- 외부조인 : 합집합과 가깝다

-- ex)5-7 고객 테이블에서 담당자가 '이은광'인 경우 고객번호, 고객회사명, 마일리지와 마일리지등급을 보여라
-- 따라서 외부 조인을 사용해야 부서번호가 없는 '정수진' 사원의 정보도 함께 얻을 수 있다.
select 사원번호
,이름
,부서명
from 사원
left outer join 부서
on 사원.부서번호 = 부서.부서번호
where 성별 = '여';

-- 만약 사원 테이블명이 우측에 기술되어 있을땐 RIGHT를 넣으면 된다.
-- from 부서
-- RIGHT OUTER JOIN 사원
-- on 사원.부서번호 = 부서.부서번호

select * from 사원;

-- ex)5-8 부서명과 해당 부서의 소속 사원 정보를 보이시오. 이떄 사원이 한명도 존재하지 않는 부서명이 있다면 그 부서명도 함께 보이시오.
-- 널 값을 포함하는게 뭐다? outer join 이다!
select 부서명
,사원.*
from 사원
right outer join 부서
on 사원.부서번호 = 부서.부서번호;

-- ex)5-9 사원이 한명도 존재하지 않는 부서명을 보여라
select 부서명
,사원.* -- 설명을 위해 사원 테이블의 정보도 함께 나타낸다
from 사원
right outer join 부서
on 사원.부서번호 = 부서.부서번호
where 사원.부서번호 is null;

-- ex)5-10 소속 부서가 없는 사원 이름을 보여라
select 이름
,부서.* -- 설명을 위해 부서 테이블 정보도 함께 나타낸다.
from 사원
left outer join 부서
on 사원.부서번호 = 부서.부서번호
where 부서.부서번호 is null;

-- selfJoin
-- ex)5-11 사원번호, 사원의 이름, 상사의 사원번호, 상사의 이름을 보이시오.
-- 사원과 사원을 조인하면 selfjoin이라고 보면 된다.

-- ANSI SQL조인
select 사원.사원번호
,사원.이름
,상사.사원번호 as '상사의 사원번호'
,상사.이름 as '상사의 이름'
from 사원
inner join 사원 as 상사
on 사원.상사번호 = 상사.상사번호;

-- ex)5-12 사원이름, 직위, 상사이름을 상사이름 순으로 정렬해 나타내시오. 상사가 없는 사원 이름도 함께 보여라
select 사원.이름 as 이름
,사원.직위
,상사.이름 as 상사이름
from 사원 as 상사
right outer join 사원
on 사원.상사번호 = 상사.사원번호
order by 상사이름;

-- ex) 6-1 최고 마일리지를 보유한 고객의 정보를 보여라
select 고객번호
,고객회사명
,담당자명
,마일리지
from 고객
where 마일리지 = (select max(마일리지)
from 고객
);

-- ex)6-2 주문번호 'H0250'을 주문한 고객에 대해 rhrorghltkaudrhk 담당자명을 보여라
-- 서브쿼리 사용
select 고객회사명
,담당자명
from 고객
where 고객번호 = (select 고객번호
from 주문
where 주문번호 = 'H0250');

-- 조인 사용
select 고객회사명
,담당자명
from 고객
inner join 주문
on 고객.고객번호 = 주문.고객번호
where 주문번호 = 'H0250';

-- 서브쿼리 사용 예제
-- ex)6-3 '부산광역시' 고객의 최소 마일리지보다 더 큰 마일리지를 가진 고객 정보를 보여라
select 담당자명
,고객회사명
,마일리지
from 고객
where 마일리지 > (select min(마일리지)
from 고객
where 도시 = '부산광역시'
);

-- 위 문제에서 고객정보만 보여라 라고 했기 때문에 위 문제처럼 할필요없이 *로 검색조건을 추출해줘도 된다
select *
from 고객
where 마일리지 > (select min(마일리지)
from 고객
where 도시 = '부산광역시'
);

-- ex)6-4 '부산광역시' 고객이 주문한 주문건수를 보여라
select count(*) as 주문건수
from 주문
where 고객번호 in (select 고객번호
from 고객
where 도시 = '부산광역시'
); -- 51건은 in 연산자로 일일이 하나하나 조건을 비교하여 카운팅한 횟수를 뽑아낸 결과값

-- ex)6-5 '부산광역시' 전체 고객의 마일리지보다 큰 고객의 정보를 보여라
select 담당자명
,고객회사명
,마일리지
from 고객
where 마일리지 > any (select 마일리지
from 고객
where 도시 = '부산광역시');

-- ex)6-6 각 지역의 어느 평균 마일리지보다도 마일리지가 큰 고객의 정보를 보여라
select 담당자명
,고객회사명
,마일리지
from 고객
where 마일리지 > all (select avg(마일리지) -- 햇갈릴 경우 서브쿼리 먼저 검색해볼것
from 고객
group by 지역
);

select avg(마일리지) from 고객 group by 지역;

-- ex)6-7 한번 이라도 주문한 적이 있는 고객 정보를 보여라
select 고객번호
,고객회사명
from 고객
where exists (select *
from 주문
where 고객번호 = 고객.고객번호
);

-- ex)6-8 고객 전체의 평균마일리지보다 평균마일리지가 큰 도시에 대해
-- 도시명과 도시의 평균마일리지를 보여라
select 도시
,avg(마일리지) as 평균마일리지
from 고객
group by 도시
having avg(마일리지) > (select avg(마일리지)
from 고객
);

-- ex)6-9 담당자명, 고객회사명, 마일리지, 도시, 해당 도시의 평균마일리지를 보여라
-- 그리고 고객이 위치하는 도시의 평균마일리지와 각 고객의 마일리지 간의 차이도 함께 보여라
select 담당자명
,고객회사명
,마일리지
,고객.도시
,도시_평균마일리지
,도시_평균마일리지 - 마일리지 as 차이
from 고객
,(select 도시
,avg(마일리지) as 도시_평균마일리지
from 고객
group by 도시
) as 도시별요약
where 고객.도시 = 도시별요약.도시;

-- ex)6-10 고객번호, 담당자명과 고객의 최종 주문일을 보여라
-- 해당 고객의 최종 주문일을 찾기 위해 스칼라 서브쿼리를 사용한다.
select 고객번호
,담당자명
,(select max(주문일)
from 주문
where 주문.고객번호 = 고객.고객번호)
as 최종주문일
from 고객;

-- ex)6-11 ex)6-9를 CTE를 사용해 작성하라

-- MYSQ 8.0 최신기능 CTE 사용
WITH 도시별요약 AS
(select 도시 ,avg(마일리지) 
as 도시_평균마일리지
from 고객
group by 도시
)

select 담당자명
,고객회사명
,마일리지
,고객.도시
,도시_평균마일리지
,도시_평균마일리지 - 마일리지 as 차이
from 고객
,도시별요약
where 고객.도시 = 도시별요약.도시;

-- 상관 서브쿼리 & 다중 컬럼 서브쿼리 사용예제
-- ex)6-12 사원 테이블에서 사원번호, 사원의 이름, 상사의 사원번호, 상사의 이름을 보여라

-- 상관 서브쿼리
select 사원번호
,이름
,상사번호
,(select 이름
from 사원 as 상사
where 상사.사원번호 = 사원.상사번호) as 상사이름
from 사원;

select 사원번호, 이름, 상사번호
from 사원;

-- 다중 컬럼 서브쿼리 (여러 개의 컬럼을 사용해 다중 비교를 수행하는 쿼리)
-- ex)6-13 각 도시마다 최고 마일리지를 보유한 고객 정보를 보여라
select 도시
,담당자명
,고객회사명
,마일리지
from 고객
where(도시,마일리지) in (select 도시, max(마일리지) -- 순서와 개수가 같아야 한다.
from 고객
group by 도시);

-- 데이터 흐름을 확인하기 위해 서브 쿼리만 따로 추출
(select 도시, max(마일리지) from 고객 group by 도시);

-- DML(데이터 조작어) select(조회), insert(삽입), update(수정), delete(삭제)

-- insert문
-- ex)7-1 부서 테이블에 다음 레코드를 삽입하라
-- 부서번호: A5, 부서명 : 마케팅부
insert into 부서 values('A5', '마케팅부');

select * from 부서;

delete from 부서
where 부서번호 = 'AS';

-- ex)7-2 제품 테이블에 다음 레코드를 추가하시오
-- 제품번호: 91, 제품명: 연어피클소스, 단가: 5000, 재고: 40
insert into 제품
values(91, '연어피클소스', null, 5000, 40);

-- ex)7-3 제품 테이블에 다음 레코드를 추가하시오
-- 제품번호: 90, 제품명: 연어피클소스, 단가: 5000, 재고: 40
insert into 제품(제품번호, 제품명, 단가, 재고)
values(90, '연어핫소스', 4000, 50);

select * from 제품;

-- ex)7-4 사원 테이블에 한 문장으로 세 명의 레코드를 추가하라
-- 사원번호 : E20, 이름: 김사과, 직위 : 수습사원, 성별 : 남, 입사일 : 현재 날짜
-- 사원번호 : E21, 이름: 박바나나, 직위 : 수습사원, 성별 : 여, 입사일 : 현재 날짜
-- 사원번호 : E22, 이름: 정오렌지, 직위 : 수습사원, 성별 : 여, 입사일 : 현재 날짜

insert into 사원(사원번호, 이름, 직위, 성별, 입사일)
values('E20', '김사과', '수습사원', '남', curdate())
,('E21', '박바나나', '수습사원', '여', curdate())
,('E22', '정오렌지', '수습사원', '여', curdate());

select * from 사원;

-- update문
-- ex)7-5 사원번호가 'E20'인 사원의 데이터를 다음과 같이 수정하라
-- (사원번호 : E20, 이름 : 김사과) -> (사원번호 : E20, 이름 : 김레몬)
update 사원
set 이름 = '김레몬'
where 사원번호 = 'E20';

select * from 사원;

-- ex)7-6 제품번호가 91인 제품에 대하여 포장 단위를 추가하라
-- (제품번호 : 91, 포장단위 : null) -> (제품번호 : 91, 포장단위 : '200 ml bottles')

update 제품
set 포장단위 = '200 ml bottles'
where 제품번호 = 91;

-- ex)7-7 제품번호가 91인 제품에 대하여 단가를 10%인상하고, 재고에서 10을 뺀 값으로 변경하라
-- update에서 두개 이상의 조건을 넣고 싶은 경우 , 하나 찍으면 됨
update 제품
set 단가 = 단가 * 1.1
,재고 = 재고 - 10
where 제품번호 = 91;

select * from 제품;

-- delete문
-- ex)7-8 제품 테이블에서 제품번호가 91인 레코드를 삭제하라
delete from 제품
where 제품번호 = 91;

select * from 제품;

-- ex)7-9 사원 테이블에서 입사일이 가장 늦은 사원 3명의 레코드를 삭제하라
delete from 사원
order by 입사일 desc
limit 3;

-- ex)7-4에서 추가한 '김레몬', '박바나나', '정오렌지'가 삭제된 것을 확인할 쿼리
select * 
from 사원
where 이름 in('김레몬', '박바나나', '정오렌지');

select * from 사원;

-- on duplicate key update : 레코드가 없다면 새로이 추가하고, 이미 있으면 데이터를 변경하는 경우에 사용한다.
-- ex)7-10 91번 제품이 없다면 레코드를 추가하고, 이미 존재하면 값을 변경하라
-- 제품번호 : 91, 제품명 : 연어피클핫소스, 단가 : 6000, 재고 : 50
insert into 제품(제품번호, 제품명, 단가, 재고)
values(91, '연어피클핫소스', 6000, 50)
on duplicate key update
제품명 = '연어피클핫소스', 단가 = 7000, 재고 = 70;

select * 
from 제품
where 제품번호 = 91;

-- insert into select문
-- ex)7-11 고객주문요약 테이블을 만들고, 레코드를 추가하라
create table 고객주문요약
(
고객번호 char(5) primary key
,고객회사명 varchar(50)
,주문건수 int
,최종주문일 date
);

-- ex)7-11 고객주문요약 테이블을 만들고, 레코드를 추가하라
insert into 고객주문요약
select 고객.고객번호
,고객회사명
,count(*)
,max(주문일)
from 고객
,주문
where 고객.고객번호 = 주문.고객번호
group by 고객.고객번호
,고객회사명;

select * from 고객주문요약;

-- update select
-- ex)7-12 제품번호가 91인 제품의 단가를 '소스' 제품들의 평균단가로 변경하라
update 제품
set 단가 = (
select *
from(
select avg(단가)
from 제품
where 제품명 like '%소스%'
) as t
)
where 제품번호 = 91;

select * from 제품;

-- ex)7-13 한 번이라도 주문한 적이 있는 고객의 마일리지를 10% 인상하시오
update 고객
,(
select distinct 고객번호
from 주문
) as 주문고객
set 마일리지 = 마일리지 * 1.1
where 고객.고객번호 in (주문고객.고객번호);

-- 결과 확인을 위한 select문
select *
from 고객
where 고객번호 in
(select distinct 고객번호 from 주문);

-- ex)7-14 마일리지등급이 "S"인 고객의 마일리지에 1000점씩 추가하시오.
-- ANSI SQL 표현
update 고객
inner join 마일리지등급
on 마일리지 between 하한마일리지 and 상한마일리지
set 마일리지 = 마일리지 + 1000
where 등급명 = 'S';

-- Non-ANSI SQL 표현
update 고객
,마일리지등급
set 마일리지 = 마일리지 + 1000
where 마일리지 between 하한마일리지 and 상한마일리지
and 등급명 = 'S';

-- 결과 확인을 위한 select문
select 고객번호
,고객회사명
,마일리지
from 고객
inner join 마일리지등급
on 마일리지 between 하한마일리지 and 상한마일리지
where 등급명 = 'S';

-- delete selest : delete문에서도 삭제할 레코드를 찾기 위해 서브쿼리를 사용한다.
-- ex)7-15 주문 테이블에는 존재하나 주문세부 테이블에는 존재하지 않는 주문번호를 주문 테이블에서 삭제하라
delete from 주문
where 주문번호 not in (
select distinct 주문번호
from 주문세부
);

select * from 주문세부;

-- ex)7-16 주문번호 'H0248'에 대한 내역을 주문 테이블과 주문세부 테이블에서 모두 삭제하라. 하나의 문장으로 작업을 수행해라
-- 주문 테이블, 주문세부 테이블에  주문번호 'H0248'를 동시에 삭제하기

-- ANSI SQL 표햔
select *
from 주문
where 주문번호  = 'H0248';

-- Non-ANSI SQL 표햔

-- ex)7-17 한 번도 주문한 적이 없는 고객의 정보를 삭제하라
-- 한 번도 주문한 적이 없는 고객 검색
select 고객.*
from 고객
left outer join 주문
on 고객.고객번호 = 주문.고객번호
where 주문.고객번호 is null;

-- 주문한 적이 없는 고객의 레코드를 고객 테이블에서 삭제하기
delete 고객
from 고객
left join 주문
on 고객.고객고객번호 = 주문.고객번호
where 주문.고객번호 is null;

-- 삭제된 고객 정보가 고객 테이블에 존재하는지 확인하기
select *
from 고객
where 고객번호 in('BOOZA', 'RISPA', 'SSAFI','TTRAN');

-- ex)8-1 한빛학사 데이터 베이스 생성
create database 한빛학사;

-- ex)8-2 다음과 같이 한빛학사 데이터베이스에 학과 테이블을 생성하고, 레코드 3건을 삽입하라
create table 학과
(
학과번호 char(2)
,학과명 varchar(20)
,학과장명 varchar(20)
);

-- 학과 테이블에 3건 레코드를 삽입
insert into 학과
values('AA', '컴퓨터공학과', '배경민')
,('BB', '소프트웨어학과', '김남준')
,('CC', '디자인융합학과', '김남준');

select * from 학과;

-- ex)8-3 다음과 같이 학생 테이블을 생성하고, 레코드 3건을 삽입하라
create table 학생
(
학번 char(5)
,이름 varchar(20)
,생일 date
,연락처 varchar(20)
,학과번호 char(2)
);

-- 학생 데이터 표를 참고해 3건의 레코드 삽입
insert into 학생
value('S0001','이윤주','2020-01-30','01033334444','AA')
,('S0001','이승은','2021-02-23', null,'AA')
,('S0003','백재용','2018-03-31', '0107778888','DD');

select * from 학생;

-- ex)8-4 학생 테이블을 사용해 휴학생 테이블을 생성하라, 이때 데이터는 복사하지 않고, 구조만 복사하라
create table 휴학생 as
SELECT *
FROM 학생
WHERE 1 = 2;

select * from 휴학생;

-- ex)8-5 휘트니스센터 회원을 관리하는 테이블을 만들어라. 이때 체질량 지수가 자동 계산되어 저장되도록 GENERATED 컬럼으로 설정하라
-- 회원 테이블 생성
create table 회원
(
아이디 varchar(20) primary key
,회원명 varchar(20)
,키 INT
,몸무게 int
,체질량지수 decimal(4,1) as (몸무게 / power(키 / 100, 2)) stored -- 몸무게 / power <- 제곱, stored : 실제컬럼으로 존재시켜라
);

insert into 회원(아이디, 회원명, 키, 몸무게)
values('APPLE', '김사과', 178, 70);

select * from 회원;