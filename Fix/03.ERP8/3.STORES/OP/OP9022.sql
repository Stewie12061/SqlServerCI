IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP9022]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP9022]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----Created by: Nguyen Quoc Huy, date: 02/03/2009
----purpose: In Debit Note
-- Last edit, 27/04/2008
---Edit by Trung Dung, Date 27/06/2011
---Them bien Conn de xu ly tranh chap du lieu

---- Modified by Kim Thư on 08/05/2019: Sửa store trả thẳng dữ liệu, không qua view
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Xuân Nguyên on 13/04/2023: [2023/04/IS/0084] - Fix lỗi Ambiguous column ClassifyID

-- exec OP9022 @DivisionID='SB', @TranMonth=3, @TranYear=2019, @OrderID='3RD2/03/2019/0001'
CREATE PROCEDURE OP9022 @DivisionID as varchar(20),
				@TranMonth as int,
				@TranYear as int,
				@OrderID as varchar(8000)

AS
Declare @sSQL as varchar(8000)

Set @sSQL = 
'Select  OT2001.DivisionID, OT2001.SOrderID, 	TransactionID, 
	VoucherTypeID, 	VoucherNo, 	OrderDate, 	
	ContractNo,	 	ContractDate,
	OT2001.CurrencyID,
	OT2001.ObjectID, AT1202.ObjectName ,AT1202.Address ,  AT1202.VATNo as OVATNo, AT1202.Tel, AT1202.Fax, AT1202.Email,
	OT2001.DeliveryAddress,
 	OT2001.Notes as Descrip,
	OT2001.SalesManID, 	AT1103_2.FullName as SalesManName, 
	OT2001.TransPort,
	OT2001.EmployeeID, AT1103.FullName, AT1103.Address as EmployeeAddress,
	OT2002.InventoryID, 	isnull(OT2002.InventoryCommonName, 	AT1302.InventoryName)  as InventoryName,  
	AT1302.UnitID, 		AT1304.UnitName,
	AT1002.CityName,
	AT1302.Notes01 as InNotes01, AT1302.Notes02 as InNotes02, AT1302.notes03 as InNotes03, AT1302.Specification,
	AT1310_S1.SName as SName1, AT1310_S2.SName as SName2,

	OT2002.MethodID, 	MethodName, 	
	AT1208.PaymentTermName, 
	OrderQuantity, 		OT2002.SalePrice, 	OT2001.ExchangeRate, 
	case when AT1004.Operator = 0 or OT2001.ExchangeRate = 0  then SalePrice*OT2001.ExchangeRate else
	OT2002.SalePrice/OT2001.ExchangeRate  end as SalePriceConverted,
	isnull(ConvertedAmount,0) as ConvertedAmount, 
	isnull(OriginalAmount,0) as OriginalAmount, 
	OT2002.VATPercent, 	
	isnull(VATConvertedAmount,0) as VATConvertedAmount, 	
	isnull(VATOriginalAmount, 0) as VATOriginalAmount,
	DiscountPercent, 	
	isnull(DiscountConvertedAmount,0) as DiscountConvertedAmount, 	
	isnull(DiscountOriginalAmount,0) as DiscountOriginalAmount,
	OT2002.CommissionPercent, 	
	isnull(OT2002.CommissionCAmount, 0) as CommissionCAmount,
	 isnull(OT2002.CommissionOAmount,0) as CommissionOAmount, 
	IsPicking, OT2002.WareHouseID, WareHouseName, OT2002.ShipDate, OT2002.RefInfor,
	OT2002.Orders, AT1205.PaymentName, AT1004.CurrencyName,
	isnull(OT2002.OriginalAmount, 0) + isnull(OT2002.VATOriginalAmount, 0)	 -
	 isnull(OT2002.DiscountOriginalAmount, 0) - isnull(CommissionOAmount,0) as TotalOriginalAmount,
	isnull(OT2002.ConvertedAmount, 0) + isnull(OT2002.VATConvertedAmount, 0) - 
	isnull(OT2002.DiscountConvertedAmount, 0)-isnull(CommissionCAmount, 0)as TotalConvertedAmount,
	OT2001.Ana01ID, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.Ana04ID, OT2001.Ana05ID, 
	OT1002_2.AnaName as AnaName2,
	OT1002_3.AnaName as AnaName3,
	OT1002_4.AnaName as AnaName4,
	OT1002_5.AnaName as AnaName5,
 	OT2002.Description ,
	
	isnull (OT2001.Contact, AT1202.contactor)as contactor ,
	OT2002.Notes, OT2002.Notes01, OT2002.Notes02, OT2002.Notes03, OT2002.Notes04, OT2002.Notes05,
	OT2001.VATObjectID,
	Isnull(OT2001.VATObjectName,T02.ObjectName) as VATObjectName,
	isnull(OT2001.Address,		 T02.Address) as VATAddress,
	Isnull(OT2001.VATNo,T02.VatNo) as VATNo ,
	OT2002.EndDate,
	AT1302.Varchar01, AT1302.Varchar02, AT1302.Varchar03, AT1302.varchar04, AT1302.varchar05,
	AT1302.I01ID,T15.AnaName as AnaNameI01,  AT1302.I02ID, T16.AnaName as AnaNameI02,
	 AT1302.I03ID, T17.AnaName as AnaNameI03,
	 AT1302.I04ID, AT1302.I05ID,

	OT2002.Date01,OT2002.Date02, OT2002.Date03, OT2002.Date04, OT2002.Date05,
	OT2002.ObjectID01, OT2002.RefName01, OT2002.ObjectName01, OT2002.ObjectAddress01, OT2002.ObjectCity01, OT2002.ObjectState01, OT2002.ObjectCntry01, OT2002.ObjectZip01, 
	OT2002.ObjectID02, OT2002.RefName02, OT2002.ObjectName02, OT2002.ObjectAddress02, OT2002.ObjectCity02, OT2002.ObjectState02, OT2002.ObjectCntry02, OT2002.ObjectZip02,
	OT2002.Cal01,OT2002.cal02,OT2002.Cal03,OT2002.Cal04, OT2002.Cal05,OT2002.Aut, OT2002.Cut,OT2002.OrigLocn, OT2002.DestLocn, OT2002.SvType, OT2002.SvAbbrew, 
		OT2002.SurDesc1, OT2002.SurDesc2, OT2002.SurDesc3, OT2002.SurDesc4, 
		OT2002.SurDesc5, OT2002.SurDesc6, OT2002.SurDesc7, OT2002.SurDesc8,
	OT2002.Quantity01,Ot2002.Quantity02,OT2002.Quantity03, OT2002.Quantity04,Ot2002.Quantity05,OT2002.Quantity06,
		OT2002.Quantity07,Ot2002.Quantity08,OT2002.Quantity09, OT2002.Quantity10,Ot2002.Quantity11,OT2002.Quantity12,
	AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID, AT1001.CountryName,OT2001.ClassifyID

