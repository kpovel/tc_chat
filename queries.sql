insert into "user" (login, password) values ('kpovel', crypt('deeznuts', gen_salt('bf')));

select * from "user" where login = 'kpovel' and password = crypt('deeznuts', password);

