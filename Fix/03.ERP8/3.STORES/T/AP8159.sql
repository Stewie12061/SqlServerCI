IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8159]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP8159]
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
---- Create on 24/11/2022 by Nhựt Trường : Import Quyết định thuyên chuyển
---- Update on 10/07/2023 by Kiều Nga : Bổ sung cập nhật bảng HT2400, HT2401, HT1400


CREATE PROCEDURE [DBO].[AP8159]
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
	Proposer NVARCHAR(50),
	DepartmentIDOld NVARCHAR(50),
	TeamIDOld NVARCHAR(50),
	SectionIDOld NVARCHAR(50),
	ProcessIDOld NVARCHAR(50),
	DutyIDOld  NVARCHAR(50),
	HistoryID NVARCHAR(50),
	ImportMessage NVARCHAR(500) DEFAULT ('')
	--CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
)

CREATE TABLE #Keys
(
	Row INT ,	
	HistoryID NVARCHAR(50)
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
		X.Data.query('DecideNo').value('.', 'NVARCHAR(50)') AS DecideNo,
		X.Data.query('DecidePerson').value('.', 'NVARCHAR(50)') AS DecidePerson,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
		X.Data.query('DepartmentID').value('.', 'NVARCHAR(50)') AS DepartmentID,
		X.Data.query('TeamID').value('.', 'NVARCHAR(50)') AS TeamID,
		X.Data.query('SectionID').value('.', 'NVARCHAR(50)') AS SectionID,
		X.Data.query('ProcessID').value('.', 'NVARCHAR(50)') AS ProcessID,
		X.Data.query('DutyID').value('.', 'NVARCHAR(50)') AS DutyID,
		X.Data.query('FromDate').value('.', 'DATETIME') AS FromDate,
		X.Data.query('ToDate').value('.', 'DATETIME') AS ToDate,
		X.Data.query('Notes').value('.', 'NVARCHAR(250)') AS Notes

INTO	#AP8159
FROM	@XML.nodes('//Data') AS X (Data)

INSERT INTO #Data (Row, DivisionID,	Period,DecideNo,DecidePerson,EmployeeID,
					DepartmentID,TeamID,SectionID,ProcessID,DutyID	,FromDate	,ToDate,Notes)

		

SELECT Row, DivisionID,	Period,DecideNo,DecidePerson,EmployeeID,
					DepartmentID,TeamID,SectionID,ProcessID,DutyID	,FromDate	,ToDate,Notes
FROM  #AP8159

---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID


-- Sinh khóa

DECLARE @cKey AS CURSOR
DECLARE
		@Row AS INT,
		@KEYSTRING AS INT,
		@LastKey AS  INT,
		@substr AS VARCHAR(50)

SET @cKey = CURSOR SCROLL KEYSET FOR
	SELECT	Row,HistoryID
	FROM	#Data
		
OPEN @cKey
FETCH NEXT FROM @cKey INTO @Row,  @substr
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @KEYSTRING = (SELECT LTRIM(FORMAT(GETDATE(),'yyyy')))
	SET @LastKey = (SELECT LastKey from AT4444 where TABLENAME = 'HT1302_MK' AND KEYSTRING =(SELECT 'HS'+ CAST(LTRIM((@KEYSTRING))AS VARCHAR)))
	SET @substr= (SELECT(CONCAT(LEFT('0000000000',10-LEN(LTRIM(cast(@LastKey  as INT))))+LTRIM(cast(@LastKey as INT)),(SELECT CAST(('HS'+ LTRIM(@KEYSTRING)) AS NVARCHAR)))))
	UPDATE AT4444 SET LASTKEY = @lastkey   WHERE DivisionID=@DivisionID and  TABLENAME = 'HT1302_MK' AND KEYSTRING = (SELECT CAST(('HS'+ LTRIM(@KEYSTRING)) AS NVARCHAR))

	INSERT INTO #Keys(Row,HistoryID)
	VALUES (@Row, @substr)				
	FETCH NEXT FROM @cKey INTO @Row,  @substr
END
CLOSE @cKey

 --Cập nhật khóa
UPDATE		DT
SET			DT.HistoryID = K.HistoryID 
		
FROM		#Data DT
INNER JOIN	#Keys K
		ON	K.Row = DT.Row
		

---- Cập nhật người quyết định	
UPDATE		DT
SET			DT.Proposer = @UserID

FROM		#Data DT



