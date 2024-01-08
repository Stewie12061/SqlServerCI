IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2817]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2817]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Import Cống công tháng
-- <History>
---- Created by Huỳnh Thử on 29/06/2020 
---- 
-- <Example>
/* 
 AP8149 @DivisionID = 'VG', @UserID = 'ASOFTADMIN', @ImportTemplateID = 'SalesOrder', @XML = ''
 */

 CREATE PROCEDURE HP2817
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@TranMonth NVARCHAR(50),
	@TranYear NVARCHAR(50),
	@ImportTemplateID AS NVARCHAR(50),
	@XML AS XML
) 
AS
DECLARE @cCURSOR AS CURSOR,
		@CURSOR AS CURSOR,
		@CURSORPIVOT AS CURSOR,
		@sSQL AS VARCHAR(1000)

		DECLARE @ColID AS NVARCHAR(50), 
		@ColSQLDataType AS NVARCHAR(50),
		@EmployeeID VARCHAR(50),
		@AbsentType VARCHAR(50),
		@AbsentAmount DECIMAL(28,8),
		@CT VARCHAR(50),
		@DepartmentID VARCHAR(50),
		@TeamID VARCHAR(50),
		@Period nvarchar(50),
		@Param1 nvarchar(50)

CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT,
	--EmployeeID NVARCHAR(50),
	--EmployeeName NVARCHAR(50),
	--TranMonth int,
	--TranYear int,
	--DepartmentID NVARCHAR(50) DEFAULT (''),
	--TeamID NVARCHAR(50) DEFAULT (''),
	--AbsentTypeID NVARCHAR(50) DEFAULT (''),
	--AbsentAmount DECIMAL(28,8),
	--CreateUserID NVARCHAR(50) DEFAULT (''),
	--CreateUserID NVARCHAR(50) DEFAULT (''),
	ImportMessage NVARCHAR(MAX) DEFAULT ('')
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
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END 
-- Thêm dữ liệu vào bảng tạm
INSERT INTO #Data (Row, DivisionID,[Period], EmployeeID, EmployeeName, CT,GCTT, [NO], NO1,NT1, BL, NP, 
					ND, AC, OTPN, OTCD, OTMD,OTCDW,OTMDN,OTMH,OTMDL1,OTT,OTN,OTLT,OTDL,CDT,TCCD,
					NC,TCDL,RN1,KTAS)

SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('Period').value('.', 'NVARCHAR(50)') AS [Period],
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
		X.Data.query('EmployeeName').value('.', 'NVARCHAR(50)') AS EmployeeName,
		X.Data.query('CT').value('.', 'NVARCHAR(50)') AS 'CT',
		X.Data.query('GCTT').value('.', 'DECIMAL(28,8)') AS GCTT,
		X.Data.query('NO').value('.', 'DECIMAL(28,8)') AS [NO],
		X.Data.query('NO1').value('.', 'DECIMAL(28,8)') AS NO1,
		X.Data.query('NT1').value('.', 'DECIMAL(28,8)') AS NT1,
		X.Data.query('BL').value('.', 'DECIMAL(28,8)') AS BL,
		X.Data.query('NP').value('.', 'DECIMAL(28,8)') AS NP,
		X.Data.query('ND').value('.', 'DECIMAL(28,8)') AS ND,
		X.Data.query('AC').value('.', 'DECIMAL(28,8)') AS AC,
		X.Data.query('OTPN').value('.', 'DECIMAL(28,8)') AS OTPN,
		X.Data.query('OTCD').value('.', 'DECIMAL(28,8)') AS OTCD,
		X.Data.query('OTMD').value('.', 'DECIMAL(28,8)') AS OTMD,
		X.Data.query('OTCDW').value('.', 'DECIMAL(28,8)') AS OTCDW,
		X.Data.query('OTMDN').value('.', 'DECIMAL(28,8)') AS OTMDN,
		X.Data.query('OTMH').value('.', 'DECIMAL(28,8)') AS OTMH,
		X.Data.query('OTMDL1').value('.', 'DECIMAL(28,8)') AS OTMDL1,
		X.Data.query('OTT').value('.', 'DECIMAL(28,8)') AS OTT,
		X.Data.query('OTN').value('.', 'DECIMAL(28,8)') AS OTN,
		X.Data.query('OTLT').value('.', 'DECIMAL(28,8)') AS OTLT,
		X.Data.query('OTDL').value('.', 'DECIMAL(28,8)') AS OTDL,
		X.Data.query('CDT').value('.', 'DECIMAL(28,8)') AS CDT,
		X.Data.query('TCCD').value('.', 'DECIMAL(28,8)') AS TCCD,
		X.Data.query('NC').value('.', 'DECIMAL(28,8)') AS NC,
		X.Data.query('TCDL').value('.', 'DECIMAL(28,8)') AS TCDL,
		X.Data.query('RN1').value('.', 'DECIMAL(28,8)') AS RN1,
		X.Data.query('KTAS').value('.', 'DECIMAL(28,8)') AS KTAS
		
