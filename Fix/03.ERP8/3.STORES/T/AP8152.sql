IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8152]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP8152]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---- Xử lý Import thời gian dừng máy (NEWTOYO)
-- <Reference> 
----
---- Created by Bảo Thy on 22/03/2018
---- Modified by on
---- Example
/*
	EXEC AP8152 'NTY','ASOFTADMIN','StoppedTImeMachine', '<Data>
  <Row>1</Row>
  <DivisionID>NTY</DivisionID>
  <Period>02/2018</Period>
  <MachineID>CONECUON6</MachineID>
  <date>2018-02-02</date>
  <FromTime>09:15:00</FromTime>
  <ToTime>10:30:00</ToTime>
  <Notes>Ghi chú 1</Notes>
</Data>
<Data>
  <Row>2</Row>
  <DivisionID>NTY</DivisionID>
  <Period>02/2018</Period>
  <MachineID>CONECUON6</MachineID>
  <date>2018-02-12</date>
  <FromTime>08:15:00</FromTime>
  <ToTime>09:10:00</ToTime>
  <Notes>Ghi chú 2</Notes>
</Data>
<Data>
  <Row>3</Row>
  <DivisionID>NTY</DivisionID>
  <Period>02/2018</Period>
  <MachineID>CONECUON6</MachineID>
  <date>2018-02-18</date>
  <FromTime>08:15:00</FromTime>
  <ToTime>09:10:00</ToTime>
  <Notes>Ghi chú 3</Notes>
</Data>
<Data>
  <Row>4</Row>
  <DivisionID>NTY</DivisionID>
  <Period>02/2018</Period>
  <MachineID>CONECUON5</MachineID>
  <date>2018-02-12</date>
  <FromTime>08:15:00</FromTime>
  <ToTime>09:10:00</ToTime>
  <Notes>Ghi chú 2</Notes>
</Data>'
*/

CREATE PROCEDURE [DBO].[AP8152]
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
		CASE WHEN X.Data.query('Date').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Date').value('.', 'VARCHAR(50)') END AS [Date],
		X.Data.query('FromTime').value('.', 'VARCHAR(50)') AS FromTime,
		X.Data.query('ToTime').value('.', 'VARCHAR(50)') AS ToTime,
		X.Data.query('Notes').value('.', 'NVARCHAR(250)') AS Notes
INTO	#AP8152		
FROM	@XML.nodes('//Data') AS X (Data)

ALTER TABLE #Data ADD StandardFromTime VARCHAR(50)
ALTER TABLE #Data ADD StandardToTime VARCHAR(50)
ALTER TABLE #Data ADD TotalTime DECIMAL(28,8)
ALTER TABLE #Data ADD ShiftDate VARCHAR(3)
ALTER TABLE #Data ADD EmployeeID VARCHAR(50)
ALTER TABLE #Data ADD ShiftID VARCHAR(50)

INSERT INTO #Data (Row, DivisionID, Period, MachineID, Date, FromTime, ToTime, Notes, ShiftDate)
SELECT Row, DivisionID, Period, MachineID, Date, FromTime, ToTime, Notes, 'D'+CASE WHEN DAY(Date) < 10 THEN '0'+LTRIM(DAY(Date)) ELSE LTRIM(DAY(Date)) END
FROM #AP8152

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

