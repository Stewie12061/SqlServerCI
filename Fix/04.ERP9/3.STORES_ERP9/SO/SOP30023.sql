IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30023]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30023]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---Created by: Trọng Kiên, date:  04/12/2020
---Purpose: In báo cáo chi tiết bán hàng theo loại sản phẩm
---Modified on 27/12/2021 by Văn Tài: Fix lỗi Alias S2.PaperTypeID.
---Modified on 08/04/2022 by Văn Tài: Bổ sung phân quyền xem đơn hàng VNA.
-- EXEC SOP30023 'MK',0,2,2016,2,2016,'2016-02-01','2016-02-14','vd05','vd05',0

CREATE PROCEDURE [dbo].[SOP30023] 
				@DivisionID			NVARCHAR(50),	--Biến môi trường
				@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
				@IsDate				TINYINT,		--1: Theo ngày; 0: Theo kỳ
				@FromDate			DATETIME, 
				@ToDate				DATETIME, 
				@PeriodIDList		NVARCHAR(2000),
				@FromObjectID		NVARCHAR(MAX),
				@ToObjectID			NVARCHAR(MAX),
				@FromSalesManID		NVARCHAR(MAX),
				@ToSalesManID		NVARCHAR(MAX),
				@FromInventoryID	NVARCHAR(MAX),
				@ToInventoryID		NVARCHAR(MAX),
				@InventoryTypeID	NVARCHAR(MAX) = NULL,
				@ConditionSOrderID  NVARCHAR(MAX) = '' -- Phân quyền xem phiếu báo giá.
AS

DECLARE @sSQL nvarchar(MAX) = '',
		@sSQL1 nvarchar(MAX) = '',
		@sSQL2 nvarchar(MAX) = '',
		@sSQL3 nvarchar(MAX) = '',
		@sSQL4 nvarchar(MAX) = '',
		@sSQL5 nvarchar(MAX) = '',
		@sWhere NVARCHAR(MAX) = 'WHERE '

