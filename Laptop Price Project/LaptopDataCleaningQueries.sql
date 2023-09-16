-- View the full dataset
SELECT * FROM laptopData;

-- Cheking for duplicate values
SELECT Unnamed_0 , COUNT(*)
FROM laptopData
GROUP BY Unnamed_0
ORDER BY Unnamed_0 DESC;
-- There are no duplicates found appart from nulls which are 30.

-- Checking for null values from all columns
SELECT *
FROM laptopData
WHERE Unnamed_0 is null ;

-- There are 30 rows of null values filled in each colomn.

-- The deletion of the null rows that were present.
DELETE FROM laptopData WHERE Unnamed_0 IS NULL;

-- This has removed all of the 30 rows that had the null values present.

-- Inserting data into the null value found in the Inches column.
UPDATE laptopData SET Inches = 15.6 WHERE Inches IS NULL;

-- The table has been changed and has filled in the null value of 467 in inches.

-- The inches column is not formatted all the same so I must change the formating.
-- This code will update the table so that all the inches are rounded to two decimal places.
UPDATE laptopData SET Inches = round(Inches,2);

-- The same needs to be done to the price column as well.
-- This will update the table and round the price column to two decimal places
UPDATE laptopData SET Price = round(Price,2);

-- In order to see if there are any more pieces of data that are wrong I systimaticlay checked each colomn.
-- When checking the column of Memory I was able to find wrong data in Unnamed_0 770.
SELECT Unnamed_0, Memory
FROM laptopData;

-- I am able to identify the row that has incorrect data throught the unique id.
SELECT *
FROM laptopData
WHERE Unnamed_0 = 770;

-- Due to me not being able to find the data I need, I will be removing this row as it is not of the highest importance
DELETE FROM laptopData WHERE Unnamed_0 = 770;

-- The Opsys has the mac operating system with lowercas which needs to be chnaged.
UPDATE laptopData SET OpSys = 'MacOS'
WHERE OpSys = 'macOS';

-- Carrying on the work being done on each colomn I was able to find the weight producing the incorrect data.
SELECT Unnamed_0, Weight
FROM laptopData;

-- The full row is being selected to see more of the information of the data.
SELECT *
FROM laptopData
WHERE Unnamed_0 = 208;

-- The removal of the row as the data cannot be changed.
DELETE FROM laptopData WHERE Unnamed_0 = 208;

-- When looking at the Company column there was the use of Vero as company name which is incorrect.
SELECT * 
FROM laptopData
WHERE company = 'Vero';

-- In order to change this I researched Vero and found that it was made by Acer and thus will change the name of company to Acer.
UPDATE laptopData SET Company = 'Acer'
WHERE Company = 'Vero';

-- With the Ram column being considered as a value I wish to convert this column and remove the GB.
-- This will update the Ram value of 8GB to 8
UPDATE laptopData SET Ram = 8
WHERE Ram = '8GB';

-- This will update the Ram value of 16GB to 16
UPDATE laptopData SET Ram = 16
WHERE Ram = '16GB';

-- This will update the Ram value of 4GB to 4
UPDATE laptopData SET Ram = 4
WHERE Ram = '4GB';

-- This will update the Ram value of 2GB to 2
UPDATE laptopData SET Ram = 2
WHERE Ram = '2GB';

-- This will update the Ram value of 6GB to 6
UPDATE laptopData SET Ram = 6
WHERE Ram = '6GB';

-- This will update the Ram value of 12GB to 12
UPDATE laptopData SET Ram = 12
WHERE Ram = '12GB';

-- This will update the Ram value of 32GB to 32
UPDATE laptopData SET Ram = 32
WHERE Ram = '32GB';

-- This will update the Ram value of 64GB to 64
UPDATE laptopData SET Ram = 64
WHERE Ram = '64GB';

-- This will update the Ram value of 1GB to 1
UPDATE laptopData SET Ram = 1
WHERE Ram = '1GB';

-- This is done to rename the column to mention that the numbers are listed in GB.
EXEC sp_rename 'laptopData.Ram', 'RamInGB', 'Column'; 

-- This will update the Ram value of 24GB to 24
UPDATE laptopData SET RamInGB = 24
WHERE RamInGB = '24GB';

-- This will allow for me to convert the column to an integer format.
ALTER TABLE laptopData
ALTER COLUMN RamInGB int;

-- The code below allows for me to change the Weight column so that all the values before the kg remain while kg is removed.
--UPDATE laptopData
SET Weight = LEFT(Weight, CHARINDEX ('kg',Weight)-1);

-- This is done to rename the column to mention that the numbers are listed in KG.
EXEC sp_rename 'laptopData.Weight', 'WeightInKG', 'Column'; 

-- This will allow for me to convert the column to an float format.
ALTER TABLE laptopData
ALTER COLUMN WeightInKG float;

-- Adding a new column to hold the slpit data of memory.
ALTER TABLE laptopData ADD MemoryType nvarchar(50);

-- Filling the data for MemoryType from Memory column.
UPDATE laptopData
SET MemoryType = SUBSTRING(Memory, (CHARINDEX (' ', Memory)+1), (LEN(Memory) - CHARINDEX (' ', Memory)));

-- Remofing the not needed information and populating the table with the Memory size.
UPDATE laptopData
SET Memory = LEFT(Memory, (CHARINDEX (' ', Memory)-1));

