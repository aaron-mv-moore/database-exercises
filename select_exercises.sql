-- SELECT exercises
	USE albums_db;
	SHOW TABLES;
	DESCRIBE albums;
	SELECT * FROM albums LIMIT 10;

-- How many rows are in the albums table?
	-- A: 31
	SELECT count(*) AS 'total items' 
	FROM albums;

-- How many unique artist names are in the albums table? 
	-- A: 23
	SELECT count(DISTINCT artist) 
	FROM albums;

-- What is the primary key for the albums table?
	-- A: the id column
	DESCRIBE albums;

-- What is the oldest release date for any album in the albums table? What is the most recent release date?
	-- A: Oldest = 1967; Newest = 2011
	SELECT max(release_date), min(release_date)
	FROM albums;

-- The name of all albums by Pink Floyd
	-- A: The Dark Side of the Moon; The Wall
	SELECT * 
	FROM albums 
	WHERE artist LIKE '%Floyd';

-- The year Sgt. Pepper's Lonely Hearts Club Band was released
	-- A: 1967
	SELECT artist, name, release_date 
	FROM albums 
	WHERE name LIKE '%Club Band';

-- The genre for the album Nevermind
	-- A: Grunge, Alternative rock
	SELECT * 
	FROM albums 
	WHERE name = 'Nevermind';

-- Which albums were released in the 1990s
	-- A: The Bodyguard, Jagged Little Pill, Come On OverFalling into You, Let's Talk About Love, Dangerous, The Immaculate Collection, Titanic: Music from the Motion Picture, Metallica, Nevermind, Supernatural
	SELECT name 
	FROM albums 
	WHERE release_date < 2000 
	AND release_date > 1989;

-- Which albums had less than 20 million certified sales
	-- A:Grease: The Original Soundtrack from the Motion Picture, Bad, Sgt. Pepper's Lonely Hearts Club Band, Dirty Dancing, Let's Talk About Love, Dangerous, The Immaculate Collection, Abbey Road, Born in the U.S.A., Brothers in Arms, Titanic: Music from the Motion Picture, Nevermind, The Wall
	SELECT name 
	FROM albums 
	WHERE sales < 20;


-- All the albums with a genre of "Rock". 
	SELECT * 
	FROM albums 
	WHERE genre = 'Rock';
	-- Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
	-- A: querying "Rock" without something to tell the computer wyou want more than only "Rock" is why. The computer is looking only for what we told it to look for. Below is an example that can be used to find more than just "Rock"
	SELECT * 
	FROM albums 
	WHERE genre LIKE "%rock";