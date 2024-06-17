-- user (회원)

-- 기존 테이블 존재하면 삭제
DROP TABLE IF EXISTS UserInformation;

-- UserInformation : 유저 정보를 담고 있는 테이블
CREATE TABLE UserInformation (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(30) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Name VARCHAR(10) NOT NULL,
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    modification_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- UserInformation 테이블 전체 조회
select * from UserInformation;

-- 기본 데이터
-- NoOpPasswordEncoder - 암호화 없이 로그인 테스트 하기

-- 사용자 정보
INSERT INTO UserInformation ( email, password, name )
VALUES ( 'user', '1234', '사용자' );

-- 관리자 정보
INSERT INTO UserInformation ( email, password, name)
VALUES ( 'admin', '1234', '관리자' );

-------------------------------------------------------------

-- BCryptPasswordEncoder - 암호화 후 로그인 테스트 하기

-- 사용자
INSERT INTO UserInformation ( email, password, name )
VALUES ( 'user1', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '사용자1' );

-- 관리자
INSERT INTO UserInformation ( email, password, name )
VALUES ( 'admin', '$2a$12$TrN..KcVjciCiz.5Vj96YOBljeVTTGJ9AUKmtfbGpgc9hmC7BxQ92', '관리자1' );

-- LOGIN 회원 ID(EMAIL) 조회 쿼리
        SELECT 
        u.user_id
        ,email
        ,password
        ,name
        ,registration_date
        ,modification_date
        FROM userinformation u LEFT OUTER JOIN userinfo_auth auth
        ON u.EMAIL = auth.user_id
        WHERE u.email = 'test11';

------------------------------------------------------------------------------------------------------------------

-- userinfo_auth : UserInfomation의 권한을 관리하는 테이블

drop table userinfo_auth;

CREATE TABLE `userinfo_auth` (
      auth_no int NOT NULL AUTO_INCREMENT       -- 권한번호
    , user_id varchar(100) NOT NULL             -- 아이디
    , auth varchar(100) NOT NULL                -- 권한 (USER, ADMIN, ...)
    , PRIMARY KEY(auth_no)
);

SELECT * FROM userinfo_auth;

-- 기본 데이터
-- 사용자
-- * 권한 : USER
INSERT INTO userinfo_auth ( user_id, auth )
VALUES ( 'user', 'ROLE_USER' );

-- 관리자
-- * 권한 : USER, ADMIN
INSERT INTO userinfo_auth ( user_id, auth )
VALUES ( 'user', 'ROLE_USER' );

INSERT INTO userinfo_auth ( user_id, auth )
VALUES ( 'admin', 'ROLE_ADMIN' );

-- XXX ➡ ROLE_XXX 변환
UPDATE userinfo_auth
SET auth = CONCAT('ROLE_', auth)
WHERE auth NOT LIKE 'ROLE_%';

--------------------------------------------------------------------
-- 업체 & 관리자 (store & admin)

-- 업체 & 관리자 등록
CREATE TABLE StoreRegistration (
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    owner_id INT NOT NULL,
    store_name VARCHAR(30) NOT NULL,
    store_address VARCHAR(50) NOT NULL,
    store_description TEXT NULL,
    store_image VARCHAR(100) NULL,
    approval_status TINYINT(1) NOT NULL DEFAULT 0,
    approval_date DATETIME NULL,
    modification_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    store_x DECIMAL(15, 12) NOT NULL,
    store_y DECIMAL(15, 12) NOT NULL,
    store_ca VARCHAR(20) NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES UserInformation(user_id),
    UNIQUE (owner_id)
);

-- 업체 정보
CREATE TABLE StoreInformation (
    store_id INT NOT NULL,
    menu_name VARCHAR(30) NOT NULL,
    menu_price INT NOT NULL,
    menu_image VARCHAR(100) NULL,
    visibility_status TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (store_id, menu_name),
    FOREIGN KEY (store_id) REFERENCES StoreRegistration(store_id)
);

---------------------------------------------------------------------
-- 주문정보 테이블

CREATE TABLE OrderInformation (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    store_id INT NOT NULL,
    order_details VARCHAR(255) NOT NULL,
    total_price INT NOT NULL,
    order_approval_status TINYINT(1) NOT NULL DEFAULT 0,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES UserInformation(user_id),
    FOREIGN KEY (store_id) REFERENCES StoreRegistration(store_id)
);

select * from orderinformation;
select * from storeregistration;
select * from storeinformation;
