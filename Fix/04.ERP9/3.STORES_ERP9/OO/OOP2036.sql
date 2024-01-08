IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2036]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OOP2036]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Kiểm tra trùng thời gian xin làm thêm giờ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 30/09/2016
/*-- <Example>
	OOP2036 @DivisionID='MK',@UserID='000054', @TranMonth=8, @TranYear=2016, @XML = @XML
----*/

CREATE PROCEDURE OOP2036
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@XML XML
)
AS 

CREATE TABLE #TBL_OOP2036 (APK VARCHAR(50), EmployeeID VARCHAR(50), WorkFromDate DATETIME, WorkToDate DATETIME, APKMaster VARCHAR(50))



INSERT INTO #TBL_OOP2036
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK,
	   X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
	  (CASE WHEN X.Data.query('WorkFromDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('WorkFromDate').value('.', 'DATETIME') END) AS WorkFromDate,
	  (CASE WHEN X.Data.query('WorkToDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('WorkToDate').value('.', 'DATETIME') END) AS WorkToDate,
	   X.Data.query('APKMaster').value('.', 'NVARCHAR(50)') AS APKMaster
FROM @XML.nodes('//Data') AS X (Data)


DECLARE @Cur CURSOR,
		@APK VARCHAR(50),
		@EmployeeID VARCHAR(50),
		@WorkFromDate DATETIME,
		@WorkToDate DATETIME,
		@i INT,
		@APKMaster VARCHAR(50)

SET @APKMaster = (SELECT TOP 1 APKMaster from #TBL_OOP2036)
Print @APKMaster
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT Distinct APK, EmployeeID, WorkFromDate, WorkToDate FROM #TBL_OOP2036

OPEN @Cur
FETCH NEXT FROM @Cur INTO @APK,@EmployeeID,@WorkFromDate,@WorkToDate
WHILE @@FETCH_STATUS = 0
BEGIN
				
	--DECLARE @Cur1 CURSOR,
	--		@APK1 VARCHAR(50),
	--		@WorkFromDate1 DATETIME,
	--		@WorkToDate1 DATETIME
	
	--SET @i = 0

	--SET @Cur1 = CURSOR SCROLL KEYSET FOR
	--SELECT Distinct APK, WorkFromDate, WorkToDate FROM OOT2030
	--WHERE EmployeeID = @EmployeeID
	--AND MONTH(WorkFromDate) = MONTH(@WorkFromDate) AND  YEAR(WorkFromDate) = YEAR(@WorkFromDate)
	--AND APKMaster <> @APKMaster
			
	--OPEN @Cur1
	--FETCH NEXT FROM @Cur1 INTO @APK1,@WorkFromDate1,@WorkToDate1
	--WHILE @@FETCH_STATUS = 0
	--BEGIN	
	--IF EXISTS (SELECT TOP 1 1 FROM OOT2030
	--	   WHERE EmployeeID = @EmployeeID
	--	   AND  APKMaster <> @APKMaster
 --          AND (@WorkFromDate Between @WorkFromDate1 and @WorkToDate1
	--			OR @WorkToDate Between @WorkFromDate1 and @WorkToDate1
	--			OR (@WorkFromDate <= @WorkFromDate1 AND @WorkToDate >= @WorkToDate1))
	--		AND APK = @APK1		  
	--		 )
			
	--SET @i = @i + 1
	--	--select @WorkFromDate,@WorkToDate,@WorkFromDate1,@WorkToDate1, @i			
	--FETCH NEXT FROM @Cur1 INTO @APK1,@WorkFromDate1,@WorkToDate1
	--END 
	--Close @Cur1
	--IF @i = 0
	--DELETE #TBL_OOP2036 WHERE APK = @APK 
	--					AND EmployeeID = @EmployeeID
	--					AND WorkFromDate = @WorkFromDate 
	--					AND WorkToDate = @WorkToDate

	IF NOT EXISTS (SELECT TOP 1 1 FROM OOT2030
		   WHERE EmployeeID = @EmployeeID
		   AND  APKMaster <> @APKMaster
           AND (@WorkFromDate Between WorkFromDate and WorkToDate
				OR @WorkToDate Between WorkFromDate and WorkToDate
				OR (@WorkFromDate <= WorkFromDate AND @WorkToDate >= WorkToDate))			
			 )
	BEGIN
		DELETE #TBL_OOP2036
		WHERE --APK = @APK 
		EmployeeID = @EmployeeID
		AND WorkFromDate = @WorkFromDate 
		AND WorkToDate = @WorkToDate
	END
FETCH NEXT FROM @Cur INTO @APK,@EmployeeID,@WorkFromDate,@WorkToDate
END 
Close @Cur 

SELECT * FROM #TBL_OOP2036

--DELETE #TBL_OOP2036
drop table #TBL_OOP2036


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

