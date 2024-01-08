IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8168]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP8168]
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
---- Create on 02/10/2019 by Khánh Đoan : Import Quyết bổ nhiệm




CREATE PROCEDURE [DBO].[AP8168]
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
	DutyID NVARCHAR(50),
	ImportMessage NVARCHAR(500) DEFAULT ('')
	--CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
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
		X.Data.query('DecideType').value('.', 'NVARCHAR(50)') AS DecideType,
		X.Data.query('Level').value('.', 'NVARCHAR(50)') AS Level,
		X.Data.query('NewDutyID').value('.', 'NVARCHAR(50)') AS NewDutyID,
		X.Data.query('NewLevel').value('.', 'NVARCHAR(50)') AS NewLevel,
		X.Data.query('EffectiveDate').value('.', 'DATETIME') AS EffectiveDate,
		X.Data.query('Description').value('.', 'NVARCHAR(250)') AS [Description]


INTO	#AP8168
FROM	@XML.nodes('//Data') AS X (Data)

INSERT INTO #Data (Row, DivisionID,Period,	DecideNo,DecidePerson,
				EmployeeID	,DecideType	,Level,NewDutyID,	NewLevel,EffectiveDate,[Description])

SELECT Row, DivisionID,Period,	DecideNo,DecidePerson,		EmployeeID	
			,DecideType,Level,NewDutyID,NewLevel,EffectiveDate,[Description]

FROM  #AP8168


---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

---- Cập nhật người quyết định	
UPDATE		DT
SET			DT.Proposer = @UserID

FROM		#Data DT


UPDATE		DT
SET			DT.DutyID = HV.DutyID

FROM		#Data DT
INNER JOIN	HV1400 HV WITH (NOLOCK)
	  ON HV.EmployeeID = DT.EmployeeID AND HV.DivisionID = @DivisionID
WHERE	HV.EmployeeStatus != 9
      And HV.EmployeeStatus != 0


UPDATE HT1403
      SET DutyID = DT.NewDutyID,
          TitleID = DT.NewDutyID

FROM  HT1403
LEFT JOIN #Data DT ON DT.EmployeeID = HT1403.EmployeeID
      WHERE HT1403.DivisionID = @DivisionID
      And HT1403.EmployeeID = DT.EmployeeID


Update T1
      SET T1.BaseSalary = T3.BaseSalary,
      T1.SalaryCoefficient = T2.SalaryCoefficient,
      T1.[C01] = T2.[C01], T1.[C02] = T2.[C02], T1.[C03] = T2.[C03],
      T1.[C04] = T2.[C04], T1.[C05] = T2.[C05], T1.[C06] = T2.[C06],
      T1.[C07] = T2.[C07], T1.[C08] = T2.[C08], T1.[C09] = T2.[C09], T1.[C10] = T2.[C10],
      T1.[C11] = T2.[C11], T1.[C12] = T2.[C12], T1.[C13] = T2.[C13],
      T1.[C14] = T2.[C14], T1.[C15] = T2.[C15], T1.[C16] = T2.[C16],
      T1.[C17] = T2.[C17], T1.[C18] = T2.[C18], T1.[C19] = T2.[C19], T1.[C20] = T2.[C20],
      T1.[C21] = T2.[C21], T1.[C22] = T2.[C22],
      T1.[C23] = T2.[C23], T1.[C24] = T2.[C24], T1.[C25] = T2.[C25]
      FROM HT1403 T1 
	  LEFT JOIN #Data DT ON DT.EmployeeID = T1.EmployeeID 
      INNER JOIN HT0048 T2 WITH(NOLOCK) ON T1.DivisionID = T2.DivisionID  AND T1.TitleID = T2.TitleID AND T1.SalaryLevel = T2.SalaryLevel
      INNER JOIN HT1106 T3 WITH(NOLOCK) ON T1.DivisionID = T2.DivisionID  AND T1.TitleID = T2.TitleID

      WHERE T1.DivisionID =  @DivisionID
      And T1.EmployeeID = DT.EmployeeID


-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT


INSERT INTO HT0362 (DivisionID	,DecideNo	,DecideDate,DecidePerson,	Proposer,
						EmployeeID	,DecideType	,	DutyID	,Level	,NewDutyID,
					NewLevel,	EffectiveDate,Notes	,CreateUserID,CreateDate,	LastModifyUserID	,LastModifyDate	)
SELECT	DISTINCT
		DT.DivisionID	,DT.DecideNo	,GETDATE()	,DT.DecidePerson,	
		DT.Proposer,	DT.EmployeeID,	DT.DecideType	,DT.DutyID	,DT.Level	,DT.NewDutyID,
		DT.NewLevel,DT.EffectiveDate,DT.[Description]	,@UserID,GETDATE(),	@UserID	,GETDATE()	

FROM #Data DT 

LB_RESULT:
SELECT *  FROM  #Data 

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
