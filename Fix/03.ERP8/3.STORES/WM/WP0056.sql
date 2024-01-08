IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0056]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0056]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Tính phí thuê kho
-- <History>
---- Create   on 29/11/2022 by Nhật Thanh
---- Modified on 02/06/2023 by Nhựt Trường: [2023/05/IS/0173] - Chỉnh lại công thức tính phí thuê kho lấy theo đơn giá của bảng giá bậc thang thay vì đơn giá ở phiếu nhập kho (tháng đầu tiên).
---- Modified on 08/06/2023 by Nhựt Trường: Điều chỉnh lại một số hàm do phù hợp với các bản sql server có phiên bản thấp hơn sql server 2017.
---- Modified on 23/08/2023 by Nhật Thanh: Thay đổi cách tính để tính được những tháng không có phát sinh chứng từ
---- Modified on 28/09/2023 by Nhựt Trường: 2023/09/IS/0209, Lấy giá trị trung bình cho trường FirstMonthDays.
---- Modified on 22/11/2023 by Kiều Nga: [2023/11/IS/0047] Cải tiến tốc độ tính phí thuê kho (thêm cột NextMonthQuantity2 và lấy dữ liệu từ bảng WT0056 thay cho lấy từ bảng AT2007)

CREATE PROCEDURE [dbo].[WP0056] 	
				@DivisionID nvarchar(50),
				@TranMonth int,
				@TranYear int,
				@ObjectID nvarchar(100),
				@OrderID nvarchar(100)