From OT2002 left join AT1302 on AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID= OT2002.InventoryID	
	            			
	left join OT1003 on OT1003.MethodID = OT2002.MethodID 
	inner join OT2001 on OT2002.DivisionID = OT2001.DivisionID and OT2001.SOrderID = OT2002.SOrderID
	left join AT1205 on AT1205.PaymentID = OT2001.PaymentID  
	left join AT1303 on AT1303.DivisionID IN (''@@@'', '''+@DivisionID+''') AND AT1303.WareHouseID = OT2002.WareHouseID
	left join AT1301 on AT1301.InventoryTypeID = OT2001.InventoryTypeID 	
	left join AT1304 on AT1304.UnitID = AT1302.UnitID	         
	left join AT1103 on AT1103.EmployeeID = OT2001.EmployeeID and AT1103.DivisionID = OT2001.DivisionID
	left join AT1103 AT1103_2 on AT1103_2.EmployeeID = OT2001.SalesManID and AT1103_2.DivisionID = OT2001.DivisionID
	left join AT1004 on AT1004.CurrencyID = OT2001.CurrencyID
	left join AT1202 on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT2001.ObjectID
	left join AT1202 T02 on T02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T02.ObjectID = OT2001.VATObjectID
	left join AT1208 on AT1208.PaymentTermID = OT2001.PaymentTermID
	left join AT1310  AT1310_S1 on AT1310_S1.STypeID= ''I01'' and AT1310_S1.S = AT1302.S1 
	left join AT1310  AT1310_S2 on AT1310_S2.STypeID= ''I02'' and AT1310_S2.S = AT1302.S2
	left join OT1002	OT1002_2 on OT1002_2.AnaID = OT2001.Ana02ID and  OT1002_2.AnaTypeID = ''S02'' 
	left join OT1002	OT1002_3 on OT1002_3.AnaID = OT2001.Ana03ID and  OT1002_3.AnaTypeID = ''S03'' 
	left join OT1002	OT1002_4 on OT1002_4.AnaID = OT2001.Ana04ID and  OT1002_4.AnaTypeID = ''S04'' 
	left join OT1002	OT1002_5 on OT1002_5.AnaID = OT2001.Ana05ID and  OT1002_5.AnaTypeID = ''S05'' 
	left join AT1002 on AT1002.CityID = AT1202.CityID
	Left Join AT1001 on  AT1001.CountryID = OT2002.ObjectCntry02

	Left Join AT1015  T15 on  T15.AnaID = AT1302.I01ID and T15. AnaTypeID =''I01''
	Left Join AT1015   T16 on T16.AnaID = AT1302.I02ID and T16.AnaTypeID =''I02''
	Left Join AT1015  T17  on  T17.AnaID = AT1302.I03ID and  T17.AnaTypeID =''I03''

Where OT2001.DivisionID = ''' + @DivisionID + ''' and 
	 OT2001.SOrderID in ( ''' + @OrderID + ''')'

--Print @sSQL

	--If Not Exists (Select 1 From sysObjects Where Name ='OV9022')
	--	Exec ('Create view OV9022  ---tao boi OP9022
	--		as '+@sSQL)
	--Else
	--	Exec( 'Alter view OV9022  ---tao boi OP9022
	--		as '+@sSQL)
			
	--If Not Exists (Select 1 From sysObjects Where Name ='OV9022' + @Conn)
	--	Exec ('Create view OV9022' + @Conn + '  ---tao boi OP9022
	--		as '+@sSQL)
	--Else
	--	Exec( 'Alter view OV9022' + @Conn + '    ---tao boi OP9022
	--		as '+@sSQL)
PRINT @sSQL
EXEC (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