DECLARE @CustomerName INT = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex)
    
	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' DivisionID IN ('''+@DivisionIDList+''')'
	ELSE 
		SET @sWhere = @sWhere + ' DivisionID = '''+@DivisionID+''''

	--Search theo điều điện thời gian
	IF @IsDate = 1	
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,OrderDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	ELSE
		SET @sWhere = @sWhere+' AND (CASE WHEN  MONTH(OrderDate) <10 THEN ''0''+RTRIM(LTRIM(STR(MONTH(OrderDate))))+''/''+LTRIM(RTRIM(STR(YEAR(OrderDate)))) 
										ELSE RTRIM(LTRIM(STR(MONTH(OrderDate))))+''/''+LTRIM(RTRIM(STR(YEAR(OrderDate)))) END) IN ('''+@PeriodIDList+''')'
	
	--Search theo khách hàng (Dữ liệu khách hàng nhiều nên dùng control từ khách hàng, đến khách hàng)
	IF ISNULL(@FromObjectID, '')!= '' AND ISNULL(@ToObjectID, '') = ''
		SET @sWhere = @sWhere + ' AND ISNULL(ObjectID, '''') > = N'''+@FromObjectID +''''
	ELSE IF ISNULL(@FromObjectID, '') = '' AND ISNULL(@ToObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(ObjectID, '''') < = N'''+@ToObjectID +''''
	ELSE IF ISNULL(@FromObjectID, '') != '' AND ISNULL(@ToObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(ObjectID, '''') BETWEEN N'''+@FromObjectID+''' AND N'''+@ToObjectID+''''

	--Search theo người bán hàng (Dữ liệu khách hàng nhiều nên dùng control từ người bán hàng, đến người bán hàng)
	IF ISNULL(@FromSalesManID, '')!= '' AND ISNULL(@ToInventoryID, '') = ''
		SET @sWhere = @sWhere + ' AND ISNULL(SalesManID, '''') > = N'''+@FromSalesManID +''''
	ELSE IF ISNULL(@FromSalesManID, '') = '' AND ISNULL(@ToSalesManID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(SalesManID, '''') < = N'''+@ToSalesManID +''''
	ELSE IF ISNULL(@FromSalesManID, '') != '' AND ISNULL(@ToInventoryID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(SalesManID, '''') BETWEEN N'''+@FromSalesManID+''' AND N'''+@ToSalesManID+''''

	--Search theo vật tư (Dữ liệu vật tư nhiều nên dùng control từ vật tư, đến vật tư)
	IF ISNULL(@FromInventoryID, '')!= '' AND ISNULL(@ToInventoryID, '') = ''
		SET @sWhere = @sWhere + ' AND ISNULL(InventoryID, '''') > = N'''+@FromInventoryID +''''
	ELSE IF ISNULL(@FromInventoryID, '') = '' AND ISNULL(@ToInventoryID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(InventoryID, '''') < = N'''+@ToInventoryID +''''
	ELSE IF ISNULL(@FromInventoryID, '') != '' AND ISNULL(@ToInventoryID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(InventoryID, '''') BETWEEN N'''+@FromInventoryID+''' AND N'''+@ToInventoryID+''''

	--Search theo loại sản phẩm
	IF ISNULL(@InventoryTypeID, '') != ''
	    SET @sWhere = @sWhere + ' AND S2.PaperTypeID IN ('''+@InventoryTypeID+''') AND ISNULL(S2.PaperTypeID, '''') <> '''''

	IF @CustomerName = 147 -- Customize cho VNA
	BEGIN

		IF Isnull(@ConditionSOrderID,'')!=''
			SET @sWhere = @sWhere + ' AND ( 
											ISNULL(S2.SalesManID, '''') IN ('''+@ConditionSOrderID+''' ) 
										)		'

	END

SET @sSQL = 'SELECT TypeID,UserName,IsUsed FROM AT0005 WITH (NOLOCK) WHERE TypeID like ''%S%'' AND IsUsed = 1 AND DivisionID = ''' + @DivisionID + ''''
EXEC (@sSQL)

SET @sSQL1 = N'DECLARE @TempSOP30023 TABLE (SOrderID VARCHAR(50), Date NVARCHAR(MAX),Address NVARCHAR(MAX))

              DECLARE @SumAdd NVARCHAR(MAX)='''',
					  @SumDate NVARCHAR(MAX)='''',
					  @Cur CURSOR,
					  @SOrderID VARCHAR(50) = '''',
					  @Address NVARCHAR(MAX),
					  @Date VARCHAR(50),
					  @Current_SOrderID VARCHAR(500)= (SELECT TOP 1 SOrderID FROM OT2003_MT),
					  @CountData INT = (SELECT COUNT (*) FROM OT2003_MT)

			  SET @Cur = CURSOR SCROLL KEYSET FOR
			     SELECT SOrderID, CONVERT(varchar, Date, 103), Address FROM OT2003_MT
			  OPEN @Cur
			  FETCH NEXT FROM @Cur INTO @SOrderID, @Date, @Address
			  WHILE @@FETCH_STATUS = 0
			  BEGIN
			      IF(@Current_SOrderID = @SOrderID)
			      BEGIN
			          SET @SumDate = @SumDate + '' ; '' + @Date
			          SET @SumAdd = @SumAdd + '' ; '' + @Address
			      END
			      ELSE
			      BEGIN
			          IF (@CountData = 1)
			          BEGIN
			              INSERT INTO @TempSOP30023 VALUES (@Current_SOrderID, @SumDate, @SumAdd)
			              INSERT INTO @TempSOP30023 VALUES (@SOrderID, @Date, @Address)
			          END
			          ELSE
			          BEGIN
			              INSERT INTO @TempSOP30023 VALUES (@Current_SOrderID, @SumDate, @SumAdd)
			          END
			          SET @SumDate = @Date
			          SET @SumAdd =  @Address
			          SET @Current_SOrderID = @SOrderID
			  END
			  FETCH NEXT FROM @Cur INTO @SOrderID, @Date, @Address
			  SET @CountData = @CountData - 1
			  END
			  CLOSE @Cur

              SELECT * INTO #TempAddress
              FROM @TempSOP30023'

