IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2046]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OOP2046]
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
	OOP2046 @DivisionID='MK',@UserID='000054', @TranMonth=8, @TranYear=2016, @XML = @XML
----*/

CREATE PROCEDURE OOP2046
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@XML XML
)
AS 

CREATE TABLE #TBL_OOP2046 (APK VARCHAR(50), EmployeeID VARCHAR(50), [Date] DATETIME, InOut TINYINT, APKMaster VARCHAR(50))


INSERT INTO #TBL_OOP2046
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK,
	   X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
	  (CASE WHEN X.Data.query('Date').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Date').value('.', 'DATETIME') END) AS [Date],
	  (CASE WHEN X.Data.query('InOut').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('InOut').value('.', 'TINYINT') END) AS InOut,
	  X.Data.query('APKMaster').value('.', 'NVARCHAR(50)') AS APKMaster
FROM @XML.nodes('//Data') AS X (Data)

DECLARE @Cur CURSOR,
		@APK VARCHAR(50),
		@EmployeeID VARCHAR(50),
		@Date DATETIME,
		@InOut TINYINT,
		@i INT,
		@APKMaster VARCHAR(50)

SET @APKMaster = (SELECT TOP 1 APKMaster FROM #TBL_OOP2046)

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT Distinct APK, EmployeeID, [Date], InOut FROM #TBL_OOP2046

OPEN @Cur
FETCH NEXT FROM @Cur INTO @APK,@EmployeeID,@Date,@InOut
WHILE @@FETCH_STATUS = 0
BEGIN
				
	--DECLARE @Cur1 CURSOR,
	--		@APK1 VARCHAR(50),
	--		@Date1 DATETIME,
	--		@InOut1 TINYINT
	
	--SET @i = 0

	--SET @Cur1 = CURSOR SCROLL KEYSET FOR
	--SELECT Distinct APK, [Date], InOut FROM OOT2040
	--WHERE EmployeeID = @EmployeeID
	--AND MONTH([Date]) =  MONTH(@Date) AND  YEAR([Date]) = YEAR(@Date)
			
	--OPEN @Cur1
	--FETCH NEXT FROM @Cur1 INTO @APK1,@Date1,@InOut1
	--WHILE @@FETCH_STATUS = 0
	--BEGIN
	
	--IF EXISTS (SELECT TOP 1 1 FROM OOT2040
	--		   WHERE EmployeeID = @EmployeeID
	--		   AND  APK <> @APK
	--		   AND @Date = @Date1 AND @InOut = @InOut1)
			 
	--SET @i = @i + 1
	----	select @LeaveFromDate,@LeaveToDate,@LeaveFromDate1,@LeaveToDate1, @i			
	--FETCH NEXT FROM @Cur1 INTO @APK1,@Date1,@InOut1
	--END 
	--Close @Cur1

	--IF @i = 0
	--DELETE #TBL_OOP2046 WHERE APK = @APK 
	--					AND EmployeeID = @EmployeeID
	--					AND [Date] = @Date 
	--					AND InOut = @InOut
	IF NOT EXISTS (SELECT TOP 1 1 FROM OOT2040
			   WHERE EmployeeID = @EmployeeID
			   AND  APKMaster <> @APKMaster
			   AND @Date = [Date] AND @InOut = InOut)
	BEGIN
		DELETE #TBL_OOP2046
		WHERE EmployeeID = @EmployeeID
		AND [Date] = @Date
		AND InOut = @InOut
	END

FETCH NEXT FROM @Cur INTO @APK,@EmployeeID,@Date,@InOut
END 
Close @Cur 

SELECT * FROM #TBL_OOP2046

DROP TABLE #TBL_OOP2046


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

