IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP6017]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP6017]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Created by :Cao Thị Phượng, date: 02/08/2016
---purpose: In bao cao Tong hop tinh hinh tồn kho giao hang
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung

--EXEC OP6017 'HT', '','2016-05-02 00:00:00.000','2016-05-05 00:00:00.000', '3C-700A','YN', '152','156','10047-B.2*AP','10329-A.3*7',1,''

CREATE PROCEDURE OP6017
(
	@DivisionID NVARCHAR(50),
	@DivisionIDList NVARCHAR(250),
	@FromDate  DATETIME,
	@ToDate    DATETIME,
	@FromInventoryID nvarchar(50),
	@ToInventoryID nvarchar(50),
	@FromWareHouseID nvarchar(50),
	@ToWareHouseID nvarchar(50),
	@FromObjectID nvarchar(50),
	@ToObjectID nvarchar(50),
	@IsCondition TINYINT,
	@UserID VARCHAR(50)
)				
AS
DECLARE @sSQL NVARCHAR(4000),
@sWhere NVARCHAR(4000),
@sWhere1 NVARCHAR(4000)

SET @sWhere = ''

IF ISNULL(@DivisionID,'')!='' 
	SET @sWhere1 =  @DivisionID
ELSE 
	SET @sWhere1 =  @DivisionIDList
	
