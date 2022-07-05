-- CREATE TABLES


-- Table Banda:

CREATE TABLE band( 
band_id SERIAL,
band_uri text,
band_name text, 
PRIMARY KEY (band_id)); 

-- Table Album:
CREATE TABLE album( 
band_id integer,
album_id SERIAL,
album_name text, 
release_date date, 
description text, 
running_time numeric, 
sales_amount numeric, 
PRIMARY KEY(band_id, album_id), 
FOREIGN KEY (band_id) REFERENCES band ON DELETE CASCADE);

-- Table Band_genre:
CREATE TABLE band_genre (
band_id integer,
genre_name text, 
PRIMARY KEY(band_id, genre_name), 
FOREIGN KEY (band_id) REFERENCES band);

-- Table Member:
CREATE TABLE member(
member_id SERIAL,
member_uri text,
PRIMARY KEY (member_id));


-- Table Band_Members:
CREATE TABLE band_members(
band_id integer,
member_id integer,
current_member boolean,
PRIMARY KEY(band_id, member_id),
FOREIGN KEY (band_id) REFERENCES band, 
FOREIGN KEY (member_id) REFERENCES member; 

-- Table member_names:
CREATE TABLE member_names(
member_id integer,
name_id SERIAL,
name text,
PRIMARY KEY (name_id, member_id),
FOREIGN KEY (member_id) REFERENCES member);


--INSERTS


-- Table band:
COPY band(band_uri, band_name) FROM '/home/redck/Documents/Base de dados Anvaçada/Trabalho Prático/csv_files/band-band_name.csv' DELIMITER ';' CSV HEADER;

-- Table MEMBER:
CREATE TEMP TABLE tmp AS SELECT member_uri FROM member;

COPY tmp(member_uri) FROM '/home/redck/Documents/Base de dados Anvaçada/Trabalho Prático/csv_files/band-member-final.csv' DELIMITER ';' CSV HEADER;

INSERT INTO member(member_uri) SELECT DISTINCT ON (member_uri) * FROM tmp

DROP TABLE tmp

-- Table MEMBER_NAMES:
CREATE TEMP TABLE tmp AS SELECT member_uri, name FROM member, member_names;

COPY tmp(member_uri, name) FROM '/home/redck/Documents/Base de dados Anvaçada/Trabalho Prático/csv_files/band-member-names-final.csv' DELIMITER ';' CSV HEADER;

INSERT INTO member_names(member_id, name) SELECT DISTINCT m.member_id, t.name FROM tmp t, member m WHERE t.member_uri = m.member_uri ;  


-- Table ALBUM:

CREATE TEMP TABLE tmp AS SELECT band_uri, album_name, release_date, description, running_time, sales_amount FROM band, album;

COPY tmp(band_uri, album_name, release_date, description, running_time, sales_amount) FROM '/home/redck/Documents/Base de dados Anvaçada/Trabalho Prático/csv_files/band-album.csv' DELIMITER ';' CSV HEADER;

INSERT INTO album(band_id,album_name,release_date,description, running_time, sales_amount) SELECT DISTINCT b.band_id ,t.album_name, t.release_date, t.description, t.running_time, t.sales_amount FROM tmp t, band b WHERE t.band_uri = b.band_uri ;  


-- Table band_genre:
CREATE TEMP TABLE tmp AS SELECT band_uri, genre_name FROM band, band_genre;

COPY tmp(band_uri, genre_name) FROM '/home/redck/Documents/Base de dados Anvaçada/Trabalho Prático/csv_files/band-genre_name.csv' DELIMITER ';' CSV HEADER;

INSERT INTO band_genre(band_id,genre_name) SELECT b.band_id ,t.genre_name FROM tmp t, band b WHERE t.band_uri = b.band_uri ;  


-- Table Band_Members:

CREATE TEMP TABLE tmp AS SELECT band_uri, member_uri, current_member FROM band, member,band_Members;

COPY tmp(band_uri, member_uri, current_member) FROM '/home/redck/Documents/Base de dados Anvaçada/Trabalho Prático/csv_files/band-members.csv' DELIMITER ';' CSV HEADER;
INSERT INTO band_Members(band_id,member_id,current_member) SELECT b.band_id ,m.member_id, t.current_member FROM tmp t, band b, member m WHERE t.band_uri = b.band_uri and t.member_uri = m.member_uri ON CONFLICT DO NOTHING;


--Queries

--Complex Operation 1: Choose the genre less sold from the last decade and select the 10 best albums of that genre.


SELECT band.band_name, album.album_name, band_genre.genre_name
FROM band, band_genre, album, (SELECT worst_genre.genre_name FROM (SELECT band_genre.genre_name, sum(sales_amount) AS total FROM  band_genre, band, album WHERE album.release_date > '12-31-2009' and album.release_date < '01-01-2021' and band_genre.band_id= band.band_id and album.band_id = band.band_id GROUP BY band_genre.genre_name) AS worst_genre ORDER BY worst_genre.total ASC limit 1) AS wg
WHERE album.release_date > '12-31-2009' and album.release_date < '01-01-2021' and band_genre.genre_name = wg.genre_name and band.band_id = album.band_id and band.band_id = band_genre.band_id ORDER BY album.sales_amount DESC limit 10;

--Complex Operation Discover the worst genre in the last decade and up their sales 10 times the original value 

UPDATE album
SET sales_amount = (sales_amount * 10)
FROM (SELECT band.band_name, album.album_name, band_genre.genre_name
FROM band, band_genre, album, (SELECT worst_genre.genre_name FROM (SELECT band_genre.genre_name, sum(sales_amount) AS total FROM  band_genre, band, album WHERE album.release_date > '12-31-2009' and album.release_date < '01-01-2021' and band_genre.band_id= band.band_id and album.band_id = band.band_id GROUP BY band_genre.genre_name) AS worst_genre ORDER BY worst_genre.total ASC limit 1) AS wg
WHERE album.release_date > '12-31-2009' and album.release_date < '01-01-2021' and band_genre.genre_name = wg.genre_name and band.band_id = album.band_id and band.band_id = band_genre.band_id ORDER BY album.sales_amount DESC limit 10) AS wg
WHERE wg.album_name = album.album_name

