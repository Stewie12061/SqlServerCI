IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30020]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO











---Created by: Trọng Kiên, date:  02/12/2020
---Purpose: In báo cáo tổng hợp bán hàng theo loại sản phẩm
---- Modified on	08/04/2022 by Văn Tài - Bổ sung phân quyền xem đơn hàng VNA.
-- EXEC SOP30020 'MK',0,2,2016,2,2016,'2016-02-01','2016-02-14','vd05','vd05',0

CREATE PROCEDURE [dbo].[SOP30020] 
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
		@sWhere NVARCHAR(MAX) = 'WHERE '

DECLARE @CustomerName INT = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex)

    
	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' O2.DivisionID IN ('''+@DivisionIDList+''')'
	ELSE 
		SET @sWhere = @sWhere + ' O2.DivisionID = '''+@DivisionID+''''

	--Search theo điều điện thời gian
	IF @IsDate = 1	
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,O2.OrderDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	ELSE
		SET @sWhere = @sWhere+' AND (CASE WHEN  MONTH(O2.OrderDate) <10 THEN ''0''+RTRIM(LTRIM(STR(MONTH(O2.OrderDate))))+''/''+LTRIM(RTRIM(STR(YEAR(O2.OrderDate)))) 
										ELSE RTRIM(LTRIM(STR(MONTH(O2.OrderDate))))+''/''+LTRIM(RTRIM(STR(YEAR(O2.OrderDate)))) END) IN ('''+@PeriodIDList+''')'
	
	--Search theo khách hàng (Dữ liệu khách hàng nhiều nên dùng control từ khách hàng, đến khách hàng)
	IF ISNULL(@FromObjectID, '')!= '' AND ISNULL(@ToObjectID, '') = ''
		SET @sWhere = @sWhere + ' AND ISNULL(O2.ObjectID, '''') > = N'''+@FromObjectID +''''
	ELSE IF ISNULL(@FromObjectID, '') = '' AND ISNULL(@ToObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(O2.ObjectID, '''') < = N'''+@ToObjectID +''''
	ELSE IF ISNULL(@FromObjectID, '') != '' AND ISNULL(@ToObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(O2.ObjectID, '''') BETWEEN N'''+@FromObjectID+''' AND N'''+@ToObjectID+''''

	--Search theo người bán hàng (Dữ liệu khách hàng nhiều nên dùng control từ người bán hàng, đến người bán hàng)
	IF ISNULL(@FromSalesManID, '')!= '' AND ISNULL(@ToInventoryID, '') = ''
		SET @sWhere = @sWhere + ' AND ISNULL(O2.SalesManID, '''') > = N'''+@FromSalesManID +''''
	ELSE IF ISNULL(@FromSalesManID, '') = '' AND ISNULL(@ToSalesManID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(O2.SalesManID, '''') < = N'''+@ToSalesManID +''''
	ELSE IF ISNULL(@FromSalesManID, '') != '' AND ISNULL(@ToInventoryID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(O2.SalesManID, '''') BETWEEN N'''+@FromSalesManID+''' AND N'''+@ToSalesManID+''''

	--Search theo vật tư (Dữ liệu vật tư nhiều nên dùng control từ vật tư, đến vật tư)
	IF ISNULL(@FromInventoryID, '')!= '' AND ISNULL(@ToInventoryID, '') = ''
		SET @sWhere = @sWhere + ' AND ISNULL(O2.InventoryID, '''') > = N'''+@FromInventoryID +''''
	ELSE IF ISNULL(@FromInventoryID, '') = '' AND ISNULL(@ToInventoryID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(O2.InventoryID, '''') < = N'''+@ToInventoryID +''''
	ELSE IF ISNULL(@FromInventoryID, '') != '' AND ISNULL(@ToInventoryID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(O2.InventoryID, '''') BETWEEN N'''+@FromInventoryID+''' AND N'''+@ToInventoryID+''''

	--Search theo loại sản phẩm
	IF ISNULL(@InventoryTypeID, '') != ''
	    SET @sWhere = @sWhere + ' AND S2.PaperTypeID IN ('''+@InventoryTypeID+''')'

	IF @CustomerName = 147 -- Customize cho VNA
	BEGIN

		IF Isnull(@ConditionSOrderID,'')!=''
			SET @sWhere = @sWhere + ' AND ( 
											ISNULL(O2.EmployeeID, '''') IN ('''+@ConditionSOrderID+''' ) 
											OR ISNULL(O2.SalesManID, '''') IN ('''+@ConditionSOrderID+''' ) 
										)		'

	END

SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY S2.PaperTypeID) AS RowNum, C1.Description, S2.PaperTypeID, O2.CurrencyID,
				   SUM(CASE 
						   WHEN O3.RefOrderID IS NOT NULL THEN CASE 
																   WHEN  O3.DataType = 2 THEN O3.AdjustQuantity
																   ELSE O1.OrderQuantity
															   END
						   ELSE O1.OrderQuantity 
					   END) AS OrderQuantity,
				   SUM(CASE 
						   WHEN O3.RefOrderID IS NOT NULL THEN O3.OriginalAmount
						   ELSE O1.OriginalAmount 
					   END) AS OriginalAmount,
				   SUM(CASE 
						   WHEN O3.RefOrderID IS NOT NULL THEN O3.ConvertedAmount
						   ELSE O1.ConvertedAmount 
						END) AS ConvertedAmount,
				   SUM(CASE 
						   WHEN O3.RefOrderID IS NOT NULL THEN O3.ConvertedAmount * (O1.VATPercent / 100)
						   ELSE O1.VATConvertedAmount 
						END) AS VATConvertedAmount,
				   SUM(CASE 
						   WHEN O3.RefOrderID IS NOT NULL THEN (O3.ConvertedAmount * (O1.VATPercent / 100) + O3.ConvertedAmount)
						   ELSE (O1.VATConvertedAmount + O1.ConvertedAmount)
						END) AS VATAfterTotalAmount
			FROM OT2002 O1 WITH (NOLOCK)
			LEFT JOIN OT2001 O2 WITH (NOLOCK) ON O1.SOrderID = O2.APK
			INNER JOIN SOT2080 S1 WITH (NOLOCK) ON O1.InventoryID = S1.InventoryID AND S1.APKInherit = O2.APK
			INNER JOIN SOT2081 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster
			LEFT JOIN OT2007 O3 WITH (NOLOCK) ON O2.APK = O3.RefOrderID
			LEFT JOIN CRMT0099 C1 WITH (NOLOCK) ON C1.ID = S2.PaperTypeID AND C1.CodeMaster = ''CRMT00000022''
			' + @sWhere + '
			GROUP BY C1.Description, S2.PaperTypeID, O2.CurrencyID'
   print @sSQL     
        IF exists(Select Top 1 1 From sysObjects WITH (NOLOCK) Where XType = 'V' and Name = 'OV30020')
	       DROP VIEW OV30020

        EXEC('Create view OV30020 --tao boi SOP30020 
		      as ' + @sSQL)

		SELECT * FROM OV30020

        SELECT SUM(OrderQuantity) AS TotalOrderQuantity, SUM(OriginalAmount) AS TotalOriginalAmount,
			    SUM(ConvertedAmount) AS TotalConvertedAmount, SUM(VATConvertedAmount) AS TotalVATConvertedAmount,
				SUM(VATAfterTotalAmount) AS VATAfterTotalAmount
		FROM OV30020









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
