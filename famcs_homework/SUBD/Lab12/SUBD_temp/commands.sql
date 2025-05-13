-- Задание 2

-- сгенерированно для DBML на сайте https://dbdiagram.io/d
CREATE TABLE [Movie] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [description] varchar(255),
  [rating] int,
  [age_limit] int,
  [number_of_views] int,
  [duration] int,
  [release_year] int,
  [country_id] int,
  [website_id] int,
  [publisher_id] int,
  [director_id] int,
  [genre_id] int
)
GO

CREATE TABLE [Genre] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] varchar(255)
)
GO

CREATE TABLE [Publisher] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] varchar(255),
  [website_id] int
)
GO

CREATE TABLE [Director] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [country_id] int UNIQUE,
  [name] varchar(255),
  [description] text
)
GO

CREATE TABLE [Country] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] varchar(255)
)
GO

CREATE TABLE [Collection] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] varchar(255),
  [description] text
)
GO

CREATE TABLE [MovieCollection] (
  [collection_id] int,
  [movie_id] int
)
GO

CREATE TABLE [Website] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] varchar(255),
  [url] text
)
GO

CREATE TABLE [LocalityType] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] varchar(50),
  [code] varchar(20)
)
GO

CREATE TABLE [Locality] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [country_id] int,
  [locality_type_id] int,
  [name] varchar(255)
)
GO

CREATE TABLE [Address] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [locality_id] int,
  [street] varchar(255),
  [house] int
)
GO

CREATE TABLE [Rentaler] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] varchar(255),
  [website_id] int
)
GO

CREATE TABLE [Rentaler_Concrete] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [rentaler_id] int,
  [address_id] int,
  [phone_number] varchar(255)
)
GO

CREATE TABLE [User] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [age] int,
  [name] varchar(255)
)
GO

CREATE TABLE [UserFavoriteMovies] (
  [user_id] int,
  [movie_id] int
)
GO

CREATE TABLE [UserFavoriteGenre] (
  [genre_id] int,
  [user_id] int
)
GO

CREATE TABLE [Carrier] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [size] int,
  [name] varchar(255),
  [type_id] int
)
GO

CREATE TABLE [Type] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] varchar(255)
)
GO

CREATE TABLE [RentedCarriers] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [start_rent] time,
  [end_rent] time,
  [carrier_id] int,
  [rentaler_concrete_id] int
)
GO

CREATE TABLE [Recording_Format] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] varchar(255)
)
GO

CREATE TABLE [MovieCarrier] (
  [movie_id] int,
  [carrier_id] int,
  [recording_format_id] int
)
GO

CREATE TABLE [WatchHistory] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [movie_id] int,
  [user_id] int,
  [watched_at] datetime DEFAULT (GETDATE())
)
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Таблица сущности Фильм.
Хранит информацию о фильмах:
- количество просмотров
- описание
- рейтинг
- страна производства
- и другие метаданные
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Movie';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Таблица сущности Жанр, хранит название Жанра',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Genre';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Сущность Издатель (Дисней, Пиксар и т.п.).
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Publisher';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Таблица сущности Режиссер:
хранит в себе имя, страну происхождения
и описание режиссера
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Director';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Таблица сущности Страна: хранит название страны',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Country';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Таблица сущности Коллекция: хранит название и описание коллекции',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Collection';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Таблица, описывающая содержимое коллекций',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MovieCollection';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Таблица, описывающая Веб-сайт',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Website';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Хранит виды населенных мест (город, деревня, поселок и т.п.)',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'LocalityType';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Связывает Страну и населенный пункт (с указанием типа)',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Locality';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Хранит адрес объекта',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Address';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Компания, предоставляющая носители с фильмами в аренду.
Может иметь несколько точек по миру
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Rentaler';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Конкретная точка аренды с адресом и контактами',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Rentaler_Concrete';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Пользователь системы: имя и возраст',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'User';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Связь пользователя и понравившихся фильмов',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'UserFavoriteMovies';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Связь пользователя и предпочитаемых жанров',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'UserFavoriteGenre';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Физический носитель фильма (диск, кассета и т.д.)',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Carrier';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Типы носителей (DVD, Blu-ray, VHS и т.д.)',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Type';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'История аренды носителей',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'RentedCarriers';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Форматы записи (PAL, NTSC и т.д.)',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Recording_Format';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Связь между фильмом и его носителями',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'MovieCarrier';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'хранит информацию о просмотре фильма
',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'WatchHistory';
GO

