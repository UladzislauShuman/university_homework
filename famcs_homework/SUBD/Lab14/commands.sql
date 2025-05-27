-- Лаб12
-- Задание 2

-- сгенерированно для DBML на сайте https://dbdiagram.io/d
CREATE TABLE [Movie] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [name] VARCHAR(255),
  [description] VARCHAR(255),
  [rating] INT DEFAULT 0 CHECK ([rating] BETWEEN 0 AND 10),
  [age_limit] INT DEFAULT 0 CHECK ([age_limit] BETWEEN 0 AND 21),
  [number_of_views] INT DEFAULT 0 CHECK ([number_of_views] >= 0),
  [duration] INT CHECK ([duration] > 0),
  [release_year] INT CHECK ([release_year] >= 1888),
  [country_id] INT,
  [website_id] INT,
  [publisher_id] INT,
  [director_id] INT,
  [genre_id] INT
)
GO

CREATE TABLE [Genre] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [name] VARCHAR(255) NOT NULL
)
GO

CREATE TABLE [Publisher] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [name] VARCHAR(255) NOT NULL,
  [website_id] INT
)
GO

CREATE TABLE [Director] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [country_id] INT,
  [name] VARCHAR(255) NOT NULL,
  [description] TEXT
)
GO

CREATE TABLE [Country] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [name] VARCHAR(255) NOT NULL
)
GO

CREATE TABLE [Collection] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [name] VARCHAR(255) NOT NULL,
  [description] TEXT
)
GO

CREATE TABLE [MovieCollection] (
  [collection_id] INT,
  [movie_id] INT,
  PRIMARY KEY ([collection_id], [movie_id])
)
GO

CREATE TABLE [Website] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [name] VARCHAR(255) NOT NULL,
  [url] TEXT
)
GO

CREATE TABLE [LocalityType] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [name] VARCHAR(50) NOT NULL,
  [code] VARCHAR(20) NOT NULL
)
GO

CREATE TABLE [Locality] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [country_id] INT,
  [locality_type_id] INT,
  [name] VARCHAR(255) NOT NULL
)
GO

CREATE TABLE [Address] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [locality_id] INT,
  [street] VARCHAR(255) NOT NULL,
  [house] INT CHECK ([house] > 0)
)
GO

CREATE TABLE [Rentaler] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [name] VARCHAR(255) NOT NULL,
  [website_id] INT
)
GO

CREATE TABLE [Rentaler_Concrete] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [rentaler_id] INT,
  [address_id] INT,
  [phone_number] VARCHAR(255) NOT NULL
)
GO

CREATE TABLE [User] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [age] INT CHECK ([age] >= 0 AND [age] <= 120),
  [name] VARCHAR(255) NOT NULL
)
GO

CREATE TABLE [UserFavoriteMovies] (
  [user_id] INT,
  [movie_id] INT,
  PRIMARY KEY ([user_id], [movie_id])
)
GO

CREATE TABLE [UserFavoriteGenre] (
  [genre_id] INT,
  [user_id] INT,
  PRIMARY KEY ([genre_id], [user_id])
)
GO

CREATE TABLE [Carrier] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [size] INT CHECK ([size] >= 0), -- 0 для облачных сервисов
  [name] VARCHAR(255) NOT NULL,
  [type_id] INT,

  [start_rent] DATETIME,
  [end_rent] DATETIME,
  [rentaler_concrete_id] INT
)
GO

CREATE TABLE [Type] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [name] VARCHAR(255) NOT NULL
)
GO

CREATE TABLE [Recording_Format] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [name] VARCHAR(255) NOT NULL
)
GO

CREATE TABLE [MovieCarrier] (
  [movie_id] INT,
  [carrier_id] INT,
  [recording_format_id] INT,
  PRIMARY KEY ([movie_id], [carrier_id], [recording_format_id])
)
GO

CREATE TABLE [WatchHistory] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [movie_id] INT,
  [user_id] INT NULL,
  [watched_at] DATETIME DEFAULT GETDATE()
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

ALTER TABLE [Carrier] ADD FOREIGN KEY ([rentaler_concrete_id]) REFERENCES [Rentaler_Concrete] ([id])
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
INSERT INTO LocalityType (name, code) VALUES
('VILLAGE', 'VIL'),
('CITY', 'CTY'),
('TOWN', 'TWN'),
('SETTLEMENT', 'SET'),
('HAMLET', 'HMT'),
('DISTRICT', 'DST'),
('METROPOLIS', 'MET'),
('CAPITAL', 'CPL'),
('PROVINCE', 'PRV'),
('SUBURB', 'SUB');

INSERT INTO Country (name) VALUES
('США'),
('Канада'),
('Великобритания'),
('Франция'),
('Германия'),
('Япония'),
('Австралия'),
('Россия'),
('Бразилия'),
('Индия'),
('Китай'),
('Мексика'),
('Южная Корея'),
('Италия'),
('Испания');

INSERT INTO Website (name, url) VALUES
('Netflix', 'https://www.netflix.com'),
('Amazon Prime', 'https://www.primevideo.com'),
('Disney+', 'https://www.disneyplus.com'),
('Hulu', 'https://www.hulu.com'),
('HBO Max', 'https://www.hbomax.com'),
('YouTube Movies', 'https://www.youtube.com/movies'),
('Apple TV+', 'https://tv.apple.com'),
('Google Play Movies', 'https://play.google.com/store/movies'),
('Vudu', 'https://www.vudu.com'),
('Peacock', 'https://www.peacocktv.com'),
('Paramount+', 'https://www.paramountplus.com'),
('Tubi', 'https://tubitv.com'),
('Crunchyroll', 'https://www.crunchyroll.com'),
('Mubi', 'https://mubi.com'),
('Shudder', 'https://www.shudder.com');

