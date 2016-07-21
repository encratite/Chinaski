set client_min_messages to warning;

drop function if exists now_utc() cascade;

create function now_utc()
returns timestamp as $$
	select now() at time zone 'utc';
$$ language sql;

drop table if exists user_account cascade;

create table user_account
(
	id serial primary key,
	name text unique not null,
	password_hash bytea not null,
	registration_time timestamp not null default now_utc()
);

drop table if exists session cascade;

create table session
(
	user_id int references user_account (id),
	session_key text not null,
	last_address inet not null,
	last_access_time timestamp not null default now_utc(),
	primary key (user_id, session_key)
);

drop table if exists drink_definition cascade;

create table drink_definition
(
	id serial primary key,
	author_id int references user_account (id) not null,
	name text not null,
	alcohol_by_volume numeric not null check (alcohol_by_volume > 0),
	volume_per_unit numeric check (volume_per_unit is null or volume_per_unit > 0),
	url text,
	last_edit_time timestamp not null default now_utc()
);

drop table if exists drink cascade;

create table drink
(
	id serial primary key,
	user_id int references user_account (id) not null,
	drink_id int references drink_definition (id) not null,
	date date not null,
	units int check (units is null or units > 0),
	volume numeric check (volume is null or volume > 0),
	unique (user_id, drink_id, date),
	check (units is not null or volume is not null)
);

drop table if exists drink_review cascade;

create table drink_review
(
	id serial primary key,
	drink_id int references drink_definition (id),
	author_id int references user_account (id),
	review text not null,
	rating int not null check (rating >= 1 and rating <= 10),
	last_edit_time timestamp not null default now_utc()
);