ALTER TABLE [Movie] ADD FOREIGN KEY ([country_id]) REFERENCES [Country] ([id])
GO

ALTER TABLE [Movie] ADD FOREIGN KEY ([website_id]) REFERENCES [Website] ([id])
GO

ALTER TABLE [Movie] ADD FOREIGN KEY ([publisher_id]) REFERENCES [Publisher] ([id])
GO

ALTER TABLE [Movie] ADD FOREIGN KEY ([director_id]) REFERENCES [Director] ([id])
GO

ALTER TABLE [Movie] ADD FOREIGN KEY ([genre_id]) REFERENCES [Genre] ([id])
GO

ALTER TABLE [Publisher] ADD FOREIGN KEY ([website_id]) REFERENCES [Website] ([id])
GO

ALTER TABLE [Director] ADD FOREIGN KEY ([country_id]) REFERENCES [Country] ([id])
GO

ALTER TABLE [MovieCollection] ADD FOREIGN KEY ([collection_id]) REFERENCES [Collection] ([id])
GO

ALTER TABLE [MovieCollection] ADD FOREIGN KEY ([movie_id]) REFERENCES [Movie] ([id])
GO

ALTER TABLE [Locality] ADD FOREIGN KEY ([country_id]) REFERENCES [Country] ([id])
GO

ALTER TABLE [Locality] ADD FOREIGN KEY ([locality_type_id]) REFERENCES [LocalityType] ([id])
GO

ALTER TABLE [Address] ADD FOREIGN KEY ([locality_id]) REFERENCES [Locality] ([id])
GO

ALTER TABLE [Rentaler] ADD FOREIGN KEY ([website_id]) REFERENCES [Website] ([id])
GO

ALTER TABLE [Rentaler_Concrete] ADD FOREIGN KEY ([rentaler_id]) REFERENCES [Rentaler] ([id])
GO

ALTER TABLE [Rentaler_Concrete] ADD FOREIGN KEY ([address_id]) REFERENCES [Address] ([id])
GO

ALTER TABLE [UserFavoriteMovies] ADD FOREIGN KEY ([user_id]) REFERENCES [User] ([id])
GO

ALTER TABLE [UserFavoriteMovies] ADD FOREIGN KEY ([movie_id]) REFERENCES [Movie] ([id])
GO

ALTER TABLE [UserFavoriteGenre] ADD FOREIGN KEY ([genre_id]) REFERENCES [Genre] ([id])
GO

ALTER TABLE [UserFavoriteGenre] ADD FOREIGN KEY ([user_id]) REFERENCES [User] ([id])
GO

ALTER TABLE [Carrier] ADD FOREIGN KEY ([type_id]) REFERENCES [Type] ([id])
GO

ALTER TABLE [RentedCarriers] ADD FOREIGN KEY ([carrier_id]) REFERENCES [Carrier] ([id])
GO

ALTER TABLE [RentedCarriers] ADD FOREIGN KEY ([rentaler_concrete_id]) REFERENCES [Rentaler_Concrete] ([id])
GO

ALTER TABLE [MovieCarrier] ADD FOREIGN KEY ([movie_id]) REFERENCES [Movie] ([id])
GO

ALTER TABLE [MovieCarrier] ADD FOREIGN KEY ([carrier_id]) REFERENCES [Carrier] ([id])
GO

ALTER TABLE [MovieCarrier] ADD FOREIGN KEY ([recording_format_id]) REFERENCES [Recording_Format] ([id])
GO

ALTER TABLE [WatchHistory] ADD FOREIGN KEY ([movie_id]) REFERENCES [Movie] ([id])
GO

ALTER TABLE [WatchHistory] ADD FOREIGN KEY ([user_id]) REFERENCES [User] ([id])
GO

-- Задание 3
-- внести данные в созданные таблицы
INSERT INTO Country  VALUES 
(N'Россия'),
(N'США'),
(N'Франция'),
(N'Германия'),
(N'Япония'),
(N'Южная Корея'),
(N'Китай'),
(N'Великобритания'),
(N'Италия'),
(N'Испания'),
(N'Индия'),
(N'Бразилия');


