		#### setting up/ making the first reccomender based on summary ####

#### checking for updates 
sudo apt-get update

####installing and updating postgres 
sudo apt install postgresql libpq-dev-postgresql-client postgresql-common-y

####starting postgres for this assignment
sudo service postgres-9.3 start 

#### opening psql as the test user 
psql test

#### creating table  
test=> CREATE TABLE film(url text, title text, ReleaseDate text, Distributor text, Starring text, Summary text, Director text, Genre text, Rating text, Runtime text, Userscore text, Metascore text, ScoreCounts text); 

#### inserting data 
test=> \copy film FROM '/HOME/pi/RSL/moviesFromMetacritic.csv' delimiter';' csv header;  
/HOME/pi/RSL/moviesFromMetacritic.csv: No such file or directory

####checking if my favorite film is in the database (it is)
test=> select url, Userscore from film where url like '%social%' order by Userscore;

#### Taking a look at the data from my favorite movie (the social network)
test=> SELECT*FROM film WHERE url='the-social-network';

#### what movies are similar to my favorite movie? 
test=> SELECT url FROM film WHERE lexemesSummary @@ to_tsquery('social');

#### altering table (adding a factor) 
test=> ALTER TABLE film ADD lexemesSummary tsvector;

#### making it orderly and usable  
test=> UPDATE film SET lexemesSummary = to_tsvector(Summary); 

#### Adding rank to the table film 
test=> ALTER TABLE film ADD rank float4;

#### Making it so that rank is being measured (with my fav movie) through the summary colomn
test=> UPDATE film SET rank = ts_rank(lexemesSummary,plainto_tsquery((SELECT Summary FROM film WHERE url='the-social-network')));

#### making the top 50 reccomendations based upon my favorite movie (the social network)
test=> CREATE TABLE reccomendationsSocialNetwork AS SELECT url, rank FROM film WHERE rank > 0.01 ORDER BY rank DESC LIMIT 50;
SELECT 50



		#### top 50 based on the title field #####

####adding the vector for title  
test=> ALTER TABLE film ADD lexemestitle tsvector;
ALTER TABLE
test=> UPDATE film SET lexemestitle = to_tsvector(title);
UPDATE 5229

#### Making it so that rank is being measured (with my fav movie) through the title colomn
test=> UPDATE film SET rank = ts_rank(lexemestitle,plainto_tsquery((SELECT title FROM film WHERE url='the-social-network')));

####creating the reccomended table with title 
test=> CREATE TABLE reccomendationsbasedontitleSocialNetwork AS SELECT url, rank FROM film WHERE rank > 0.1 ORDER BY rank DESC LIMIT 50;  
SELECT 0

###Lowering the rank so i'll get some output 
test=> CREATE TABLE reccomendationsbasedontitleSocialNetwork AS SELECT url, rank FROM film WHERE rank > 0.001 ORDER BY rank DESC LIMIT 50;  
SELECT 1


		#### top 50 based on the Starring field ####

####adding the vector for starring 
test=> ALTER TABLE film ADD lexemesstarring tsvector; 
ALTER TABLE
test=> UPDATE film SET lexemesstarring = to_tsvector(starring); 
UPDATE 5229

#### Making it so that rank is being measured (with my fav movie) through the starring colomn
test=> UPDATE film SET rank = ts_rank(lexemesstarring,plainto_tsquery((SELECT summary FROM film WHERE url ='the-social-network')));
UPDATE 5229

#### Creating the reccomender table with starring 
test=> CREATE TABLE reccomendationsbasedonstarring AS SELECT url, rank FROM film WHERE rank > 0.1 ORDER BY rank DESC LIMIT 50;
SELECT 2

#### Same table with lower rankings (2 outputs are not enough) 
test=> CREATE TABLE reccomendationsbasedonstarring AS SELECT url, rank FROM film WHERE rank > 0.01 ORDER BY rank DESC LIMIT 50;
SELECT 17


		#### CONCLUSION ####

The one with summary as predictor gave the best output with 50 movies ranging around rank 0.6
Though my personal prefference is with starring as this gives some movies (17) with similar actors, which are more my taste.
With the title i only get one result which is the movie itself, which is logical as it's the only one with that title 
