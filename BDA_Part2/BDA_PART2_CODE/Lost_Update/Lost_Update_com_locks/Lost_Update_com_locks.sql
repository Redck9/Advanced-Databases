-- Query Window 1:

SELECT * FROM worst_genre() AS worst_genre, update_function(worst_genre) FOR SHARE;
SELECT pg_sleep(30);
SELECT * FROM worst_genre() AS worst_genre, update_function_for_ww_conflict(worst_genre);

-----------------------------------
-- Query Window 2:

BEGIN;
SELECT * FROM worst_genre() AS worst_genre, update_function(worst_genre);
SELECT * FROM worst_genre() AS worst_genre, update_function_for_ww_conflict(worst_genre);
COMMIT;