INSERT INTO Rentaler (name, website_id) VALUES
('Netflix', 1),
('Amazon Rentals', 2),
('Disney Rentals', 3),
('Hulu Rentals', 4),
('HBO Rentals', 5),
('YouTube Rentals', 6),
('Apple Rentals', 7),
('Google Rentals', 8),
('Vudu Rentals', 9),
('Peacock Rentals', 10),
('Paramount Rentals', 11),
('Tubi Rentals', 12),
('Crunchyroll Rentals', 13),
('Mubi Rentals', 14),
('Shudder Rentals', 15);

INSERT INTO Locality (country_id, locality_type_id, name) VALUES
(1, 2, 'Нью-Йорк'),
(1, 2, 'Лос-Анджелес'),
(1, 2, 'Чикаго'),
(1, 1, 'Гринвич-Виллидж'),
(1, 1, 'Слипи Холлоу'),
(2, 2, 'Торонто'),
(2, 1, 'Ниагара-он-те-Лейк'),
(3, 2, 'Лондон'),
(3, 1, 'Литтл Венеция'),
(4, 2, 'Париж'),
(4, 1, 'Живерни'),
(5, 2, 'Берлин'),
(5, 1, 'Нойхарденберг'),
(6, 2, 'Токио'),
(6, 1, 'Митака');


INSERT INTO Address (locality_id, street, house) VALUES
(1, 'Бродвей', 123),
(2, 'Сансет бульвар', 45),
(3, 'Мичиган авеню', 100),
(4, 'Вашингтон сквер', 12),
(5, 'Главная улица', 77),
(6, 'Улица Королевы', 555),
(7, 'Улица Короля', 101),
(8, 'Бейкер-стрит', 221),
(9, 'Улица Роз', 5),
(10, 'Елисейские поля', 10),
(11, 'Улица Парижа', 1),
(12, 'Унтер-ден-Линден', 8),
(13, 'Хауптштрассе', 15),
(14, 'Синдзюку', 3),
(15, 'Улица Митака', 7);

INSERT INTO Rentaler_Concrete (rentaler_id, address_id, phone_number) VALUES
(1, 1, '+1-212-555-1234'),
(1, 4, '+1-212-555-5678'),
(2, 6, '+1-416-555-7890'),
(2, 7, '+1-416-555-4567'),
(3, 10, '+33-1-555-2345'),
(3, 11, '+33-1-555-6789'),
(4, 8, '+44-20-555-3456'),
(4, 9, '+44-20-555-7890'),
(5, 12, '+49-30-555-4567'),
(5, 13, '+49-30-555-7891'),
(6, 14, '+81-3-555-5678'),
(6, 15, '+81-3-555-1234'),
(7, 2, '+1-310-555-9876'),
(8, 3, '+1-312-555-4321'),
(9, 5, '+1-914-555-6543');

INSERT INTO Type (name) VALUES
('DVD'),
('Blu-ray'),
('VHS'),
('Digital'),
('LaserDisc'),
('Betamax'),
('HD DVD'),
('4K UHD'),
('CD'),
('Cassette'),
('Streaming'),
('USB'),
('External HDD'),
('SD Card'),
('Blu-ray 3D');

INSERT INTO Carrier (size, name, type_id) VALUES
(700, 'Carrier A', 1),
(2500, 'Carrier B', 2),
(1200, 'Carrier C', 3),
(0, 'Digital Stream', 4),
(4400, 'LaserDisc 1', 5),
(800, 'Betamax Tape', 6),
(5000, 'HD DVD 1', 7),
(6000, '4K UHD Disk', 8),
(650, 'Audio CD', 9),
(90, 'Music Cassette', 10),
(0, 'Netflix Stream', 11),
(16000, 'USB Stick', 12),
(100000, 'External HDD 1', 13),
(64, 'SD Card 64GB', 14),
(2700, 'Blu-ray 3D Disc', 15),

(2700, 'Blu-ray with Intersteller', 15),
(3700, 'Blu-ray with La La Land', 15),
(2500, 'Blu-ray withThe Shawshank Redemption', 15),
(2900, 'Blu-ray with Spirited Away', 15),
(3000, 'Blu-ray with The Grand Budapest Hotel', 15),

(700, 'Collectors DVD', 6),
(2500, 'Directors Blu-ray', 6),
(700, 'Limited VHS', 2),
(16000, 'HD Stream', 1),
(0, 'LaserClassic', 11),
(700, 'BetaArchive', 15),
(0, 'HD Master Copy', 6),
(700, '4K Collector Edition', 11),
(700, 'Studio CD', 14),
(0, 'Classic Cassette', 9),
(700, 'Netflix Digital', 11),
(700, 'USB Archive', 4),
(5000, 'HDD Vault', 7),
(5000, 'SD Memory', 10),
(5000, 'Blu-ray 3D Master', 13),
(2500, 'Bonus Disk', 1),
(2500, 'Behind the Scenes', 9),
(5000, 'Remastered Copy', 10),
(0, 'Studio Screener', 5),
(0, 'Original Print', 13);

INSERT INTO Recording_Format (name) VALUES
('MP4'),
('MKV'),
('AVI'),
('MOV'),
('WMV'),
('FLV'),
('MPEG'),
('WEBM'),
('HEVC'),
('ProRes');

