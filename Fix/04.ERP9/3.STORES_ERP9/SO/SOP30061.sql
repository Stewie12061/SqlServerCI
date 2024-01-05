IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30061]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30061]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- In bao cao Doanh số trung bình của đơn hàng theo nhân viên - SOR3006
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create ON 28/06/2017 by Cao Thị Phượng
---- Modified By Thị Phượng Date 05/07/2017 Bổ sung phân quyền dữ liêu
---- Modified By Anh Đô		Date 27/10/2022 Chỉnh sửa điều kiện lọc
-- <Example> EXEC SOP30061 'AS', '', 1, '2017-01-01', '2017-06-30', '04/2017'',''06/2017', 'B-D-0000000000000002', 'KH0009', 'Hoang', 'VU', '','VU'',''PHUONG' 

CREATE PROCEDURE [dbo].[SOP30061] (
				@DivisionID			NVARCHAR(50),	--Biến môi trường
				@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
				@IsDate				TINYINT,		--1: Theo ngày; 0: Theo kỳ
				@FromDate			DATETIME, 
				@ToDate				DATETIME, 
				@PeriodIDList		NVARCHAR(2000),	
				@ObjectID			NVARCHAR(MAX),
				@SalesManID			NVARCHAR(MAX),
				@UserID				NVARCHAR(50),	--Biến môi trường
				@ConditionSOrderID  NVARCHAR(Max),	--Biến môi trường
				@FromObjectID		NVARCHAR(MAX) = '',
				@ToObjectID			NVARCHAR(MAX) = '',
				@FromSalesManID		NVARCHAR(MAX) = '',
				@ToSalesManID		NVARCHAR(MAX) = ''
				)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(max),
			@sWhere NVARCHAR(max),
			@sWhere2 Nvarchar(Max),
			@sSELECT nvarchar(max),
			@sGROUPBY nvarchar(max)
	Set @sWhere = ''
    Set @sWhere2 = ''
	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere2 = ' M.DivisionID IN ('''+@DivisionIDList+''')'
	ELSE 
		SET @sWhere2 = ' M.DivisionID = N'''+@DivisionID+''''

	--Search theo điều điện thời gian
	IF @IsDate = 1	
	BEGIN
		SET @sWhere2 = @sWhere2 + ' AND CONVERT(VARCHAR,M.OrderDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	END
	ELSE
	BEGIN
		SET @sWhere2 = @sWhere2 + ' AND Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
								Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End IN ('''+@PeriodIDList+''')'
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

	---Phân quyền dữ liệu
	IF Isnull(@ConditionSOrderID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.SalesManID, M.CreateUserID) in ('''+@ConditionSOrderID+''')'

--Lấy kết quả
	
	SET @sSQL = ' Select  M.DivisionID, AT01.DivisionName , M.EmployeeID, M.EmployeeName,  CAST(COUNT(Distinct M.SOrderID) AS DECIMAL(28,1)) as Quantity
					, SUM(M.ConvertedAmount) as ConvertedAmount, SUM(M.OriginalAmount) as OriginalAmount  
					, SUM(M.ConvertedAmount)/ CAST(COUNT(Distinct M.SOrderID) AS DECIMAL(28,1))  as AVGConvertedAmount
					FROM
					(
						SELECT  M.DivisionID, M.SOrderID,  M.SalesManID as EmployeeID, M.SalesManID +'' - ''+ AT03.FullName as EmployeeName,
						D.OrderQuantity, D.ConvertedAmount, D.OriginalAmount
						FROM OT2001 M WITH (NOLOCK)
						INNER JOIN OT2002 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.SorderID = D.SorderID and M.OrderType = 0 and M.IsConfirm = 1
						LEFT JOIN AT1103 AT03 WITH (NOLOCK) ON AT03.EmployeeID = M.SalesManID
						WHERE '+@sWhere2 + @sWHERE + ' 
					)M
					LEFT JOIN AT1101 AT01 WITH (NOLOCK) ON AT01.DivisionID = M.DivisionID
				  Group by   M.DivisionID, M.EmployeeID, M.EmployeeName, AT01.DivisionName
				  Order by M.EmployeeID'
	EXEC (@sSQL)
	--PRINT (@sSQL)
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
