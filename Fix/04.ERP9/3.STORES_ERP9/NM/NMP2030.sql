IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2030]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2030]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load Grid danh sách phiếu điều tra dinh dưỡng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Trà Giang
----Create date: 17/09/2018
--- Modify 
/*
--Lọc thường
EXEC NMP2030 'BS',null,1,25,1,'2018-06-01','2018-06-29', '06/2018'',''09/2018','PDT/09/2018/01', '', '','',NULL
--Lọc nâng cao
EXEC NMP2030 'BS',null,1,25,1,'2018-06-01','2018-06-29', '06/2018'',''09/2018','PDT/09/2018/01', '', '','',N' where IsNull(InvestigateVoucherNo,'''') = N''asdas'''

*/
 CREATE PROCEDURE NMP2030
(
 	 @DivisionID VARCHAR(50),
     @DivisionIDList NVARCHAR(2000),
     @PageNumber INT,
     @PageSize INT,
     @FromDate DATETIME,
     @ToDate DATETIME,
	 @InvestigateVoucherNo NVARCHAR(50),
	 @MarketVoucherNo NVARCHAR(50),
     @MenuVoucherNo NVARCHAR(50),
	 @Description NVARCHAR(250),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS
DECLARE @sSQL01 NVARCHAR (MAX),
		@sSQL02 NVARCHAR (MAX),
		@sSQL03 NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),	
		@TotalRow NVARCHAR(50) = N''

	SET @sWhere = '1=1 '
	SET @OrderBy = ' N.InvestigateVoucherDate Desc, N.InvestigateVoucherNo'
	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

	If Isnull(@SearchWhere, '') = '' --Lọc thường
		Begin
	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != '' 
		SET @sWhere = @sWhere + 'AND N.DivisionID IN ('''+@DivisionIDList+''')'
	Else 
		SET @sWhere = @sWhere + 'AND N.DivisionID IN ('''+@DivisionID+''')'

	IF Isnull(@InvestigateVoucherNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(N.InvestigateVoucherNo,'''') LIKE N''%'+@InvestigateVoucherNo+'%'' '
	
	IF Isnull(@MarketVoucherNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(N.MarketVoucherNo,'''') LIKE N''%'+@MarketVoucherNo+'%'' '
	IF Isnull(@MenuVoucherNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(N.MenuVoucherNo,'''') LIKE N''%'+@MenuVoucherNo+'%'' '
	IF Isnull(@Description, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(N.Description,'''') LIKE N''%'+@Description+'%'' '
	

	
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10),N.InvestigateVoucherDate,112) BETWEEN '+CONVERT(VARCHAR(10),@FromDate,112)+' AND '+CONVERT(VARCHAR(10),@ToDate,112)+' '
		--nếu giá trị NULL thì set về rổng 
				SET @SearchWhere = Isnull(@SearchWhere, '')
		End
	   --Lấy Distinct thưc đơn tổng
			SET @sSQL01 = '		
		
								Select	Distinct N.APK ,N.DivisionID ,N.InvestigateVoucherNo,N.InvestigateVoucherDate,N.MarketVoucherNo ,N.MenuVoucherNo,N.Description
								INTO #NMP2030 
								FROM NMT2030 N WITH (NOLOCK)
								WHERE ' +@sWhere + 'AND N.DeleteFlg = 0 

								Select  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow	
								,APK ,DivisionID ,InvestigateVoucherNo,InvestigateVoucherDate,AnaID,MarketVoucherNo ,MenuVoucherNo,Description
							FROM #NMP2030 AS N
							'+@SearchWhere +'
		
								ORDER BY '+@OrderBy+'
								OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
								FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '


EXEC (@sSQL01)
--print (@sSQL01)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
