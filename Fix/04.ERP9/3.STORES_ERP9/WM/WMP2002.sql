IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP2002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP2002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Load danh sách hợp đồng theo đối tượng
 -- <Return>
 ---- 
 -- <Reference>
 ---- WM ERP 9.0 / Yêu cầu nhập/xuất kho / cập nhật / button hợp đồng
 -- <History>
 ----Created by: Bảo Thy, Date: 13/01/2016
 /*-- <Example>
 	WMP2002 @DivisionID='ESP',@UserID='00150', @PageNumber=1,@PageSize=25, @TxtSearch='', @TranMonth=2,@TranYear=2016,
	@Date = '2016-10-01', @ToDate = '2016-12-31'
 	
 ----*/
 
 CREATE PROCEDURE WMP2002
 ( 
   @DivisionID VARCHAR(50),
   @UserID VARCHAR(50),
   @TxtSearch VARCHAR(250),
   @PageNumber INT,
   @PageSize INT,
   @Date DATETIME,
   @TranMonth INT,
   @TranYear INT
 ) 
 AS
 DECLARE @sSQL VARCHAR(MAX),
 		 @OrderBy NVARCHAR(500),
         @TotalRow NVARCHAR(50) = '',
         @sSQL1 NVARCHAR(MAX)

SET @OrderBy = 'BT.ContractNo'
IF @PageNumber <> 0 
	SET @TotalRow = 'COUNT(*) OVER ()'
ELSE 
	SET @TotalRow = ''

SET @sSQL = '
SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, BT.*
FROM
	(
	SELECT DivisionID, ContractID, ContractNo, Contractname AS Description, BeginDate, EndDate
	FROM AT1020 WITH (NOLOCK)
	WHERE DivisionID = '''+@DivisionID+'''
	AND ObjectID = '''+@UserID+'''
	AND '''+CONVERT(VARCHAR(10),@Date,120)+''' BETWEEN BeginDate AND EndDate
	AND ISNULL(ContractNo,'''') LIKE ''%'+@TxtSearch+'%'' 
	)BT
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS	
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY

'

--PRINT(@sSQL)
EXEC(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
