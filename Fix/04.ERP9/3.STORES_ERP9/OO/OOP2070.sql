IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2070]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2070]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form OOF2070: Đơn xin đổi ca
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified by Bảo Thy on 06/09/2016: Lấy Khối, Phòng từ danh mục phòng ban, tổ nhóm
----Created by: Bảo Thy, Date: 23/02/2016
---- Modified by Bảo Anh on 04/01/2019: không lấy các cột người duyệt, trạng thái duyệt, SectionID, SubsectionID, ProcessID
---- Modified on 04/10/2019 by Bảo Toàn: Cập nhật phân quyền
---- Modified on 21/05/2020 by Bảo Toàn: Thiết lặp mặc địch giá trị @LanguageID
/*-- <Example>
	OOP2070 @DivisionID='MK',@UserID='000090',@PageNumber=1,@PageSize=25,@IsSearch=1, @TranMonth=8, @TranYear=2016,
	@ID=NULL,@DepartmentID=NULL,@SectionID=NULL, @SubsectionID=NULL,@ProcessID=NULL,@CreateUserID='000090',
	@ChangeFromDate=NULL,@ChangeToDate=NULL,@Status=NULL,@CreateFromDate='2016-06-11',@CreateToDate='2016-06-11'
----*/

CREATE PROCEDURE OOP2070
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
	@CreateUserID VARCHAR(50),
	@SectionID VARCHAR(50),
	@SubsectionID VARCHAR(50),
	@ProcessID VARCHAR(50),
	@ChangeFromDate DATE,
	@ChangeToDate DATE,
	@Status NVARCHAR(250),
	@CreateFromDate DATETIME,
	@CreateToDate DATETIME,
	@LanguageID VARCHAR(50) = NULL,
	@ConditionShiftChangeID VARCHAR(MAX)
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
IF ISNULL(@LanguageID,'vi-VN' ) ='vi-VN'
 SET @sSQLLanguage='O99.Description'
ELSE SET @sSQLLanguage='O99.DescriptionE'

--SET @Level=ISNULL((SELECT TOP 1 LEVEL FROM OOT0010 WHERE DivisionID=@DivisionID AND AbsentType ='DXDC'AND TranMonth=@TranMonth AND TranYear=@TranYear),0)              
SET @OrderBy = 'CreateDate DESC'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
IF @IsSearch = 1
BEGIN
	IF @ID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.ID,'''') LIKE ''%'+@ID+'%'' '
	IF @DepartmentID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.DepartmentID,'''') LIKE '''+@DepartmentID+''' '
	IF @SectionID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.SectionID,'''') LIKE '''+@SectionID+''' '
	IF @CreateUserID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.CreateUserID,'''') LIKE ''%'+@CreateUserID+'%'' '
	IF @SubsectionID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.SubsectionID,'''') LIKE '''+@SubsectionID+''' '
	IF @ProcessID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.ProcessID,'''') LIKE '''+@ProcessID+''' '
	--IF @Status IS NOT NULL SET @sWhere = @sWhere + '
	--AND ISNULL(OOT90.Status,'''') LIKE ''%'+@Status+'%'' '
	IF @CreateFromDate IS NOT NULL SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,OOT90.CreateDate,120), 126) >= '''+CONVERT(VARCHAR(10),@CreateFromDate,126)+''' '
	IF @CreateToDate IS NOT NULL SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,OOT90.CreateDate,120), 126) <= '''+CONVERT(VARCHAR(10),@CreateToDate,126)+''' '
	IF (@ChangeFromDate IS NOT NULL AND @ChangeToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,OOT2070.ChangeFromDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@ChangeFromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ChangeToDate,126)+'''
	AND CONVERT(VARCHAR(10), CONVERT(DATE,OOT2070.ChangeToDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@ChangeFromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ChangeToDate,126)+''' '
	IF (@ChangeFromDate IS NOT NULL AND @ChangeToDate IS NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,OOT2070.ChangeFromDate,120), 126) >= '''+CONVERT(VARCHAR(10),@ChangeFromDate,126)+''' '
	IF (@ChangeFromDate IS NULL AND @ChangeToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,OOT2070.ChangeToDate,120), 126) =< '''+CONVERT(VARCHAR(10),@ChangeToDate,126)+''' '
END

