IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CMNP90012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CMNP90012]
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
----Created by: Dũng DV
--Khi gọi màn hình CMNF9001 từ màn hình POSF2051 ( sự kiện nhấn button linh kiện/ dịch vụ ) : Chỉ load thông tin linh kiện dịch vụ có trong bảng giá được check chọn sử dung ở màn hình danh mục cửa hàng ( tab TT hàng hóa) 
--exec CMNP90012 @DivisionID=N'NN',@TxtSearch=N'',@UserID=N'SUPPORT2',@ConditionIV=N' ',@IsUsedConditionIV=N' (0=0) ',@ShopID=N'CH01',@PageNumber=1,@PageSize=25
 CREATE PROCEDURE CMNP90012 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
	 @ConditionIV NVARCHAR(250),		--lấy Biến môi trường từ module gọi tương ứng 
	 @IsUsedConditionIV NVARCHAR(250),	--lấy Biến môi trường từ module gọi tương ứng 
	 @ShopID VARCHAR(25), 
     @PageNumber INT,
     @PageSize INT,
	 @IsStocked INT =0
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@KITID nvarchar(500),
		@CustomizeName int
 
	Set @CustomizeName = (Select CustomerName from CustomerIndex)
	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'AT1302.InventoryID, AT1302.InventoryName'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'
	
	
			IF Isnull(@TxtSearch,'') != ''  SET @sWhere = @sWhere +'
											AND (AT1302.InventoryID LIKE N''%'+@TxtSearch+'%'' 
											OR AT1302.InventoryName LIKE N''%'+@TxtSearch+'%'' 
											OR AT1304.UnitName LIKE N''%'+@TxtSearch+'%'' 
											OR AT1302.UnitID LIKE N''%'+@TxtSearch+'%'') '
	If isnull(@ConditionIV , '') =''  SET @ConditionIV = '('''')'  

	IF Isnull(@IsStocked,0) = 1
		SET @sWhere = @sWhere +' and AT1302.IsStocked = 1 '
	
	SET @sSQL = '
						SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
						 AT1302.DivisionID, AT1302.InventoryID, AT1302.InventoryName, AT1302.InventoryTypeID
									, AT1302.UnitID, AT1304.UnitName, AT1302.IsCommon, AT1302.Disabled
									, AT1302.SalePrice01 as SalePrice, AT1302.VATGroupID, AT1302.VATPercent,
									AT1302.I01ID, T15.AnaName As I01Name, 
									AT1302.I02ID, T25.AnaName As I02Name,
									AT1302.I03ID, T35.AnaName As I03Name,
									AT1302.I04ID, T45.AnaName As I04Name,
									AT1302.I05ID, T55.AnaName As I05Name, AT1302.Specification
									,OT1302.UnitPrice,OT1302.Notes01,OT1302.Notes02
									,OT1302.Notes
						FROM AT1302 WITH (NOLOCK)
						JOIN  OT1302 ON AT1302.InventoryID = OT1302.InventoryID
						JOIN POST0010 ON  POST0010.ServicePriceID=OT1302.ID
						Left join AT1304 WITH (NOLOCK) on  AT1302.UnitID = AT1304.UnitID and AT1304.Disabled = 0
						LEFT JOIN AT1015 T15 WITH (NOLOCK) ON AT1302.I01ID = T15.AnaID AND T15.AnaTypeID = ''I01''
						LEFT JOIN AT1015 T25 WITH (NOLOCK) ON AT1302.I02ID = T25.AnaID AND T25.AnaTypeID = ''I02''
						LEFT JOIN AT1015 T35 WITH (NOLOCK) ON AT1302.I03ID = T35.AnaID AND T35.AnaTypeID = ''I03''
						LEFT JOIN AT1015 T45 WITH (NOLOCK) ON AT1302.I04ID = T45.AnaID AND T45.AnaTypeID = ''I04''
						LEFT JOIN AT1015 T55 WITH (NOLOCK) ON AT1302.I05ID = T55.AnaID AND T55.AnaTypeID = ''I05''
						WHERE AT1302.DivisionID in ('''+@DivisionID+''', ''@@@'') and AT1302.Disabled = 0 and POST0010.ShopID ='''+@ShopID+''' '+@sWhere+'
							and (ISNULL(AT1302.InventoryID, ''#'') IN (' + @ConditionIV + ') Or ' + @IsUsedConditionIV + ') 
						ORDER BY '+@OrderBy+'
						OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
						FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL)
--PRINT(@sSQL)