INSERT INTO Genre (name) VALUES
('Боевик'),
('Комедия'),
('Драма'),
('Ужасы'),
('Триллер'),
('Мелодрама'),
('Научная фантастика'),
('Фэнтези'),
('Документальный'),
('Анимация'),
('Приключения'),
('Криминал'),
('Детектив'),
('Мюзикл'),
('Вестерн');

INSERT INTO Publisher (name, website_id) VALUES
('Disney', 3),
('Warner Bros', 5),
('Universal Pictures', 6),
('Paramount Pictures', 11),
('Sony Pictures', 8),
('20th Century Fox', 9),
('Lionsgate', 10),
('MGM', 12),
('Columbia Pictures', 7),
('New Line Cinema', 13),
('Pixar', 3),
('DreamWorks', 14),
('Focus Features', 15),
('Blumhouse', 4),
('A24', 2);

INSERT INTO Director (country_id, name, description) VALUES
(1, 'Стивен Спилберг', 'Знаменитый американский режиссёр'),
(2, 'Джеймс Кэмерон', 'Канадский режиссёр, известный по фильму «Титаник»'),
(3, 'Кристофер Нолан', 'Британско-американский кинорежиссёр'),
(4, 'Люк Бессон', 'Французский режиссёр и продюсер'),
(5, 'Вернер Херцог', 'Немецкий режиссёр'),
(6, 'Хаяо Миядзаки', 'Японский режиссёр анимации'),
(7, 'Баз Лурман', 'Австралийский режиссёр, известный мюзиклами'),
(8, 'Андрей Тарковский', 'Российский кинорежиссёр'),
(9, 'Жозе Падилья', 'Бразильский режиссёр'),
(10, 'Сатьяджит Рей', 'Индийский режиссёр'),
(11, 'Чжан Имоу', 'Китайский режиссёр'),
(12, 'Гильермо дель Торо', 'Мексиканский режиссёр'),
(13, 'Пак Чхан Ук', 'Южнокорейский режиссёр'),
(14, 'Паоло Соррентино', 'Итальянский режиссёр'),
(15, 'Педро Альмодовар', 'Испанский режиссёр');

INSERT INTO Movie ([name], description, rating, age_limit, number_of_views, duration, release_year, country_id, website_id, publisher_id, director_id, genre_id) VALUES
('Звёздные войны: Новая надежда', 'Эпическое космическое приключение', 9, 13, 2, 150, 2010, 1, 1, 1, 3, 7),
('Реальная любовь', 'Романтическая комедия о любви', 7, 12, 3, 120, 2015, 3, 3, 11, 3, 6),
('Тёмный рыцарь', 'Остросюжетная криминальная драма', 8, 16, 1, 130, 2005, 5, 5, 2, 1, 12),
('История игрушек 4', 'Анимационный фильм для детей', 10, 0, 2, 90, 2018, 6, 3, 11, 6, 10),
('История Рима', 'Исторический документальный фильм', 6, 0, 2, 110, 2012, 4, 6, 13, 5, 9),
('Деревня', 'История ужасов в деревне', 5, 18, 1, 100, 2011, 8, 4, 14, 8, 4),
('Властелин колец', 'Фэнтезийная эпическая сага', 9, 13, 6, 140, 2014, 7, 7, 3, 7, 8),
('Джон Уик', 'Остросюжетный боевик', 8, 16, 3, 115, 2013, 1, 2, 1, 2, 1),
('Мальчишник в Вегасе', 'Комедия о повседневной жизни', 7, 0, 6000, 105, 2016, 3, 3, 14, 3, 2),
('Исчезнувшая', 'Детективная история о преступлении', 8, 16, 6, 125, 2009, 5, 9, 2, 1, 13),
('Начало', 'Научно-фантастический триллер', 9, 14, 2, 130, 2017, 1, 1, 3, 3, 7),
('Дневник памяти', 'Романтическая драма', 7, 12, 3, 100, 2018, 3, 3, 11, 3, 6),
('Планета Земля II', 'Документальный фильм о природе', 8, 0, 1, 90, 2014, 4, 6, 13, 5, 9),
('Холодное сердце 2', 'Анимационное приключение', 9, 0, 1, 95, 2019, 6, 3, 11, 6, 10),
('Настоящая grit', 'Ковбойская история в стиле вестерн', 7, 16, 1, 130, 2010, 1, 2, 1, 1, 15),

('Интерстеллар', 'Захватывающая космическая одиссея о любви и времени', 9, 13, 0, 169, 2014, 1, 1, 3, 3, 7),
('Ла-Ла Ленд', 'Современный мюзикл о мечтах и романтике в Голливуде', 8, 12, 0, 128, 2016, 1, 3, 14, 7, 14),
('Побег из Шоушенка', 'Мощная драма о надежде и дружбе в тюрьме', 10, 16, 0, 142, 1994, 1, 5, 2, 1, 3),
('Унесённые призраками', 'Магическое аниме о девочке в мире духов', 9, 0, 0, 125, 2001, 6, 3, 11, 6, 10),
('Отель «Гранд Будапешт»', 'Причудливая комедия о легендарном консьерже отеля', 8, 13, 0, 100, 2014, 1, 7, 3, 15, 2),

