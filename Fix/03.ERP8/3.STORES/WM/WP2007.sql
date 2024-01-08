IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP2007]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP2007]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-------- Created by		Khánh Đoan.
-------- Date 12/12/2007. In bao cao theo Palllet
-------- Date 05/03/2020. Update Huỳnh Thử - Lấy thêm thông tin khối (Mã Phân Tích 08)
-------- Date 18/03/2020. Update Huỳnh Thử - optimize code
-------- Date 30/03/2020. Update Huỳnh Thử - Ngày xuất lấy từ ngày xuất kho
-------- Date 07/04/2020. Update Huỳnh Thử - Update Tính chi phí
-------- Date 14/04/2020. Update tính chi phí thuê Palle - Pallet có nhiều mặt hàng, xuất hết bao nhiều dòng thì đếm bấy nhiêu số lượng pallet xuất
-------- Date 12/06/2020. Update -- Lấy số lượng xuất trước khoảng thời gian Print
							     -- Lấy tổng số lượng xuất của pallet xuất gán vào Danh sách xuất để đến số Pallet xuẩt
-------- Date 24/08/2020. Update tính chi phí.
-------- Date 24/08/2020. Group thêm Inventory lấy đúng số trọng lượng của từng mặt hàng.
-------- Date 27/08/2020. Sửa điều kiện join ObjectID từ Wt2001 sang AT2006
-------- Date 24/09/2020. Lấy ngày xuất là AT2006
-------- Date 29/09/2020. Sửa lại cách lấy trọng lượng và where Theo T06.ObjectID
----     Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
----     Modified by Huỳnh Thử on 27/10/2020 : Tính chi phí không cần where theo Kho
----     Modified by Huỳnh Thử on 17/12/2020 : Sửa lại công thức tính trọng lượng
----     Modified by Huỳnh Thử on 22/12/2020 : Bỏ group Inventory
----     Modified by Huỳnh Thử on 15/01/2021 : Sum Lệch xuất kho. Xuất kho có thể kế thừa nhiều lệnh
----     Modified by Xuân Nguyên on 02/03/2022 :[2022/02/IS/0055] Sửa cách lấy lệnh xuất kho
----     Modified by Xuân Nguyên on 22/03/2022 :[2022/03/IS/0225] Bỏ sum ActualQuantity khi lấy DebitQuantity
----     Modified by Xuân Nguyên on 22/03/2022 :[2022/03/IS/0225] - Bỏ sum ActualQuantity khi lấy số lượng nhập tồn
----     Modified by Hương Nhung on 26/10/2023 :[2023/10/IS/0234] - Fix lỗi Ambiguous column name

CREATE PROCEDURE [dbo].[WP2007]  	
		@DivisionID AS nvarchar(50),
		@FromDate  as NVARCHAR(50)  ,
		@ToDate as NVARCHAR(50)	,	
		@ObjectID as NVARCHAR(50),
		@FromRoomID as NVARCHAR(50),
		@ToRoomID as NVARCHAR(50),
		@FromWareHouseID as NVARCHAR(50), 
		@ToWareHouseID as NVARCHAR(50),
		@FromContractID as NVARCHAR(50),
		@ToContractID  as NVARCHAR(50),
		@Mode TINYINT -- 0 là tính chi phí, 1 là print báo cáo
AS
declare 
	@sSQL1 AS nvarchar(MAX), 
	@sSQL1A AS nvarchar(MAX), 
	@sSQL1B AS nvarchar(MAX), 
	@sSQL2 AS nvarchar(MAX), 
	@sSQL3 AS nvarchar(MAX), 
	@sSQL3A AS NVARCHAR(MAX),
	@sSQL3B AS NVARCHAR(MAX),
	@sSQL4 AS nvarchar(MAX),
	@sSQL11 AS NVARCHAR(MAX)
	
	
----B1 : List danh sách tồn đầu


