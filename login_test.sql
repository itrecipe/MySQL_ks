create database login_test;

use login_test;

create table login(
id bigint auto_increment primary key,
username varchar(20) not null unique,
password varchar(20) not null
);

select * from login;

drop table login;

insert into login values(1, "user", "1234");