IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0186]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0186]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Hải Long on 14/09/2016: In báo cáo kế hoạch sản xuất MF0183 (AN PHÁT)
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.


CREATE PROCEDURE [dbo].[MP0186]
    @DivisionID nvarchar(50),  
    @FromMonth AS int,
    @ToMonth AS int,
    @FromYear AS int,
    @ToYear AS int,
    @FromDate AS datetime,
    @ToDate AS DATETIME,
    @IsDate AS TINYINT,
    @FromObjectID nvarchar(50),
	@ToObjectID nvarchar(50),
	@FromInventoryID nvarchar(50),
	@ToInventoryID nvarchar(50),
	@FromVoucherNo nvarchar(50),
	@ToVoucherNo nvarchar(50)
	
AS
SET NOCOUNT ON  


DECLARE @VoucherDate DATETIME
DECLARE @VoucherID NVARCHAR(100)
CREATE TABLE #MP0186 
(
	AnaName01 NVARCHAR(100),
	AnaName02 NVARCHAR(100),
	Ana01ID NVARCHAR(100),
	Ana02ID NVARCHAR(100),
	ObjectName2 NVARCHAR(100),
	InventoryID NVARCHAR(100),
	InventoryName NVARCHAR(100),
	PO NVARCHAR(100),
	Quantity DECIMAL(28,8),
	StandardName01 NVARCHAR(100),
	UnitPrice DECIMAL(28,8),
	SyncDate datetime,
	DeliverDate datetime,
	NextQuantity DECIMAL(28,8),
	Notes NVARCHAR(100),
	TranMonth INT,
	TranYear INT,
	Quantity01 DECIMAL(28,8),
	Quantity02 DECIMAL(28,8),
	Quantity03 DECIMAL(28,8),
	Quantity04 DECIMAL(28,8),
	Quantity05 DECIMAL(28,8),
	Quantity06 DECIMAL(28,8),
	Quantity07 DECIMAL(28,8),
	Quantity08 DECIMAL(28,8),
	Quantity09 DECIMAL(28,8),
	Quantity10 DECIMAL(28,8),
	Quantity11 DECIMAL(28,8),
	Quantity12 DECIMAL(28,8),
	Quantity13 DECIMAL(28,8),
	Quantity14 DECIMAL(28,8),
	Quantity15 DECIMAL(28,8),
	Quantity16 DECIMAL(28,8),
	Quantity17 DECIMAL(28,8),
	Quantity18 DECIMAL(28,8),
	Quantity19 DECIMAL(28,8),
	Quantity20 DECIMAL(28,8),
	Quantity21 DECIMAL(28,8),
	Quantity22 DECIMAL(28,8),
	Quantity23 DECIMAL(28,8),
	Quantity24 DECIMAL(28,8),
	Quantity25 DECIMAL(28,8),
	Quantity26 DECIMAL(28,8),
	Quantity27 DECIMAL(28,8),
	Quantity28 DECIMAL(28,8),
	Quantity29 DECIMAL(28,8),
	Quantity30 DECIMAL(28,8),
	Quantity31 DECIMAL(28,8),
	Quantity_SX DECIMAL(28,8),
	Date01 DECIMAL(28,8),
	Date02 DECIMAL(28,8),
	Date03 DECIMAL(28,8),
	Date04 DECIMAL(28,8),
	Date05 DECIMAL(28,8),
	Date06 DECIMAL(28,8),
	Date07 DECIMAL(28,8),
	Date08 DECIMAL(28,8),
	Date09 DECIMAL(28,8),
	Date10 DECIMAL(28,8),
	Date11 DECIMAL(28,8),
	Date12 DECIMAL(28,8),
	Date13 DECIMAL(28,8),
	Date14 DECIMAL(28,8),
	Date15 DECIMAL(28,8),
	Date16 DECIMAL(28,8),
	Date17 DECIMAL(28,8),
	Date18 DECIMAL(28,8),
	Date19 DECIMAL(28,8),
	Date20 DECIMAL(28,8),
	Date21 DECIMAL(28,8),
	Date22 DECIMAL(28,8),
	Date23 DECIMAL(28,8),
	Date24 DECIMAL(28,8),
	Date25 DECIMAL(28,8),
	Date26 DECIMAL(28,8),
	Date27 DECIMAL(28,8),
	Date28 DECIMAL(28,8),
	Date29 DECIMAL(28,8),
	Date30 DECIMAL(28,8),
	Date31 DECIMAL(28,8),			
	
)