AS
	DELETE FROM WT0056 WHERE ObjectID like @ObjectID and OrderId like @OrderID and TranMonth = @TranMonth and TranYear = @TranYear  -- Xóa dữ liệu cũ

	SELECT A06.TranMonth,A06.TranYear,A07.OrderID,A06.ObjectID,A06.VoucherNo, A06.VoucherID,A07.InventoryID,A07.ActualQuantity,
	ISNULL(C53.UnitPrice,0) AS UnitPrice,	
	A06.KindVoucherID,A06.VoucherDate, 
		Day(EOMONTH(A06.VoucherDate)) - DAY(A06.VoucherDate)+1 as FirstMonthDays,	
	(SELECT TOP 1 VoucherDate FROM AT2007 A071 LEFT JOIN AT2006 A06 on A06.VoucherID = A071.VoucherID WHERE A071.OrderID = A07.OrderID ORDER BY VoucherDate) as FirstVoucherDate
	,CASE WHEN A06.VoucherDate < convert(Datetime,concat('15/',@TranMonth,'/',@TranYear),103)
	THEN
		CASE WHEN KindvoucherID in (1,5,7,9)
		THEN 
			A07.ActualQuantity
		ELSE -A07.ActualQuantity
		END
	ELSE 0
	END AS InventoryQuantityNN
	,CASE WHEN KindvoucherID in (1,5,7,9)
		THEN 
			A07.ActualQuantity
		ELSE -A07.ActualQuantity
		END
	AS InventoryQuantity
	,CASE WHEN A06.VoucherDate < convert(Datetime,concat('15/',@TranMonth,'/',@TranYear),103) and  A06.VoucherDate >= convert(Datetime,concat('01/',@TranMonth,'/',@TranYear),103) and KindvoucherID in (2,4,6,8)
	THEN
		A07.ActualQuantity
	ELSE 0
	END AS InventoryQuantityHalf1
	,CASE WHEN A06.VoucherDate >= convert(Datetime,concat('15/',@TranMonth,'/',@TranYear),103) and  A06.TranMonth = @TranMonth  and KindvoucherID in (1,5,7,9)
	THEN
		A07.ActualQuantity
	ELSE 0
	END AS InventoryQuantityHalf2
	INTO #Temp1
	FROM AT2007 A07 WITH (NOLOCK)
	LEFT JOIN AT2006 A06 WITH (NOLOCK) on A06.VoucherID = A07.VoucherID
	LEFT JOIN OT2001 O01 WITH (NOLOCK) on A07.OrderID = O01.SOrderID
	LEFT JOIN OT2002 O02 WITH (NOLOCK) on O02.SOrderID = O01.SOrderID
	LEFT JOIN CT0153 C53 WITH (NOLOCK) on C53.ID = O01.PriceListID AND C53.InventoryID = O02.Ana04ID AND
							O02.OrderQuantity BETWEEN CONVERT(DECIMAL(28,8),LTRIM(RTRIM(SUBSTRING(C53.Value,1,CHARINDEX('-',C53.Value) - 1)))) AND CONVERT(DECIMAL(28,8),LTRIM(RTRIM(REPLACE(SUBSTRING(C53.Value,CHARINDEX('-',C53.Value) + 1,LEN(C53.Value)),'(%)',''))))
	WHERE O01.VoucherTypeID = 'PTK' and A07.OrderID like @OrderID and O01.ObjectID like @ObjectID
		 AND A06.TranMonth = @TranMonth and A06.Tranyear = @TranYear
	ORDER BY A06.VoucherDate,A06.Kindvoucherid, A06.VoucherID, A07.InventoryID

	select * from #Temp1

	UPDATE #Temp1
	SET #Temp1.InventoryQuantity = B.NewInventoryQuantity,
		#Temp1.InventoryQuantityNN = B.NewInventoryQuantityNN,
		#Temp1.InventoryQuantityHalf1 = B.NewInventoryQuantityHalf1,
		#Temp1.InventoryQuantityHalf2 = B.NewInventoryQuantityHalf2 
	FROM #Temp1
	left join(select orderid,inventoryid, SUM(InventoryQuantity) NewInventoryQuantity, SUM(InventoryQuantityNN) NewInventoryQuantityNN,SUM(InventoryQuantityHalf1) NewInventoryQuantityHalf1, SUM(InventoryQuantityHalf2) NewInventoryQuantityHalf2
    from #Temp1 group by orderid,inventoryid) B
	on #Temp1.OrderID = B.OrderID and #Temp1.inventoryid = B.inventoryid
	
	--select * from #Temp1

	SELECT #Temp1.TranMonth, #Temp1.TranYear, #Temp1.OrderID, #Temp1.ObjectID,#Temp1.InventoryID, #Temp1.UnitPrice,
	SUM(CASE WHEN KindvoucherID in (1,5,7,9) then #Temp1.ActualQuantity else 0 end) ActualQuantity,
	AVG(CASE WHEN KindvoucherID in (1,5,7,9) then #Temp1.FirstMonthDays else 0 end) as FirstMonthDays,
	SUM(CASE WHEN KindvoucherID in (1,5,7,9) then (#Temp1.UnitPrice*#Temp1.FirstMonthDays*#Temp1.ActualQuantity) / DAY(DATEADD(DD,-1,DATEADD(MM,DATEDIFF(MM,-1,VoucherDate),0))) else 0 end) as FirstMonthAmount,
	InventoryQuantity NextMonthQuantity,InventoryQuantityNN,InventoryQuantity*UnitPrice as NextMonthAmount, InventoryQuantityHalf1,InventoryQuantityHalf2,InventoryQuantityHalf1+InventoryQuantityHalf2 NextHalfMonthQuantity,
	(InventoryQuantityHalf1+InventoryQuantityHalf2)*UnitPrice/2 as NextHalfMonthAmount
	,FirstVoucherDate,VoucherDate, KindvoucherID
	INTO #Temp2
	FROM #Temp1
	WHERE  #Temp1.TranMonth = @TranMonth and #Temp1.Tranyear = @TranYear
	GROUP BY #Temp1.TranMonth, #Temp1.TranYear, #Temp1.OrderID, #Temp1.ObjectID,#Temp1.InventoryID, #Temp1.UnitPrice,FirstVoucherDate,InventoryQuantity,InventoryQuantityNN,InventoryQuantityHalf1,InventoryQuantityHalf2,VoucherDate, KindvoucherID

	--select 'temp2',* from #Temp2

	INSERT INTO WT0056(DivisionID, TranMonth, TranYear, VoucherDate, OrderID, ObjectID, InventoryID, UnitPrice, FirstMonthQuantity, FirstMonthDays, FirstMonthAmount, NextMonthQuantity, 
	NextMonthAmount, NextHalfMonthQuantity,NextHalfMonthAmount,NextMonthQuantity2)
	--Tháng đầu
	SELECT @DivisionID, @TranMonth, @TranYear, VoucherDate, OrderID, ObjectID, InventoryID, UnitPrice, ActualQuantity FirstMonthQuantity, FirstMonthDays, Round(FirstMonthAmount,0), 0 as NextMonthQuantity, 
	0 as NextMonthAmount, 0 as NextHalfMonthQuantity, 
	0 as NextHalfMonthAmount
	,NextMonthQuantity as NextMonthQuantity2
	FROM #Temp2
	WHERE @TranMonth=MONTH(FirstVoucherDate) and KindvoucherID in (1,5,7,9) and TranMonth = @TranMonth
	UNION 
	-- Tháng sau
	SELECT @DivisionID, @TranMonth, @TranYear, NULL as VoucherDate, T1.OrderID, T1.ObjectID, T1.InventoryID, T1.UnitPrice, 0 as FirstMonthQuantity, 0 as FirstMonthDays, 0 FirstMonthAmount
	,ISNULL(T1.NextMonthQuantity2,0) + ISNULL(T2.InventoryQuantityNN,0) as NextMonthQuantity
	,(ISNULL(T1.NextMonthQuantity2,0) + ISNULL(T2.InventoryQuantityNN,0))*T1.UnitPrice as NextMonthAmount
	,(ISNULL(T2.NextHalfMonthQuantity,0)) as NextHalfMonthQuantity
	, Round(ISNULL(T2.NextHalfMonthQuantity,0)*T1.UnitPrice/2,0) as NextHalfMonthAmount
	,(ISNULL(T1.NextMonthQuantity2,0) + ISNULL(T2.NextMonthQuantity,0)) as NextMonthQuantity2
	FROM WT0056 T1 WITH (NOLOCK)
	LEFT JOIN #Temp2 T2 WITH (NOLOCK) ON T1.OrderID = T2.OrderID AND T1.ObjectID = T2.ObjectID AND T1.InventoryID = T2.InventoryID AND T1.UnitPrice = T2.UnitPrice
	WHERE @TranMonth - 1 = T1.TranMonth AND @TranYear = T1.TranYear
	GROUP BY T1.TranMonth, T1.TranYear, T1.OrderID, T1.ObjectID,T1.InventoryID, T1.UnitPrice,T1.NextMonthQuantity2, 
	T1.NextMonthAmount, T1.NextHalfMonthAmount,T2.NextMonthQuantity,T2.NextHalfMonthQuantity,T2.InventoryQuantityNN
	ORDER BY OrderID , ObjectID, VoucherDate, InventoryID
	
	DROP TABLE [dbo].#Temp1
	DROP TABLE [dbo].#Temp2

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO