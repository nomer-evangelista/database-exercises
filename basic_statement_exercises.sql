SHOW DATABASES;
USE albums_db;
SELECT DATABASE();
SHOW TABLES;
SHOW CREATE TABLE albums;
# What is the primary key for the albums table?
-- id
-- # What does the column named 'name' represent?
DESCRIBE albums;
SELECT * FROM albums;
# What do you think the sales column represents?
-- Music Album
SELECT * FROM albums WHERE artist = 'Pink Floyd';
# Find the name of all albums by Pink Floyd.
-- The Dark Side of the Moon, The Wall
SELECT * FROM albums WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';
# What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
-- The Beatles
SELECT genre, artist, name FROM albums WHERE name = 'Nevermind';
# What is the genre for the album Nevermind?
-- Grunge, Alternative rock
SELECT release_date, name, artist FROM albums WHERE release_date = '1990';
# Which albums were released in the 1990s?
-- The Immaculate Collection
SELECT id, name AS low_selling_albums, artist, sales FROM albums WHERE sales < '20';
# Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.
/* Grease: The Original Soundtrack from the Motion Picture, Bad, Sgt. Pepper's Lonely Hearts Club Band, Dirty Dancing, 
Let's Talk About Love, Dangerous, The Immaculate Collection, Abbey Road, Born in the U.S.A., Brothers in Arms,
Titanic: Music from the Motion Picture, Nevermind, The Wall */	
 