IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP30021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP30021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Purpose: In bao cao Tong hop Don hang mua (ERP 9.0)
---- Create By Thị Phượng On 14/08/2017
---- Modified by 
---- Example EXEC POP30021 'MS', '', 1, '2017-01-01', '2017-08-30', '08/2017',  '', '', '0', 'PHUONG'

CREATE PROCEDURE [dbo].[POP30021] 
				@DivisionID			NVARCHAR(50),	--Biến môi trường
				@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
				@IsDate				TINYINT,		--1: Theo ngày; 0: Theo kỳ
				@FromDate			DATETIME, 
				@ToDate				DATETIME, 
				@PeriodIDList		NVARCHAR(2000),
				@FromObjectID		NVARCHAR(MAX),
				@ToObjectID			NVARCHAR(MAX),	
				@OrderStatus		NVARCHAR(MAX),	
				@UserID				NVARCHAR(50)	--Biến môi trường		
AS
BEGIN
	DECLARE @sSQL01 NVARCHAR(max),
			@sSQL02 NVARCHAR(max),
			@sWhere NVARCHAR(max)
    
    Set @sWhere = ''
    
	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWHERE = @sWhere + ' M.DivisionID IN ('''+@DivisionIDList+''', ''@@@'')'
	ELSE 
		SET @sWHERE = @sWhere + ' M.DivisionID IN ('''+@DivisionID+''', ''@@@'')'


	--Search theo điều điện thời gian
	IF @IsDate = 1	
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,M.OrderDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	ELSE
		SET @sWhere = @sWhere + ' AND (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
										Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'

	--Search theo khách hàng (Dữ liệu khách hàng nhiều nên dùng control từ khách hàng, đến khách hàng)
	IF Isnull(@FromObjectID, '')!= '' and Isnull(@ToObjectID, '') = ''
		SET @sWhere = @sWhere + ' AND Isnull(M.ObjectID, '''') > = N'''+@FromObjectID +''''
	ELSE IF Isnull(@FromObjectID, '') = '' and Isnull(@ToObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.ObjectID, '''') < = N'''+@ToObjectID +''''
	ELSE IF Isnull(@FromObjectID, '') != '' and Isnull(@ToObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.ObjectID, '''') Between N'''+@FromObjectID+''' AND N'''+@ToObjectID+''''

	IF Isnull(@OrderStatus, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.OrderStatus, '''') = '+@OrderStatus+''


Set @sSQL01 = '
Select 	M.DivisionID, 	A.DivisionName,
		M.POrderID, 
		M.VoucherTypeID, 
		M.VoucherNo, 
		M.ClassifyID, 
		M.InventoryTypeID, 
		M.CurrencyID, 
		AT1004.CurrencyName,
		M.ExchangeRate, 
		M.OrderType, 
		M.ObjectID, 
		case when isnull(M.ObjectName, '''') <> '''' then M.ObjectName else AT1202.ObjectName end as ObjectName,
		M.OrderStatus, 
		AT0099.Description as OrderStatusName,		
		M.OrderDate, 
		M.Transport, 
		M.PaymentID, 
		M.ShipDate, 
		M.ContractNo, 
		M.DueDate,
		OriginalAmount = (Select sum(isnull(OriginalAmount, 0)) From OT3002 Where OT3002.POrderID = M.POrderID ),
		ConvertedAmount = (Select sum(isnull(ConvertedAmount, 0)) From OT3002 Where OT3002.POrderID = M.POrderID ),
		VATOriginalAmount = (Select sum(isnull(VATOriginalAmount, 0)) From OT3002 Where OT3002.POrderID = M.POrderID ),
		VATConvertedAmount = (Select sum(isnull(VATConvertedAmount, 0)) From OT3002 Where OT3002.POrderID = M.POrderID ),
		DiscountOriginalAmount = (Select sum(isnull(DiscountOriginalAmount, 0)) From OT3002 Where OT3002.POrderID = M.POrderID ),
		DiscountConvertedAmount = (Select sum(isnull(DiscountConvertedAmount, 0)) From OT3002 Where OT3002.POrderID = M.POrderID ),
		SumConvertedAmount =  (Select sum(isnull(ConvertedAmount, 0)) From OT3002 Where OT3002.POrderID = M.POrderID )+ (Select sum(isnull(VATConvertedAmount, 0)) From OT3002 Where OT3002.POrderID = M.POrderID ) - (Select sum(isnull(DiscountConvertedAmount, 0)) From OT3002 Where OT3002.POrderID = M.POrderID )
		'
		
SET @sSQL02 = 'FROM OT3001 M
LEFT JOIN (select OT3002.Ana01ID, OT3002.Ana02ID, OT3002.Ana03ID, OT3002.Ana04ID, OT3002.Ana05ID, OT3002.Ana06ID, OT3002.Ana07ID, OT3002.Ana08ID, OT3002.Ana09ID, OT3002.Ana10ID, OT3002.POrderID, OT3002.DivisionID 
           FROM OT3002 where OT3002.DivisionID = ''' + @DivisionID + ''' and OT3002.Orders = 1 ) OT3002 on OT3002.POrderID = M.POrderID and OT3002.DivisionID = M.DivisionID
LEFT JOIN AT0099 ON M.OrderStatus = AT0099.ID and AT0099.CodeMaster =''AT00000003''
LEFT JOIN AT1202            on AT1202.ObjectID = M.ObjectID
Left join AT1101 A WITH (NOLOCK) On A.DivisionID = M.DivisionID
LEFT JOIN AT1004            on AT1004.CurrencyID = M.CurrencyID 
WHERE '+ @sWhere +''
END
EXEC( @sSQL01 + @sSQL02)
--PRINT  (@sSQL + @sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
