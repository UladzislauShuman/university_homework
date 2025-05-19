-- ������� 3
-- ������ ������ � ��������� �������
INSERT INTO Country  VALUES 
(N'������'),
(N'���'),
(N'�������'),
(N'��������'),
(N'������'),
(N'����� �����'),
(N'�����'),
(N'��������������'),
(N'������'),
(N'�������'),
(N'�����'),
(N'��������');
select * from Country;


INSERT INTO Genre (name) VALUES 
(N'�������'),
(N'�����'),
(N'������'),
(N'����������'),
(N'���������'),
(N'�����'),
(N'�������'),
(N'��������������'),
(N'��������'),
(N'������������'),
(N'�������'),
(N'��������');
select * from Genre;

-- ���  
INSERT INTO Website (name, url) VALUES 
(N'���������', N'https://www.kinopoisk.ru'),
(N'IMDb', N'https://www.imdb.com'),
(N'Rotten Tomatoes', N'https://www.rottentomatoes.com'),
(N'Film.ru', N'https://www.film.ru'),
(N'����-�����.��', N'https://www.kino-teatr.ru'),
(N'MoviePilot', N'https://www.moviepilot.de'),
(N'MyDramaList', N'https://mydramalist.com'),
(N'AsianWiki', N'https://asianwiki.com'),
(N'SensCritique', N'https://www.senscritique.com'),
(N'Metacritic', N'https://www.metacritic.com'),
(N'ReviewFilm', N'https://reviewfilm.ru'),
(N'�����.������', N'https://film.online');
select * from Website;

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
select * from Publisher;

INSERT INTO Director (name, country_id, description)
SELECT D.name, id, D.description FROM (
    VALUES 
    (N'������ ���������', N'������', N'��������� ���������� �������.'),
    (N'��������� �����', N'��������������', N'����� ������� ������ � �������������.'),
    (N'������� ���������', N'���', N'�������� � ������������� �������.'),
    (N'���� ��������', N'������', N'������ �������� � �����.'),
    (N'��� ���� ��', N'����� �����', N'������������ ������� ���������.'),
    (N'������� ����', N'�������', N'����������� ����� � ����������.'),
    (N'�������� �������', N'������', N'������� ������������ ����.'),
    (N'����� �����', N'��������������', N'���������� ������� � �������.'),
    (N'������ ����������', N'������', N'���� �� ��������������� ����.'),
    (N'��� ������', N'���', N'���������� �������-�������.'),
    (N'����������', N'�������', N'��������� ������� �� ������.'),
    (N'������ ����������', N'������', N'���������, ������������ � �����.')
) AS D(name, country, description)
JOIN Country ON Country.name = D.country;


INSERT INTO Movie (description, rating, age_limit, number_of_views, duration, release_year, country_id, website_id, publisher_id, director_id, genre_id)
VALUES
(N'�������������� ����� � �������.', 9, 16, 1500000, 120, 2022, 
  (SELECT id FROM Country WHERE name = N'���'),
  (SELECT id FROM Website WHERE name = N'IMDb'),
  (SELECT id FROM Publisher WHERE name = N'Warner Bros.'),
  (SELECT id FROM Director WHERE name = N'��������� �����'),
  (SELECT id FROM Genre WHERE name = N'����������')),

(N'����� � �����, ������������ ������.', 8, 12, 500000, 110, 2021,
  (SELECT id FROM Country WHERE name = N'������'),
  (SELECT id FROM Website WHERE name = N'���������'),
  (SELECT id FROM Publisher WHERE name = N'Mosfilm'),
  (SELECT id FROM Director WHERE name = N'������ ���������'),
  (SELECT id FROM Genre WHERE name = N'�����')),

(N'������� � ����������, ������� ������ ���� �����.', 7, 12, 800000, 95, 2020, 
  (SELECT id FROM Country WHERE name = N'��������������'),
  (SELECT id FROM Website WHERE name = N'Rotten Tomatoes'),
  (SELECT id FROM Publisher WHERE name = N'Paramount Pictures'),
  (SELECT id FROM Director WHERE name = N'��� ����'),
  (SELECT id FROM Genre WHERE name = N'�������')),