('Матрица', 'Хакер обнаруживает, что реальность — это симуляция', 7, 18, 18, 143, 1991, 8, 12, 6, 3, 6),
('Форрест Гамп', 'Малоумный человек становится свидетелем исторических событий', 9, 6, 7, 127, 2022, 11, 4, 8, 3, 14),
('Криминальное чтиво', 'Истории преступлений в Лос-Анджелесе', 9, 18, 19, 113, 2003, 4, 4, 13, 2, 10),
('Крёстный отец', 'Мафиозная семья борется за власть и верность', 9, 16, 7, 155, 2000, 8, 13, 6, 12, 1),
('Молчание ягнят', 'Стажер ФБР просит помощи у каннибала', 8, 18, 0, 117, 2022, 3, 4, 15, 6, 4),
('Выживший', 'Колонист сражается за выживание после предательства', 7, 12, 0, 118, 2018, 13, 11, 13, 15, 13),
('Чёрный лебедь', 'Балерина погружается в безумие', 10, 16, 10, 109, 2022, 7, 2, 9, 8, 8),
('Социальная сеть', 'История создания Facebook', 9, 18, 7, 163, 2019, 10, 10, 5, 12, 6),
('Одержимость', 'Молодой барабанщик сталкивается с требовательным учителем', 8, 6, 7, 97, 2005, 7, 12, 8, 14, 13),
('Она', 'Мужчина влюбляется в систему искусственного интеллекта', 6, 18, 2, 134, 2012, 14, 5, 3, 6, 9),
('Прибытие', 'Лингвист расшифровывает язык пришельцев', 10, 16, 12, 95, 1995, 2, 7, 5, 6, 1),
('Паразиты', 'Бедная семья проникает в богатый дом', 6, 12, 14, 176, 2020, 11, 13, 15, 7, 6),
('Престиж', 'Два мага в смертельном соперничестве', 8, 16, 14, 169, 1996, 3, 3, 10, 9, 5),
('Игра в имитацию', 'Алан Тьюринг взламывает нацистскую Энигму', 6, 18, 19, 144, 2000, 15, 7, 12, 1, 9),
('Амели', 'Причудливая француженка меняет жизни окружающих', 9, 18, 1, 179, 2006, 13, 14, 12, 10, 11),
('Миллионер из трущоб', 'Сирота побеждает в телеигре вопреки всему', 8, 16, 10, 99, 2017, 11, 5, 11, 14, 12),
('Джокер', 'Психически больной человек погружается в безумие', 6, 6, 11, 172, 1991, 12, 1, 4, 9, 6),
('1917', 'Два солдата Первой мировой несут важное сообщение', 9, 6, 2, 133, 2004, 12, 5, 6, 10, 14),
('Тайна Коко', 'Мальчик попадает в мир мёртвых', 9, 16, 2, 96, 2010, 13, 15, 8, 10, 3),
('Головоломка', 'Эмоции внутри сознания девочки', 6, 16, 1, 176, 1994, 5, 1, 6, 15, 11);

INSERT INTO Collection (name, description) VALUES
('Лучшая научная фантастика', 'Лучшие научно-фантастические фильмы'),
('Романтическая классика', 'Лучшие романтические фильмы всех времён'),
('Ночь ужасов', 'Страшные фильмы ужасов'),
('Семейные развлечения', 'Фильмы, подходящие для семейного просмотра'),
('Лучшие комедии', 'Лучшие комедийные фильмы'),
('Экшн-триллеры', 'Лучшие остросюжетные боевики'),
('Документальное кино', 'Образовательные и познавательные фильмы'),
('Любимая анимация', 'Популярные анимационные фильмы'),
('Криминальные истории', 'Лучшие криминальные драмы'),
('Фэнтези-миры', 'Фильмы, действие которых происходит в фантастических мирах'),
('Приключенческие путешествия', 'Захватывающие приключенческие фильмы'),
('Тайны и саспенс', 'Интригующие детективные фильмы'),
('Вестерн-легенды', 'Классические вестерны'),
('Мюзиклы', 'Знаменитые мюзиклы'),
('Мировое кино', 'Лучшие зарубежные фильмы');

INSERT INTO MovieCollection (collection_id, movie_id) VALUES
(1,1),
(1, 16), 
(1, 21), 
(1, 11),
(2,2),
(2, 12), 
(2, 17), 
(2, 30),
(3,6),
(3, 25),
(3, 10),
(4,4),
(4, 19),
(4, 31),
(4, 14),
(5,9),
(6,8),
(7,5),
(8,14),
(9,3),
(10,7),
(11,11),
(12,10),
(13,15),
(14,2),
(15,13);

INSERT INTO [User] (age, name) VALUES
(45, 'Mom'),
(48, 'Dad'),
(20, 'Daughter'),
(18, 'Son'),
(6, 'Cat');


INSERT INTO UserFavoriteMovies (user_id, movie_id) VALUES
-- Mom
(1, 1), (1, 3), (1, 5), (1, 7), (1, 9),

-- Dad
(2, 2), (2, 4), (2, 6), (2, 8), (2, 10),

-- Daughter
(3, 11), (3, 12), (3, 13), (3, 14), (3, 15),

-- Son
(4, 1), (4, 4), (4, 7), (4, 10), (4, 13),

-- Cat
(5, 2), (5, 5), (5, 8), (5, 11), (5, 14);

INSERT INTO UserFavoriteGenre (genre_id, user_id) VALUES
-- Mom 
(1, 1), (3, 1), (5, 1),

-- Dad 
(2, 2), (4, 2), (6, 2),

-- Daughter
(1, 3), (2, 3), (7, 3),

-- Son
(3, 4), (5, 4), (7, 4),

-- Cat
(4, 5), (6, 5), (7, 5);

