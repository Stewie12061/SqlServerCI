IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP3101]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP3101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




----Created by:Nguyen Thi Thuy Tuyen, date:30/10/2006
----purpose: In Yeu cau mua hang
--- Last edit: Thuy Tuyen date : 24/04/2009  LAy so luong ton kho thu te.
---22/07/2009,30/07/2009
--Edit by: Thuy Tuyen, date 19/05/2010 lay so luong ton kho thuc te theo ngay lap yeu cau mua hang
 /********************************************
'* Edited by: [GS] [Mỹ Tuyền] [02/08/2010]
'********************************************/
--Edit by: Mai Duyen, date 20/04/2015: Bo Sung AT1302.Barcode
---- Modified by Tiểu Mai on 18/07/2016: Bổ sung thông tin quy cách theo thiết lập
---- Modified by Phương Thảo on 15/05/2017: Sửa danh mục dùng chung
---- Modified by Tiểu Mai on 07/08/2017: Lấy trường OT3102.Description
---- Modified by Hồng Thảo on 05/12/2018 Lấy trường  OT3102.StockCurrent (CustomerIndex=32 Phuc Long)
---- Modified by Hồng Thảo on 07/12/2018 Lấy trường  OT3102.Ana06ID,T1.AnaName AS Ana06Name (CustomerIndex=32 Phuc Long)
---- Modified by Kim Thư on 15/02/2019 Lấy trường OrderStatus - Trạng thái yêu cầu mua hàng
---- Modified by Khánh Đoan on 09/26/2019 Lây trường ConfirmUserID, ConfirmDate, ConfirmUserName
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/*
exec OP3101 @Divisionid=N'HT',@Tranmonth=6,@Tranyear=2016,@Orderid=N'YC/06/2016/0001'
*/

 
CREATE PROCEDURE [dbo].[OP3101] @DivisionID as nvarchar(50),
				 @TranMonth as int,
				 @TranYear as int,
				 @OrderID as nvarchar(50)
				
AS
Declare @sSQL as nvarchar(max),
		@sSQL1 as  nvarchar (max),
		@sSQL2 as nvarchar(max) = '',
		@sSQL3 as  nvarchar (max) = '',
		@OrderDate as datetime

Set  @OrderDate = ( select Orderdate from OT3101 where  OT3101.ROrderID = @OrderID AND DivisionID=@DivisionID)

------- Quản lý theo quy cách hàng hóa
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	SET @sSQL2 = ',
				O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
				O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
				A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
				A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
				A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
				A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
				A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20,
				B.S01, B.S02, B.S03, B.S04, B.S05, B.S06, B.S07, B.S08, B.S09, B.S10,
				B.S11, B.S12, B.S13, B.S14, B.S15, B.S16, B.S17, B.S18, B.S19, B.S20
					'
	
	SET @sSQL3 = '
		LEFT JOIN OT8899 O99 WITH (NOLOCK) ON OT3102.DivisionID = O99.DivisionID AND OT3102.ROrderID = O99.VoucherID AND O99.TransactionID = OT3102.TransactionID AND O99.TableID = ''OT3102''
		FULL JOIN (SELECT * FROM  (SELECT UserName, TypeID, DivisionID
		                   FROM AT0005 WITH (NOLOCK) WHERE TypeID LIKE ''S__'') b PIVOT (max(Username) for TypeID IN (S01, S02, S03, S04, S05, S06, S07, S08, S09, S10,
																										S11, S12, S13, S14, S15, S16, S17, S18, S19, S20))  AS a) B ON B.DivisionID in (OT3102.DivisionID,''@@@'')
		LEFT JOIN AT0128 A01 WITH (NOLOCK) ON O99.S01ID = A01.StandardID AND A01.StandardTypeID = ''S01''
		LEFT JOIN AT0128 A02 WITH (NOLOCK) ON O99.S02ID = A02.StandardID AND A02.StandardTypeID = ''S02''
		LEFT JOIN AT0128 A03 WITH (NOLOCK) ON O99.S03ID = A03.StandardID AND A03.StandardTypeID = ''S03''
		LEFT JOIN AT0128 A04 WITH (NOLOCK) ON O99.S04ID = A04.StandardID AND A04.StandardTypeID = ''S04''
		LEFT JOIN AT0128 A05 WITH (NOLOCK) ON O99.S05ID = A05.StandardID AND A05.StandardTypeID = ''S05''
		LEFT JOIN AT0128 A06 WITH (NOLOCK) ON O99.S06ID = A06.StandardID AND A06.StandardTypeID = ''S06''
		LEFT JOIN AT0128 A07 WITH (NOLOCK) ON O99.S07ID = A07.StandardID AND A07.StandardTypeID = ''S07''
		LEFT JOIN AT0128 A08 WITH (NOLOCK) ON O99.S08ID = A08.StandardID AND A08.StandardTypeID = ''S08''
		LEFT JOIN AT0128 A09 WITH (NOLOCK) ON O99.S09ID = A09.StandardID AND A09.StandardTypeID = ''S09''
		LEFT JOIN AT0128 A10 WITH (NOLOCK) ON O99.S10ID = A10.StandardID AND A10.StandardTypeID = ''S10''
		LEFT JOIN AT0128 A11 WITH (NOLOCK) ON O99.S11ID = A11.StandardID AND A11.StandardTypeID = ''S11''
		LEFT JOIN AT0128 A12 WITH (NOLOCK) ON O99.S12ID = A12.StandardID AND A12.StandardTypeID = ''S12''
		LEFT JOIN AT0128 A13 WITH (NOLOCK) ON O99.S13ID = A13.StandardID AND A13.StandardTypeID = ''S13''
		LEFT JOIN AT0128 A14 WITH (NOLOCK) ON O99.S14ID = A14.StandardID AND A14.StandardTypeID = ''S14''
		LEFT JOIN AT0128 A15 WITH (NOLOCK) ON O99.S15ID = A15.StandardID AND A15.StandardTypeID = ''S15''
		LEFT JOIN AT0128 A16 WITH (NOLOCK) ON O99.S16ID = A16.StandardID AND A16.StandardTypeID = ''S16''
		LEFT JOIN AT0128 A17 WITH (NOLOCK) ON O99.S17ID = A17.StandardID AND A17.StandardTypeID = ''S17''
		LEFT JOIN AT0128 A18 WITH (NOLOCK) ON O99.S18ID = A18.StandardID AND A18.StandardTypeID = ''S18''
		LEFT JOIN AT0128 A19 WITH (NOLOCK) ON O99.S19ID = A19.StandardID AND A19.StandardTypeID = ''S19''
		LEFT JOIN AT0128 A20 WITH (NOLOCK) ON O99.S20ID = A20.StandardID AND A20.StandardTypeID = ''S20''
		'
