-- --------------------------------------------------------------------------------
-- Name: Eric Shepard
-- Class: IT-111 
-- Abstract: Assignment 9 step #7
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbMeLikeAlot;     -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
--						Problem #9 step #7
-- --------------------------------------------------------------------------------

-- Drop Table Statements

IF OBJECT_ID ('TCustomerSongs')		IS NOT NULL DROP TABLE TCustomerSongs
IF OBJECT_ID ('TCustomers')			IS NOT NULL DROP TABLE TCustomers
IF OBJECT_ID ('TSongs')				IS NOT NULL DROP TABLE TSongs
IF OBJECT_ID ('TArtists')			IS NOT NULL DROP TABLE TArtists


-- --------------------------------------------------------------------------------
--	Step #1 : Create table 
-- --------------------------------------------------------------------------------

CREATE TABLE TCustomers
(
	 intCustomerID		INTEGER			NOT NULL
	,strFirstName		VARCHAR(255)	NOT NULL
	,strLastName		VARCHAR(255)	NOT NULL
	,strAddress			VARCHAR(255)	NOT NULL
	,strCity			VARCHAR(255)	NOT NULL
	,strState			VARCHAR(255)	NOT NULL
	,strZip				VARCHAR(255)	NOT NULL
	,dtmDateOfBirth		DATETIME		NOT NULL
	,strRace			VARCHAR(255)	NOT NULL
	,strGender			VARCHAR(255)	NOT NULL
	,CONSTRAINT TCustomers_PK PRIMARY KEY ( intCustomerID )
)

CREATE TABLE TSongs
(
	 intSongID			INTEGER			NOT NULL
	,intArtistID		INTEGER			NOT NULL
	,strSongName		VARCHAR(255)	NOT NULL
	,strGenre			VARCHAR(255)	NOT NULL
	,strRecordLabel		VARCHAR(255)	NOT NULL
	,dtmDateRecorded	DATETIME		NOT NULL
	,CONSTRAINT TSongs_PK PRIMARY KEY ( intSongID )
)

CREATE TABLE TArtists
(
	 intArtistID		INTEGER			NOT NULL
	,strFirstName		VARCHAR(255)	NOT NULL
	,strLastName		VARCHAR(255)	NOT NULL
	,CONSTRAINT TArtists_PK PRIMARY KEY ( intArtistID )
)

CREATE TABLE TCustomerSongs
(
	 intCustomerSongID	INTEGER			NOT NULL
	,intCustomerID		INTEGER			NOT NULL
	,intSongID			INTEGER			NOT NULL
	,CONSTRAINT TCustomerSongs_PK PRIMARY KEY (  intCustomerSongID )
)


-- --------------------------------------------------------------------------------
--	Step #2 : Establishing Referential Integrity 
-- --------------------------------------------------------------------------------
--
-- #	Child							Parent						Column
-- -	-----							------						---------
-- 1	TSongs							TArtists					intArtistID						 
-- 2	TCustomerSongs					TCustomers					intCustomerID 
-- 3	TCustomerSongs					TSongs						intSongID

--1
ALTER TABLE TSongs ADD CONSTRAINT TSongs_TArtists_FK 
FOREIGN KEY ( intArtistID ) REFERENCES TArtists ( intArtistID ) ON DELETE CASCADE

--2
ALTER TABLE TCustomerSongs	 ADD CONSTRAINT TCustomerSongs_TCustomers_FK 
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers ( intCustomerID ) ON DELETE CASCADE

--3
ALTER TABLE TCustomerSongs	 ADD CONSTRAINT TCustomerSongs_TSongs_FK 
FOREIGN KEY ( intSongID ) REFERENCES TSongs ( intSongID ) ON DELETE CASCADE


-- --------------------------------------------------------------------------------
--	Step #3 : Add Sample Data - INSERTS
-- --------------------------------------------------------------------------------

INSERT INTO TCustomers (intCustomerID, strFirstName, strLastName, strAddress, strCity, strState, strZip, dtmDateOfBirth, strRace, strGender)
VALUES				  (1, 'James', 'Jones', '321 Elm St.', 'Cincinnati', 'Oh', '45201', '1/1/1997', 'Hispanic', 'Male')
					 ,(2, 'Sally', 'Smith', '987 Main St.', 'Norwood', 'Oh', '45218', '12/1/1999', 'African-American', 'Female')
					 ,(3, 'Jose', 'Hernandez', '1569 Windisch Rd.', 'West Chester', 'Oh', '45069', '9/23/1998', 'Hispanic', 'Male')
					 ,(4, 'Lan', 'Kim', '44561 Oak Ave.', 'Milford', 'Oh', '45246', '6/11/1999', 'Asian', 'Male')

INSERT INTO TArtists( intArtistID, strFirstName, strLastName)
VALUES				(1, 'Bob', 'Nields')
				   ,(2, 'Ray', 'Harmon')
				   ,(3, 'Pam', 'Ransdell')

INSERT INTO TSongs ( intSongID, intArtistID, strSongName, strGenre, strRecordLabel, dtmDateRecorded)
VALUES				 ( 1, 1,'Hey Jude', 'Rock', 'MyOwn', '8/28/2017')
					,( 2, 2,'School House Rock', 'Rock', 'HisOwn', '8/28/2007')
					,( 3, 3,'Rocking on the Porch', 'Country', 'CountingToes', '8/28/1997')
					,( 4, 1,'Blue Jude', 'Blues', 'DeepMusic', '8/28/2009')

INSERT INTO TCustomerSongs (intCustomerSongID, intCustomerID, intSongID)
VALUES				    	( 1, 1, 1)
						   ,( 2, 1, 2)
						   ,( 3, 1, 3)
						   ,( 4, 1, 4)
						   ,( 5, 2, 2)
						   ,( 6, 2, 3)
						   ,( 7, 3, 4)
						   ,( 8, 4, 1)
						   ,( 9, 4, 4)

SELECT *
FROM TCustomers,TSongs,TCustomerSongs
WHERE TCustomers.intCustomerID = TCustomerSongs.intCustomerID
  and TSongs.intSongID = TCustomerSongs.intSongID


SELECT *
FROM TCustomers,TSongs,TCustomerSongs
WHERE TCustomers.intCustomerID = TCustomerSongs.intCustomerID
  and TSongs.intSongID = TCustomerSongs.intSongID
  and TCustomers.strLastName = 'Smith'

SELECT *
FROM TArtists,TSongs
WHERE TArtists.intArtistID = TSongs.intArtistID
  
SELECT *
FROM TArtists,TSongs
WHERE TArtists.intArtistID = TSongs.intArtistID
  and TSongs.dtmDateRecorded > '2017-01-01'