INSERT INTO WatchHistory (movie_id, user_id, watched_at) VALUES
-- Mom 
(1, 1, '2024-05-01T20:00:00'),
(3, 1, '2024-05-02T21:00:00'),
(5, 1, '2024-05-03T22:00:00'),
(7, 1, '2024-05-04T19:30:00'),
(9, 1, '2024-05-05T20:15:00'),
(27, 1, '2025-04-06T15:34:55'),
(28, 1, '2025-05-09T15:34:55'),
(36, 1, '2025-05-13T15:34:55'),
(38, 1, '2025-05-01T15:34:55'),
(40, 1, '2025-04-06T15:34:55'),
(40, 1, '2025-05-11T15:34:55'),

-- Dad 
(2, 2, '2024-04-10T18:45:00'),
(4, 2, '2024-04-12T20:00:00'),
(6, 2, '2024-04-13T21:15:00'),
(8, 2, '2024-04-15T19:00:00'),
(10, 2, '2024-04-17T20:30:00'),
(25, 2, '2025-05-13T15:34:55'),
(27, 2, '2025-05-12T15:34:55'),
(29, 2, '2025-03-29T15:34:55'),
(34, 2, '2025-04-15T15:34:55'),
(35, 2, '2025-04-07T15:34:55'),
(38, 2, '2025-03-25T15:34:55'),
(39, 2, '2025-04-15T15:34:55'),

-- Daughter 
(11, 3, '2024-03-20T17:00:00'),
(12, 3, '2024-03-22T18:00:00'),
(13, 3, '2024-03-24T19:15:00'),
(14, 3, '2024-03-26T20:45:00'),
(15, 3, '2024-03-28T21:30:00'),
(25, 3, '2025-05-06T15:34:55'),
(27, 3, '2025-04-12T15:34:55'),
(28, 3, '2025-04-16T15:34:55'),
(31, 3, '2025-04-19T15:34:55'),
(31, 3, '2025-05-04T15:34:55'),
(32, 3, '2025-04-12T15:34:55'),
(33, 3, '2025-04-09T15:34:55'),
(37, 3, '2025-04-07T15:34:55'),
(38, 3, '2025-05-11T15:34:55'),
(39, 3, '2025-04-15T15:34:55'),


-- Son
(1, 4, '2024-02-10T16:30:00'),
(4, 4, '2024-02-12T17:45:00'),
(7, 4, '2024-02-14T19:00:00'),
(10, 4, '2024-02-16T20:15:00'),
(13, 4, '2024-02-18T21:00:00'),
(21, 4, '2025-05-05T15:34:55'),
(21, 4, '2025-03-21T15:34:55'),
(25, 4, '2025-03-28T15:34:55'),
(26, 4, '2025-05-10T15:34:55'),
(29, 4, '2025-04-03T15:34:55'),
(30, 4, '2025-04-23T15:34:55'),

-- Cat
(2, 5, '2024-01-05T15:00:00'),
(5, 5, '2024-01-07T16:30:00'),
(8, 5, '2024-01-09T17:45:00'),
(11, 5, '2024-01-11T19:00:00'),
(14, 5, '2024-01-13T20:30:00'),
(22, 5, '2025-05-02T15:34:55'),
(23, 5, '2025-04-28T15:34:55'),
(24, 5, '2025-05-08T15:34:55'),
(26, 5, '2025-03-24T15:34:55'),
(32, 5, '2025-04-16T15:34:55'),
(32, 5, '2025-04-10T15:34:55'),
(36, 5, '2025-05-06T15:34:55'),
(36, 5, '2025-04-03T15:34:55'),
(39, 5, '2025-04-06T15:34:55'),
(40, 5, '2025-05-11T15:34:55');

INSERT INTO Carrier (size, name, type_id, start_rent, end_rent, rentaler_concrete_id) VALUES
-- просрочил
(700, 'Carrier A', 1,DATEADD(DAY, -10, GETDATE()), DATEADD(DAY, -9, GETDATE()), 1), 
(2500, 'Carrier B', 2, DATEADD(DAY, -8, GETDATE()), DATEADD(DAY, -7, GETDATE()), 2), 
(1200, 'Carrier C', 3, DATEADD(DAY, -6, GETDATE()), DATEADD(DAY, -5, GETDATE()), 3),
(0, 'Digital Stream', 4, DATEADD(DAY, -4, GETDATE()), DATEADD(DAY, -3, GETDATE()), 4), 

-- сегодня закончиться
(4400, 'LaserDisc 1', 5, DATEADD(DAY, -1, GETDATE()), DATEADD(HOUR, 2, GETDATE()), 5),

-- активные
(800, 'Betamax Tape', 6, DATEADD(DAY, -2, GETDATE()), DATEADD(DAY, 1, GETDATE()), 6),
(5000, 'HD DVD 1', 7, DATEADD(DAY, -3, GETDATE()), DATEADD(DAY, 2, GETDATE()), 7),
(6000, '4K UHD Disk', 8, DATEADD(DAY, -4, GETDATE()), DATEADD(DAY, 3, GETDATE()), 8),
(650, 'Audio CD', 9, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, 4, GETDATE()), 9),
(90, 'Music Cassette', 10, DATEADD(DAY, -6, GETDATE()), DATEADD(DAY, 5, GETDATE()), 10),

