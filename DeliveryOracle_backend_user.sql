-- user

-- 기존 테이블 존재하면 삭제
DROP TABLE IF EXISTS user;

select * from user;

-- user : 회원 테이블
CREATE TABLE `user` (
`NO` int not null AUTO_INCREMENT,
`USER_ID` varchar(100) NOT NULL,
`USER_PW` varchar(200) NOT NULL,
`NAME` varchar(100) not null,
`EMAIL` varchar(200) default null,
`REG_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
`UPD_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
`ENABLED` int DEFAULT 1,
PRIMARY KEY (`NO`)
) COMMENT = '회원';

-- 기본 데이터
-- NoOpPasswordEncoder - 암호화 없이 로그인
-- 사용자useruser_auth
INSERT INTO user ( user_id, user_pw, name, email )
VALUES ( 'user', '123456', '사용자', 'user@mail.com' );

-- 관리자
INSERT INTO user ( user_id, user_pw, name, email )
VALUES ( 'admin', '123456', '관리자', 'admin@mail.com' );


-- BCryptPasswordEncoder - 암호화 시
-- 사용자
INSERT INTO user ( user_id, user_pw, name, email )
VALUES ( 'user', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자', 'user@mail.com' );

-- 관리자
INSERT INTO user ( user_id, user_pw, name, email )
VALUES ( 'admin', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '관리자', 'admin@mail.com' );

-- user_auth

-- 기존 테이블 존재하면 삭제
DROP TABLE IF EXISTS user_auth;

select * from user_auth;

-- user_auth : 권한 테이블
CREATE TABLE `user_auth` (
      auth_no int NOT NULL AUTO_INCREMENT       -- 권한번호
    , user_id varchar(100) NOT NULL             -- 아이디
    , auth varchar(100) NOT NULL                -- 권한 (USER, ADMIN, ...)
    , PRIMARY KEY(auth_no)
);

-- 기본 데이터
-- 사용자
-- * 권한 : USER
INSERT INTO user_auth ( user_id,  auth )
VALUES ( 'user', 'ROLE_USER' );

-- 관리자
-- * 권한 : USER, ADMIN
INSERT INTO user_auth ( user_id,  auth )
VALUES ( 'admin', 'ROLE_USER' );

INSERT INTO user_auth ( user_id,  auth )
VALUES ( 'admin', 'ROLE_ADMIN' );

--   XXX  ➡ ROLE_XXX  변환
UPDATE user_auth
SET auth = CONCAT('ROLE_', auth)
WHERE auth NOT LIKE 'ROLE_%';