INSERT INTO Genre (name) VALUES 
(N'Комедия'),
(N'Драма'),
(N'Боевик'),
(N'Фантастика'),
(N'Мелодрама'),
(N'Ужасы'),
(N'Триллер'),
(N'Документальный'),
(N'Анимация'),
(N'Исторический'),
(N'Фэнтези'),
(N'Криминал');

INSERT INTO Website (name, url) VALUES 
(N'КиноПоиск', N'https://www.kinopoisk.ru'),
(N'IMDb', N'https://www.imdb.com'),
(N'Rotten Tomatoes', N'https://www.rottentomatoes.com'),
(N'Film.ru', N'https://www.film.ru'),
(N'Кино-Театр.ру', N'https://www.kino-teatr.ru'),
(N'MoviePilot', N'https://www.moviepilot.de'),
(N'MyDramaList', N'https://mydramalist.com'),
(N'AsianWiki', N'https://asianwiki.com'),
(N'SensCritique', N'https://www.senscritique.com'),
(N'Metacritic', N'https://www.metacritic.com'),
(N'ReviewFilm', N'https://reviewfilm.ru'),
(N'Фильм.онлайн', N'https://film.online');

INSERT INTO Publisher (name, website_id)
SELECT P.name, id FROM (
    VALUES 
    (N'Walt Disney'),
    (N'Pixar'),
    (N'Warner Bros.'),
    (N'Universal Pictures'),
    (N'Paramount Pictures'),
    (N'Sony Pictures'),
    (N'Mosfilm'),
    (N'Lenfilm'),
    (N'Ghibli'),
    (N'CJ Entertainment'),
    (N'Netflix Studios'),
    (N'HBO')
) AS P(name)
JOIN Website ON P.name LIKE '%'
WHERE Website.id IN (SELECT TOP 12 id FROM Website);

INSERT INTO Director (name, country_id, description)
SELECT D.name, id, D.description FROM (
    VALUES 
    (N'Андрей Звягинцев', N'Россия', N'Известный российский режиссёр.'),
    (N'Кристофер Нолан', N'Великобритания', N'Автор Темного Рыцаря и Интерстеллара.'),
    (N'Квентин Тарантино', N'США', N'Стильный и харизматичный режиссёр.'),
    (N'Хаяо Миядзаки', N'Япония', N'Мастер анимации и магии.'),
    (N'Пон Джун Хо', N'Южная Корея', N'Оскароносный режиссёр Паразитов.'),
    (N'Франсуа Озон', N'Франция', N'Французская драма и психология.'),
    (N'Федерико Феллини', N'Италия', N'Классик итальянского кино.'),
    (N'Ридли Скотт', N'Великобритания', N'Знаменитый фантаст и историк.'),
    (N'Сергей Эйзенштейн', N'Россия', N'Один из родоначальников кино.'),
    (N'Тим Бёртон', N'США', N'Готический фэнтези-режиссёр.'),
    (N'Альмодовар', N'Испания', N'Испанская страсть на экране.'),
    (N'Андрей Тарковский', N'Россия', N'Философия, пространство и время.')
) AS D(name, country, description)
JOIN Country ON Country.name = D.country;


INSERT INTO Movie (description, rating, age_limit, number_of_views, duration, release_year, country_id, website_id, publisher_id, director_id, genre_id)
VALUES
(N'Фантастический фильм о будущем.', 9, 16, 1500000, 120, 2022, 
  (SELECT id FROM Country WHERE name = N'США'),
  (SELECT id FROM Website WHERE name = N'IMDb'),
  (SELECT id FROM Publisher WHERE name = N'Warner Bros.'),
  (SELECT id FROM Director WHERE name = N'Кристофер Нолан'),
  (SELECT id FROM Genre WHERE name = N'Фантастика')),

(N'Драма о семье, переживающей кризис.', 8, 12, 500000, 110, 2021,
  (SELECT id FROM Country WHERE name = N'Россия'),
  (SELECT id FROM Website WHERE name = N'КиноПоиск'),
  (SELECT id FROM Publisher WHERE name = N'Mosfilm'),
  (SELECT id FROM Director WHERE name = N'Андрей Звягинцев'),
  (SELECT id FROM Genre WHERE name = N'Драма')),

(N'Комедия о студентках, которые меняют свою жизнь.', 7, 12, 800000, 95, 2020, 
  (SELECT id FROM Country WHERE name = N'Великобритания'),
  (SELECT id FROM Website WHERE name = N'Rotten Tomatoes'),
  (SELECT id FROM Publisher WHERE name = N'Paramount Pictures'),
  (SELECT id FROM Director WHERE name = N'Гай Ричи'),
  (SELECT id FROM Genre WHERE name = N'Комедия')),

