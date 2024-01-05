IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP3086]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP3086]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo vật tư nhân viên đang giữ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Kiều Nga, Date: 26/11/2019
-- <Example> 

CREATE PROCEDURE POSP3086 
(
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@ShopID				VARCHAR(50),
	@ShopIDList			NVARCHAR(MAX),
	@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME,
	@FromYear           AS INT,
	@FromMonth          AS INT,
	@PeriodIDList		NVARCHAR(2000),
	@ListInventoryID	VARCHAR(MAX) ='',
	@ListEmployeeID		VARCHAR(MAX) =''
)
AS
BEGIN
		DECLARE @sSQL1   NVARCHAR(MAX) ='',  
				@sSQL2   NVARCHAR(MAX) ='',  
				@sWhere NVARCHAR(MAX) =''
				
		IF Isnull(@DivisionIDList,'') = ''
			SET @sWhere = @sWhere + ' AND PT50.DivisionID IN ('''+ @DivisionID+''')'
		Else 
			SET @sWhere = @sWhere + ' AND PT50.DivisionID IN ('''+@DivisionIDList+''')'

		IF @IsDate = 1	
			SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,PT50.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
		ELSE
			SET @sWhere = @sWhere + ' AND (Case When  Month(PT50.VoucherDate) <10 then ''0''+rtrim(ltrim(str(Month(PT50.VoucherDate))))+''/''+ltrim(Rtrim(str(Year(PT50.VoucherDate)))) Else rtrim(ltrim(str(Month(PT50.VoucherDate))))+''/''+ltrim(Rtrim(str(Year(PT50.VoucherDate)))) End) IN ('''+@PeriodIDList+''')'

		IF Isnull(@ShopIDList,'') = ''
			SET @sWhere = @sWhere + ' And PT50.ShopID IN ('''+@ShopID+''')'
		Else 
			SET @sWhere = @sWhere + ' And PT50.ShopID IN ('''+@ShopIDList+''')'
				
		IF Isnull(@ListInventoryID, '')<> ''
			SET @sWhere = @sWhere + ' AND PT51.ServiceID IN ('''+@ListInventoryID +''')'

		IF Isnull(@ListEmployeeID, '')<> ''
		   	SET @sWhere = @sWhere + ' AND PT53.RepairEmployeeID IN ('''+@ListEmployeeID +''')'

-- Lấy dữ liệu tồn kho store POSP00711 lọc theo kho hàng hỏng
create table #POSP00711(
DivisionID nvarchar(50),WareHouseID nvarchar(50),WareHouseName nvarchar(250),InventoryID nvarchar(50),
InventoryName nvarchar(50),UnitID nvarchar(50),UnitName nvarchar(250),BeginQuantity decimal,ImQuantity decimal,
ExQuantity decimal,EndQuantity decimal)
insert into #POSP00711
exec POSP3085 @DivisionID=@DivisionID,@DivisionIDList=@DivisionIDList,@ShopID=@ShopIDList,@IsDate=@IsDate,@FromDate=@FromDate,@ToDate=@ToDate,@FromYear=@FromYear,@FromMonth=@FromMonth,@PeriodIDList=@PeriodIDList,@ListInventoryID=@ListInventoryID

SET @sSQL1 = 'SELECT PT53.RepairEmployeeID AS EmployeeID ,A03.FullName AS EmployeeName, PT51.ServiceID, A01.InventoryName as ServiceName,P04.UnitName,
		 ISNULL(OV24.EndQuantity,0) as EndQuantity,Sum(ISNULL(PT51.SuggestQuantity,0)) as SuggestQuantity , Sum(ISNULL(PT51.ReturnQuantity,0)) as ReturnQuantity, Sum(ISNULL(PT51.SuggestQuantity,0) - ISNULL(PT51.ReturnQuantity,0)) as ActualQuantity
FROM POST2051 PT51 WITH (NOLOCK)
INNER JOIN POST2050 PT50 WITH (NOLOCK) ON PT50.APK = PT51.APKMaster
INNER JOIN POST2053 PT53 WITH (NOLOCK) ON PT53.VoucherNo = PT50.VoucherNo
LEFT JOIN AT1302 A01 WITH (NOLOCK)  ON PT51.ServiceID = A01.InventoryID
LEFT JOIN AT1304 P04 WITH (NOLOCK) ON A01.UnitID = P04.UnitID
LEFT JOIN AT1103 A03 WITH (NOLOCK)  ON PT53.RepairEmployeeID = A03.EmployeeID
LEFT JOIN #POSP00711 OV24 WITH (NOLOCK)  ON OV24.InventoryID = PT51.ServiceID
Where A01.IsStocked = 1 '+@sWhere+
'Group by PT53.RepairEmployeeID,A03.FullName, PT51.ServiceID, A01.InventoryName,P04.UnitName,ISNULL(OV24.EndQuantity,0)
Order by PT53.RepairEmployeeID,PT51.ServiceID'

EXEC(@sSQL1)

print @sSQL1

END		

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
