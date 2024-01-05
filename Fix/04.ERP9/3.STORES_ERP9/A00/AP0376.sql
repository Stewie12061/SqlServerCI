IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0376]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0376]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In báo cáo công việc hàng tháng cho khách hàng Bê tông Long An (CustomizeIndex = 80) tại ERP 9.0\T
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tiểu Mai on 22/08/2017
---- Modified by Trọng Kiên on 27/10/2020: Fix lỗi bảng #Temp khi chạy fix
---- Modified by ... on ...
-- <Example>
---- exec AP0376 'PC', 12, 2016, 'ANHPHU', 'VTL-000000042', '', ''

CREATE PROCEDURE [dbo].[AP0376]
				 	@DivisionID NVARCHAR(50) ,
					@Month INT,
					@Year INT,
					@FromObjectID NVARCHAR(50),
					@ToObjectID NVARCHAR(50),
					@FromAna03ID NVARCHAR(50),
					@ToAna03ID NVARCHAR(50) 
 AS


---- 1. Lấy kết quả thực hiện trong tháng in báo cáo
------- 1.1 Các hợp đồng ký kết trong tháng
SELECT A20.DivisionID, A20.ObjectID, A31.InventoryID, A31.UnitID, A31.S01ID, A31.S02ID, A31.S03ID, A31.S04ID, A31.S05ID, A31.S06ID, A31.S07ID, A31.S08ID, A31.S09ID, A31.S10ID,
	A31.S11ID, A31.S12ID, A31.S13ID, A31.S14ID, A31.S15ID, A31.S16ID, A31.S17ID, A31.S18ID, A31.S19ID, A31.S20ID,
	A20.ConRef01, A20.ConRef02, A20.ConRef03, A20.ConRef04, A20.ConRef05, A20.ConRef06, A20.ConRef07, A20.ConRef08, A20.ConRef09, A20.ConRef10,
	A20.ConRef11, A20.ConRef12, A20.ConRef13, A20.ConRef14, A20.ConRef15, A20.ConRef16, A20.ConRef17, A20.ConRef18, A20.ConRef19, A20.ConRef20,
	A20.ConvertedAmount, SUM(A31.OrderQuantity) AS OrderQuantity	
INTO #TempAP0376_1
FROM AT1020 A20 WITH (NOLOCK)
LEFT JOIN AT1021 A21 WITH (NOLOCK) ON A21.DivisionID = A20.DivisionID AND A21.ContractID = A20.ContractID
LEFT JOIN AT1031 A31 WITH (NOLOCK) ON A31.DivisionID = A21.DivisionID AND A31.ContractID = A21.ContractID 
WHERE A20.DivisionID = @DivisionID AND MONTH(A20.SignDate) = @Month AND YEAR(A20.SignDate) = @Year
	AND A20.ObjectID BETWEEN @FromObjectID AND @ToObjectID
GROUP BY A20.DivisionID, A20.ObjectID, A31.InventoryID, A31.UnitID, A31.S01ID, A31.S02ID, A31.S03ID, A31.S04ID, A31.S05ID, A31.S06ID, A31.S07ID, A31.S08ID, A31.S09ID, A31.S10ID,
	A31.S11ID, A31.S12ID, A31.S13ID, A31.S14ID, A31.S15ID, A31.S16ID, A31.S17ID, A31.S18ID, A31.S19ID, A31.S20ID,
	A20.ConRef01, A20.ConRef02, A20.ConRef03, A20.ConRef04, A20.ConRef05, A20.ConRef06, A20.ConRef07, A20.ConRef08, A20.ConRef09, A20.ConRef10,
	A20.ConRef11, A20.ConRef12, A20.ConRef13, A20.ConRef14, A20.ConRef15, A20.ConRef16, A20.ConRef17, A20.ConRef18, A20.ConRef19, A20.ConRef20,
	A20.ConvertedAmount
	
	
