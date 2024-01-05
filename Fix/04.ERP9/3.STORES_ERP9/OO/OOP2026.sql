IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2026]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OOP2026]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Kiểm tra trùng thời gian xin ra ngoài
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 30/09/2016
/*-- <Example>
	OOP2026 @DivisionID='MK',@UserID='000054', @TranMonth=8, @TranYear=2016, @XML = @XML
----*/

CREATE PROCEDURE OOP2026
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@XML XML
)
AS 

CREATE TABLE #TBL_OOP2026 (APK VARCHAR(50), EmployeeID VARCHAR(50), GoFromDate DATETIME, GoToDate DATETIME, APKMaster VARCHAR(50))

INSERT INTO #TBL_OOP2026
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK,
	   X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
	  (CASE WHEN X.Data.query('GoFromDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('GoFromDate').value('.', 'DATETIME') END) AS GoFromDate,
	  (CASE WHEN X.Data.query('GoToDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('GoToDate').value('.', 'DATETIME') END) AS GoToDate,
	  X.Data.query('APKMaster').value('.', 'NVARCHAR(50)') AS APKMaster
FROM @XML.nodes('//Data') AS X (Data)

DECLARE @Cur CURSOR,
		@APK VARCHAR(50),
		@EmployeeID VARCHAR(50),
		@GoFromDate DATETIME,
		@GoToDate DATETIME,
		@i INT,
		@APKMaster VARCHAR(50)

SET @APKMaster = (SELECT TOP 1 APKMaster FROM #TBL_OOP2026)
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT Distinct APK, EmployeeID, GoFromDate, GoToDate FROM #TBL_OOP2026

OPEN @Cur
FETCH NEXT FROM @Cur INTO @APK,@EmployeeID,@GoFromDate,@GoToDate
WHILE @@FETCH_STATUS = 0
BEGIN

	--DECLARE @Cur1 CURSOR,
	--		@APK1 VARCHAR(50),
	--		@GoFromDate1 DATETIME,
	--		@GoToDate1 DATETIME
	
	--SET @i = 0

	--SET @Cur1 = CURSOR SCROLL KEYSET FOR
	--SELECT Distinct APK, GoFromDate, GoToDate FROM OOT2020
	--WHERE EmployeeID = @EmployeeID
	--AND MONTH(GoFromDate) = MONTH(@GoFromDate) AND  YEAR(GoFromDate) = YEAR(@GoFromDate)
			
	--OPEN @Cur1
	--FETCH NEXT FROM @Cur1 INTO @APK1,@GoFromDate1,@GoToDate1
	--WHILE @@FETCH_STATUS = 0
	--BEGIN

	
	--IF EXISTS (SELECT TOP 1 1 FROM OOT2020
	--	   WHERE EmployeeID = @EmployeeID
	--	   AND  APK <> @APK
 --          AND (@GoFromDate Between @GoFromDate1 and @GoToDate1
	--			OR @GoToDate Between @GoFromDate1 and @GoToDate1
	--			OR (@GoFromDate <= @GoFromDate1 AND @GoToDate >= @GoToDate1))
	--	   AND APK = @APK1		
	--		 )

	--SET @i = @i + 1
	--	--select @GoFromDate,@GoToDate,@GoFromDate1,@GoToDate1, @i			
	--FETCH NEXT FROM @Cur1 INTO @APK1,@GoFromDate1,@GoToDate1
	--END 
	--Close @Cur1

	--IF @i = 0
	--DELETE #TBL_OOP2026 WHERE APK = @APK 
	--					AND EmployeeID = @EmployeeID
	--					AND GoFromDate = @GoFromDate 
	--					AND GoToDate = @GoToDate
	IF NOT EXISTS(SELECT TOP 1 1 FROM OOT2020
					   WHERE EmployeeID = @EmployeeID
					   AND  APKMaster <> @APKMaster
					   AND (@GoFromDate Between GoFromDate and GoToDate
							OR @GoToDate Between GoFromDate and GoToDate
							OR (@GoFromDate <= GoFromDate AND @GoToDate >= GoToDate))
			 )
	BEGIN
		DELETE #TBL_OOP2026 
		WHERE EmployeeID = @EmployeeID
		AND GoFromDate = @GoFromDate 
		AND GoToDate = @GoToDate
	END

FETCH NEXT FROM @Cur INTO @APK,@EmployeeID,@GoFromDate,@GoToDate
END 
Close @Cur 

SELECT * FROM #TBL_OOP2026

DROP TABLE #TBL_OOP2026



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

