IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2020]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load Grid danh sách phieu ke cho
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
---- Lọc thường
EXEC NMP2020 'BS',null,1,25,1,'2018-09-28','2018-09-29', '09/2018'',''08/2018','', '','','', NULL
---- Lọc nâng cao
EXEC NMP2020 'BS',null,1,25,1,'2018-09-28','2018-09-29', '09/2018'',''08/2018','', '','','',N' where IsNull(MarketVoucherNo,'''') = N''asdas'''

*/
 CREATE PROCEDURE NMP2020
(
 	 @DivisionID VARCHAR(50),
     @DivisionIDList NVARCHAR(2000),
     @PageNumber INT,
     @PageSize INT,
     @IsDate TINYINT, --0:Datetime; 1:Period
     @FromDate DATETIME,
     @ToDate DATETIME,
	 @PeriodIDList NVARCHAR(4000),
     @MarketVoucherNo NVARCHAR(50),
	 @AnaID NVARCHAR(50),
	 @Description NVARCHAR(250),
	 @UserID  VARCHAR(50),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS
DECLARE @sSQL01 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50) = N''

		IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
      	SET @sWhere = ' 1 = 1 '
	SET @OrderBy = ' N.MarketVoucherDate Desc, N.MarketVoucherNo'
	If Isnull(@SearchWhere, '') = '' --Lọc thường
		Begin
	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != '' 
		SET @sWhere = @sWhere + 'AND  N.DivisionID IN ('''+@DivisionIDList+''')'
	Else 
		SET @sWhere = @sWhere + ' AND N.DivisionID IN ('''+@DivisionID+''')'

	IF Isnull(@MarketVoucherNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(N.MarketVoucherNo,'''') LIKE N''%'+@MarketVoucherNo+'%'' '
	IF Isnull(@AnaID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(N.AnaID,'''') LIKE N''%'+@AnaID+'%'' '
	IF Isnull(@Description, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(N.Description,'''') LIKE N''%'+@Description+'%'' '
	

	
	IF @IsDate = 0 
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10),N.MarketVoucherDate,112) BETWEEN '+CONVERT(VARCHAR(10),@FromDate,112)+' AND '+CONVERT(VARCHAR(10),@ToDate,112)+' '
	IF @IsDate = 1 
		SET @sWhere = @sWhere + ' AND (Case When  N.TranMonth <10 then ''0''+rtrim(ltrim(str(N.TranMonth)))+''/''+ltrim(Rtrim(str(N.TranYear))) 
									Else rtrim(ltrim(str(N.TranMonth)))+''/''+ltrim(Rtrim(str(N.TranYear))) End) IN ('''+@PeriodIDList+''')'

	--nếu giá trị NULL thì set về rổng 
				SET @SearchWhere = Isnull(@SearchWhere, '')
End

	   --Lấy Distinct phieu ke cho
			SET @sSQL01 = '		
								Select	Distinct N.APK ,N.DivisionID ,N.MarketVoucherNo,N.MarketVoucherDate,N.AnaID,N.Description
								 INTO #NMP2020 
								FROM NMT2020 N WITH (NOLOCK)
								inner join  AT1011 A11 WITH (NOLOCK)  on N.AnaID=A11.AnaID
								inner join  AT0000  WITH (NOLOCK)  ON  A11.AnaTypeID = AT0000.SchoolAnaTypeID AND A11.DivisionID IN ('''+@DivisionID+''', ''@@@'')
								WHERE ' +@sWhere + 'AND N.DeleteFlg = 0 
		
								Select  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow	
								 ,APK ,DivisionID ,MarketVoucherNo,MarketVoucherDate,AnaID,Description
							FROM #NMP2020 AS N
							'+@SearchWhere +'
							ORDER BY '+@OrderBy+'
							OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
							FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'


EXEC (@sSQL01)
--print (@sSQL01)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

