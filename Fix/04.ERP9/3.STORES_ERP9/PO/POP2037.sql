IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2037]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2037]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In Yêu cầu mua hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Như Hàn, Date: 08/12/2018
-- <Example>
---- 
/*-- <Example>
	POP2037 @DivisionID = 'AIC', @UserID = 'ASOFTADMIN', @ROrderList = ''
	
	POP2037 @DivisionID, @UserID, @ROrderList 
----*/
CREATE PROCEDURE POP2037
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @ROrderList XML
)
AS 

CREATE TABLE #ROrderList (ROrderID VARCHAR(50))
INSERT INTO #ROrderList (ROrderID)
SELECT X.Data.query('ROrderID').value('.', 'VARCHAR(50)') AS ROrderID
FROM	@ROrderList.nodes('//Data') AS X (Data)
ORDER BY ROrderID

DECLARE @sSQL NVARCHAR (MAX) = N'',
		@sSQL1 NVARCHAR(MAX) = N'', 
		@sSQL2 NVARCHAR(MAX) = N''

SELECT DISTINCT
	OT3101.DivisionID,
	OT3101.ROrderID, 	
	OT3102.TransactionID, 
	VoucherTypeID, 	
	VoucherNo, 	
	OrderDate,  
	OT3101.Description,
	OT3101.TransPort,
	OT3101.ObjectID,
	OT3101.DueDate,
	OT3101.PaymentID,
	AT1205.PaymentName,
	case when isnull(OT3101.ObjectName, '') = '' then AT1202.ObjectName else 
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
	case when isnull(OT3102. InventoryCommonName, '') = '' then InventoryName else 
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
	OT3101.Ana03ID  as OAna03ID  ,
	OT3101.Ana04ID  as OAna04ID,
	OT3101.Ana05ID  as OAna05ID,
	OT1002.AnaName as AnaName01,
	AT1302.I02ID, AT1015. AnaName,
	OT3102.Notes, OT3102.Notes01, OT3102.Notes02, 
	AT1302.Varchar02, AT1302.Varchar01, AT1302.VArchar03, AT1302.Varchar04, AT1302.Varchar05,
	OT3102.Ana01ID ,
	OT3102.Ana02ID,
	OT3102.Ana03ID,
	OT3102.Ana04ID,
	OT3102.Ana05ID, AT1302.Barcode, OT3102.Description as Description_Detail  
 From OT3102 
	left join AT1302 WITH (NOLOCK) on AT1302.InventoryID= OT3102.InventoryID
	inner join OT3101 WITH (NOLOCK) on OT3101.ROrderID = OT3102.ROrderID AND OT3101.DivisionID = OT3102.DivisionID
	left join OT1002 WITH (NOLOCK) on OT1002.AnaTypeID ='R01' and OT1002.AnaID = OT3101.Ana01ID And OT1002.DivisionID = OT3101.DivisionID
	left join AT1301 WITH (NOLOCK) on AT1301.InventoryTypeID = OT3101.InventoryTypeID
	left join AT1304 WITH (NOLOCK) on AT1304.UnitID = AT1302.UnitID
	left join AT1103 WITH (NOLOCK) on AT1103.EmployeeID = OT3101.EmployeeID
	left join AT1202 WITH (NOLOCK) on AT1202.ObjectID = OT3101.ObjectID
	left join AT1205 WITH (NOLOCK) on AT1205.PaymentID = OT3101.PaymentID
	left join AT1004 WITH (NOLOCK) on AT1004.CurrencyID = OT3101.CurrencyID 
	left join AT1001 WITH (NOLOCK) on AT1001.CountryID = AT1202.CountryID
	left join AT1002 WITH (NOLOCK) on AT1002.CityID = AT1202.CityID
	left join AT1310  AT1310_S1 WITH (NOLOCK) on AT1310_S1.STypeID= 'I01' and AT1310_S1.S = AT1302.S1
	left join AT1310  AT1310_S2 WITH (NOLOCK) on AT1310_S2.STypeID= 'I02' and AT1310_S2.S = AT1302.S2
	left Join AT1015 WITH (NOLOCK) on AT1015.AnaID = AT1302.I02ID
WHERE OT3102.DivisionID = @DivisionID
AND OT3102.ROrderID in (SELECT ROrderID FROM #ROrderList)
ORDER BY OT3101.ROrderID


--PRINT @sSQL
--PRINT @sSQL1
--EXEC (@sSQL+@sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
