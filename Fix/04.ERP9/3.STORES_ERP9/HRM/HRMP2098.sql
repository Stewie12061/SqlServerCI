IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2098]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2098]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Lấy dữ liệu kế hoạch đào tạo định kỳ
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Hải Long on 19/09/2017
---- <Example>
---- EXEC [HRMP2098] @DivisionID='AS',@UserID='ASOFTADMIN'
---- 

CREATE PROCEDURE [dbo].[HRMP2098]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50)  
) 
AS 

IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT2071_Temp]') AND TYPE IN (N'U'))
BEGIN 
	DROP TABLE HRMT2071_Temp	
END
CREATE TABLE HRMT2071_Temp
(
	TransactionID NVARCHAR(50), 
	TrainingPlanID NVARCHAR(50),
	IsAll TINYINT,	
	DepartmentID NVARCHAR(50),
	TrainingFieldID NVARCHAR(50),
	FromDate DATETIME,
	ToDate DATETIME,
	RepeatTypeID NVARCHAR(50),	
	Description NVARCHAR(50)
)	

DECLARE @Cursor CURSOR,
		@TransactionID NVARCHAR(50), 
		@TrainingPlanID NVARCHAR(50),
		@IsAll TINYINT,
		@DepartmentID NVARCHAR(50), 
		@TrainingFieldID NVARCHAR(50),
		@StartDate DATETIME,
		@DurationPlan INT,
		@RepeatTypeID NVARCHAR(50),
		@RepeatTime TINYINT,
		@Notes NVARCHAR(250),
		@FromDate DATETIME,
		@ToDate DATETIME,		
		@Times AS INT,
		@Count AS INT

-- Lấy kế hoạch đào tạo định kỳ theo quý, năm có có giới hạn lặp lại		
SET @Cursor = CURSOR SCROLL KEYSET FOR 
SELECT TransactionID, TrainingPlanID, IsAll, DepartmentID, TrainingFieldID, StartDate, DurationPlan, RepeatTypeID, RepeatTime, Notes
FROM HRMT2071 WITH (NOLOCK)
WHERE RepeatTime <> 0
AND DivisionID = @DivisionID 

OPEN @Cursor
FETCH NEXT FROM @Cursor INTO @TransactionID, @TrainingPlanID, @IsAll, @DepartmentID, @TrainingFieldID, @StartDate, @DurationPlan, @RepeatTypeID, @RepeatTime, @Notes
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Count = 0
	IF @RepeatTypeID <> '0'
	BEGIN
		IF @RepeatTypeID = '1'
		BEGIN
			SET @Times = @RepeatTime * 4
		END
		ELSE
		BEGIN
			SET @Times = @RepeatTime
		END
		
		WHILE @Times > @Count
		BEGIN
			SET @FromDate = DATEADD(quarter, @Count, @StartDate)
			SET @ToDate = DATEADD(DAY, @DurationPlan, DATEADD(quarter, @Count, @StartDate))
								
			INSERT INTO HRMT2071_Temp (TransactionID, TrainingPlanID, IsAll, DepartmentID, TrainingFieldID, FromDate, ToDate, RepeatTypeID, [Description])
			VALUES (@TransactionID, @TrainingPlanID, @IsAll, @DepartmentID, @TrainingFieldID, @FromDate, @ToDate, @RepeatTypeID, @Notes)
			
			SET @Count = @Count + 1
		END
	END
	ELSE
	BEGIN
		SET @FromDate = DATEADD(quarter, @Count, @StartDate)
		SET @ToDate = DATEADD(DAY, @DurationPlan, DATEADD(quarter, @Count, @StartDate))
					
		INSERT INTO HRMT2071_Temp (TransactionID, TrainingPlanID, IsAll, DepartmentID, TrainingFieldID, FromDate, ToDate, RepeatTypeID, [Description])	
		VALUES (@TransactionID, @TrainingPlanID, @IsAll, @DepartmentID, @TrainingFieldID, @FromDate, @ToDate, @RepeatTypeID, @Notes)			
	END		
	
	FETCH NEXT FROM @Cursor INTO @TransactionID, @TrainingPlanID, @IsAll, @DepartmentID, @TrainingFieldID, @StartDate, @DurationPlan, @RepeatTypeID, @RepeatTime, @Notes