SET @sSQL2 = N'SELECT * INTO #TempSOP30023
			  FROM(
			       SELECT O2.DivisionID, O2.OrderDate, O2.VoucherNo, O2.VoucherNo AS VoucherNoRp, O2.CurrencyID, O2.ObjectID, O2.ObjectName, O1.InventoryID, A1.InventoryName,
				          O1.UnitID, A2.UnitName, O2.SalesManID, A3.FullName AS SalesManName, O1.OrderQuantity, O1.OrderQuantity AS OrderQuantityRp, O1.SalePrice, O1.SalePrice AS SalePriceRp, O1.ConvertedAmount, (O1.ConvertedAmount * (O1.VATPercent / 100)) AS VAT,
				          (O1.ConvertedAmount + (O1.ConvertedAmount * (O1.VATPercent / 100))) AS TotalAmount,
						  CASE
							  WHEN O3.RefOrderID IS NOT NULL THEN 0
							  ELSE O1.ConvertedAmount
						  END AS ConvertedAmountRp,
						  CASE
						      WHEN O3.RefOrderID IS NOT NULL THEN 0
						      ELSE (O1.ConvertedAmount * (O1.VATPercent / 100))
						  END AS VATRp,
						  CASE
						      WHEN O3.RefOrderID IS NOT NULL THEN 0
						      ELSE (O1.ConvertedAmount + (O1.ConvertedAmount * (O1.VATPercent / 100)))
						  END AS TotalAmountRp,
						  S2.PaperTypeID, ISNULL(C1.Description, '''') AS InventoryTypeName, T1.Date, T1.Address,
						  O4.S01ID AS S01, O4.S02ID AS S02, O4.S03ID AS S03, O4.S04ID AS S04, O4.S05ID AS S05, O4.S06ID AS S06, O4.S07ID AS S07, O4.S08ID AS S08,
						  O4.S09ID AS S09, O4.S10ID AS S10, O4.S11ID AS S11, O4.S12ID AS S12, O4.S13ID AS S13, O4.S14ID AS S14, O4.S15ID AS S15, O4.S16ID AS S16,
						  O4.S17ID AS S17, O4.S18ID AS S18, O4.S19ID AS S19, O4.S20ID AS S20, N''Đơn hàng bán'' AS DataType
				   FROM OT2002 O1 WITH (NOLOCK)
				       LEFT JOIN OT2001 O2 WITH (NOLOCK) ON O1.SOrderID = O2.APK AND O2.OrderType = 0
					   LEFT JOIN AT1302 A1 WITH (NOLOCK) ON O1.InventoryID = A1.InventoryID
					   LEFT JOIN AT1304 A2 WITH (NOLOCK) ON O1.UnitID = A2.UnitID
					   LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON O1.InventoryID = S1.InventoryID AND S1.APKInherit = O2.APK
					   INNER JOIN SOT2081 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster
					   LEFT JOIN CRMT0099 C1 WITH (NOLOCK) ON C1.ID = S2.PaperTypeID AND C1.CodeMaster = ''CRMT00000022''
					   LEFT JOIN OT2007 O3 WITH (NOLOCK) ON O2.APK = O3.RefOrderID
					   LEFT JOIN #TempAddress T1 ON O2.APK = T1.SOrderID
					   LEFT JOIN OT8899 O4 WITH (NOLOCK) ON O1.TransactionID = O4.TransactionID
					   LEFT JOIN AT1103 A3 WITH (NOLOCK) ON O2.SalesManID = A3.EmployeeID
					   UNION ALL'			  

SET @sSQL3 = N'SELECT O2.DivisionID, O2.VoucherDate AS OrderDate, O2.VoucherNo, (O3.VoucherNo + ''_'' + O2.VoucherNo) AS VoucherNoRp, O2.CurrencyID, O2.ObjectID, P1.MemberName AS ObjectName,
					 O1.InventoryID, A1.InventoryName, O1.UnitID, A2.UnitName, O3.SalesManID, A3.FullName AS SalesManName,
					 ISNULL(CASE WHEN O1.AdjustQuantity IS NULL THEN O4.OrderQuantity
					    		 ELSE O1.AdjustQuantity END, 0) AS OrderQuantity, ISNULL(O1.AdjustQuantity, 0) AS OrderQuantityRp,
					 ISNULL(CASE WHEN O1.AdjustPrice IS NULL THEN O4.SalePrice
								 ELSE O1.AdjustPrice END, 0) AS SalePrice, ISNULL(O1.AdjustPrice, 0) AS SalePriceRp,
					 O1.ConvertedAmount, (O1.ConvertedAmount *(O4.VATPercent / 100)) AS VAT, (O1.ConvertedAmount + (O1.ConvertedAmount * (O4.VATPercent / 100))) AS TotalAmount,
					 O1.ConvertedAmount AS ConvertedAmountRp, (O1.ConvertedAmount *(O4.VATPercent / 100)) AS VATRp, (O1.ConvertedAmount + (O1.ConvertedAmount * (O4.VATPercent / 100))) AS TotalAmountRp,
					 S2.PaperTypeID, ISNULL(C1.Description, '''') AS InventoryTypeName, T1.Date, T1.Address,
					 O5.S01ID AS S01, O5.S02ID AS S02, O5.S03ID AS S03, O5.S04ID AS S04, O5.S05ID AS S05, O5.S06ID AS S06, O5.S07ID AS S07, O5.S08ID AS S08,
					 O5.S09ID AS S09, O5.S10ID AS S10, O5.S11ID AS S11, O5.S12ID AS S12, O5.S13ID AS S13, O5.S14ID AS S14, O5.S15ID AS S15, O5.S16ID AS S16,
					 O5.S17ID AS S17, O5.S18ID AS S18, O5.S19ID AS S19, O5.S20ID AS S20,
					 CASE WHEN O1.DataType = 1 THEN N''Đơn hàng điều chỉnh (Giá)''
					      ELSE N''Đơn hàng điều chỉnh (Lượng)'' END AS DataType
              FROM OT2007 O1 WITH (NOLOCK)
				  LEFT JOIN OT2006 O2 WITH (NOLOCK) ON O1.VoucherID = O2.VoucherID
				  LEFT JOIN POST0011 P1 WITH (NOLOCK) ON O2.ObjectID = P1.MemberID
				  LEFT JOIN AT1302 A1 WITH (NOLOCK) ON O1.InventoryID = A1.InventoryID
				  LEFT JOIN AT1304 A2 WITH (NOLOCK) ON O1.UnitID = A2.UnitID
				  LEFT JOIN OT2001 O3 WITH (NOLOCK) ON O1.RefOrderID = O3.APK AND O3.OrderType = 0
				  LEFT JOIN OT2002 O4 WITH (NOLOCK) ON O3.APK = O4.SOrderID
				  LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON O1.InventoryID = S1.InventoryID AND S1.APKInherit = O2.APK
				  INNER JOIN SOT2081 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster
				  LEFT JOIN CRMT0099 C1 WITH (NOLOCK) ON C1.ID = S2.PaperTypeID AND C1.CodeMaster = ''CRMT00000022''
				  LEFT JOIN #TempAddress T1 ON O3.APK = T1.SOrderID
				  LEFT JOIN OT8899 O5 WITH (NOLOCK) ON O4.TransactionID = O5.TransactionID
				  LEFT JOIN AT1103 A3 WITH (NOLOCK) ON O3.SalesManID = A3.EmployeeID
				  ) AS temp'

SET @sSQL4 = N'SELECT ROW_NUMBER() OVER (ORDER BY PaperTypeID) AS RowNum,* FROM #TempSOP30023 AS S2 
				'
              + @sWhere +'
              ORDER BY PaperTypeID, OrderDate, VoucherNo'

SET @sSQL5 = N'SELECT ISNULL(InventoryTypeName, '''') AS InventoryTypeName, CONVERT(DECIMAL(28,0),SUM(TotalAmountRp)) AS TotalTotalAmountRp, CONVERT(DECIMAL(28,0),SUM(VATRp)) AS TotalVATRp, CONVERT(DECIMAL(28,0),SUM(TotalAmountRp)) AS TotalAmountRp,
                      CONVERT(DECIMAL(28,0),SUM(OrderQuantityRp)) AS TotalOrderQuantityRp, CONVERT(DECIMAL(28,0),SUM(SalePriceRp)) AS TotalSalePriceRp
              FROM #TempSOP30023 AS S2
			  '+ @sWhere +'
			  GROUP BY InventoryTypeName'
print @sSQL1
print @sSQL2
print @sSQL3
print @sSQL4
print @sSQL5
EXEC (@sSQL1 + ' ' + @sSQL2 + ' ' + @sSQL3 + ' ' + @sSQL4 + ' ' + @sSQL5)








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
