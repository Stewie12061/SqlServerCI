IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form OOF2000: Bảng phân ca
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Quốc Tuấn, Date: 07/12/2015
---- Modified by Bảo Thy on 06/09/2016: Lấy Khối, Phòng từ danh mục phòng ban, tổ nhóm
---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
---- Modified by Bảo Anh on 04/01/2019: lấy trạng thái duyệt từ OOT2000 theo cải tiến mới
---- Modified on 04/10/2019 by Bảo Toàn: Cập nhật phân quyền
/*-- <Example>
	OOP2000 @DivisionID='MK',@UserID='000090',@TranMonth=8,@TranYear=2016,@PageNumber=1,@PageSize=25,@IsSearch=1,
	@ID=NULL,@Description=NULL,@CreateUserID=NULL,@DepartmentID=NULL,@SectionID=NULL,
	@SubsectionID=NULL,@ProcessID=NULL,@Status=NULL, @CreateFromDate = '2016-08-01', @CreateToDate = '2016-08-01'
	select * from oot9000 where type ='dxp' and createdate = '2016-08-01'
----*/

CREATE PROCEDURE OOP2000
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@PageNumber INT,
	@PageSize INT,
	@IsSearch TINYINT,
	@ID VARCHAR(50),
	@Description NVARCHAR(500),
	@CreateUserID VARCHAR(50),
	@DepartmentID VARCHAR(50),
	@SectionID VARCHAR(50),
	@SubsectionID VARCHAR(50),
	@ProcessID VARCHAR(50),
	@Status NVARCHAR(250),
	@CreateFromDate DATETIME,
	@CreateToDate DATETIME,
	@ConditionShiftID VARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = '',
		@sSQL1 NVARCHAR (MAX) = '',
        @sWhere NVARCHAR(MAX) = '',
        @sWhere1 NVARCHAR(2000) = '',
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50) = '',
		@Level INT,
		@sSQLSL NVARCHAR (MAX) = '',
		@sSQLJon NVARCHAR (MAX) = '',
		@s VARCHAR(2),
		@LanguageID VARCHAR(50),
		@sSQLLanguage VARCHAR(100)=''
		

SELECT TOP 1 @LanguageID=LanguageID FROM AT14051 WITH (NOLOCK) WHERE UserID=@UserID
IF @LanguageID='vi-VN' OR ISNULL(@sSQLLanguage,'') = ''
 SET @sSQLLanguage='O99.Description'
ELSE SET @sSQLLanguage='O99.DescriptionE'

SET @Level=ISNULL((SELECT TOP 1 LEVEL FROM OOT0010 WHERE DivisionID=@DivisionID AND AbsentType ='BPC' AND TranMonth=@TranMonth AND TranYear=@TranYear),0)
SET @OrderBy = 'CreateDate DESC'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
IF @IsSearch = 1
BEGIN
	IF @ID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.ID,'''') LIKE ''%'+@ID+'%'' '
	IF @Description IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.Description,'''') LIKE ''%'+@Description+'%'' '
	IF @CreateUserID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.CreateUserID,'''') LIKE ''%'+@CreateUserID+'%'' '
	IF @DepartmentID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.DepartmentID,'''') LIKE ''%'+@DepartmentID+'%'' '
	IF @SectionID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.SectionID,'''') LIKE ''%'+@SectionID+'%'' '
	IF @SubsectionID IS NOT NULL SET @sWhere = @sWhere1 + '
	AND ISNULL(OOT90.SubsectionID,'''') LIKE ''%'+@SubsectionID+'%'' '
	IF @ProcessID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.ProcessID,'''') LIKE ''%'+@ProcessID+'%'' '
	IF @Status IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(LTRIM(OOT90.Status),'''') LIKE ''%'+@Status+'%'' '
	IF @CreateFromDate IS NOT NULL SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,OOT90.CreateDate,120), 126) >= '''+CONVERT(VARCHAR(10),@CreateFromDate,126)+''' '
	IF @CreateToDate IS NOT NULL SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,OOT90.CreateDate,120), 126) <= '''+CONVERT(VARCHAR(10),@CreateToDate,126)+''' '
