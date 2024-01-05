IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CMNP90011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CMNP90011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary> 
--- Load màn hình chọn mặt hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Hoàng vũ
----Modify on 10/04/2017 by Thị Phượng, Bổ sung lấy các đối tượng có IsCommon =1 (dùng chung)
----Edited by: Phan thanh hoàng vũ, Date: 09/05/2017: Bổ sung điều kiện search phân quyền thiết lập dữ liệu (ERP8)
----Edited by: Thị Phượng, Date: 09/05/2017: Bổ sung SET @ConditionIV lúc giá trị null fix bug  
----Edited by: Thị Phượng, Date: 31/07/2017: Bổ sung lấy thêm trường VATPercent 
----Edited by: Tà Giang, Date: 27/11/2018: Bổ sung lấy thêm trường InventoryTypeID 
----Modified on 21/12/2018 by Như Hàn: Thêm các trường mã phân tích mặt hàng
----Modified on 26/05/2020 by Kiều Nga: Lấy thông tin quy cách (customize MaiThu)
----Modified on 10/12/2020 by Đình Ly: Thêm điều kiện lọc theo Loại sản phẩm (customize MaiThu)
----Modified on 14/12/2020 by Đình Ly: Thêm điều kiện lọc theo Chủng loại (MPT2) (customize MaiThu)
----Modified on 14/12/2020 by Đình Ly: Chỉnh sửa nguồn dữ liệu cột VATPercent (% thuế VAT theo Mặt hàng)
----Modified on 30/08/2021 by Kiều Nga: Bổ sung lấy thêm trường IsArea 
----Modified on 24/11/2021 by Kiều Nga: Bổ sung lấy thêm trường InventoryGroupAnaTypeID 
----Modified on 30/12/2021 by Kiều Nga: Bổ sung lấy thêm trường Barcode 
----Modified on 19/04/2022 by Minh Hiếu: Bổ sung lấy thêm trường VATPercent cho POF2009, bỏ lấy các trường phí
----Modified on 09/01/2023 by Nhật Quang: Bổ sung customize HIPC 158 chọn NVL thay thế
----Modified on 09/02/2023 by Đình Định: Bổ sung điều kiện lọc theo loại sản phẩm (HIPC) 
----Modified on 15/03/2023 by Nhật Quang: Màn hình định mức sản phẩm - Bổ sung điều kiện lọc chọn mặt hàng theo tên
----Modified on 05/05/2023 by Đức Tuyên: Dự toán màn hình Chọn mặt hàng SOF9001 lấy theo nhóm nguyên vật liệu đã chọn ở định mức
----Modified on 25/05/2023 by Nhật Thanh: Bổ sung load IsDiscount, IsDiscountWallet
----Modified on 17/08/2023 by Đức Tuyên: Bổ sung hiển thị mã phân tích mặt hàng customize INNOTEK.
----Modified on 22/12/2023 by Bi Phan: [2023/12/IS/0035] Bổ sung Thông tin vận chuyển chưa trừ lùi số lượng mặt hàng.

-- <Example>
/*
    EXEC CMNP90011 'AS', 'F',null, N'( (SELECT '''' AS DataID UNION ALL SELECT ''#'' AS DataID UNION ALL SELECT InventoryID FROM AT1302 WHERE DivisionID = ''AS''))' 
	, N'( (1=0) )' , 1,25

	EXEC CMNP90011 'AS', 'F',null, '', '((0 = 0))' , 1,25

*/

CREATE PROCEDURE CMNP90011 
(
     @DivisionID NVARCHAR(250),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
	 @ConditionIV NVARCHAR(250),		-- Lấy Biến môi trường từ module gọi tương ứng 
	 @IsUsedConditionIV NVARCHAR(250),	-- Lấy Biến môi trường từ module gọi tương ứng 
     @PageNumber INT,
     @PageSize INT,
	 @InventoryIDSelectList VARCHAR(MAX) = '', -- Lấy danh sách mặt hàng được chọn - Customer  DUCTIN (114)
	 @InventoryTypeID VARCHAR(250) = '', -- Loại mặt hàng - Customer DUCTIN (114)
	 @KindSupplierID VARCHAR(250) = '', -- Chủng loại (MTP2) - Customer DUCTIN (114)
	 @FormId VARCHAR(250) = '', 
	 @PorderId VARCHAR(250) = '',
	 @InventoryID VARCHAR(250) = NULL, -- Loại mặt hàng - Customer HIPC (158)
	 @OriginalInventoryID VARCHAR(250) = NULL,
	 @Type VARCHAR(MAX) = '',  -- Loại mặt hàng - Customer HIPC (158)
	 @MaterialGroupID VARCHAR(50) = '' -- Nhóm nguyên liệu - Customer HIPC (158)
)
AS

DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@KITID nvarchar(500),
		@CustomizeName int,
 		@sSelect NVARCHAR (MAX) ='',
		@sJoin NVARCHAR (MAX) ='',
		@InventoryGroupAnaTypeID NVARCHAR (MAX) ='',
		@All NVARCHAR (50) = N'Tất cả'

	Set @CustomizeName = (Select CustomerName from CustomerIndex)
	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'AT1302.InventoryID, AT1302.InventoryName'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'
	
	IF ISNULL(@TxtSearch,'') != ''  
	SET @sWhere = @sWhere +' AND (AT1302.InventoryID LIKE N''%'+@TxtSearch+'%'' 
							 OR AT1302.InventoryName LIKE N''%'+@TxtSearch+'%'' 
							 OR AT1304.UnitName LIKE N''%'+@TxtSearch+'%'' 
							 OR AT1302.UnitID LIKE N''%'+@TxtSearch+'%'' 
							 OR AT1302.InventoryTypeID LIKE N''%'+@TxtSearch+'%'' 
							 OR AT1302.IsStocked LIKE N''0'+@TxtSearch+'%'' 
							 OR AT1302.Barcode LIKE N''%'+@TxtSearch+'%'')'

	IF ISNULL(@ConditionIV , '') ='' SET @ConditionIV = '('''')'  

	-- Lọc dữ liệu theo Loại sản phẩm.
	IF ISNULL(@InventoryTypeID, '') != ''
		SET @sWhere = @sWhere + ' AND AT1302.InventoryTypeID = (''' + @InventoryTypeID + ''') '

	-- Lọc dữ liệu theo Chủng loại (MPT02).
	IF ISNULL(@KindSupplierID, '') != ''
		SET @sWhere = @sWhere + ' AND T25.AnaID = (''' + @KindSupplierID + ''') '

	SET @InventoryGroupAnaTypeID = (select top 1 InventoryGroupAnaTypeID from AT0000 WITH (NOLOCK) where DefDivisionID in (@DivisionID, '@@@'))

	IF ISNULL(@InventoryGroupAnaTypeID, '') != ''
		SET @sSelect = N',AT1302.'+@InventoryGroupAnaTypeID+'ID as InventoryGroupAnaTypeID'

	IF ISNULL(@FormId , '') ='' SET @FormId = @FormId + 'CMNF9001'  

	IF ISNULL(@PorderId , '') ='' SET @PorderId = '('''')'  

--lấy hàng nếu trong màn hình thông tin vận chuyển

IF (@FormId = 'POF2009')

