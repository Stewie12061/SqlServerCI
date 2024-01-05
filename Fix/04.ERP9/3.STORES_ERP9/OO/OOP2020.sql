IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2020]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form OOF2020: Đơn xin phép ra ngoài
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 09/12/2015
---- Modified by Bảo Thy on 06/09/2016: Lấy Khối, Phòng từ danh mục phòng ban, tổ nhóm
---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
---- Modified on 04/10/2019 by Bảo Toàn: Cập nhật phân quyền
---- Modified on 21/05/2020 by Bảo Toàn: Thiết lặp mặc địch giá trị @LanguageID
/*-- <Example>
	OOP2020 @DivisionID='MK',@UserID='000060',@PageNumber=1,@PageSize=25,@IsSearch=1, @TranMonth=8, @TranYear=2016,
	@ID=NULL,@DepartmentID=NULL,@SectionID=NULL, @SubsectionID=NULL,@ProcessID=NULL,
	@CreateUserID=NULL,@Status=NULL,@CreateFromDate=NULL,@CreateToDate=NULL,@GoFromDate ='2016-05-24',@GoToDate='2016-05-25'
----*/

CREATE PROCEDURE OOP2020
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@PageNumber INT,
	@PageSize INT,
	@IsSearch TINYINT,
	@TranMonth INT,
	@TranYear INT,
	@ID VARCHAR(50),
	@DepartmentID VARCHAR(50),
	@SectionID VARCHAR(50),
	@SubsectionID VARCHAR(50),
	@ProcessID VARCHAR(50),
	@Status NVARCHAR(250),
	@CreateUserID VARCHAR(50),
	@CreateFromDate DATETIME,
	@CreateToDate DATETIME,
	@GoFromDate DATETIME,
	@GoToDate DATETIME,
	@LanguageID VARCHAR(50) = NULL,
	@ConditionPermissionOutFormID VARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = '',
		@sSQL1 NVARCHAR (MAX) = '',
        @sWhere NVARCHAR(MAX) = '',
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50) = '',
		@Level INT,
		@sSQLSL NVARCHAR (MAX) = '',
		@sSQLJon NVARCHAR (MAX) = '',
		@sSQLLanguage VARCHAR(100)=''

--SELECT TOP 1 @LanguageID=LanguageID FROM AT14051 WHERE UserID=@UserID
IF ISNULL(@LanguageID,'vi-VN') ='vi-VN'
 SET @sSQLLanguage='O99.Description'
ELSE SET @sSQLLanguage='O99.DescriptionE'

