drop table if exists message;
drop table if exists chat_room_member;
drop table if exists chat_room;
drop type if exists room_type;
drop table if exists "user";
drop extension pgcrypto;

create extension pgcrypto;

create table "user" (
    id         serial primary key,
    username   varchar(50)             not null,
    login      varchar(50) unique      not null,
    password   char(60)                not null,
    created_at timestamp default now() not null
);

create type room_type as enum ('private', 'public');
create table chat_room (
    id         serial primary key,
    name       varchar(50)             not null,
    room_type  room_type               not null,
    created_at timestamp default now() not null
);

create table chat_room_member (
    chat_room_id int references chat_room (id),
    user_id      int references "user" (id),
    joined_at    timestamp default now() not null,
    primary key (chat_room_id, user_id)
);

create table message (
    id           serial primary key,
    chat_room_id int references chat_room (id),
    sent_by      int references "user" (id),
    content      text                    not null,
    sent_at      timestamp default now() not null
);
