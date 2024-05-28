/* MySQL에서는 시퀀스 대신 AUTO_INCREMENT를 사용하기 때문에 시퀀스 생성 및 삭제는 필요 없습니다. */

/* tbl_board 테이블 생성 */
CREATE TABLE tbl_board (
  bno INT AUTO_INCREMENT, /* 자동 증가하는 bno 컬럼 */
  title VARCHAR(200) NOT NULL, /* VARCHAR2 대신 VARCHAR 사용 */
  content VARCHAR(2000) NOT NULL,
  writer VARCHAR(50) NOT NULL,
  regdate DATETIME DEFAULT CURRENT_TIMESTAMP, /* 작성 날짜, Oracle의 SYSDATE 대신 CURRENT_TIMESTAMP 사용 */
  updatedate DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, /* 업데이트 날짜, 자동으로 현재 시간으로 업데이트 */
  PRIMARY KEY (bno) /* bno를 기본 키로 설정 */
);

/* tbl_board 테이블 전체 조회 */
SELECT * FROM tbl_board;

/* tbl_board 테이블 삭제 */
DROP TABLE tbl_board;

/* tbl_board 테이블에 더미 데이터 삽입 */
/* 주의: 테이블을 삭제한 직후에는 이 명령을 실행할 수 없으니, 테이블을 다시 생성한 후 실행해야 합니다. */
INSERT INTO tbl_board (title, content, writer) VALUES ('테스트 제목', '테스트 내용', 'user00');
/* MySQL에서는 AUTO_INCREMENT 속성이 지정된 bno는 자동으로 값을 증가시키므로, 명시적으로 지정하지 않습니다. */

/* 데이터 변경사항(commit) 확정 */
COMMIT;
/* MySQL 트랜잭션에서도 commit을 사용하여 변경사항을 확정합니다. */

/* tbl_board 테이블에서 bno 기준 내림차순으로 데이터 조회 */
SELECT * FROM tbl_board ORDER BY bno DESC;

/* 특이한 조건으로 정렬을 시도하나, 실제 사용 시에는 명확한 의도를 가지고 사용해야 합니다. */
SELECT * FROM tbl_board ORDER BY bno + 1 DESC;

/* 인덱스를 이용한 데이터 검색 (MySQL에서의 힌트 사용 예시) */
SELECT * FROM tbl_board FORCE INDEX (PRIMARY) ORDER BY bno;
/* MySQL에서는 FORCE INDEX 힌트를 사용하여 특정 인덱스의 사용을 강제할 수 있습니다. */