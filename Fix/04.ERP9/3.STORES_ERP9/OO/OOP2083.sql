IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2083]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2083]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In đơn xin OT
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 10/08/2016
---- Modified by Bảo Thy on 06/09/2016: Lấy Khối, Phòng từ danh mục phòng ban, tổ nhóm
---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
/*-- <Example>
	OOP2083 'MK', 'AsoftAdmin','8A66F19A-8A79-4FCD-8C0F-004352CDEFD5'',''72C237C4-C371-4E59-ADB1-0046953A62F5'',''6572CC3F-419B-4B35-B466-00E0A2A967C4',
	1,null,null,null,null,null,null,0,null,null,1,null,null
	select * from oot9000 where type = 'dxltg'	
----*/
CREATE PROCEDURE OOP2083
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@APKMasterList NVARCHAR(4000),  ---APK của OOT9000
	@IsSearch TINYINT,
	@ID VARCHAR(50),
	@DepartmentID VARCHAR(50),
	@CreateUserID VARCHAR(50),
	@SectionID VARCHAR(50),
	@SubsectionID VARCHAR(50),
	@ProcessID VARCHAR(50),
	@IsCheckALL TINYINT,
	@WorkFromDate DATETIME,
	@WorkToDate DATETIME,
	@Status VARCHAR(10),
	@CreateFromDate DATETIME,
	@CreateToDate DATETIME
)
AS 
DECLARE @Cur CURSOR,
		@APKMaster VARCHAR(50),
		@sSQL NVARCHAR (MAX) = '',
		@sSQL1 NVARCHAR (MAX) = '',
		@sSQL2 NVARCHAR (MAX) = '',
		@sSQL3 NVARCHAR (MAX) = '',
        @sWhere NVARCHAR(MAX) = '',
        @sWhere1 NVARCHAR(MAX) = '',
		@Level INT,
		@TranMonth INT,
		@TranYear INT,
		@sSQLSL NVARCHAR (MAX) = '',
		@sSQLJon NVARCHAR (MAX) = '',
		@LanguageID VARCHAR(50),
		@sSQLLanguage VARCHAR(100)='',
		@TotalEmployee INT 

IF @IsCheckALL=0 
BEGIN
	SET @sWhere1='AND OOT90.APK IN ('''+@APKMasterList+''')'
END

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
	IF @CreateFromDate IS NOT NULL AND  @CreateToDate IS NOT NULL SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,OOT90.CreateDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@CreateFromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@CreateToDate,126)+''' '
	IF (@WorkFromDate IS NOT NULL AND @WorkToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,OOT20.WorkFromDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@WorkFromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@WorkToDate,126)+'''
	AND CONVERT(VARCHAR(10), CONVERT(DATE,OOT20.WorkToDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@WorkFromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@WorkToDate,126)+''' '
END


SELECT TOP 1 @LanguageID=LanguageID FROM AT14051 WHERE UserID=@UserID
IF @LanguageID='vi-VN'
SET @sSQLLanguage='O99.Description'
ELSE SET @sSQLLanguage='O99.DescriptionE'

SET @sSQL2 = 'SELECT OOT90.APK FROM OOT9000 OOT90
			WHERE OOT90.[Type] = ''DXLTG''
			--AND OOT90.[Status] = 1
			'+@sWhere+' 
			'+@sWhere1+' '
	
CREATE TABLE #APK (APK VARCHAR(50))
INSERT INTO #APK
EXEC (@sSQL2)

--SET @sSQL3 = 'SELECT OOT90.APK, OOT2010.EmployeeID FROM OOT9000 OOT90
--			LEFT JOIN OOT2010 on OOT90.APK = OOT2010.APKMaster
--			WHERE OOT90.[Type] = ''DXLTG''
--			'+@sWhere+' 
--			'+@sWhere1+' '
--CREATE TABLE #APK1 (APK VARCHAR(50), EmployeeID VARCHAR(50))
--INSERT INTO #APK1
--EXEC (@sSQL3)			

