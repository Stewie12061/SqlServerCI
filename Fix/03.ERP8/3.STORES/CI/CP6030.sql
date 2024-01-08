IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CP6030]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CP6030]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by: Tieu Mai
---- Date: 07/03/2016
---- Purpose: Load danh sách phiếu quá trình hoạt động phát sinh hàng ngày của máy (Angel)
---- Modifed by Tiểu Mai on 28/11/2016: Fix bug thiếu AND khi @strWhere <> ''
---- Modified by Bảo Thy on 23/05/2017: Sửa danh mục dùng chung

---- CP6030 N'HT',2,2016,2,2016,'2016-02-29 00:00:00','2016-02-29 00:00:00',0

CREATE PROCEDURE [dbo].[CP6030]    
					@DivisionID nvarchar(50),
				    @FromMonth int,
	  			    @FromYear int,
				    @ToMonth int,
				    @ToYear int,  
				    @FromDate as datetime,
				    @ToDate as Datetime,
				    @IsDate as TINYINT,
				    @StrWhere NVARCHAR(4000) = ''
	
AS
Declare
 @sSQL as varchar(max),
 @sWhere  as nvarchar(4000)
 
 
IF @IsDate = 0
	Set  @sWhere = ' AND (CT6030.TranMonth + CT6030.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' and ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50))  + ')'
else				  
	Set  @sWhere = ' AND (CT6030.VoucherDate Between '''+Convert(nvarchar(10),@FromDate,21)+''' and '''+convert(nvarchar(10), @ToDate,21)+''')'


Set  @sSQL = '
SELECT CT6030.VoucherTypeID, CT6030.VoucherDate, CT6030.VoucherID, CT6030.VoucherNo, CT6030.Description, CT6030.MTC01, CT6030.MTC02, AT1103.FullName as EmployeeName 
FROM CT6030
LEFT JOIN AT1103 WITH (NOLOCK) ON CT6030.EmployeeID = AT1103.EmployeeID
LEFT JOIN CT6031 WITH (NOLOCK) ON CT6030.DivisionID = CT6031.DivisionID AND CT6030.VoucherID = CT6031.VoucherID
LEFT JOIN AT0150 WITH (NOLOCK) ON AT0150.DivisionID = CT6031.DivisionID AND AT0150.MachineID = CT6031.MachineID
WHERE CT6030.DivisionID = '''+@DivisionID+'''' + @sWhere + ''
+
CASE WHEN Isnull(@StrWhere,'') <> '' THEN ' AND ' ELSE '' END +
 @StrWhere + '
GROUP BY CT6030.VoucherTypeID, CT6030.VoucherDate, CT6030.VoucherID, CT6030.VoucherNo, CT6030.Description, CT6030.MTC01, CT6030.MTC02, AT1103.FullName
Order by VoucherDate, VoucherNo '


EXEC(@sSQL)
--PRINT @sSQL



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
