-- 트리거 부분만 따로 뗴어냄

-- 새로운 테이블과 트리거 생성
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

DELIMITER //

CREATE TRIGGER before_store_update
BEFORE UPDATE ON StoreRegistration
FOR EACH ROW
BEGIN
    INSERT INTO StoreRegistrationAudit (
        store_id, owner_id, store_name, store_address, store_description, 
        store_image, approval_status, approval_date, modification_date, 
        store_x, store_y, store_ca, change_type, change_date
    ) VALUES (
        OLD.store_id, OLD.owner_id, OLD.store_name, OLD.store_address, OLD.store_description, 
        OLD.store_image, OLD.approval_status, OLD.approval_date, OLD.modification_date, 
        OLD.store_x, OLD.store_y, OLD.store_ca, 'UPDATE', NOW()
    );
END;
//

CREATE TRIGGER before_store_delete
BEFORE DELETE ON StoreRegistration
FOR EACH ROW
BEGIN
    INSERT INTO StoreRegistrationAudit (
        store_id, owner_id, store_name, store_address, store_description, 
        store_image, approval_status, approval_date, modification_date, 
        store_x, store_y, store_ca, change_type, change_date
    ) VALUES (
        OLD.store_id, OLD.owner_id, OLD.store_name, OLD.store_address, OLD.store_description, 
        OLD.store_image, OLD.approval_status, OLD.approval_date, OLD.modification_date, 
        OLD.store_x, OLD.store_y, OLD.store_ca, 'DELETE', NOW()
    );
END;
//