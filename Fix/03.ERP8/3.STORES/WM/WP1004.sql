IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP1004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP1004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-------- Created by		Huỳnh Thử.
-------- Date 27/03/2020. Load Dữ liệu tính chi phí thuê Pallet
-------- Date 17/04/2020. Update tính chi phí thuê Palle
-------- Date 14/04/2020. Update tính chi phí thuê Palle - Pallet có nhiều mặt hàng, xuất hết bao nhiều dòng thì đếm bấy nhiêu số lượng pallet xuất
----     Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
----     Modified by Huỳnh Thử on 27/10/2020 : Move từ WP2007 qua cho đồng bộ
----     Modified by Huỳnh Thử on 15/01/2021 : Move từ WP2007 qua cho đồng bộ -- Sum Lệch xuất kho. Xuất kho có thể kế thừa nhiều lệnh
----	 Modified by Hoàng Lâm on 27/10/2023 : Bổ sung gọi đích danh bảng khi load Dữ liệu tính chi phí thuê Pallet

CREATE PROCEDURE [dbo].[WP1004]  	
		@DivisionID AS nvarchar(50),
		@FromDate  as NVARCHAR(50)  ,
		@ToDate as NVARCHAR(50)	,	
		@ObjectID as NVARCHAR(50)

AS
declare 
	@sSQL1 AS nvarchar(MAX), 
	@sSQL1A AS nvarchar(MAX), 
	@sSQL1B AS nvarchar(MAX), 
	@sSQL2 AS nvarchar(MAX), 
	@sSQL3 AS nvarchar(MAX), 
	@sSQL4 AS nvarchar(MAX),
	@sSQL11 AS NVARCHAR(MAX),
	@sSQL3A AS NVARCHAR(MAX),
	@sSQL3B AS NVARCHAR(MAX),
	@FromWareHouseID  AS NVARCHAR(MAX),
	@ToWareHouseID AS NVARCHAR(MAX),
	@FromContractID AS NVARCHAR(MAX),
	@ToContractID AS NVARCHAR(MAX)

	seT @FromWareHouseID=N'VNBDG-DR-FL-EIM03'
	seT @ToWareHouseID=N'VNSGN-CH-RK-ANP'
	seT @FromContractID=N'CT20170000000049'
	seT @ToContractID=N'CT20170000000061'
----B1 : List danh sách tồn đầu


