IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8151]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP8151]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Xử lý Import kết quả sản xuất
-- <Reference> 
----
---- Created by Bảo Thy on 15/12/2017
---- Modified by Bảo Thy on 09/01/2018: fix lỗi convert date/time khi tính ActWorkingTime
---- Modified by on
---- Example
/*
	EXEC AP8151 'NTY','ASOFTADMIN','AssignMachine'
*/

CREATE PROCEDURE [DBO].[AP8151]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@ImportTemplateID AS NVARCHAR(50),
	@XML AS XML
) 
AS
DECLARE @cCURSOR AS CURSOR,
		@sSQL AS VARCHAR(1000)
		
DECLARE @ColID AS NVARCHAR(50), 
		@ColSQLDataType AS NVARCHAR(50)

CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT,
	Orders INT,
	ImportMessage NVARCHAR(500) DEFAULT (''),
	CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	(
		Row ASC
	) ON [PRIMARY]	
)

SET @cCURSOR = CURSOR STATIC FOR
	SELECT		TLD.ColID,
				BTL.ColSQLDataType
	FROM		A01065 TL
	INNER JOIN	A01066 TLD
			ON	TL.ImportTemplateID = TLD.ImportTemplateID
	INNER JOIN	A00065 BTL
			ON	BTL.ImportTransTypeID = TL.ImportTransTypeID AND BTL.ColID = TLD.ColID
	WHERE		TL.ImportTemplateID = @ImportTemplateID
	ORDER BY	TLD.OrderNum

OPEN @cCURSOR									
-- Tạo cấu trúc bảng tạm
FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType	
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + CASE WHEN @ColSQLDataType LIKE '%char%' THEN ' COLLATE SQL_Latin1_General_CP1_CI_AS' ELSE '' END + ' NULL'
--	PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END

SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
		X.Data.query('Period').value('.', 'VARCHAR(10)') AS Period,
		X.Data.query('MachineID').value('.', 'VARCHAR(50)') AS MachineID,
		X.Data.query('Date').value('.', 'DATETIME') AS [Date],
		--(CASE WHEN X.Data.query('StandardQuantity').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('StandardQuantity').value('.', 'DECIMAL(28,8)') END) AS StandardQuantity,
		(CASE WHEN X.Data.query('InQuantity').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('InQuantity').value('.', 'DECIMAL(28,8)') END) AS InQuantity,
		(CASE WHEN X.Data.query('OutQuantity').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('OutQuantity').value('.', 'DECIMAL(28,8)') END) AS OutQuantity,
		X.Data.query('Notes').value('.', 'NVARCHAR(250)') AS Notes
INTO	#AP8151		
FROM	@XML.nodes('//Data') AS X (Data)

ALTER TABLE #Data ADD ActWorkingTime DECIMAL(28,8)
ALTER TABLE #Data ADD InVariance DECIMAL(28,8)
ALTER TABLE #Data ADD TotalVariance DECIMAL(28,8)
ALTER TABLE #Data ADD StopWorkingTime DECIMAL(28,8)
ALTER TABLE #Data ADD HourPerDay DECIMAL(28,8)
ALTER TABLE #Data ADD QuantityPerDay DECIMAL(28,8)
ALTER TABLE #Data ADD StandardQuantity DECIMAL(28,8)
ALTER TABLE #Data ADD FromTime NVARCHAR(100)
ALTER TABLE #Data ADD ToTime NVARCHAR(100)

INSERT INTO #Data (Row, DivisionID, Period, MachineID, Date, InQuantity, OutQuantity, Notes)
SELECT Row, DivisionID, Period, MachineID, Date, InQuantity, OutQuantity, Notes
FROM #AP8151

SELECT DISTINCT NEWID() AS APKMaster, MachineID
INTO #Data_APKMaster
FROM #Data

DECLARE @TranMonth INT,
		@TranYear INT,
		@DataCol VARCHAR(50),
		@DataCol1 VARCHAR(50)

SELECT @DataCol = DataCol
FROM	A01066 WITH (NOLOCK)
WHERE	ImportTemplateID = @ImportTemplateID AND ColID = 'MachineID'

SELECT @DataCol1 = DataCol
FROM	A01066 WITH (NOLOCK)
WHERE	ImportTemplateID = @ImportTemplateID AND ColID = 'Date'

