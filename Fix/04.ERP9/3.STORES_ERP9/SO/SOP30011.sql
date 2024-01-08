IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In bao cao Tong hop chao gia (Dựa trên báo cáo bên OP)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 22/05/2017 by Phan thanh hoàng vũ
---- Modified on	08/04/2022 by Văn Tài - Bổ sung phân quyền xem đơn hàng VNA.
---- Modified on 17/01/2023 by Anh Đô: Select thêm cột tổng DiscountAmount
---- Modified on 13/02/2923 by Anh Đô: Bổ sung xử lí trừ chiết khấu và cộng thuế cho cột OriginalAmount và ConvertedAmount
---- Modified on 21/02/2023 by Anh Đô: Cập nhật xử lí lọc nhiều theo OrderStatus
-- <Example> EXEC SOP30011 'AS', 'AS'',''GS'',''GC', 1, '2017-01-01', '2017-05-30', '05/2017', '', '', '', '', '0', '' 

CREATE PROCEDURE [dbo].[SOP30011] (
				@DivisionID			NVARCHAR(50),	--Biến môi trường
				@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
				@IsDate				TINYINT,		--1: Theo ngày; 0: Theo kỳ
				@FromDate			DATETIME, 
				@ToDate				DATETIME, 
				@PeriodIDList		NVARCHAR(2000),
				--@FromObjectID		NVARCHAR(MAX),
				--@ToObjectID		NVARCHAR(MAX),
				--@FromSalesManID	NVARCHAR(MAX),
				--@ToSalesManID		NVARCHAR(MAX),
				@ObjectID			NVARCHAR(MAX),
				@EmployeeID		    NVARCHAR(MAX),
				@OrderStatus		NVARCHAR(MAX),	
				@UserID				NVARCHAR(50),	--Biến môi trường
				@ConditionSOrderID  NVARCHAR (MAX) = '' -- Phân quyền xem đơn hàng bán.
				)

AS

