IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load Grid danh sách thực đơn tổng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Trà Giang
----Create date: 07/09/2018
--- Modify 
/*
----Lọc thường
EXEC NMP2000 'BS',null,1,25,0,'2018-06-29','2018-06-29', '06/2018'',''07/2018','', '', '','','',NULL

----lỌc nâng cao
EXEC NMP2000 'BS',null,1,25,0,'2018-06-29','2018-06-29', '06/2018'',''07/2018','', '', '','','',N' where IsNull(VoucherNo,'''') = N''asdas'''


*/
 CREATE PROCEDURE NMP2000
(
 	 @DivisionID VARCHAR(50),
     @DivisionIDList NVARCHAR(2000),
     @PageNumber INT,
     @PageSize INT,
     @IsDate TINYINT, --1:Datetime;0:Period
     @FromDate DATETIME,
     @ToDate DATETIME,
	 @PeriodIDList NVARCHAR(4000),
     @VoucherNo NVARCHAR(50),
	 @MenuTypeID NVARCHAR(250),
	 @Description NVARCHAR(250),
	 @BeginDate DATETIME,
	 @FinishDate DATETIME,
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
	IF Isnull(@MenuTypeID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(N.MenuTypeID,'''') LIKE N''%'+@MenuTypeID+'%'' '
	IF Isnull(@Description, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(N.Description,'''') LIKE N''%'+@Description+'%'' '
	IF Isnull(@BeginDate, '') != ''
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10),N.BeginDate,112) = '+CONVERT(VARCHAR(10),@BeginDate,112)
	IF Isnull(@FinishDate, '') != ''
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10),N.FinishDate,112) ='+CONVERT(VARCHAR(10),@FinishDate,112)
	
	IF @IsDate = 1 
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10),N.VoucherDate,112) BETWEEN '+CONVERT(VARCHAR(10),@FromDate,112)+' AND '+CONVERT(VARCHAR(10),@ToDate,112)+' '
	IF @IsDate = 0 
		SET @sWhere = @sWhere + ' AND (Case When  N.TranMonth <10 then ''0''+rtrim(ltrim(str(N.TranMonth)))+''/''+ltrim(Rtrim(str(N.TranYear))) 
									Else rtrim(ltrim(str(N.TranMonth)))+''/''+ltrim(Rtrim(str(N.TranYear))) End) IN ('''+@PeriodIDList+''')'
		--nếu giá trị NULL thì set về rổng 
				SET @SearchWhere = Isnull(@SearchWhere, '')
		End


	   --Lấy Distinct thưc đơn tổng
			SET @sSQL01 = N'		
		
								Select	Distinct N.APK ,N.DivisionID ,N.VoucherNo,N.VoucherDate,N.MenuTypeID,N.Description ,N.BeginDate,N.FinishDate
								INTO #NMP2000
								FROM NMT2000 N WITH (NOLOCK)
								WHERE ' +@sWhere + 'AND N.DeleteFlg = 0 

								Select  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow	
								, APK ,DivisionID ,VoucherNo,VoucherDate,MenuTypeID,Description ,BeginDate,FinishDate
							FROM #NMP2000 AS N
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
