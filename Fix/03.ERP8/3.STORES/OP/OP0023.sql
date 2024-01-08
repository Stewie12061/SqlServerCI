IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0023]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0023]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load danh sách mặt hàng sắp hết hạn sử dụng (ANGEL) 
---- EXEC OP0023 @DivisionID = 'ANG', @DateNum = 600 
-- <Param>

CREATE PROCEDURE [dbo].[OP0023] 
		@DivisionID nvarchar(50),
		@DateNum INT				
AS
DECLARE @sSQL NVARCHAR(MAX)
DECLARE @CustomerName int
Set @CustomerName = (select 1 from CustomerIndex)
--PRINT @lstTransactionID

SET @sSQL = '
SELECT COUNT(ReTransactionID) AS CountInventoryID, 
	   STUFF((
	   		SELECT '', '' + [ReTransactionID] 
	   		FROM AT0114 WITH (NOLOCK)
	   		WHERE (ReTransactionID = AT0114.ReTransactionID) 
	   		AND DivisionID = ''' + @DivisionID + '''
	   		AND EndQuantity > 0
			' + case when @CustomerName = 57 then '	AND ReTransactionID IN (SELECT TransactionID FROM AT2007 WITH (NOLOCK) WHERE DivisionID = ''' + @DivisionID + ''')' else '' end + '
	   		AND DATEDIFF(d, GETDATE(), convert(nvarchar(50),LimitDate,101)) BETWEEN 0 AND ' + CONVERT(NVARCHAR(5),@DateNum) + '
	   		FOR XML PATH(''''),TYPE).value(''(./text())[1]'',''VARCHAR(MAX)''),1,2,''''
	   	) AS lstTransactionID
FROM   AT0114 WITH (NOLOCK)
WHERE  AT0114.DivisionID = ''' + @DivisionID + '''
       AND EndQuantity > 0
	   ' + case when @CustomerName = 57 then 'AND ReTransactionID IN (SELECT TransactionID FROM AT2007 WITH (NOLOCK) WHERE DivisionID = ''' + @DivisionID + ''')' else '' end + '
       AND DATEDIFF(d, GETDATE(), convert(nvarchar(50),LimitDate,101)) BETWEEN 0 AND ' + CONVERT(NVARCHAR(5),@DateNum) + '
'

PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
       