SET @Level=ISNULL((SELECT TOP 1 LEVEL FROM OOT0010 WHERE DivisionID=@DivisionID AND AbsentType ='DXRN'AND TranMonth=@TranMonth AND TranYear=@TranYear),0)              
SET @OrderBy = ' CreateDate DESC'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
IF @IsSearch = 1
BEGIN
	IF @ID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.ID,'''') LIKE ''%'+@ID+'%'' '
	IF @DepartmentID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.DepartmentID,'''') LIKE ''%'+@DepartmentID+'%'' '
	IF @SectionID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.SectionID,'''') LIKE ''%'+@SectionID+'%'' '
	IF @SubsectionID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.SubsectionID,'''') LIKE ''%'+@SubsectionID+'%'' '
	IF @ProcessID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.ProcessID,'''') LIKE ''%'+@ProcessID+'%'' '
	IF @Status IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.Status,'''') LIKE ''%'+@Status+'%'' '
	IF @CreateUserID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.CreateUserID,'''') LIKE ''%'+@CreateUserID+'%'' '
	IF @CreateFromDate IS NOT NULL SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,OOT90.CreateDate,120), 126) >= '''+CONVERT(VARCHAR(10),@CreateFromDate,126)+''' '
	IF @CreateToDate IS NOT NULL SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,OOT90.CreateDate,120), 126) <= '''+CONVERT(VARCHAR(10),@CreateToDate,126)+''' '
	IF (@GoFromDate IS NOT NULL AND @GoToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,OOT2020.GoFromDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@GoFromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@GoToDate,126)+'''
	AND CONVERT(VARCHAR(10), CONVERT(DATE,OOT2020.GoToDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@GoFromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@GoToDate,126)+''' '
	IF (@GoFromDate IS NOT NULL AND @GoToDate IS NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,OOT2020.GoFromDate,120), 126) >= '''+CONVERT(VARCHAR(10),@GoFromDate,126)+''' '
	IF (@GoFromDate IS NULL AND @GoToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,OOT2020.GoToDate,120), 126) =< '''+CONVERT(VARCHAR(10),@GoToDate,126)+''' '
END

IF Isnull(@ConditionPermissionOutFormID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OOT90.CreateUserID,'''') in (N'''+@ConditionPermissionOutFormID+''' )'


DECLARE @i INT = 1, @s VARCHAR(2)
	WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSL=@sSQLSL+',ApprovePerson'+@s+'ID,ApprovePerson'+@s+'Name,ApprovePerson'+@s+'Status, ApprovePerson'+@s+'StatusName'
		SET @sSQLJon =@sSQLJon+ '
						LEFT JOIN (SELECT ApprovePersonID ApprovePerson'+@s+'ID,OOT1.APKMaster,OOT1.DivisionID,
						Ltrim(RTrim(isnull(HT14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT14.MiddleName,''''))) 
						+ '' '' + LTrim(RTrim(Isnull(HT14.FirstName,''''))) As ApprovePerson'+@s+'Name, 
						OOT1.Status ApprovePerson'+@s+'Status,'+@sSQLLanguage+' ApprovePerson'+@s+'StatusName 
						FROM OOT9001 OOT1
						INNER JOIN HT1400 HT14 ON HT14.DivisionID=OOT1.DivisionID AND HT14.EmployeeID=OOT1.ApprovePersonID
						LEFT JOIN OOT0099 O99 ON O99.ID1=ISNULL(OOT1.Status,0) AND O99.CodeMaster=''Status''
						WHERE OOT1.Level='+STR(@i)+'
						)APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK'
		SET @i = @i + 1		
	END	

SET @sSQL =' 
	SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
	FROM
	(
		SELECT DISTINCT OOT90.APK, OOT90.DivisionID,OOT90.TranMonth, OOT90.TranYear, OOT90.ID,
		       OOT90.[Description], OOT90.DepartmentID, OOT90.SectionID,
		       OOT90.SubsectionID, OOT90.ProcessID, OOT90.AppoveLevel,
		       OOT90.ApprovingLevel, '+@sSQLLanguage+' StatusName, OOT90.CreateUserID,AT1405.UserName AS CreateUserName, OOT90.CreateDate,
		       OOT90.LastModifyUserID, OOT90.LastModifyDate,A11.DepartmentName,
		       A12.TeamName SectionName,A13.AnaName SubsectionName,A14.AnaName ProcessName
		       '+@sSQLSL+'
		FROM OOT9000 OOT90
		LEFT JOIN OOT2020 ON OOT2020.DivisionID = OOT90.DivisionID AND OOT90.APK = OOT2020.APKMaster
		LEFT JOIN AT1102 A11 ON A11.DepartmentID=OOT90.DepartmentID 
		LEFT JOIN HT1101 A12 ON A12.DivisionID = OOT90.DivisionID AND A12.TeamID=OOT90.SectionID AND OOT90.DepartmentID = A12.DepartmentID
		LEFT JOIN AT1011 A13 ON A13.AnaID=OOT90.SubsectionID AND A13.AnaTypeID=''A04''
		LEFT JOIN AT1011 A14 ON A14.AnaID=OOT90.ProcessID AND A14.AnaTypeID=''A05''
		LEFT JOIN OOT0099 O99 ON O99.ID1=ISNULL(OOT90.Status,0) AND O99.CodeMaster=''Status'' 
		LEFT JOIN AT1405 ON OOT90.DivisionID=AT1405.DivisionID AND OOT90.CreateUserID=AT1405.UserID
		LEFT JOIN AT0010 ON AT0010.DivisionID = OOT90.DivisionID AND AT0010.AdminUserID = '''+@UserID+''' AND AT0010.UserID = OOT90.CreateUserID '
SET @sSQL1='
		'+@sSQLJon+'
		WHERE OOT90.DivisionID = '''+@DivisionID+'''
		AND OOT90.Type=''DXRN''
		AND (OOT90.CreateUserID = AT0010.UserID
		OR  OOT90.CreateUserID = '''+@UserID+''')
		'+@sWhere+'
	)A
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

EXEC (@sSQL+@sSQL1)
--PRINT (@sSQL)
--PRINT (@sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