UPDATE		DT
SET			DepartmentIDOld = HV.DepartmentID,
			TeamIDOld		= HV.TeamID,
			SectionIDOld	= HV.Ana04ID,
			ProcessIDOld	= HV.Ana05ID,
			DutyIDOld		= HV.DutyID

FROM		#Data DT
INNER JOIN	HV1400 HV WITH (NOLOCK)
		ON	HV.EmployeeID = DT.EmployeeID
	
LEFT JOIN AT1011 AT1 WITH(NOLOCK) 
		ON 
AT1.DivisionID = HV.DivisionID AND AT1.AnaID=HV.Ana04ID AND AT1.AnaTypeID='A04'
LEFT JOIN AT1011 AT2 WITH(NOLOCK) 
		ON AT2.DivisionID = HV.DivisionID AND AT2.AnaID=HV.Ana05ID AND AT2.AnaTypeID='A05'

-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
GOTO LB_RESULT


INSERT INTO	HT1302_MK(
				DivisionID,HistoryID,
				DecideNo,DecideDate,DecidePerson,Proposer,EmployeeID,
					DepartmentIDOld,TeamIDOld,SectionIDOld,ProcessIDOld,DutyIDOld	,
					DepartmentID,TeamID,SectionID,ProcessID,DutyID	,FromDate	,ToDate,Notes
					,CreateUserID,CreateDate,	LastModifyUserID,LastModifyDate	)

SELECT DISTINCT 	DT.DivisionID,DT.HistoryID,
					DT.DecideNo,GETDATE(),DT.DecidePerson,DT.Proposer,DT.EmployeeID,
					DT.DepartmentIDOld,DT.TeamIDOld,DT.SectionIDOld,DT.ProcessIDOld,DT.DutyIDOld,
					DT.DepartmentID,DT.TeamID,DT.SectionID,ProcessID,DT.DutyID	,DT.FromDate,DT.ToDate,DT.Notes,
					@UserID, GETDATE(),	@UserID, GETDATE()



FROM #Data DT

--- Cập nhật bảng HT2400 (hồ sơ lương)
UPDATE HT2400
SET DepartmentID = DT.DepartmentID,
TeamID = DT.TeamID,
Ana02ID = DT.DepartmentID,
Ana03ID = DT.TeamID,
Ana04ID = DT.SectionID,
Ana05ID = DT.ProcessID,
DutyID = DT.DutyID
FROM		HT2400 HT
INNER JOIN	#Data DT WITH (NOLOCK) ON HT.DivisionID = DT.DivisionID 
AND HT.EmployeeID = DT.EmployeeID
AND (TranMonth + TranYear * 100 between  MONTH(DT.FromDate)+ YEAR(DT.FromDate)*100 and MONTH(DT.ToDate)+ YEAR(DT.ToDate)*100)

--- Cập nhật bảng HT2401
UPDATE HT2401
SET DepartmentID = DT.DepartmentID,
TeamID = DT.TeamID
FROM		HT2401 HT
INNER JOIN	#Data DT WITH (NOLOCK) ON HT.DivisionID = DT.DivisionID 
AND HT.EmployeeID = DT.EmployeeID
AND (TranMonth + TranYear * 100 between  MONTH(DT.FromDate)+ YEAR(DT.FromDate)*100 and MONTH(DT.ToDate)+ YEAR(DT.ToDate)*100)

--- Cập nhật dữ liệu phòng ban, chức vụ (HT1400 hs nhân viên) 
DECLARE @CurHP0005 CURSOR,
		@DivisionIDHP0005 VARCHAR(50),
		@UserIDHP0005 VARCHAR(50),
		@DecideNo Varchar(50) = ''

SET @CurHP0005 = CURSOR SCROLL KEYSET FOR
SELECT DISTINCT DT.DivisionID,@UserID,DT.DecideNo FROM #Data DT 
OPEN @CurHP0005
FETCH NEXT FROM @CurHP0005 INTO @DivisionIDHP0005, @UserIDHP0005,@DecideNo
WHILE @@FETCH_STATUS = 0
BEGIN	
	EXEC HP0005 @DivisionID=@DivisionIDHP0005,@UserID=@UserIDHP0005,@DecideNo=@DecideNo

	FETCH NEXT FROM @CurHP0005 INTO @DivisionIDHP0005, @UserIDHP0005,@DecideNo
END	
CLOSE @CurHP0005


LB_RESULT:
 SELECT *  FROM  #Data 

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
