-- create new users
insert into "user" (id, username, user_type, login, email, password)
values (1, 'first user', 'user', 'first_user', 'first_user@mail.com', '12345');

insert into "user" (id, username, user_type, login, email, password)
values (2, 'second user', 'user', 'second_user', 'second_user@mail.com', '12345');

-- create new private chat
insert into chat_room (id, name, room_type)
values (1, 'First chat', 'private');

-- join these users into "First chat"
insert into chat_room_member (chat_room_id, user_id)
values (1, 1);
insert into chat_room_member (chat_room_id, user_id)
values (1, 2);

-- Find all chats where joined user_id = 1
select *
from chat_room_member
where user_id = 1;

-- Find interlocutor username where user_id = 1 and chat_room = 1
select "user".username as interlocutor_name
from chat_room
         inner join chat_room_member on chat_room.id = chat_room_member.chat_room_id
         inner join "user" on chat_room_member.user_id = "user".id
where chat_room.id = 1
  and chat_room.room_type = 'private'
  and user_id != 1 -- this selects the interlocutor of the chat
