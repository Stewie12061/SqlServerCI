IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CP6036]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CP6036]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Danh sách máy sắp đến ngày bảo dưỡng (CSF6032) 
-- <Param>

CREATE PROCEDURE [dbo].[CP6036] 
		@DivisionID nvarchar(50),
		@DateNum INT				
AS
DECLARE @sSQL NVARCHAR(MAX)

--PRINT @lstTransactionID

SET @sSQL = '
SELECT COUNT(TransactionID) AS CountMachine, 
       STUFF((
				SELECT '', '' + [TransactionID] 
				FROM CT6033 WITH (NOLOCK)
				WHERE (TransactionID = CT6033.TransactionID) 
				AND DivisionID = ''' + @DivisionID + '''
				AND DATEDIFF(d, GETDATE(), convert(nvarchar(50),DateMaintenance,101)) <= ' + CONVERT(NVARCHAR(5),@DateNum) + '
				AND ISNULL(StatusMaintenance, 0) <> 3
				FOR XML PATH(''''),TYPE).value(''(./text())[1]'',''VARCHAR(MAX)''),1,2,''''
			) AS lstTransactionID
FROM CT6033 WITH (NOLOCK)
WHERE DivisionID = ''' + @DivisionID + '''
AND DATEDIFF(d, GETDATE(), convert(nvarchar(50),DateMaintenance,101)) <= ' + CONVERT(NVARCHAR(5),@DateNum) + '
AND ISNULL(StatusMaintenance, 0) <> 3
--GROUP BY TransactionID
'

PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