IF ISNULL(@FromObjectID,'') !='' 
	SET @sWhere= @sWhere +'AND (isnull(OT2001.ObjectID,'''') between '''+@FromObjectID+''' AND '''+@ToObjectID+''')	'
	--Biến bảng @OV2801 thay thế view động OV2801
	Declare @OV2801 table (
							DivisionID varchar(50),
							InventoryID varchar(50),
							WareHouseID varchar(50),
							SQuantity decimal(28,8),
							PQuantity decimal(28,8))			
	Insert into @OV2801 (DivisionID, InventoryID, WareHouseID, SQuantity, PQuantity)
	SELECT DivisionID, InventoryID, WareHouseID, 
					SUM(CASE WHEN TypeID <> 'PO' AND Finish <> 1 THEN OrderQuantity - ActualQuantity ELSE 0 END) SQuantity,
					SUM(CASE WHEN TypeID = 'PO' AND Finish <> 1  THEN OrderQuantity - ActualQuantity ELSE 0 END) PQuantity
	FROM OV2800 WITH (NOLOCK)
	GROUP BY DivisionID, InventoryID, WareHouseID 

	--Biến bảng @OV2401 thay thế view động OV2401
	Declare @OV2401 table (
							DivisionID varchar(50),
							WareHouseID varchar(50),
							InventoryID varchar(50),
							DebitQuantity decimal(28,8),
							CreditQuantity decimal(28,8),
							ENDQuantity decimal(28,8))	
	Insert into @OV2401 (DivisionID, WareHouseID, InventoryID, DebitQuantity, CreditQuantity, ENDQuantity)
	Select x.DivisionID, x.WareHouseID, x.InventoryID, Sum(x.DebitQuantity), sum(x.CreditQuantity), Sum(x.DebitQuantity)-sum(x.CreditQuantity)
	From (
				Select 	AT2017.DivisionID,  WareHouseID,  InventoryID, Isnull(ActualQuantity, 0) as DebitQuantity, 0 as CreditQuantity
				From AT2017  WITH (NOLOCK) inner join AT2016  WITH (NOLOCK) on AT2016.VoucherID = AT2017.VoucherID
				Union All  -- Nhap kho
				Select 	AT2008.DivisionID, WareHouseID, InventoryID, Isnull(DebitQuantity,0) as DebitQuantity, 0 as CreditQuantity
				From AT2008  WITH (NOLOCK)
				Union All  -- Xuat kho
				Select 	AT2008.DivisionID, WareHouseID, InventoryID, 0 as DebitQuantity, Isnull(CreditQuantity,0) as CreditQuantity
				From AT2008  WITH (NOLOCK)
				) x
	Where x.DivisionID = @sWhere1 and (x.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID) AND (x.WareHouseID BETWEEN @FromWareHouseID AND @ToWareHouseID)
	Group by x.DivisionID,  x.WareHouseID, x.InventoryID
	HAVING Sum(x.DebitQuantity)-sum(x.CreditQuantity) <> 0
		
	--Bảng tạm #OV2506 thay thế view động OV2506		
	SELECT ISNULL(V00.DivisionID, V01.DivisionID) DivisionID,
			ISNULL(V00.WareHouseID,V01.WareHouseID) WareHouseID,
			ISNULL(V00.InventoryID,V01.InventoryID) InventoryID,
			CASE WHEN V01.ENDQuantity = 0 THEN NULL ELSE V01.ENDQuantity END  ENDQuantity,
			CASE WHEN V00.SQuantity = 0 THEN NULL ELSE V00.SQuantity END SQuantity,
			CASE WHEN V00.PQuantity = 0 THEN NULL ELSE V00.PQuantity END PQuantity,
			ISNULL(V01.ENDQuantity,0) - ISNULL(V00.SQuantity, 0) +  ISNULL(V00.PQuantity, 0) ReadyQuantity,
			CASE WHEN ISNULL(T01.MaxQuantity,0) = 0 THEN NULL ELSE T01.MaxQuantity END MaxQuantity, 
		CASE WHEN ISNULL(T01.MinQuantity, 0) = 0 THEN NULL ELSE T01.MinQuantity END MinQuantity
		into #OV2506
	FROM @OV2801 V00 FULL JOIN @OV2401 V01 ON V00.WareHouseID = V01.WareHouseID AND V00.InventoryID = V01.InventoryID AND V00.DivisionID = V01.DivisionID
						LEFT JOIN AT1314 T01  WITH (NOLOCK) ON T01.InventoryID = ISNULL(V00.InventoryID, V01.InventoryID) 
												AND ISNULL (V00.WareHouseID, V01.WareHouseID) LIKE T01.WareHouseID AND T01.DivisionID = V00.DivisionID
	WHERE (ISNULL(V00.InventoryID, V01.InventoryID) BETWEEN @FromInventoryID AND @ToInventoryID)
		AND(ISNULL(EndQuantity,0) <> 0 OR ISNULL(SQuantity,0) <> 0 OR PQuantity <> 0) 
		AND ISNULL(V00.DivisionID, V01.DivisionID)  = @sWhere1
IF @Iscondition =0 		
SET @sSQL = '
	SELECT M.DivisionID, z.ShipDate, ObjectID,
	 M.WareHouseID, M.InventoryID, A.InventoryName, M.EndQuantity, M.SQuantity, M.PQuantity, M.ReadyQuantity, z.OrderQuantity,null as TransferQuantity,
	 M.MaxQuantity, M.MinQuantity
	FROM #OV2506 M WITH (NOLOCK) 
	Left join AT1302 A WITH (NOLOCK) on A.DivisionID IN (''@@@'', M.DivisionID) AND M.InventoryID = A.InventoryID
	left join 
	(select DivisionID, ShipDate, InventoryID,WareHouseID, sum(OrderQuantity) as OrderQuantity, ObjectID from 
		(SELECT OT2002.DivisionID, Convert(Nvarchar(10),OT2001.ShipDate,103) as ShipDate, OT2002.InventoryID, sum(OrderQuantity) AS OrderQuantity,null as ObjectID,
		CASE WHEN isnull(WareHouseID, '''') !='''' THEN WareHouseID ELSE 
			(SELECT c.WareHouseID FROM CRMT00000 AS c WHERE c.DivisionID ='''+@sWhere1+''') END AS WareHouseID
		 FROM OT2001  WITH (NOLOCK)
		INNER JOIN OT2002  WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2002.SOrderID = OT2001.SOrderID 
		 WHERE (CONVERT(VARCHAR(10),OT2001.ShipDate,112) BETWEEN '''+CONVERT(VARCHAR(20),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(20),@ToDate,112)+''')
		 GROUP BY OT2002.DivisionID, Convert(Nvarchar(10),OT2001.ShipDate,103), OT2002.InventoryID, OT2002.WareHouseID)c
	 Group by DivisionID, ShipDate, InventoryID,WareHouseID, ObjectID
	)z on z.DivisionID =M.DivisionID AND z.InventoryID =M.InventoryID
	where isnull(ShipDate,'''') != ''''
	ORDER BY M.DivisionID,z.ShipDate,  M.InventoryID, M.WareHouseID
	'
IF @IsCondition =1 
	SET @sSQL = '
	SELECT M.DivisionID, z.ShipDate, z.ObjectID,
	 M.WareHouseID, M.InventoryID, A.InventoryName, M.EndQuantity, M.SQuantity, M.PQuantity, M.ReadyQuantity, z.OrderQuantity, null as TransferQuantity,
	 M.MaxQuantity, M.MinQuantity
	FROM #OV2506 M WITH (NOLOCK) 
	Left join AT1302 A WITH (NOLOCK) on A.DivisionID IN (''@@@'', M.DivisionID) AND M.InventoryID = A.InventoryID
	left join 
	(select DivisionID, ShipDate, InventoryID,WareHouseID, sum(OrderQuantity) as OrderQuantity, ObjectID from 
		(SELECT OT2002.DivisionID, Convert(Nvarchar(10),OT2001.ShipDate,103) as ShipDate, OT2002.InventoryID, sum(OrderQuantity) AS OrderQuantity, OT2001.ObjectID,
		CASE WHEN isnull(WareHouseID, '''') !='''' THEN WareHouseID ELSE 
			(SELECT c.WareHouseID FROM CRMT00000 AS c WHERE c.DivisionID ='''+@sWhere1+''') END AS WareHouseID
		 FROM OT2001  WITH (NOLOCK)
		INNER JOIN OT2002  WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2002.SOrderID = OT2001.SOrderID 
		 WHERE (CONVERT(VARCHAR(10),OT2001.ShipDate,112) BETWEEN '''+CONVERT(VARCHAR(20),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(20),@ToDate,112)+''')
		  '+@sWhere+'
		 GROUP BY OT2002.DivisionID, Convert(Nvarchar(10),OT2001.ShipDate,103), OT2002.InventoryID, OT2002.WareHouseID, OT2001.ObjectID)c
	 Group by DivisionID, ShipDate, InventoryID,WareHouseID, ObjectID
	)z on z.DivisionID =M.DivisionID AND z.InventoryID =M.InventoryID 
	where isnull(ShipDate,'''') != ''''
	ORDER BY M.DivisionID,z.ShipDate, M.InventoryID, M.WareHouseID, Z.ObjectID
	'	
EXEC (@sSQL)		
Print (@sSQL)
