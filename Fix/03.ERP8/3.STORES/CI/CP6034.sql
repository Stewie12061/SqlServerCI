IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CP6034]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CP6034]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by: Tieu Mai
---- Date: 07/03/2016
---- Purpose: Load kế thừa phiếu quá trình hoạt động phát sinh hàng ngày của máy (Angel)
---- Modified by Bảo Thy on 23/05/2017: Sửa danh mục dùng chung

---- CP6034 N'HT','2016-02-29 00:00:00','2016-02-29 00:00:00',0, ''

CREATE PROCEDURE [dbo].[CP6034]    
					@DivisionID nvarchar(50),
				    @FromDate AS datetime,
				    @ToDate AS Datetime,
				    @IsType AS TINYINT,  --- 0 load master, 1 load detail
					@LstVoucherID AS NVARCHAR(MAX) --- truyen '' khi load master
AS
Declare
 @sSQL as varchar(max)
 
SET @LstVoucherID = REPLACE(@LstVoucherID, ',', ''',''') 
 
IF @IsType = 0
	SET @sSQL = '
		SELECT CT6030.*, AT1103.FullName AS EmployeeName 
		FROM CT6030 WITH (NOLOCK)
		LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = CT6030.EmployeeID
		WHERE CT6030.DivisionID = '''+@DivisionID+'''
		AND VoucherDate BETWEEN '''+ CONVERT(NVARCHAR(10),@FromDate, 101)+''' AND '''+ CONVERT(NVARCHAR(10),@ToDate,101) +'''
		ORDER BY VoucherDate, VoucherNo	
	'
ELSE
	SET @sSQL = '
		SELECT CT6031.*, AT0150.MachineName, AT0146.MacErrorName, AT0166.ComponentName, DATEADD(month , CT6031.TimeCheckMonth, CT6031.TimeCheck) AS DateComMaintenace  
		FROM CT6031 WITH (NOLOCK)
		LEFT JOIN AT0150 WITH (NOLOCK) ON AT0150.DivisionID = CT6031.DivisionID AND AT0150.MachineID = CT6031.MachineID
		LEFT JOIN AT0146 WITH (NOLOCK) ON AT0146.DivisionID = CT6031.DivisionID AND AT0146.MacErrorID = CT6031.MacErrorID
		LEFT JOIN AT0166 WITH (NOLOCK) ON AT0166.DivisionID = CT6031.DivisionID AND AT0166.ComponentID = CT6031.ComponentSub
		WHERE CT6031.DivisionID = '''+@DivisionID+'''
		AND VoucherID IN ('''+@LstVoucherID+''')
		Order by CT6031.TransactionID, CT6031.MachineID
	'
--PRINT @sSQL
EXEC(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
