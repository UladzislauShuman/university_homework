-- таблица пользователей, 50 000 строк, 9 колонок
create table users (
    id          bigserial primary key,
    username    varchar(64)  not null unique,
    email       varchar(128) not null,
    first_name  varchar(64)  not null,
    last_name   varchar(64)  not null,
    city        varchar(64)  not null,
    birth_date  date         not null,
    created_at  timestamptz  not null,
    bio         text         not null
);

-- заполняем через generate_series: имена, фамилии и города берём из небольших списков по кругу
insert into users (username, email, first_name, last_name, city, birth_date, created_at, bio)
select
    'user_' || g,
    'user_' || g || '@example.com',
    (array['Ivan','Anna','Pavel','Olga','Dmitry','Maria','Alexey','Elena','Sergey','Daria'])[1 + g % 10],
    (array['Ivanov','Petrova','Sidorov','Kozlova','Novikov','Morozova','Volkov','Sokolova'])[1 + g % 8],
    (array['Minsk','Brest','Grodno','Gomel','Vitebsk','Mogilev','Pinsk','Lida'])[1 + g % 7],
    date '1970-01-01' + (g * 37 % 15000),
    timestamptz '2020-01-01' + (g * 613 % 157680000) * interval '1 second',
    repeat(md5(g::text), 4)          -- ~128 символов "описания профиля"
from generate_series(1, 50000) as g;

analyze users;