-- и тд
(0, 'Netflix Stream', 11, NULL, NULL, NULL),
(16000, 'USB Stick', 12, NULL, NULL, NULL),
(100000, 'External HDD 1', 13, NULL, NULL, NULL),
(64, 'SD Card 64GB', 14, NULL, NULL, NULL),
(2700, 'Blu-ray 3D Disc', 15, NULL, NULL, NULL),
(2700, 'Blu-ray with Intersteller', 15, NULL, NULL, NULL),
(3700, 'Blu-ray with La La Land', 15, NULL, NULL, NULL),
(2500, 'Blu-ray withThe Shawshank Redemption', 15, NULL, NULL, NULL),
(2900, 'Blu-ray with Spirited Away', 15, NULL, NULL, NULL),
(3000, 'Blu-ray with The Grand Budapest Hotel', 15, NULL, NULL, NULL),
(700, 'Collectors DVD', 6, GETDATE(), DATEADD(DAY, 1, GETDATE()), 11),
(2500, 'Directors Blu-ray', 6, NULL, NULL, NULL),
(700, 'Limited VHS', 2, GETDATE(), DATEADD(DAY, 1, GETDATE()), 9),
(16000, 'HD Stream', 1, NULL, NULL, NULL),
(0, 'LaserClassic', 11, GETDATE(), DATEADD(DAY, 5, GETDATE()), 8),
(700, 'BetaArchive', 15, NULL, NULL, NULL),
(0, 'HD Master Copy', 6, GETDATE(), DATEADD(DAY, 4, GETDATE()), 11),
(700, '4K Collector Edition', 11, NULL, NULL, NULL),
(700, 'Studio CD', 14, GETDATE(), DATEADD(DAY, 3, GETDATE()), 7),
(0, 'Classic Cassette', 9, NULL, NULL, NULL),
(700, 'Netflix Digital', 11, GETDATE(), DATEADD(DAY, 2, GETDATE()), 13),
(700, 'USB Archive', 4, NULL, NULL, NULL),
(5000, 'HDD Vault', 7, GETDATE(), DATEADD(DAY, 2, GETDATE()), 6),
(5000, 'SD Memory', 10, NULL, NULL, NULL),
(5000, 'Blu-ray 3D Master', 13, GETDATE(), DATEADD(DAY, 1, GETDATE()), 11),
(2500, 'Bonus Disk', 1, NULL, NULL, NULL),
(2500, 'Behind the Scenes', 9, GETDATE(), DATEADD(DAY, 5, GETDATE()), 11),
(5000, 'Remastered Copy', 10, NULL, NULL, NULL),
(0, 'Studio Screener', 5, GETDATE(), DATEADD(DAY, 3, GETDATE()), 7),
(0, 'Original Print', 13, NULL, NULL, NULL);

INSERT INTO [MovieCarrier] (movie_id, carrier_id, recording_format_id) VALUES
(1, 1, 1),
(2, 2, 7),
(3, 3, 3),
(4, 4, 10),
(5, 5, 1),
(6, 6, 1),
(7, 7, 1),
(8, 8, 3),
(9, 9, 4),
(10, 10, 5),
(11, 11, 7),
(12, 12, 1),
(13, 13, 1),
(14, 14, 1),
(15, 15, 9),
(16, 16, 6),
(17, 17, 2),
(18, 18, 8),
(19, 19, 1),
(20, 20, 1),
(21, 21, 6),
(22, 22, 7),
(23, 23, 7),
(24, 24, 8),
(25, 25, 6),
(26, 26, 10),
(27, 27, 7),
(28, 28, 7),
(29, 29, 6),
(30, 30, 1),
(31, 31, 3),
(32, 32, 7),
(33, 33, 2),
(34, 34, 4),
(35, 35, 10),
(36, 36, 6),
(37, 37, 3),
(38, 38, 8),
(39, 39, 4),
(40, 40, 5);

-- Задание 4
-- сформировать запросы

-- 1
-- любимый жанр месяца пользователя Daughter (id = 3)
SELECT TOP 1 g.name AS favorite_month_genre, COUNT(*) AS amount_of_views
FROM WatchHistory wh
JOIN Movie m ON wh.movie_id = m.id
JOIN Genre g ON m.genre_id = g.id
WHERE wh.user_id = 3
  AND wh.watched_at >= DATEADD(month, -1, GETDATE())
GROUP BY g.name
ORDER BY amount_of_views DESC;

-- 2
-- любимый режисер пользоватля id = 1
SELECT TOP 1 d.name AS favorite_director, COUNT(*) AS movies_watched
FROM WatchHistory wh
JOIN Movie m ON wh.movie_id = m.id
JOIN Director d ON m.director_id = d.id
WHERE wh.user_id = 1
GROUP BY d.name
ORDER BY movies_watched DESC;

-- 3
-- фильмы режисёра
SELECT m.name AS movie_title, m.release_year, m.rating
FROM Movie m
JOIN Director d ON m.director_id = d.id
WHERE d.name = 'Кристофер Нолан' 
ORDER BY m.release_year DESC;

-- 4 
-- самый популярный фильм среди домоседцев
SELECT TOP 1 m.name AS most_popular_movie, COUNT(*) AS times_watched
FROM WatchHistory wh
JOIN Movie m ON wh.movie_id = m.id
GROUP BY m.name
ORDER BY times_watched DESC;

-- 5
-- фильмы, которые можно смотреть всей семье
SELECT m.description, m.age_limit, g.name AS genre
FROM Movie m
JOIN Genre g ON m.genre_id = g.id
WHERE m.age_limit <= (
	SELECT MIN(age)
	FROM [User]
	WHERE [name] <> 'Cat' -- по человеческим годам кот старше
)
ORDER BY m.rating DESC;