BEGIN
 
    SET @sSelect = @sSelect +N' ,A.S01,A.S02,A.S03,A.S04,A.S05,A.S06,A.S07,A.S08,A.S09,A.S10,A.S11,A.S12,A.S13,A.S14,A.S15,A.S16,A.S17,A.S18,A.S19,A.S20 '
	SET @sJoin = N'LEFT JOIN (SELECT * FROM 
	(
		SELECT InventoryID,StandardID,StandardTypeID 
		FROM AT1323
		WHERE ISNULL(OriginalValue,0) = 1
	) src PIVOT (
		MAX(StandardID) for StandardTypeID in (S01,S02,S03,S04,S05,S06,S07,S08,S09,S10,S11,S12,S13,S14,S15,S16,S17,S18,S19,S20)
	) piv ) A ON AT1302.InventoryID = A.InventoryID'

	SET @sSQL = 'SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
					, AT1302.DivisionID
					, AT1302.InventoryID
					, AT1302.InventoryName
					, AT1302.InventoryTypeID
					, AT1302.UnitID
					, AT1304.UnitName
					, AT1302.IsCommon
					, AT1302.Disabled
					, AT1302.SalePrice01 as SalePrice
					, AT1302.VATGroupID, T10.VATGroupName, T10.VATRate
					, AT1302.I01ID, T15.AnaName As I01Name
					, AT1302.I02ID, T25.AnaName As I02Name
					, AT1302.I03ID, T35.AnaName As I03Name
					, AT1302.I04ID, T45.AnaName As I04Name
					, AT1302.I05ID, T55.AnaName As I05Name
					, ISNULL(AT1302.IsArea,0) as IsArea
					, T57.OriginalAmount
					, T57.OrderQuantity
					, T57.ConvertedAmount
					, T57.PurchasePrice	
					, T57.VATOriginalAmount
					, T57.VATConvertedAmount
					, T57.ContQuantity
					, T57.CostTowing
					, T57.CostConvertedAmount
					, T57.ImportAndExportDuties
					, T57.IExportDutiesConvertedAmount
					, T57.SafeguardingDuties
					, T57.SafeguardingDutiesConvertedAmount
					, T57.DifferentDuties
					, T57.DifferentDutiesConvertedAmount
					, T57.SumDuties
					, T57.TransactionID
					, T57.VATPercent
					, AT1302.Specification
					, AT1302.Barcode ' + @sSelect + ',
					ISNULL((Select SUM(OT8.OrderQuantity) AS OrderQuantityOT8 from OT3008 OT8 
						Where AT1302.InventoryID = OT8.InventoryID 
						AND T57.TransactionID = OT8.TransactionID
						AND OT8.POrderID = T57.POrderID
						),0) AS OrderQuantityOT18
				INTO #TempData
				FROM AT1302 WITH (NOLOCK)
					LEFT JOIN AT1304 WITH (NOLOCK) on  AT1302.UnitID = AT1304.UnitID and AT1304.Disabled = 0
					LEFT JOIN AT1010 T10 WITH (NOLOCK) ON T10.VATGroupID = AT1302.VATGroupID
					LEFT JOIN AT1015 T15 WITH (NOLOCK) ON AT1302.I01ID = T15.AnaID AND T15.AnaTypeID = ''I01''
					LEFT JOIN AT1015 T25 WITH (NOLOCK) ON AT1302.I02ID = T25.AnaID AND T25.AnaTypeID = ''I02''
					LEFT JOIN AT1015 T35 WITH (NOLOCK) ON AT1302.I03ID = T35.AnaID AND T35.AnaTypeID = ''I03''
					LEFT JOIN AT1015 T45 WITH (NOLOCK) ON AT1302.I04ID = T45.AnaID AND T45.AnaTypeID = ''I04''
					LEFT JOIN AT1015 T55 WITH (NOLOCK) ON AT1302.I05ID = T55.AnaID AND T55.AnaTypeID = ''I05''
					Inner JOIN OT3002 T57 WITH (NOLOCK) ON AT1302.InventoryID = T57.InventoryID and T57.POrderID = '''+@PorderId+'''
				'+ @sJoin +'
				WHERE AT1302.DivisionID in ('''+@DivisionID+''', ''@@@'') and AT1302.Disabled = 0  '+@sWhere+'
					--AND (ISNULL(AT1302.InventoryID, ''#'') IN (' + @ConditionIV + ') Or ' + @IsUsedConditionIV + ')
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY 
				Select RowNum, TotalRow ,DivisionID
					, InventoryID
					, InventoryName
					, InventoryTypeID
					, UnitID
					, UnitName
					, IsCommon
					, Disabled
					, SalePrice
					, VATGroupID, VATGroupName, VATRate
					, I01ID, I01Name
					, I02ID, I02Name
					, I03ID, I03Name
					, I04ID, I04Name
					, I05ID, I05Name
					, IsArea
					, OriginalAmount
					, (OrderQuantity - OrderQuantityOT18) as OrderQuantity
					, ConvertedAmount
					, PurchasePrice	
					, VATOriginalAmount
					, VATConvertedAmount
					, ContQuantity
					, CostTowing
					, CostConvertedAmount
					, ImportAndExportDuties
					, IExportDutiesConvertedAmount
					, SafeguardingDuties
					, SafeguardingDutiesConvertedAmount
					, DifferentDuties
					, DifferentDutiesConvertedAmount
					, SumDuties
					, TransactionID
					, VATPercent
					, Specification
					, Barcode ' + @sSelect + ' from #TempData A Where OrderQuantity - OrderQuantityOT18 > 0'

	EXEC (@sSQL)
	PRINT(@sSQL)
END


ELSE IF (@FormId = 'SOR3019')

BEGIN
	SET @sSQL = N'
	SELECT 0 AS RowNum, ' + @TotalRow + ' AS TotalRow
							, '''+@DivisionID+''' AS DivisionID, ''%'' AS EmployeeID, N''Tất cả'' AS EmployeeName
				UNION ALL
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
						, AT1302.DivisionID
						, AT1302.InventoryID
						, AT1302.InventoryName
						, AT1302.UnitID
						, AT1304.UnitName
					FROM AT1302 WITH (NOLOCK)
						LEFT JOIN AT1304 WITH (NOLOCK) on  AT1302.UnitID = AT1304.UnitID and AT1304.Disabled = 0
						
					'+ @sJoin +'
					WHERE AT1302.DivisionID in ('''+@DivisionID+''', ''@@@'') and AT1302.Disabled = 0  '+@sWhere+' 
						--AND (ISNULL(AT1302.InventoryID, ''#'') IN (' + @ConditionIV + ') Or ' + @IsUsedConditionIV + ')
					--ORDER BY '+@OrderBy+'
					--OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
					--FETCH NEXT '+STR(@PageSize)+' ROWS ONLY 
					'

	EXEC (@sSQL)
END

ELSE
BEGIN

	-- Lấy thông tin quy cách (customize MaiThu)
	IF (@CustomizeName = 117)
	BEGIN
		SET @sSelect = N' ,A.S01,A.S02,A.S03,A.S04,A.S05,A.S06,A.S07,A.S08,A.S09,A.S10,A.S11,A.S12,A.S13,A.S14,A.S15,A.S16,A.S17,A.S18,A.S19,A.S20 '
		SET @sJoin = N'LEFT JOIN (SELECT * FROM 
		(
			SELECT InventoryID,StandardID,StandardTypeID 
			FROM AT1323
			WHERE ISNULL(OriginalValue,0) = 1
		) src PIVOT (
			MAX(StandardID) for StandardTypeID in (S01,S02,S03,S04,S05,S06,S07,S08,S09,S10,S11,S12,S13,S14,S15,S16,S17,S18,S19,S20)
		) piv ) A ON AT1302.InventoryID = A.InventoryID'
	END
		print(@CustomizeName)
	print(@FormId)
	print(@Type)
	-- Lấy thêm dòng tất cả (Customize Angel)
	IF(@CustomizeName = 57)
	BEGIN
		SET @sSQL = N'SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * FROM (
					   SELECT '''+@DivisionID+''' AS DivisionID
						, N''%'' AS InventoryID
						, N'''+@All+''' AS InventoryName
						, NULL AS InventoryTypeID
						, NULL AS UnitID
						, NULL AS UnitName
						, NULL AS IsCommon
						, NULL AS Disabled
						, NULL AS SalePrice
						, NULL AS VATGroupID, NULL AS VATGroupName, NULL AS VATPercent
						, NULL AS I01ID, NULL AS I01Name
						, NULL AS I02ID, NULL AS I02Name
						, NULL AS I03ID, NULL AS I03Name
						, NULL AS I04ID, NULL AS I04Name
						, NULL AS I05ID, NULL AS I05Name
						, NULL AS IsArea
						, NULL AS Specification
						, NULL AS Barcode

					   UNION ALL

					   SELECT AT1302.DivisionID
						, AT1302.InventoryID
						, AT1302.InventoryName
						, AT1302.InventoryTypeID
						, AT1302.UnitID
						, AT1304.UnitName
						, AT1302.IsCommon
						, AT1302.Disabled
						, AT1302.SalePrice01 as SalePrice
						, AT1302.VATGroupID, T10.VATGroupName
						, IIF(ISNULL(T10.VATRate, 0) != 0, T10.VATRate, 0) AS VATPercent
						, AT1302.I01ID, T15.AnaName As I01Name
						, AT1302.I02ID, T25.AnaName As I02Name
						, AT1302.I03ID, T35.AnaName As I03Name
						, AT1302.I04ID, T45.AnaName As I04Name
						, AT1302.I05ID, T55.AnaName As I05Name
						, ISNULL(AT1302.IsArea,0) as IsArea
						, AT1302.Specification
						, AT1302.Barcode
						' + @sSelect + '
					FROM AT1302 WITH (NOLOCK)
						LEFT JOIN AT1304 WITH (NOLOCK) on  AT1302.UnitID = AT1304.UnitID and AT1304.Disabled = 0
						LEFT JOIN AT1010 T10 WITH (NOLOCK) ON T10.VATGroupID = AT1302.VATGroupID
						LEFT JOIN AT1015 T15 WITH (NOLOCK) ON AT1302.I01ID = T15.AnaID AND T15.AnaTypeID = ''I01''
						LEFT JOIN AT1015 T25 WITH (NOLOCK) ON AT1302.I02ID = T25.AnaID AND T25.AnaTypeID = ''I02''
						LEFT JOIN AT1015 T35 WITH (NOLOCK) ON AT1302.I03ID = T35.AnaID AND T35.AnaTypeID = ''I03''
						LEFT JOIN AT1015 T45 WITH (NOLOCK) ON AT1302.I04ID = T45.AnaID AND T45.AnaTypeID = ''I04''
						LEFT JOIN AT1015 T55 WITH (NOLOCK) ON AT1302.I05ID = T55.AnaID AND T55.AnaTypeID = ''I05''
						
					'+ @sJoin +'
					WHERE AT1302.DivisionID in ('''+@DivisionID+''', ''@@@'') and AT1302.Disabled = 0  '+@sWhere+'
						--AND (ISNULL(AT1302.InventoryID, ''#'') IN (' + @ConditionIV + ') Or ' + @IsUsedConditionIV + ')
						) AT1302
					ORDER BY '+@OrderBy+'
					OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
					FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END

	ELSE IF(@FormId = 'SOF9001' AND @InventoryID <> 'undefined') -- AND @CustomizeName = 158 
	BEGIN
		IF ISNULL(@MaterialGroupID, '') <> ''
			SET @sWhere = @sWhere + N'AND MT0006.MaterialGroupID = '''+@MaterialGroupID+''''
		SET @sSQL = N'SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
					  FROM (
						SELECT AT1302.DivisionID
						, MT0006.MaterialID AS InventoryID
						, AT1302.InventoryName 
						, AT1302.InventoryTypeID
						, ''1'' AS CoValues
						, NULL AS UnitID
						, AT1304.UnitName
						, AT1302.IsCommon
						, AT1302.Disabled
						, AT1302.SalePrice01 as SalePrice
						, AT1302.VATGroupID, T10.VATGroupName
						, IIF(ISNULL(T10.VATRate, 0) != 0, T10.VATRate, 0) AS VATPercent
						, AT1302.I01ID, T15.AnaName As I01Name
						, AT1302.I02ID, T25.AnaName As I02Name
						, AT1302.I03ID, T35.AnaName As I03Name
						, AT1302.I04ID, T45.AnaName As I04Name
						, AT1302.I05ID, T55.AnaName As I05Name
						, ISNULL(AT1302.IsArea,0) as IsArea
						, AT1302.Specification
						, AT1302.Barcode
						' + @sSelect + '
					FROM MT0006 WITH (NOLOCK)
					--	LEFT JOIN MT0007 WITH (NOLOCK) ON MT0006.MaterialGroupID = MT0007.MaterialGroupID
						LEFT JOIN AT1302 WITH (NOLOCK) ON MT0006.MaterialID = AT1302.InventoryID
						LEFT JOIN AT1304 WITH (NOLOCK) ON AT1302.UnitID = AT1304.UnitID and AT1304.Disabled = 0
						LEFT JOIN AT1010 T10 WITH (NOLOCK) ON T10.VATGroupID = AT1302.VATGroupID
						LEFT JOIN AT1015 T15 WITH (NOLOCK) ON AT1302.I01ID = T15.AnaID AND T15.AnaTypeID = ''I01''
						LEFT JOIN AT1015 T25 WITH (NOLOCK) ON AT1302.I02ID = T25.AnaID AND T25.AnaTypeID = ''I02''
						LEFT JOIN AT1015 T35 WITH (NOLOCK) ON AT1302.I03ID = T35.AnaID AND T35.AnaTypeID = ''I03''
						LEFT JOIN AT1015 T45 WITH (NOLOCK) ON AT1302.I04ID = T45.AnaID AND T45.AnaTypeID = ''I04''
						LEFT JOIN AT1015 T55 WITH (NOLOCK) ON AT1302.I05ID = T55.AnaID AND T55.AnaTypeID = ''I05''
						
					'+ @sJoin +'
					WHERE MT0006.DivisionID IN ('''+@DivisionID+''', ''@@@'') and AT1302.Disabled = 0  '+@sWhere+'
						 AND MT0006.MaterialID = '''+@OriginalInventoryID+'''
						AND (ISNULL(AT1302.InventoryTypeID, ''#'') IN (' + @ConditionIV + ') Or ' + @IsUsedConditionIV + ')

					UNION ALL

					   SELECT AT1302.DivisionID
						, MT0007.MaterialID AS InventoryID
						, AT1302.InventoryName 
						, AT1302.InventoryTypeID
						, MT0007.CoValues
						, NULL AS UnitID
						, AT1304.UnitName
						, AT1302.IsCommon
						, AT1302.Disabled
						, AT1302.SalePrice01 as SalePrice
						, AT1302.VATGroupID, T10.VATGroupName
						, IIF(ISNULL(T10.VATRate, 0) != 0, T10.VATRate, 0) AS VATPercent
						, AT1302.I01ID, T15.AnaName As I01Name
						, AT1302.I02ID, T25.AnaName As I02Name
						, AT1302.I03ID, T35.AnaName As I03Name
						, AT1302.I04ID, T45.AnaName As I04Name
						, AT1302.I05ID, T55.AnaName As I05Name
						, ISNULL(AT1302.IsArea,0) as IsArea
						, AT1302.Specification
						, AT1302.Barcode
						' + @sSelect + '
					FROM MT0006 WITH (NOLOCK)
						LEFT JOIN MT0007 WITH (NOLOCK) ON MT0006.MaterialGroupID = MT0007.MaterialGroupID
						LEFT JOIN AT1302 WITH (NOLOCK) ON MT0007.MaterialID = AT1302.InventoryID
						LEFT JOIN AT1304 WITH (NOLOCK) ON AT1302.UnitID = AT1304.UnitID and AT1304.Disabled = 0
						LEFT JOIN AT1010 T10 WITH (NOLOCK) ON T10.VATGroupID = AT1302.VATGroupID
						LEFT JOIN AT1015 T15 WITH (NOLOCK) ON AT1302.I01ID = T15.AnaID AND T15.AnaTypeID = ''I01''
						LEFT JOIN AT1015 T25 WITH (NOLOCK) ON AT1302.I02ID = T25.AnaID AND T25.AnaTypeID = ''I02''
						LEFT JOIN AT1015 T35 WITH (NOLOCK) ON AT1302.I03ID = T35.AnaID AND T35.AnaTypeID = ''I03''
						LEFT JOIN AT1015 T45 WITH (NOLOCK) ON AT1302.I04ID = T45.AnaID AND T45.AnaTypeID = ''I04''
						LEFT JOIN AT1015 T55 WITH (NOLOCK) ON AT1302.I05ID = T55.AnaID AND T55.AnaTypeID = ''I05''
						
					'+ @sJoin +'
					WHERE MT0006.DivisionID IN (''' + @DivisionID+''', ''@@@'') and AT1302.Disabled = 0  '+@sWhere+'
						 AND MT0006.MaterialID = '''+@InventoryID+'''
						--AND (ISNULL(AT1302.InventoryID, ''#'') IN (' + @ConditionIV + ') Or ' + @IsUsedConditionIV + ')
						) AT1302
					ORDER BY '+@OrderBy+'
					OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
					FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END

	ELSE IF (@CustomizeName = 158 AND @FormId = 'CMNF9001' AND @Type = N'GridEditMT2124')
		 BEGIN
		 	SET @sSQL =    N' SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow 
								, AT1302.APK, AT1302.InventoryID
		 						, AT1302.InventoryName
		 						, AT1302.UnitID, AT1304.UnitName
		 						, AT1302.InventoryTypeID
								, AT1302.IsStocked
		 	                FROM AT1302 WITH (NOLOCK)
		 					LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID
		 	               WHERE AT1302.DivisionID IN ('''+@DivisionID+''', ''@@@'') 
						     AND AT1302.InventoryTypeID = N''DV''
						     AND AT1302.IsStocked = N''0''
							 '+@sWhere+'
		 	                	
		 	                ORDER BY '+@OrderBy+'
							OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
							FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
		 END

	ELSE IF (@CustomizeName = 158 AND @FormId = 'CMNF9001' AND @Type = N'GridEditMT2125')
		 BEGIN
		 SET @sSQL =    N' SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow 
								, AT1302.APK, AT1302.InventoryID
		 						, AT1302.InventoryName
		 						, AT1302.UnitID, AT1304.UnitName
		 						, AT1302.InventoryTypeID
								, AT1302.IsStocked
		 	                FROM AT1302 WITH (NOLOCK)
		 					LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = AT1302.UnitID
		 	               WHERE AT1302.DivisionID IN ('''+@DivisionID+''', ''@@@'') 
						     AND AT1302.InventoryTypeID = N''DC''
		 	                  '+@sWhere+'

		 	                ORDER BY '+@OrderBy+'
							OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
							FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END
	ELSE IF ((select CustomerName From CustomerIndex) = 161)
	BEGIN
		SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
						, AT1302.DivisionID
						, AT1302.InventoryID
						, AT1302.InventoryName
						, AT1302.InventoryTypeID
						, AT1302.UnitID
						, AT1304.UnitName
						, AT1302.IsCommon
						, AT1302.Disabled
						, AT1302.SalePrice01 as SalePrice
						, AT1302.VATGroupID, T10.VATGroupName
						, IIF(ISNULL(T10.VATRate, 0) != 0, T10.VATRate, 0) AS VATPercent
						, AT1302.I01ID, T15.AnaName As I01Name
						, AT1302.I02ID, T25.AnaName As I02Name
						, AT1302.I03ID, T35.AnaName As I03Name
						, AT1302.I04ID, T45.AnaName As I04Name
						, AT1302.I05ID, T55.AnaName As I05Name
						, ISNULL(AT1302.IsArea,0) as IsArea
						, AT1302.Specification
						, AT1302.Barcode
					, AT1302.IsDiscount
					, AT1302.IsDiscountWallet
						, AT1302.I06ID, AT06.AnaName As I06Name, AT1302.I07ID, AT07.AnaName As I07Name, AT1302.I08ID, AT08.AnaName As I08Name,AT1302.I09ID, AT09.AnaName As I09Name , AT1302.I10ID, AT10.AnaName As I10Name
						' + @sSelect + '
					FROM AT1302 WITH (NOLOCK)
						LEFT JOIN AT1304 WITH (NOLOCK) on  AT1302.UnitID = AT1304.UnitID and AT1304.Disabled = 0
						LEFT JOIN AT1010 T10 WITH (NOLOCK) ON T10.VATGroupID = AT1302.VATGroupID
						LEFT JOIN AT1015 T15 WITH (NOLOCK) ON AT1302.I01ID = T15.AnaID AND T15.AnaTypeID = ''I01''
						LEFT JOIN AT1015 T25 WITH (NOLOCK) ON AT1302.I02ID = T25.AnaID AND T25.AnaTypeID = ''I02''
						LEFT JOIN AT1015 T35 WITH (NOLOCK) ON AT1302.I03ID = T35.AnaID AND T35.AnaTypeID = ''I03''
						LEFT JOIN AT1015 T45 WITH (NOLOCK) ON AT1302.I04ID = T45.AnaID AND T45.AnaTypeID = ''I04''
						LEFT JOIN AT1015 T55 WITH (NOLOCK) ON AT1302.I05ID = T55.AnaID AND T55.AnaTypeID = ''I05''
						LEFT JOIN AT1015 AT06 WITH (NOLOCK) ON AT06.AnaID = AT1302.I06ID AND AT06.AnaTypeID = ''I06''
						LEFT JOIN AT1015 AT07 WITH (NOLOCK) ON AT07.AnaID = AT1302.I07ID AND AT07.AnaTypeID = ''I07''
						LEFT JOIN AT1015 AT08 WITH (NOLOCK) ON AT08.AnaID = AT1302.I08ID AND AT08.AnaTypeID = ''I08''
						LEFT JOIN AT1015 AT09 WITH (NOLOCK) ON AT09.AnaID = AT1302.I09ID AND AT09.AnaTypeID = ''I09''
						LEFT JOIN AT1015 AT10 WITH (NOLOCK) ON AT10.AnaID = AT1302.I10ID AND AT10.AnaTypeID = ''I10''
					'+ @sJoin +'
					WHERE AT1302.DivisionID in ('''+@DivisionID+''', ''@@@'')   and AT1302.Disabled = 0  '+@sWhere+'
						--AND (ISNULL(AT1302.InventoryID, ''#'') IN (' + @ConditionIV + ') Or ' + @IsUsedConditionIV + ')
					ORDER BY '+@OrderBy+'
					OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
					FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END
	ELSE
	BEGIN
		SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
						, AT1302.DivisionID
						, AT1302.InventoryID
						, AT1302.InventoryName
						, AT1302.InventoryTypeID
						, AT1302.UnitID
						, AT1304.UnitName
						, AT1302.IsCommon
						, AT1302.Disabled
						, AT1302.SalePrice01 as SalePrice
						, AT1302.VATGroupID, T10.VATGroupName
						, IIF(ISNULL(T10.VATRate, 0) != 0, T10.VATRate, 0) AS VATPercent
						, AT1302.I01ID, T15.AnaName As I01Name
						, AT1302.I02ID, T25.AnaName As I02Name
						, AT1302.I03ID, T35.AnaName As I03Name
						, AT1302.I04ID, T45.AnaName As I04Name
						, AT1302.I05ID, T55.AnaName As I05Name
						, ISNULL(AT1302.IsArea,0) as IsArea
						, AT1302.Specification
						, AT1302.Barcode
					, AT1302.IsDiscount
					, AT1302.IsDiscountWallet
						' + @sSelect + '
					FROM AT1302 WITH (NOLOCK)
						LEFT JOIN AT1304 WITH (NOLOCK) on  AT1302.UnitID = AT1304.UnitID and AT1304.Disabled = 0
						LEFT JOIN AT1010 T10 WITH (NOLOCK) ON T10.VATGroupID = AT1302.VATGroupID
						LEFT JOIN AT1015 T15 WITH (NOLOCK) ON AT1302.I01ID = T15.AnaID AND T15.AnaTypeID = ''I01''
						LEFT JOIN AT1015 T25 WITH (NOLOCK) ON AT1302.I02ID = T25.AnaID AND T25.AnaTypeID = ''I02''
						LEFT JOIN AT1015 T35 WITH (NOLOCK) ON AT1302.I03ID = T35.AnaID AND T35.AnaTypeID = ''I03''
						LEFT JOIN AT1015 T45 WITH (NOLOCK) ON AT1302.I04ID = T45.AnaID AND T45.AnaTypeID = ''I04''
						LEFT JOIN AT1015 T55 WITH (NOLOCK) ON AT1302.I05ID = T55.AnaID AND T55.AnaTypeID = ''I05''
						
					'+ @sJoin +'
					WHERE AT1302.DivisionID in ('''+@DivisionID+''', ''@@@'')   and AT1302.Disabled = 0  '+@sWhere+'
						--AND (ISNULL(AT1302.InventoryID, ''#'') IN (' + @ConditionIV + ') Or ' + @IsUsedConditionIV + ')
					ORDER BY '+@OrderBy+'
					OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
					FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END

	EXEC (@sSQL)
	PRINT(@sSQL)
	PRINT(@FormId)

END

DROP TABLE IF EXISTS #TempData

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
