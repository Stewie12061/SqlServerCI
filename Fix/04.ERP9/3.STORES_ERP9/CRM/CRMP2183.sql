IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2183]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2183]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO













-- <Summary> 
--- Load màn hình chọn mặt hàng clone từ store CMNP90011
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
----Modify on 21/12/2018 by Như Hàn: Thêm các trường mã phân tích mặt hàng
----Modify on 26/05/2020 by Kiều Nga: Lấy thông tin quy cách (customize MaiThu)
----Modify on 10/12/2020 by Đình Ly: Thêm điều kiện lọc theo Loại sản phẩm (customize MaiThu)
----Modify on 14/12/2020 by Đình Ly: Thêm điều kiện lọc theo Chủng loại (MPT2) (customize MaiThu)

-- <Example>
/*
    EXEC CRMP2183 'AS', 'F',null, N'( (SELECT '''' AS DataID UNION ALL SELECT ''#'' AS DataID UNION ALL SELECT InventoryID FROM AT1302 WHERE DivisionID = ''AS''))' 
	, N'( (1=0) )' , 1,25

	EXEC CRMP2183 'AS', 'F',null, '', '((0 = 0))' , 1,25

*/

CREATE PROCEDURE CRMP2183 
(
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
	 @ConditionIV NVARCHAR(250),		-- Lấy Biến môi trường từ module gọi tương ứng 
	 @IsUsedConditionIV NVARCHAR(250),	-- Lấy Biến môi trường từ module gọi tương ứng 
     @PageNumber INT,
     @PageSize INT,
	 @InventoryIDSelectList VARCHAR(MAX) = '', -- Lấy danh sách mặt hàng được chọn - Customer  DUCTIN (114)
	 @InventoryTypeID VARCHAR(250) = '', -- Loại mặt hàng - Customer DUCTIN (114)
	 @KindSupplierID VARCHAR(250) = '', -- Chủng loại (MTP2) - Customer DUCTIN (114)
	 @inventoryIDConvert NVARCHAR(MAX) -- Lấy dánh sách mặt hàng từ lưới sản phẩm trong màn hình chi tiết Cơ hội - CRMF2052
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@KITID nvarchar(500),
		@CustomizeName int,
 		@sSelect NVARCHAR (MAX) ='',
		@sJoin NVARCHAR (MAX) =''

	Set @CustomizeName = (Select CustomerName from CustomerIndex)
	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'AT1302.InventoryID, AT1302.InventoryName'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'
	
	IF ISNULL(@inventoryIDConvert, '') != ''
	SET @sWhere = @sWhere + ' AND AT1302.InventoryID NOT IN (' + @inventoryIDConvert +')'

	IF Isnull(@TxtSearch,'') != ''  
		SET @sWhere = @sWhere +'
						AND (AT1302.InventoryID LIKE N''%'+@TxtSearch+'%'' 
						OR AT1302.InventoryName LIKE N''%'+@TxtSearch+'%'' 
						OR AT1304.UnitName LIKE N''%'+@TxtSearch+'%'' 
						OR AT1302.UnitID LIKE N''%'+@TxtSearch+'%'') '


	SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
					, AT1302.APK
					, AT1302.DivisionID
					, AT1302.InventoryID
					, AT1302.InventoryName
					, AT1302.InventoryTypeID
					, AT1302.UnitID
					, AT1304.UnitName
					, AT1302.IsCommon
					, AT1302.Disabled
					, AT1302.SalePrice01 as SalePrice
					, AT1302.SalePrice01 as UnitPrice
					, AT1302.VATGroupID,T10.VATGroupName, AT1302.VATPercent
					, AT1302.I01ID, T15.AnaName As I01Name
					, AT1302.I02ID, T25.AnaName As I02Name
					, AT1302.I03ID, T35.AnaName As I03Name
					, AT1302.I04ID, T45.AnaName As I04Name
					, AT1302.I05ID, T55.AnaName As I05Name
					, AT1302.Specification' + @sSelect + '
					, OT1302.DiscountAmount AS Discountamount
				FROM AT1302 WITH (NOLOCK)
					LEFT JOIN OT1302 WITH (NOLOCK) ON OT1302.InventoryID = AT1302.InventoryID
					LEFT join AT1304 WITH (NOLOCK) on  AT1302.UnitID = AT1304.UnitID and AT1304.Disabled = 0
					LEFT JOIN AT1010 T10 WITH (NOLOCK) ON T10.VATGroupID = AT1302.VATGroupID
					LEFT JOIN AT1015 T15 WITH (NOLOCK) ON AT1302.I01ID = T15.AnaID AND T15.AnaTypeID = ''I01''
					LEFT JOIN AT1015 T25 WITH (NOLOCK) ON AT1302.I02ID = T25.AnaID AND T25.AnaTypeID = ''I02''
					LEFT JOIN AT1015 T35 WITH (NOLOCK) ON AT1302.I03ID = T35.AnaID AND T35.AnaTypeID = ''I03''
					LEFT JOIN AT1015 T45 WITH (NOLOCK) ON AT1302.I04ID = T45.AnaID AND T45.AnaTypeID = ''I04''
					LEFT JOIN AT1015 T55 WITH (NOLOCK) ON AT1302.I05ID = T55.AnaID AND T55.AnaTypeID = ''I05''
				'+ @sJoin +'
				WHERE AT1302.DivisionID in ('''+@DivisionID+''', ''@@@'') and AT1302.Disabled = 0  '+@sWhere+'
					--AND (ISNULL(AT1302.InventoryID, ''#'') IN (' + @ConditionIV + ') Or ' + @IsUsedConditionIV + ')
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY ' 

EXEC (@sSQL)
PRINT(@sSQL)














GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