SET @sSQL1=N'
	-- BEGIN
	SELECT  COUNT(A.VoucherID) BeginPallet , ISNULL(SUM(A.BeginQuantity),0 ) AS BeginQuantity ,A.InventoryTypeID
	INTO #NHAP FROM(
	SELECT T01.VoucherID ,SUM(T02.ActualQuantity ) as BeginQuantity,T06.WareHouseID ,T06.ObjectID ,T99.InventoryTypeID
	FROM WT2002 T02 WITH (NOLOCK) 
	LEFT JOIN WT2001 T01 WITH (NOLOCK)  ON T01.VoucherID = T02.VoucherID 
	LEFT JOIN AT2006 T06  WITH (NOLOCK) ON T06.VoucherID = T02.ReVoucherID
	LEFT JOIN CT0199 T99  WITH (NOLOCK) ON T99.LocationID = T01.LocationID
	LEFT JOIN AT1020 WITH (NOLOCK) ON  AT1020.ObjectID = T06.ObjectID
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', T02.DivisionID) AND AT1302.InventoryID = T02.InventoryID
	WHERE T01.KindVoucherID =1
	 AND T01.IsRent = 1
	 --AND AT1020.ContractID BETWEEN '''+@FromContractID+''' AND'''+@ToContractID+'''
	 AND T01.VoucherDate < '''+@FromDate+'''

	GROUP BY T01.VoucherID,T06.ObjectID, T06.WareHouseID ,T99.InventoryTypeID
	)A
	WHERE A.ObjectID = '''+@ObjectID+'''
	--AND A.WareHouseID  BETWEEN '''+@FromWareHouseID+''' AND ''' +@ToWareHouseID+'''
	GROUP BY A.InventoryTypeID'

	SET @sSQL1A = '
	--- Xuất pallet
	select WT2002.RePVoucherID,WT2002.RePTransactionID,WT2002.VoucherID,WT2002.TransactionID, Sum(WT2002.ActualQuantity) as ActualQuantity, AT2006.VoucherDate INTO #AT2007 From AT2007 
	left join AT2006 on AT2006.VoucherID = AT2007.VoucherID
	Left join WT2002 on WT2002.VoucherID = AT2007.InheritVoucherID and WT2002.TransactionID = AT2007.InheritTransactionID
	left join WT2001 on WT2001.VoucherID = Wt2002.VoucherID
	where AT2006.KindVoucherID = 2
	and WT2001.KindVoucherID = 2
	AND AT2006.VoucherDate < '''+@FromDate+'''
	GRoup by WT2002.RePVoucherID,WT2002.RePTransactionID,WT2002.VoucherID,WT2002.TransactionID ,AT2006.VoucherDate 

	-- Lệnh xuất kho
	SELECT #AT2007.RePVoucherID ,#AT2007.RePTransactionID ,T99.InventoryTypeID
	,SUM(ISNULL((#AT2007.ActualQuantity),0))  AS ActualQuantity 
	INTO #TAN FROM #AT2007  WITH (NOLOCK)
	Left JOIN WT2002 T02 ON T02.RePVoucherID = #AT2007.RePVoucherID and  T02.RePTransactionID =  #AT2007.RePTransactionID  and T02.VoucherID= #AT2007.VoucherID and T02.TransactionID = #AT2007.TransactionID
	LEFT JOIN WT2001 T01 WITH (NOLOCK) ON  T01.VoucherID = T02.VoucherID
	LEFT JOIN AT1020 WITH (NOLOCK) ON  AT1020.ObjectID = T01.ObjectID
	LEFT JOIN AT2006 T06  WITH (NOLOCK) ON T06.VoucherID = T02.ReVoucherID
	LEFT JOIN AT1302  WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', T02.DivisionID) AND  AT1302.InventoryID = T02.InventoryID
	LEFT JOIN CT0199 T99  WITH (NOLOCK) ON T99.LocationID = T02.LocationID
	Left JOIN WT2002 T022 ON T022.VoucherID = #AT2007.RePVoucherID and  T022.TransactionID =  #AT2007.RePTransactionID 
	LEFT JOIN WT2001 T011 WITH (NOLOCK) ON  T011.VoucherID = #AT2007.RePVoucherID
	WHERE T01.KindVoucherID = 2
		AND T011.IsRent = 1
	AND T06.VoucherDate < '''+@FromDate+'''
	AND  T06.ObjectID =  '''+@ObjectID+'''
	--AND T01.WareHouseID  BETWEEN '''+@FromWareHouseID+''' AND ''' +@ToWareHouseID+'''
	--AND AT1020.ContractID BETWEEN '''+@FromContractID+''' AND'''+@ToContractID+'''
	GROUP BY #AT2007.RePVoucherID,#AT2007.RePTransactionID,T01.WareHouseID,T99.InventoryTypeID
			
	'
	SET @sSQL1B =N'

	--- Tồn pallet
	SELECT T01.VoucherID, ISNULL((T02.ActualQuantity),0) - SUM(ISNULL(TAM.ActualQuantity,0)) as BeginQuantity,T99.InventoryTypeID ,T06.ObjectID, 
	SUM(ISNULL(TAM.ActualQuantity,0)) AS EXQuantity
	INTO #TON FROM WT2002 T02 WITH (NOLOCK)
	LEFT JOIN WT2001 T01 WITH (NOLOCK) ON  T01.VoucherID = T02.VoucherID
	LEFT JOIN AT2006 T06  WITH (NOLOCK) ON T06.VoucherID = T02.ReVoucherID
	LEFT JOIN CT0199 T99  WITH (NOLOCK) ON T99.LocationID = T01.LocationID	
	LEFT JOIN #TAN TAM ON TAM.RePVoucherID = T01.VoucherID AND TAM.RePTransactionID = T02.TransactionID AND TAM.InventoryTypeID = T99.InventoryTypeID
	WHERE T01.KindVoucherID = 1 
	
	AND T06.ObjectID =  '''+@ObjectID+'''
	AND CONVERT(DATE,T01.VoucherDate,105) < '''+@FromDate+'''
	--AND T06.WareHouseID  BETWEEN '''+@FromWareHouseID+''' AND ''' +@ToWareHouseID+'''
	GROUP BY T02.VoucherID ,T06.ObjectID ,T99.InventoryTypeID,T01.VoucherID, T02.TransactionID ,T02.ActualQuantity'
	 

	
	-- Move bên WP2007 qua
	SET @sSQL11 =N'
	-- Tồn đầu kì
	SELECT SUM(A.BeginPallet) AS BeginPallet,SUM(A.BeginQuantity) AS BeginQuantity,InventoryTypeID FROM (
	--- Nhập
	SELECT   BeginPallet, BeginQuantity,InventoryTypeID FROM #NHAP
	UNION ALL
	-- Số lượng xuất
	SELECT 0 BeginPallet,-Isnull(SUM(EXQuantity),0) AS  BeginQuantity,InventoryTypeID  FROM #TON
	--WHERE  #TON.VoucherDate  < '''+@FromDate+'''
	GROUP BY InventoryTypeID,#TON.VoucherID
	UNION ALL
	-- pallet xuất
	SELECT   -1 AS BeginPallet,0 AS BeginQuantity,InventoryTypeID FROM #TON
	LEFT JOIN 
		(
			SELECT VoucherID,SUM(BeginQuantity) AS BeginQuantity  FROM #TON T
			GROUP BY T.VoucherID
		) G
	ON G.VoucherID = #TON.VoucherID
	WHERE G.BeginQuantity = 0 
	GROUP BY InventoryTypeID,#TON.VoucherID

	--SELECT  FORMAT(#TON.VoucherDateEX,''yyyy-MM-dd'') AS VoucherDate, -1 AS BeginPallet,0 AS BeginQuantity,InventoryTypeID FROM #TON
	--WHERE BeginQuantity = 0 AND FORMAT((SELECT TOP 1 VoucherDate FROM WT2001
	--	LEFT JOIN  WT2002 ON WT2002.VoucherID = WT2001.VoucherID
	--	WHERE RePVoucherID = #TON.VoucherID
	--	),''yyyy-MM-dd'') < '''+@FromDate+'''
	--GROUP BY InventoryTypeID,#TON.VoucherID
	) A
	GROUP BY A.InventoryTypeID

	'

---- NHÂP
SET @sSQL2=N'
	
	-- Nhập pallet
	SELECT COUNT(A.VoucherID) DebitPallet , ISNULL(SUM(A.DebitQuantity),0 ) AS DebitQuantity ,A.InventoryTypeID,
	format(A.VoucherDate ,''dd/MM/yyyy'') AS VoucherDate
	FROM(
	SELECT T01.VoucherID ,SUM(T02.ActualQuantity ) as DebitQuantity,T06.WareHouseID ,T06.ObjectID ,T99.InventoryTypeID,
	CONVERT(DATE,T01.VoucherDate,105) AS VoucherDate
	FROM WT2002 T02 WITH (NOLOCK) 
	LEFT JOIN WT2001 T01 WITH (NOLOCK)  ON T01.VoucherID = T02.VoucherID 
	LEFT JOIN AT2006 T06  WITH (NOLOCK) ON T06.VoucherID = T02.ReVoucherID
	LEFT JOIN CT0199 T99  WITH (NOLOCK) ON T99.LocationID = T01.LocationID
	--LEFT JOIN AT1020 WITH (NOLOCK) ON  AT1020.ObjectID = T06.ObjectID
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', T02.DivisionID) AND AT1302.InventoryID = T02.InventoryID
	WHERE T01.KindVoucherID = 1
		 AND T01.IsRent = 1
		 --AND AT1020.ContractID BETWEEN '''+@FromContractID+''' AND'''+@ToContractID+'''
	AND CONVERT(DATE,T01.VoucherDate,105) between  '''+@FromDate+'''AND'''+@ToDate+''' 
	GROUP BY T01.VoucherID,T06.ObjectID, T06.WareHouseID ,T99.InventoryTypeID,CONVERT(DATE,T01.VoucherDate,105)
	)A
	WHERE A.ObjectID = '''+@ObjectID+'''
	--AND A.WareHouseID  BETWEEN '''+@FromWareHouseID+''' AND ''' +@ToWareHouseID+'''
	GROUP BY A.InventoryTypeID,format(A.VoucherDate ,''dd/MM/yyyy'')
			'

---- XUẤT
SET @sSQL3=N'
	--- XUẤT ------------
	select WT2002.RePVoucherID,WT2002.RePTransactionID,WT2002.VoucherID,WT2002.TransactionID, Sum(WT2002.ActualQuantity) as ActualQuantity, AT2006.VoucherDate INTO #AT200702 From AT2007 
	left join AT2006 on AT2006.VoucherID = AT2007.VoucherID
	Left join WT2002 on WT2002.VoucherID = AT2007.InheritVoucherID and WT2002.TransactionID = AT2007.InheritTransactionID
	left join WT2001 on WT2001.VoucherID = Wt2002.VoucherID
	where AT2006.KindVoucherID = 2
	and WT2001.KindVoucherID = 2
	AND AT2006.VoucherDate  BETWEEN  '''+@FromDate+'''AND'''+@ToDate+'''
	GRoup by WT2002.RePVoucherID,WT2002.RePTransactionID,WT2002.VoucherID,WT2002.TransactionID ,AT2006.VoucherDate 

	SELECT #AT200702.RePVoucherID ,#AT200702.RePTransactionID ,#AT200702.VoucherID,#AT200702.TransactionID,T99.InventoryTypeID
	,ISNULL((#AT200702.ActualQuantity),0)  AS ActualQuantity ,CONVERT(DATE,#AT200702.VoucherDate,105) AS VoucherDate
	INTO #TAN11 FROM #AT200702  WITH (NOLOCK)
	Left JOIN WT2002 T02 ON T02.RePVoucherID = #AT200702.RePVoucherID and  T02.RePTransactionID =  #AT200702.RePTransactionID  and T02.VoucherID= #AT200702.VoucherID and T02.TransactionID = #AT200702.TransactionID
	LEFT JOIN WT2001 T01 WITH (NOLOCK) ON  T01.VoucherID = T02.VoucherID
	--LEFT JOIN AT1020 WITH (NOLOCK) ON  AT1020.ObjectID = T01.ObjectID
	LEFT JOIN AT2006 T06  WITH (NOLOCK) ON T06.VoucherID = T02.ReVoucherID
	LEFT JOIN AT1302  WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', T02.DivisionID) AND  AT1302.InventoryID = T02.InventoryID
	LEFT JOIN CT0199 T99  WITH (NOLOCK) ON T99.LocationID = T02.LocationID
	Left JOIN WT2002 T022 ON T022.VoucherID = #AT200702.RePVoucherID and  T022.TransactionID =  #AT200702.RePTransactionID 
	LEFT JOIN WT2001 T011 WITH (NOLOCK) ON  T011.VoucherID = #AT200702.RePVoucherID
	WHERE T01.KindVoucherID = 2
	   AND T011.IsRent = 1
	   --AND AT1020.ContractID BETWEEN '''+@FromContractID+''' AND'''+@ToContractID+'''
	   --AND T01.WareHouseID  BETWEEN '''+@FromWareHouseID+''' AND ''' +@ToWareHouseID+'''
	-- AND CONVERT(DATE,T01.VoucherDate,105) BETWEEN  '''+@FromDate+'''AND'''+@ToDate+'''
	AND T06.ObjectID = '''+@ObjectID+'''
	GROUP BY #AT200702.RePVoucherID,#AT200702.RePTransactionID,T01.WareHouseID,T99.InventoryTypeID,#AT200702.VoucherDate,#AT200702.ActualQuantity,T01.VoucherNo,#AT200702.VoucherID,#AT200702.TransactionID
	'
	SET  @sSQL3A =N'

	--- Số lượng xuất trước khoảng thời gian in 
	select WT2002.RePVoucherID,WT2002.RePTransactionID, Sum(AT2007.ActualQuantity) as ActualQuantity
	into #Xuat1 From AT2007 
	left join AT2006 on AT2006.VoucherID = AT2007.VoucherID
	Left join WT2002 on WT2002.VoucherID = AT2007.InheritVoucherID and WT2002.TransactionID = AT2007.InheritTransactionID
	left join WT2001 on WT2001.VoucherID = Wt2002.VoucherID
	where AT2006.KindVoucherID = 2
	and WT2001.KindVoucherID = 2
	AND AT2006.VoucherDate < '''+@FromDate+'''
	GRoup by WT2002.RePVoucherID,WT2002.RePTransactionID
	
	--- Tạo bảng tạm tính số lượng tồn cuối của từng dòng Pallet (Để đếm số Pallet thực xuất)
	SELECT T02.TransactionID , ISNULL((T02.ActualQuantity),0) - ISNULL((select ActualQuantity from #Xuat1  where RePTransactionID = T02.TransactionID),0) - SUM(ISNULL(TAM.ActualQuantity,0)) as CreditQuantity
	INTO #Xuat2 FROM WT2002 T02 WITH (NOLOCK)
	LEFT JOIN WT2001 T01 WITH (NOLOCK) ON  T01.VoucherID = T02.VoucherID
	LEFT JOIN AT2006 T06  WITH (NOLOCK) ON T06.VoucherID = T02.ReVoucherID
	LEFT JOIN CT0199 T99  WITH (NOLOCK) ON T99.LocationID = T01.LocationID
	LEFT JOIN #TAN11 TAM ON TAM.RePVoucherID = T01.VoucherID AND TAM.RePTransactionID = T02.TransactionID AND TAM.InventoryTypeID = T99.InventoryTypeID
	WHERE T01.KindVoucherID = 1 
	AND T06.ObjectID =  '''+@ObjectID+'''
	AND CONVERT(DATE,T01.VoucherDate,105) <= '''+@ToDate+'''
	--AND T06.WareHouseID  BETWEEN '''+@FromWareHouseID+''' AND ''' +@ToWareHouseID+'''
	GROUP BY  T02.TransactionID,T02.ActualQuantity'


--	SET  @sSQL3B =N'
--	--- Tồn
--	SELECT T01.VoucherID, ISNULL((T02.ActualQuantity),0) - SUM(ISNULL(TAM.ActualQuantity,0)) as CreditQuantity,T99.InventoryTypeID ,T06.ObjectID, 
--	SUM(ISNULL(TAM.ActualQuantity,0)) AS EXQuantity
--	,TAM.VoucherDate AS VoucherDateEX
--	INTO #TON11 FROM WT2002 T02 WITH (NOLOCK)
--	LEFT JOIN WT2001 T01 WITH (NOLOCK) ON  T01.VoucherID = T02.VoucherID
--	LEFT JOIN AT2006 T06  WITH (NOLOCK) ON T06.VoucherID = T02.ReVoucherID
--	LEFT JOIN CT0199 T99  WITH (NOLOCK) ON T99.LocationID = T01.LocationID
--	LEFT JOIN #TAN11 TAM ON TAM.RePVoucherID = T01.VoucherID AND TAM.RePTransactionID = T02.TransactionID AND TAM.InventoryTypeID = T99.InventoryTypeID
--	WHERE T01.KindVoucherID = 1 
--		AND T01.IsRent = 1
--	AND T06.ObjectID =  '''+@ObjectID+'''
--	AND CONVERT(DATE,T01.VoucherDate,105) <= '''+@ToDate+'''
--	GROUP BY   T02.VoucherID ,T06.ObjectID ,T99.InventoryTypeID,T01.VoucherID, T02.TransactionID,TAM.VoucherDate ,T02.ActualQuantity
	 
--	SELECT SUM(A.CreditPallet) AS CreditPallet,ISNULL(SUM(A.CreditQuantity) ,0) AS CreditQuantity,A.InventoryTypeID,A.VoucherDate FROM (
--	-- Số lượng xuất
--	SELECT FORMAT(#TON11.VoucherDateEX,''dd/MM/yyyy'') AS VoucherDate, 0 CreditPallet, SUM(EXQuantity) AS  CreditQuantity,InventoryTypeID FROM #TON11
--	GROUP BY InventoryTypeID,#TON11.VoucherID,#TON11.VoucherDateEX
--	UNION ALL
--	-- pallet xuất
--	SELECT FORMAT(G.VoucherDateEX,''dd/MM/yyyy'') AS VoucherDate, 1 CreditPallet, 0 AS  CreditQuantity,InventoryTypeID FROM #TON11
--	LEFT JOIN (SELECT VoucherID,SUM(CreditQuantity) AS CreditQuantity, (SELECT TOP 1  MAX(VoucherDateEX) FROM #TON11 WHERE VoucherID = T11.VoucherID GROUP BY VoucherID) AS VoucherDateEX FROM #TON11 T11 
--				GROUP BY T11.VoucherID) G
--				ON G.VoucherID = #TON11.VoucherID
--	WHERE G.CreditQuantity = 0
--	GROUP BY InventoryTypeID,#TON11.VoucherID,G.VoucherDateEX
--	) A
--	WHERE CONVERT(DATE,A.VoucherDate,105) BETWEEN  '''+@FromDate+'''AND'''+@ToDate+''' 
--	GROUP BY A.InventoryTypeID,A.VoucherDate 
--	HAVING ISNULL(A.VoucherDate ,'''') <> ''''
--'

-- Move từ WP2007 qua
SET  @sSQL3B =N'
	--- Tồn
	SELECT T01.VoucherID, ISNULL(#Xuat2.CreditQuantity,0) AS CreditQuantity,T99.InventoryTypeID ,T06.ObjectID, 
	SUM(ISNULL(TAM.ActualQuantity,0)) AS EXQuantity
	,TAM.VoucherDate AS VoucherDateEX
	INTO #TON11 FROM WT2002 T02 WITH (NOLOCK)
	LEFT JOIN WT2001 T01 WITH (NOLOCK) ON  T01.VoucherID = T02.VoucherID
	LEFT JOIN AT2006 T06  WITH (NOLOCK) ON T06.VoucherID = T02.ReVoucherID
	LEFT JOIN CT0199 T99  WITH (NOLOCK) ON T99.LocationID = T01.LocationID
	LEFT JOIN #Xuat2 WITH (NOLOCK) ON T02.TransactionID = #Xuat2.TransactionID
	LEFT JOIN #TAN11 TAM ON TAM.RePVoucherID = T01.VoucherID AND TAM.RePTransactionID = T02.TransactionID AND TAM.InventoryTypeID = T99.InventoryTypeID
	WHERE T01.KindVoucherID = 1 
	AND T06.ObjectID =  '''+@ObjectID+'''
	AND CONVERT(DATE,T01.VoucherDate,105) <= '''+@ToDate+'''
	--AND T06.WareHouseID  BETWEEN '''+@FromWareHouseID+''' AND ''' +@ToWareHouseID+'''
	GROUP BY   T02.VoucherID ,T06.ObjectID ,T99.InventoryTypeID,T01.VoucherID, T02.TransactionID,TAM.VoucherDate,#Xuat2.CreditQuantity
	 
	SELECT SUM(A.CreditPallet) AS CreditPallet,ISNULL(SUM(A.CreditQuantity) ,0) AS CreditQuantity,A.InventoryTypeID, A.VoucherDate FROM (
	-- Số lượng xuất
	SELECT FORMAT(#TON11.VoucherDateEX,''dd/MM/yyyy'') AS VoucherDate, 0 CreditPallet, SUM(EXQuantity) AS  CreditQuantity,InventoryTypeID FROM #TON11
	GROUP BY InventoryTypeID,#TON11.VoucherID,#TON11.VoucherDateEX
	UNION ALL
	-- pallet xuất
	SELECT FORMAT(MAX(G.VoucherDateEX),''dd/MM/yyyy'') AS VoucherDate, 1 CreditPallet, 0 AS  CreditQuantity,InventoryTypeID FROM #TON11
	LEFT JOIN (
				SELECT VoucherID,SUM(CreditQuantity) AS CreditQuantity, (SELECT TOP 1  MAX(VoucherDateEX) FROM #TON11 WHERE VoucherID = T11.VoucherID GROUP BY VoucherID) AS VoucherDateEX FROM #TON11 T11
				GROUP BY T11.VoucherID
				) G
	ON G.VoucherID = #TON11.VoucherID
	WHERE G.CreditQuantity = 0
	GROUP BY InventoryTypeID,#TON11.VoucherID,G.VoucherDateEX

	--SELECT FORMAT(#TON11.VoucherDateEX,''dd/MM/yyyy'') AS VoucherDate, 1 CreditPallet, 0 AS  CreditQuantity,InventoryTypeID FROM #TON11
	--WHERE CreditQuantity = 0
	--GROUP BY InventoryTypeID,#TON11.VoucherID,#TON11.VoucherDateEX

	) A
	WHERE CONVERT(DATE,A.VoucherDate,105) BETWEEN  '''+@FromDate+'''AND'''+@ToDate+''' 
	GROUP BY A.InventoryTypeID,A.VoucherDate 
	HAVING ISNULL(A.VoucherDate ,'''') <> ''''
'
SET @sSQL4 = '

	SELECT T20.BeginDate,T20.EndDate, T20.ContractID , ContractNo, T20.ObjectID,PriceID, T02.InventoryID As RoomID, T02.UnitID , T02.UnitPrice --, T31.InventoryID As WareHouseID
	FROM AT1020  T20 WITH (NOLOCK)
	LEFT JOIN OT1302 T02 WITH (NOLOCK) ON T02.ID = T20.PriceID
	LEFT JOIN OT1301 T01 WITH (NOLOCK) ON T01.ID = T02.ID
	LeFT JOIN AT1031 T31 WITH (NOLOCK) ON T31.ContractID = T20.ContractID
	left join AT1302 T302 WITH (NOLOCK) ON T302.DivisionID IN (''@@@'', T02.DivisionID) AND T302.InventoryID = T02.InventoryID
	left join AT1301 T301 WITH (NOLOCK) ON T301.InventoryTypeID = T302.InventoryTypeID
	WHERE T20.ObjectID = '''+@ObjectID+''' 
	AND   T301.IsRent = 1
'




PRINT @sSQL1
PRINT @sSQL1A
PRINT @sSQL1B
PRINT @sSQL11
PRINT @sSQL2
PRINT @sSQL3
PRINT @sSQL3A
PRINT @sSQL3B
PRINT @sSQL4
EXEC (@sSQL1+@sSQL1A+@sSQL1B+@sSQL11+@sSQL2 +@sSQL3 +@sSQL3A+@sSQL3B+ @sSQL4)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
