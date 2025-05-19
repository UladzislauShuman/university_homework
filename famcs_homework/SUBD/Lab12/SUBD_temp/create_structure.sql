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
  [country_id] int,
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