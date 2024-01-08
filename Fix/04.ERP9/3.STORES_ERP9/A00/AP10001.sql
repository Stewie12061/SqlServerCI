IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP10001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP10001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Màn hình chọn tiêu thức
-- <Param>
---- 
-- <Return>
---- Chọn tiêu thức động
-- <Reference>
---- ERP9/Báo cáo tài chính
-- <History>
---- Create on 06/09/2017 by Kha Vi
---- Modified on 29/09/2017 by Bảo Thy: bổ sung phân trang
-- <Example>
---- 

CREATE PROCEDURE AP10001(
		  @DivisionID VARCHAR(50),
		  @SelectionType nvarchar(50),
		  @FormID nvarchar(50),
		  @Key01ID nvarchar(50),
		  @Key02ID nvarchar(50),
		  @Key03ID nvarchar(50),
		  @Num01ID nvarchar(50),
		  @Num02ID nvarchar(50),
		  @Date01ID nvarchar(50),
		  @Date02ID nvarchar(50),
		  @PageNumber INT,
		  @PageSize INT
)
AS
DECLARE @sSQL nvarchar(max),
		@sJoin nvarchar(max),
		@sWhere nvarchar(max),
		@TotalRow NVARCHAR(50)
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF (@FormID='AR3002' and @SelectionType='IN')
BEGIN

	SET @sWhere = N'AT1302.InventoryTypeID between '''+@Key01ID+''' and '''+@Key02ID+''''

	SET @sJoin = N'left join AT1302 WITH(NOLOCK) on AV6666.SelectionID=AT1302.InventoryID'

	SET @sSQL=
	N'SELECT ROW_NUMBER() OVER (ORDER BY SelectionID) AS RowNum, '+@TotalRow+' AS TotalRow, * from AV6666 with (nolock) '+@sJoin+'
	where AV6666.SelectionType= '''+@SelectionType+''' and av6666.DivisionID = '''+@DivisionID+''' and '+@sWhere+' 
	ORDER BY SelectionID
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END
ELSE
BEGIN 
	SET @sWhere=''
	SET @sJoin=''
	SET @sSQL=N'SELECT ROW_NUMBER() OVER (ORDER BY SelectionID) AS RowNum, '+@TotalRow+' AS TotalRow, * from AV6666 with (nolock) '+@sJoin+'
	where AV6666.SelectionType= '''+@SelectionType+''' and av6666.DivisionID = '''+@DivisionID+'''
	ORDER BY SelectionID
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END

exec(@sSQL)
--print(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
