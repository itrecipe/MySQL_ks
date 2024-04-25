/*Ch03 예제*/
/*예제3-1*/
SELECT CHAR_LENGTH('HELLO')
      ,LENGTH('HELLO')
      ,CHAR_LENGTH('안녕')
      ,LENGTH('안녕');

/*예제3-2*/
SELECT CONCAT('DREAMS', 'COME', 'TRUE')
      ,CONCAT_WS('-', '2023', '01', '29');

/*예제3-3*/
SELECT LEFT('SQL 완전정복', 3)
      ,RIGHT('SQL 완전정복', 4)
      ,SUBSTR('SQL 완전정복', 2, 5)
      ,SUBSTR('SQL 완전정복', 2); 

/*예제3-4*/
SELECT SUBSTRING_INDEX('서울시 동작구 흑석로', ' ', 2)
      ,SUBSTRING_INDEX('서울시 동작구 흑석로', ' ', -2);

/*예제3-5*/
SELECT LPAD('SQL', 10, '#')
      ,RPAD('SQL', 5, '*');

/*예제3-6*/
SELECT LENGTH(LTRIM(' SQL '))
	  ,LENGTH(RTRIM(' SQL '))
      ,LENGTH(TRIM(' SQL '));

/*예제3-7*/
SELECT TRIM(BOTH 'abc' FROM 'abcSQLabcabc')
      ,TRIM(LEADING 'abc' FROM 'abcSQLabcabc')
      ,TRIM(TRAILING 'abc' FROM 'abcSQLabcabc');

/*예제3-8*/
SELECT FIELD('JAVA', 'SQL', 'JAVA', 'C')
      ,FIND_IN_SET('JAVA', 'SQL,JAVA,C')
      ,INSTR('네 인생을 살아라', '인생')
      ,LOCATE('인생', '네 인생을 살아라');

/*예제3-9*/
SELECT ELT(2, 'SQL', 'JAVA', 'C');

/*예제3-10*/
SELECT REPEAT('*', 5);

/*예제3-11*/
SELECT REPLACE('010.1234.5678', '.', '-');

/*예제3-12*/
SELECT REVERSE('OLLEH');

/*예제3-13*/
SELECT CEILING(123.56)
      ,FLOOR(123.56)
      ,ROUND(123.56)
      ,ROUND(123.56, 1)
      ,TRUNCATE(123.56, 1);

/*예제3-14*/
SELECT ABS(-120)
      ,ABS(120)
      ,SIGN(-120)
      ,SIGN(120);

/*예제3-15*/
SELECT MOD(203, 4)
      ,203 % 4
      ,203 MOD 4;

/*예제3-16*/
SELECT POWER(2, 3)
      ,SQRT(16)
      ,RAND()
      ,RAND(100)
      ,ROUND(RAND() * 100);

/*예제3-17*/
SELECT NOW()
      ,SYSDATE()
      ,CURDATE()
      ,CURTIME();

/*예제3-18*/
SELECT NOW()
      ,YEAR(NOW())
      ,QUARTER(NOW())
      ,MONTH(NOW())
      ,DAY(NOW())
      ,HOUR(NOW())
      ,MINUTE(NOW())
      ,SECOND(NOW());

/*예제3-19*/
SELECT NOW()
      ,DATEDIFF('2025-12-20', NOW())
      ,DATEDIFF(NOW(), '2025-12-20')
      ,TIMESTAMPDIFF(YEAR, NOW(), '2025-12-20')
      ,TIMESTAMPDIFF(MONTH, NOW(), '2025-12-20')
      ,TIMESTAMPDIFF(DAY, NOW(), '2025-12-20');
      
/*예제3-20*/
SELECT NOW()
      ,ADDDATE(NOW(), 50)
      ,ADDDATE(NOW(), INTERVAL 50 DAY)
      ,ADDDATE(NOW(), INTERVAL 50 MONTH)
      ,SUBDATE(NOW(), INTERVAL 50 HOUR);

/*예제3-21*/
SELECT NOW()
      ,LAST_DAY(NOW())
      ,DAYOFYEAR(NOW())
      ,MONTHNAME(NOW())
      ,WEEKDAY(NOW());

/*예제3-22*/
SELECT CAST('1' AS UNSIGNED)
      ,CAST(2 AS CHAR(1))
      ,CONVERT('1', UNSIGNED)
      ,CONVERT(2, CHAR(1));

/*예제3-23*/
SELECT IF(12500 * 450 > 5000000, '초과달성', '미달성');

/*예제3-24*/
SELECT IFNULL(1, 0)
      ,IFNULL(NULL, 0)
      ,IFNULL(1/0, 'OK');

/*예제3-25*/
SELECT NULLIF(12 * 10, 120)
	  ,NULLIF(12 * 10, 1200);

/*예제3-26*/
SELECT CASE WHEN 12500 * 450 > 5000000 THEN '초과달성'
WHEN 2500 * 450 > 4000000 THEN '달성'
ELSE '미달성'
END;