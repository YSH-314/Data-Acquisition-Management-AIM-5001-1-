SELECT "FirstName","LastName","EmployeeId","Title","ReportsTo"
FROM "Employee"
WHERE "ReportsTo"= (
	SELECT "EmployeeId" 
	FROM "Employee" 
	WHERE "FirstName"='Nancy' AND "LastName"='Edwards');
	
SELECT 
	AVG(EXTRACT (YEAR FROM age(CAST("HireDate" AS DATE),CAST("BirthDate" AS DATE)))) AS "Ave_age"
FROM "Employee";

SELECT "FirstName","LastName","EmployeeId","Title"
FROM "Employee"
ORDER BY "BirthDate"
LIMIT 3;

SELECT "FirstName" ||' '||"LastName" AS "Name","City"
FROM "Customer"
WHERE "Country"='USA' AND "City"<>'California';

SELECT "CustomerId","LastName","Country"
FROM "Customer"
WHERE "Company" IS NULL
ORDER BY "Country","LastName";

SELECT "CustomerId","LastName","Country",(CASE WHEN "Company" IS NULL THEN 'Individual' ELSE "Company" END)
FROM "Customer"
ORDER BY "Country","LastName";

CREATE Table "My_Albums"
("My_AlbumId" INT NOT NULL,
"AlbumId" INT NOT NULL,
"My_Rating" INT NULL,
"My_Notes" VARCHAR (255),
CONSTRAINT "PK_My_AlbumId" PRIMARY KEY ("My_AlbumId")
);
ALTER TABLE "My_Albums" ADD CONSTRAINT "FK_AlbumId"
    FOREIGN KEY ("AlbumId") REFERENCES "Album" ("AlbumId") ON DELETE NO ACTION ON UPDATE NO ACTION;
INSERT INTO "My_Albums" ("My_AlbumId", "AlbumId", "My_Rating", "My_Notes") VALUES (1, 37, 3, 'Old
and Scratched');
INSERT INTO "My_Albums" ("My_AlbumId", "AlbumId", "My_Notes") VALUES (2, 110, 'Easy Listening');
INSERT INTO "My_Albums" ("My_AlbumId", "AlbumId", "My_Notes") VALUES (3, 36, 'Easy Listening');
INSERT INTO "My_Albums" ("My_AlbumId","AlbumId","My_Rating") VALUES (4,4,5);

Update "My_Albums"
SET "My_Notes"='gentle and delightful'
WHERE "My_AlbumId"=4;

DELETE FROM "My_Albums" WHERE "My_AlbumId"=4;

