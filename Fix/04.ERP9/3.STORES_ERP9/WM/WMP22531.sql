IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP22531]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP22531]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary> 
--- Load màn hình chọn mặt hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Hoài Bảo, Date: 10/03/2022
----Modified by: Hoài Bảo, Date: 23/11/2022 - Bổ sung load tên người lập phiếu, tên kho
-- <Example>
/*
    EXEC WMP22531 @DivisionID=N'''',@TxtSearch=N'''',@TranMonth=N''1'',@TranYear=N''2021'',@PageNumber=N''1'',@PageSize=N''100'''
*/

CREATE PROCEDURE WMP22531
(
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @TranMonth VARCHAR(50),
	 @TranYear VARCHAR(50),
     @PageNumber INT,
     @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)

	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'M.CreateDate'

	SET @sWhere = @sWhere + ' AND Isnull(ReTransactionID,'''') = '''' '

	IF ISNULL(@DivisionID, '') != ''
		SET @sWhere = @sWhere + ' AND AT2036.DivisionID IN (''' + @DivisionID + ''') '
	IF ISNULL(@TranMonth, '') != ''
		SET @sWhere = @sWhere + ' AND AT2036.TranMonth IN (''' + @TranMonth + ''') '
	IF ISNULL(@TranYear, '') != ''
		SET @sWhere = @sWhere + ' AND AT2036.TranYear IN (''' + @TranYear + ''') '
	
	IF Isnull(@TxtSearch,'') != ''  SET @sWhere = @sWhere +'
									AND (AT2036.VoucherNo LIKE N''%'+@TxtSearch+'%'' 
									OR A1.FullName LIKE N''%'+@TxtSearch+'%'' 
									OR A2.WareHouseName LIKE N''%'+@TxtSearch+'%'' 
									OR AT2036.[Description] LIKE N''%'+@TxtSearch+'%'')'

	SET @sSQL = 'SELECT DISTINCT AT2036.VoucherID,AT2036.DivisionID,AT2036.TranMonth,AT2036.TranYear,AT2036.VoucherTypeID,AT2036.VoucherNo,AT2036.VoucherDate,
      AT2036.WareHouseID, A2.WareHouseName, A1.FullName AS EmployeeName, AT2036.EmployeeID AS DeEmployeeID, AT2036.CreateDate
	  INTO #TempAT2036
      FROM AT2036 WITH (NOLOCK)
	  INNER JOIN AT2037 WITH (NOLOCK) ON AT2036.DivisionID = AT2037.DivisionID AND AT2036.VoucherID=AT2037.VoucherID 
	  LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = AT2036.EmployeeID
	  LEFT JOIN AT1303 A2 WITH (NOLOCK) ON A2.WareHouseID = AT2036.WareHouseID
      WHERE 1=1 ' + @sWhere + '

	  DECLARE @Count INT
	  SELECT @Count = COUNT(Voucherno) FROM #TempAT2036

	  SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow,
		  M.VoucherID, M.DivisionID, M.TranMonth, M.TranYear, M.VoucherTypeID, M.VoucherNo
		, M.VoucherDate, M.WareHouseID, M.WareHouseName, M.EmployeeName, M.DeEmployeeID, M.CreateDate
	  FROM #TempAT2036 M
	  ORDER BY ' + @OrderBy + '
	  OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
	  FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

	EXEC (@sSQL)
	PRINT(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
