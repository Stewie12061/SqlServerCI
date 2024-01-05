IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP30011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP30011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- in bao cao chi tiet don hang mua trên web
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 14/08/2017 by Thị Phượng 
-- <Example> EXEC POP30011 'KC', '', 1, '2017-01-01', '2017-08-30', '04/2017'',''05/2017', '', '',  '', 'VND', 'PHUONG'
---- 


CREATE PROCEDURE [dbo].[POP30011] 
				@DivisionID			NVARCHAR(50),	--Biến môi trường
				@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
				@IsDate				TINYINT,		--1: Theo ngày; 0: Theo kỳ
				@FromDate			DATETIME, 
				@ToDate				DATETIME, 
				@PeriodIDList		NVARCHAR(2000),
				@FromObjectID		NVARCHAR(MAX),
				@ToObjectID			NVARCHAR(MAX),
				@GroupID			nvarchar(50),	-- GroupID: OB, CI1, CI2, CI3, I01, I02, I03, I04, I05		
				@CurrencyID			as nvarchar(50),
				@UserID				NVARCHAR(50)	--Biến môi trường
 AS
DECLARE 	@sSQL nvarchar(MAX),
			--@sSQL1 nvarchar(MAX),
			@sWhere nvarchar(MAX),
			@GroupField nvarchar(20),
			@sFROM nvarchar(500),
			@sSELECT nvarchar(500) 
  
   	Set @sFROM = ''
	Set @sSELECT = ''
	Set @sWhere = ''
--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' OV2400.DivisionID IN ('''+@DivisionIDList+''')'
	ELSE 
		SET @sWhere = @sWhere + ' OV2400.DivisionID = '''+@DivisionID+''''

	--Search theo điều điện thời gian
	IF @IsDate = 1	
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,OV2400.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	ELSE
		SET @sWhere = @sWhere + ' AND OV2400.MonthYear IN ('''+@PeriodIDList+''')'
	
	--Search theo khách hàng (Dữ liệu khách hàng nhiều nên dùng control từ khách hàng, đến khách hàng)
	IF Isnull(@FromObjectID, '')!= '' and Isnull(@ToObjectID, '') = ''
		SET @sWhere = @sWhere + ' AND Isnull(OV2400.ObjectID, '''') > = N'''+@FromObjectID +''''
	ELSE IF Isnull(@FromObjectID, '') = '' and Isnull(@ToObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(OV2400.ObjectID, '''') < = N'''+@ToObjectID +''''
	ELSE IF Isnull(@FromObjectID, '') != '' and Isnull(@ToObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(OV2400.ObjectID, '''') Between N'''+@FromObjectID+''' AND N'''+@ToObjectID+''''
--Search theo loại tiền
	IF Isnull(@CurrencyID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(OV2400.CurrencyID, '''') = N'''+@CurrencyID+''''

	IF Isnull(@GroupID, '')!= ''
	BEGIN
		Exec AP4700  	@GroupID,	@GroupField OUTPUT
		Select @sFROM = @sFROM + ' left join AV6666 V1 on V1.DivisionID = OV2400.DivisionID AND V1.SelectionType = ''' + @GroupID + ''' and V1.SelectionID = OV2400.' + @GroupField,
			   @sSELECT = @sSELECT + ', V1.SelectionID as GroupID, V1.SelectionName as GroupName'
	END
	ELSE
		Set @sSELECT = @sSELECT +  ', '''' as GroupID, '''' as GroupName'	


Set @sSQL =  '
Select  OV2400.DivisionID, A.DivisionName,
		OV2400.OrderID as POrderID,  
		VoucherNo,           
		VoucherDate as OrderDate,
		CurrencyID,
		ObjectID,
		ObjectName,
		Orders,
		OrderStatus,
		Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,
		Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
		AnaName01,AnaName02,AnaName03,AnaName04,AnaName05,
		AnaName06,AnaName07,AnaName08,AnaName09,AnaName10,
		InventoryID, 
		InventoryName, 
		UnitName,
		Specification,
		InventoryTypeID,
		OrderQuantity,
		PurchasePrice,
		VATPercent,
		VATConvertedAmount,
		DiscountPercent,
		isnull(PurchasePrice, 0)* isnull(ExchangeRate, 0) as ConvertedPrice,	
		TotalOriginalAmount as TOriginalAmount,
		TotalConvertedAmount as TConvertedAmount' + 
		@sSELECT  + '
	From OV2400 
	Left join AT1101 A on A.DivisionID = OV2400.DivisionID' + 
	IsNull(@sFROM,'') + '
	WHERE '+ @sWhere + ''
	
--PRINT(@sSQL)
--PRINT(@sSQL1)

	EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
