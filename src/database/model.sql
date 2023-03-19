create database servicecontrol;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

drop table if exists users cascade;
create table users(
    user_id varchar DEFAULT REPLACE(uuid_generate_v4()::text, '-', '' ) primary key,
    user_firstname varchar(24) not null,
    user_lastname varchar(24) not null,
    user_email varchar(64) not null,
    user_password varchar(24) not null,
    user_role text not null default 'staff',
    user_delete boolean not null default false,
    user_createdat TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

drop table if exists branches cascade;
create table branches(
    branch_id varchar DEFAULT REPLACE(uuid_generate_v4()::text, '-', '' ) primary key,
    branch_name varchar(64) not null,
    user_id varchar references users(user_id),
    branch_createdat TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

drop table if exists branchworker cascade;
create table branchworker(
    branchworker_id varchar DEFAULT REPLACE(uuid_generate_v4()::text, '-', '' ) primary key,
    branch_id varchar references branches(branch_id),
    user_id varchar references users(user_id),
    branchworker_createdat TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

drop table if exists clients cascade;
create table clients(
    client_id text primary key,
    client_status smallint not null default 1,
    client_firstname varchar(24) not null,
    client_lastname varchar(24) not null,
    client_phone_number_first varchar(13) not null,
    client_phone_number_second varchar(13) not null,
    client_about text not null,
    client_address text not null,
    client_age varchar(11) not null,
    client_deleter varchar references users(user_id),
    branch_id varchar references branches(branch_id),
    user_id varchar references users(user_id),
    client_createdat TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

drop table if exists devicetypes cascade;
create table devicetypes(
    devicetype_id varchar DEFAULT REPLACE(uuid_generate_v4()::text, '-', '' ) primary key,
    devicetype_name varchar(24) not null,
    branch_id varchar references branches(branch_id),
    devicetype_createdat TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

drop table if exists orders cascade;
create table orders(
    order_id text primary key,
    order_status smallint not null default 1,
    order_device_type varchar references devicetypes(devicetype_id),
    order_device_name text not null,
    order_device_bug text not null,
    order_over_time text,
    order_price text not null,
    order_about text not null,
    order_finished text,
    order_finisher varchar references users(user_id),
    order_deleter varchar references users(user_id),
    client_id varchar references clients(client_id),
    branch_id varchar references branches(branch_id),
    order_createdat TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);