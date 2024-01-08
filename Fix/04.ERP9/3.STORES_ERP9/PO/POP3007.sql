IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP3007]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP3007]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Báo cáo mã hàng mua nhiều nhất theo thời gian
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 17/08/2019 by Kiều Nga
----Modify on 17/08/2020 by Kiều Nga : chuyển param InventoryID sang dạng xml
----Modify on 23/02/2023 by Nhật Thanh : Bổ sung lấy cột thông số kỹ thuật
----Modify on ... by ...

-- <Example>
/*  
 EXEC POP3007 @DivisionID,@IsDate, @FromDate, @ToDate, @PeriodList, @InventoryID
*/
----
CREATE PROCEDURE POP3007 ( 
        @DivisionID VARCHAR(50),
		@DivisionIDList	NVARCHAR(MAX),
		@IsDate INT, ---- 1: là ngày, 0: là kỳ
		@FromDate DATETIME,
		@ToDate DATETIME,
		@PeriodList NVARCHAR(MAX),
		@InventoryID AS xml = '<D></D>'
) 
AS

DECLARE @TotalRow VARCHAR(50),
		@sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sJoin VARCHAR(MAX)

SET @sWhere = ''
SET @sJoin = ''
SET @sSQL = ''

--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
IF Isnull(@DivisionIDList, '') != ''
	SET @sWhere = '  OT02.DivisionID IN ('''+@DivisionIDList+''')'
ELSE 
	SET @sWhere = '  OT02.DivisionID = N'''+@DivisionID+''''	

--Begin: Load dữ liệu từ xml params:
--- Mặt hàng
IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[tmpInventoryID]') AND TYPE IN (N'U'))
					DROP TABLE tmpInventoryID
CREATE TABLE tmpInventoryID
(
		InventoryID varchar(50)
)
INSERT INTO	tmpInventoryID		
SELECT	X.D.value('.', 'VARCHAR(50)') AS InventoryID
FROM	@InventoryID.nodes('//D') AS X (D)
------------------------------------------

IF @IsDate = 0
	BEGIN
	IF ISNULL(@PeriodList,'') <> ''
		SET @sWhere = @sWhere + ' AND ((CASE WHEN OT01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(OT01.TranMonth)))+''/''+ltrim(Rtrim(str(OT01.TranYear))) in ('''+@PeriodList +'''))'
	END
ELSE
	BEGIN
	IF ISNULL(@FromDate,'') <> '' AND ISNULL(@ToDate,'') <> ''
		SET @sWhere = @sWhere + ' AND (Convert(varchar(20),OT01.OrderDate,112) Between ''' + Convert(varchar(20),@FromDate,112) + ''' AND ''' + Convert(varchar(20),Isnull(@ToDate,'12/31/9999'),112) + ''')'
	END

IF (select count(InventoryID) from tmpInventoryID where ISNULL(InventoryID,'') <> '') > 0
	SET @sWhere = @sWhere + 'AND OT02.InventoryID IN (select InventoryID from tmpInventoryID)'

SET @sSQL = @sSQL+ '
select OT02.InventoryID, T02.InventoryName, T02.Specification, T04.UnitName, Sum(OT02.OrderQuantity) as OrderQuantity
FROM OT3002  OT02 WITH (NOLOCK)
LEFT JOIN OT3001 OT01 WITH (NOLOCK) ON OT01.POrderID = OT02.POrderID
LEFT JOIN AT1302 T02 WITH (NOLOCK) ON T02.InventoryID = OT02.InventoryID
LEFT JOIN AT1304 T04 WITH (NOLOCK) ON T04.UnitID = OT02.UnitID
where 
'+@sWhere+'
Group By OT02.InventoryID, T02.InventoryName,T02.Specification, T04.UnitName
Order by Sum(OT02.OrderQuantity) DESC ,OT02.InventoryID'


print @sSQL
EXEC(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
