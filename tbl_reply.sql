-- tbl_reply 댓글 테이블 생성
CREATE TABLE tbl_reply (
    rno INT AUTO_INCREMENT PRIMARY KEY,
    bno INT,
    reply VARCHAR(255),
    replyer VARCHAR(50),
    replyDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- tbl_reply 테이블 전체 조회
SELECT * FROM tbl_reply;
SELECT * FROM tbl_board;

-- tbl_reply 테이블 삭제 및 시퀀스 관련 명령어 삭제
-- MySQL에서는 시퀀스 대신 AUTO_INCREMENT 속성 사용
DROP TABLE tbl_reply;
-- TRUNCATE TABLE tbl_reply; -- 이 명령어는 테이블을 먼저 삭제한 후에는 사용할 수 없습니다.

-- tbl_reply 테이블 수정, pk 걸기 -- 테이블 생성 시 이미 처리했습니다.

-- tbl_reply 테이블 수정, fk 걸기
ALTER TABLE tbl_reply ADD CONSTRAINT fk_reply_board FOREIGN KEY (bno) REFERENCES tbl_board (bno);

-- insert test
-- 시퀀스 대신 AUTO_INCREMENT 속성을 사용하므로, rno는 명시하지 않습니다.
INSERT INTO tbl_reply(bno, reply, replyer)
VALUES (1, '댓글', '작성자');

-- 인덱스 생성
CREATE INDEX idx_reply ON tbl_reply (bno DESC, rno ASC);

-- MySQL에서는 자동 커밋이 활성화되어 있으므로, 별도로 commit을 실행할 필요가 없습니다.

-- tbl_board 테이블에 replycnt 컬럼 추가, 기본값 0으로 설정
ALTER TABLE tbl_board ADD (replycnt INT DEFAULT 0);

-- 트랜잭션 설정 후 tbl_board 테이블 업데이트 쿼리
UPDATE tbl_board 
SET replycnt = (SELECT COUNT(rno) FROM tbl_reply WHERE tbl_reply.bno = tbl_board.bno);