(N'Трогательная история любви на фоне войны.', 8, 16, 700000, 130, 2019, 
  (SELECT id FROM Country WHERE name = N'Франция'),
  (SELECT id FROM Website WHERE name = N'Film.ru'),
  (SELECT id FROM Publisher WHERE name = N'Universal Pictures'),
  (SELECT id FROM Director WHERE name = N'Жан-Пьер Жене'),
  (SELECT id FROM Genre WHERE name = N'Мелодрама')),

(N'Фильм ужасов о заброшенном доме.', 6, 18, 300000, 100, 2023, 
  (SELECT id FROM Country WHERE name = N'Германия'),
  (SELECT id FROM Website WHERE name = N'Кино-Театр.ру'),
  (SELECT id FROM Publisher WHERE name = N'Sony Pictures'),
  (SELECT id FROM Director WHERE name = N'Фридрих Шпахт'),
  (SELECT id FROM Genre WHERE name = N'Ужасы')),

(N'Документальный фильм о природе и экологии.', 9, 0, 200000, 60, 2021, 
  (SELECT id FROM Country WHERE name = N'Италия'),
  (SELECT id FROM Website WHERE name = N'MyDramaList'),
  (SELECT id FROM Publisher WHERE name = N'Ghibli'),
  (SELECT id FROM Director WHERE name = N'Фредерико Моччи'),
  (SELECT id FROM Genre WHERE name = N'Документальный')),

(N'Анимационный фильм о дружбе между детьми и животными.', 8, 6, 900000, 85, 2020, 
  (SELECT id FROM Country WHERE name = N'Япония'),
  (SELECT id FROM Website WHERE name = N'AsianWiki'),
  (SELECT id FROM Publisher WHERE name = N'Mosfilm'),
  (SELECT id FROM Director WHERE name = N'Хаяо Миядзаки'),
  (SELECT id FROM Genre WHERE name = N'Анимация')),

(N'Боевик с захватывающими гонками на машинах.', 7, 16, 1300000, 105, 2022, 
  (SELECT id FROM Country WHERE name = N'Южная Корея'),
  (SELECT id FROM Website WHERE name = N'Rotten Tomatoes'),
  (SELECT id FROM Publisher WHERE name = N'Paramount Pictures'),
  (SELECT id FROM Director WHERE name = N'Чан Вук'),
  (SELECT id FROM Genre WHERE name = N'Боевик')),

(N'Фэнтези о магии и приключениях.', 9, 12, 2000000, 140, 2023, 
  (SELECT id FROM Country WHERE name = N'Китай'),
  (SELECT id FROM Website WHERE name = N'SensCritique'),
  (SELECT id FROM Publisher WHERE name = N'Walt Disney'),
  (SELECT id FROM Director WHERE name = N'Тим Бёртон'),
  (SELECT id FROM Genre WHERE name = N'Фэнтези')),

(N'Мелодрама о сложных отношениях в семье.', 7, 18, 100000, 95, 2021, 
  (SELECT id FROM Country WHERE name = N'Испания'),
  (SELECT id FROM Website WHERE name = N'Metacritic'),
  (SELECT id FROM Publisher WHERE name = N'Warner Bros.'),
  (SELECT id FROM Director WHERE name = N'Педро Альмодовар'),
  (SELECT id FROM Genre WHERE name = N'Мелодрама')),

(N'Фильм о подростках и их проблемах в школе.', 7, 12, 750000, 100, 2019, 
  (SELECT id FROM Country WHERE name = N'Индия'),
  (SELECT id FROM Website WHERE name = N'Rotten Tomatoes'),
  (SELECT id FROM Publisher WHERE name = N'Pixar'),
  (SELECT id FROM Director WHERE name = N'Рита Махеш'),
  (SELECT id FROM Genre WHERE name = N'Комедия')),

(N'Психологический триллер о манипуляциях в отношениях.', 8, 18, 900000, 105, 2022, 
  (SELECT id FROM Country WHERE name = N'Бразилия'),
  (SELECT id FROM Website WHERE name = N'IMDb'),
  (SELECT id FROM Publisher WHERE name = N'Sony Pictures'),
  (SELECT id FROM Director WHERE name = N'Пауло Морено'),
  (SELECT id FROM Genre WHERE name = N'Триллер'));

