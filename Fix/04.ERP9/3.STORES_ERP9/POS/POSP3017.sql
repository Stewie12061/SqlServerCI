IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP3017]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POSP3017]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- TOTAL SHOWROOM PRODUCT MOVEMENT – POSR3017
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
-- <Example> EXEC POSP3017 'HCM', 'HCM', 'AEONTANPHU', 'CH-HCM001'',''AEONTANPHU', 1, '2017-01-01', '2018-12-31', '12/2017'',''01/2018'',''02/2018','','', 'ASOFTADMIN'

CREATE PROCEDURE POSP3017 
(
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@ShopID				VARCHAR(50),
	@ShopIDList			NVARCHAR(MAX),
	@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME, 
	@PeriodIDList		NVARCHAR(2000),
	@ToInventoryID		VARCHAR(MAX),
	@FromInventoryID	VARCHAR(MAX),
	@UserID				VARCHAR(50)
)
AS
BEGIN
		DECLARE @sSQL   NVARCHAR(MAX),  
				@sWhere NVARCHAR(MAX),
				@Date  NVARCHAR(MAX)

		SET @Date = ''
		SET @sWhere = ''
		--Nếu Danh sách @DivisionIDList trống thì lấy biến môi trường @DivisionID
		IF Isnull(@DivisionIDList, '') != ''
			SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionIDList+''')'
		ELSE 
			SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionID+''')'	
	
		--Nếu Danh sách @ShopIDList trống thì lấy biến môi trường @ShopID
		IF Isnull(@ShopIDList, '')!= ''
			SET @sWhere = @sWhere + ' AND M.ShopID IN ('''+@ShopIDList+''')'
		ELSE 
			SET @sWhere = @sWhere + ' AND M.ShopID IN ('''+@ShopID+''')'

		IF @IsDate = 1	
			SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,M.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
		ELSE
			SET @sWhere = @sWhere + ' AND (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
											Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'
		--Search theo hội viên  (Dữ liệu mặt hàng nhiều nên dùng control từ mặt hàng , đến mặt hàng
		IF Isnull(@FromInventoryID, '')!= '' and Isnull(@ToInventoryID, '') = ''
			SET @sWhere = @sWhere + ' AND D.InventoryID > = N'''+@FromInventoryID +''''
		ELSE IF Isnull(@FromInventoryID, '') = '' and Isnull(@ToInventoryID, '') != ''
			SET @sWhere = @sWhere + ' AND D.InventoryID < = N'''+@ToInventoryID +''''
		ELSE IF Isnull(@FromInventoryID, '') != '' and Isnull(@ToInventoryID, '') != ''
			SET @sWhere = @sWhere + ' AND D.InventoryID Between N'''+@FromInventoryID+''' AND N'''+@ToInventoryID+''''

	--Lấy dữ liệu bảng					 	    
	SET @sSQL=N'	
			SELECT  M.DivisionID, Sum(M.Quantity) as Quantity, Sum(M.FreeGift) FreeGift	, M.ShopID, M.ShopName, M.InventoryID, M.InventoryName
			INTO #POST3017 FROM (SELECT  M.DivisionID, D.InventoryID, D.InventoryName, Case When M.PVoucherNo is null and M.CVoucherNo is null then D.ActualQuantity 
												When M.PVoucherNo is not null and M.CVoucherNo is null then (-1) * D.ActualQuantity
												When M.PVoucherNo is null and M.CVoucherNo is not null and D.APKDInherited is not null then (-1) * D.ActualQuantity
												When M.PVoucherNo is null and M.CVoucherNo is not null and D.APKDInherited is null then D.ActualQuantity
												end as Quantity, 0.0 as FreeGift, M.ShopID, A2.ShopName
			FROM POST0016 M WITH (NOLOCK) 
			INNER JOIN POST00161 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
			LEFT JOIN POST0010 A2 WITH (NOLOCK) ON A2.DivisionID = M.DivisionID and A2.ShopID = M.ShopID
			WHERE isnull(D.IsFreeGift,0) = 0 AND M.DeleteFlg = 0 '+@sWhere+'
			UNION ALL 
			SELECT  M.DivisionID, D.InventoryID, D.InventoryName, 0.0 as Quantity, Case When M.PVoucherNo is null and M.CVoucherNo is null then D.ActualQuantity 
												When M.PVoucherNo is not null and M.CVoucherNo is null then (-1) * D.ActualQuantity
												When M.PVoucherNo is null and M.CVoucherNo is not null and D.APKDInherited is not null then (-1) * D.ActualQuantity
												When M.PVoucherNo is null and M.CVoucherNo is not null and D.APKDInherited is null then D.ActualQuantity
												end as FreeGift, M.ShopID, A2.ShopName
			FROM POST0016 M WITH (NOLOCK) 
			INNER JOIN POST00161 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
			LEFT JOIN POST0010 A2 WITH (NOLOCK) ON A2.DivisionID = M.DivisionID and A2.ShopID = M.ShopID
			WHERE isnull(D.IsFreeGift,0) = 1 AND M.DeleteFlg = 0 '+@sWhere+'
			)M 
			Group by M.DivisionID, M.ShopID, M.ShopName , M.InventoryID, M.InventoryName
				
			DECLARE @columns NVARCHAR(MAX), @columns1 NVARCHAR(MAX),
							@sql NVARCHAR(MAX);
					SET @columns = N'''';
					SET @columns1  = N'''';
					SELECT @columns += N'', '' + quotename(N''Gift (''+InventoryName+'')'')
					FROM (SELECT InventoryName FROM #POST3017 group by InventoryName ) AS x Order by InventoryName;
					SELECT @columns1 += N'', '' + quotename(N''Sale (''+InventoryName+'')'')
					FROM (SELECT InventoryName FROM #POST3017 group by InventoryName ) AS x Order by InventoryName;
					
					SET @sql = N''
						SELECT DivisionID, ShopID, ShopName, '' + STUFF(@columns1, 1, 2, '''') +'' Into #A1
					FROM (
						  SELECT DivisionID, ShopName,ShopID, Quantity, N''''Sale (''''+InventoryName+'''')'''' InventoryName
						  FROM  #POST3017
					  
						  ) AS j
									PIVOT
									(
									  SUM(Quantity) FOR InventoryName IN (''
									  + STUFF(REPLACE(@columns1, '', ['', '',[''), 1, 1, '''')
									  + '')
									) AS p;
						SELECT GDivisionID, GShopName, GShopID, '' + STUFF(@columns, 1, 2, '''') +'' Into #A2
					FROM (
						  SELECT DivisionID as GDivisionID, ShopName as GShopName ,ShopID as GShopID, FreeGift, N''''Gift (''''+InventoryName+'''')'''' InventoryName
						  FROM  #POST3017
					  
						  ) AS j
									PIVOT
									(
									  SUM(FreeGift) FOR InventoryName IN (''
									  + STUFF(REPLACE(@columns, '', ['', '',[''), 1, 1, '''')
									  + '')
									) AS p;
					Select * from #A2 B  LEFT JOIN #A1 A ON A.DivisionID = B.GDivisionID and A.ShopID = B.GShopID '';
					EXEC sp_executesql @sql;
		'		
		EXEC (@sSQL)
		Print (@sSQL)
		
		
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