---- Kiểm tra máy đã được phân công sản xuất chưa
UPDATE T1
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'HFML000585 {0}='''+@DataCol+''' {1}='''+@DataCol1+''''
FROM #Data T1
WHERE NOT EXISTS (SELECT TOP 1 1
			  FROM HT1110 WITH (NOLOCK)
			  INNER JOIN HT1111 WITH (NOLOCK) ON HT1110.DivisionID = HT1111.DivisionID AND HT1110.APK = HT1111.APKMaster
			  WHERE HT1110.DivisionID = T1.DivisionID AND HT1110.TranMonth+HT1110.TranYear*100 = @TranMonth+@TranYear*100
			  AND HT1110.MachineID = T1.MachineID AND T1.Date = HT1111.Date)


---- Kiểm tra thời gian dừng máy bị trùng
UPDATE T1
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'HFML000584 {0}='''+@DataCol+''''
FROM #Data T1
WHERE EXISTS (SELECT TOP 1 1 FROM #Data T2
			  WHERE T1.MachineID = T2.MachineID AND T1.Date = T2.Date AND T1.Row <> T2.Row
			  AND ((T2.FromTime BETWEEN T1.FromTime AND T1.ToTime) 
				  OR (T2.ToTime BETWEEN T1.FromTime AND T1.ToTime) 
				  OR (T1.FromTime BETWEEN T2.FromTime AND T2.ToTime)
				  OR (T1.ToTime BETWEEN T2.FromTime AND T2.ToTime)))
OR EXISTS (SELECT TOP 1 1 FROM HT1115 T3
		  WHERE T1.MachineID = T3.MachineID AND T1.Date = T3.Date
		  AND ((T3.FromTime BETWEEN T1.FromTime AND T1.ToTime) 
		    OR (T3.ToTime BETWEEN T1.FromTime AND T1.ToTime) 
		    OR (T1.FromTime BETWEEN T3.FromTime AND T3.ToTime)
		    OR (T1.ToTime BETWEEN T3.FromTime AND T3.ToTime)))

-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT

----Xử lý và insert dữ liệu
UPDATE #Data
SET #Data.EmployeeID = T2.EmployeeID
FROM #Data
INNER JOIN 
(
	SELECT T1.MachineID, MAX(T1.EmployeeID) AS EmployeeID
	FROM HT1113 T1 WITH (NOLOCK)
	WHERE T1.DivisionID = @DivisionID
	AND T1.TranMonth+T1.TranYear*100 = @TranMonth+@TranYear*100
	GROUP BY T1.MachineID
)T2 ON T2.MachineID = #Data.MachineID

SELECT EmployeeID, StrDate, ShiftID
INTO #HT1025_AP8152
FROM 
(SELECT T1.EmployeeID, [D01], [D02], [D03], [D04], [D05], [D06], [D07], [D08], [D09], [D10], [D11], [D12], [D13], [D14], [D15], [D16], [D17], [D18], [D19], [D20], 
[D21], [D22], [D23], [D24], [D25], [D26], [D27], [D28], [D29], [D30], [D31]
FROM HT1025 T1 WITH (NOLOCK)
INNER JOIN #Data T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.TranMonth+T1.TranYear*100 = @TranMonth+@TranYear*100) p
UNPIVOT
(ShiftID FOR StrDate IN ([D01], [D02], [D03], [D04], [D05], [D06], [D07], [D08], [D09], [D10], [D11], [D12], [D13], [D14], [D15], [D16], [D17], [D18], [D19], [D20], 
						 [D21], [D22], [D23], [D24], [D25], [D26], [D27], [D28], [D29], [D30], [D31])
)AS unpvt


UPDATE T1
SET T1.ShiftID = T2.ShiftID
FROM #Data T1
INNER JOIN #HT1025_AP8152 T2 ON T1.EmployeeID = T2.EmployeeID AND T1.ShiftDate = T2.StrDate

UPDATE T1
SET T1.StandardFromTime = T2.FromBreakTime, 
	T1.StandardToTime = T2.ToBreakTime
FROM #Data T1
INNER JOIN HT1020 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.ShiftID = T2.ShiftID

UPDATE #Data
SET TotalTime = CASE WHEN ToTime < StandardFromTime OR FromTime > StandardToTime THEN CONVERT(DECIMAL(28,8),DATEDIFF(mi,FromTime,ToTime))/60
					  WHEN (StandardFromTime BETWEEN FromTime AND ToTime) AND (StandardToTime BETWEEN FromTime AND ToTime)
						THEN CONVERT(DECIMAL(28,8),DATEDIFF(mi,FromTime,ToTime))/60 - CONVERT(DECIMAL(28,8),DATEDIFF(mi,StandardFromTime,StandardToTime))/60
					  WHEN (StandardFromTime BETWEEN FromTime AND ToTime) AND StandardToTime > ToTime
						THEN CONVERT(DECIMAL(28,8),DATEDIFF(mi,FromTime,ToTime))/60 - CONVERT(DECIMAL(28,8),DATEDIFF(mi,StandardFromTime,ToTime))/60
					  WHEN (StandardToTime BETWEEN FromTime AND ToTime) AND StandardFromTime < FromTime
						THEN CONVERT(DECIMAL(28,8),DATEDIFF(mi,FromTime,ToTime))/60 - CONVERT(DECIMAL(28,8),DATEDIFF(mi,FromTime,StandardToTime))/60
END


INSERT INTO HT1115 (APK, DivisionID, MachineID, TranMonth, TranYear, Date, FromTime, ToTime, TotalTime, Notes, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, StandardFromTime, StandardToTime)
SELECT NEWID(), DivisionID, MachineID, @TranMonth, @TranYear, Date, FromTime, ToTime, TotalTime, Notes, @UserID, GETDATE(), @UserID, GETDATE(), StandardFromTime, StandardToTime
FROM #Data

LB_RESULT:
SELECT * FROM #Data

DROP TABLE #Data

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