--SELECT ID FROM OOT9000 WHERE APK IN (SELECT APK FROM #APK1) AND ISNULL(OOT9000.Status,0) <> 1


SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT * FROM #APK

OPEN @Cur
FETCH NEXT FROM @Cur INTO @APKMaster
WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @TotalEmployee = COUNT(EmployeeID) FROM OOT2030 WHERE APKMaster = @APKMaster
	SELECT @TranMonth = TranMonth, @TranYear = TranYear FROM OOT9000 WHERE APK = @APKMaster
	
	SET @Level=ISNULL((SELECT TOP 1 LEVEL FROM OOT0010 WHERE DivisionID=@DivisionID AND AbsentType ='DXP'AND TranMonth=@TranMonth AND TranYear=@TranYear),0)
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
							OOT1.Status ApprovePerson'+@s+'Status, '+@sSQLLanguage+' ApprovePerson'+@s+'StatusName 
							FROM OOT9001 OOT1
							INNER JOIN HT1400 HT14 ON HT14.DivisionID=OOT1.DivisionID AND HT14.EmployeeID=OOT1.ApprovePersonID
							LEFT JOIN OOT0099 O99 ON O99.ID1=ISNULL(OOT1.Status,0) AND O99.CodeMaster=''Status''
							WHERE OOT1.Level='+STR(@i)+'
							)T'+@s+' ON T'+@s+'.DivisionID= OOT20.DivisionID  AND T'+@s+'.APKMaster=OOT20.APKMaster'
			SET @i = @i + 1		
		END	
	
	SET @sSQL =' 
		SELECT ROW_NUMBER() OVER (ORDER BY OOT20.EmployeeID) AS RowNum, OOT20.DivisionID, OOT20.APK,OOT20.APKMaster,'+STR(@Level)+' AS [Level],OOT20.EmployeeID, Ltrim(RTrim(isnull(HT14.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT14.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT14.FirstName,''''))) As EmployeeName, 
		HT14.DepartmentID, A11.DepartmentName, HT14.TeamID,  A12.TeamName, HT14.Ana04ID AS SubsectionID,  A13.AnaName AS SubsectionName, HT14.Ana05ID AS ProcessID,  A14.AnaName AS ProcessName,
		OOT90.WorkType, OOT20.Reason, OOT90.CreateDate, OOT20.WorkFromDate AS WorkingDate,
		CONVERT(VARCHAR(50),CONVERT(TIME(0),OOT20.WorkFromDate,0),108) +'' -- ''+ CONVERT(VARCHAR(50),CONVERT(TIME(0),OOT20.WorkToDate,0),120) AS WorkingTime,
		'+STR(@TotalEmployee)+' AS TotalEmployee
		'+@sSQLSL+'
		FROM OOT2030 OOT20 WITH (NOLOCK)
		LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON OOT90.DivisionID = OOT20.DivisionID AND OOT90.APK = OOT20.APKMaster
		LEFT JOIN HT1400 HT14 WITH (NOLOCK) ON HT14.DivisionID = OOT20.DivisionID AND HT14.EmployeeID = OOT20.EmployeeID 
		LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID=OOT90.DepartmentID 
		LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A12.DivisionID = OOT20.DivisionID AND A12.TeamID=OOT90.SectionID
		LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A13.AnaID=HT14.Ana04ID AND A13.AnaTypeID=''A04''
		LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A14.AnaID=HT14.Ana05ID AND A14.AnaTypeID=''A05''
		'
	SET @sSQL1=' '+@sSQLJon+'
		WHERE OOT20.DivisionID = '''+@DivisionID+'''
		AND OOT20.APKMaster = '''+@APKMaster+'''
		--AND EXISTS (SELECT TOP 1 1 FROM OOT9000 WHERE APK ='''+@APKMaster+''' AND OOT9000.[Status] = 1) 
		--AND OOT20.[Status] = 1
 
		ORDER BY OOT20.EmployeeID
			'
	--PRINT (@sSQL)
	--PRINT (@sSQL1)
	
	EXEC (@sSQL+@sSQL1)
	
	SET @sSQLSL = ''
	SET @sSQLJon = ''
	
FETCH NEXT FROM @Cur INTO @APKMaster
END 
Close @Cur 


	
DROP TABLE #APK

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
