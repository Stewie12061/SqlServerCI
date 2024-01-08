IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2016]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OOP2016]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Kiểm tra trùng thời gian xin nghỉ phép
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 30/09/2016
----Modified on 15/03/2023 by Nhựt Trường: [2023/03/IS/0159] Bổ sung thêm điều kiện kiểm tra trùng thời gian xin phép.
----updated  on 11/04/2023 by Thành Sang - Bỏ qua điều kiện với đơn đã từ chối
/*-- <Example>
	OOP2016 @DivisionID='MK',@UserID='000054', @TranMonth=8, @TranYear=2016, @XML = @XML
----*/

CREATE PROCEDURE OOP2016
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@XML XML
)
AS 

CREATE TABLE #TBL_OOP2016 (APK VARCHAR(50), EmployeeID VARCHAR(50), LeaveFromDate DATETIME, LeaveToDate DATETIME, APKMaster VARCHAR(50))

INSERT INTO #TBL_OOP2016
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK,
	   X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
	  (CASE WHEN X.Data.query('LeaveFromDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('LeaveFromDate').value('.', 'DATETIME') END) AS LeaveFromDate,
	  (CASE WHEN X.Data.query('LeaveToDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('LeaveToDate').value('.', 'DATETIME') END) AS LeaveToDate,
	  X.Data.query('APKMaster').value('.', 'NVARCHAR(50)') AS APKMaster
FROM @XML.nodes('//Data') AS X (Data)

DECLARE @Cur CURSOR,
		@APK VARCHAR(50),
		@EmployeeID VARCHAR(50),
		@LeaveFromDate DATETIME,
		@LeaveToDate DATETIME,
		@i INT,
		@APKMaster VARCHAR(50)

SET @APKMaster = (SELECT TOP 1 APKMaster FROM #TBL_OOP2016)
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT Distinct APK, EmployeeID, LeaveFromDate, LeaveToDate FROM #TBL_OOP2016

OPEN @Cur
FETCH NEXT FROM @Cur INTO @APK,@EmployeeID,@LeaveFromDate,@LeaveToDate
WHILE @@FETCH_STATUS = 0
BEGIN
				
	--DECLARE @Cur1 CURSOR,
	--		@APK1 VARCHAR(50),
	--		@LeaveFromDate1 DATETIME,
	--		@LeaveToDate1 DATETIME
	
	--SET @i = 0

	--SET @Cur1 = CURSOR SCROLL KEYSET FOR
	--SELECT Distinct APK, LeaveFromDate, LeaveToDate FROM OOT2010
	--WHERE EmployeeID = @EmployeeID
	--AND MONTH(LeaveFromDate) = MONTH(@LeaveFromDate) AND  YEAR(LeaveFromDate) = YEAR(@LeaveFromDate)
			
	--OPEN @Cur1
	--FETCH NEXT FROM @Cur1 INTO @APK1,@LeaveFromDate1,@LeaveToDate1
	--WHILE @@FETCH_STATUS = 0
	--BEGIN

	
	--IF EXISTS (SELECT TOP 1 1 FROM OOT2010
	--	   WHERE EmployeeID = @EmployeeID
	--	   AND  APK <> @APK
 --          AND (@LeaveFromDate Between @LeaveFromDate1 and @LeaveToDate1
	--			OR @LeaveToDate Between @LeaveFromDate1 and @LeaveToDate1
	--			OR (@LeaveFromDate <= @LeaveFromDate1 AND @LeaveToDate >= @LeaveToDate1))
	--	  AND APK = @APK1	
	--		 )

	--SET @i = @i + 1
	----	select @LeaveFromDate,@LeaveToDate,@LeaveFromDate1,@LeaveToDate1, @i			
	--FETCH NEXT FROM @Cur1 INTO @APK1,@LeaveFromDate1,@LeaveToDate1
	--END 
	--Close @Cur1

	--IF @i = 0
	--DELETE TBL_OOP2016 WHERE APK = @APK 
	--					AND EmployeeID = @EmployeeID
	--					AND LeaveFromDate = @LeaveFromDate 
	--					AND LeaveToDate = @LeaveToDate
	IF NOT EXISTS (SELECT TOP 1 1 FROM OOT2010
		   WHERE EmployeeID = @EmployeeID
		   AND  APKMaster <> @APKMaster
           AND ((	(@LeaveFromDate Between LeaveFromDate and LeaveToDate OR @LeaveToDate Between LeaveFromDate and LeaveToDate)
					AND (@LeaveFromDate >= LeaveToDate AND @LeaveToDate Between LeaveFromDate and LeaveToDate))
				OR (@LeaveFromDate <= LeaveFromDate AND @LeaveToDate >= LeaveToDate))		  
				AND Status <> 2		
			 ) 
	BEGIN 
		DELETE #TBL_OOP2016 
		WHERE EmployeeID = @EmployeeID
		AND LeaveFromDate = @LeaveFromDate 
		AND LeaveToDate = @LeaveToDate
	END

FETCH NEXT FROM @Cur INTO @APK,@EmployeeID,@LeaveFromDate,@LeaveToDate
END 
Close @Cur 

SELECT * FROM #TBL_OOP2016

DROP TABLE #TBL_OOP2016



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

