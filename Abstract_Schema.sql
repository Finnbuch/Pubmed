CREATE TABLE abstract (
	Content 	text,
    AbstractID  int,
    Rejected	bool,
    primary key(AbstractID)
    );
	
CREATE TABLE meta (
	AbstractID int,
    Journal 		varchar(255),
	Author			long varchar,
	Science 		long varchar,
    Publish_Date 	datetime,
    PubmedID 		int,
    Keyword 		varchar(255),
    Citations 		varchar(255),
    
    FOREIGN KEY(AbstractID) REFERENCES abstract(AbstractID)
    );
    
CREATE TABLE Valence (
	Positivity 	float4,
    Negativity 	float4,
	Neutrality 	float4,
    Compound   	float4,
    AbstractID 	int,
    FOREIGN KEY(AbstractID) REFERENCES abstract(AbstractID)
    );

CREATE TABLE part_valence (
	AbstractID 	int,
    Part  	   	int, 
    Positivity 	float4,
	Neutrality 	float4,
	Negativity 	float4,
    Compound   	float4,
    PRIMARY KEY (AbstractID, Part),
    FOREIGN KEY (AbstractID) REFERENCES abstract(AbstractID)
    );
    
CREATE TABLE speechgraphs (
	L1			int,
    L2			int,
    L3			int,
    RE			int,
    LSC			int,
    AbstractID	int,
	FOREIGN KEY(AbstractID) REFERENCES abstract(AbstractID)
    );
    
    CREATE TABLE retraction_data (
    AbstractID				int,
	Article_type			varchar(255),
    Retraction_nature		varchar(255),
	FOREIGN KEY(AbstractID) REFERENCES abstract(AbstractID)
    );
    
    CREATE TABLE raw_text (
	rAbstract 			text,
    AbstractID			int,
    FOREIGN KEY(AbstractID) REFERENCES abstract(AbstractID)
    );
    
### reading in the original dataset from edlinger et al ###    
    
LOAD DATA INFILE 'E:\\Organization_Project\\files\\Text_Combined_df_readable.csv'
INTO TABLE abstract
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'E:\\Organization_Project\\files\\Valence_Combined_df_readable.csv'
INTO TABLE valence
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'E:\\Organization_Project\\files\\Valence_thirds_Combined_readable.csv'
INTO TABLE part_valence
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'E:\\Organization_Project\\files\\Meta_Combined_df_readable.csv'
INTO TABLE meta
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

ALTER TABLE meta MODIFY PubmedID INTEGER;

### reading in the dataset from retractionwatch ###

LOAD DATA INFILE 'E:\\Organization_Project\\files\\Retractionwatch\\Retraction_Text_Combined_df_readable.csv'
INTO TABLE abstract
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'E:\\Organization_Project\\files\\Retractionwatch\\Retraction_Valence_Combined_df_readable.csv'
INTO TABLE valence
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'E:\\Organization_Project\\files\\Retractionwatch\\Retraction_Valence_thirds_Combined_readable.csv'
INTO TABLE part_valence
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'E:\\Organization_Project\\files\\Retractionwatch\\Retraction_Meta_Combined_df_readable.csv'
INTO TABLE meta
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'E:\\Organization_Project\\files\\Retractionwatch\\Retraction_Data_Combined_df_readable.csv'
INTO TABLE rejection_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

#### Loading Raw TEXT ######

LOAD DATA INFILE 'E:\\Organization_Project\\files\\Raw_Text_Combined_df_readable.csv'
INTO TABLE raw_text
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SET SQL_SAFE_UPDATES = 0;

UPDATE meta m
JOIN abstract a ON m.AbstractID = a.AbstractID
SET Science = SUBSTRING(Science, 2, 3)
WHERE a.Rejected = 1;

UPDATE meta m
JOIN abstract a ON m.AbstractID = a.AbstractID
SET Science = REPLACE(Science, 'SOC', 'psy')
WHERE a.Rejected = 1;

UPDATE meta m
JOIN abstract a ON m.AbstractID = a.AbstractID
SET Science = REPLACE(Science, 'BLS', 'bio')
WHERE a.Rejected = 1;

UPDATE meta m
JOIN abstract a ON m.AbstractID = a.AbstractID
SET Science = REPLACE(Science, 'PHY', 'phy')
WHERE a.Rejected = 1;

UPDATE meta m
JOIN abstract a ON m.AbstractID = a.AbstractID
SET Science = REPLACE(Science, 'HUM', 'hum')
WHERE a.Rejected = 1;

SELECT Science
FROM meta m
JOIN abstract a ON m.AbstractID = a.AbstractID
WHERE a.Rejected = 1;

