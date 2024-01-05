IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30111]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30111]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In báo cáo Giá bán thực tế so với giá bán chuẩn - SOR3011
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create ON 30/06/2017 by Cao Thị Phượng
---- Modified on 14/10/2022 by Hoài Bảo - Thay đổi param truyền vào theo dạng danh sách, tính lại tỷ lệ bán đúng giá
---- Modified on 18/01/2023 by Anh Đô - Fix lỗi "Subquery returned more than 1 value" khi lấy dữ liệu cột ExpectPrice
---- Modified on 18/01/2023 by Văn Tài - [2023/03/IS/0179] Bổ sung bảng tạm khi chọn nhiều khách hàng, xử lý trường hợp Greater = 0.
-- <Example> EXEC SOP30111 'AS', '', 1, '2017-01-01', '2017-06-30', '06/2017', '', '', '', '', '', '', '' ,'PHUONG'', ''QUI'', ''QUYNH'', ''VU'

CREATE PROCEDURE [dbo].[SOP30111]
(
			@DivisionID			NVARCHAR(50),	--Biến môi trường
			@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
			@IsDate				TINYINT,		--1: Theo ngày; 0: Theo kỳ
			@FromDate			DATETIME, 
			@ToDate				DATETIME, 
			@PeriodIDList		NVARCHAR(2000),
			--@FromObjectID		NVARCHAR(MAX),
			--@ToObjectID			NVARCHAR(MAX),
			--@FromSalesManID		NVARCHAR(MAX),
			--@ToSalesManID		NVARCHAR(MAX),				
			--@FromInventoryID	NVARCHAR(MAX),
			--@ToInventoryID		NVARCHAR(MAX),			
			@ObjectID			VARCHAR(MAX),
			@EmployeeID		    VARCHAR(MAX),
			@InventoryID		VARCHAR(MAX),	
			@UserID				VARCHAR(50),	--Biến môi trường
			@ConditionSOrderID  VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @sSQL VARCHAR(MAX),
			@sWhere VARCHAR(MAX),
			@sSELECT VARCHAR(MAX),
			@sGROUPBY VARCHAR(MAX)
	SET @sWhere = ''
	
	SELECT Value AS ObjectID
	INTO #SOP30111_ObjectID 
	FROM StringSplit(@ObjectID, ''',''') AT00
	WHERE AT00.Value <> ','
    
	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = ' M.DivisionID IN ('''+@DivisionIDList+''')'
	ELSE 
		SET @sWhere = ' M.DivisionID = N'''+@DivisionID+''''	

	--Search theo điều điện thời gian
	IF @IsDate = 1
	BEGIN
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,M.OrderDate,112) BETWEEN ''' + CONVERT(VARCHAR,@FromDate,112) + ''' AND ''' + CONVERT(VARCHAR,@ToDate,112) + ''''
	END
	ELSE
	BEGIN
		SET @sWhere = @sWhere + ' AND (CASE WHEN M.TranMonth < 10 THEN ''0'' + RTRIM(LTRIM(STR(M.TranMonth))) + ''/''
										+ LTRIM(RTRIM(STR(M.TranYear))) ELSE RTRIM(LTRIM(STR(M.TranMonth))) + ''/''
										+ LTRIM(RTRIM(STR(M.TranYear))) END) IN ('''+@PeriodIDList+''')'
	END

	--Search theo khách hàng (Dữ liệu khách hàng nhiều nên dùng control từ khách hàng, đến khách hàng)
	--IF ISNULL(@FromObjectID, '')!= '' AND ISNULL(@ToObjectID, '') = ''
	--	SET @sWhere = @sWhere + ' AND ISNULL(M.ObjectID, '''') > = N'''+@FromObjectID +''''
	--ELSE IF ISNULL(@FromObjectID, '') = '' AND ISNULL(@ToObjectID, '') != ''
	--	SET @sWhere = @sWhere + ' AND ISNULL(M.ObjectID, '''') < = N'''+@ToObjectID +''''
	--ELSE IF ISNULL(@FromObjectID, '') != '' AND ISNULL(@ToObjectID, '') != ''
	--	SET @sWhere = @sWhere + ' AND ISNULL(M.ObjectID, '''') Between N'''+@FromObjectID+''' AND N'''+@ToObjectID+''''

	--Search theo người bán hàng (Dữ liệu khách hàng nhiều nên dùng control từ người bán hàng, đến người bán hàng)
	--IF ISNULL(@FromSalesManID, '')!= '' AND ISNULL(@ToSalesManID, '') = ''
	--	SET @sWhere = @sWhere + ' AND ISNULL(M.SalesManID, '''') > = N'''+@FromSalesManID +''''
	--ELSE IF ISNULL(@FromSalesManID, '') = '' AND ISNULL(@ToSalesManID, '') != ''
	--	SET @sWhere = @sWhere + ' AND ISNULL(M.SalesManID, '''') < = N'''+@ToSalesManID +''''
	--ELSE IF ISNULL(@FromSalesManID, '') != '' AND ISNULL(@ToSalesManID, '') != ''
	--	SET @sWhere = @sWhere + ' AND ISNULL(M.SalesManID, '''') Between N'''+@FromSalesManID+''' AND N'''+@ToSalesManID+''''

	--Search theo mặt hàng (Dữ liệu mặt hàng nhiều nên dùng control từ mặt hàng, đến mặt hàng)
	--IF ISNULL(@FromInventoryID, '')!= '' AND ISNULL(@ToInventoryID, '') = ''
	--	SET @sWhere = @sWhere + ' AND ISNULL(D.InventoryID, '''') > = N'''+@FromInventoryID +''''
	--ELSE IF ISNULL(@FromInventoryID, '') = '' AND ISNULL(@ToInventoryID, '') != ''
	--	SET @sWhere = @sWhere + ' AND ISNULL(D.InventoryID, '''') < = N'''+@ToInventoryID +''''
	--ELSE IF ISNULL(@FromInventoryID, '') != '' AND ISNULL(@ToInventoryID, '') != ''
	--	SET @sWhere = @sWhere + ' AND ISNULL(D.InventoryID, '''') Between N'''+@FromInventoryID+''' AND N'''+@ToInventoryID+''''

	--Search theo khách hàng
	IF ISNULL(@ObjectID, '')!= ''
		SET @sWhere = @sWhere + ' AND M.ObjectID IN (SELECT DISTINCT ObjectID FROM #SOP30111_ObjectID)'

	--Search theo nhân viên
	IF ISNULL(@EmployeeID, '')!= ''
		SET @sWhere = @sWhere + ' AND M.SalesManID IN ('''+@EmployeeID +''')'

	--Search theo mặt hàng
	IF ISNULL(@InventoryID, '')!= ''
		SET @sWhere = @sWhere + ' AND D.InventoryID IN ('''+@InventoryID +''')'

	---Phân quyền dữ liệu
	IF ISNULL(@ConditionSOrderID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.SalesManID, M.CreateUserID) IN ('''+@ConditionSOrderID+''')'
	SET @sSQL = '	SELECT M.DivisionID, M.SalesManID, D.InventoryID,
					CASE WHEN ISNULL(M.PriceListID,'''')!= '''' THEN (
						SELECT H.UnitPrice FROM OT1302 H WITH (NOLOCK) WHERE H.InventoryID = D.InventoryID
						AND H.ID = M.PriceListID AND H.DivisionID IN ('''+ @DivisionID +''', ''@@@'')
					)
					Else (
						SELECT H.SalePrice01 FROM AT1302 H WITH (NOLOCK) WHERE H.InventoryID = D.InventoryID
					) END AS ExpectPrice,
					D.SalePrice AS ActualPrice
					INTO #TemPrice
					FROM OT2001 M WITH (NOLOCK)
					INNER JOIN OT2002 D WITH (NOLOCK) On M.DivisionID = D.DivisionID AND M.SOrderID = D.SOrderID
					WHERE  ' + @sWHERE + '  							  
				--Dem tong so mat hang 	
					DECLARE @count DECIMAL(28,1)
					SELECT @count = COUNT(InventoryID) FROM #TemPrice
				----Dem tong so lan tren gia ban	
				--	DECLARE @Greater DECIMAL(28,1)
				--	SELECT @Greater = Count(InventoryID) FROM #TemPrice
				--	WHERE ExpectPrice > ActualPrice
				--	--Group by DivisionID, SalesManID, ExpectPrice, ActualPrice
				----Dem tong so lan duoi gia ban	
				--	DECLARE @Less DECIMAL(28,1)
				--	SELECT @Less = Count(InventoryID) FROM #TemPrice
				--	WHERE ExpectPrice < ActualPrice
				--	--Group by DivisionID, SalesManID, ExpectPrice, ActualPrice
				--Dem tong so lan bang gia ban	
					DECLARE @Ice DECIMAL(28,1)
					SELECT @Ice = Count(InventoryID) FROM #TemPrice
					WHERE ExpectPrice = ActualPrice 
					--Group by DivisionID, SalesManID
				--Tinh gia ty le 
					SELECT M.DivisionID
							, M.DivisionName
							, M.SalesManID
							, M.EmployeeName
							, SUM(ISNULL(Greater, 0)) AS Greater
							, SUM(ISNULL(Less,0)) AS Less
							, SUM(ISNULL(Ice,0)) AS Ice
							, CASE WHEN SUM(ISNULL(Greater, 0)) = 0 
									THEN 0 
									ELSE (CAST(SUM(ISNULL(Ice,0)) AS DECIMAL(28,1))/CAST(SUM(ISNULL(Greater, 0)) + SUM(ISNULL(Less,0)) + SUM(ISNULL(Ice,0)) AS DECIMAL(28,1))) 
								END AS Rate
							, Total
					FROM
					(SELECT M.DivisionID, AT01.DivisionName, M.SalesManID, M.SalesManID +'' _ ''+AT03.FullName AS EmployeeName,
					CASE WHEN (ExpectPrice > ActualPrice) THEN  Count(InventoryID) END AS Greater,
					CASE WHEN (ExpectPrice < ActualPrice) THEN  Count(InventoryID) END AS Less, 
					CASE WHEN (ExpectPrice = ActualPrice) THEN  Count(InventoryID) END AS Ice, @count AS Total
					FROM #TemPrice M
					LEFT JOIN AT1103 AT03 WITH (NOLOCK) ON AT03.EmployeeID = M.SalesManID
					LEFT JOIN AT1101 AT01 WITH (NOLOCK) ON AT01.DivisionID = M.DivisionID
					GROUP BY M.DivisionID, AT01.DivisionName,  M.SalesManID,  AT03.FullName, M.ExpectPrice, M.ActualPrice)
					M
					GROUP BY M.DivisionID, m.DivisionName,  M.SalesManID, M.EmployeeName, M.Total
					ORDER BY M.DivisionID, M.SalesManID'
	PRINT (@sSQL)
	EXEC (@sSQL)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
