/*ch07_문제1*/
INSERT INTO 제품
VALUES(95, '망고베리 아이스크림', '400g', 800, 30);

/*ch07_문제2*/
INSERT INTO 제품(제품번호, 제품명, 단가)
VALUES(96, '눈꽃빙수맛 아이스크림', 2000);

/*ch07_문제3*/
UPDATE 제품
SET 재고 = 30
WHERE 제품번호 = 96;

/*ch07_문제4*/
DELETE 부서
FROM 부서
LEFT JOIN 사원
ON 부서.부서번호 = 사원.부서번호
WHERE 사원.부서번호 IS NULL;
