IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2025]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2025]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----Created by: Trọng Kiên, date: 19/04/2021
----Modified by Lê Hoàng on 29/07/2021 : load phí vận chuyển lắp đặt từ tham số chi tiết, load tiêu chuẩn từ bảng tính giá
----Modified by Văn Tài	 on 29/07/2021 : Hỗ trợ xử lý lỗi không khai báo danh sách tiêu chuẩn mặt hàng.
---- exec SOP2025 @Divisionid=N'ANG',@Tranmonth=1,@Tranyear=2016,@APK=N''

CREATE PROCEDURE [dbo].[SOP2025] 
				@DivisionID AS nvarchar(50),
				@APK AS nvarchar(4000),
				@Template AS VARCHAR(50),
				@Language AS VARCHAR(50) = 'vi-VN'
AS

DECLARE @sSQL00 NVARCHAR(MAX) ='',
		@sSQL NVARCHAR(MAX) =''

--lấy danh sác tiêu chuẩn của mặt hàng 
DECLARE @PivotColumns AS NVARCHAR(MAX)

SELECT DISTINCT S11.StandardID INTO #PivotStandard
FROM OT2102 O02 WITH(NOLOCK)
LEFT JOIN SOT2110 S10 WITH(NOLOCK) ON S10.DivisionID = O02.DivisionID AND S10.APK = O02.InheritVoucherID AND S10.APK = O02.InheritTransactionID
LEFT JOIN SOT2111 S11 WITH(NOLOCK) ON S11.DivisionID = S10.DivisionID AND S11.APKMaster = S10.APK 
LEFT JOIN QCT1000 Q10 WITH(NOLOCK) ON Q10.DivisionID IN (S11.DivisionID,'@@@') AND Q10.StandardID = S11.StandardID
WHERE O02.DivisionID = @DivisionID AND O02.QuotationID = @APK AND O02.InheritTableID = 'SOT2110' 