(N'������������ ������� ����� �� ���� �����.', 8, 16, 700000, 130, 2019, 
  (SELECT id FROM Country WHERE name = N'�������'),
  (SELECT id FROM Website WHERE name = N'Film.ru'),
  (SELECT id FROM Publisher WHERE name = N'Universal Pictures'),
  (SELECT id FROM Director WHERE name = N'���-���� ����'),
  (SELECT id FROM Genre WHERE name = N'���������')),

(N'����� ������ � ����������� ����.', 6, 18, 300000, 100, 2023, 
  (SELECT id FROM Country WHERE name = N'��������'),
  (SELECT id FROM Website WHERE name = N'����-�����.��'),
  (SELECT id FROM Publisher WHERE name = N'Sony Pictures'),
  (SELECT id FROM Director WHERE name = N'������� �����'),
  (SELECT id FROM Genre WHERE name = N'�����')),

(N'�������������� ����� � ������� � ��������.', 9, 0, 200000, 60, 2021, 
  (SELECT id FROM Country WHERE name = N'������'),
  (SELECT id FROM Website WHERE name = N'MyDramaList'),
  (SELECT id FROM Publisher WHERE name = N'Ghibli'),
  (SELECT id FROM Director WHERE name = N'��������� �����'),
  (SELECT id FROM Genre WHERE name = N'��������������')),

(N'������������ ����� � ������ ����� ������ � ���������.', 8, 6, 900000, 85, 2020, 
  (SELECT id FROM Country WHERE name = N'������'),
  (SELECT id FROM Website WHERE name = N'AsianWiki'),
  (SELECT id FROM Publisher WHERE name = N'Mosfilm'),
  (SELECT id FROM Director WHERE name = N'���� ��������'),
  (SELECT id FROM Genre WHERE name = N'��������')),

(N'������ � �������������� ������� �� �������.', 7, 16, 1300000, 105, 2022, 
  (SELECT id FROM Country WHERE name = N'����� �����'),
  (SELECT id FROM Website WHERE name = N'Rotten Tomatoes'),
  (SELECT id FROM Publisher WHERE name = N'Paramount Pictures'),
  (SELECT id FROM Director WHERE name = N'��� ���'),
  (SELECT id FROM Genre WHERE name = N'������')),

(N'������� � ����� � ������������.', 9, 12, 2000000, 140, 2023, 
  (SELECT id FROM Country WHERE name = N'�����'),
  (SELECT id FROM Website WHERE name = N'SensCritique'),
  (SELECT id FROM Publisher WHERE name = N'Walt Disney'),
  (SELECT id FROM Director WHERE name = N'��� ������'),
  (SELECT id FROM Genre WHERE name = N'�������')),

(N'��������� � ������� ���������� � �����.', 7, 18, 100000, 95, 2021, 
  (SELECT id FROM Country WHERE name = N'�������'),
  (SELECT id FROM Website WHERE name = N'Metacritic'),
  (SELECT id FROM Publisher WHERE name = N'Warner Bros.'),
  (SELECT id FROM Director WHERE name = N'����� ����������'),
  (SELECT id FROM Genre WHERE name = N'���������')),

(N'����� � ���������� � �� ��������� � �����.', 7, 12, 750000, 100, 2019, 
  (SELECT id FROM Country WHERE name = N'�����'),
  (SELECT id FROM Website WHERE name = N'Rotten Tomatoes'),
  (SELECT id FROM Publisher WHERE name = N'Pixar'),
  (SELECT id FROM Director WHERE name = N'���� �����'),
  (SELECT id FROM Genre WHERE name = N'�������')),

(N'��������������� ������� � ������������ � ����������.', 8, 18, 900000, 105, 2022, 
  (SELECT id FROM Country WHERE name = N'��������'),
  (SELECT id FROM Website WHERE name = N'IMDb'),
  (SELECT id FROM Publisher WHERE name = N'Sony Pictures'),
  (SELECT id FROM Director WHERE name = N'����� ������'),
  (SELECT id FROM Genre WHERE name = N'�������'));