DECLARE 
    @sSQL01 NVARCHAR(MAX),
    @sSQL02 NVARCHAR(max),
	@sWhere NVARCHAR(MAX),
	@sFROM nvarchar(500),
	@sSELECT nvarchar(500)
	SET @sWhere = ''
	Set @sFROM = ''
	Set @sSELECT = ''
	
	DECLARE @CustomerName INT = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex)

	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' OT2101.DivisionID IN ('''+@DivisionIDList+''', ''@@@'')'
	ELSE 
		SET @sWhere = @sWhere + ' OT2101.DivisionID IN ('''+@DivisionID+''', ''@@@'')'


	--Search theo điều điện thời gian
	IF @IsDate = 1	
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,OT2101.QuotationDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	ELSE
		SET @sWhere = @sWhere + ' AND (Case When  OT2101.TranMonth <10 then ''0''+rtrim(ltrim(str(OT2101.TranMonth)))+''/''+ltrim(Rtrim(str(OT2101.TranYear))) 
										Else rtrim(ltrim(str(OT2101.TranMonth)))+''/''+ltrim(Rtrim(str(OT2101.TranYear))) End) IN ('''+@PeriodIDList+''')'

	IF Isnull(@ObjectID, '') NOT IN ('%', '')
		SET @sWhere = @sWhere + ' AND OT2101.ObjectID IN ('''+@ObjectID +''')'

	IF Isnull(@EmployeeID, '')!= ''
		SET @sWhere = @sWhere + ' AND OT2101.SalesManID IN ('''+@EmployeeID +''')'

	IF @CustomerName = 147 -- Customize cho VNA
	BEGIN

		IF Isnull(@ConditionSOrderID,'')!=''
			SET @sWhere = @sWhere + ' AND ( 
											ISNULL(OT2101.EmployeeID, '''') IN ('''+@ConditionSOrderID+''' ) 
											OR ISNULL(OT2101.SalesManID, '''') IN ('''+@ConditionSOrderID+''' ) 
										)		'

	END

	----Search theo khách hàng (Dữ liệu khách hàng nhiều nên dùng control từ khách hàng, đến khách hàng)
	--IF Isnull(@FromObjectID, '')!= '' and Isnull(@ToObjectID, '') = ''
	--	SET @sWhere = @sWhere + ' AND OT2101.ObjectID > = N'''+@FromObjectID +''''
	--ELSE IF Isnull(@FromObjectID, '') = '' and Isnull(@ToObjectID, '') != ''
	--	SET @sWhere = @sWhere + ' AND OT2101.ObjectID < = N'''+@ToObjectID +''''
	--ELSE IF Isnull(@FromObjectID, '') != '' and Isnull(@ToObjectID, '') != ''
	--	SET @sWhere = @sWhere + ' AND OT2101.ObjectID Between N'''+@FromObjectID+''' AND N'''+@ToObjectID+''''

	----Search theo người bán hàng (Dữ liệu khách hàng nhiều nên dùng control từ người bán hàng, đến người bán hàng)
	--IF Isnull(@FromSalesManID, '')!= '' and Isnull(@ToSalesManID, '') = ''
	--	SET @sWhere = @sWhere + ' AND OT2101.SalesManID > = N'''+@FromSalesManID +''''
	--ELSE IF Isnull(@FromSalesManID, '') = '' and Isnull(@ToSalesManID, '') != ''
	--	SET @sWhere = @sWhere + ' AND OT2101.SalesManID < = N'''+@ToSalesManID +''''
	--ELSE IF Isnull(@FromSalesManID, '') != '' and Isnull(@ToSalesManID, '') != ''
	--	SET @sWhere = @sWhere + ' AND OT2101.SalesManID Between N'''+@FromSalesManID+''' AND N'''+@ToSalesManID+''''

	IF Isnull(@OrderStatus, '') != ''
		SET @sWhere = @sWhere + ' AND OT2101.OrderStatus IN ('''+@OrderStatus+''')'
	
SET @sSQL01 = ' SELECT OT2101.DivisionID, OT2101.TranMonth, OT2101.TranYear, OT2101.VoucherTypeID, OT2101.ObjectID,
					   CASE WHEN ISNULL(OT2101.ObjectName, '''') <> '''' THEN OT2101.ObjectName ELSE AT1202.ObjectName END AS ObjectName, 
					   CASE WHEN ISNULL(OT2101.Address, '''') <> '''' THEN OT2101.Address ELSE AT1202.Address END AS Address, AT1202.Tel,AT1202.Fax,
					   AT1202.Email,AT1202.BankAccountNo,OT2101.EmployeeID, AT1103.FullName,OT2101.CurrencyID, AT1004.CurrencyName,OT2101.ExchangeRate, 
					   OT2101.QuotationNo, OT2101.QuotationDate, OT2101.RefNo1, OT2101.RefNo2, OT2101.RefNo3, OT2101.Attention1, OT2101.Attention2, 
					   OT2101.Dear, OT2101.Condition, OT2101.SaleAmount, OT2101.PurchaseAmount, OT2101.Disabled, OT2101.Status, OT2101.OrderStatus, 
					   OT2101.IsSO, OT2101.Description, OT2101.CreateDate, OT2101.CreateUserID, OT2101.LastModifyDate, OT2101.LastModifyUserID, 
					   OT2101.InventoryTypeID, OT2101.EndDate, OT2101.Transport, OT2101.DeliveryAddress, OT2101.PaymentID, OT2101.PaymentTermID, 
					   OT2101.Ana01ID, OT2101.Ana02ID, OT2101.Ana03ID, OT1002_1.AnaName AS Ana01Name, OT1002_2.AnaName AS Ana02Name, 
					   OT1002_3.AnaName AS Ana03Name, OT2101.Ana04ID, OT2101.Ana05ID, OT2101.SalesManID,AT01.FullName as SaleManName,OT2101.ClassifyID, 
					   A00002.Name AS OrderStatusName,OV1001.EDescription AS EOrderStatusName,OT2001.SOrderID, 
					   QuoQuantity = (SELECT SUM(ISNULL (QuoQuantity,0)) FROM OT2102 WHERE OT2102.QuotationID = OT2101.QuotationID AND DivisionID = '''+@DivisionID+'''),
					   OriginalAmount = (
							SELECT SUM(ISNULL(OriginalAmount, 0)) - SUM(ISNULL(DiscountAmount, 0)) + SUM(ISNULL(VATOriginalAmount, 0)) 
							FROM OT2102 WHERE OT2102.QuotationID = OT2101.QuotationID AND DivisionID = '''+@DivisionID+'''),
					   ConvertedAmount = (
							SELECT SUM(ISNULL(ConvertedAmount, 0)) - SUM(ISNULL(DiscountAmount, 0)) * ISNULL(OT2101.ExchangeRate, 1) + SUM(ISNULL(VATConvertedAmount, 0))
							FROM OT2102 WHERE OT2102.QuotationID = OT2101.QuotationID AND DivisionID = '''+@DivisionID+'''),
					   VATOriginalAmount = (SELECT SUM(ISNULL(VATOriginalAmount, 0)) FROM OT2102 WHERE OT2102.QuotationID = OT2101.QuotationID AND DivisionID = '''+@DivisionID+'''),
					   VATConvertedAmount = (SELECT SUM(ISNULL(VATConvertedAmount, 0)) FROM OT2102 WHERE OT2102.QuotationID = OT2101.QuotationID AND DivisionID = '''+@DivisionID+'''),
					   DiscountOriginalAmount = (SELECT SUM(ISNULL(DiscountOriginalAmount, 0)) FROM OT2102 WHERE OT2102.QuotationID = OT2101.QuotationID AND DivisionID = '''+@DivisionID+'''),
					   DiscountConvertedAmount = (SELECT SUM(ISNULL(DiscountConvertedAmount, 0)) FROM OT2102 WHERE OT2102.QuotationID = OT2101.QuotationID AND DivisionID = '''+@DivisionID+'''),
					   OT2102.Ana01ID as AnaID01,OT2102.Ana02ID as AnaID02,OT2102.Ana03ID as AnaID03,OT2102.Ana04ID as AnaID04,OT2102.Ana05ID as AnaID05,
					   OT2102.Ana06ID as AnaID06,OT2102.Ana07ID as AnaID07,OT2102.Ana08ID as AnaID08,OT2102.Ana09ID as AnaID09,OT2102.Ana10ID as AnaID10,
					   A01.AnaName as AnaName01,A02.AnaName as AnaName02,A03.AnaName as AnaName03,A04.AnaName as AnaName04,A05.AnaName as AnaName05,
					   A06.AnaName as AnaName06,A07.AnaName as AnaName07,A08.AnaName as AnaName08,A09.AnaName as AnaName09,A10.AnaName as AnaName10,
					   OT2102.QD01,OT2102.QD02,OT2102.QD03,OT2102.QD04,OT2102.QD05, OT2102.QD06,OT2102.QD07,OT2102.QD08,OT2102.QD09,OT2102.QD10
					   ,OT2102.InventoryID,AT02.InventoryName
					   ,DiscountAmount = (SELECT SUM(ISNULL(DiscountAmount, 0)) FROM OT2102 WHERE OT2102.QuotationID = OT2101.QuotationID AND DivisionID = '''+@DivisionID+''')'

SET @sSQL02 = ' FROM OT2101 LEFT JOIN OV1001           WITH (NOLOCK) ON OV1001.DivisionID = OT2101.DivisionID    AND OV1001.OrderStatus = OT2101.OrderStatus AND OV1001.TypeID=''QO''
							LEFT JOIN OT2001           WITH (NOLOCK) ON OT2001.DivisionID = OT2101.DivisionID    AND OT2001.QuotationID = OT2101.QuotationID
							LEFT JOIN AT1202           WITH (NOLOCK) ON AT1202.ObjectID = OT2101.ObjectID
							LEFT JOIN AT1103           WITH (NOLOCK) ON AT1103.EmployeeID = OT2101.EmployeeID
							LEFT JOIN OT1002 OT1002_1  WITH (NOLOCK) ON OT1002_1.DivisionID = OT2101.DivisionID  AND OT1002_1.AnaTypeID = ''S01'' AND OT1002_1.AnaID = OT2101.Ana01ID
							LEFT JOIN OT1002 OT1002_2  WITH (NOLOCK) ON OT1002_2.DivisionID = OT2101.DivisionID  AND OT1002_2.AnaTypeID = ''S02'' AND OT1002_2.AnaID = OT2101.Ana02ID
							LEFT JOIN OT1002 OT1002_3  WITH (NOLOCK) ON OT1002_3.DivisionID = OT2101.DivisionID  AND OT1002_3.AnaTypeID = ''S03'' AND OT1002_3.AnaID = OT2101.Ana03ID
							LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.DivisionID = OT2101.DivisionID AND AT1004.CurrencyID = OT2101.CurrencyID
							LEFT JOIN (SELECT O02.DivisionID, O02.QuotationID, O02.Ana01ID, O02.Ana02ID,O02.Ana03ID,O02.Ana04ID,O02.Ana05ID,
											  O02.Ana06ID,O02.Ana07ID,O02.Ana08ID,O02.Ana09ID,O02.Ana10ID,O02.QD01,O02.QD02,O02.QD03,O02.QD04,
											  O02.QD05,O02.QD06,O02.QD07,O02.QD08,O02.QD09,O02.QD10, O02.InventoryID
									   FROM OT2102 O02 	WITH (NOLOCK) WHERE O02.DivisionID = ''' + @DivisionID + ''' AND O02.Orders = 1
									   ) OT2102	ON OT2102.DivisionID = OT2101.DivisionID	AND OT2102.QuotationID = OT2101.QuotationID
							left join AT1011 A01 WITH (NOLOCK) on A01.AnaTypeID = ''A01'' and A01.AnaID = OT2102.Ana01ID  
							left join AT1011 A02 WITH (NOLOCK) on A02.AnaTypeID = ''A02'' and A02.AnaID = OT2102.Ana02ID  
							left join AT1011 A03 WITH (NOLOCK) on A03.AnaTypeID = ''A03'' and A03.AnaID = OT2102.Ana03ID  
							left join AT1011 A04 WITH (NOLOCK) on A04.AnaTypeID = ''A04'' and A04.AnaID = OT2102.Ana04ID  
							left join AT1011 A05 WITH (NOLOCK) on A05.AnaTypeID = ''A05'' and A05.AnaID = OT2102.Ana05ID  
							left join AT1011 A06 WITH (NOLOCK) on A06.AnaTypeID = ''A06'' and A06.AnaID = OT2102.Ana06ID  
							left join AT1011 A07 WITH (NOLOCK) on A07.AnaTypeID = ''A07'' and A07.AnaID = OT2102.Ana07ID  
							left join AT1011 A08 WITH (NOLOCK) on A08.AnaTypeID = ''A08'' and A08.AnaID = OT2102.Ana08ID  
							left join AT1011 A09 WITH (NOLOCK) on A09.AnaTypeID = ''A09'' and A09.AnaID = OT2102.Ana09ID  
							left join AT1011 A10 WITH (NOLOCK) on A10.AnaTypeID = ''A10'' and A10.AnaID = OT2102.Ana10ID
							LEFT JOIN A00002 WITH (NOLOCK) ON OV1001.Description = A00002.ID and LanguageID = ''vi-VN''
							LEFT JOIN AT1103 AT01 WITH (NOLOCK) ON AT01.EmployeeID = OT2101.SalesManID
							LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.InventoryID = OT2102.InventoryID
          
				Where ' + @sWhere +
				' Order by OT2101.QuotationDate, OT2101.QuotationNo'

EXEC (@sSQL01 + @sSQL02)

print @sSQL01 
print @sSQL02


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
