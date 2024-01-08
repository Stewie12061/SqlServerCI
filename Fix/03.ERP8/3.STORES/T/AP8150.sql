IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8150]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP8150]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Xử lý Import phân công nhân viên đứng máy
-- <Reference> 
----
---- Created by Bảo Thy on 15/12/2017
---- Modified by Bảo Thy on 23/03/2018: bổ sung kiểm tra phân công máy theo ngày nghỉ việc của nhân viên (không quan tâm EmployeeStatus)
---- Modified by on
---- Example
/*
	EXEC AP8150 'NTY','ASOFTADMIN','AssignMachine'
*/

CREATE PROCEDURE [DBO].[AP8150]
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
		X.Data.query('EmployeeID').value('.', 'VARCHAR(50)') AS EmployeeID,
		X.Data.query('Date').value('.', 'DATETIME') AS [Date]
INTO	#AP8150		
FROM	@XML.nodes('//Data') AS X (Data)

ALTER TABLE #Data ADD LeaveDate DATETIME

INSERT INTO #Data (Row, DivisionID, Period, MachineID, EmployeeID, Date, LeaveDate)
SELECT T1.Row, T1.DivisionID, T1.Period, T1.MachineID, T1.EmployeeID, T1.Date, T2.LeaveDate
FROM #AP8150 T1
LEFT JOIN HT1403 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID

SELECT DISTINCT NEWID() AS APKMaster, MachineID
INTO #Data_APKMaster
FROM 
(SELECT DISTINCT MachineID FROM #Data)Temp

DECLARE @TranMonth INT,
		@TranYear INT,
		@DataCol VARCHAR(50),
		@DataCol1 VARCHAR(50),
		@DataCol2 VARCHAR(50)

SELECT @DataCol = DataCol
FROM	A01066 WITH (NOLOCK)
WHERE	ImportTemplateID = @ImportTemplateID AND ColID = 'MachineID'

SELECT @DataCol1 = DataCol
FROM	A01066 WITH (NOLOCK)
WHERE	ImportTemplateID = @ImportTemplateID AND ColID = 'EmployeeID'

SELECT @DataCol2 = DataCol
FROM	A01066 WITH (NOLOCK)
WHERE	ImportTemplateID = @ImportTemplateID AND ColID = 'Date'

SET @TranMonth = (SELECT TOP 1 LEFT(Period, 2) FROM #Data)
SET @TranYear = (SELECT TOP 1 RIGHT(Period, 4) FROM #Data)

---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

---- Kiểm tra phân công NV trong file import bị trùng
UPDATE T1
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'HFML000580 {0}='''+@DataCol1+''''
FROM #Data T1
INNER JOIN 
(
	SELECT MachineID, EmployeeID, Date
	FROM #Data
	GROUP BY MachineID, EmployeeID, Date
	HAVING COUNT(1) > 1
) T2 ON T1.EmployeeID = T2.EmployeeID AND T1.MachineID = T2.MachineID AND T1.Date = T2.Date

---- Kiểm tra nếu NV đã được phân công trước đó thì không được phân công nữa
UPDATE T1
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'HFML000579 {0}='''+@DataCol+''' {1}='''+@DataCol1+''' {2}='''+@DataCol2+''''
FROM #Data T1
INNER JOIN 
(
	SELECT MachineID, EmployeeID, Date
	FROM HT1113 WITH (NOLOCK)
	WHERE TranMonth = @TranMonth AND TranYear = @TranYear
) T2 ON T1.EmployeeID = T2.EmployeeID AND T1.MachineID = T2.MachineID AND T1.Date = T2.Date

---- Kiểm tra không được phân công sau ngày nghỉ việc của nhân viên
UPDATE T1
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'HFML000586 {0}='''+@DataCol1+''' {1}='''+@DataCol2+''''
FROM #Data T1
WHERE T1.Date >= T1.LeaveDate

-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT
	
--Lưu phân công nhân viên đứng máy 
INSERT INTO HT1113 (APK, DivisionID, APKMaster, TranMonth, TranYear, MachineID, EmployeeID, Date, ActFromTime, ActToTime, CreateUserID, CreateDate, LastmodifyDate, LastmodifyUserID)
SELECT NEWID(), T1.DivisionID, T2.APKMaster, @TranMonth, @TranYear, T1.MachineID, T1.EmployeeID, T1.Date, NULL, NULL, @UserID, GETDATE(), GETDATE(), @UserID
FROM #Data T1
INNER JOIN #Data_APKMaster T2 ON T1.MachineID = T2.MachineID

LB_RESULT:
SELECT * FROM #Data

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