INSERT INTO Collection (name, description) VALUES 
(N'Лучшие драмы', N'Сборник трогательных и сильных драматических фильмов.'),
(N'Комедии для всей семьи', N'Весёлые фильмы, подходящие для семейного просмотра.'),
(N'Фильмы ужасов', N'Жуткие истории и страшные кадры.'),
(N'Любимые мультфильмы', N'Анимационные фильмы, полные добра и юмора.'),
(N'Классика кино', N'Самые известные фильмы всех времён.'),
(N'Фильмы о войне', N'Истории, основанные на реальных событиях.'),
(N'Фантастика и фэнтези', N'Миры магии и технологий.'),
(N'Криминальные драмы', N'Фильмы о преступности и следствии.'),
(N'Артхаус и фестивальное кино', N'Нестандартные фильмы с глубоким смыслом.'),
(N'Лучшие фильмы года', N'Хиты последних лет.');

INSERT INTO MovieCollection (collection_id, movie_id)
SELECT 
    (SELECT id FROM Collection WHERE name = N'Лучшие драмы'),
    (SELECT id FROM Movie WHERE name = N'Фантастика 2045')
UNION ALL
SELECT 
    (SELECT id FROM Collection WHERE name = N'Лучшие драмы'),
    (SELECT id FROM Movie WHERE name = N'Жизнь в кризисе')
UNION ALL
SELECT 
    (SELECT id FROM Collection WHERE name = N'Комедии для всей семьи'),
    (SELECT id FROM Movie WHERE name = N'Студенческий переезд')
UNION ALL
SELECT 
    (SELECT id FROM Collection WHERE name = N'Комедии для всей семьи'),
    (SELECT id FROM Movie WHERE name = N'Любовь и война')
UNION ALL
SELECT 
    (SELECT id FROM Collection WHERE name = N'Фильмы ужасов'),
    (SELECT id FROM Movie WHERE name = N'Дом на холме')
UNION ALL
SELECT 
    (SELECT id FROM Collection WHERE name = N'Фильмы ужасов'),
    (SELECT id FROM Movie WHERE name = N'Жизнь в лесах')
UNION ALL
SELECT 
    (SELECT id FROM Collection WHERE name = N'Любимые мультфильмы'),
    (SELECT id FROM Movie WHERE name = N'Друзья на ферме')
UNION ALL
SELECT 
    (SELECT id FROM Collection WHERE name = N'Любимые мультфильмы'),
    (SELECT id FROM Movie WHERE name = N'Гонка века')
UNION ALL
SELECT 
    (SELECT id FROM Collection WHERE name = N'Классика кино'),
    (SELECT id FROM Movie WHERE name = N'Магия будущего')
UNION ALL
SELECT 
    (SELECT id FROM Collection WHERE name = N'Классика кино'),
    (SELECT id FROM Movie WHERE name = N'Сложные отношения');


INSERT INTO User (age, name)
VALUES 
(45, N'Мама'),
(47, N'Папа'),
(17, N'Дочка'),
(14, N'Сын');

INSERT INTO UserFavoriteMovies (user_id, movie_id)
SELECT 
    (SELECT id FROM User WHERE name = N'Мама'),
    (SELECT id FROM Movie WHERE name = N'Фантастика 2045')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Мама'),
    (SELECT id FROM Movie WHERE name = N'Жизнь в кризисе')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Мама'),
    (SELECT id FROM Movie WHERE name = N'Комедийный марш')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Мама'),
    (SELECT id FROM Movie WHERE name = N'Любовь и война')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Мама'),
    (SELECT id FROM Movie WHERE name = N'Магия будущего')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Папа'),
    (SELECT id FROM Movie WHERE name = N'Студенческий переезд')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Папа'),
    (SELECT id FROM Movie WHERE name = N'Сложные отношения')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Папа'),
    (SELECT id FROM Movie WHERE name = N'Магия будущего')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Папа'),
    (SELECT id FROM Movie WHERE name = N'Гонка века')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Дочка'),
    (SELECT id FROM Movie WHERE name = N'Дом на холме')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Дочка'),
    (SELECT id FROM Movie WHERE name = N'Жизнь в лесах')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Дочка'),
    (SELECT id FROM Movie WHERE name = N'Три ангела')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Дочка'),
    (SELECT id FROM Movie WHERE name = N'Друзья на ферме')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Сын'),
    (SELECT id FROM Movie WHERE name = N'Гонка века')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Сын'),
    (SELECT id FROM Movie WHERE name = N'Любовь и война')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Сын'),
    (SELECT id FROM Movie WHERE name = N'Три ангела');

