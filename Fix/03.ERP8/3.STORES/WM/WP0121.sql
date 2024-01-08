IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0121]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0121]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Tra ra du lieu load edit Master ke thua nhieu phieu don hang ban o MH yêu cầu xuất kho (WF0096) -- AN PHÁT (CustomizeIndex = 54)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created on 09/08/2016 by Tiểu Mai
---- Modified by Bảo Thy on 26/05/2017: Sửa danh mục dùng chung
---- Modified by Văn Tài on 13/12/2019: Sửa lỗi thiếu AND khi search theo từ ngày đến ngày.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- EXEC 

CREATE PROCEDURE [dbo].[WP0121]      
			@DivisionID nvarchar(50),
		    @FromMonth int,
		    @FromYear int,
		    @ToMonth int,
		    @ToYear int,  
		    @FromDate as datetime,
		    @ToDate as Datetime,
		    @IsDate as tinyint, ----0 theo kỳ, 1 theo ngày
		    @ObjectID nvarchar(50)		
				
 AS
DECLARE @sSQL as nvarchar(4000),		
		@CustomizeName AS INT,
		@sWHERE AS NVARCHAR(MAX)
		
SET @sWHERE = N''
	
DECLARE	@TempTable table(CustomerName  int,IsExcel  int)
INSERT @TempTable
EXEC	[dbo].[AP4444]
SET @CustomizeName = (SELECT TOP 1 CustomerName FROM @TempTable)

IF @IsDate = 1
	set @sWHERE = @sWHERE + '
	AND O01.OrderDate BETWEEN ''' + CONVERT(NVARCHAR(10),@FromDate,21) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate,21) + ''' '
ELSE 
	set @sWHERE = @sWHERE + '
	AND O01.TranMonth + O01.TranYear * 100 BETWEEN ' + CAST(@FromMonth + @FromYear * 100 AS NVARCHAR(50)) + ' AND ' +  CAST(@ToMonth + @ToYear * 100 AS NVARCHAR(50))

SET @sSQL = '
SELECT DISTINCT O01.DivisionID
	, O01.SOrderID AS OrderID
	, O01.OrderDate
	, O01.ObjectID
	, A22.ObjectName
	, O01.Notes 
FROM OT2001 O01 WITH (NOLOCK)
LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O02.DivisionID = O01.DivisionID 
										AND O02.SOrderID = O01.SOrderID
LEFT JOIN AT1202 A22 WITH (NOLOCK) ON A22.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND O01.ObjectID = A22.ObjectID
WHERE O01.DivisionID = '''+@DivisionID+''' 
		AND OrderType  = 0
		AND (ISNULL(OrderQuantity,0) - ISNULL(SOActualQuantity,0)) > 0
		AND O01.ObjectID LIKE '''+@ObjectID+'''
		' + @sWHERE

EXEC (@sSQL)
PRINT (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON