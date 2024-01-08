IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP3022]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP3022]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In chi tiet don hang ban
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 30/12/2004 by Vo Thanh Huong
---- 
----Thuy Tuyen  5/12/2006 sua goi store AP47000 , AV6666 sang OP4700, OV6666
---Last Edit ThuyTuyen 16/04/2008 ,27/05/2009,21/09/2009.
--ThuyTuyen, lay cac thong tin theo DVT qui doi 
---- Modified on 23/09/2011 by Le Thi Thu Hien : Customize cho khach hang Quang Huy ( Tach 50% doanh thu cho nhan vien kinh doanh)
---- Modified on 11/11/2011 by Le Thi Thu Hien : Bo sung so luong xuat kho ActualQuantity va so luong con lai QuantityEnd
---- Modified on 31/01/2012 by Le Thi Thu Hien : Sua dieu kien CONVERT theo ngay
---- Modified on 31/01/2012 by Le Thi Thu Hien : Sua dieu kien AND ISNULL (@Condition, '')  <> ''
---- Modified on 02/03/2014 by Le Thi Thu Hien : Bo sung phan quyen xem du lieu cua nguoi khac
---- Modified on 02/10/2014 by Thanh Sơn: Bổ sung 10 mã phân tích nghiệp vụ (Name & ID)
---- Modified on 25/05/2015 by Lê Thị Hạnh: Bổ sung ETaxConvertedUnit (Customize Index: 36 - SGPT)
---- Modified on 10/12/2015 by Kim Vũ: Bổ sung nvarchar01 - nvarchar20 (ABA)
---- Modified on 03/05/2017 by Bảo Thy: Bổ sung thông tin quy cách
---- Modified by Hải Long on 22/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Bảo Thy on 19/06/2017: Fix lỗi "Ambiguous column name 'GroupID'"
---- Modified on 23/02/2018 by Bảo Anh: Bổ sung cột ObjectAddress
---- Modified on 06/03/2018 by Bảo Anh: Bổ sung cột I01ID -> I10ID
---- Modified on 15/07/2019 by Khánh Đoan: Bổ sung các trường Address,Email,Tel
---- Modified on 11/12/2019 by Văn Minh: Bổ sung các trường O01 -> O05 ID and Name
---- Modified on 12/07/2022 by Thành Sang : Lấy thêm cột quy cách WNotes01, trọng lượng WNotes02 từ phiếu xuất kho AT2007
---- Modified on 12/10/2022 by Thành Sang : CustomerIndex cột quy cách cho khách KOYO
---- Modified on 05/01/2023 by Phương Thảo : Bổ sung  cột IsProInventoryID ,DiscountSaleAmountDetail ,VAna01ID,VAna01Name,VAna02ID,VAna02Name,VAna03ID,VAna03Name,VAna04ID,VAna04Name,VAna05ID,VAna05Name
---- Modified on 11/01/2023 [2023/01/IS/0033] by Phương Thảo : Bổ sung  cột CityName,ClassifyID,I01Name,...,I10Name.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- 

CREATE PROCEDURE [dbo].[OP3022] 
			@DivisionID AS nvarchar(50),
			@FromMonth AS int,
			@ToMonth AS int,
			@FromYear AS int,
			@ToYear AS int,
			@FromDate AS datetime,
			@ToDate AS datetime,
			@FromObjectID AS nvarchar(50),
			@ToObjectID AS nvarchar(50),				
			@IsDate AS tinyint,
			@IsGroup AS tinyint,
			@GroupID nvarchar(50), -- GroupID: OB, CI1, CI2, CI3, I01, I02, I03, I04, I05		
			@CurrencyID AS nvarchar(50),
			@UserID As nvarchar(50),
			@UserGroupID As nvarchar(50)
 AS
DECLARE 	@sSQL varchar(MAX),
			@sSQL1 varchar(MAX),
			@sSQL2 varchar(MAX),
			@GroupField nvarchar(20),
			@sFROM nvarchar(500),
			@sSELECT nvarchar(500), 
			@FromMonthYearText NVARCHAR(20), 
			@ToMonthYearText NVARCHAR(20), 
			@FromDateText NVARCHAR(20), 
			@ToDateText NVARCHAR(20),
			@Condition NVARCHAR(4000),
			@CustomerName INT,
			@sSQL3 NVARCHAR(200) = '',
			@sSQL4 NVARCHAR(100) = '',
			@sSQL5 NVARCHAR(500) = '',
			@sSQL6 NVARCHAR(200) = '', 
			@sSQL7 NVARCHAR(200) = '' 


SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
IF @CustomerName = 20 --- Customize Sinolife
BEGIN
	SET @sSQL3 = 'LEFT JOIN AT1202 AT1202_1 ON AT1202_1.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202_1.ObjectID = O1.SalesManID'
	SET @sSQL4 = 'AT1202_1.ObjectName SalesManName'
END
ELSE 
BEGIN
	SET @sSQL3 = 'LEFT JOIN AT1103 AT1103_2 ON AT1103_2.EmployeeID = O1.SalesManID'
	SET @sSQL4 = 'SalesManName'
END	


IF @CustomerName = 52 --- Customize KOYO
BEGIN
	SET @sSQL5 = ', A00.Notes01 AS WNotes01, A00.Notes02 AS WNotes02, A00.Notes03 AS WNotes03'
	SET @sSQL6 = 'LEFT JOIN AT2007 A00 WITH (NOLOCK) ON A00.DivisionID IN ( ''@@@'', OV2300.DivisionID) AND A00.OTransactionID = OV2300.TransactionID AND A00.InventoryID = OV2300.InventoryID'
	SET @sSQL7 = ', O1.WNotes01, O1.WNotes02, O1.WNotes03'
END

----------------->>>>>> Phân quyền xem chứng từ của người dùng khác		
DECLARE @sSQLPer AS NVARCHAR(MAX),
		@sWHEREPer AS NVARCHAR(MAX)
SET @sSQLPer = ''
SET @sWHEREPer = ''		

IF EXISTS (SELECT TOP 1 1 FROM OT0001 WHERE DivisionID = @DivisionID AND IsPermissionView = 1 ) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
	BEGIN
		SET @sSQLPer = ' LEFT JOIN AT0010 ON AT0010.DivisionID = OV2300.DivisionID 
											AND AT0010.AdminUserID = '''+@UserID+''' 
											AND AT0010.UserID = OV2300.CreateUserID '
		SET @sWHEREPer = ' AND (OV2300.CreateUserID = AT0010.UserID
								OR  OV2300.CreateUserID = '''+@UserID+''') '		
	END

-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác	
If @UserID<>''
EXEC AP1409 @DivisionID,'ASOFTOP','VT','VT',@UserID,@UserGroupID,0,@Condition OUTPUT     

SELECT @sFROM = '',  @sSELECT = ''
IF @IsGroup  = 1 
	BEGIN
	EXEC OP4700  	@GroupID,	@GroupField OUTPUT
	SELECT @sFROM = @sFROM + ' 
		LEFT JOIN	OV6666 V1 
			ON		V1.SelectionType = ''' + @GroupID + ''' 
					AND V1.SelectionID = Convert(nvarchar(50),OV2300.' + @GroupField + ') 
					AND OV2300.DivisionID = V1.DivisionID' ,
		@sSELECT = @sSELECT + ', 
		V1.SelectionID AS GroupID, V1.SelectionName AS GroupName'
				
	END
ELSE
	SET @sSELECT = @sSELECT +  ', 
		'''' AS GroupID, '''' AS GroupName'	

Set @sSQL =  '
SELECT  
		OV2300.DivisionID,
		OV2300.OrderID AS SOrderID,  
		OV2300.VoucherNo,           
		OV2300.VoucherDate AS OrderDate,
		OV2300.ObjectID,
		OV2300.ObjectName,
		OV2300.CurrencyID,
		OV2300.Orders,
		OV2300.OrderStatus,
		OV2300.StatusName,
		OV2300.InventoryID, 
		OV2300.InventoryName, 
		OV2300.SName1,
		OV2300.SName2,
		OV2300.InNotes01,
		OV2300.InNotes02,
		OV2300.Specification,
		OV2300.UnitName,
		OV2300.OrderQuantity, -- So luong don hang
		OV2300.ActualQuantity, -- So luong xuat kho
		(OV2300.OrderQuantity - OV2300.ActualQuantity) AS QuantityEnd, --So luong con lai
		OV2300.ConversionUnitID, 
		OV2300.ConversionUnitName,
		isnull(OV2300.ConvertedQuantity,0)  AS ConvertedQuantity ,
		OV2300.VATPercent,		
		OV2300.DiscountPercent,
		OV2300.CommissionPercent,
		OV2300.SalePrice,
		isnull(SalePrice, 0) * isnull(OV2300.ExchangeRate, 0) AS ConvertedPrice,	
		OV2300.OriginalAmount,
		OV2300.ConvertedAmount,
		OV2300.VATOriginalAmount,
		OV2300.VATConvertedAmount,
		isnull (OV2300.OriginalAmount ,0) + isnull(OV2300.VATOriginalAmount,0) AS SumOriginalAmount,
		isnull (OV2300.ConvertedAmount ,0) + isnull(OV2300.VATConvertedAmount,0) AS SumConvertedAmount,	
		OV2300.DiscountOriginalAmount,
		OV2300.DiscountConvertedAmount,
		OV2300.CommissionOAmount, 
		OV2300.CommissionCAmount,
		OV2300.QuotationID,
		OV2300.Shipdate , OV2300.Description, OV2300.RefInfor,  OV2300.Notes, OV2300.Notes01, OV2300.Notes02,
		OV2300.SaleOffPercent01,
		OV2300.SaleOffAmount01,
		OV2300.SaleOffPercent02,
		OV2300.SaleOffAmount02,
		OV2300.SaleOffPercent03,
		OV2300.SaleOffAmount03,
		OV2300.SaleOffPercent04,
		OV2300.SaleOffAmount04,
		OV2300.SaleOffPercent05,
		OV2300.SaleOffAmount05,
		OV2300.SalesManID, OV2300.SalesManName,
		OV2300.SalesMan2ID, OV2300.SalesMan2Name, OV2300.WareHouseID, OV2300.WareHouseName,
		OV2300.CityName,
		OV2300.ClassifyID,
		OV2300.I01Name,OV2300.I02Name,OV2300.I03Name,OV2300.I04Name,OV2300.I05Name,
		OV2300.I06Name,OV2300.I07Name,OV2300.I08Name,OV2300.I09Name,OV2300.I10Name,
		OV2300.Ana01ID, OV2300.Ana02ID, OV2300.Ana03ID, OV2300.Ana04ID, OV2300.Ana05ID, 
		OV2300.Ana06ID, OV2300.Ana07ID, OV2300.Ana08ID, OV2300.Ana09ID, OV2300.Ana10ID,
		OV2300.AnaName01, OV2300.AnaName02, OV2300.AnaName03, OV2300.AnaName04, OV2300.AnaName05, 
		OV2300.AnaName06, OV2300.AnaName07, OV2300.AnaName08, OV2300.AnaName09, OV2300.AnaName10,
		OV2300.VAna01ID, OV2300.VAna02ID, OV2300.VAna03ID, OV2300.VAna04ID, OV2300.VAna05ID, 
		OV2300.VAna01Name, OV2300.VAna02Name, OV2300.VAna03Name, OV2300.VAna04Name, OV2300.VAna05Name,
		OV2300.IsProInventoryID,
		OV2300.DiscountSaleAmountDetail, 		
		OV2300.TDescription,OV2300.DeliveryAddress, OV2300.ObjectAddress, OV2300.Contact,OV2300.Transport,
		ISNULL(OV2300.ETaxConvertedUnit,0) AS ETaxConvertedUnit,
		TotalOriginalAmount AS TOriginalAmount,
		TotalConvertedAmount AS TConvertedAmount ,
		OV2300.I01ID, OV2300.I02ID, OV2300.I03ID, OV2300.I04ID, OV2300.I05ID,
		OV2300.I06ID, OV2300.I07ID, OV2300.I08ID, OV2300.I09ID, OV2300.I10ID,
		OV2300.nvarchar01, OV2300.nvarchar02, OV2300.nvarchar03, OV2300.nvarchar04, OV2300.nvarchar05,
		OV2300.nvarchar06, OV2300.nvarchar07, OV2300.nvarchar08, OV2300.nvarchar09, OV2300.nvarchar10, 
		OV2300.nvarchar11, OV2300.nvarchar12, OV2300.nvarchar13, OV2300.nvarchar14, OV2300.nvarchar15, 
		OV2300.nvarchar16, OV2300.nvarchar17, OV2300.nvarchar18, OV2300.nvarchar19, OV2300.nvarchar20, 
		ISNULL(OV2300.S01ID,'''') AS S01ID, ISNULL(OV2300.S02ID,'''') AS S02ID, ISNULL(OV2300.S03ID,'''') AS S03ID, ISNULL(OV2300.S04ID,'''') AS S04ID, 
		ISNULL(OV2300.S05ID,'''') AS S05ID, ISNULL(OV2300.S06ID,'''') AS S06ID, ISNULL(OV2300.S07ID,'''') AS S07ID, ISNULL(OV2300.S08ID,'''') AS S08ID, 
		ISNULL(OV2300.S09ID,'''') AS S09ID, ISNULL(OV2300.S10ID,'''') AS S10ID, ISNULL(OV2300.S11ID,'''') AS S11ID, ISNULL(OV2300.S12ID,'''') AS S12ID, 
		ISNULL(OV2300.S13ID,'''') AS S13ID, ISNULL(OV2300.S14ID,'''') AS S14ID, ISNULL(OV2300.S15ID,'''') AS S15ID, ISNULL(OV2300.S16ID,'''') AS S16ID, 
		ISNULL(OV2300.S17ID,'''') AS S17ID, ISNULL(OV2300.S18ID,'''') AS S18ID, ISNULL(OV2300.S19ID,'''') AS S19ID, ISNULL(OV2300.S20ID,'''') AS S20ID,'
SET @sSQL1 = '	
		A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
		A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
		A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
		A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
		A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20 ' + 
		IsNull(@sSELECT,'')  + ', (OV2300.ObjectAddress) AS Address,OV2300.Tel,OV2300.Email,OV2300.O01ID, OV2300.O02ID, OV2300.O03ID, OV2300.O04ID, OV2300.O05ID, OV2300.O01Name, OV2300.O02Name, OV2300.O03Name, OV2300.O04Name, OV2300.O05Name, OV2300.FullName
		' + @sSQL5 + '
FROM	OV2300 
' + @sSQL6 + '
LEFT JOIN AT0128 A01 WITH (NOLOCK) ON OV2300.S01ID = A01.StandardID AND A01.StandardTypeID = ''S01''
LEFT JOIN AT0128 A02 WITH (NOLOCK) ON OV2300.S02ID = A02.StandardID AND A02.StandardTypeID = ''S02''
LEFT JOIN AT0128 A03 WITH (NOLOCK) ON OV2300.S03ID = A03.StandardID AND A03.StandardTypeID = ''S03''
LEFT JOIN AT0128 A04 WITH (NOLOCK) ON OV2300.S04ID = A04.StandardID AND A04.StandardTypeID = ''S04''
LEFT JOIN AT0128 A05 WITH (NOLOCK) ON OV2300.S05ID = A05.StandardID AND A05.StandardTypeID = ''S05''
LEFT JOIN AT0128 A06 WITH (NOLOCK) ON OV2300.S06ID = A06.StandardID AND A06.StandardTypeID = ''S06''
LEFT JOIN AT0128 A07 WITH (NOLOCK) ON OV2300.S07ID = A07.StandardID AND A07.StandardTypeID = ''S07''
LEFT JOIN AT0128 A08 WITH (NOLOCK) ON OV2300.S08ID = A08.StandardID AND A08.StandardTypeID = ''S08''
LEFT JOIN AT0128 A09 WITH (NOLOCK) ON OV2300.S09ID = A09.StandardID AND A09.StandardTypeID = ''S09''
LEFT JOIN AT0128 A10 WITH (NOLOCK) ON OV2300.S10ID = A10.StandardID AND A10.StandardTypeID = ''S10''
LEFT JOIN AT0128 A11 WITH (NOLOCK) ON OV2300.S11ID = A11.StandardID AND A11.StandardTypeID = ''S11''
LEFT JOIN AT0128 A12 WITH (NOLOCK) ON OV2300.S12ID = A12.StandardID AND A12.StandardTypeID = ''S12''
LEFT JOIN AT0128 A13 WITH (NOLOCK) ON OV2300.S13ID = A13.StandardID AND A13.StandardTypeID = ''S13''
LEFT JOIN AT0128 A14 WITH (NOLOCK) ON OV2300.S14ID = A14.StandardID AND A14.StandardTypeID = ''S14''
LEFT JOIN AT0128 A15 WITH (NOLOCK) ON OV2300.S15ID = A15.StandardID AND A15.StandardTypeID = ''S15''
LEFT JOIN AT0128 A16 WITH (NOLOCK) ON OV2300.S16ID = A16.StandardID AND A16.StandardTypeID = ''S16''
LEFT JOIN AT0128 A17 WITH (NOLOCK) ON OV2300.S17ID = A17.StandardID AND A17.StandardTypeID = ''S17''
LEFT JOIN AT0128 A18 WITH (NOLOCK) ON OV2300.S18ID = A18.StandardID AND A18.StandardTypeID = ''S18''
LEFT JOIN AT0128 A19 WITH (NOLOCK) ON OV2300.S19ID = A19.StandardID AND A19.StandardTypeID = ''S19''
LEFT JOIN AT0128 A20 WITH (NOLOCK) ON OV2300.S20ID = A20.StandardID AND A20.StandardTypeID = ''S20''
' + IsNull(@sFROM,'') + '
'+@sSQLPer+'
WHERE	OV2300.OrderType = 0 
		'+@sWHEREPer+'
		AND OV2300.DivisionID = ''' + @DivisionID + ''' 
		AND	ObjectID between ''' + @FromObjectID + ''' AND ''' + @ToObjectID + ''' 
		AND ' + CASE WHEN @IsDate = 1 THEN ' CONVERT(DATETIME,CONVERT(VARCHAR(10),OV2300.VoucherDate,101),101)  BETWEEN ''' + @FromDateText + ''' AND ''' +  @ToDateText  + ''''
				ELSE 	' OV2300.TranMonth + OV2300.TranYear*100 between ' +  @FromMonthYearText +  ' AND ' + @ToMonthYearText  end  + ' 
		AND OV2300.CurrencyID like ''' + @CurrencyID + '''' + Case When @UserID<>'' AND ISNULL (@Condition, '')  <> '' Then ' AND isnull(OV2300.VoucherTypeID,''#'') In ' + @Condition Else '' End

--PRINT (@sSQL)
--PRINT (@sSQL1)

IF EXISTS(SELECT TOP 1 1 FROM SYSOBJECTS WHERE XTYPE = 'V' AND NAME = 'OV3022A')
	DROP VIEW OV3022A
EXEC('CREATE VIEW OV3022A AS ' + @sSQL + @sSQL1)    --tao boi OP3022
	
SET @sSQL1 =  '
SELECT O1.DivisionID, SOrderID, VoucherNo, OrderDate, O1.ObjectID, O1.ObjectName, O1.CurrencyID, Orders, OrderStatus, StatusName, InventoryID,
	InventoryName, SName1, SName2, InNotes01, InNotes02, Specification, UnitName, OrderQuantity, ActualQuantity, QuantityEnd, ConversionUnitID,
	ConversionUnitName, ConvertedQuantity, VATPercent, DiscountPercent, CommissionPercent, SalePrice, ConvertedPrice, OriginalAmount,
	ConvertedAmount, VATOriginalAmount, VATConvertedAmount, SumOriginalAmount, SumConvertedAmount, DiscountOriginalAmount,
	DiscountConvertedAmount, CommissionOAmount, CommissionCAmount, QuotationID, Shipdate, Description, RefInfor, Notes,
	Notes01, Notes02, SaleOffPercent01, SaleOffAmount01, SaleOffPercent02, SaleOffAmount02, SaleOffPercent03,
	SaleOffAmount03, SaleOffPercent04, SaleOffAmount04, SaleOffPercent05, SaleOffAmount05, SalesManID,
	 '+@sSQL4+',
	SalesMan2ID, SalesMan2Name, TDescription, DeliveryAddress, ObjectAddress, Contact, Transport, TOriginalAmount, TConvertedAmount, O1.GroupID,
	GroupName,
	CityName,
	ClassifyID,
	I01Name,I02Name,I03Name,I04Name,I05Name,I06Name,I07Name,I08Name,I09Name,I10Name,
	Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,  Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
	AnaName01, AnaName02, AnaName03, AnaName04, AnaName05,  AnaName06, AnaName07, AnaName08, AnaName09, AnaName10,
	VAna01ID, VAna02ID, VAna03ID, VAna04ID, VAna05ID, VAna01Name, VAna02Name, VAna03Name, VAna04Name, VAna05Name, 
	IsProInventoryID,
	DiscountSaleAmountDetail,
	WareHouseID, WareHouseName, ISNULL(O1.ETaxConvertedUnit,0) AS ETaxConvertedUnit, nvarchar01, nvarchar02, nvarchar03, nvarchar04, nvarchar05,
	nvarchar06, nvarchar07, nvarchar08, nvarchar09, nvarchar10, nvarchar11, nvarchar12, nvarchar13, nvarchar14, nvarchar15, 
	nvarchar16, nvarchar17, nvarchar18, nvarchar19, nvarchar20,
	ISNULL(O1.S01ID,'''') AS S01ID, ISNULL(O1.S02ID,'''') AS S02ID, ISNULL(O1.S03ID,'''') AS S03ID, ISNULL(O1.S04ID,'''') AS S04ID, 
	ISNULL(O1.S05ID,'''') AS S05ID, ISNULL(O1.S06ID,'''') AS S06ID, ISNULL(O1.S07ID,'''') AS S07ID, ISNULL(O1.S08ID,'''') AS S08ID, 
	ISNULL(O1.S09ID,'''') AS S09ID, ISNULL(O1.S10ID,'''') AS S10ID, ISNULL(O1.S11ID,'''') AS S11ID, ISNULL(O1.S12ID,'''') AS S12ID, 
	ISNULL(O1.S13ID,'''') AS S13ID, ISNULL(O1.S14ID,'''') AS S14ID, ISNULL(O1.S15ID,'''') AS S15ID, ISNULL(O1.S16ID,'''') AS S16ID, 
	ISNULL(O1.S17ID,'''') AS S17ID, ISNULL(O1.S18ID,'''') AS S18ID, ISNULL(O1.S19ID,'''') AS S19ID, ISNULL(O1.S20ID,'''') AS S20ID,
	O1.StandardName01, O1.StandardName02, O1.StandardName03, O1.StandardName04, O1.StandardName05, O1.StandardName06, O1.StandardName07, O1.StandardName08, 
	O1.StandardName09, O1.StandardName10, O1.StandardName11, O1.StandardName12, O1.StandardName13, O1.StandardName14, O1.StandardName15, O1.StandardName16,
	O1.StandardName17, O1.StandardName18, O1.StandardName19, O1.StandardName20,
	I01ID, I02ID, I03ID, I04ID, I05ID, I06ID, I07ID, I08ID, I09ID, I10ID,
	O1.Address, O1.Tel,O1.Email, O1.O01ID, O1.O02ID, O1.O03ID, O1.O04ID, O1.O05ID, O1.O01Name, O1.O02Name, O1.O03Name, O1.O04Name, O1.O05Name, O1.FullName
	' + @sSQL7 + '
FROM		OV3022A O1
'+@sSQL3+'
WHERE 		ISNULL(O1.SalesMan2ID, '''') = ''''
'

Set @sSQL2 =  '
UNION ALL
SELECT O1.DivisionID, SOrderID, VoucherNo, OrderDate, O1.ObjectID, O1.ObjectName, O1.CurrencyID, Orders, OrderStatus, StatusName, InventoryID,
	InventoryName, SName1, SName2, InNotes01, InNotes02, Specification, UnitName, OrderQuantity/2, ActualQuantity/2, QuantityEnd/2,
	ConversionUnitID, ConversionUnitName, ConvertedQuantity, VATPercent, DiscountPercent, CommissionPercent, SalePrice, ConvertedPrice,
	OriginalAmount/2, ConvertedAmount/2, VATOriginalAmount/2, VATConvertedAmount/2, SumOriginalAmount/2, SumConvertedAmount/2,
	DiscountOriginalAmount/2, DiscountConvertedAmount/2, CommissionOAmount/2, CommissionCAmount/2, QuotationID, Shipdate,
	Description, RefInfor, Notes, Notes01, Notes02, SaleOffPercent01, SaleOffAmount01, SaleOffPercent02,
	SaleOffAmount02, SaleOffPercent03, SaleOffAmount03, SaleOffPercent04, SaleOffAmount04, SaleOffPercent05,
	SaleOffAmount05, SalesManID,
	 '+@sSQL4+',
	SalesMan2ID, SalesMan2Name, TDescription, DeliveryAddress, ObjectAddress, Contact, Transport, TOriginalAmount/2, TConvertedAmount/2,
	O1.GroupID, GroupName,
	CityName,
	ClassifyID,
	I01Name,I02Name,I03Name,I04Name,I05Name,I06Name,I07Name,I08Name,I09Name,I10Name,
	Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,  Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
	AnaName01, AnaName02, AnaName03, AnaName04, AnaName05, AnaName06, AnaName07, AnaName08, AnaName09, AnaName10,
	VAna01ID, VAna02ID, VAna03ID, VAna04ID, VAna05ID, VAna01Name, VAna02Name, VAna03Name, VAna04Name, VAna05Name, 
	IsProInventoryID,
	DiscountSaleAmountDetail,
	WareHouseID,WareHouseName, ISNULL(O1.ETaxConvertedUnit,0) AS ETaxConvertedUnit, nvarchar01, nvarchar02, nvarchar03, nvarchar04, nvarchar05,
	nvarchar06, nvarchar07, nvarchar08, nvarchar09, nvarchar10,  nvarchar11, nvarchar12, nvarchar13, nvarchar14, nvarchar15, 
	nvarchar16, nvarchar17, nvarchar18, nvarchar19, nvarchar20,
	ISNULL(O1.S01ID,'''') AS S01ID, ISNULL(O1.S02ID,'''') AS S02ID, ISNULL(O1.S03ID,'''') AS S03ID, ISNULL(O1.S04ID,'''') AS S04ID, 
	ISNULL(O1.S05ID,'''') AS S05ID, ISNULL(O1.S06ID,'''') AS S06ID, ISNULL(O1.S07ID,'''') AS S07ID, ISNULL(O1.S08ID,'''') AS S08ID, 
	ISNULL(O1.S09ID,'''') AS S09ID, ISNULL(O1.S10ID,'''') AS S10ID, ISNULL(O1.S11ID,'''') AS S11ID, ISNULL(O1.S12ID,'''') AS S12ID, 
	ISNULL(O1.S13ID,'''') AS S13ID, ISNULL(O1.S14ID,'''') AS S14ID, ISNULL(O1.S15ID,'''') AS S15ID, ISNULL(O1.S16ID,'''') AS S16ID, 
	ISNULL(O1.S17ID,'''') AS S17ID, ISNULL(O1.S18ID,'''') AS S18ID, ISNULL(O1.S19ID,'''') AS S19ID, ISNULL(O1.S20ID,'''') AS S20ID,
	O1.StandardName01, O1.StandardName02, O1.StandardName03, O1.StandardName04, O1.StandardName05, O1.StandardName06, O1.StandardName07, O1.StandardName08, 
	O1.StandardName09, O1.StandardName10, O1.StandardName11, O1.StandardName12, O1.StandardName13, O1.StandardName14, O1.StandardName15, O1.StandardName16,
	O1.StandardName17, O1.StandardName18, O1.StandardName19, O1.StandardName20,
	I01ID, I02ID, I03ID, I04ID, I05ID, I06ID, I07ID, I08ID, I09ID, I10ID,
	O1.Address, O1.Tel,O1.Email, O1.O01ID, O1.O02ID, O1.O03ID, O1.O04ID, O1.O05ID, O1.O01Name, O1.O02Name, O1.O03Name, O1.O04Name, O1.O05Name, O1.FullName
	' + @sSQL7 + '

FROM		OV3022A O1
'+@sSQL3+'
WHERE 		ISNULL(O1.SalesMan2ID, '''') <> ''''
'
--PRINT (@sSQL1)
--PRINT (@sSQL2)

IF EXISTS(SELECT TOP 1 1 FROM SYSOBJECTS WHERE XTYPE = 'V' AND NAME = 'OV3022')
	DROP VIEW OV3022
EXEC('CREATE VIEW OV3022 AS ' + @sSQL1 + @sSQL2)-- + @sSQL2)    --tao boi OP3022
--EXEC (@sSQL1 + @sSQL2 + @sSQL2)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