-- 6
-- список носителей и статус их просроченности
SELECT 
  c.name AS carrier_name,
  c.end_rent, -- Берем дату окончания аренды прямо из таблицы Carrier
  'Просроченный' AS status
FROM Carrier c
WHERE 
  c.start_rent IS NOT NULL   -- он арендованный?
  AND c.end_rent < GETDATE()  -- проверяем дату
ORDER BY c.end_rent;


-- 7
-- фильмы, которые ни разу не смотрели
SELECT m.name AS movie_title
FROM Movie m
LEFT JOIN WatchHistory wh ON m.id = wh.movie_id
WHERE wh.movie_id IS NULL AND m.number_of_views = 0;

-- 8
-- сортировка пользователей по самым смотрящим (кто больше всего смотрел)
SELECT u.name AS user_name, COUNT(*) AS watched_movies
FROM WatchHistory wh
JOIN [User] u ON wh.user_id = u.id
GROUP BY u.name
ORDER BY watched_movies DESC;

-- 9
-- рекомендация фильмов пользователю id = 3 согласно его любимым жанрам
SELECT m.name AS recommended_movie
FROM Movie m
WHERE m.genre_id IN (
  SELECT genre_id
  FROM UserFavoriteGenre
  WHERE user_id = 3
)
AND m.id NOT IN (
  SELECT movie_id FROM WatchHistory WHERE user_id = 3
);

-- 10
-- фильмы, у которых рейтинг выше среднего
SELECT name, rating
FROM Movie
WHERE rating > (SELECT AVG(rating) FROM Movie)
ORDER BY rating DESC;

-- 11
-- Вся информация о коллекциях
SELECT 
    c.id AS collection_id,
    c.name AS collection_name,
    CAST(c.description AS NVARCHAR(MAX)) AS description,
    COUNT(mc.movie_id) AS movies_count,
    STRING_AGG(CAST(m.name AS NVARCHAR(MAX)), ', ') WITHIN GROUP (ORDER BY m.name) AS movies_list
FROM [Collection] c
JOIN [MovieCollection] mc ON c.id = mc.collection_id
JOIN [Movie] m ON mc.movie_id = m.id
GROUP BY c.id, c.name, CAST(c.description AS NVARCHAR(MAX))
ORDER BY c.name;

--Лаб14

-- 1. Разработать 2 хранимые процедуры для формирования
-- отчетных документов по специфике предметной области Вашего варианта
-- индивидального задания и описанию выходных документов (ЛР-4).

-- 1 процедура -- отчет по фильмам относительно различных критериев
CREATE PROCEDURE GetMoviesByCriteria (
    @GenreName NVARCHAR(255) = NULL,
    @DirectorName NVARCHAR(255) = NULL,
    @MinReleaseYear INT = NULL,
    @MaxReleaseYear INT = NULL,
    @MaxAgeLimit INT = NULL,
    @PublisherName NVARCHAR(255) = NULL -- Добавлен поиск по издателю
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        m.name AS MovieTitle,
        g.name AS Genre,
        d.name AS Director,
        p.name AS Publisher,
        m.release_year AS ReleaseYear,
        m.duration AS DurationMinutes,
        m.rating AS Rating,
        m.age_limit AS AgeLimit,
        c.name AS Country
    FROM Movie m
    JOIN Genre g ON m.genre_id = g.id
    JOIN Director d ON m.director_id = d.id
    JOIN Publisher p ON m.publisher_id = p.id
    JOIN Country c ON m.country_id = c.id
    WHERE
        (@GenreName IS NULL OR g.name = @GenreName)
        AND (@DirectorName IS NULL OR d.name = @DirectorName)
        AND (@MinReleaseYear IS NULL OR m.release_year >= @MinReleaseYear)
        AND (@MaxReleaseYear IS NULL OR m.release_year <= @MaxReleaseYear)
        AND (@MaxAgeLimit IS NULL OR m.age_limit <= @MaxAgeLimit)
        AND (@PublisherName IS NULL OR p.name = @PublisherName)
    ORDER BY
        m.release_year DESC, m.name;
END
GO

-- примеры:

-- все комедии, выпущенные с 2010 по 2020 год, с возрастным ограничением до 18 лет
EXEC GetMoviesByCriteria @GenreName = 'Комедия', @MinReleaseYear = 2010, @MaxReleaseYear = 2020, @MaxAgeLimit = 18;

-- все фильмы без фильтров 
EXEC GetMoviesByCriteria;

-- 2 выбираем фильмы по продолжительности
CREATE PROCEDURE GetMoviesByDuration (
    @MinDurationMinutes INT,     
    @MaxDurationMinutes INT,    
    @SortOrder NVARCHAR(10) = 'ASC' -- 'ASC', 'DESC' 
)
AS
BEGIN
    SET NOCOUNT ON;

    -- проверка
    IF @MinDurationMinutes > @MaxDurationMinutes
    BEGIN
        PRINT 'exception: min > max';
        RETURN;
    END

    -- еще проверка
    IF @SortOrder NOT IN ('ASC', 'DESC')
    BEGIN
        PRINT 'не ASC и не DESC, default = ASC';
        SET @SortOrder = 'ASC';
    END

    SELECT
        m.name AS MovieTitle,
        m.duration AS DurationMinutes,
        g.name AS Genre,
        d.name AS Director,
        m.release_year AS ReleaseYear,
        m.rating AS Rating,
        m.age_limit AS AgeLimit
    FROM Movie m
    LEFT JOIN Genre g ON m.genre_id = g.id
    LEFT JOIN Director d ON m.director_id = d.id
    WHERE
        m.duration >= @MinDurationMinutes
        AND m.duration <= @MaxDurationMinutes
    ORDER BY
        CASE WHEN @SortOrder = 'ASC' THEN m.duration END ASC,
        CASE WHEN @SortOrder = 'DESC' THEN m.duration END DESC,
        m.name ASC;
END
GO

-- Пример использования:
EXEC GetMoviesByDuration @MinDurationMinutes = 120, @MaxDurationMinutes = 150, @SortOrder = 'DESC';



-- 2. Разработать 1 триггер для поддержания ограничений
-- целостности БД предметной области Вашего варианта индивидального
-- задания или выполнения заданных действий с некоторыми ее таблицами
-- после определенных DML-запросов пользователей.

-- триггер для автоматического обновления количества просмотров фильма после
-- добавления его в WatchHistory

CREATE TRIGGER Trigger_UpdateMovieViewsAfterWatching
ON WatchHistory -- после того как в таблицу
AFTER INSERT -- была вставленна новая запись
AS
BEGIN
    WITH MovieViewCounts AS ( -- сохраняем результат запроса (CTE), 
        SELECT
            i.movie_id, -- id фильма из insert
            COUNT(*) AS NewViews -- сколько он там фигурирует
        FROM inserted i
        GROUP BY i.movie_id
    )
    UPDATE Movie -- и используем его для Обновления данных в Movie
    SET number_of_views = Movie.number_of_views + mvc.NewViews
    FROM Movie
    INNER JOIN MovieViewCounts mvc ON Movie.id = mvc.movie_id;

END
GO

-- Проверка работы триггера:
-- до
SELECT name, number_of_views FROM Movie WHERE id = 1;

-- добавляем
INSERT INTO WatchHistory (movie_id, user_id, watched_at)
VALUES (1, 2, GETDATE()); 

-- перепроверяем
SELECT name, number_of_views FROM Movie WHERE id = 1;

-- 3. Создать 2 представления, представляющих выборочные данные
-- отдельных таблиц БД предметной области вашего варианта индивидального
-- задания.-- подробная информация о носителяхCREATE VIEW view_DetailedCarrierInfo
AS
SELECT
    c.id AS Id, -- id
    c.name AS Carrier_Name, -- имя
    t.name AS Carrier_Type, -- тип
    c.size AS Carrier_SizeMB, -- размер
    ( -- фильмы через запятую
        SELECT STRING_AGG(CAST(m.name AS NVARCHAR(MAX)), ', ') WITHIN GROUP (ORDER BY m.name)
        FROM MovieCarrier mc
        JOIN Movie m ON mc.movie_id = m.id
        WHERE mc.carrier_id = c.id
    ) AS MoviesOnCarrier,
    c.start_rent AS Start_date_,
    c.end_rent AS End_date,
    rc.name AS RentedFrom_Name,
    CASE -- cтатус носителя
        WHEN c.rentaler_concrete_id IS NULL THEN 'Наше'
        WHEN c.end_rent IS NOT NULL AND c.end_rent < GETDATE() THEN 'просрочил (до: ' + CONVERT(VARCHAR(10), c.end_rent, 120) + ')'
        WHEN c.end_rent IS NOT NULL AND c.end_rent >= GETDATE() THEN 'активно (до: ' + CONVERT(VARCHAR(10), c.end_rent, 120) + ')'
        WHEN c.start_rent IS NOT NULL AND c.end_rent IS NULL THEN 'не укащано когда вернуть'
    END AS Carrier_Status,
    DATEDIFF(day, GETDATE(), c.end_rent) AS Due 
FROM Carrier c
JOIN Type t ON c.type_id = t.id
LEFT JOIN Rentaler_Concrete rc_details ON c.rentaler_concrete_id = rc_details.id
LEFT JOIN Rentaler rc ON rc_details.rentaler_id = rc.id
GO

-- например:
SELECT *
FROM view_DetailedCarrierInfo;


--2 Любимый жанр пользователя за месяц
CREATE VIEW view_UserTopGenresOfMonth
AS
WITH MonthlyUserGenreViews AS (
    SELECT
        wh.user_id,
        g.id AS genre_id,
        g.name AS genre_name,
        COUNT(*) AS amount_of_views,
        ROW_NUMBER() OVER (PARTITION BY wh.user_id ORDER BY COUNT(*) DESC, g.name ASC) as rang
    FROM WatchHistory wh
    JOIN Movie m ON wh.movie_id = m.id
    JOIN Genre g ON m.genre_id = g.id
    WHERE wh.watched_at >= DATEADD(month, DATEDIFF(month, 0, GETDATE()), 0) -- левая рамка месяца
      AND wh.watched_at < DATEADD(month, DATEDIFF(month, 0, GETDATE()) + 1, 0) -- правая
      AND wh.user_id IS NOT NULL
    GROUP BY wh.user_id, g.id, g.name
)
SELECT
    mu.user_id,
    u.name AS UserName,
    mu.genre_name AS GenreName,
    mu.amount_of_views AS ViewsInMonth,
    mu.rang AS GenreRankInMonth
FROM MonthlyUserGenreViews mu
JOIN [User] u ON mu.user_id = u.id;
-- WHERE mu.rn <= 5;
GO

-- пример
SELECT GenreName, ViewsInMonth, GenreRankInMonth
FROM view_UserTopGenresOfMonth
WHERE user_id = 3 AND GenreRankInMonth <= 5
ORDER BY GenreRankInMonth;