FROM	@XML.nodes('//Data') AS X (Data)
ORDER BY [Row]
---- Kiểm tra Mã nhân viên có tồn tại không
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidEmployee',
@Module = 'ASOFT-HRM', @ColID = 'EmployeeID', @Param1 = ''

---- Kiểm tra Mã nhân viên duplicate
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidEmployeeDuplicate',
@Module = 'ASOFT-HRM', @ColID = 'EmployeeID', @Param1 = ''

SELECT TOP 1 @Param1 = [Period] FROM #Data
---- Kiểm tra nhân viên đã có trong bảng công tháng chưa
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckValidEmployeeHT2402',
@Module = 'ASOFT-HRM', @ColID = 'EmployeeID', @Param1 = @Param1 

IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT

-- Chạy vòng lập để PIVOT dữ liệu
SET @CURSORPIVOT = CURSOR FOR
	select EmployeeID,AbsentType,AbsentAmount,CT,[Period] from #Data
	UNPIVOT 
	(
		AbsentAmount 
		FOR AbsentType IN (GCTT,[NO], NO1,NT1, BL, NP, 
					ND, AC, OTPN, OTCD, OTMD,OTCDW,OTMDN,OTMH,OTMDL1,OTT,OTN,OTLT,OTDL,CDT,TCCD,
					NC,TCDL,RN1,KTAS)
	) TAB;
OPEN @CURSORPIVOT
FETCH NEXT FROM @CURSORPIVOT INTO @EmployeeID,@AbsentType,@AbsentAmount,@CT,@Period
WHILE @@FETCH_STATUS = 0
BEGIN
		SELECT @TranMonth = SUBSTRING(@Period,0,3)
		SELECT @Tranyear = SUBSTRING(@Period,4,4)
    -- lấy DepartmentID, TeamID
	SELECT @DepartmentID = DepartmentID, @TeamID = TeamID FROM HT2400 WHERE EmployeeID = @EmployeeID AND TranMonth = @TranMonth AND TranYear = @TranYear
	-- kiểm tra thử việc hay không
	IF(@CT = 'C')
		SET @AbsentType = 'T.' +@AbsentType 
	ELSE
        SET @AbsentType = 'T.' +@AbsentType +'_TV'
	-- Insert vào bảng công tháng
	EXEC(
	'INSERT INTO dbo.HT2402M'+@TranMonth+@TranYear+'
	(
	   
	    DivisionID,
	    EmployeeID,
	    TranMonth,
	    TranYear,
	    DepartmentID,
	    TeamID,
	    AbsentTypeID,
	    AbsentAmount,
	    CreateDate,
	    CreateUserID,
	    LastModifyDate,
	    LastModifyUserID,
	    PeriodID,
	    AbsentMonthID
	)
	VALUES
	(   
	    '''+@DivisionID+''',       -- DivisionID - nvarchar(50)
	    '''+@EmployeeID+''',       -- EmployeeID - nvarchar(50)
	    '+@TranMonth+',         -- TranMonth - int
	    '+@TranYear+',         -- TranYear - int
	    '''+@DepartmentID+''',       -- DepartmentID - nvarchar(50)
	    '''+@TeamID+''',       -- TeamID - nvarchar(50)
	    '''+@AbsentType+''',       -- AbsentTypeID - nvarchar(50)
	    '+@AbsentAmount+',      -- AbsentAmount - decimal(28, 8)
	    GETDATE(), -- CreateDate - datetime
	    '''+@UserID+''',       -- CreateUserID - nvarchar(50)
	    GETDATE(), -- LastModifyDate - datetime
	    '''+@UserID+''',       -- LastModifyUserID - nvarchar(50)
	    N''P01'',       -- PeriodID - nvarchar(50)
	    N''NULL''        -- AbsentMonthID - nvarchar(50)
	    )	'
	)
	FETCH NEXT FROM @CURSORPIVOT INTO @EmployeeID,@AbsentType,@AbsentAmount,@CT,@Period
END 


	LB_RESULT:
SELECT * FROM #Data