SET @sSQL1=N'
	-- BEGIN
	SELECT  COUNT(A.VoucherID) BeginPallet , ISNULL(SUM(A.BeginQuantity),0 ) AS BeginQuantity,A.InventoryTypeID,ISNULL(SUM(A.BeginWeight),0) AS BeginWeight, ISNULL(SUM(A.BeginGradeLevel),0) BeginGradeLevel
	INTO #NHAP FROM(
	SELECT T01.VoucherID ,(T02.ActualQuantity ) as BeginQuantity, T06.WareHouseID ,T06.ObjectID ,T99.InventoryTypeID,
	SUM(CONVERT(DECIMAL(18, 8),  CASE WHEN ISNULL(T07.Ana04ID,'''') <> '''' THEN T07.Ana04ID ELSE AT1302.I07ID END) * IsNULL(T02.ActualQuantity,0)) as BeginWeight,
	SUM(CONVERT(DECIMAL(18, 8), AT1302.I08ID) * IsNULL(T02.ActualQuantity,0)) as BeginGradeLevel
	FROM WT2002 T02 WITH (NOLOCK) 
	LEFT JOIN WT2001 T01 WITH (NOLOCK)  ON T01.VoucherID = T02.VoucherID 
	LEFT JOIN AT2006 T06  WITH (NOLOCK) ON T06.VoucherID = T02.ReVoucherID
	LEFT JOIN AT2007 T07  WITH (NOLOCK) ON T07.VoucherID = T06.VoucherID AND T07.TransactionID = T02.ReTransactionID
	LEFT JOIN CT0199 T99  WITH (NOLOCK) ON T99.LocationID = T01.LocationID
	'+CASE WHEN @Mode = 0 THEN +'LEFT JOIN AT1020 WITH (NOLOCK) ON  AT1020.ObjectID = T06.ObjectID ' ELSE '' END +'
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', T02.DivisionID) AND AT1302.InventoryID = T02.InventoryID
	WHERE T01.KindVoucherID =1
	'+CASE WHEN @Mode = 0 THEN +'AND AT1020.ContractID BETWEEN '''+@FromContractID+''' AND'''+@ToContractID+'''' ELSE '' END +'
	 AND T01.VoucherDate < '''+@FromDate+'''

	GROUP BY T01.VoucherID,T06.ObjectID, T06.WareHouseID ,T99.InventoryTypeID,T02.ActualQuantity
	)A
	WHERE A.ObjectID = '''+@ObjectID+'''
	'+CASE WHEN @Mode = 1 THEN +'AND A.InventoryTypeID  BETWEEN '''+@FromRoomID+''' AND'''+@ToRoomID+''' AND A.WareHouseID  BETWEEN '''+@FromWareHouseID+''' AND ''' +@ToWareHouseID+'''' ELSE '' END +'  
	

	GROUP BY A.InventoryTypeID'

	SET @sSQL1A = '
	--- Xuất pallet
	select AT2006.VoucherDate,WT2002.RePVoucherID,WT2002.RePTransactionID,WT2002.VoucherID,WT2002.TransactionID, Sum(AT2007.ActualQuantity) as ActualQuantity,
	SUM(CONVERT(DECIMAL(18, 8),
	CASE WHEN ISNULL(AT2007.Ana04ID,'''') <> '''' THEN AT2007.Ana04ID ELSE AT1302.I07ID END) * IsNULL(AT2007.ActualQuantity,0)) as BeginWeight,
	SUM(CONVERT(DECIMAL(18, 8), AT1302.I08ID) * IsNULL(AT2007.ActualQuantity,0)) as BeginGradeLevel
	INTO #AT2007 From AT2007 
	left join AT2006 on AT2006.VoucherID = AT2007.VoucherID
	Left join WT2002 on WT2002.VoucherID = AT2007.InheritVoucherID and WT2002.TransactionID = AT2007.InheritTransactionID
	left join WT2001 on WT2001.VoucherID = Wt2002.VoucherID
	LEFT JOIN AT1302  ON AT1302.DivisionID IN (''@@@'', AT2007.DivisionID) AND AT1302.InventoryID = AT2007.InventoryID
	where AT2006.KindVoucherID = 2
	and WT2001.KindVoucherID = 2
	AND AT2006.VoucherDate < '''+@FromDate+'''
	GRoup by AT2006.VoucherDate,WT2002.RePVoucherID,WT2002.RePTransactionID,WT2002.VoucherID,WT2002.TransactionID 

	-- Lệnh xuất kho
	SELECT #AT2007.RePVoucherID ,#AT2007.RePTransactionID, T99.InventoryTypeID,
	 (#AT2007.BeginWeight) AS BeginWeight,
	 (#AT2007.BeginGradeLevel) AS BeginGradeLevel,
	(ISNULL((#AT2007.ActualQuantity),0)) AS ActualQuantity 
	INTO #TAN FROM #AT2007  WITH (NOLOCK)
	Left JOIN WT2002 T02 ON T02.RePVoucherID = #AT2007.RePVoucherID and  T02.RePTransactionID =  #AT2007.RePTransactionID  and T02.VoucherID= #AT2007.VoucherID and T02.TransactionID = #AT2007.TransactionID
	LEFT JOIN WT2001 T01 WITH (NOLOCK) ON  T01.VoucherID = T02.VoucherID
	'+CASE WHEN @Mode = 0 THEN +'LEFT JOIN AT1020 WITH (NOLOCK) ON  AT1020.ObjectID = T01.ObjectID ' ELSE '' END +'
	LEFT JOIN AT2006 T06  WITH (NOLOCK) ON T06.VoucherID = T02.ReVoucherID
	LEFT JOIN AT2007 T07  WITH (NOLOCK) ON T07.inheritTransactionID = T02.TransactionID
	LEFT JOIN AT2006 T06XK  WITH (NOLOCK) ON T06XK.VoucherID = T07.VoucherID	
	LEFT JOIN AT1302  WITH (NOLOCK) ON  AT1302.DivisionID IN (''@@@'', T02.DivisionID) AND AT1302.InventoryID = T02.InventoryID
	LEFT JOIN CT0199 T99  WITH (NOLOCK) ON T99.LocationID = T02.LocationID
	WHERE T01.KindVoucherID = 2
	AND T06XK.VoucherDate < '''+@FromDate+'''
	AND  T06.ObjectID =  '''+@ObjectID+'''
	'+CASE WHEN @Mode = 1 THEN +'AND T99.InventoryTypeID  BETWEEN '''+@FromRoomID+''' AND'''+@ToRoomID+''' AND T01.WareHouseID  BETWEEN '''+@FromWareHouseID+''' AND ''' +@ToWareHouseID+'''' ELSE '' END +'   
	'+CASE WHEN @Mode = 0 THEN +'AND AT1020.ContractID BETWEEN '''+@FromContractID+''' AND'''+@ToContractID+'''' ELSE '' END +'
	GROUP BY #AT2007.RePVoucherID,#AT2007.RePTransactionID,T01.WareHouseID,T99.InventoryTypeID, #AT2007.ActualQuantity,#AT2007.BeginWeight,#AT2007.BeginGradeLevel,T02.VoucherID,T02.TransactionID
	'
	SET @sSQL1B =N'

	--- Tồn pallet
	SELECT T01.VoucherID, ISNULL((T02.ActualQuantity),0) - SUM(ISNULL(TAM.ActualQuantity,0)) as BeginQuantity,T99.InventoryTypeID ,T06.ObjectID 
	,( SUM(ISNULL(TAM.BeginWeight,0)))  AS BeginWeight
	,( SUM(ISNULL(TAM.BeginGradeLevel,0)))  AS BeginGradeLevel,
	SUM(ISNULL(TAM.ActualQuantity,0)) AS EXQuantity
	
	INTO #TON FROM WT2002 T02 WITH (NOLOCK)
	LEFT JOIN WT2001 T01 WITH (NOLOCK) ON  T01.VoucherID = T02.VoucherID
	LEFT JOIN AT2006 T06  WITH (NOLOCK) ON T06.VoucherID = T02.ReVoucherID
	LEFT JOIN CT0199 T99  WITH (NOLOCK) ON T99.LocationID = T01.LocationID
	LEFT JOIN #TAN TAM ON TAM.RePVoucherID = T01.VoucherID AND TAM.RePTransactionID = T02.TransactionID AND TAM.InventoryTypeID = T99.InventoryTypeID
	WHERE T01.KindVoucherID = 1 
	
	AND T06.ObjectID =  '''+@ObjectID+'''
	'+CASE WHEN @Mode = 1 THEN +'AND T99.InventoryTypeID  BETWEEN '''+@FromRoomID+''' AND'''+@ToRoomID+''' AND T06.WareHouseID  BETWEEN '''+@FromWareHouseID+''' AND ''' +@ToWareHouseID+'''' ELSE '' END +'  
	AND CONVERT(DATE,T01.VoucherDate,105) < '''+@FromDate+'''
	GROUP BY   T02.VoucherID ,T06.ObjectID ,T99.InventoryTypeID,T01.VoucherID, T02.TransactionID,T02.ActualQuantity'
	 
	SET @sSQL11 =N'
	-- Tồn đầu kì
	SELECT SUM(A.BeginPallet) AS BeginPallet,SUM(A.BeginQuantity) AS BeginQuantity,InventoryTypeID,SUM(A.BeginWeight) AS BeginWeight ,SUM(A.BeginGradeLevel) AS BeginGradeLevel FROM (
	--- Nhập
	SELECT   BeginPallet, BeginQuantity,InventoryTypeID,BeginWeight,BeginGradeLevel FROM #NHAP
	UNION ALL
	-- Số lượng xuất
	SELECT 0 BeginPallet,-Isnull((EXQuantity),0) AS  BeginQuantity,InventoryTypeID,-Isnull((BeginWeight),0) AS BeginWeight ,- Isnull((BeginGradeLevel),0) AS BeginGradeLevel  FROM #TON
	--WHERE  #TON.VoucherDate  < '''+@FromDate+'''
	GROUP BY InventoryTypeID,#TON.VoucherID,EXQuantity,BeginWeight,BeginGradeLevel
	UNION ALL
	-- pallet xuất
	SELECT   -1 AS BeginPallet,0 AS BeginQuantity,InventoryTypeID,0 AS BeginWeight,0 AS BeginGradeLevel FROM #TON
	LEFT JOIN 
		(
			SELECT VoucherID,SUM(BeginQuantity) AS BeginQuantity  FROM #TON T
			GROUP BY T.VoucherID
		) G
	ON G.VoucherID = #TON.VoucherID
	WHERE G.BeginQuantity = 0 
	GROUP BY InventoryTypeID,#TON.VoucherID

	--SELECT  FORMAT(#TON.VoucherDateEX,''yyyy-MM-dd'') AS VoucherDate, -1 AS BeginPallet,0 AS BeginQuantity,InventoryTypeID,0 AS BeginWeight,0 AS BeginGradeLevel FROM #TON
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
	SELECT COUNT(A.VoucherID) DebitPallet , ISNULL(SUM(A.DebitQuantity),0 ) AS DebitQuantity ,A.InventoryTypeID,ISNULL(SUM(A.DebitWeight),0) AS DebitWeight, ISNULL(SUM(A.DebitGradeLevel),0) DebitGradeLevel,
	format(A.VoucherDate ,''dd/MM/yyyy'') AS VoucherDate
	FROM(
	SELECT T01.VoucherID ,(T02.ActualQuantity ) as DebitQuantity,T06.WareHouseID ,T06.ObjectID ,T99.InventoryTypeID,
	SUM(CONVERT(DECIMAL(18, 8),  CASE WHEN ISNULL(T07.Ana04ID,'''') <> '''' THEN T07.Ana04ID ELSE AT1302.I07ID END) * IsNULL(T02.ActualQuantity,0)) as DebitWeight,
	SUM(CONVERT(DECIMAL(18, 8), AT1302.I08ID)) as DebitGradeLevel,
	CONVERT(DATE,T01.VoucherDate,105) AS VoucherDate
	FROM WT2002 T02 WITH (NOLOCK) 
	LEFT JOIN WT2001 T01 WITH (NOLOCK)  ON T01.VoucherID = T02.VoucherID 
	LEFT JOIN AT2006 T06  WITH (NOLOCK) ON T06.VoucherID = T02.ReVoucherID
	LEFT JOIN AT2007 T07  WITH (NOLOCK) ON T06.VoucherID = T07.VoucherID AND T07.TransactionID = t02.ReTransactionID
	LEFT JOIN CT0199 T99  WITH (NOLOCK) ON T99.LocationID = T01.LocationID
	'+CASE WHEN @Mode = 0 THEN +'LEFT JOIN AT1020 WITH (NOLOCK) ON  AT1020.ObjectID = T06.ObjectID ' ELSE '' END +'
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', T02.DivisionID) AND AT1302.InventoryID = T02.InventoryID
	WHERE T01.KindVoucherID = 1
	'+CASE WHEN @Mode = 0 THEN +'AND AT1020.ContractID BETWEEN '''+@FromContractID+''' AND'''+@ToContractID+'''' ELSE '' END +'
	AND CONVERT(DATE,T01.VoucherDate,105) between  '''+@FromDate+'''AND'''+@ToDate+''' 
	GROUP BY T01.VoucherID,T06.ObjectID, T06.WareHouseID ,T99.InventoryTypeID,CONVERT(DATE,T01.VoucherDate,105),T02.ActualQuantity
	)A
	WHERE A.ObjectID = '''+@ObjectID+'''
	'+CASE WHEN @Mode = 1 THEN +'AND A.InventoryTypeID  BETWEEN '''+@FromRoomID+''' AND'''+@ToRoomID+''' AND A.WareHouseID  BETWEEN '''+@FromWareHouseID+''' AND ''' +@ToWareHouseID+'''' ELSE '' END +'  
	GROUP BY A.InventoryTypeID,format(A.VoucherDate ,''dd/MM/yyyy'')
			'

---- XUẤT
SET @sSQL3=N'
	--- XUẤT ------------
	select WT2002.RePVoucherID,WT2002.RePTransactionID,WT2002.VoucherID,WT2002.TransactionID, Sum(AT2007.ActualQuantity) as ActualQuantity, AT2006.VoucherDate,
	SUM(CONVERT(DECIMAL(18, 8),CASE WHEN ISNULL(AT2007.Ana04ID,'''') <> '''' THEN AT2007.Ana04ID ELSE AT1302.I07ID END) * IsNULL(AT2007.ActualQuantity,0)) as CreditWeight,
	SUM(CONVERT(DECIMAL(18, 8), AT1302.I08ID) * IsNULL(AT2007.ActualQuantity,0)) as CreditGradeLevel
	INTO #AT200702 
	FROM AT2007 
	left join AT2006 on AT2006.VoucherID = AT2007.VoucherID
	Left join WT2002 on WT2002.VoucherID = AT2007.InheritVoucherID and WT2002.TransactionID = AT2007.InheritTransactionID
	left join WT2001 on WT2001.VoucherID = Wt2002.VoucherID
	LEFT JOIN AT1302  ON AT1302.DivisionID IN (''@@@'', AT2007.DivisionID) AND AT1302.InventoryID = AT2007.InventoryID
	where AT2006.KindVoucherID = 2
	and WT2001.KindVoucherID = 2
	AND AT2006.VoucherDate  BETWEEN  '''+@FromDate+'''AND'''+@ToDate+'''
	GRoup by WT2002.RePVoucherID,WT2002.RePTransactionID,WT2002.VoucherID,WT2002.TransactionID ,AT2006.VoucherDate 

	SELECT #AT200702.RePVoucherID ,#AT200702.RePTransactionID ,#AT200702.VoucherID,#AT200702.TransactionID,T99.InventoryTypeID,
	#AT200702.CreditWeight,
	#AT200702.CreditGradeLevel
	,ISNULL((#AT200702.ActualQuantity),0)  AS ActualQuantity ,CONVERT(DATE,#AT200702.VoucherDate,105) AS VoucherDate
	INTO #TAN11 FROM #AT200702  WITH (NOLOCK)
	Left JOIN WT2002 T02 ON T02.RePVoucherID = #AT200702.RePVoucherID and  T02.RePTransactionID =  #AT200702.RePTransactionID  and T02.VoucherID= #AT200702.VoucherID and T02.TransactionID = #AT200702.TransactionID
	LEFT JOIN WT2001 T01 WITH (NOLOCK) ON  T01.VoucherID = T02.VoucherID
	'+CASE WHEN @Mode = 0 THEN +'LEFT JOIN AT1020 WITH (NOLOCK) ON  AT1020.ObjectID = T01.ObjectID ' ELSE '' END +'
	LEFT JOIN AT2006 T06  WITH (NOLOCK) ON T06.VoucherID = T02.ReVoucherID
	LEFT JOIN AT1302  WITH (NOLOCK) ON  AT1302.DivisionID IN (''@@@'', T02.DivisionID) AND AT1302.InventoryID = T02.InventoryID
	LEFT JOIN CT0199 T99  WITH (NOLOCK) ON T99.LocationID = T02.LocationID
	WHERE T01.KindVoucherID = 2
	AND CONVERT(DATE,#AT200702.VoucherDate,105) BETWEEN  '''+@FromDate+'''AND'''+@ToDate+'''
	AND T06.ObjectID = '''+@ObjectID+'''
	'+CASE WHEN @Mode = 1 THEN +'AND T99.InventoryTypeID  BETWEEN '''+@FromRoomID+''' AND'''+@ToRoomID+''' AND T01.WareHouseID  BETWEEN '''+@FromWareHouseID+''' AND ''' +@ToWareHouseID+'''' ELSE '' END +'  
	'+CASE WHEN @Mode = 0 THEN +'AND AT1020.ContractID BETWEEN '''+@FromContractID+''' AND'''+@ToContractID+'''' ELSE '' END +' 
	GROUP BY #AT200702.RePVoucherID,#AT200702.RePTransactionID,T01.WareHouseID,T99.InventoryTypeID,#AT200702.VoucherDate,#AT200702.ActualQuantity,
	#AT200702.CreditWeight,
	#AT200702.CreditGradeLevel,
	AT1302.I07ID,AT1302.I08ID,T01.VoucherNo,#AT200702.VoucherID,#AT200702.TransactionID
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
	'+CASE WHEN @Mode = 1 THEN +'AND T99.InventoryTypeID  BETWEEN '''+@FromRoomID+''' AND'''+@ToRoomID+''' AND T06.WareHouseID  BETWEEN '''+@FromWareHouseID+''' AND ''' +@ToWareHouseID+'''' ELSE '' END +'  
	
	GROUP BY  T02.TransactionID,T02.ActualQuantity'

	SET  @sSQL3B =N'
	--- Tồn
	SELECT T01.VoucherID, ISNULL(#Xuat2.CreditQuantity,0) AS CreditQuantity,T99.InventoryTypeID ,T06.ObjectID 
	,( SUM(ISNULL(TAM.CreditWeight,0)))  AS CreditWeight
	,( SUM(ISNULL(TAM.CreditGradeLevel,0)))  AS CreditGradeLevel,
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
	'+CASE WHEN @Mode = 1 THEN +'AND T99.InventoryTypeID  BETWEEN '''+@FromRoomID+''' AND'''+@ToRoomID+''' AND T06.WareHouseID  BETWEEN '''+@FromWareHouseID+''' AND ''' +@ToWareHouseID+'''' ELSE '' END +'  
	GROUP BY   T02.VoucherID ,T06.ObjectID ,T99.InventoryTypeID,T01.VoucherID, T02.TransactionID,TAM.VoucherDate,#Xuat2.CreditQuantity
	 
	SELECT SUM(A.CreditPallet) AS CreditPallet,ISNULL(SUM(A.CreditQuantity) ,0) AS CreditQuantity,A.InventoryTypeID,SUM(A.CreditWeight) AS CreditWeight ,SUM(A.CreditGradeLevel) AS CreditGradeLevel,A.VoucherDate FROM (
	-- Số lượng xuất
	SELECT FORMAT(#TON11.VoucherDateEX,''dd/MM/yyyy'') AS VoucherDate, 0 CreditPallet, SUM(EXQuantity) AS  CreditQuantity,InventoryTypeID,ISNULL(SUM(CreditWeight),0) AS CreditWeight, ISNULL(SUM(CreditGradeLevel),0) AS  CreditGradeLevel FROM #TON11
	GROUP BY InventoryTypeID,#TON11.VoucherID,#TON11.VoucherDateEX
	UNION ALL
	-- pallet xuất
	SELECT FORMAT(MAX(G.VoucherDateEX),''dd/MM/yyyy'') AS VoucherDate, 1 CreditPallet, 0 AS  CreditQuantity,InventoryTypeID,0 AS CreditWeight, 0 AS  CreditGradeLevel FROM #TON11
	LEFT JOIN (
				SELECT VoucherID,SUM(CreditQuantity) AS CreditQuantity, (SELECT TOP 1  MAX(VoucherDateEX) FROM #TON11 WHERE VoucherID = T11.VoucherID GROUP BY VoucherID) AS VoucherDateEX FROM #TON11 T11
				GROUP BY T11.VoucherID
				) G
	ON G.VoucherID = #TON11.VoucherID
	WHERE G.CreditQuantity = 0
	GROUP BY InventoryTypeID,#TON11.VoucherID,G.VoucherDateEX

	--SELECT FORMAT(#TON11.VoucherDateEX,''dd/MM/yyyy'') AS VoucherDate, 1 CreditPallet, 0 AS  CreditQuantity,InventoryTypeID,0 AS CreditWeight, 0 AS  CreditGradeLevel FROM #TON11
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
	WHERE T20.ObjectID = '''+@ObjectID+''' 
	--AND   T31.InventoryID BetWeen '''+@FromWareHouseID+'''  AND '''+@ToWareHouseID+'''
	--AND   T02.InventoryID  BETWEEN '''+@FromRoomID+'''AND ''' +@ToRoomID+'''
	--AND   T20.ContractID BETWEEN '''+@FromContractID+''' AND '''+@ToContractID+'''
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