------- 1.2 Khối lượng nghiệm thu cọc/trụ
SELECT A90.DivisionID, A90.ObjectID, A32.I01ID, A32.I02ID, A90.InventoryID, O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
	O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
	A90.Ana01ID, A90.Ana02ID, A90.Ana03ID, A90.Ana04ID, A90.Ana05ID, A90.Ana06ID, A90.Ana07ID, A90.Ana08ID, A90.Ana09ID, A90.Ana10ID,
	SUM(A31.OrderQuantity) AS HD_OrderQuantity, SUM(A90.Quantity) AS NT_Quantity
INTO #TempAP0376_2
FROM AT9000 A90 WITH (NOLOCK)
LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O02.DivisionID = A90.DivisionID AND A90.OTransactionID = O02.TransactionID AND A90.OrderID = O02.SOrderID
LEFT JOIN AT8899 O99 WITH (NOLOCK) ON O99.DivisionID = A90.DivisionID AND O99.VoucherID = A90.VoucherID AND O99.TransactionID = A90.TransactionID
LEFT JOIN AT1031 A31 WITH (NOLOCK) ON O02.DivisionID = A31.DivisionID AND O02.InheritVoucherID = A31.ContractID AND O02.InheritTransactionID = A31.TransactionID
LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.InventoryID = A90.InventoryID
WHERE A90.DivisionID = @DivisionID AND A90.ObjectID BETWEEN @FromObjectID AND @ToObjectID 
	AND A90.Ana03ID BETWEEN @FromAna03ID AND @ToAna03ID
	AND TransactionTypeID = 'T04'
GROUP BY A90.DivisionID, A90.ObjectID, A32.I01ID, A32.I02ID, A90.InventoryID, O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
	O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
	A90.Ana01ID, A90.Ana02ID, A90.Ana03ID, A90.Ana04ID, A90.Ana05ID, A90.Ana06ID, A90.Ana07ID, A90.Ana08ID, A90.Ana09ID, A90.Ana10ID

---- 2. Lập hồ sơ thanh quyết toán cho các dự án
SELECT A20.DivisionID, A20.ObjectID, A20.ConvertedAmount, SUM(A21.PaymentAmount) AS PaymentAmountInMonth
INTO #TempAP0376_3
FROM AT1020 A20 WITH (NOLOCK)
LEFT JOIN AT1021 A21 WITH (NOLOCK) ON A21.DivisionID = A20.DivisionID AND A21.ContractID = A20.ContractID
WHERE A20.ObjectID BETWEEN @FromObjectID AND @ToObjectID
	AND A20.DivisionID = @DivisionID
	AND MONTH(A21.PaymentDate) = @Month AND YEAR(A21.PaymentDate) = @Year
GROUP BY A20.DivisionID, A20.ObjectID, A20.ConvertedAmount

---- 3. Thông tin theo dõi, giám sát tại các công trình
SELECT O02.DivisionID, O02.Ana03ID, A32.I01ID, A31.InventoryID, A31.UnitID,
	A31.S01ID, A31.S02ID, A31.S03ID, A31.S04ID, A31.S05ID, A31.S06ID, A31.S07ID, A31.S08ID, A31.S09ID, A31.S10ID,
	A31.S11ID, A31.S12ID, A31.S13ID, A31.S14ID, A31.S15ID, A31.S16ID, A31.S17ID, A31.S18ID, A31.S19ID, A31.S20ID,
	A20.ConRef01, A20.ConRef02, A20.ConRef03, A20.ConRef04, A20.ConRef05, A20.ConRef06, A20.ConRef07, A20.ConRef08, A20.ConRef09, A20.ConRef10,
	A20.ConRef11, A20.ConRef12, A20.ConRef13, A20.ConRef14, A20.ConRef15, A20.ConRef16, A20.ConRef17, A20.ConRef18, A20.ConRef19, A20.ConRef20
