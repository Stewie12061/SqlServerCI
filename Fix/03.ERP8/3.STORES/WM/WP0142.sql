IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0142]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0142]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Báo cáo đối chiếu số lượng tồn kho quản lý tại công ty so với tại các cửa hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 22/08/2017 by Thị Phượng  
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
 
-- <Example> EXEC WP0142 'MSA', 'KCH','KCTY', 'ALIADTPA3800TD', 'XTHWTSNQ02DC', 9, 2017, 9,2017,'2017-08-01', '2017-10-30', 1, 'PHUONG'
---- 
 
CREATE PROCEDURE [dbo].[WP0142]
(
	@DivisionID       AS NVARCHAR(50),
    @FromWareHouseID     AS NVARCHAR(50),
    @ToWareHouseID       AS NVARCHAR(50),
    @FromInventoryID  AS NVARCHAR(50),
    @ToInventoryID    AS NVARCHAR(50),
    @FromMonth        AS INT,
    @FromYear         AS INT,
    @ToMonth          AS INT,
    @ToYear           AS INT,
    @FromDate         AS DATETIME,
    @ToDate           AS DATETIME,
    @IsDate           AS TINYINT,
	@UserID			  AS NVARCHAR(50)
)
as 
DECLARE @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang MINH SANG khong (CustomerName = 79)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
IF @CustomerName = 79 --- Customize  MINH SANG
Begin
DECLARE	@sSQLSelect AS nvarchar(max) ,
				@sWhere AS nvarchar(max) ,
				@sWhere1 AS nvarchar(max) ,
				@sWhere2 AS nvarchar(max) ,
				@sSQLBegin AS nvarchar(max), 
				@sSQLImport AS nvarchar(max),
				@sSQLExport AS nvarchar(max),
				@sSQLResult AS nvarchar(max),
				@sSQLFinal AS nvarchar(max),
				@FromMonthYearText NVARCHAR(20), 
				@ToMonthYearText NVARCHAR(20), 
				@FromDateText NVARCHAR(20), 
				@ToDateText NVARCHAR(20)

IF @IsDate = 0 
Begin
	SET @sWhere = 'AND TranMonth + TranYear * 100 <= '+STR(@FromMonth + @FromYear * 100)+''
	SET @sWhere1 = 'AND (TranMonth + TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+') '
END
IF @IsDate = 1 
BEGIN
	SET @sWhere = 'AND CONVERT(VARCHAR, VoucherDate,112) <='+CONVERT(VARCHAR,@FromDate,112)+' '
	SET @sWhere1 = 'AND (CONVERT(VARCHAR, VoucherDate,112) BETWEEN '+CONVERT(VARCHAR,@FromDate,112)+' AND '+CONVERT(VARCHAR,@ToDate,112)+' )'
END

				
SET @sSQLSelect = ' --So luong ton kho ben ERP
Select M.DivisionID, M.InventoryID, M.InventoryName, M.WareHouseID , M.WareHouseName, (SUM(BeginQuantity) + SUM(DebitQuantity) - SUM(CreditQuantity) ) as EndQuantity
Into #Sodu From( 
	Select 	AV7000.DivisionID,	AV7000.InventoryID, AV7000.InventoryName,  AV7000.WareHouseID, AT1303.WareHouseName, 
				Sum(AV7000.SignQuantity) as BeginQuantity, 0 as DebitQuantity, 0 as CreditQuantity
				From AV7000
				inner join AT1303 With (NOLOCK) on AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = AV7000.WareHouseID
				Where AV7000.DivisionID = ''' + @DivisionID + ''' and
				(AV7000.WareHouseID between N''' + @FromWareHouseID + ''' and N''' + @ToWareHouseID + ''')  And
				(AV7000.InventoryID between N''' + @FromInventoryID + ''' and N''' + @ToInventoryID + ''')  '+@sWhere+'
				Group by  AV7000.DivisionID,	AV7000.InventoryID, AV7000.InventoryName,  AV7000.WareHouseID, AT1303.WareHouseName
				Union ALL
	Select 	AV7000.DivisionID, AV7000.InventoryID, AT1302.InventoryName, AV7000.WareHouseID, AT1303.WareHouseName,	
				0 as BeginQuantity,
				Sum(Case when D_C = ''D'' then isnull(AV7000.ActualQuantity,0) else 0 end) as DebitQuantity,
				Sum(Case when D_C = ''C'' then isnull(AV7000.ActualQuantity,0) else 0 end) as CreditQuantity
				From AV7000 
				inner join AT1302 on AT1302.DivisionID IN (''@@@'', AV7000.DivisionID) AND AT1302.InventoryID = AV7000.InventoryID
				inner join AT1303 on  AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = AV7000.WareHouseID
				Where 	AV7000.DivisionID =''' + @DivisionID + ''' and
				(AV7000.InventoryID between N''' + @FromInventoryID + ''' and N''' + @ToInventoryID + ''') and
				(AV7000.WareHouseID between N''' + @FromWareHouseID + ''' and N''' + @ToWareHouseID + ''') and
				AV7000.D_C in (''D'', ''C'')  '+@sWhere1+'
				Group by  AV7000.DivisionID, AV7000.InventoryID, AT1302.InventoryName, AV7000.WareHouseID, AT1303.WareHouseName
	) M
	Group by  M.DivisionID, M.InventoryID, M.InventoryName, M.WareHouseID, M.WareHouseName
				'
				
