SHOW DATABASES;
USE albums_db;
SELECT DATABASE();
SHOW TABLES;
SHOW CREATE TABLE albums;

# 2. What is the primary key for the albums table?
-- id
DESCRIBE albums;

# 3. What does the column named 'name' represent?
-- Music Album title
SELECT * FROM albums;

# 4. What do you think the sales column represents?
-- music album sales

# 5. Find the name of all albums by Pink Floyd.
-- The Dark Side of the Moon, The Wall
SELECT * FROM albums WHERE artist = 'Pink Floyd';

# 6. What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
-- 1967
SELECT * FROM albums WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

# 7. What is the genre for the album Nevermind?
-- Grunge, Alternative rock
SELECT genre, artist, name FROM albums WHERE name = 'Nevermind';

# 8. Which albums were released in the 1990s?
/* Abbey Road, Appetite for Destruction, Back in Black, Bad, Bat Out of Hell, Born in the U.S.A., Brothers in Arms, Dirty Dancing, 
Grease: The Original Soundtrack from the Motion Picture, Hotel California, Led Zeppelin IV, Rumours, Saturday Night Fever, 
Sgt. Pepper's Lonely Hearts Club Band, The Dark Side of the Moon, The Immaculate Collection, The Wall, Their Greatest Hits (1971–1975), 
 Thriller */ 
SELECT release_date, name, artist FROM albums WHERE release_date <= '1990'ORDER BY name;

# 9. Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.
/* Grease: The Original Soundtrack from the Motion Picture, Bad, Sgt. Pepper's Lonely Hearts Club Band, Dirty Dancing, 
Let's Talk About Love, Dangerous, The Immaculate Collection, Abbey Road, Born in the U.S.A., Brothers in Arms,
Titanic: Music from the Motion Picture, Nevermind, The Wall */	
SELECT id, name AS low_selling_albums, artist, sales FROM albums WHERE sales < '20';

