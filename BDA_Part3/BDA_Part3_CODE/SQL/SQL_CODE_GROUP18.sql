-- CREATE TABLES


-- Table worst_genre_2010:

CREATE TABLE worst_genre_2010 AS
SELECT band_genre.genre_name, sum(sales_amount) AS total FROM  band_genre, band, album WHERE album.release_date > '12-31-2009' and album.release_date < '01-01-2021' and band_genre.band_id= band.band_id and album.band_id = band.band_id GROUP BY band_genre.genre_name


-- Table albuns_worst_genre_2010:
CREATE TABLE albuns_worst_genre_2010AS
SELECT band.band_name, album.album_name, band_genre.genre_name
FROM band, band_genre, album, (SELECT worst_genre.genre_name FROM (SELECT band_genre.genre_name, sum(sales_amount) AS total FROM  band_genre, band, album WHERE album.release_date > '12-31-2009' and album.release_date < '01-01-2021' and band_genre.band_id= band.band_id and album.band_id = band.band_id GROUP BY band_genre.genre_name) AS worst_genre ORDER BY worst_genre.total ASC limit 1) AS wg
WHERE album.release_date > '12-31-2009' and album.release_date < '01-01-2021' and band_genre.genre_name = wg.genre_name and band.band_id = album.band_id and band.band_id = band_genre.band_id ORDER BY album.sales_amount DESC limit 10 


CREATE TABLE albuns_worst_genre_2010 AS

--Queries

--Complex Operation 1: Choose the genre less sold from the last decade and select the 10 best albums of that genre.

SELECT band.band_name, album.album_name, band_genre.genre_name
FROM band, band_genre, album,
  (SELECT worst_genre_2010.genre_name
  FROM
   worst_genre_2010
  ORDER BY worst_genre_2010.total ASC limit 1) AS wg
WHERE band_genre.genre_name = wg.genre_name and band.band_id = album.band_id and 
band.band_id = band_genre.band_id
ORDER BY album.sales_amount DESC limit 10;

--Complex Operation Discover the worst genre in the last decade and up their sales 10 times the original value 

 UPDATE album
SET sales_amount = (sales_amount * 10)
FROM albuns_worst_genre_2010
WHERE albuns_worst_genre_2010.album_name = album.album_name;

