IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30041]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- In bao cao Doanh số bán hàng theo mặt hàng - SOR3004
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create ON 26/06/2017 by Phan thanh hoàng Vũ
---- Modified By Thị Phượng Date 05/07/2017 Bổ sung phân quyền dữ liêu
---- Modified By Anh Đô Date 06/02/2023 - Select thêm các cột SalePrice, DiscountPercent, OriginalDiscountAmount
---- Modified By Anh Đô Date 14/02/2023 - Fix lỗi sai số dữ liệu; Bổ sung trừ chiết khấu cho cột OriginalAmount và ConvertedAmount
-- <Example> EXEC SOP30041 'AS',  'AS'',''GS'',''GC', 1, '2017-01-01', '2017-06-30', '06/2017', '', '', '', '', '', '', '' ,'VU'

CREATE PROCEDURE [dbo].[SOP30041] (
				@DivisionID			NVARCHAR(50),	--Biến môi trường
				@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
				@IsDate				TINYINT,		--1: Theo ngày; 0: Theo kỳ
				@FromDate			DATETIME, 
				@ToDate				DATETIME, 
				@PeriodIDList		NVARCHAR(2000),
				@FromObjectID		NVARCHAR(MAX) = '',
				@ToObjectID			NVARCHAR(MAX) = '',
				@FromSalesManID		NVARCHAR(MAX) = '',
				@ToSalesManID		NVARCHAR(MAX) = '',	
				@FromInventoryID	NVARCHAR(MAX) = '',
				@ToInventoryID		NVARCHAR(MAX) = '',	
				@UserID				NVARCHAR(50),	--Biến môi trường
				@ConditionSOrderID  NVARCHAR(Max),
				@ObjectID			NVARCHAR(MAX) = '',
				@SalesManID			NVARCHAR(MAX) = '',
				@InventoryID		NVARCHAR(MAX) = ''
				)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(max),
			@sWhere NVARCHAR(max),
			@sWhere1 NVARCHAR(max),
			@sSELECT nvarchar(max),
			@sGROUPBY nvarchar(max)
	Set @sWhere = ''
    Set @sWhere1 = ''
	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionIDList+''', ''@@@'')'
	ELSE 
		SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionID+''', ''@@@'')'

	--Search theo điều điện thời gian
	IF @IsDate = 1	
	BEGIN
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,O.OrderDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''

	END
	ELSE
	BEGIN
		
		SET @sWhere = @sWhere + ' AND (Case When  Month(O.OrderDate) <10 then ''0''+rtrim(ltrim(str(Month(O.OrderDate))))+''/''+ltrim(Rtrim(str(Year(O.OrderDate)))) 
										Else rtrim(ltrim(str(Month(O.OrderDate))))+''/''+ltrim(Rtrim(str(Year(O.OrderDate)))) End) IN ('''+@PeriodIDList+''')'
	
	END

	--Search theo khách hàng (Dữ liệu khách hàng nhiều nên dùng control từ khách hàng, đến khách hàng)
	IF Isnull(@FromObjectID, '')!= '' and Isnull(@ToObjectID, '') = ''
		SET @sWhere = @sWhere + ' AND Isnull(M.ObjectID, '''') > = N'''+@FromObjectID +''''
	ELSE IF Isnull(@FromObjectID, '') = '' and Isnull(@ToObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.ObjectID, '''') < = N'''+@ToObjectID +''''
	ELSE IF Isnull(@FromObjectID, '') != '' and Isnull(@ToObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.ObjectID, '''') Between N'''+@FromObjectID+''' AND N'''+@ToObjectID+''''

	--Search theo người bán hàng (Dữ liệu khách hàng nhiều nên dùng control từ người bán hàng, đến người bán hàng)
	IF Isnull(@FromSalesManID, '')!= '' and Isnull(@ToSalesManID, '') = ''
		SET @sWhere = @sWhere + ' AND Isnull(M.SalesManID, '''') > = N'''+@FromSalesManID +''''
	ELSE IF Isnull(@FromSalesManID, '') = '' and Isnull(@ToSalesManID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.SalesManID, '''') < = N'''+@ToSalesManID +''''
	ELSE IF Isnull(@FromSalesManID, '') != '' and Isnull(@ToSalesManID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.SalesManID, '''') Between N'''+@FromSalesManID+''' AND N'''+@ToSalesManID+''''

	--Search theo mặt hàng (Dữ liệu mặt hàng nhiều nên dùng control từ mặt hàng, đến mặt hàng)
	IF Isnull(@FromInventoryID, '')!= '' and Isnull(@ToInventoryID, '') = ''
		SET @sWhere = @sWhere + ' AND Isnull(M.InventoryID, '''') > = N'''+@FromInventoryID +''''
	ELSE IF Isnull(@FromInventoryID, '') = '' and Isnull(@ToInventoryID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.InventoryID, '''') < = N'''+@ToInventoryID +''''
	ELSE IF Isnull(@FromInventoryID, '') != '' and Isnull(@ToInventoryID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.InventoryID, '''') Between N'''+@FromInventoryID+''' AND N'''+@ToInventoryID+''''

	-- Search theo list danh sách khách hàng (Dữ liệu khách hàng dùng control chọn nhìu)
	IF ISNULL(@ObjectID, '') != ''
		SET @sWhere = @sWhere + 'AND O.ObjectID IN ( SELECT * FROM StringSplit(REPLACE('''+@ObjectID+''', '''', ''''), '','') ) '

	-- Search theo list danh sách nhân viên (Dữ liệu nhân viên dùng control chọn nhìu)
	IF ISNULL(@SalesManID, '') != ''
		SET @sWhere = @sWhere + 'AND O.SalesManID IN ( SELECT * FROM StringSplit(REPLACE('''+@SalesManID+''', '''', ''''), '','') ) '

	-- Search theo list danh sách mặt hàng (Dữ liệu mặt hàng dùng control chọn nhìu)
	IF ISNULL(@InventoryID, '') != ''
		SET @sWhere = @sWhere + 'AND M.InventoryID IN ( SELECT * FROM StringSplit(REPLACE('''+@InventoryID+''', '''', ''''), '','') ) '

	---Phân quyền dữ liệu
	IF Isnull(@ConditionSOrderID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(O.SalesManID, O.CreateUserID) in ('''+@ConditionSOrderID+''')'

	
	SET @sSQL = '
		SELECT
			 M.DivisionID
			,A3.DivisionName
			,M.InventoryID
			,A1.InventoryName
			,A2.UnitName
			,M.SalePrice
			,M.DiscountPercent
			,SUM(ISNULL(M.DiscountAmount, 0)) AS OriginalDiscountAmount
			,SUM(M.OrderQuantity) as OrderQuantity
			,ISNULL(SUM(M.OriginalAmount) - SUM(M.DiscountAmount), 0) AS OriginalAmount
			,ISNULL(SUM(M.ConvertedAmount) - SUM(M.DiscountAmount * M.ExchangeRate), 0) AS ConvertedAmount
		FROM OT2002 M
		LEFT JOIN OT2001 O WITH (NOLOCK) ON O.SOrderID = M.SOrderID AND O.IsConfirm = 1 AND O.OrderType = 0 
		LEFT JOIN AT1302 A1 WITH (NOLOCK) ON A1.InventoryID = M.InventoryID
		LEFT JOIN AT1304 A2 WITH (NOLOCK) ON A2.UnitID = M.UnitID
		LEFT JOIN AT1101 A3 WITH (NOLOCK) ON A3.DivisionID = M.DivisionID
		WHERE '+ @sWhere +'
		GROUP BY  M.DivisionID ,A3.DivisionName, M.InventoryID, A1.InventoryName, A2.UnitName, M.SalePrice, M.DiscountPercent
	'
	EXEC (@sSQL)
	PRINT (@sSQL)
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