END ------- Quản lý theo quy cách hàng hóa

Set @sSQL = 
'Select Distinct
	OT3101.DivisionID,
	OT3101.ROrderID, 	
	OT3102.TransactionID, 
	VoucherTypeID, 	
	VoucherNo, 	
	OrderDate,  
	OT3101.Description,
	OT3101.TransPort,
	OT3101.ObjectID, 	
	case when isnull(OT3101.ObjectName, '''') = '''' then AT1202.ObjectName else 
	OT3101.ObjectName end as ObjectName,
	AT1202.Website, AT1202.Contactor,
	AT1202.Tel, AT1202.Fax,  OT3101.ReceivedAddress,  
	isnull(OT3101.Address, AT1202.Address)  as ObjectAddress, 
	AT1002.CityName,
	OT3101.CurrencyID,  AT1004.CurrencyName,
	OT3101.ShipDate, OT3101.ExchangeRate, 
	OT3101.ContractNo, OT3101.ContractDate,
	AT1001.CountryName,  	
	AT1205.PaymentName,		OT3101.EmployeeID, 
	AT1103.FullName, 	AT1103.Address as EmployeeAddress,
	OT3102.InventoryID, 	
	case when isnull(OT3102. InventoryCommonName, '''') = '''' then InventoryName else 
	OT3102.InventoryCommonName end as InventoryName, 
	AT1302.UnitID, 
	AT1304.UnitName, 
	AT1302.Specification,
	AT1302.Notes01 as InNotes01, AT1302.Notes02 as InNotes02,
	AT1310_S1.SName as SName1, AT1310_S2.SName as SName2,
	OrderQuantity, 
	RequestPrice, 
	case when AT1004.Operator = 0 or OT3101.ExchangeRate = 0  then OT3102.RequestPrice*OT3101.ExchangeRate else
	OT3102.RequestPrice/OT3101.ExchangeRate  end as RequestPriceConverted,
	isnull(ConvertedAmount,0) as ConvertedAmount,  
	isnull(OriginalAmount, 0) as OriginalAmount,	
	OT3102.VATPercent,
	VATOriginalAmount,
	OT3102.VATConvertedAmount,
	DiscountPercent, 
	isnull(DiscountConvertedAmount,0) as DiscountConvertedAmount,  
	isnull(DiscountOriginalAmount,0) as DiscountOriginalAmount,
	isnull(OT3102.OriginalAmount, 0) + isnull(OT3102.VATOriginalAmount, 0) - isnull(OT3102.DiscountOriginalAmount, 0) as TotalOriginalAmount,
	isnull(OT3102.ConvertedAmount, 0) + isnull(OT3102.VATConvertedAmount, 0) - isnull(OT3102.DiscountConvertedAmount, 0) as TotalConvertedAmount,
	OT3102.Orders,
	OT3101.Ana01ID as OAna01ID ,
	OT3101.Ana02ID as OAna02ID,
	OT3101.Ana03ID  as OAna03ID ,
	OT3101.Ana04ID  as OAna04ID,
	OT3101.Ana05ID  as OAna05ID,
	OT1002.AnaName as AnaName01,
	AT1302.I02ID, AT1015. AnaName,
	OT3102.Notes, OT3102.Notes01, OT3102.Notes02, A.EndQuantity,
	AT1302.Varchar02, AT1302.Varchar01, AT1302.VArchar03, AT1302.Varchar04, AT1302.Varchar05,
	OT3102.Ana01ID, 
	OT3102.Ana02ID,
	OT3102.Ana03ID,
	OT3102.Ana04ID,
	OT3102.Ana05ID,OT3102.Ana06ID,T1.AnaName AS Ana06Name, T2.AnaName AS Ana04Name, AT1302.Barcode, OT3102.Description as Description_Detail, OT3102.StockCurrent,
	OT3101.OrderStatus,OT3101.ConfirmUserID,OT3101.ConfirmDate ,AT1405.UserName AS ConfirmUserName  '
	
Set @sSQL1 =' From OT3102 
	left join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (''@@@'', OT3102.DivisionID) AND AT1302.InventoryID= OT3102.InventoryID
	inner join OT3101 WITH (NOLOCK) on OT3101.ROrderID = OT3102.ROrderID AND OT3101.DivisionID = OT3102.DivisionID
	left join OT1002  WITH (NOLOCK) on OT1002.AnaTypeID =''P01'' and OT1002.AnaID = OT3101.Ana01ID And OT1002.DivisionID = OT3101.DivisionID
	
	left join AT1301 WITH (NOLOCK) on AT1301.InventoryTypeID = OT3101.InventoryTypeID
	left join AT1304 WITH (NOLOCK) on AT1304.UnitID = AT1302.UnitID
	left join AT1103 WITH (NOLOCK) on AT1103.EmployeeID = OT3101.EmployeeID
	left join AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT3101.ObjectID
	left join AT1205 WITH (NOLOCK) on AT1205.PaymentID = OT3101.PaymentID
	left join AT1004 WITH (NOLOCK) on AT1004.CurrencyID = OT3101.CurrencyID 
	left join AT1001 WITH (NOLOCK) on AT1001.CountryID = AT1202.CountryID
	left join AT1002 WITH (NOLOCK) on AT1002.CityID = AT1202.CityID
	left join AT1310  AT1310_S1 WITH (NOLOCK) on AT1310_S1.STypeID= ''I01'' and AT1310_S1.S = AT1302.S1
	left join AT1310  AT1310_S2 WITH (NOLOCK) on AT1310_S2.STypeID= ''I02'' and AT1310_S2.S = AT1302.S2
	LEFT JOIN AT1011 T1 ON T1.AnaID = OT3102.Ana06ID AND T1.AnaTypeID = ''A06''
	LEFT JOIN AT1011 T2 ON T2.AnaID = OT3102.Ana04ID AND T2.AnaTypeID = ''A04''
	left Join AT1015 WITH (NOLOCK) on AT1015.AnaID = AT1302.I02ID
	LEFT JOIN AT1405 WITH (NOLOCK) ON  AT1405.UserID = OT3101.ConfirmUserID
	left join ( Select Top 100 Percent DivisionID, InventoryID,	sum(isnull(EndQuantity,0)) as EndQuantity
		From OV2411 Where DivisionID = ''' + @DivisionID + '''  and
				           VoucherDate <= ''' +  convert(nvarchar(10), @OrderDate, 101)  + '''	 -- lay so luong ton kho thu te (khong xet thoi gian OV2401 ,  neu tinh thoi gian OV2411
	
		Group by DivisionID, InventoryID
		Having  sum(isnull(EndQuantity,0)) <>0
		Order By DivisionID, InventoryID ) as A on A.DivisionID = OT3101.DivisionID and 
						          		     	 A.InventoryID = OT3102.InventoryID --and
									----A.WareHouseID = OT3101.Ana01ID
'	

--print @sSQL
--PRINT @sSQL2
--PRINT @sSQL1
--PRINT @sSQL3
	 
If Not Exists (Select 1 From sysObjects Where Name ='OV3101')
	Exec ('Create view OV3101  ---tao boi OP3101
		as '+@sSQL + @sSQL2 + @sSQL1 + @sSQL3 + '
			Where OT3101.DivisionID = ''' + @DivisionID + ''' and 
					OT3101.ROrderID = ''' + @OrderID + '''')
Else
	Exec( 'Alter view OV3101  ---tao boi OP3101
		as '+@sSQL + @sSQL2 + @sSQL1 + @sSQL3 + '
			Where OT3101.DivisionID = ''' + @DivisionID + ''' and 
				OT3101.ROrderID = ''' + @OrderID + '''')



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