INSERT INTO Collection (name, description) VALUES 
(N'������ �����', N'������� ������������ � ������� ������������� �������.'),
(N'������� ��� ���� �����', N'������ ������, ���������� ��� ��������� ���������.'),
(N'������ ������', N'������ ������� � �������� �����.'),
(N'������� �����������', N'������������ ������, ������ ����� � �����.'),
(N'�������� ����', N'����� ��������� ������ ���� �����.'),
(N'������ � �����', N'�������, ���������� �� �������� ��������.'),
(N'���������� � �������', N'���� ����� � ����������.'),
(N'������������ �����', N'������ � ������������ � ���������.'),
(N'������� � ������������ ����', N'������������� ������ � �������� �������.'),
(N'������ ������ ����', N'���� ��������� ���.');

INSERT INTO MovieCollection (collection_id, movie_id)
SELECT 
    (SELECT id FROM Collection WHERE name = N'������ �����'),
    (SELECT id FROM Movie WHERE name = N'���������� 2045')
UNION ALL
SELECT 
    (SELECT id FROM Collection WHERE name = N'������ �����'),
    (SELECT id FROM Movie WHERE name = N'����� � �������')
UNION ALL
SELECT 
    (SELECT id FROM Collection WHERE name = N'������� ��� ���� �����'),
    (SELECT id FROM Movie WHERE name = N'������������ �������')
UNION ALL
SELECT 
    (SELECT id FROM Collection WHERE name = N'������� ��� ���� �����'),
    (SELECT id FROM Movie WHERE name = N'������ � �����')
UNION ALL
SELECT 
    (SELECT id FROM Collection WHERE name = N'������ ������'),
    (SELECT id FROM Movie WHERE name = N'��� �� �����')
UNION ALL
SELECT 
    (SELECT id FROM Collection WHERE name = N'������ ������'),
    (SELECT id FROM Movie WHERE name = N'����� � �����')
UNION ALL
SELECT 
    (SELECT id FROM Collection WHERE name = N'������� �����������'),
    (SELECT id FROM Movie WHERE name = N'������ �� �����')
UNION ALL
SELECT 
    (SELECT id FROM Collection WHERE name = N'������� �����������'),
    (SELECT id FROM Movie WHERE name = N'����� ����')
UNION ALL
SELECT 
    (SELECT id FROM Collection WHERE name = N'�������� ����'),
    (SELECT id FROM Movie WHERE name = N'����� ��������')
UNION ALL
SELECT 
    (SELECT id FROM Collection WHERE name = N'�������� ����'),
    (SELECT id FROM Movie WHERE name = N'������� ���������');


INSERT INTO User (age, name)
VALUES 
(45, N'����'),
(47, N'����'),
(17, N'�����'),
(14, N'���');

INSERT INTO UserFavoriteMovies (user_id, movie_id)
SELECT 
    (SELECT id FROM User WHERE name = N'����'),
    (SELECT id FROM Movie WHERE name = N'���������� 2045')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'����'),
    (SELECT id FROM Movie WHERE name = N'����� � �������')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'����'),
    (SELECT id FROM Movie WHERE name = N'���������� ����')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'����'),
    (SELECT id FROM Movie WHERE name = N'������ � �����')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'����'),
    (SELECT id FROM Movie WHERE name = N'����� ��������')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'����'),
    (SELECT id FROM Movie WHERE name = N'������������ �������')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'����'),
    (SELECT id FROM Movie WHERE name = N'������� ���������')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'����'),
    (SELECT id FROM Movie WHERE name = N'����� ��������')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'����'),
    (SELECT id FROM Movie WHERE name = N'����� ����')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'�����'),
    (SELECT id FROM Movie WHERE name = N'��� �� �����')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'�����'),
    (SELECT id FROM Movie WHERE name = N'����� � �����')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'�����'),
    (SELECT id FROM Movie WHERE name = N'��� ������')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'�����'),
    (SELECT id FROM Movie WHERE name = N'������ �� �����')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'���'),
    (SELECT id FROM Movie WHERE name = N'����� ����')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'���'),
    (SELECT id FROM Movie WHERE name = N'������ � �����')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'���'),
    (SELECT id FROM Movie WHERE name = N'��� ������');

