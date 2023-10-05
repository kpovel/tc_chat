drop table if exists seen_by;
drop table if exists message;
drop table if exists chat_room_member;
drop table if exists chat_room;
drop type if exists room_type;
drop table if exists "user";
drop table if exists avatar;
drop type if exists user_type;
drop extension pgcrypto;

create extension pgcrypto;

create table avatar (
    id   serial primary key,
    name varchar(60) not null
);

create type user_type as enum ('user', 'admin');
create table "user" (
    id         serial primary key,
    username   varchar(50)             not null,
    user_type  user_type               not null,
    avatar_id  serial,
    login      varchar(50) unique      not null,
    email      varchar(50) unique      not null,
    password   char(60)                not null,
    created_at timestamp default now() not null,
    last_seen  timestamp default now() not null,

    foreign key (avatar_id) references avatar (id)
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

create table seen_by (
    user_id    int references "user" (id),
    message_id int references message (id),
    seen_at    timestamp default now() not null,

    primary key (user_id, message_id)
);
