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
CREATE TABLE `userinfo_auth` (
      auth_no int NOT NULL AUTO_INCREMENT       -- 권한번호
    , user_id varchar(100) NOT NULL             -- 아이디
    , auth varchar(100) NOT NULL                -- 권한 (USER, ADMIN, ...)
    , PRIMARY KEY(auth_no)
);

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
-- 업체 및 관리자 파트 (store & admin)

-- 업체 & 관리자 등록
CREATE TABLE StoreRegistration (
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    owner_id INT NOT NULL,
    store_name VARCHAR(30) NOT NULL,
    store_address VARCHAR(50) NOT NULL,
    store_description TEXT NULL,
    store_image VARCHAR(255) NULL,
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
    menu_image VARCHAR(255) NULL,
    visibility_status TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (store_id, menu_name)
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
    user_x DECIMAL(15, 12) NOT NULL,
    user_y DECIMAL(15, 12) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES UserInformation(user_id)
);

-- < Store & Admin 파트 : 결제 내역 조회 기능 > => orderinformation 테이블의 담긴 store_id가 5인 결제 내역과 각종 세부 정보들을 추출하기 위한 쿼리 작성
SELECT o.order_id, o.customer_id, o.store_id, o.order_details, o.total_price, o.user_x, o.user_y,
       u.Email AS email, u.Name AS name
FROM OrderInformation o
JOIN UserInformation u ON o.customer_id = u.user_id
WHERE o.store_id = 5 AND order_approval_status = 4;

-- < Store & Admin 파트 : 현재 매출 내역 기능 조회하기 >
SELECT store_id, order_details, total_price, order_date, order_approval_status
FROM OrderInformation
WHERE store_id = 5 AND order_approval_status = 3;

----------------------------------------------------------------------------------
-- 라이더 테이블
CREATE TABLE RiderDelivery (
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    store_id INT NOT NULL,
    store_name VARCHAR(30) NOT NULL,
    store_owner_email VARCHAR(30) NOT NULL,
    rider_id INT NOT NULL,
    distance_to_store DECIMAL(15, 12) NOT NULL,
    distance_to_user DECIMAL(15, 12) NOT NULL,
    delivery_price INT NOT NULL, 
    delivery_status TINYINT(1) NOT NULL DEFAULT 0,
        store_x DECIMAL(15, 12) NOT NULL,
    store_y DECIMAL(15, 12) NOT NULL,
        user_x DECIMAL(15, 12) NOT NULL,
    user_y DECIMAL(15, 12) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    
    FOREIGN KEY (order_id) REFERENCES OrderInformation(order_id),
    FOREIGN KEY (rider_id) REFERENCES UserInformation(user_id)
);

-- 댓글, 대댓글 테이블
CREATE TABLE Comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    store_id INT NOT NULL,
    author_id INT NOT NULL,
    author_name VARCHAR(20) NOT NULL,
    content TEXT NOT NULL,
    rating TINYINT CHECK (rating BETWEEN 0 AND 5),
    visibility_status TINYINT(1) NOT NULL DEFAULT 1,
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modification_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    reply_id INT,
    depth TINYINT CHECK (depth IN (1, 2)),
    FOREIGN KEY (author_id) REFERENCES UserInformation(user_id)
);
 
-- 댓글 신고 테이블
CREATE TABLE Reports (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    comment_id INT NOT NULL,
    comment_author_id INT NOT NULL,
    report_status TINYINT(1) NOT NULL DEFAULT 0,
    report_text VARCHAR(100) NOT NULL,
    reporter_id INT NOT NULL,
    report_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 업체 등록 정보에 대한 변경 이력을 관리해줄 테이블
CREATE TABLE StoreRegistrationAudit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    store_id INT,
    owner_id INT,
    store_name VARCHAR(30),
    store_address VARCHAR(50),
    store_description TEXT,
    store_image VARCHAR(100),
    approval_status TINYINT(1),
    approval_date DATETIME,
    modification_date TIMESTAMP,
    store_x DECIMAL(15, 12),
    store_y DECIMAL(15, 12),
    store_ca VARCHAR(20),
    change_type ENUM('UPDATE', 'DELETE'),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- StoreRegistration 테이블에 대한 update & delete 작업을 감지해 변경 내역을 StoreRegistrationAudit
-- 테이블에 기록해주는 MYSQL 트리거 적용
-- 트리거란? 특정 이벤트가 발생되었을 때 수정된 내역을 자동으로 감지하여 실행되는 일종의 DB 코드라고 한다.
-- 기존 트리거 삭제
-- 테이블 존재 여부 확인
SHOW TABLES;

-- 업체(가게) 신고기능
CREATE TABLE StoreReports (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    store_id INT NOT NULL,
    report_status TINYINT(1) NOT NULL DEFAULT 0,
    report_text VARCHAR(100) NOT NULL,
    reporter_id INT NOT NULL,
    report_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 계좌 정보를 담고 있는 테이블
CREATE TABLE account (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    owner_id INT,
    owner_name VARCHAR(10),
    owner_email VARCHAR(30),
    account_status TINYINT(1),
    account_amount INT,
    approval_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES UserInformation(user_id)
);

-- 계좌 입출금 상태
CREATE TABLE accountstatus (
    num INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    amount INT,
    type VARCHAR(10),
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES account(account_id)
);

-- 순위 및 포인트
CREATE TABLE rankpoint (
	Rating VARCHAR(20) primary key,
	score int
);

-- rankpoint에 집어 넣을 값
insert into rankpoint (Rating,score) value("Bronze",5000);
insert into rankpoint (Rating,score) value("Silver",10000);
insert into rankpoint (Rating,score) value("Gold",50000);
insert into rankpoint (Rating,score) value("Platinum",100000);

-- 방문자 테이블
  CREATE TABLE visitors (
    email VARCHAR(255) NOT NULL,
    visit_date DATE NOT NULL,
    PRIMARY KEY (email, visit_date)
);

-- 테이블 삭제 (존재할 경우에만)
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS orderinformation;
DROP TABLE IF EXISTS riderdelivery;
DROP TABLE IF EXISTS storeinformation;
DROP TABLE IF EXISTS storeregistration;
DROP TABLE IF EXISTS userinfo_auth;
DROP TABLE IF EXISTS userinformation;
DROP TABLE IF EXISTS StoreRegistrationAudit;

select * from comments;
select * from userinformation;
select * from orderinformation;
select * from storeregistration;
select * from rankpoint;
select * from userinfo_auth;
select * from account;
select * from accountstatus;
select * from storereports;