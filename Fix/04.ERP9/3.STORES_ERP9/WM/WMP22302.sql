IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP22302]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP22302]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load dữ liệu combobox đơn hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoài Bảo, Date: 25/02/2022
-- <Example>
/*	EXEC WMP22302 @DivisionID=N'DTI',@TranMonth=N'12',@TranYear=N'2019',@OrderDate=N'2022-02-25 00:00:00'
*/

CREATE PROCEDURE WMP22302 (
	@DivisionID AS NVARCHAR(50),		
	@TranMonth AS INT,
	@TranYear AS INT,
	@OrderDate AS NVARCHAR(50)
)
AS
DECLARE @sSQL AS NVARCHAR(MAX) = ''

SET @sSQL = '
SELECT OV1003.OrderID, OV1003.VoucherNo, OV1003.OrderDate, OV1003.ObjectName, OV1003.Notes, OV1003.Type 
      FROM OV1003
      WHERE OV1003.Disabled = 0 
      AND OV1003.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID('''+ @DivisionID +'''))       
      AND OV1003.OrderType = 0 
      AND OV1003.Type = ''SO'' 
      AND OV1003.TranMonth = ' + CONVERT(NVARCHAR(5), @TranMonth) + '
	  AND OV1003.TranYear = ' + CONVERT(NVARCHAR(5), @TranYear) + '
      AND OV1003.OrderStatus NOT IN (0, 3, 4, 9)  
      UNION ALL 
      SELECT OrderID, VoucherNo,  OrderDate, ObjectName, Notes, Type FROM OV1003 
      WHERE Disabled = 0 
      AND OV1003.TranMonth = ' + CONVERT(NVARCHAR(5), @TranMonth) + '
	  AND OV1003.TranYear = ' + CONVERT(NVARCHAR(5), @TranYear) + '
      AND DivisionID in ('''+ @DivisionID +''',''@@@'') 
      AND Type = ''ES'' 
      and OrderStatus NOT IN (0, 2, 9) 
      AND OrderID IN 
      (
	      SELECT DISTINCT OV1015.OrderID From OV1015 
	      Where DivisionID in ('''+ @DivisionID +''',''@@@'') 
	      AND EndQuantity > 0
	  )
      UNION 
      SELECT OrderID, VoucherNo,  OrderDate, ObjectName, Notes, Type FROM OV1003 
      WHERE DivisionID in ('''+ @DivisionID +''',''@@@'') 
      AND Type = ''AS''
      AND OV1003.TranMonth = ' + CONVERT(NVARCHAR(5), @TranMonth) + '
	  AND OV1003.TranYear = ' + CONVERT(NVARCHAR(5), @TranYear) + '
      AND OrderDate <= '''+ @OrderDate +'''
      AND OrderID IN (SELECT DISTINCT OrderID FROM OV1016 WHERE DataType = 2 AND DivisionID = '''+ @DivisionID +''' AND OrderQuantity > 0)
ORDER BY VoucherNo, OrderDate' 
		
--PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