DECLARE @Cursor AS cursor
IF @IsDate = 0
BEGIN
	SET @Cursor = CURSOR SCROLL KEYSET FOR   
	Select MT0181.VoucherDate, MT0181.VoucherID
	From MT0181 
	LEFT JOIN MT0182 ON MT0181.DivisionID = MT0182.DivisionID AND MT0181.VoucherID = MT0182.VoucherID
	WHERE MT0181.DivisionID = @DivisionID AND
		  MT0181.VoucherNo BETWEEN @FromVoucherNo AND @ToVoucherNo AND
		  MT0181.ObjectID BETWEEN @FromObjectID AND @ToObjectID AND
		  MT0182.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID
		  AND MT0181.TranYear*12 + MT0181.TranMonth BETWEEN @FromYear*12+@FromMonth AND @ToYear*12+@ToMonth	
END
ELSE
	BEGIN
		SET @Cursor = CURSOR SCROLL KEYSET FOR   
		Select MT0181.VoucherDate, MT0181.VoucherID
		From MT0181 
		LEFT JOIN MT0182 ON MT0181.DivisionID = MT0182.DivisionID AND MT0181.VoucherID = MT0182.VoucherID
		WHERE MT0181.DivisionID = @DivisionID AND
			  MT0181.VoucherNo BETWEEN @FromVoucherNo AND @ToVoucherNo AND
			  MT0181.ObjectID BETWEEN @FromObjectID AND @ToObjectID AND
			  MT0182.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID	 
			  AND MT0181.VoucherDate BETWEEN CONVERT(NVARCHAR(20), @FromDate, 101) AND CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'	
	END
	OPEN @Cursor
	FETCH NEXT FROM @Cursor INTO @VoucherDate, @VoucherID
		WHILE @@FETCH_STATUS = 0  
			BEGIN
				Insert into #MP0186
				SELECT  
				A1.AnaName01, A1.AnaName02, A1.Ana01ID, A1.Ana02ID, A1.ObjectName2, A1.InventoryID, A1.InventoryName, A1.PO, A1.Quantity,
				A1.StandardName01, A1.UnitPrice, A1.SyncDate, A1.DeliverDate, A1.NextQuantity, A1.Notes, A1.TranMonth, A1.TranYear,
				A1.Quantity01, A1.Quantity02, A1.Quantity03, A1.Quantity04, A1.Quantity05, A1.Quantity06, A1.Quantity07, A1.Quantity08, A1.Quantity09, A1.Quantity10,  
				A1.Quantity11, A1.Quantity12, A1.Quantity13, A1.Quantity14, A1.Quantity15, A1.Quantity16, A1.Quantity17, A1.Quantity18, A1.Quantity19, A1.Quantity20,  
				A1.Quantity21, A1.Quantity22, A1.Quantity23, A1.Quantity24, A1.Quantity25, A1.Quantity26, A1.Quantity27, A1.Quantity28, A1.Quantity29, A1.Quantity30, A1.Quantity31,
				A2.Quantity_SX,
				A3.Date01, A3.Date02, A3.Date03, A3.Date04, A3.Date05, A3.Date06, A3.Date07, A3.Date08, A3.Date09, A3.Date10,
				A3.Date11, A3.Date12, A3.Date13, A3.Date14, A3.Date15, A3.Date16, A3.Date17, A3.Date18, A3.Date19, A3.Date20,
				A3.Date21, A3.Date22, A3.Date23, A3.Date24, A3.Date25, A3.Date26, A3.Date27, A3.Date28, A3.Date29, A3.Date30, A3.Date31
				FROM (SELECT MT0181.VoucherNo, MT0181.VoucherDate, MT0181.ObjectID, MT0181.EmployeeID, AT1103.FullName, MT0181.[Description], MT0181.[Disabled], 
						A21.ObjectName, A22.ObjectName as ObjectName2, MT0182.*, AT1302.InventoryName,
						A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
						A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
						A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
						A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
						A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20,
						a.S01, a.S02, a.S03, a.S04, a.S05, a.S06, a.S07, a.S08, a.S09, a.S10,
						a.S11, a.S12, a.S13, a.S14, a.S15, a.S16, a.S17, a.S18, a.S19, a.S20, PT01.AnaName AnaName01, PT02.AnaName AnaName02
	  
						FROM MT0181 WITH (NOLOCK)
						LEFT JOIN MT0182 WITH (NOLOCK) ON MT0181.DivisionID = MT0182.DivisionID AND MT0181.VoucherID = MT0182.VoucherID
						LEFT JOIN AT1103 WITH (NOLOCK) ON  MT0181.EmployeeID = AT1103.EmployeeID
						LEFT JOIN AT1302 WITH (NOLOCK) ON MT0182.InventoryID = AT1302.InventoryID AND AT1302.DivisionID IN (MT0182.DivisionID,'@@@')
						LEFT JOIN AT1202 A21 WITH (NOLOCK) ON A21.DivisionID IN (@DivisionID, '@@@') AND MT0181.ObjectID = A21.ObjectID
						LEFT JOIN AT1202 A22 WITH (NOLOCK) ON A22.DivisionID IN (@DivisionID, '@@@') AND MT0182.ObjectID2 = A22.ObjectID
						FULL JOIN (SELECT * FROM  (SELECT UserName, TypeID, DivisionID
	  											FROM AT0005 WITH (NOLOCK) WHERE TypeID LIKE 'S__') b PIVOT (max(Username) for TypeID IN (S01, S02, S03, S04, S05, S06, S07, S08, S09, S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S20))  AS a) a ON a.DivisionID = MT0182.DivisionID
						LEFT JOIN AT0128 A01 WITH (NOLOCK) ON MT0182.S01ID = A01.StandardID AND A01.StandardTypeID = 'S01'
						LEFT JOIN AT0128 A02 WITH (NOLOCK) ON MT0182.S02ID = A02.StandardID AND A02.StandardTypeID = 'S02'
						LEFT JOIN AT0128 A03 WITH (NOLOCK) ON MT0182.S03ID = A03.StandardID AND A03.StandardTypeID = 'S03'
						LEFT JOIN AT0128 A04 WITH (NOLOCK) ON MT0182.S04ID = A04.StandardID AND A04.StandardTypeID = 'S04'
						LEFT JOIN AT0128 A05 WITH (NOLOCK) ON MT0182.S05ID = A05.StandardID AND A05.StandardTypeID = 'S05'
						LEFT JOIN AT0128 A06 WITH (NOLOCK) ON MT0182.S06ID = A06.StandardID AND A06.StandardTypeID = 'S06'
						LEFT JOIN AT0128 A07 WITH (NOLOCK) ON MT0182.S07ID = A07.StandardID AND A07.StandardTypeID = 'S07'
						LEFT JOIN AT0128 A08 WITH (NOLOCK) ON MT0182.S08ID = A08.StandardID AND A08.StandardTypeID = 'S08'
						LEFT JOIN AT0128 A09 WITH (NOLOCK) ON MT0182.S09ID = A09.StandardID AND A09.StandardTypeID = 'S09'
						LEFT JOIN AT0128 A10 WITH (NOLOCK) ON MT0182.S10ID = A10.StandardID AND A10.StandardTypeID = 'S10'
						LEFT JOIN AT0128 A11 WITH (NOLOCK) ON MT0182.S11ID = A11.StandardID AND A11.StandardTypeID = 'S11'
						LEFT JOIN AT0128 A12 WITH (NOLOCK) ON MT0182.S12ID = A12.StandardID AND A12.StandardTypeID = 'S12'
						LEFT JOIN AT0128 A13 WITH (NOLOCK) ON MT0182.S13ID = A13.StandardID AND A13.StandardTypeID = 'S13'
						LEFT JOIN AT0128 A14 WITH (NOLOCK) ON MT0182.S14ID = A14.StandardID AND A14.StandardTypeID = 'S14'
						LEFT JOIN AT0128 A15 WITH (NOLOCK) ON MT0182.S15ID = A15.StandardID AND A15.StandardTypeID = 'S15'
						LEFT JOIN AT0128 A16 WITH (NOLOCK) ON MT0182.S16ID = A16.StandardID AND A16.StandardTypeID = 'S16'
						LEFT JOIN AT0128 A17 WITH (NOLOCK) ON MT0182.S17ID = A17.StandardID AND A17.StandardTypeID = 'S17'
						LEFT JOIN AT0128 A18 WITH (NOLOCK) ON MT0182.S18ID = A18.StandardID AND A18.StandardTypeID = 'S18'
						LEFT JOIN AT0128 A19 WITH (NOLOCK) ON MT0182.S19ID = A19.StandardID AND A19.StandardTypeID = 'S19'
						LEFT JOIN AT0128 A20 WITH (NOLOCK) ON MT0182.S20ID = A20.StandardID AND A20.StandardTypeID = 'S20'
						LEFT JOIN AT1011 PT01 WITH (NOLOCK) ON PT01.AnaID = MT0182.Ana01ID
						LEFT JOIN AT1011 PT02 WITH (NOLOCK) ON PT02.AnaID = MT0182.Ana02ID) A1

				-- Tìm những kế hoạch đã sản xuất (Quantity_SX) cho từng mặt hàng
				LEFT JOIN ( SELECT SUM(MT1001.Quantity) AS Quantity_SX, MT1001.DivisionID, MT2005.PlanObjectID, MT1001.ProductID, MT1001.UnitID,
									   M89.S01ID, M89.S02ID, M89.S03ID, M89.S04ID, M89.S05ID, M89.S06ID, M89.S07ID, M89.S08ID, M89.S09ID, M89.S10ID,
									   M89.S11ID, M89.S12ID, M89.S13ID, M89.S14ID, M89.S15ID, M89.S16ID, M89.S17ID, M89.S18ID, M89.S19ID, M89.S20ID
							FROM MT0182 WITH (NOLOCK)
							LEFT JOIN MT0181 WITH (NOLOCK) ON MT0182.DivisionID = MT0181.DivisionID AND MT0182.VoucherID = MT0181.VoucherID
							LEFT JOIN MT2005 WITH (NOLOCK) ON MT2005.DivisionID = MT0182.DivisionID AND MT2005.InheritPlanMonthID = MT0182.VoucherID AND MT2005.PlanObjectID = MT0182.ObjectID2
																AND MT2005.InventoryID = MT0182.InventoryID
																AND MT2005.UnitID = MT0182.UnitID
							LEFT JOIN MT8899 WITH (NOLOCK) ON MT8899.DivisionID = MT2005.DivisionID AND MT8899.VoucherID = MT2005.VoucherID AND MT8899.TransactionID = MT2005.TransactionID AND MT8899.TableID = 'MT2005'
																AND Isnull(MT8899.S01ID,'') = Isnull(MT0182.S01ID,'')
																AND Isnull(MT8899.S02ID,'') = Isnull(MT0182.S02ID,'')
																AND Isnull(MT8899.S03ID,'') = Isnull(MT0182.S03ID,'')
																AND Isnull(MT8899.S04ID,'') = Isnull(MT0182.S04ID,'')
																AND Isnull(MT8899.S05ID,'') = Isnull(MT0182.S05ID,'')
																AND Isnull(MT8899.S06ID,'') = Isnull(MT0182.S06ID,'')
																AND Isnull(MT8899.S07ID,'') = Isnull(MT0182.S07ID,'')
																AND Isnull(MT8899.S08ID,'') = Isnull(MT0182.S08ID,'')
																AND Isnull(MT8899.S09ID,'') = Isnull(MT0182.S09ID,'')
																AND Isnull(MT8899.S10ID,'') = Isnull(MT0182.S10ID,'')	
																AND Isnull(MT8899.S11ID,'') = Isnull(MT0182.S11ID,'')
																AND Isnull(MT8899.S12ID,'') = Isnull(MT0182.S12ID,'')
																AND Isnull(MT8899.S13ID,'') = Isnull(MT0182.S13ID,'')
																AND Isnull(MT8899.S14ID,'') = Isnull(MT0182.S14ID,'')
																AND Isnull(MT8899.S15ID,'') = Isnull(MT0182.S15ID,'')
																AND Isnull(MT8899.S16ID,'') = Isnull(MT0182.S16ID,'')
																AND Isnull(MT8899.S17ID,'') = Isnull(MT0182.S17ID,'')
																AND Isnull(MT8899.S18ID,'') = Isnull(MT0182.S18ID,'')
																AND Isnull(MT8899.S19ID,'') = Isnull(MT0182.S19ID,'')
																AND Isnull(MT8899.S20ID,'') = Isnull(MT0182.S20ID,'')				
							LEFT JOIN MT1001 WITH (NOLOCK) ON MT1001.DivisionID = MT2005.DivisionID AND MT1001.InheritVoucherID = MT2005.VoucherID AND MT1001.InheritTransactionID = MT2005.TransactionID AND MT1001.InheritTableID = 'MT2004'
							LEFT JOIN MT8899 M89 WITH (NOLOCK) ON M89.DivisionID = MT1001.DivisionID AND M89.VoucherID = MT1001.VoucherID AND M89.TransactionID = MT1001.TransactionID
							WHERE MT0181.VoucherDate <= CONVERT(NVARCHAR(20), @VoucherDate, 101)
							GROUP BY MT1001.DivisionID, MT2005.PlanObjectID, MT1001.ProductID, MT1001.UnitID,
									 M89.S01ID, M89.S02ID, M89.S03ID, M89.S04ID, M89.S05ID, M89.S06ID, M89.S07ID, M89.S08ID, M89.S09ID, M89.S10ID,
									 M89.S11ID, M89.S12ID, M89.S13ID, M89.S14ID, M89.S15ID, M89.S16ID, M89.S17ID, M89.S18ID, M89.S19ID, M89.S20ID ) A2
				ON A2.DivisionID = A1.DivisionID AND A2.PlanObjectID = A1.ObjectID2 AND A2.ProductID = A1.InventoryID AND A2.UnitID = A1.UnitID 
				AND ISNULL(A2.S01ID, '') = ISNULL(A1.S01ID, '') AND ISNULL(A2.S02ID, '') = ISNULL(A1.S02ID, '') AND ISNULL(A2.S03ID, '') = ISNULL(A1.S03ID, '') AND ISNULL(A2.S04ID, '') = ISNULL(A1.S04ID, '') AND ISNULL(A2.S05ID, '') = ISNULL(A1.S05ID, '')
				AND ISNULL(A2.S06ID, '') = ISNULL(A1.S06ID, '') AND ISNULL(A2.S07ID, '') = ISNULL(A1.S07ID, '') AND ISNULL(A2.S08ID, '') = ISNULL(A1.S08ID, '') AND ISNULL(A2.S09ID, '') = ISNULL(A1.S09ID, '') AND ISNULL(A2.S10ID, '') = ISNULL(A1.S10ID, '')
				AND ISNULL(A2.S11ID, '') = ISNULL(A1.S11ID, '') AND ISNULL(A2.S12ID, '') = ISNULL(A1.S12ID, '') AND ISNULL(A2.S13ID, '') = ISNULL(A1.S13ID, '') AND ISNULL(A2.S14ID, '') = ISNULL(A1.S14ID, '') AND ISNULL(A2.S15ID, '') = ISNULL(A1.S15ID, '')
				AND ISNULL(A2.S16ID, '') = ISNULL(A1.S16ID, '') AND ISNULL(A2.S17ID, '') = ISNULL(A1.S17ID, '') AND ISNULL(A2.S18ID, '') = ISNULL(A1.S18ID, '') AND ISNULL(A2.S19ID, '') = ISNULL(A1.S19ID, '') AND ISNULL(A2.S20ID, '') = ISNULL(A1.S20ID, '')		 
 
				-- Tìm những kế hoạch chưa sản xuất (Date01 - Date31) cho từng mặt hàng
				LEFT JOIN (SELECT DivisionID, PlanObjectID, ProductID, UnitID, InheritPlanMonthID,
							S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
							S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID,
							SUM(ISNULL(Date01, 0)) AS Date01, SUM(ISNULL(Date02, 0)) AS Date02, SUM(ISNULL(Date03, 0)) AS Date03, SUM(ISNULL(Date04, 0)) AS Date04, SUM(ISNULL(Date05, 0)) AS Date05,
							SUM(ISNULL(Date06, 0)) AS Date06, SUM(ISNULL(Date07, 0)) AS Date07, SUM(ISNULL(Date08, 0)) AS Date08, SUM(ISNULL(Date09, 0)) AS Date09, SUM(ISNULL(Date10, 0)) AS Date10,
							SUM(ISNULL(Date11, 0)) AS Date11, SUM(ISNULL(Date12, 0)) AS Date12, SUM(ISNULL(Date13, 0)) AS Date13, SUM(ISNULL(Date14, 0)) AS Date14, SUM(ISNULL(Date15, 0)) AS Date15,
							SUM(ISNULL(Date16, 0)) AS Date16, SUM(ISNULL(Date17, 0)) AS Date17, SUM(ISNULL(Date18, 0)) AS Date18, SUM(ISNULL(Date19, 0)) AS Date19, SUM(ISNULL(Date20, 0)) AS Date20,
							SUM(ISNULL(Date21, 0)) AS Date21, SUM(ISNULL(Date22, 0)) AS Date22, SUM(ISNULL(Date23, 0)) AS Date23, SUM(ISNULL(Date24, 0)) AS Date24, SUM(ISNULL(Date25, 0)) AS Date25,
							SUM(ISNULL(Date26, 0)) AS Date26, SUM(ISNULL(Date27, 0)) AS Date27, SUM(ISNULL(Date28, 0)) AS Date28, SUM(ISNULL(Date29, 0)) AS Date29, SUM(ISNULL(Date30, 0)) AS Date30, SUM(ISNULL(Date31, 0)) AS Date31                       
							FROM (SELECT * FROM (SELECT MT1001.Quantity, MT1001.DivisionID, MT2005.PlanObjectID, MT1001.ProductID, MT1001.UnitID, MT2005.InheritPlanMonthID,
														M89.S01ID, M89.S02ID, M89.S03ID, M89.S04ID, M89.S05ID, M89.S06ID, M89.S07ID, M89.S08ID, M89.S09ID, M89.S10ID,
														M89.S11ID, M89.S12ID, M89.S13ID, M89.S14ID, M89.S15ID, M89.S16ID, M89.S17ID, M89.S18ID, M89.S19ID, M89.S20ID,
														( CASE  WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '01' THEN 'Date01'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '02' THEN 'Date02'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '03' THEN 'Date03'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '04' THEN 'Date04'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '05' THEN 'Date05'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '06' THEN 'Date06'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '07' THEN 'Date07'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '08' THEN 'Date08'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '09' THEN 'Date09'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '10' THEN 'Date10'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '11' THEN 'Date11'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '12' THEN 'Date12'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '13' THEN 'Date13'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '14' THEN 'Date14'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '15' THEN 'Date15'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '16' THEN 'Date16'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '17' THEN 'Date17'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '18' THEN 'Date18'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '19' THEN 'Date19'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '20' THEN 'Date20'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '21' THEN 'Date21'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '22' THEN 'Date22'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '23' THEN 'Date23'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '24' THEN 'Date24'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '25' THEN 'Date25'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '26' THEN 'Date26'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '27' THEN 'Date27'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '28' THEN 'Date28'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '29' THEN 'Date29'	
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '30' THEN 'Date30'
																WHEN SUBSTRING (Convert(nvarchar(50), MT2004.VoucherDate, 101), 4,2) = '31' THEN 'Date31' END) Date		   		   			   
													FROM MT0182 WITH (NOLOCK)
													LEFT JOIN MT0181 WITH (NOLOCK) ON MT0182.DivisionID = MT0181.DivisionID AND MT0182.VoucherID = MT0181.VoucherID
													LEFT JOIN MT2005 WITH (NOLOCK) ON MT2005.DivisionID = MT0182.DivisionID AND MT2005.InheritPlanMonthID = MT0182.VoucherID AND MT2005.PlanObjectID = MT0182.ObjectID2
																						AND MT2005.InventoryID = MT0182.InventoryID
																						AND MT2005.UnitID = MT0182.UnitID
													inner join MT2004 WITH (NOLOCK) on MT2005.VoucherID = MT2004.VoucherID and MT2005.DivisionID = MT2004.DivisionID									
													LEFT JOIN MT8899 WITH (NOLOCK) ON MT8899.DivisionID = MT2005.DivisionID AND MT8899.VoucherID = MT2005.VoucherID AND MT8899.TransactionID = MT2005.TransactionID AND MT8899.TableID = 'MT2005'
																						AND Isnull(MT8899.S01ID,'') = Isnull(MT0182.S01ID,'')
																						AND Isnull(MT8899.S02ID,'') = Isnull(MT0182.S02ID,'')
																						AND Isnull(MT8899.S03ID,'') = Isnull(MT0182.S03ID,'')
																						AND Isnull(MT8899.S04ID,'') = Isnull(MT0182.S04ID,'')
																						AND Isnull(MT8899.S05ID,'') = Isnull(MT0182.S05ID,'')
																						AND Isnull(MT8899.S06ID,'') = Isnull(MT0182.S06ID,'')
																						AND Isnull(MT8899.S07ID,'') = Isnull(MT0182.S07ID,'')
																						AND Isnull(MT8899.S08ID,'') = Isnull(MT0182.S08ID,'')
																						AND Isnull(MT8899.S09ID,'') = Isnull(MT0182.S09ID,'')
																						AND Isnull(MT8899.S10ID,'') = Isnull(MT0182.S10ID,'')	
																						AND Isnull(MT8899.S11ID,'') = Isnull(MT0182.S11ID,'')
																						AND Isnull(MT8899.S12ID,'') = Isnull(MT0182.S12ID,'')
																						AND Isnull(MT8899.S13ID,'') = Isnull(MT0182.S13ID,'')
																						AND Isnull(MT8899.S14ID,'') = Isnull(MT0182.S14ID,'')
																						AND Isnull(MT8899.S15ID,'') = Isnull(MT0182.S15ID,'')
																						AND Isnull(MT8899.S16ID,'') = Isnull(MT0182.S16ID,'')
																						AND Isnull(MT8899.S17ID,'') = Isnull(MT0182.S17ID,'')
																						AND Isnull(MT8899.S18ID,'') = Isnull(MT0182.S18ID,'')
																						AND Isnull(MT8899.S19ID,'') = Isnull(MT0182.S19ID,'')
																						AND Isnull(MT8899.S20ID,'') = Isnull(MT0182.S20ID,'')				
													LEFT JOIN MT1001 WITH (NOLOCK) ON MT1001.DivisionID = MT2005.DivisionID AND MT1001.InheritVoucherID = MT2005.VoucherID AND MT1001.InheritTransactionID = MT2005.TransactionID AND MT1001.InheritTableID = 'MT2004'
													LEFT JOIN MT8899 M89 WITH (NOLOCK) ON M89.DivisionID = MT1001.DivisionID AND M89.VoucherID = MT1001.VoucherID AND M89.TransactionID = MT1001.TransactionID ) A
								--WHERE MT25.TransactionID NOT IN (SELECT DISTINCT InheritTransactionID FROM MT1001) 
								PIVOT (Max(Quantity) FOR Date IN ([Date01], [Date02], [Date03], [Date04], [Date05], [Date06], [Date07], [Date08], [Date09], [Date10],
																		[Date11], [Date12], [Date13], [Date14], [Date15], [Date16], [Date17], [Date18], [Date19], [Date20],
																		[Date21], [Date22], [Date23], [Date24], [Date25], [Date26], [Date27], [Date28], [Date29], [Date30], [Date31])) AS P ) P1 
								GROUP BY	DivisionID, PlanObjectID, ProductID, UnitID, InheritPlanMonthID,
											S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
											S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID ) A3									
				ON A3.DivisionID = A1.DivisionID AND A3.PlanObjectID = A1.ObjectID2 AND A3.ProductID = A1.InventoryID AND A3.UnitID = A1.UnitID AND A3.InheritPlanMonthID = A1.VoucherID 
				AND ISNULL(A3.S01ID, '') = ISNULL(A1.S01ID, '') AND ISNULL(A3.S02ID, '') = ISNULL(A1.S02ID, '') AND ISNULL(A3.S03ID, '') = ISNULL(A1.S03ID, '') AND ISNULL(A3.S04ID, '') = ISNULL(A1.S04ID, '') AND ISNULL(A3.S05ID, '') = ISNULL(A1.S05ID, '')
				AND ISNULL(A3.S06ID, '') = ISNULL(A1.S06ID, '') AND ISNULL(A3.S07ID, '') = ISNULL(A1.S07ID, '') AND ISNULL(A3.S08ID, '') = ISNULL(A1.S08ID, '') AND ISNULL(A3.S09ID, '') = ISNULL(A1.S09ID, '') AND ISNULL(A3.S10ID, '') = ISNULL(A1.S10ID, '')
				AND ISNULL(A3.S11ID, '') = ISNULL(A1.S11ID, '') AND ISNULL(A3.S12ID, '') = ISNULL(A1.S12ID, '') AND ISNULL(A3.S13ID, '') = ISNULL(A1.S13ID, '') AND ISNULL(A3.S14ID, '') = ISNULL(A1.S14ID, '') AND ISNULL(A3.S15ID, '') = ISNULL(A1.S15ID, '')
				AND ISNULL(A3.S16ID, '') = ISNULL(A1.S16ID, '') AND ISNULL(A3.S17ID, '') = ISNULL(A1.S17ID, '') AND ISNULL(A3.S18ID, '') = ISNULL(A1.S18ID, '') AND ISNULL(A3.S19ID, '') = ISNULL(A1.S19ID, '') AND ISNULL(A3.S20ID, '') = ISNULL(A1.S20ID, '')	

				WHERE A1.VoucherID = @VoucherID
				FETCH NEXT FROM @Cursor INTO @VoucherDate, @VoucherID
			END
			
SELECT * FROM #MP0186			
					  
--DROP TABLE #MP0186

SET NOCOUNT OFF 
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
