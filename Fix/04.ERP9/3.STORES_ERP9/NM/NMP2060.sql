IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2060]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2060]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
--- Load Grid danh sách ho so suc khoe
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Trà Giang
----Create date: 22/09/2018
--- Modify 
/*
--Lọc thường
EXEC NMP2060 'BS',null,1,25,1,'2018-06-29','2018-09-29', '06/2018'',''09/2018','HSSK/09/2018/001','', '',NULL
--Lọc nâng cao
EXEC NMP2060 'BS',null,1,25,1,'2018-06-29','2018-09-29', '06/2018'',''09/2018','HSSK/09/2018/001','','',N' where IsNull(VoucherNo,'''') = N''asdas'''

*/
 CREATE PROCEDURE NMP2060
(
 	 @DivisionID VARCHAR(50),
     @DivisionIDList NVARCHAR(2000),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
     @FromDate DATETIME,
     @ToDate DATETIME,
     @VoucherNo NVARCHAR(50),
	 @GradeLevelID NVARCHAR(50),
	 @ClassID NVARCHAR(50),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
	 
)
AS
DECLARE @sSQL01 NVARCHAR (MAX),
		@sSQL02 NVARCHAR (MAX),
		@sSQL03 NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50) = N''

		IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
      	SET @sWhere = ' 1 = 1 '
		SET @OrderBy = ' N.VoucherDate Desc, N.VoucherNo'
	If Isnull(@SearchWhere, '') = '' --Lọc thường
		Begin
	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != '' 
		SET @sWhere = @sWhere + 'AND N.DivisionID IN ('''+@DivisionIDList+''')'
	Else 
		SET @sWhere = @sWhere + 'AND N.DivisionID IN ('''+@DivisionID+''')'

	IF Isnull(@VoucherNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(N.VoucherNo,'''') LIKE N''%'+@VoucherNo+'%'' '
	
	IF Isnull(@GradeLevelID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(N.GradeLevelID,'''') LIKE N''%'+@GradeLevelID+'%'' '
			IF Isnull(@ClassID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(N.ClassID,'''') LIKE N''%'+@ClassID+'%'' '
	
	
	
  IF Isnull(@FromDate, '') != '' AND Isnull(@ToDate, '') != ''
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10),N.VoucherDate,112) BETWEEN '+CONVERT(VARCHAR(10),@FromDate,112)+' AND '+CONVERT(VARCHAR(10),@ToDate,112)+' '
	--IF @IsDate = 0 
	--	SET @sWhere = @sWhere + ' AND (Case When  N.TranMonth <10 then ''0''+rtrim(ltrim(str(N.TranMonth)))+''/''+ltrim(Rtrim(str(N.TranYear))) 
	--								Else rtrim(ltrim(str(N.TranMonth)))+''/''+ltrim(Rtrim(str(N.TranYear))) End) IN ('''+@PeriodIDList+''')'
		--nếu giá trị NULL thì set về rổng 
				SET @SearchWhere = Isnull(@SearchWhere, '')
	End
			SET @sSQL01 = '
			SELECT N.APK, N.DivisionID, N.VoucherNo, N.VoucherDate,
			N.SchoolYearID, 
			N.GradeID , N.ClassID,
			T1.GradeName , T2.ClassName,
			N.CreateUserID, N.CreateDate, N.LastModifyUserID, N.LastModifyDate,
			N.DeleteFlg,N.TranMonth,N.TranYear
			INTO #NMP2060
			FROM NMT2060 N WITH (NOLOCK)
			LEFT JOIN EDMT1000 T1 WITH (NOLOCK) ON N.GradeID = T1.GradeID
			LEFT JOIN EDMT1020 T2 WITH (NOLOCK) ON N.ClassID = T2.ClassID

			WHERE ' +@sWhere + 'AND N.DeleteFlg = 0 
			
			Select  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow	
			,APK,DivisionID,VoucherNo,VoucherDate,
			SchoolYearID, GradeName AS GradeID , ClassName AS ClassID,
			CreateUserID,CreateDate,LastModifyUserID,LastModifyDate,
			DeleteFlg,TranMonth,TranYear		
			FROM #NMP2060 AS N
			'+@SearchWhere +'
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

								 

EXEC (@sSQL01)
--print @sSQL01






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