SELECT @PivotColumns = COALESCE(@PivotColumns + ',','') + QUOTENAME(Standard)
FROM (SELECT StandardID as Standard FROM #PivotStandard) AS PivotExample

PRINT @PivotColumns

SET @sSQL00 = N'
					SELECT OT2102APK, DivisionID, TransactionID, QuotationID, InventoryID,
					   APKMaster, '+@PivotColumns+' INTO #PivotStandardData
					FROM (SELECT O02.APK OT2102APK, O02.DivisionID, O02.TransactionID, O02.QuotationID, O02.InventoryID,
								 S11.APKMaster, S11.StandardID, S11.StandardValue
							FROM OT2102 O02
							LEFT JOIN SOT2110 S10 WITH(NOLOCK) ON S10.DivisionID = O02.DivisionID AND S10.APK = O02.InheritVoucherID AND S10.APK = O02.InheritTransactionID
							LEFT JOIN SOT2111 S11 WITH(NOLOCK) ON S11.DivisionID = S10.DivisionID AND S11.APKMaster = S10.APK 
							LEFT JOIN QCT1000 Q10 WITH(NOLOCK) ON Q10.DivisionID IN (S11.DivisionID,''@@@'') AND Q10.StandardID = S11.StandardID
							WHERE O02.DivisionID = ''' + @DivisionID + ''' AND O02.QuotationID = ''' + @APK + ''' AND O02.InheritTableID = ''SOT2110'' 
							) AS Standard_Temp
							PIVOT
							( 
								MAX(StandardValue)
								FOR StandardID IN ('+@PivotColumns+')
							) AS  PVT'

IF (ISNULL(@PivotColumns, '') = '')
BEGIN
	IF (@Template = 'SOR2020ReportMECI_1')
	BEGIN
		SET @sSQL = N' SELECT O1.InventoryID, A1.InventoryName, O3.S01ID, O3.S02ID, O3.S03ID, O3.S04ID
					   , O1.QuoQuantity, O1.UnitPrice, O1.OriginalAmount AS Amount, ISNULL(O1.QD01,0) AS Fee
					   , ISNULL(O1.VATConvertedAmount, 0) AS VATConvertedAmount
					   FROM OT2102 O1 WITH (NOLOCK)
						   LEFT JOIN OT2101 O2 WITH (NOLOCK) ON O1.QuotationID = O2.QuotationID
						   LEFT JOIN AT1302 A1 WITH (NOLOCK) ON A1.DivisionID IN (O1.DivisionID,''@@@'') AND O1.InventoryID = A1.InventoryID
						   LEFT JOIN OT8899 O3 WITH (NOLOCK) ON O3.DivisionID = O1.DivisionID AND O1.TransactionID = O3.TransactionID AND O3.TableID = ''OT2102''
						   --LEFT JOIN #PivotStandardData R01 WITH(NOLOCK) ON R01.OT2102APK = O1.APK
					   WHERE O2.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), O2.APK) = ''' + @APK + '''
					   ORDER BY O1.Orders'
	END
	ELSE IF (@Template = 'SOR2020ReportMECI_2')
		SET @sSQL = N' SELECT CONCAT(A1.InventoryName, CHAR(13), O1.Notes, CHAR(13), O1.Notes01, CHAR(13), O1.Notes02) AS InventoryName
					   , O3.S05ID, O3.S06ID, O3.S07ID, O3.S08ID
					   , O1.QuoQuantity, O1.UnitPrice, O1.OriginalAmount AS Amount, ISNULL(O1.QD01,0) AS Fee
					   , ISNULL(O1.VATConvertedAmount, 0) AS VATConvertedAmount
					   FROM OT2102 O1 WITH (NOLOCK)
						   LEFT JOIN OT2101 O2 WITH (NOLOCK) ON O1.QuotationID = O2.QuotationID
						   LEFT JOIN AT1302 A1 WITH (NOLOCK) ON O1.InventoryID = A1.InventoryID
						   LEFT JOIN OT8899 O3 WITH (NOLOCK) ON O1.TransactionID = O3.TransactionID AND O3.TableID = ''OT2102''
						   --LEFT JOIN #PivotStandardData R01 WITH(NOLOCK) ON R01.OT2102APK = O1.APK
					   WHERE O2.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), O2.APK) = ''' + @APK + '''
					   ORDER BY O1.Orders'

	ELSE IF (@Template = 'SOR2020ReportMECI_3')
		SET @sSQL = N' SELECT CONCAT(A1.InventoryName, CHAR(13), O1.Notes, CHAR(13), O1.Notes01, CHAR(13), O1.Notes02) AS InventoryName
					   , O3.S05ID, O3.S09ID, O3.S10ID
					   , O1.QuoQuantity, O1.UnitPrice, O1.OriginalAmount AS Amount, ISNULL(O1.QD01,0) AS Fee
					   , ISNULL(O1.VATConvertedAmount, 0) AS VATConvertedAmount
					   FROM OT2102 O1 WITH (NOLOCK)
						   LEFT JOIN OT2101 O2 WITH (NOLOCK) ON O1.QuotationID = O2.QuotationID
						   LEFT JOIN AT1302 A1 WITH (NOLOCK) ON O1.InventoryID = A1.InventoryID
						   LEFT JOIN OT8899 O3 WITH (NOLOCK) ON O1.TransactionID = O3.TransactionID AND O3.TableID = ''OT2102''
						   --LEFT JOIN #PivotStandardData R01 WITH(NOLOCK) ON R01.OT2102APK = O1.APK
					   WHERE O2.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), O2.APK) = ''' + @APK + '''
					   ORDER BY O1.Orders'

	ELSE IF (@Template = 'SOR2020ReportMECI_4')
		SET @sSQL = N' SELECT O1.InventoryID, A1.InventoryName, '''' AS Specification, A2.Image01ID AS Image
					   , O1.QuoQuantity, O1.UnitPrice, O1.OriginalAmount AS Amount, ISNULL(O1.QD01,0) AS Fee
					   , ISNULL(O1.VATConvertedAmount, 0) AS VATConvertedAmount
					   FROM OT2102 O1 WITH (NOLOCK)
						   LEFT JOIN OT2101 O2 WITH (NOLOCK) ON O1.QuotationID = O2.QuotationID
						   LEFT JOIN AT1302 A1 WITH (NOLOCK) ON O1.InventoryID = A1.InventoryID
						   LEFT JOIN A00003 A2 WITH (NOLOCK) ON A1.InventoryID = A2.InventoryID
						   --LEFT JOIN #PivotStandardData R01 WITH(NOLOCK) ON R01.OT2102APK = O1.APK
					   WHERE O2.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), O2.APK) = ''' + @APK + '''
					   ORDER BY O1.Orders'
				   
END
ELSE
BEGIN
	IF (@Template = 'SOR2020ReportMECI_1')
	BEGIN
		SET @sSQL = N' SELECT O1.InventoryID, A1.InventoryName, O3.S01ID, O3.S02ID, O3.S03ID, O3.S04ID
					   , O1.QuoQuantity, O1.UnitPrice, O1.OriginalAmount AS Amount, ISNULL(O1.QD01,0) AS Fee
					   , '+@PivotColumns+'
					   , ISNULL(O1.VATConvertedAmount, 0) AS VATConvertedAmount
					   FROM OT2102 O1 WITH (NOLOCK)
						   LEFT JOIN OT2101 O2 WITH (NOLOCK) ON O1.QuotationID = O2.QuotationID
						   LEFT JOIN AT1302 A1 WITH (NOLOCK) ON A1.DivisionID IN (O1.DivisionID,''@@@'') AND O1.InventoryID = A1.InventoryID
						   LEFT JOIN OT8899 O3 WITH (NOLOCK) ON O3.DivisionID = O1.DivisionID AND O1.TransactionID = O3.TransactionID AND O3.TableID = ''OT2102''
						   LEFT JOIN #PivotStandardData R01 WITH(NOLOCK) ON R01.OT2102APK = O1.APK
					   WHERE O2.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), O2.APK) = ''' + @APK + '''
					   ORDER BY O1.Orders'
	END
	ELSE IF (@Template = 'SOR2020ReportMECI_2')
		SET @sSQL = N' SELECT CONCAT(A1.InventoryName, CHAR(13), O1.Notes, CHAR(13), O1.Notes01, CHAR(13), O1.Notes02) AS InventoryName
					   , O3.S05ID, O3.S06ID, O3.S07ID, O3.S08ID
					   , O1.QuoQuantity, O1.UnitPrice, O1.OriginalAmount AS Amount, ISNULL(O1.QD01,0) AS Fee
					   , '+@PivotColumns+'
					   , ISNULL(O1.VATConvertedAmount, 0) AS VATConvertedAmount
					   FROM OT2102 O1 WITH (NOLOCK)
						   LEFT JOIN OT2101 O2 WITH (NOLOCK) ON O1.QuotationID = O2.QuotationID
						   LEFT JOIN AT1302 A1 WITH (NOLOCK) ON O1.InventoryID = A1.InventoryID
						   LEFT JOIN OT8899 O3 WITH (NOLOCK) ON O1.TransactionID = O3.TransactionID AND O3.TableID = ''OT2102''
						   LEFT JOIN #PivotStandardData R01 WITH(NOLOCK) ON R01.OT2102APK = O1.APK
					   WHERE O2.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), O2.APK) = ''' + @APK + '''
					   ORDER BY O1.Orders'

	ELSE IF (@Template = 'SOR2020ReportMECI_3')
		SET @sSQL = N' SELECT CONCAT(A1.InventoryName, CHAR(13), O1.Notes, CHAR(13), O1.Notes01, CHAR(13), O1.Notes02) AS InventoryName
					   , O3.S05ID, O3.S09ID, O3.S10ID
					   , O1.QuoQuantity, O1.UnitPrice, O1.OriginalAmount AS Amount, ISNULL(O1.QD01,0) AS Fee
					   , '+@PivotColumns+'
					   , ISNULL(O1.VATConvertedAmount, 0) AS VATConvertedAmount
					   FROM OT2102 O1 WITH (NOLOCK)
						   LEFT JOIN OT2101 O2 WITH (NOLOCK) ON O1.QuotationID = O2.QuotationID
						   LEFT JOIN AT1302 A1 WITH (NOLOCK) ON O1.InventoryID = A1.InventoryID
						   LEFT JOIN OT8899 O3 WITH (NOLOCK) ON O1.TransactionID = O3.TransactionID AND O3.TableID = ''OT2102''
						   LEFT JOIN #PivotStandardData R01 WITH(NOLOCK) ON R01.OT2102APK = O1.APK
					   WHERE O2.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), O2.APK) = ''' + @APK + '''
					   ORDER BY O1.Orders'

	ELSE IF (@Template = 'SOR2020ReportMECI_4')
		SET @sSQL = N' SELECT O1.InventoryID, A1.InventoryName, '''' AS Specification, A2.Image01ID AS Image
					   , O1.QuoQuantity, O1.UnitPrice, O1.OriginalAmount AS Amount, ISNULL(O1.QD01,0) AS Fee
					   , '+@PivotColumns+'
					   , ISNULL(O1.VATConvertedAmount, 0) AS VATConvertedAmount
					   FROM OT2102 O1 WITH (NOLOCK)
						   LEFT JOIN OT2101 O2 WITH (NOLOCK) ON O1.QuotationID = O2.QuotationID
						   LEFT JOIN AT1302 A1 WITH (NOLOCK) ON O1.InventoryID = A1.InventoryID
						   LEFT JOIN A00003 A2 WITH (NOLOCK) ON A1.InventoryID = A2.InventoryID
						   LEFT JOIN #PivotStandardData R01 WITH(NOLOCK) ON R01.OT2102APK = O1.APK
					   WHERE O2.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), O2.APK) = ''' + @APK + '''
					   ORDER BY O1.Orders'
END

PRINT (@sSQL00 + @sSQL)
EXEC (@sSQL00 + @sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