END
CLOSE @Cursor
DEALLOCATE @Cursor	

-- Lấy kế hoạch đào tạo định kỳ lặp lại theo quý không giới hạn
INSERT INTO HRMT2071_Temp (TransactionID, TrainingPlanID, IsAll, DepartmentID, TrainingFieldID, FromDate, ToDate, RepeatTypeID, [Description])	
SELECT TransactionID, TrainingPlanID, IsAll, DepartmentID, TrainingFieldID, 
DATEADD(quarter, 
				((
					CASE WHEN DATEPART(MONTH, StartDate) BETWEEN 1 AND 3 THEN 1
						 WHEN DATEPART(MONTH, StartDate) BETWEEN 4 AND 6 THEN 2
						 WHEN DATEPART(MONTH, StartDate) BETWEEN 7 AND 9 THEN 3 ELSE 4 END
				)-1)*-1+DATEPART(quarter,GETDATE())-1, StartDate) AS FromDate,
DATEADD(DAY, DurationPlan, DATEADD(quarter, 
				((
					CASE WHEN DATEPART(MONTH, StartDate) BETWEEN 1 AND 3 THEN 1
						 WHEN DATEPART(MONTH, StartDate) BETWEEN 4 AND 6 THEN 2
						 WHEN DATEPART(MONTH, StartDate) BETWEEN 7 AND 9 THEN 3 ELSE 4 END
				)-1)*-1+DATEPART(quarter,GETDATE())-1, StartDate)) AS ToDate, RepeatTypeID, Notes		
FROM HRMT2071 WITH (NOLOCK)
WHERE RepeatTypeID = '1'
AND RepeatTime = 0
AND DivisionID = @DivisionID 
UNION ALL 
SELECT TransactionID, TrainingPlanID, IsAll, DepartmentID, TrainingFieldID,
DATEADD(quarter, 
				((
					CASE WHEN DATEPART(MONTH, StartDate) BETWEEN 1 AND 3 THEN 1
						 WHEN DATEPART(MONTH, StartDate) BETWEEN 4 AND 6 THEN 2
						 WHEN DATEPART(MONTH, StartDate) BETWEEN 7 AND 9 THEN 3 ELSE 4 END
				)-2)*-1+DATEPART(quarter,GETDATE())-1, StartDate) AS FromDate,
DATEADD(DAY, DurationPlan, DATEADD(quarter, 
				((
					CASE WHEN DATEPART(MONTH, StartDate) BETWEEN 1 AND 3 THEN 1
						 WHEN DATEPART(MONTH, StartDate) BETWEEN 4 AND 6 THEN 2
						 WHEN DATEPART(MONTH, StartDate) BETWEEN 7 AND 9 THEN 3 ELSE 4 END
				)-2)*-1+DATEPART(quarter,GETDATE())-1, StartDate)) AS ToDate, RepeatTypeID, Notes
FROM HRMT2071 WITH (NOLOCK)
WHERE RepeatTypeID = '1' 
AND RepeatTime = 0
AND DivisionID = @DivisionID 	

-- Lấy kế hoạch đào tạo định kỳ lặp lại theo năm không giới hạn
INSERT INTO HRMT2071_Temp (TransactionID, TrainingPlanID, IsAll, DepartmentID, TrainingFieldID, FromDate, ToDate, RepeatTypeID, [Description])	
SELECT TransactionID, TrainingPlanID, IsAll, DepartmentID, TrainingFieldID, StartDate AS FromDate, DATEADD(DAY, DurationPlan, StartDate) AS ToDate, RepeatTypeID, Notes   			
FROM HRMT2071 WITH (NOLOCK)
WHERE RepeatTypeID = '2' 
AND RepeatTime = 0
AND DivisionID = @DivisionID 	
UNION ALL	
SELECT TransactionID, TrainingPlanID, IsAll, DepartmentID, TrainingFieldID, DATEADD(YEAR, 1, StartDate) AS FromDate, DATEADD(DAY, DurationPlan, DATEADD(YEAR, 1, StartDate)) AS ToDate, RepeatTypeID, Notes   			
FROM HRMT2071 WITH (NOLOCK)
WHERE RepeatTypeID = '2' 
AND RepeatTime = 0
AND DivisionID = @DivisionID 			

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
