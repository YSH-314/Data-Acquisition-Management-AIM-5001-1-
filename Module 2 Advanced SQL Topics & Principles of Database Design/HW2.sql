--Q1 Write a SQL query that produces a list of all Kiss albums in the Chinook database. How many Kiss albums are contained within the database?
SELECT A."ArtistId",A."Name",Al."AlbumId",Al."Title"
FROM "Artist" AS A
LEFT JOIN "Album" AS Al
ON A."ArtistId"=Al."ArtistId"
WHERE A."Name"='Kiss';

--Q4 Write a SQL query that provides a list of all the Kiss songs on Kiss albums contained within the Chinook database. The output of the query MUST include artist name, album title, track name and composer.
SELECT A."Name" AS "Artist_Name",Al."Title" AS "Album_Title",T."Name" AS "Track_Name",T."Composer"
FROM "Artist" AS A
LEFT JOIN "Album" AS Al
ON A."ArtistId"=Al."ArtistId"
LEFT JOIN "Track" AS T
ON Al."AlbumId"=T."AlbumId"
WHERE A."Name"='Kiss';

--Q7 Write a SQL query that produces a list of the names of all customers who have purchased Kiss songs.
SELECT C."FirstName"||' '|| C."LastName" AS "Customer_Name"
FROM "Customer" AS C
LEFT JOIN "Invoice" AS I
ON C."CustomerId"=I."CustomerId"
LEFT JOIN "InvoiceLine" AS IL
ON I."InvoiceId"=IL."InvoiceId"
LEFT JOIN "Track" AS T
ON IL."TrackId"=T."TrackId"
WHERE T."TrackId" IN (SELECT T."TrackId"
					  FROM "Artist" AS A
					  LEFT JOIN "Album" AS Al
					  ON A."ArtistId"=Al."ArtistId"
					  LEFT JOIN "Track" AS T
					  ON Al."AlbumId"=T."AlbumId"
					  WHERE A."Name"='Kiss');

--Q7 Write a SQL query that produces a list of the names of all customers who have purchased Kiss songs.
SELECT C."FirstName",C."LastName" AS "Customer_Name"
FROM "Customer" AS C
LEFT JOIN "Invoice" AS I
ON C."CustomerId"=I."CustomerId"
LEFT JOIN "InvoiceLine" AS IL
ON I."InvoiceId"=IL."InvoiceId"
LEFT JOIN "Track" AS T
ON IL."TrackId"=T."TrackId"
WHERE T."TrackId" IN (SELECT T."TrackId"
					  FROM "Artist" AS A
					  LEFT JOIN "Album" AS Al
					  ON A."ArtistId"=Al."ArtistId"
					  LEFT JOIN "Track" AS T
					  ON Al."AlbumId"=T."AlbumId"
					  WHERE A."Name"='Kiss')

ORDER BY C."LastName"


CREATE TABLE "Movie_id"
(
	"Movie id" VARCHAR(5) NOT NULL PRIMARY KEY,
	"Movie title" VARCHAR(1000)
);

INSERT INTO "Movie_id" ("Movie id","Movie title") VALUES ('M0001','The Seven Samurai');
INSERT INTO "Movie_id" ("Movie id","Movie title") VALUES ('M0002','Bonnie and Clyde');
INSERT INTO "Movie_id" ("Movie id","Movie title") VALUES ('M0003','Reservoir Dogs');
INSERT INTO "Movie_id" ("Movie id","Movie title") VALUES ('M0004','Airplane!');
INSERT INTO "Movie_id" ("Movie id","Movie title") VALUES ('M0005','Doctor Zhivago');
					  
CREATE TABLE "Movies"
(
	"Movie title" VARCHAR(1000) NOT NULL PRIMARY KEY,
	"Length of Movie" INT,
	"Genre" VARCHAR(1000),
	"Actors" VARCHAR(1000),
	"Release Year" INT,
	"MPAA Rating" VARCHAR(1000),
	"Movie Plot" VARCHAR(1000),
	"Price" DECIMAL	
);