INSERT INTO UserFavoriteGenre (user_id, genre_id)
SELECT 
    (SELECT id FROM User WHERE name = N'Мама'),
    (SELECT id FROM Genre WHERE name = N'Фантастика')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Мама'),
    (SELECT id FROM Genre WHERE name = N'Драма')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Мама'),
    (SELECT id FROM Genre WHERE name = N'Комедия')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Мама'),
    (SELECT id FROM Genre WHERE name = N'Мелодрама')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Папа'),
    (SELECT id FROM Genre WHERE name = N'Драма')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Папа'),
    (SELECT id FROM Genre WHERE name = N'Фантастика')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Папа'),
    (SELECT id FROM Genre WHERE name = N'Триллер')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Папа'),
    (SELECT id FROM Genre WHERE name = N'Комедия')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Дочка'),
    (SELECT id FROM Genre WHERE name = N'Мелодрама')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Дочка'),
    (SELECT id FROM Genre WHERE name = N'Фантастика')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Дочка'),
    (SELECT id FROM Genre WHERE name = N'Анимация')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Дочка'),
    (SELECT id FROM Genre WHERE name = N'Комедия')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Сын'),
    (SELECT id FROM Genre WHERE name = N'Драма')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Сын'),
    (SELECT id FROM Genre WHERE name = N'Триллер')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'Сын'),
    (SELECT id FROM Genre WHERE name = N'Фантастика');

INSERT INTO WatchHistory (movie_id, user_id, watched_at)
SELECT 
    (SELECT id FROM Movie WHERE name = N'Фантастика 2045'),
    (SELECT id FROM User WHERE name = N'Мама'),
    '2025-03-01 15:00:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'Жизнь в кризисе'),
    (SELECT id FROM User WHERE name = N'Папа'),
    '2025-04-15 20:30:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'Комедийный марш'),
    (SELECT id FROM User WHERE name = N'Дочка'),
    '2025-02-20 10:15:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'Любовь и война'),
    (SELECT id FROM User WHERE name = N'Сын'),
    '2025-03-12 18:45:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'Магия будущего'),
    (SELECT id FROM User WHERE name = N'Мама'),
    '2025-05-01 22:00:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'Студенческий переезд'),
    (SELECT id FROM User WHERE name = N'Папа'),
    '2025-03-25 13:30:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'Сложные отношения'),
    (SELECT id FROM User WHERE name = N'Папа'),
    '2025-04-01 19:00:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'Гонка века'),
    (SELECT id FROM User WHERE name = N'Сын'),
    '2025-04-10 14:00:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'Дом на холме'),
    (SELECT id FROM User WHERE name = N'Дочка'),
    '2025-04-02 11:00:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'Жизнь в лесах'),
    (SELECT id FROM User WHERE name = N'Дочка'),
    '2025-05-05 09:30:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'Три ангела'),
    (SELECT id FROM User WHERE name = N'Сын'),
    '2025-02-28 16:00:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'Друзья на ферме'),
    (SELECT id FROM User WHERE name = N'Дочка'),
    '2025-05-10 17:45:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'Магия будущего'),
    (SELECT id FROM User WHERE name = N'Мама'),
    '2025-05-07 21:00:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'Гонка века'),
    (SELECT id FROM User WHERE name = N'Сын'),
    '2025-05-03 15:30:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'Три ангела'),
    (SELECT id FROM User WHERE name = N'Сын'),
    '2025-05-05 11:00:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'Жизнь в кризисе'),
    (SELECT id FROM User WHERE name = N'Папа'),
    '2025-03-10 12:00:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'Сложные отношения'),
    (SELECT id FROM User WHERE name = N'Папа'),
    '2025-04-05 20:00:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'Фантастика 2045'),
    (SELECT id FROM User WHERE name = N'Мама'),
    '2025-04-20 14:30:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'Студенческий переезд'),
    (SELECT id FROM User WHERE name = N'Папа'),
    '2025-05-02 10:00:00';