INTO #TempAP0376_4
FROM OT2002 O02 WITH (NOLOCK)
LEFT JOIN AT1031 A31 WITH (NOLOCK) ON O02.DivisionID = A31.DivisionID AND O02.InheritVoucherID = A31.ContractID AND O02.InheritTransactionID = A31.TransactionID
LEFT JOIN AT1020 A20 WITH (NOLOCK) ON A20.DivisionID = A31.DivisionID AND A20.ContractID = A31.ContractID
LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.InventoryID = O02.InventoryID
WHERE A20.ObjectID BETWEEN @FromObjectID AND @ToObjectID
	AND A20.DivisionID = @DivisionID
	AND O02.Ana03ID BETWEEN @FromAna03ID AND @ToAna03ID

---- 4. Lấy doanh thu thực hiện
SELECT A99.DivisionID, SUM(A99.ConvertedAmount) AS KH_ConvertedAmount 
INTO #TempAP0376_5
FROM AT9090 A99 WITH (NOLOCK)
WHERE A99.DivisionID = @DivisionID
	AND A99.ObjectID BETWEEN @FromObjectID AND @ToObjectID
	AND A99.TranYear = @Year
	AND A99.CreditAccountID LIKE '511%'
GROUP BY A99.DivisionID

SELECT DivisionID, SUM(ConvertedAmount) AS THBefore_ConvertedAmount  
INTO #TempAP0376_6
FROM AT9000 WITH (NOLOCK)
WHERE DivisionID = @DivisionID AND ObjectID BETWEEN @FromObjectID AND @ToObjectID
	AND  (TransactionTypeID = 'T04' OR (TransactionID IN ('T01', 'T21') AND ISNULL(IsAdvancePayment,0) <> 0))
	AND TranYear = @Year AND TranMonth < @Month
GROUP BY DivisionID
 
SELECT DivisionID, SUM(ConvertedAmount) AS TH_ConvertedAmount  
INTO #TempAP0376_7
FROM AT9000 WITH (NOLOCK)
WHERE DivisionID = @DivisionID AND ObjectID BETWEEN @FromObjectID AND @ToObjectID
	AND  (TransactionTypeID = 'T04' OR (TransactionID IN ('T01', 'T21') AND ISNULL(IsAdvancePayment,0) <> 0))
	AND TranMonth + TranYear * 100 = @Month + @Year * 100
GROUP BY DivisionID


SELECT T1.*, A02.ObjectName FROM #TempAP0376_1 T1
LEFT JOIN AT1202 A02 ON T1.ObjectID = A02.ObjectID

SELECT T2.*, A02.ObjectName, A11.AnaName AS Ana03Name, I01.AnaName AS I01Name, I02.AnaName AS I02Name
FROM #TempAP0376_2 T2
LEFT JOIN AT1202 A02 ON T2.ObjectID = A02.ObjectID
LEFT JOIN AT1011 A11 ON T2.Ana03ID = A11.AnaID AND A11.AnaTypeID = 'A03'
LEFT JOIN AT1015 I01 ON I01.AnaID = T2.I01ID AND I01.AnaTypeID = 'I01'
LEFT JOIN AT1015 I02 ON I02.AnaID = T2.I02ID AND I02.AnaTypeID = 'I02'

SELECT T3.*, A02.ObjectName FROM #TempAP0376_3 T3
LEFT JOIN AT1202 A02 ON T3.ObjectID = A02.ObjectID

SELECT T4.*, A11.AnaName AS Ana03Name, A15.AnaName AS I01Name FROM #TempAP0376_4 T4
LEFT JOIN AT1011 A11 ON T4.Ana03ID = A11.AnaID AND A11.AnaTypeID = 'A03'
LEFT JOIN AT1015 A15 ON A15.AnaID = T4.I01ID AND A15.AnaTypeID = 'I01'

SELECT T5.KH_ConvertedAmount, T6.THBefore_ConvertedAmount, T7.TH_ConvertedAmount 
FROM #TempAP0376_5 T5
LEFT JOIN #TempAP0376_6 T6 ON T5.DivisionID = T6.DivisionID
LEFT JOIN #TempAP0376_7 T7 ON T5.DivisionID = T7.DivisionID	


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
