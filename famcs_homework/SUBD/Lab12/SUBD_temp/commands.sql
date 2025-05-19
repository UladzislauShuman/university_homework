-- Задание 2

-- сгенерированно для DBML на сайте https://dbdiagram.io/d
CREATE TABLE [Movie] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
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
  [type_id] INT
)
GO

CREATE TABLE [Type] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [name] VARCHAR(255) NOT NULL
)
GO

CREATE TABLE [RentedCarriers] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [start_rent] TIME NOT NULL,
  [end_rent] TIME NOT NULL,
  [carrier_id] INT,
  [rentaler_concrete_id] INT
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
('USA'),
('Canada'),
('UK'),
('France'),
('Germany'),
('Japan'),
('Australia'),
('Russia'),
('Brazil'),
('India'),
('China'),
('Mexico'),
('South Korea'),
('Italy'),
('Spain');

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

-- Пример для USA (id=1), LocalityType: CITY=2, VILLAGE=1
INSERT INTO Locality (country_id, locality_type_id, name) VALUES
(1, 2, 'New York'),
(1, 2, 'Los Angeles'),
(1, 2, 'Chicago'),
(1, 1, 'Greenwich Village'),
(1, 1, 'Sleepy Hollow'),
(2, 2, 'Toronto'),
(2, 1, 'Niagara-on-the-Lake'),
(3, 2, 'London'),
(3, 1, 'Little Venice'),
(4, 2, 'Paris'),
(4, 1, 'Giverny'),
(5, 2, 'Berlin'),
(5, 1, 'Neuhardenberg'),
(6, 2, 'Tokyo'),
(6, 1, 'Mitaka');


INSERT INTO Address (locality_id, street, house) VALUES
(1, 'Broadway', 123),
(2, 'Sunset Blvd', 45),
(3, 'Michigan Ave', 100),
(4, 'Washington Square', 12),
(5, 'Main St', 77),
(6, 'Queen St', 555),
(7, 'King St', 101),
(8, 'Baker St', 221),
(9, 'Rose St', 5),
(10, 'Champs Elysees', 10),
(11, 'Rue de Paris', 1),
(12, 'Unter den Linden', 8),
(13, 'Hauptstrasse', 15),
(14, 'Shinjuku', 3),
(15, 'Mitaka St', 7);

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
(2700, 'Blu-ray 3D Disc', 15);


INSERT INTO Recording_Format (name) VALUES
('PAL'),
('NTSC'),
('SECAM'),
('HD'),
('4K'),
('8K'),
('HDR'),
('SD'),
('Blu-ray'),
('DVD');

INSERT INTO Genre (name) VALUES
('Action'),
('Comedy'),
('Drama'),
('Horror'),
('Thriller'),
('Romance'),
('Sci-Fi'),
('Fantasy'),
('Documentary'),
('Animation'),
('Adventure'),
('Crime'),
('Mystery'),
('Musical'),
('Western');

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
(1, 'Steven Spielberg', 'Famous American director'),
(2, 'James Cameron', 'Canadian director known for Titanic'),
(3, 'Christopher Nolan', 'British-American film director'),
(4, 'Luc Besson', 'French film director and producer'),
(5, 'Werner Herzog', 'German film director'),
(6, 'Hayao Miyazaki', 'Japanese animation director'),
(7, 'Baz Luhrmann', 'Australian director known for musicals'),
(8, 'Andrei Tarkovsky', 'Russian filmmaker'),
(9, 'José Padilha', 'Brazilian director'),
(10, 'Satyajit Ray', 'Indian film director'),
(11, 'Zhang Yimou', 'Chinese director'),
(12, 'Guillermo del Toro', 'Mexican director'),
(13, 'Park Chan-wook', 'South Korean director'),
(14, 'Paolo Sorrentino', 'Italian director'),
(15, 'Pedro Almodóvar', 'Spanish director');

INSERT INTO Movie (description, rating, age_limit, number_of_views, duration, release_year, country_id, website_id, publisher_id, director_id, genre_id) VALUES
('Epic space adventure', 9, 13, 10000, 150, 2010, 1, 1, 1, 3, 7),
('Romantic comedy about love', 7, 12, 5000, 120, 2015, 3, 3, 11, 3, 6),
('Thrilling crime drama', 8, 16, 7000, 130, 2005, 5, 5, 2, 1, 12),
('Animated children movie', 10, 0, 20000, 90, 2018, 6, 3, 11, 6, 10),
('Historical documentary', 6, 0, 3000, 110, 2012, 4, 6, 13, 5, 9),
('Horror story in village', 5, 18, 4000, 100, 2011, 8, 4, 14, 8, 4),
('Fantasy epic saga', 9, 13, 8000, 140, 2014, 7, 7, 3, 7, 8),
('Action packed thriller', 8, 16, 9000, 115, 2013, 1, 2, 1, 2, 1),
('Comedy about everyday life', 7, 0, 6000, 105, 2016, 3, 3, 14, 3, 2),
('Mystery crime story', 8, 16, 4000, 125, 2009, 5, 9, 2, 1, 13),
('Sci-Fi thriller', 9, 14, 11000, 130, 2017, 1, 1, 3, 3, 7),
('Romantic drama', 7, 12, 4500, 100, 2018, 3, 3, 11, 3, 6),
('Documentary about nature', 8, 0, 2000, 90, 2014, 4, 6, 13, 5, 9),
('Animation adventure', 9, 0, 15000, 95, 2019, 6, 3, 11, 6, 10),
('Western cowboy story', 7, 16, 3000, 130, 2010, 1, 2, 1, 1, 15);

INSERT INTO Collection (name, description) VALUES
('Best of Sci-Fi', 'Top rated science fiction movies'),
('Romantic Classics', 'Best romantic movies of all time'),
('Horror Night', 'Scary horror movies'),
('Family Fun', 'Movies suitable for family viewing'),
('Comedy Hits', 'Top comedy movies'),
('Action Thrillers', 'Best action packed thrillers'),
('Documentaries', 'Educational and informative films'),
('Animated Favorites', 'Popular animated movies'),
('Crime Stories', 'Best crime drama movies'),
('Fantasy Worlds', 'Movies set in fantasy universes'),
('Adventure Journeys', 'Exciting adventure movies'),
('Mystery and Suspense', 'Intriguing mystery films'),
('Western Legends', 'Classic western films'),
('Musicals', 'Famous musical movies'),
('International Cinema', 'Best foreign movies');

INSERT INTO MovieCollection (collection_id, movie_id) VALUES
(1,1),(2,2),(3,6),(4,4),(5,9),
(6,8),(7,5),(8,14),(9,3),(10,7),
(11,11),(12,10),(13,15),(14,2),(15,13);

INSERT INTO [User] (age, name) VALUES
(45, 'Mom'),
(48, 'Dad'),
(20, 'Daughter'),
(18, 'Son'),
(3, 'Cat');


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

-- Dad 
(2, 2, '2024-04-10T18:45:00'),
(4, 2, '2024-04-12T20:00:00'),
(6, 2, '2024-04-13T21:15:00'),
(8, 2, '2024-04-15T19:00:00'),
(10, 2, '2024-04-17T20:30:00'),

-- Daughter 
(11, 3, '2024-03-20T17:00:00'),
(12, 3, '2024-03-22T18:00:00'),
(13, 3, '2024-03-24T19:15:00'),
(14, 3, '2024-03-26T20:45:00'),
(15, 3, '2024-03-28T21:30:00'),

-- Son
(1, 4, '2024-02-10T16:30:00'),
(4, 4, '2024-02-12T17:45:00'),
(7, 4, '2024-02-14T19:00:00'),
(10, 4, '2024-02-16T20:15:00'),
(13, 4, '2024-02-18T21:00:00'),

-- Cat
(2, 5, '2024-01-05T15:00:00'),
(5, 5, '2024-01-07T16:30:00'),
(8, 5, '2024-01-09T17:45:00'),
(11, 5, '2024-01-11T19:00:00'),
(14, 5, '2024-01-13T20:30:00');
-- Задание 4
-- сформировать запросы

-- 1
-- Любимый жанр месяца пользователя
SELECT TOP 1 g.name AS favorite_genre, COUNT(*) AS views_count
FROM WatchHistory wh
JOIN Movie m ON wh.movie_id = m.id
JOIN Genre g ON m.genre_id = g.id
WHERE wh.user_id = 3 -- ID пользователя (например, Daughter)
  AND wh.watched_at >= DATEADD(month, -1, GETDATE())
GROUP BY g.name
ORDER BY views_count DESC;

-- 2
-- любимый режисер пользоватля
SELECT TOP 1 d.name AS favorite_director, COUNT(*) AS movies_watched
FROM WatchHistory wh
JOIN Movie m ON wh.movie_id = m.id
JOIN Director d ON m.director_id = d.id
WHERE wh.user_id = 1 -- ID пользователя (например, Mom)
GROUP BY d.name
ORDER BY movies_watched DESC;

-- 3
-- фильмы режисёра
SELECT m.description AS movie_title, m.release_year, m.rating
FROM Movie m
JOIN Director d ON m.director_id = d.id
WHERE d.name = 'Christopher Nolan' -- Имя режиссера
ORDER BY m.release_year DESC;

-- 4 
-- самый популярный фильм среди домоседцев
SELECT TOP 1 m.description AS most_popular_movie, COUNT(*) AS times_watched
FROM WatchHistory wh
JOIN Movie m ON wh.movie_id = m.id
GROUP BY m.description
ORDER BY times_watched DESC;

-- 5
-- фильмы, которые можно смотреть всей семье
SELECT m.description, m.age_limit, g.name AS genre
FROM Movie m
JOIN Genre g ON m.genre_id = g.id
WHERE m.age_limit <= 12
ORDER BY m.rating DESC;


-- что я хочу еще добавить
-- добавить таблицу UserFavorityDirector 


