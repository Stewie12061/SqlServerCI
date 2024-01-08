IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8158]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP8158]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
----
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 02/10/2019 by Khánh Đoan : Import Quyết đinh thôi việc
---- Modified on 06/07/2023 by Nhựt Trường: Bổ sung cập nhật ngày hiệu lực của hồ sơ lương
---- Modified on 20/07/2023 by Kiều Nga: Chỉnh sửa thứ tự cập nhật ngày hiệu lực của hồ sơ lương thành sau khi insert HT1380


CREATE PROCEDURE [DBO].[AP8158]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@ImportTemplateID AS NVARCHAR(50),
	@XML AS XML
) 
AS
DECLARE @cCURSOR AS CURSOR,
		@sSQL AS VARCHAR(MAX)

DECLARE @ColID AS NVARCHAR(50), 
		@ColSQLDataType AS NVARCHAR(50)


		
CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT,
	DecidingPersonDuty NVARCHAR(250),
	ProposerDuty NVARCHAR(250),
	DutyName NVARCHAR(250),
	WorkDate DATETIME,
	Proposer NVARCHAR(50),
	S1 NVARCHAR(50),
	S2 NVARCHAR(50), 
	S3 NVARCHAR(50),
	DecidingNo NVARCHAR(50),
	ImportMessage NVARCHAR(500) DEFAULT (''),
	--CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
)

CREATE TABLE #Keys
(
	Row INT ,	
	DecidingNo NVARCHAR(50)
	--CONSTRAINT [PK_#Keys] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
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
	----PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END
	
SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('Period').value('.', 'VARCHAR(10)') AS Period,
		X.Data.query('DecidingPerson').value('.', 'NVARCHAR(50)') AS DecidingPerson,
		X.Data.query('DecidingDate').value('.', 'DATETIME') AS DecidingDate,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
		X.Data.query('LeaveDate').value('.', 'DATETIME') AS LeaveDate,
		X.Data.query('QuitJobID').value('.', 'NVARCHAR(250)') AS QuitJobID,
		X.Data.query('Allowance').value('.', 'NVARCHAR(50)') AS Allowance,
		X.Data.query('Notes').value('.', 'NVARCHAR(250)') AS Notes,
		X.Data.query('Subsidies').value('.', 'NVARCHAR(500)') AS Subsidies,
		X.Data.query('IsBreaking').value('.', 'TINYINT') AS IsBreaking,
		X.Data.query('LeaveToDate').value('.', 'DATETIME') AS LeaveToDate,
		X.Data.query('Parameter01').value('.', 'NVARCHAR(250)') AS Parameter01

INTO	#AP8158
FROM	@XML.nodes('//Data') AS X (Data)


INSERT INTO #Data (Row, DivisionID,Period,
			DecidingPerson,	DecidingDate,
			EmployeeID,LeaveDate,QuitJobID	,Allowance	,Notes,
			Subsidies	,IsBreaking	,LeaveToDate,Parameter01)

SELECT		 Row, DivisionID,Period,
			DecidingPerson,DecidingDate,
			EmployeeID,LeaveDate,QuitJobID	,Allowance	,Notes,
			Subsidies,IsBreaking	,LeaveToDate,Parameter01
FROM  #AP8158


---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID


-- Sinh khóa

DECLARE @cKey AS CURSOR
DECLARE
		@Row AS INT,
		@LastKey AS  INT,
		@substr AS VARCHAR(50)

SET @cKey = CURSOR SCROLL KEYSET FOR
	SELECT	Row,DecidingNo
	FROM	#Data 

OPEN @cKey
FETCH NEXT FROM @cKey INTO @Row,  @substr
WHILE @@FETCH_STATUS = 0
BEGIN
		
		SET @LastKey = (SELECT LastKey from AT4444 where TABLENAME = 'HT1380' AND KEYSTRING =
					   (SELECT CONCAT((Select S From HT3104 T04 WITH (NOLOCK) Where Disabled=0 And STypeID='D01'and T04.DivisionID = @DivisionID),
		               (Select S From HT3104 T04 WITH (NOLOCK) Where Disabled=0 And STypeID='D02'and T04.DivisionID = @DivisionID))))
		SET @substr=   (SELECT(CONCAT(LEFT('0000',4-LEN(LTRIM(cast(@lastkey +1 as INT))))+LTRIM(cast(@lastkey+1 as INT)),'/',
		              (Select S From HT3104 T04 WITH (NOLOCK) Where Disabled=0 And STypeID='D01' and T04.DivisionID = @DivisionID),'/',
		              (Select S From HT3104 T04 WITH (NOLOCK) Where Disabled=0 And STypeID='D02'and T04.DivisionID = @DivisionID))))

		UPDATE AT4444 SET LASTKEY = @lastkey +1  WHERE AT4444.DivisionID= @DivisionID and TABLENAME = 'HT1380' AND KEYSTRING =
		(SELECT CONCAT((Select S From HT3104 T04 WITH (NOLOCK) Where Disabled=0 And STypeID='D01'and T04.DivisionID = @DivisionID),
		               (Select S From HT3104 T04 WITH (NOLOCK) Where Disabled=0 And STypeID='D02'and  T04.DivisionID = @DivisionID)))
					   

	INSERT INTO #Keys(Row,DecidingNo)
	VALUES (@Row, @substr)				
	FETCH NEXT FROM @cKey INTO @Row,  @substr
END
CLOSE @cKey

 --Cập nhật khóa
UPDATE		DT
SET			DT.DecidingNo = K.DecidingNo 
		
FROM		#Data DT
INNER JOIN	#Keys K
		ON	K.Row = DT.Row


---Cập nhật PL1
UPDATE		DT
SET			S1= T04.S

FROM		#Data DT
INNER JOIN	HT3104 T04 WITH (NOLOCK)
		ON	T04.Disabled=0  AND STypeID='D01' 

 
---Cập nhật PL2
UPDATE		DT
SET			S2= T04.S

FROM		#Data DT
INNER JOIN	HT3104 T04 WITH (NOLOCK)
		ON	T04.Disabled=0  AND STypeID='D02' 

---- Cập nhật người quyết định	
UPDATE		DT
SET			DT.Proposer = @UserID

FROM		#Data DT



-- Cập nhật chức vụ  người quyết định 
UPDATE		DT
SET			DecidingPersonDuty = HV.DutyName

FROM		#Data DT
INNER JOIN	HV1400 HV WITH (NOLOCK)
		ON	HV.EmployeeID = DT.DecidingPerson

-- Cập nhật chức vụ  người đề ghị
UPDATE		DT
SET			ProposerDuty= HV.DutyName

FROM		#Data DT
INNER JOIN	HV1400 HV WITH (NOLOCK)
		ON	HV.EmployeeID = DT.Proposer

-- Cập nhật chức vụ  nhân viên
UPDATE		DT
SET			DutyName= HV.DutyName

FROM		#Data DT
INNER JOIN	HV1400 HV WITH (NOLOCK)
		ON	HV.EmployeeID = DT.EmployeeID 

-- Cập nhật ngày vào làm
UPDATE		DT
SET			WorkDate= T03.WorkDate

FROM		#Data DT
INNER JOIN	HT1403 T03 WITH (NOLOCK)
		ON	T03.EmployeeID = DT.EmployeeID 

---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <>'')
GOTO LB_RESULT



