SELECT * 
  FROM [Screen_Habits].[dbo].[Kids_Screen_Time]

 --EXEC sp_rename '[Screen_Habits].[dbo].[Kids_Screen_Time].Observed_changes_Catagory', 'Observed_changes', 'COLUMN';
  --EXEC sp_rename '[Screen_Habits].[dbo].[Kids_Screen_Time].Strategies_Reducing_Time_catagory', 'Reduction_Strateegies', 'COLUMN';

 SELECT * FROM [Screen_Habits].[dbo].[Kids_Screen_Time]
 WHERE Time_limits IS NULL OR Designated_Screen_Time_periods IS NULL OR Screen_Content_Monitoring IS NULL;

/*check the data types*/
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS;

/*fix NULL values in all three BIT columns with a mix of 0 and 1*/
UPDATE [Screen_Habits].[dbo].[Kids_Screen_Time]
SET Time_limits = CASE 
    WHEN Time_limits IS NULL THEN FLOOR(RAND() * 2) 
    ELSE Time_limits 
END,
Screen_Content_Monitoring = CASE 
    WHEN Screen_Content_Monitoring IS NULL THEN FLOOR(RAND() * 2) 
    ELSE Screen_Content_Monitoring 
END,
Designated_Screen_Time_periods = CASE 
    WHEN Designated_Screen_Time_periods IS NULL THEN FLOOR(RAND() * 2) 
    ELSE Designated_Screen_Time_periods 
END;

SELECT COUNT(*) AS Null_Count 
FROM [Screen_Habits].[dbo].[Kids_Screen_Time]
WHERE Screen_Time IS NULL;

SELECT DISTINCT Screen_Time 
FROM [Screen_Habits].[dbo].[Kids_Screen_Time];

/*Update Current Table with Data from the Other Table*/
UPDATE K
SET K.Screen_Time = O.Screen_Time
FROM [Screen_Habits].[dbo].[Kids_Screen_Time] K
JOIN [kids_screen_time].[dbo].[screen_time] O
ON K.Content_Type = O.Content_Type;
/*
UPDATE [Screen_Habits].[dbo].[Kids_Screen_Time]
SET Screen_Time = TRY_CAST(TRIM(REPLACE(REPLACE(Screen_Time, ' hour', ''), ' hours', '')) AS INT)
WHERE Screen_Time LIKE '%hour%';
*/

--QUESTION

--How old is your child?
SELECT Child_s_Age, COUNT(*) AS Total_Children
FROM [Screen_Habits].[dbo].[Kids_Screen_Time]
GROUP BY Child_s_Age;

--What devices does your child use most?
SELECT Most_Used_Device, COUNT(*) AS Total_Users
FROM [Screen_Habits].[dbo].[Kids_Screen_Time]
GROUP BY Most_Used_Device
ORDER BY Total_Users DESC;

--What type of content does your child watch or do on screens?
SELECT Content_Type, COUNT(*) AS Total_Users
FROM [Screen_Habits].[dbo].[Kids_Screen_Time]
GROUP BY Content_Type
ORDER BY Total_Users DESC;

--Which platforms does your child use the most?
SELECT Main_Platform_Used, COUNT(*) AS Total_Useer
FROM [Screen_Habits].[dbo].[Kids_Screen_Time]
GROUP BY Main_Platform_Used
ORDER BY Total_Useer DESC

--Do you set limits on your child’s screen time? 
SELECT Time_limits, COUNT(*) AS Total_Responses
FROM [Screen_Habits].[dbo].[Kids_Screen_Time]
GROUP BY Time_limits;

--Do you check what your child is watching or doing on screens?
SELECT Designated_Screen_Time_periods, COUNT(*) AS Total_Responses
FROM [Screen_Habits].[dbo].[Kids_Screen_Time]
GROUP BY Designated_Screen_Time_periods;

--Have you noticed any changes in your child’s health or behavior because of screens?
SELECT Observed_changes, COUNT(*) AS Total_Cases
FROM Kids_Screen_Time
GROUP BY  Observed_changes
ORDER BY Total_Cases DESC;

-- What things do you do to help your child spend less time on screens? 
SELECT Strategies_Reducing_Screen_Time_catagory, COUNT(*) AS Total_Responses
FROM [Screen_Habits].[dbo].[Kids_Screen_Time]
GROUP BY Strategies_Reducing_Screen_Time_catagory
ORDER BY Total_Responses DESC;



SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Kids_Screen_Time';
