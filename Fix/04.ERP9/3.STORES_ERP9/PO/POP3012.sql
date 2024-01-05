IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP3012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP3012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Báo cáo tình hình lập đơn hàng mua
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 13/12/2019 by Kiều Nga
---- Modify on 20/01/2020 by Kiều Nga : Chỉnh sửa Từ kỳ - Đến kỳ thành control Chọn kì theo chuẩn ERP 9.9
---- Modify on 29/11/2022 by Anh Đô : Đổi từ select AnaName sang EmployeeName
---- Modify on 02/12/2022 by Anh Đô : Dùng OrderDate làm ngày chứng từ thay cho CreateDate
-- <Example>
---- 

CREATE PROCEDURE [dbo].[POP3012] 
				@DivisionID as nvarchar(50),	--Biến môi trường
				@DivisionIDList	NVARCHAR(MAX),
				@IsDate INT, ---- 1: là ngày, 0: là kỳ
				@FromDate DATETIME,
				@ToDate DATETIME,
				@PeriodList NVARCHAR(MAX)='',
				@ListEmployeeID as nvarchar(max) ='',
				@ListObjectID as nvarchar(max) =''
 AS
DECLARE 	@sSQL nvarchar(MAX) ='',
			@sWhere NVARCHAR(MAX) =''

--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
IF Isnull(@DivisionIDList, '') != ''
	SET @sWhere = ' T1.DivisionID IN ('''+@DivisionIDList+''')'
ELSE 
	SET @sWhere = ' T1.DivisionID = N'''+@DivisionID+''''	

IF @IsDate = 0
BEGIN
	SET @sWhere = @sWhere +  ' AND CONVERT(DATETIME,CONVERT(VARCHAR(10),T1.OrderDate,101),101) between ''' + CONVERT(NVARCHAR(20), @FromDate, 101) + ''' and ''' +  CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'  + ''''
END
ELSE
BEGIN
	SET @sWhere = @sWhere +  ' AND (CASE WHEN T1.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T1.TranMonth)))+''/''+ltrim(Rtrim(str(T1.TranYear))) IN ('''+@PeriodList +''')' 
END

IF ISNULL(@ListEmployeeID,'') <> ''
	SET @sWhere = @sWhere + ' AND T1.EmployeeID IN ( '''+@ListEmployeeID+''')'

IF ISNULL(@ListObjectID,'') <> ''
	SET @sWhere = @sWhere + ' AND T1.ObjectID IN ( '''+@ListObjectID+''')'

SET @sSQL = @sSQL+ N'
SELECT * FROM (
SELECT DISTINCT T4.VoucherNo as AT2006VoucherNo, T1.VoucherNo, T5.FullName AS EmployeeName, T1.OrderDate, T4.CreateDate as VoucherDate
,DATEDIFF(hour, T1.Createdate, ISNULL(T4.CreateDate, GETDATE())) as Time, CASE WHEN DATEDIFF(hour, T1.Createdate, ISNULL(T4.CreateDate, GETDATE())) >= 3  THEN N''Trễ'' ELSE N''Không trễ'' END as Evaluate
,T1.ObjectName
from OT3001 T1 WITH (NOLOCK)
Left join OT3002 T2 WITH (NOLOCK) ON T1.POrderID = T2.POrderID
Left join AT2007 T3 WITH (NOLOCK) ON T1.POrderID = T3.InheritVoucherID 
Left join AT2006 T4 WITH (NOLOCK) ON T4.VoucherID = T3.VoucherID and T4.KindVoucherID = 1
LEFT JOIN AT1103 T5 WITH (NOLOCK) ON T5.EmployeeID = T1.EmployeeID
where '+@sWhere + ') x ORDER BY x.OrderDate, x.VoucherNo'

print @sSQL
EXEC(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