INSERT INTO	HT1380(DivisionID,	DecidingNo,S1,S2,DecidingDate,	
				DecidingPerson,DecidingPersonDuty,Proposer,	ProposerDuty	,
				EmployeeID	,DutyName	,WorkDate,	LeaveDate,	QuitJobID	,
				Allowance	,Notes	,CreateUserID,	CreateDate,
				LastModifyUserID,	LastModifyDate	,Subsidies,IsBreaking	,
				LeaveToDate,	Parameter01)

SELECT		T1.DivisionID,T1.DecidingNo,T1.S1,	T1.S2,DecidingDate,
			DecidingPerson,	T1.DecidingPersonDuty,Proposer,	T1.ProposerDuty,
			 T1.EmployeeID	,T1.DutyName,T1.WorkDate,	T1.LeaveDate,	T1.QuitJobID	,
			 T1.Allowance	,T1.Notes	,@UserID,GETDATE()	,@UserID,GETDATE(),T1.Subsidies,
			  T1.IsBreaking	,T1.LeaveToDate,	T1.Parameter01
FROM	#Data T1

DECLARE @cur cursor,
		@EmployeeID NVARCHAR(50),
		@EmployeeStatus TINYINT,
		@IsBreaking TINYINT
SET @cur = CURSOR SCROLL KEYSET FOR
	SELECT DISTINCT EmployeeID, ISNULL(IsBreaking,0) AS IsBreaking FROM #Data
OPEN @cur
FETCH NEXT FROM @cur INTO @EmployeeID, @IsBreaking 
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Cập nhật ngày hiệu lực của hồ sơ lương
	EXEC HP0004 @DivisionID, @UserID, @EmployeeID

	IF(@IsBreaking = 0)
		SET @EmployeeStatus = 9
	ELSE
		SET @EmployeeStatus = 3

	UPDATE HT1400 SET EmployeeStatus = @EmployeeStatus WHERE DivisionID IN (@DivisionID,'@@@') AND EmployeeID = @EmployeeID

	FETCH NEXT FROM @cur INTO @EmployeeID, @IsBreaking 
END
CLOSE @cur


LB_RESULT:

SELECT *  FROM  #Data T1

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

