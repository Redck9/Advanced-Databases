DROP FUNCTION IF EXISTS worst_genre();
CREATE OR REPLACE FUNCTION worst_genre() RETURNS text AS $$

BEGIN

Return(SELECT worst_genre2.genre_name as Wg 
FROM (SELECT band_genre.genre_name, sum(sales_amount) AS total 
      FROM  band_genre, band, album 
      WHERE album.release_date > '12-31-2009' and album.release_date < '01-01-2021' and band_genre.band_id= band.band_id and album.band_id = band.band_id 
      GROUP BY band_genre.genre_name) AS worst_genre2 
ORDER BY worst_genre2.total ASC limit 1);

END;
$$ LANGUAGE plpgsql;

------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS top10albums_worst_genre(text);
CREATE OR REPLACE FUNCTION top10albums_worst_genre(wg text) RETURNS TABLE (album_name text) AS $$

BEGIN
Return Query
SELECT album.album_name
FROM band, band_genre, album WHERE album.release_date > '12-31-2009' and album.release_date < '01-01-2021' and band_genre.genre_name = wg and band.band_id = album.band_id and band.band_id = band_genre.band_id ORDER BY album.sales_amount DESC limit 10;
END;
$$ LANGUAGE plpgsql;

---------------------------------------------------------------------------------
DROP FUNCTION IF EXISTS  update_function(text);
CREATE OR REPLACE FUNCTION update_function(w text) RETURNS void AS $$

BEGIN

UPDATE album
SET sales_amount = (sales_amount * 10)
from (SELECT album.album_name
FROM band, band_genre, album WHERE album.release_date > '12-31-2009' and album.release_date < '01-01-2021' and band_genre.genre_name = w and band.band_id = album.band_id and band.band_id = band_genre.band_id ORDER BY album.sales_amount DESC limit 10
) as wa
WHERE wa.album_name = album.album_name;

END;
$$ LANGUAGE plpgsql;


----------------------------------------------------
DROP FUNCTION IF EXISTS  update_function_for_ww_conflict(text);
CREATE OR REPLACE FUNCTION update_function_for_ww_conflict(w text) RETURNS void AS $$

BEGIN

UPDATE album
SET sales_amount = (sales_amount /10)
from (SELECT album.album_name
FROM band, band_genre, album WHERE album.release_date > '12-31-2009' and album.release_date < '01-01-2021' and band_genre.genre_name = w and band.band_id = album.band_id and band.band_id = band_genre.band_id ORDER BY album.sales_amount DESC limit 10
) as wa
WHERE wa.album_name = album.album_name;

END;
$$ LANGUAGE plpgsql;
