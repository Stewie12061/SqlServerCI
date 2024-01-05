IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30121]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30121]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In bao cao Số đơn hàng theo nhân viên - SOR3012
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create ON 30/06/2017 by Cao Thị Phượng
---- Modified By Thị Phượng Date 05/07/2017 Bổ sung phân quyền dữ liêu
---- Modified By Văn Tài	Date 21/09/2021 Bổ sung kiểm tra trạng thái IsConfirm hoặc OrderStatus.
---- Modified By Anh Đô		Date 11/10/2022 Chỉnh sửa điều kiện lọc
-- <Example> EXEC SOP30121 'AS', '', 1, '2017-01-01', '2017-06-30', '03/2017'',''04/2017'',''06/2017', '', '', '', '', '', '', '','PHUONG'',''VU'

CREATE PROCEDURE [dbo].[SOP30121] (
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
	ELSE IF (ISNULL(@ObjectID, '') != '')
		SET @sWhere = @sWhere + ' AND M.ObjectID IN (SELECT Value FROM [dbo].StringSplit('''+ @ObjectID +''', '',''))'
	
	--Search theo người bán hàng (Dữ liệu khách hàng nhiều nên dùng control từ người bán hàng, đến người bán hàng)
	IF Isnull(@FromSalesManID, '')!= '' and Isnull(@ToSalesManID, '') = ''
		SET @sWhere = @sWhere + ' AND Isnull(M.SalesManID, '''') > = N'''+@FromSalesManID +''''
	ELSE IF Isnull(@FromSalesManID, '') = '' and Isnull(@ToSalesManID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.SalesManID, '''') < = N'''+@ToSalesManID +''''
	ELSE IF Isnull(@FromSalesManID, '') != '' and Isnull(@ToSalesManID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.SalesManID, '''') Between N'''+@FromSalesManID+''' AND N'''+@ToSalesManID+''''
	ELSE IF (ISNULL(@SalesManID, '') != '')
		SET @sWhere = @sWhere + ' AND M.SalesManID IN (SELECT Value FROM [dbo].StringSplit('''+ @SalesManID +''', '','')) '

	--Search theo mặt hàng (Dữ liệu mặt hàng nhiều nên dùng control từ mặt hàng, đến mặt hàng)
	IF Isnull(@FromInventoryID, '')!= '' and Isnull(@ToInventoryID, '') = ''
		SET @sWhere = @sWhere + ' AND Isnull(D.InventoryID, '''') > = N'''+@FromInventoryID +''''
	ELSE IF Isnull(@FromInventoryID, '') = '' and Isnull(@ToInventoryID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(D.InventoryID, '''') < = N'''+@ToInventoryID +''''
	ELSE IF Isnull(@FromInventoryID, '') != '' and Isnull(@ToInventoryID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(D.InventoryID, '''') Between N'''+@FromInventoryID+''' AND N'''+@ToInventoryID+''''
	ELSE IF (ISNULL(@InventoryID, '') != '')
		SET @sWhere = @sWhere + ' AND D.InventoryID IN (SELECT Value FROM [dbo].StringSplit('''+ @InventoryID +''', '','')) '

	---Phân quyền dữ liệu
	IF Isnull(@ConditionSOrderID, '') != ''
		SET @sWhere = @sWhere + ' AND M.SalesManID in ('''+@ConditionSOrderID+''') '

	SET @sSQL = '  Select  M.DivisionID, AT1101.DivisionName, M.SalesManID as EmployeeID,  M.SalesManID +'' _ ''+ AT1103.FullName as EmployeeName
						, Count(Distinct M.SOrderID) as OrderQuantity
						,  SUM(D.ConvertedAmount) +  Sum(isnull(VATConvertedAmount,0)) as ConvertedAmount
						 From  OT2001 M WITH (NOLOCK)
								INNER JOIN OT2002 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.SorderID = D.SorderID and M.OrderType = 0 and (M.IsConfirm = 1 OR M.OrderStatus = 1)
								LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = M.SalesManID
								LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = M.DivisionID	
							Where  ' + @sWHERE + ' 
						Group by M.DivisionID, AT1101.DivisionName, M.SalesManID ,AT1103.FullName						  
				  Order by  M.SalesManID '
	EXEC (@sSQL)
	--PRINT (@sSQL)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