END

IF Isnull(@ConditionShiftID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OOT90.CreateUserID,'''') in (N'''+@ConditionShiftID+''' )'

DECLARE @i INT = 1
	WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSL=@sSQLSL+',APP'+@s+'.ApprovePerson'+@s+'ID,APP'+@s+'.ApprovePerson'+@s+'Name,APP'+@s+'.ApproveStatus'+@s+',APP'+@s+'.ApproveStatus'+@s+'Name'
		SET @sSQLJon =@sSQLJon+ '
		LEFT JOIN (SELECT ApprovePersonID ApprovePerson'+@s+'ID,OOT1.APKMaster,OOT1.DivisionID,
		OOT1.Status ApproveStatus'+@s+','+@sSQLLanguage+' ApproveStatus'+@s+'Name,
		Ltrim(RTrim(isnull(HT14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT14.MiddleName,''''))) 
		+ '' '' + LTrim(RTrim(Isnull(HT14.FirstName,''''))) As ApprovePerson'+@s+'Name
		FROM OOT9001 OOT1 WITH (NOLOCK)
		LEFT JOIN HT1400 HT14 WITH (NOLOCK) ON HT14.DivisionID=OOT1.DivisionID AND HT14.EmployeeID=OOT1.ApprovePersonID
		LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID=LTRIM(ISNULL(OOT1.Status,0)) AND O99.CodeMaster=''Status''
		WHERE OOT1.Level='+STR(@i)+'
		)APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK'
		SET @i = @i + 1		
	END	
	
IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @Level)
		ELSE SET @s = CONVERT(VARCHAR, @Level)
SET @sSQL ='
	SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
	FROM
	(
		SELECT OOT90.DivisionID,OOT90.APK, OOT90.TranMonth, OOT90.ID,
		       OOT90.[Description], OOT90.DepartmentID, OOT90.SectionID,
		       OOT90.SubsectionID, OOT90.ProcessID, OOT90.AppoveLevel,
		       OOT90.ApprovingLevel, OOT90.CreateUserID, AT1405.UserName AS CreateUserName,OOT90.CreateDate,
		       OOT90.LastModifyUserID, OOT90.LastModifyDate,A11.DepartmentName,
		       A12.TeamName SectionName,A13.AnaName SubsectionName,A14.AnaName ProcessName,'+@sSQLLanguage+' StatusName
		       '+@sSQLSL+'
		FROM OOT9000 OOT90 WITH (NOLOCK)
		LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID=OOT90.DepartmentID 
		LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A12.DivisionID = OOT90.DivisionID AND A12.TeamID=OOT90.SectionID AND OOT90.DepartmentID = A12.DepartmentID
		LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A13.AnaID=OOT90.SubsectionID AND A13.AnaTypeID=''A04''
		LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A14.AnaID=OOT90.ProcessID AND A14.AnaTypeID=''A05''
		LEFT JOIN OOT0099 O99 ON O99.ID=LTRIM(ISNULL(OOT90.Status,0)) AND O99.CodeMaster=''Status''
		LEFT JOIN AT1405 ON OOT90.DivisionID=AT1405.DivisionID AND OOT90.CreateUserID = AT1405.UserID
		LEFT JOIN AT0010 ON AT0010.DivisionID = OOT90.DivisionID AND AT0010.AdminUserID = '''+@UserID+''' AND AT0010.UserID = OOT90.CreateUserID '
SET @sSQL1=''+@sSQLJon+'
		WHERE OOT90.Type=''BPC''
		AND OOT90.DivisionID ='''+@DivisionID+'''
		AND OOT90.TranMonth ='+STR(@TranMonth)+' AND OOT90.TranYear ='+STR(@TranYear)+'
		AND (OOT90.CreateUserID = AT0010.UserID
		OR  OOT90.CreateUserID = '''+@UserID+''')
		'+@sWhere+'
	)A
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

PRINT(@sSQL+@sSQL1)
EXEC (@sSQL+@sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