INSERT INTO UserFavoriteGenre (user_id, genre_id)
SELECT 
    (SELECT id FROM User WHERE name = N'����'),
    (SELECT id FROM Genre WHERE name = N'����������')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'����'),
    (SELECT id FROM Genre WHERE name = N'�����')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'����'),
    (SELECT id FROM Genre WHERE name = N'�������')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'����'),
    (SELECT id FROM Genre WHERE name = N'���������')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'����'),
    (SELECT id FROM Genre WHERE name = N'�����')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'����'),
    (SELECT id FROM Genre WHERE name = N'����������')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'����'),
    (SELECT id FROM Genre WHERE name = N'�������')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'����'),
    (SELECT id FROM Genre WHERE name = N'�������')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'�����'),
    (SELECT id FROM Genre WHERE name = N'���������')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'�����'),
    (SELECT id FROM Genre WHERE name = N'����������')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'�����'),
    (SELECT id FROM Genre WHERE name = N'��������')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'�����'),
    (SELECT id FROM Genre WHERE name = N'�������')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'���'),
    (SELECT id FROM Genre WHERE name = N'�����')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'���'),
    (SELECT id FROM Genre WHERE name = N'�������')
UNION ALL
SELECT 
    (SELECT id FROM User WHERE name = N'���'),
    (SELECT id FROM Genre WHERE name = N'����������');

INSERT INTO WatchHistory (movie_id, user_id, watched_at)
SELECT 
    (SELECT id FROM Movie WHERE name = N'���������� 2045'),
    (SELECT id FROM User WHERE name = N'����'),
    '2025-03-01 15:00:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'����� � �������'),
    (SELECT id FROM User WHERE name = N'����'),
    '2025-04-15 20:30:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'���������� ����'),
    (SELECT id FROM User WHERE name = N'�����'),
    '2025-02-20 10:15:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'������ � �����'),
    (SELECT id FROM User WHERE name = N'���'),
    '2025-03-12 18:45:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'����� ��������'),
    (SELECT id FROM User WHERE name = N'����'),
    '2025-05-01 22:00:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'������������ �������'),
    (SELECT id FROM User WHERE name = N'����'),
    '2025-03-25 13:30:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'������� ���������'),
    (SELECT id FROM User WHERE name = N'����'),
    '2025-04-01 19:00:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'����� ����'),
    (SELECT id FROM User WHERE name = N'���'),
    '2025-04-10 14:00:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'��� �� �����'),
    (SELECT id FROM User WHERE name = N'�����'),
    '2025-04-02 11:00:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'����� � �����'),
    (SELECT id FROM User WHERE name = N'�����'),
    '2025-05-05 09:30:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'��� ������'),
    (SELECT id FROM User WHERE name = N'���'),
    '2025-02-28 16:00:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'������ �� �����'),
    (SELECT id FROM User WHERE name = N'�����'),
    '2025-05-10 17:45:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'����� ��������'),
    (SELECT id FROM User WHERE name = N'����'),
    '2025-05-07 21:00:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'����� ����'),
    (SELECT id FROM User WHERE name = N'���'),
    '2025-05-03 15:30:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'��� ������'),
    (SELECT id FROM User WHERE name = N'���'),
    '2025-05-05 11:00:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'����� � �������'),
    (SELECT id FROM User WHERE name = N'����'),
    '2025-03-10 12:00:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'������� ���������'),
    (SELECT id FROM User WHERE name = N'����'),
    '2025-04-05 20:00:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'���������� 2045'),
    (SELECT id FROM User WHERE name = N'����'),
    '2025-04-20 14:30:00'
UNION ALL
SELECT 
    (SELECT id FROM Movie WHERE name = N'������������ �������'),
    (SELECT id FROM User WHERE name = N'����'),
    '2025-05-02 10:00:00';