IF Isnull(@ConditionShiftChangeID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OOT90.CreateUserID,'''') in (N'''+@ConditionShiftChangeID+''' )'


--DECLARE @i INT = 1, @s VARCHAR(2)
--	WHILE @i <= @Level
--	BEGIN
--		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
--		ELSE SET @s = CONVERT(VARCHAR, @i)
--		SET @sSQLSL=@sSQLSL+',ApprovePerson'+@s+'ID,ApprovePerson'+@s+'Name,ApprovePerson'+@s+'Status, ApprovePerson'+@s+'StatusName'
--		SET @sSQLJon =@sSQLJon+ '
--						LEFT JOIN (SELECT ApprovePersonID ApprovePerson'+@s+'ID,OOT1.APKMaster,OOT1.DivisionID,
--						Ltrim(RTrim(isnull(HT14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT14.MiddleName,''''))) 
--						+ '' '' + LTrim(RTrim(Isnull(HT14.FirstName,''''))) As ApprovePerson'+@s+'Name, 
--						OOT1.Status ApprovePerson'+@s+'Status, '+@sSQLLanguage+' ApprovePerson'+@s+'StatusName 
--						FROM OOT9001 OOT1
--						INNER JOIN HT1400 HT14 ON HT14.DivisionID=OOT1.DivisionID AND HT14.EmployeeID=OOT1.ApprovePersonID
--						LEFT JOIN OOT0099 O99 ON O99.ID1=ISNULL(OOT1.Status,0) AND O99.CodeMaster=''Status''
--						WHERE OOT1.Level='+STR(@i)+'
--						)APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK'
--		SET @i = @i + 1		
	--END	

SET @sSQL =' 
	SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, A.*,' +@sSQLLanguage+' StatusName
	FROM
	(
		SELECT OOT90.APK, OOT90.DivisionID, OOT90.TranMonth, OOT90.TranYear, OOT90.ID,
		       OOT90.[Description], OOT90.DepartmentID, A11.DepartmentName, OOT90.SectionID, A12.TeamName SectionName,
		       OOT90.SubsectionID, A13.AnaName SubsectionName, OOT90.ProcessID, A14.AnaName ProcessName, MIN(OOT2070.Status) AS Status,
			   OOT90.CreateUserID , AT1405.UserName AS CreateUserName, OOT90.CreateDate,
		       OOT90.LastModifyUserID, OOT90.LastModifyDate
		       '+@sSQLSL+'
		FROM OOT9000 OOT90 WITH (NOLOCK)
		LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID=OOT90.DepartmentID 
		LEFT JOIN HT1101 A12 ON A12.DivisionID = OOT90.DivisionID AND A12.TeamID=OOT90.SectionID AND OOT90.DepartmentID = A12.DepartmentID
		LEFT JOIN AT1011 A13 ON A13.AnaID=OOT90.SubsectionID AND A13.AnaTypeID=''A04''
		LEFT JOIN AT1011 A14 ON A14.AnaID=OOT90.ProcessID AND A14.AnaTypeID=''A05''
		--LEFT JOIN OOT0099 O99 ON O99.ID1=ISNULL(OOT90.Status,0) AND O99.CodeMaster=''Status'' 
		LEFT JOIN AT1405 WITH (NOLOCK) ON OOT90.DivisionID=AT1405.DivisionID AND OOT90.CreateUserID=AT1405.UserID
		LEFT JOIN OOT2070 WITH (NOLOCK) ON OOT2070.DivisionID = OOT90.DivisionID AND OOT2070.APKMaster = OOT90.APK
		LEFT JOIN AT0010 WITH (NOLOCK) ON AT0010.DivisionID = OOT90.DivisionID AND AT0010.AdminUserID = '''+@UserID+''' AND AT0010.UserID = OOT90.CreateUserID '
SET @sSQL1='
		'+@sSQLJon+'
		WHERE OOT90.Type=''DXDC''
		AND (OOT90.CreateUserID = AT0010.UserID
		OR  OOT90.CreateUserID = '''+@UserID+''')
		'+@sWhere+'
		GROUP BY OOT90.APK, OOT90.DivisionID,OOT90.TranMonth, OOT90.TranYear, OOT90.ID,
		       OOT90.[Description], OOT90.DepartmentID, OOT90.SectionID,
		       OOT90.SubsectionID, OOT90.ProcessID, OOT90.CreateUserID, AT1405.UserName,OOT90.CreateDate,
			   OOT90.LastModifyUserID, OOT90.LastModifyDate,A11.DepartmentName, A12.TeamName,  A13.AnaName, A14.AnaName'

IF @IsSearch = 1 AND @Status IS NOT NULL
	SET @sSQL1=@sSQL1+'
	HAVING MIN(OOT2070.Status) LIKE ''%'+@Status+'%'' '

SET @sSQL1=@sSQL1+'
	)A
	LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(A.Status,0) AND O99.CodeMaster=''Status''
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
