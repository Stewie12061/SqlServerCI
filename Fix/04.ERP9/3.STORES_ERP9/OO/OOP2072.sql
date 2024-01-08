IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2072]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2072]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load thông tin master Đơn xin đổi ca
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 23/02/2016
---- Modified by Bảo Thy on 06/09/2016: Lấy Khối, Phòng từ danh mục phòng ban, tổ nhóm
---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
---- Modified by Bảo Anh on 04/01/2018: Không trả ra thông tin xét duyệt vì lưu theo cấu trúc mới
-- <Example>
---- 
/*
  exec OOP2072 @DivisionID=N'MK',@UserID=N'ASOFTADMIN',@APKMaster=N'D43A77EC-FB49-4927-AF16-012C7BDB0F7E',@tranMonth=8,@TranYear=2016
*/
CREATE PROCEDURE OOP2072
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@APKMaster VARCHAR(50),
	@TranMonth INT,
	@TranYear INT
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@Level INT,
		@sSQLSL NVARCHAR (MAX) = '',
		@sSQLJon NVARCHAR (MAX) = '',
		@sSQL1 NVARCHAR (MAX) = '',
		@OrderBy NVARCHAR(500),
		@i INT = 1, @s VARCHAR(2),
		@LanguageID VARCHAR(50),
		@sSQLLanguage VARCHAR(100)=''

SELECT TOP 1 @LanguageID=LanguageID FROM AT14051 WHERE UserID=@UserID
IF @LanguageID='vi-VN'
 SET @sSQLLanguage='O99.Description'
ELSE SET @sSQLLanguage='O99.DescriptionE'
	
SET @OrderBy = ''
SET @Level = ISNULL((SELECT TOP 1 level FROM OOT0010 WHERE DivisionID = @DivisionID AND AbsentType = 'DXDC'AND TranMonth=@TranMonth AND TranYear=@TranYear), 0) 	
	WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSL=@sSQLSL+', ApprovePerson'+@s+'ID, ApprovePerson'+@s+'ID AS ApprovePerson'+@s+', ApprovePerson'+@s+'Name, ApprovePerson'+@s+'Status, ApprovePerson'+@s+'StatusName, ApprovePerson'+@s+'Note'
		SET @sSQLJon =@sSQLJon+ '
						LEFT JOIN (SELECT ApprovePersonID ApprovePerson'+@s+'ID,OOT1.APKMaster,OOT1.DivisionID,OOT1.Status,
						Ltrim(RTrim(isnull(HT14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT14.MiddleName,''''))) 
						+ '' '' + LTrim(RTrim(Isnull(HT14.FirstName,''''))) As ApprovePerson'+@s+'Name, 
						OOT1.Status ApprovePerson'+@s+'Status, O99.Description ApprovePerson'+@s+'StatusName,
						OOT1.Note ApprovePerson'+@s+'Note
						FROM OOT9001 OOT1
						INNER JOIN HT1400 HT14 ON HT14.DivisionID=OOT1.DivisionID AND HT14.EmployeeID=OOT1.ApprovePersonID
						LEFT JOIN OOT0099 O99 ON O99.ID1=ISNULL(OOT1.Status,0) AND O99.CodeMaster=''Status''
						WHERE OOT1.Level='+STR(@i)+'
						)APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK'
		SET @i = @i + 1		
	END	

SET @sSQL ='SELECT OOT90.APK, OOT90.DivisionID, A051.UserName CreateUserName, OOT90.TranMonth, OOT90.TranYear, OOT90.ID, OOT90.[Description],
			OOT90.DepartmentID, OOT90.SectionID, OOT90.SubsectionID, OOT90.ProcessID, OOT90.AppoveLevel, StatusName=NULL,
			A11.DepartmentName, A12.TeamName SectionName, A13.AnaName SubsectionName, A14.AnaName ProcessName,
			OOT90.CreateUserID +'' - ''+ A051.UserName CreateUserID, OOT90.CreateDate, 
			OOT90.LastModifyUserID +'' - ''+ A052.UserName LastModifyUserID, OOT90.LastModifyDate, MONTH(OOT27.ChangeFromDate) MonthDate
			'+@sSQLSL+'
        FROM OOT9000 OOT90 WITH (NOLOCK)
			INNER JOIN OOT2070 OOT27 WITH (NOLOCK) ON OOT27.DivisionID = OOT90.DivisionID AND OOT27.APKMaster = OOT90.APK
			LEFT JOIN AT1405 WITH (NOLOCK) ON AT1405.DivisionID = OOT90.DivisionID AND AT1405.UserID=OOT90.CreateUserID
			LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID=OOT90.DepartmentID 
			LEFT JOIN HT1101 A12 ON A12.DivisionID = OOT90.DivisionID AND A12.TeamID=OOT90.SectionID AND OOT90.DepartmentID = A12.DepartmentID
			LEFT JOIN AT1011 A13 ON A13.AnaID=OOT90.SubsectionID AND A13.AnaTypeID=''A04''
			LEFT JOIN AT1011 A14 ON A14.AnaID=OOT90.ProcessID AND A14.AnaTypeID=''A05''
			--LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(OOT90.Status,0) AND O99.CodeMaster=''Status''
			LEFT JOIN AT1405 A051 WITH (NOLOCK) ON A051.UserID = OOT90.CreateUserID
			LEFT JOIN AT1405 A052 WITH (NOLOCK) ON A052.UserID = OOT90.LastModifyUserID '
	
SET @sSQL1=''+@sSQLJon+'
	WHERE OOT90.Type=''DXDC''
		--AND OOT90.TranMonth = '+STR(@TranMonth)+'
		--AND OOT90.TranYear = '+STR(@TranYear)+'
		AND OOT90.DivisionID = '''+@DivisionID+'''
		AND OOT90.APK = '''+@APKMaster+'''
	'
	
	
EXEC (@sSQL+@sSQL1)
--PRINT(@sSQL)
--PRINT(@sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
