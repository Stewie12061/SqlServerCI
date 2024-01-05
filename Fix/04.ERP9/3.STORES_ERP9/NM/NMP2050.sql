IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2050]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2050]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Load Grid danh sách tiep pham ba bước
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Trà Giang
----Create date: 20/09/2018
--- Modify 
/*
--Lọc thường
EXEC NMP2050 'BS',null,1,25,'2018-03-01','2018-10-29', 'a', '001',NULL
--Lọc nâng cao
EXEC NMP2050 'BS',null,1,25,'2018-03-01','2018-10-29', '', '001',N' where IsNull(VoucherNo,'''') = N''asdas'''

*/
 CREATE PROCEDURE NMP2050
(
 	 @DivisionID VARCHAR(50),
     @DivisionIDList NVARCHAR(2000),
     @PageNumber INT,
     @PageSize INT,
     @FromDate DATETIME,
     @ToDate DATETIME,
	 @VoucherNo NVARCHAR(50),
	 @MarketVoucherNo  NVARCHAR(50),
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
	
	IF Isnull(@MarketVoucherNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(N.MarketVoucherNo,'''') LIKE N''%'+@MarketVoucherNo+'%'' '
	
	
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10),N.VoucherDate,112) BETWEEN '+CONVERT(VARCHAR(10),@FromDate,112)+' AND '+CONVERT(VARCHAR(10),@ToDate,112)+' '
	
		--nếu giá trị NULL thì set về rổng 
				SET @SearchWhere = Isnull(@SearchWhere, '')
End


			SET @sSQL01 = '		
		
								Select	Distinct N.APK ,N.DivisionID ,N.VoucherNo,N.VoucherDate,N.MarketVoucherNo
								INTO #NMP2050
								FROM NMT2050 N WITH (NOLOCK)
								WHERE ' +@sWhere + 'AND N.DeleteFlg = 0 
						 
						 Select  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow	
							,APK ,DivisionID ,VoucherNo,VoucherDate,MarketVoucherNo
							FROM #NMP2050 AS N
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