INSERT INTO "Movies" VALUES ('The Seven Samurai',207,'Action','oshiro Mifune, Takashi Shimura',1954,'PG-13','In 1586, a bandit gang discusses raiding a mountain village, but their chief decides to wait until after the harvest. The villagers overhear this and turn to Gisaku, the village elder and miller, who declares that they should hire samurai to protect them. Since they have no money and can only offer food as payment, Gisaku advises them to find hungry samurai.',5.9);
INSERT INTO "Movies" VALUES ('Bonnie and Clyde',120,'Romance','Warren Beatty,Faye Dunaway',1958,'G','1934. Young adults Bonnie Parker, a waitress, and Clyde Barrow, a criminal just released from prison, are immediately attracted to what the other represents for their life when they meet by chance in West Dallas, Texas. Bonnie is fascinated with Clyde"s criminal past, and his matter-of-factness and bravado in talking about it. Clyde sees in Bonnie someone sympathetic to his goals. Although attracted to each other physically, a sexual relationship between the two has obstacles. They decide to join forces to embark on a life of crime, holding up whatever establishments, primarily banks, to make money and to have fun. They don"t plan on hurting anyone or killing despite wielding loaded guns. They amass a small gang of willing accomplices, including C.W. Moss, a mechanic to fix whatever cars they steal which is important especially for their getaways, and Buck Barrow, one of Clyde"s older brothers.',5.9);
INSERT INTO "Movies" VALUES ('Reservoir Dogs',99,'Action','Harvey Keitel',1992,'PG-13','Six thugs, who are strangers to each other, are hired by a crime boss, Joe Cabot, to carry out a diamond robbery. Right at the outset, they are given false names with the intention that they won"t get too close and will concentrate on the job instead. They are completely sure that the robbery is going to be a success. But, when the police show up right at the time and the site of the robbery, panic spreads amongst the group members, and two of them are killed in the subsequent shootout, along with a few policemen and civilians. When the remaining people assemble at the premeditated rendezvous point (a warehouse), they begin to suspect that one of them is an undercover cop.',5.4);
INSERT INTO "Movies" VALUES ('Airplane!',88,'Comedy','Robert Hays, Julie Hagerty, Leslie Nielsen',1980,'G','Ex-fighter pilot Ted Striker is a traumatized war veteran turned taxi driver. Because of his pathological fear of flying and subsequent "drinking problem"—he splashes beverages anywhere but into his mouth—Ted has been unable to hold a responsible job. His wartime girlfriend, Elaine Dickinson, now a flight attendant, breaks off her relationship with him before boarding her rostered flight from Los Angeles to Chicago. Ted abandons his taxi and buys a ticket on the same flight to try to win her back. Once on board, however, Elaine continues to reject him.',5.6);
INSERT INTO "Movies" VALUES ('Doctor Zhivago',200,'Horror','Omar Sharif, Julie Christie',1966,'PG','The film is set against a backdrop of World War I, the Russian Revolution of 1917, and the Russian Civil War. A narrative framing device, set in the late 1940s or early 1950s, involves NKVD Lieutenant General Yevgraf Andreyevich Zhivago searching for the daughter of his half-brother, Dr Yuri Andreyevich Zhivago, and Larissa ("Lara") Antipova. Yevgraf believes a young woman, Tanya Komarova, may be his niece, and tells her the story of her father"s life.',6.0);

ALTER TABLE "InvoiceLine"
ADD "Movie id" VARCHAR(5),
ADD FOREIGN KEY ("Movie id") REFERENCES "Movie_id" ("Movie id");

ALTER TABLE "InvoiceLine" 
ALTER COLUMN "TrackId" DROP NOT NULL;

INSERT INTO "Invoice" VALUES (413,2,'2022-09-10 00:00:00','1415 Dr','Astoria','NY','USA','11106','6.89');

INSERT INTO "InvoiceLine" VALUES (2241,413,6,0.99,1,NULL);
INSERT INTO "InvoiceLine" VALUES (2242,413,NULL,5.9,1,'M0002');

INSERT INTO "InvoiceLine" VALUES (2243,1,NULL,5.9,1,'M0002');
UPDATE "Invoice" SET "Total"=7.88 WHERE "InvoiceId"=1;
INSERT INTO "InvoiceLine" VALUES (2244,2,NULL,5.9,1,'M0002');
UPDATE "Invoice" SET "Total"=9.86 WHERE "InvoiceId"=2;
INSERT INTO "InvoiceLine" VALUES (2245,3,NULL,5.9,1,'M0002');
UPDATE "Invoice" SET "Total"=11.84 WHERE "InvoiceId"=3;
INSERT INTO "InvoiceLine" VALUES (2246,4,NULL,5.9,1,'M0002');
UPDATE "Invoice" SET "Total"=14.81 WHERE "InvoiceId"=4;

SELECT IL."InvoiceId",C."FirstName"||' '||C."LastName" AS "Customer_Name",COUNT(IL."TrackId") AS "song_cont",COUNT(IL."Movie id") AS "movie_count",SUM(IL."UnitPrice"*IL."Quantity") AS "Total"
FROM "Customer" AS C
LEFT JOIN "Invoice" AS I
ON C."CustomerId"=I."CustomerId"
LEFT JOIN "InvoiceLine" AS IL
ON I."InvoiceId"=IL."InvoiceId"
GROUP BY (C."FirstName",C."LastName",IL."InvoiceId")
HAVING COUNT(IL."Movie id")>=1 AND COUNT(IL."TrackId")>=1;




