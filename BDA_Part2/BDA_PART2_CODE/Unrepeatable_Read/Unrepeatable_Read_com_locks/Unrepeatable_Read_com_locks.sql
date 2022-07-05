-- Query Window 1:

SELECT * from worst_genre() FOR SHARE;
SELECT pg_sleep(30);
SELECT * FROM worst_genre();

-----------------------------------
-- Query Window 2:

BEGIN;
SELECT * FROM worst_genre();
SELECT * FROM worst_genre() AS worst_genre, update_function(worst_genre);
COMMIT;