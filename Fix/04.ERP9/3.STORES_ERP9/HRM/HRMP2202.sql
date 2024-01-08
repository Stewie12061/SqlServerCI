IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2202]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HRMP2202]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Update: Đổ dữ liệu vào màn hình cập nhật Kết quả thử việc (HRMF2201)
---Tham khảo HRMP2202
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phương Thảo, Date: 18/10/2023
-- <Example>
---- 
/*-- <Example>
	EXEC HRMP2202 @DivisionID='AS',@UserID='ASOFTADMIN',@APK='TR0001'
----*/

CREATE PROCEDURE [HRMP2202] 
( 
	@DivisionID NVARCHAR(50),
	@APK NVARCHAR(50),
	@Type VARCHAR(50) = '',
	@sSQLSL NVARCHAR (MAX) = '',
	@sSQLJon NVARCHAR (MAX) = ''
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
        @Level INT,
		    @i INT = 1, @s VARCHAR(2)
IF ISNULL(@Type, '') = 'KQTV' 
BEGIN
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) WHERE APKMaster = @APK
END
ELSE
BEGIN
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) LEFT JOIN HT0534  ON OOT9001.APKMaster = HT0534.APK  WHERE HT0534.APK = @APK 
END
WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSL=@sSQLSL+' , APP'+@s+'.ApprovePerson'+@s+'ID, APP'+@s+'.ApprovePerson'+@s+'Name, APP'+@s+'.ApprovePerson'+@s+'Status, APP'+@s+'.ApprovePerson'+@s+'StatusName, APP'+@s+'.ApprovePerson'+@s+'Note'
		SET @sSQLJon =@sSQLJon+ '
						LEFT JOIN (SELECT ApprovePersonID ApprovePerson'+@s+'ID,OOT1.APKMaster,OOT1.DivisionID,OOT1.Status,
						HT14.FullName As ApprovePerson'+@s+'Name, 
						OOT1.Status ApprovePerson'+@s+'Status, O99.Description ApprovePerson'+@s+'StatusName,
						OOT1.Note ApprovePerson'+@s+'Note
						FROM OOT9001 OOT1 WITH (NOLOCK)
						INNER JOIN AT1103 HT14 WITH (NOLOCK) ON (HT14.DivisionID=OOT1.DivisionID OR ISNULL(HT14.DivisionID,'''') = ''@@@'') AND HT14.EmployeeID=OOT1.ApprovePersonID
						LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(OOT1.Status,0) AND O99.CodeMaster=''Status''
						WHERE OOT1.Level='+STR(@i)+'
						)APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK'
		SET @i = @i + 1		
	END	
SET @sSQL = '
		SELECT
		HT34.APK
		, HT34.DivisionID
    , HT34.ResultNo
		, HT34.ResultDate
		, HT34.ContractNo
		, HT34.EmployeeID
		, AT03.FullName AS EmployeeName
		, HT34.TestFromDate
		, HT34.TestToDate
		, HT34.ResultID
		, HT34.IsStopBeforeEndDate 
		, HT34.EndDate
		, HT34.ReviewPerson
		, HT34.DecidePerson
		, AT031.FullName AS ReviewPersonName---Người đánh giá
		, AT032.FullName AS DecidePersonName---Người duyệt 01
		, HT34.Notes
		, HT34.Status
		, OOT91.Note AS ApprovalNotes
		'+@sSQLSL+'
		,HT34.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT34.CreateUserID) CreateUserID
		,HT34.CreateDate
		,HT34.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT34.LastModifyUserID) LastModifyUserID
		,HT34.LastModifyDate
    FROM HT0534 HT34 WITH (NOLOCK)
		LEFT JOIN AT1103 AT03 WITH (NOLOCK) ON AT03.DivisionID = HT34.DivisionID AND AT03.EmployeeID = HT34.EmployeeID
		LEFT JOIN AT1103 AT031 WITH (NOLOCK) ON AT031.DivisionID IN ( HT34.DivisionID, ''@@@'') AND AT031.EmployeeID = HT34.ReviewPerson
		LEFT JOIN AT1103 AT032 WITH (NOLOCK) ON AT032.DivisionID IN ( HT34.DivisionID, ''@@@'') AND AT032.EmployeeID = HT34.DecidePerson
		LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON HT34.APK = OOT90.APK
		LEFT JOIN OOT9001 OOT91 WITH (NOLOCK) ON OOT91.DivisionID  IN ( HT34.DivisionID, ''@@@'') AND OOT91.APKMaster = OOT90.APK
		'+@sSQLJon+'
    WHERE HT34.DivisionID = '''+@DivisionID+'''
          AND HT34.APK = '''+@APK+''''


PRINT @sSQL			
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

