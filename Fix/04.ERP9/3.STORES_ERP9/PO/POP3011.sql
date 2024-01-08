IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP3011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP3011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Báo cáo tổng hợp giá mua mặt hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 12/12/2019 by Kiều Nga
---- Modify on 20/01/2020 by Kiều Nga : Chỉnh sửa Từ kỳ - Đến kỳ thành control Chọn kì theo chuẩn ERP 9.9
---- Modify on 23/02/2023 by Nhật Thanh : Bổ sung lấy cột thông số kỹ thuật
-- <Example>
---- 

CREATE PROCEDURE [dbo].[POP3011] 
				@DivisionID as nvarchar(50),	--Biến môi trường
				@DivisionIDList	NVARCHAR(MAX),
				@IsDate INT, ---- 1: là ngày, 0: là kỳ
				@FromDate DATETIME,
				@ToDate DATETIME,
				@PeriodList NVARCHAR(MAX)='',	
				@ListInventoryID as nvarchar(max) ='',
				@ListObjectID as nvarchar(max) =''
 AS
DECLARE 	@sSQL nvarchar(MAX) ='',
			@sWhere NVARCHAR(MAX) =''

--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
IF Isnull(@DivisionIDList, '') != ''
	SET @sWhere = ' OT02.DivisionID IN ('''+@DivisionIDList+''')'
ELSE 
	SET @sWhere = ' OT02.DivisionID = N'''+@DivisionID+''''	

IF @IsDate = 0
BEGIN
	SET @sWhere = @sWhere +  ' AND CONVERT(DATETIME,CONVERT(VARCHAR(10),OT01.OrderDate,101),101) between ''' + CONVERT(NVARCHAR(20), @FromDate, 101) + ''' and ''' +  CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'  + ''''
END
ELSE
BEGIN
	SET @sWhere = @sWhere +  ' AND (CASE WHEN OT01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(OT01.TranMonth)))+''/''+ltrim(Rtrim(str(OT01.TranYear))) IN ('''+@PeriodList +''')'
END

IF ISNULL(@ListInventoryID,'') <> ''
	SET @sWhere = @sWhere + ' AND OT02.InventoryID IN ( '''+@ListInventoryID+''')'

IF ISNULL(@ListObjectID,'') <> ''
	SET @sWhere = @sWhere + ' AND OT01.ObjectID IN ( '''+@ListObjectID+''')'

SET @sSQL = @sSQL+ '
select OT02.InventoryID, T02.InventoryName, T02.Specification, OT02.PurchasePrice, T12.ObjectName,OT02.Notes
FROM OT3002  OT02 WITH (NOLOCK)
LEFT JOIN OT3001 OT01 WITH (NOLOCK) ON OT01.POrderID = OT02.POrderID
LEFT JOIN AT1302 T02 WITH (NOLOCK) ON T02.InventoryID = OT02.InventoryID
LEFT JOIN AT1304 T04 WITH (NOLOCK) ON T04.UnitID = OT02.UnitID
LEFT JOIN AT1202 T12 WITH (NOLOCK) ON OT01.ObjectID = T12.ObjectID
where 
'+@sWhere+'
Group by OT02.InventoryID, T02.InventoryName, T02.Specification, OT02.PurchasePrice, T12.ObjectName,OT02.Notes
Order by OT02.InventoryID,OT02.PurchasePrice'

--print @sSQL
EXEC(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