SET @sSQLBegin = N'
   SELECT DivisionID, ShopID ,InventoryID, InventoryName,WareHouseID , 0 as BeginQuantity , ExQuantity,  ImQuantity
       Into #POSP00711             FROM (
                     Select A.DivisionID, A.InventoryTypeID, A.InventoryID, A.InventoryName, A.UnitID, B.WareHouseID, A.ShopID
                      ,Isnull((Select Sum(Quantity) 
                         From POST9000 
                         Where DivisionID = A.DivisionID and ShopID =A.ShopID and InventoryID = A.InventoryID 
                          and (VoucherTypeID in (Select VoucherType01 From POST0004 T Inner Join POST0010 S ON T.ShopID =S.ShopID where  S.WarehouseID between N''' + @FromWareHouseID + ''' and N''' + @ToWareHouseID + '''  ) 
						 Or VoucherTypeID in (Select VoucherType13 From POST0004 T Inner Join POST0010 S ON T.ShopID =S.ShopID where  S.WarehouseID between N''' + @FromWareHouseID + ''' and N''' + @ToWareHouseID + '''  ) )
                          '+@sWhere1+' and DeleteFlg = 0),0) as ImQuantity
                       ,
                       Isnull((Select Sum(Quantity) 
                         From POST9000 
                         Where DivisionID = A.DivisionID and InventoryID = A.InventoryID  and ShopID =A.ShopID
                          and VoucherTypeID in (Select VoucherType09 From POST0004 T Inner Join POST0010 S ON T.ShopID =S.ShopID where  S.WarehouseID between N''' + @FromWareHouseID + ''' and N''' + @ToWareHouseID + '''  )  
                          '+@sWhere1+' and DeleteFlg = 0),0) as ExQuantity
                       , ISNULL(P.FromMovingQuantity,0) as FromMovingQuantity
                       , ISNULL(P.ToMovingQuantity,0) as ToMovingQuantity
                    From POST0030 A 
					LEFT JOIN POST0010 B ON A.ShopID =B.ShopID 
					Left join 
                        (
                         Select x.DivisionID,  x.InventoryID, x.UnitID, x.WareHouseID, sum(x.FromMovingQuantity) as FromMovingQuantity, sum(x.ToMovingQuantity) as ToMovingQuantity
                         From
                          (Select M.DivisionID,  D.InventoryID, D.UnitID, M.WareHouseID
                            , Sum(Isnull(D.ActualQuantity,0) - isnull(D.ReceiveQuantity,0)) as FromMovingQuantity
                            , 0 as ToMovingQuantity
                          from WT0095 M inner join WT0096 D on M.DivisionID = D.DivisionID and M.VoucherID = D.VoucherID
                          Where M.DivisionID = ''' + @DivisionID + ''' and M.IsCheck = 1 and (D.Status = 0 OR D.Status is null)
                          Group by M.DivisionID, D.InventoryID, D.UnitID, M.WareHouseID
                          union all
                          Select  M.DivisionID, D.InventoryID, D.UnitID, M.WareHouseID2 as WareHouseID
                            , 0 as FromMovingQuantity
                            , Sum(Isnull(D.ActualQuantity,0) - isnull(D.ReceiveQuantity,0)) as ToMovingQuantity
                          from WT0095 M inner join WT0096 D on M.DivisionID = D.DivisionID and M.VoucherID = D.VoucherID
                          Where M.DivisionID = ''' + @DivisionID + ''' and M.IsCheck = 1 and (D.Status = 0 OR D.Status is null)
                          Group by M.DivisionID, D.InventoryID, D.UnitID, M.WareHouseID2 
                          ) x
                         Group by x.DivisionID, x.InventoryID, x.UnitID, x.WareHouseID
    
                         ) P on P.DivisionID = A.DivisionID and P.InventoryID = A.InventoryID and P.UnitID = A.UnitID and P.WareHouseID = B.WareHouseID
                    where A.DivisionID = ''' + @DivisionID + '''  and A.InventoryID between N''' + @FromInventoryID + ''' and N''' + @ToInventoryID + '''
					and B.WareHouseID between N''' + @FromWareHouseID + ''' and N''' + @ToWareHouseID + '''
) E '
		--Lấy kết quả
		SET @sSQLResult = N'
		Select R.DivisionID,  R.InventoryID, N''ZZZZZZZZZZ'' AS WareHouseID, ''POS'' as Type, 1 as Orders, Sum(Isnull(R.BeginQuantity,0)) + Sum(Isnull(R.ImQuantity,0)) - Sum(Isnull(R.ExQuantity,0)) as POSEndQuantity
							 Into #tem1 From #POSP00711 R
							 Group by R.DivisionID, R.InventoryID
		Select M.DivisionID, M.InventoryID, N''ZZZZZZZZZZ'' WareHouseID , ''ERP'' as Type, 2 as Orders, Sum(Isnull(M.EndQuantity,0))  as ERPEndQuantity
		Into #tem2 FROM #Sodu M	
		Group by  M.DivisionID, M.InventoryID

		Select D.DivisionID , D.WareHouseID, Case WHEN D.WareHouseID =''ZZZZZZZZZZ'' THEN N''Tổng cộng'' else B.WareHouseName end AS WareHouseName,
		D.InventoryID, A.InventoryName, D.Type , isnull(D.EndQuantity, 0) EndQuantity, D.Orders
		From 
		 (Select R.DivisionID,  R.InventoryID, R.WareHouseID, ''POS'' as Type, 1 as Orders, Sum(Isnull(R.BeginQuantity,0)) + Sum(Isnull(R.ImQuantity,0)) - Sum(Isnull(R.ExQuantity,0)) as EndQuantity
							 From #POSP00711 R
							 Group by R.DivisionID, R.WareHouseID, R.InventoryID
		  Union ALL
		  Select M.DivisionID, M.InventoryID, M.WareHouseID , ''ERP'' as Type, 2 as Orders, Sum(Isnull(M.EndQuantity,0))  as EndQuantity
		  FROM #Sodu M	
		  Group by  M.DivisionID, M.InventoryID, M.WareHouseID
		  Union ALL
		  Select M.DivisionID, M.InventoryID, M.WareHouseID , N''Chênh lệch'' as Type, 3 as Orders, ((Sum(Isnull(R.BeginQuantity,0)) + Sum(isnull(R.ImQuantity,0)) - Sum(Isnull(R.ExQuantity,0))) - Isnull(M.EndQuantity,0) )
		  FROM #Sodu M
		  LEft join #POSP00711 R on M.DivisionID = R.DivisionID and M.InventoryID= R.InventoryID and M.WareHouseID = R.WareHouseID
		  Group by  M.DivisionID, M.InventoryID, M.WareHouseID,R.DivisionID, R.WareHouseID, R.InventoryID, M.EndQuantity
		  Union ALL
		  Select R.DivisionID,  R.InventoryID, N''ZZZZZZZZZZ'' AS WareHouseID, ''POS'' as Type, 1 as Orders, Sum(Isnull(R.BeginQuantity,0)) + Sum(Isnull(R.ImQuantity,0)) - Sum(Isnull(R.ExQuantity,0)) as EndQuantity
							 From #POSP00711 R
							 Group by R.DivisionID, R.InventoryID
		  Union ALL
		  Select M.DivisionID, M.InventoryID, N''ZZZZZZZZZZ'' WareHouseID , ''ERP'' as Type, 2 as Orders, Sum(Isnull(M.EndQuantity,0))  as EndQuantity
		  FROM #Sodu M	
		  Group by  M.DivisionID, M.InventoryID
		  Union ALL
		  Select M.DivisionID, M.InventoryID, M.WareHouseID , N''Chênh lệch'' as Type, 3 as Orders, M.POSEndQuantity - R.ERPEndQuantity as EndQuantity
		  FROM #tem1 M
		  LEft join #tem2 R on M.DivisionID = R.DivisionID and M.InventoryID= R.InventoryID and M.WareHouseID =R.WareHouseID
			)D 
		Left join AT1302 A on A.DivisionID IN (''@@@'', D.DivisionID) AND A.InventoryID = D.InventoryID
		Left join AT1303 B on  B.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND B.WareHouseID = D.WareHouseID
		Order by D.DivisionID, D.WareHouseID,  D.InventoryID, D.Orders
			'
