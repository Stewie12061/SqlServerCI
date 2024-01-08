IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30081]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30081]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In bao cao Doanh số bán hàng theo khách hàng - SOR3008
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create ON 30/06/2017 by Cao Thị Phượng
---- Modified By Thị Phượng Date 05/07/2017 Bổ sung phân quyền dữ liêu
---- Modify by Hoàng vũ, Date 25/09/2018: Convert chuyển lấy dữ liệu khách hàng CRM (CRMT10101)-> Khách hàng POS (POST0011)
---- Modify by Anh Đô, Date 31/10/2022: Chỉnh sửa điều kiện lọc
---- Modify by Anh Đô, Date 06/02/2023: Select thêm cột tổng chiết khấu (SConvertedDiscountAmount)
---- Modify by Anh Đô, Date 13/02/2023: Cập nhật xử lí trừ chiết khấu cho cột SAmount
---- Modify by Anh Đô, Date 01/09/2023: Cập nhật lấy ObjectName từ bảng AT1202
-- <Example> EXEC SOP30081 'AS', '', 1, '2017-01-01', '2017-06-30', '06/2017', '', '', '', '', '', '', '' ,'PHUONG'',''VU'

CREATE PROCEDURE [dbo].[SOP30081] (
				@DivisionID			NVARCHAR(50),	--Biến môi trường
				@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
				@IsDate				TINYINT,		--1: Theo ngày; 0: Theo kỳ
				@FromDate			DATETIME, 
				@ToDate				DATETIME, 
				@PeriodIDList		NVARCHAR(2000),
				@ObjectID			NVARCHAR(MAX),
				@SalesManID			NVARCHAR(MAX),
				@InventoryID		NVARCHAR(MAX),
				@UserID				NVARCHAR(50),	--Biến môi trường
				@ConditionSOrderID  NVARCHAR(Max),	--Biến môi trường
				@FromObjectID		NVARCHAR(MAX) = '',
				@ToObjectID			NVARCHAR(MAX) = '',
				@FromSalesManID		NVARCHAR(MAX) = '',
				@ToSalesManID		NVARCHAR(MAX) = '',
				@FromInventoryID	NVARCHAR(MAX) = '',
				@ToInventoryID		NVARCHAR(MAX) = ''
				)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(max),
			@sWhere NVARCHAR(max),
			@sSELECT nvarchar(max),
			@sGROUPBY nvarchar(max)
	Set @sWhere = ''
    
	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = ' M.DivisionID IN ('''+@DivisionIDList+''')'
	ELSE 
		SET @sWhere = ' M.DivisionID = N'''+@DivisionID+''''
	---Phân quyền dữ liệu
	IF Isnull(@ConditionSOrderID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.SalesManID, M.CreateUserID) in ('''+@ConditionSOrderID+''')'

	--Search theo điều điện thời gian
	IF @IsDate = 1
	BEGIN

		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,M.OrderDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''

	END
	ELSE
	BEGIN
		SET @sWhere = @sWhere + ' AND (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''
										+ltrim(Rtrim(str(M.TranYear))) Else rtrim(ltrim(str(M.TranMonth)))+''/''
										+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'
	END

	--Search theo khách hàng (Dữ liệu khách hàng nhiều nên dùng control từ khách hàng, đến khách hàng)
	IF Isnull(@FromObjectID, '')!= '' and Isnull(@ToObjectID, '') = ''
		SET @sWhere = @sWhere + ' AND Isnull(M.ObjectID, '''') > = N'''+@FromObjectID +''''
	ELSE IF Isnull(@FromObjectID, '') = '' and Isnull(@ToObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.ObjectID, '''') < = N'''+@ToObjectID +''''
	ELSE IF Isnull(@FromObjectID, '') != '' and Isnull(@ToObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.ObjectID, '''') Between N'''+@FromObjectID+''' AND N'''+@ToObjectID+''''
	ELSE IF ISNULL(@ObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ObjectID, '''') IN (SELECT Value FROM [dbo].StringSplit('''+ @ObjectID +''', '',''))'

	--Search theo người bán hàng (Dữ liệu khách hàng nhiều nên dùng control từ người bán hàng, đến người bán hàng)
	IF Isnull(@FromSalesManID, '')!= '' and Isnull(@ToSalesManID, '') = ''
		SET @sWhere = @sWhere + ' AND Isnull(M.SalesManID, '''') > = N'''+@FromSalesManID +''''
	ELSE IF Isnull(@FromSalesManID, '') = '' and Isnull(@ToSalesManID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.SalesManID, '''') < = N'''+@ToSalesManID +''''
	ELSE IF Isnull(@FromSalesManID, '') != '' and Isnull(@ToSalesManID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.SalesManID, '''') Between N'''+@FromSalesManID+''' AND N'''+@ToSalesManID+''''
	ELSE IF ISNULL(@SalesManID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.SalesManID, '''') IN (SELECT Value FROM [dbo].StringSplit('''+ @SalesManID +''', '',''))'

	--Search theo mặt hàng (Dữ liệu mặt hàng nhiều nên dùng control từ mặt hàng, đến mặt hàng)
	IF Isnull(@FromInventoryID, '')!= '' and Isnull(@ToInventoryID, '') = ''
		SET @sWhere = @sWhere + ' AND Isnull(D.InventoryID, '''') > = N'''+@FromInventoryID +''''
	ELSE IF Isnull(@FromInventoryID, '') = '' and Isnull(@ToInventoryID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(D.InventoryID, '''') < = N'''+@ToInventoryID +''''
	ELSE IF Isnull(@FromInventoryID, '') != '' and Isnull(@ToInventoryID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(D.InventoryID, '''') Between N'''+@FromInventoryID+''' AND N'''+@ToInventoryID+''''
	ELSE IF ISNULL(@InventoryID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(D.InventoryID, '''') IN (SELECT Value FROM [dbo].StringSplit('''+ @InventoryID +''', '',''))'

		
	SET @sSQL = '  Select
						M.OrderDate 
						, M.VoucherNo
						, M.ObjectID
						, AT1202.ObjectName
						, M.DivisionID, AT1101.DivisionName
						, SUM(D.ConvertedAmount) as ConvertedAmount
						, Sum(D.OriginalAmount) as OriginalAmount
						, Sum(isnull(VATConvertedAmount,0)) as VATAmount
						, SUM(D.ConvertedAmount) +  Sum(isnull(VATConvertedAmount,0)) - SUM(ISNULL(D.DiscountAmount, 0) * D.ExchangeRate) as SAmount
						, M.CurrencyID
						, M.Notes as Description
						, AT1004.CurrencyName
						, SUM(ISNULL(D.DiscountAmount, 0) * D.ExchangeRate) AS SConvertedDiscountAmount
						 From  OT2001 M WITH (NOLOCK)
								INNER JOIN OT2002 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.SorderID = D.SorderID and M.OrderType = 0 and M.IsConfirm = 1
								LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = M.ObjectID AND AT1202.DivisionID IN (M.DivisionID, ''@@@'')
								LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = M.DivisionID
								LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = M.CurrencyID
							Where  ' + @sWHERE + ' 
						Group by 	 M.OrderDate , M.VoucherNo, M.ObjectID, AT1202.ObjectName, M.DivisionID, AT1101.DivisionName, M.CurrencyID, M.Notes, AT1004.CurrencyName
				  Order by  M.ObjectID, M.VoucherNo  '
	EXEC (@sSQL)
	--PRINT (@sSQL)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