SET @TranMonth = (SELECT TOP 1 LEFT(Period, 2) FROM #Data)
SET @TranYear = (SELECT TOP 1 RIGHT(Period, 4) FROM #Data)

---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

---- Kiểm tra ghi nhận kết quả máy và ngày trong file import bị trùng
UPDATE T1
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'HFML000581 {0}='''+@DataCol+''''
FROM #Data T1
INNER JOIN 
(
	SELECT MachineID, Date
	FROM #Data
	GROUP BY MachineID, Date
	HAVING COUNT(1) > 1
) T2 ON T1.MachineID = T2.MachineID AND T1.Date = T2.Date

---- Kiểm tra đã tồn tại ngày kết quả sản xuất của máy thì không ghi nhận nữa
UPDATE T1
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'HFML000582 {0}='''+@DataCol+''' {1}='''+@DataCol1+''''
FROM #Data T1
WHERE EXISTS (SELECT TOP 1 1
			  FROM HT1117 WITH (NOLOCK)
			  WHERE HT1117.DivisionID = @DivisionID AND HT1117.TranMonth+HT1117.TranYear*100 = @TranMonth+@TranYear*100
			  AND HT1117.MachineID = T1.MachineID AND T1.Date = HT1117.Date)

-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT

-- Tính các số liệu liên quan kết quả sản xuất
UPDATE T1
SET T1.HourPerDay = T2.HourPerDay,
	T1.QuantityPerDay = T2.QuantityPerDay
FROM #Data T1
INNER JOIN HT1109 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.MachineID = T2.MachineID
WHERE T1.DivisionID = @DivisionID

UPDATE T1
SET T1.FromTime = T3.FromTime,
	T1.ToTime = T3.ToTime
FROM #Data T1
INNER JOIN HT1110 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.MachineID = T2.MachineID AND T2.TranMonth+T2.TranYear*100 = @TranMonth+@TranYear*100
INNER JOIN HT1111 T3 WITH (NOLOCK) ON T3.DivisionID = T2.DivisionID AND T2.APK = T3.APKMaster AND T1.Date = T3.Date
WHERE T1.DivisionID = @DivisionID

UPDATE T1 
SET T1.StopWorkingTime = T2.StopWorkingTime,
	T1.ActWorkingTime = CONVERT(DECIMAL(28,8),DATEDIFF(mi, ISNULL(CONVERT(TIME(0),T1.FromTime),'00:00:00'), ISNULL(CONVERT(TIME(0),T1.ToTime),'00:00:00')))/60 - 1 - ISNULL(T2.StopWorkingTime,0)
FROM #Data T1
LEFT JOIN 
(
 SELECT T1.DivisionID, T1.TranMonth, T1.TranYear, T1.MachineID, T1.Date, SUM(ISNULL(T1.TotalTime,0)) AS StopWorkingTime
 FROM HT1115 T1 WITH (NOLOCK)
 WHERE T1.DivisionID = @DivisionID
 AND T1.TranMonth+T1.TranYear*100 = @TranMonth+@TranYear*100
 AND EXISTS (SELECT TOP 1 1 FROM #Data T2 WHERE T1.DivisionID = T2.DivisionID AND T1.MachineID = T2.MachineID AND T1.TranMonth+T1.TranYear*100 = @TranMonth+@TranYear*100 AND T1.Date = T2.Date)
 GROUP BY T1.DivisionID, T1.TranMonth, T1.TranYear, T1.MachineID, T1.Date
) T2 ON T1.DivisionID = T2.DivisionID AND T1.MachineID = T2.MachineID AND T1.Date = T2.Date

--Lưu ghi nhận kết quả sản xuất
UPDATE T1
SET T1.StandardQuantity = T1.QuantityPerDay/T1.HourPerDay*T1.ActWorkingTime
FROM #Data T1

UPDATE T1
SET T1.InVariance = CASE WHEN (ISNULL(T1.StopWorkingTime,0) + ISNULL(T1.ActWorkingTime,0)) < ISNULL(T1.HourPerDay,0) THEN ISNULL(T1.InQuantity,0) - ISNULL(T1.StandardQuantity,0)
					ELSE ISNULL(T1.InQuantity,0) - ISNULL(T1.StandardQuantity,0)/ISNULL(T1.ActWorkingTime,0)*(ISNULL(T1.HourPerDay,0)- ISNULL(T1.StopWorkingTime,0)) END,
	T1.TotalVariance = (ISNULL(T1.InQuantity,0) + ISNULL(T1.OutQuantity,0)) - ISNULL(T1.StandardQuantity,0)
FROM #Data T1

INSERT INTO HT1117 (APK, DivisionID, MachineID, TranMonth, TranYear, Date, ActWorkingTime, StandardQuantity, InQuantity, OutQuantity, InVariance, TotalVariance,
					Notes, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)

SELECT NEWID(), DivisionID, MachineID, @TranMonth, @TranYear, Date, ActWorkingTime, StandardQuantity, InQuantity, OutQuantity, InVariance, TotalVariance,
					Notes, @UserID, GETDATE(), @UserID, GETDATE()
FROM #Data

LB_RESULT:
SELECT APK, Row, Orders, ImportMessage, DivisionID, Period, MachineID, Date, StandardQuantity, InQuantity, OutQuantity, Notes FROM #Data


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