--SET @sSQLFinal =
--N'	DECLARE @columns NVARCHAR(MAX),
--		@sql NVARCHAR(MAX);
--			SET @columns = N'''';		
--			SELECT @columns += N'', '' + quotename(WareHouseID)
--			FROM (SELECT WareHouseID FROM #Sodu group by WareHouseID ) AS x Order by WareHouseID;
	
--		DECLARE @columns1 NVARCHAR(MAX)			
--			SET @columns1 = N'''';		
--			SELECT @columns1 += N'', '' + quotename(POSWareHouseID)
--			FROM (SELECT POSWareHouseID FROM #Temp03 group by POSWareHouseID ) AS x Order by POSWareHouseID;
--	SET @sql = N''
--		Select * Into #Temp02  	
--		FROM #Sodu M	
--		Pivot (sum(M.EndQuantity) for M.WareHouseID  IN (''+STUFF(REPLACE(@columns, '', ['', '',[''), 1, 1, '''')+ '')) as P

--		Select * Into #Temp04
--		FROM #Temp03 M	
--		Pivot (sum(M.POSEndQuantity) for M.POSWareHouseID  IN (''+ STUFF(REPLACE(@columns1, '', ['', '',[''), 1, 1, '''')+ ''))as A
--											 ''
--	EXEC sp_executesql @sql
--	Print @sql

--'

print @sSQLSelect
print @sSQLBegin
print @sSQLImport
print @sSQLExport
print @sSQLResult
print @sSQLFinal

		EXEC (@sSQLSelect +@sSQLBegin+ @sSQLImport + @sSQLExport + @sSQLResult)
ENd
