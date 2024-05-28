/* tbl_attach 테이블 생성 */
CREATE TABLE tbl_attach (
  uuid VARCHAR(100) NOT NULL, /* VARCHAR2 대신 VARCHAR 사용 */
  uploadPath VARCHAR(200) NOT NULL,
  fileName VARCHAR(100) NOT NULL,
  filetype CHAR(1) DEFAULT '1',
  bno INT /* MySQL에서는 NUMBER 대신 INT 사용 */
);

/* tbl_attach 테이블 전체 조회 */
SELECT * FROM tbl_attach;

/* tbl_board 테이블 전체 조회 */
SELECT * FROM tbl_board;

/* tbl_attach 테이블 삭제 */
/* 주의: 아래 ALTER TABLE 명령어가 실행되기 전에 tbl_attach 테이블을 삭제하면 안 됩니다. */
/* DROP TABLE tbl_attach; */

/* 제약조건으로 uuid를 기본 키로 설정 */
/* 테이블을 삭제하는 명령이 있으므로, 제약조건을 추가하기 전에 다시 테이블을 생성하는 단계가 필요합니다. */
/* 테이블을 재생성하는 코드는 생략되었습니다. */
ALTER TABLE tbl_attach
ADD CONSTRAINT pk_attach PRIMARY KEY (uuid);

/* 외래키 설정: tbl_attach의 bno 컬럼과 tbl_board의 bno 컬럼 사이의 관계 설정 */
ALTER TABLE tbl_attach
ADD CONSTRAINT fk_board_attach FOREIGN KEY (bno) REFERENCES tbl_board(bno);

/* MySQL에서는 데이터 변경 사항(commit) 확정을 자동으로 처리합니다. */
/* 별도로 COMMIT 명령을 사용할 필요가 없습니다, 특히 AUTO_COMMIT 모드가 활성화되어 있을 경우. */
/* 그러나, 트랜잭션을 명시적으로 관리하려는 경우에는 필요할 수 있습니다. */
