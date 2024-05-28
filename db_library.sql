create database db_library;
use db_library;

create database db_library_real;
use db_library_real;

CREATE TABLE tbl_admin_member(
	a_m_no		INT 	AUTO_INCREMENT, 
	a_m_approval	INT	NOT NULL DEFAULT 0, 
	a_m_id		VARCHAR(20) 	NOT NULL, 
	a_m_pw		VARCHAR(100) 	NOT NULL, 
	a_m_name	VARCHAR(20) 	NOT NULL, 
	a_m_gender	CHAR(1) 	NOT NULL, 
	a_m_part	VARCHAR(20) 	NOT NULL,
	a_m_position	VARCHAR(20) 	NOT NULL,
	a_m_mail	VARCHAR(50) 	NOT NULL, 
	a_m_phone	VARCHAR(20) 	NOT NULL, 
	a_m_reg_date 	DATETIME,
	a_m_mod_date	DATETIME, 
	PRIMARY KEY(a_m_no)
	);
    
select * from tbl_admin_member;

delete from tbl_admin_member where a_m_no = 1;

drop table tbl_admin_member;

create table tbl_book(
	b_no int auto_increment,
	b_thumbnail varchar(100),
	b_name varchar(20) not null,
	b_author varchar(20) not null,
	b_publisher varchar(20) not null,
	b_publish_year varchar(20) not null,
	b_isbn varchar(20) not null,
	b_call_number varchar(20) not null,
	b_rental_able tinyint not null default 1,
	b_reg_date datetime,
	b_mod_date datetime,
	primary key(b_no)
);

drop table tbl_book;

select * from tbl_book;

create table tbl_user_member(
	u_m_no int auto_increment,
	u_m_id varchar(20) not null,
	u_m_pw varchar(100) not null,
	u_m_name varchar(20) not null,
	u_m_gender char(1) not null,
	u_m_mail varchar(50) not null,
	u_m_phone varchar(20) not null,
	u_m_reg_date datetime,
	u_m_mod_date datetime,
	primary key(u_m_no)
);

drop table tbl_user_member;

select * from tbl_user_member;

create table tbl_rental_book(
	rb_no int auto_increment,
    b_no int,
    u_m_no int,
    rb_start_date datetime,
    rb_end_date datetime default '1000-01-01',
    rb_reg_date datetime,
    rb_mod_date datetime,
    primary key(rb_no)
);

drop table tbl_rental_book;

select * from tbl_rental_book;

create table tbl_hope_book(
	hb_no int auto_increment primary key,
	u_m_no int,
	hb_name varchar(30) not null,
	hb_author varchar(20) not null,
	hb_publisher varchar(2),
    hb_publish_year char(4),
	hb_reg_date datetime,
	hb_mod_date datetime,
	hb_result tinyint not null default 0,
	hb_result_last_date datetime
);

drop table tbl_hope_book;

select * from tbl_hope_book;