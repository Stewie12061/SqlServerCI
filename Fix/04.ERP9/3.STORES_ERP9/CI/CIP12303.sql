IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CIP12303') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CIP12303]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CIP12303 IN Danh muc định mức tồn kho hàng hóa
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 08/04/2016
-- <Example>
----    EXEC CIP12303 'KC','','','','','','', 'ASOFTADMIN'

CREATE PROCEDURE CIP12303 ( 
        @DivisionID VARCHAR(50),  
		@DivisionIDList NVARCHAR(2000),  
        @InventoryID nvarchar(50),
        @InventoryName nvarchar(100),
        @WareHouseID nvarchar(100),
        @NormID NVARCHAR(100),
        @Description NVARCHAR(100),
		@UserID  VARCHAR(50)
		
) 
AS 
BEGIN
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL02 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX)
		
		SET @sWhere = ''
	
	
	--Check DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + 'and (AT1314.DivisionID = '''+ @DivisionID+''' or AT1314.DivisionID = ''@@@'')'
	Else 
		SET @sWhere = @sWhere + 'and (AT1314.DivisionID IN ('''+@DivisionIDList+''') or AT1314.DivisionID = ''@@@'')'
	IF Isnull(@InventoryID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1314.InventoryID,'''') LIKE N''%'+@InventoryID+'%'' '
	IF isnull(@InventoryName,'') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(AT1314.InventoryName,'''') LIKE N''%'+@InventoryName+'%'' '
	IF isnull(@WareHouseID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1314.WareHouseName, '''') LIKE N''%'+@WareHouseID+'%'' '
	IF isnull(@NormID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1314.NormID,'''') LIKE N''%'+@NormID+'%'' '
	IF isnull(@Description, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1314.Description,'''') LIKE N''%'+@Description+'%'' '
	
	--Kiểm tra load mac84 định thì lấy tổng số trang, ngược lại thì không lấy tổng số trang (Cải tiến tốc độ )
	SET @sSQL = N'   
				Declare @AT1314 TABLE (
  				DivisionID NVARCHAR(50),
  				InventoryNormID NVARCHAR(50),
  				InventoryID NVARCHAR(50),
  				InventoryName NVARCHAR(250),
  				WareHouseID NVARCHAR(50),
  				NormID NVARCHAR(50),
  				Description NVARCHAR(50),
  				MinQuantity int,
  				MaxQuantity int,
  				ReOrderQuantity int,
  				WareHouseName NVARCHAR(50)
			  )
			 INSERT INTO @AT1314
			 (
 				DivisionID, InventoryNormID, InventoryID, InventoryName, WareHouseID, 
 				NormID, Description, MinQuantity, MaxQuantity, ReOrderQuantity,WareHouseName
			 )
			 SELECT AT14.DivisionID, AT14.InventoryNormID, AT14.InventoryID, (AT14.InventoryID+''_'' + A.InventoryName) as InventoryName,
					AT14.WareHouseID, AT14.NormID, C.Description as NormName, AT14.MinQuantity, AT14.MaxQuantity, AT14.ReOrderQuantity,
					(AT14.WareHouseID+''_'' + B.WareHouseName) as WareHouseName
			 FROM AT1314 AT14 WITH (NOLOCK)
			 LEFT JOIN AT1302 A WITH (NOLOCK) ON A.InventoryID = AT14.InventoryID 
			 LEFT JOIN AT1303 B WITH (NOLOCK) ON B.WareHouseID = AT14.WareHouseID
			 LEFT JOIN AT1313 C WITH (NOLOCK) ON C.NormID = AT14.NormID
					'
    ---lấy kết quả
	SET @sSQL02 = N'
				 SELECT 
				 Case when AT1314.DivisionID =''@@@'' then '''' else AT1314.DivisionID end as DivisionID, 
				 AT1314.InventoryNormID, AT1314.InventoryID, AT1314.InventoryName, AT1314.WareHouseID,
				 AT1314.NormID, AT1314.Description as NormName, AT1314.MinQuantity, AT1314.MaxQuantity,
				 AT1314.ReOrderQuantity, AT1314.WareHouseName
				 FROM @AT1314 AT1314
				 WHERE 1=1 '+@sWhere+'
				ORDER BY AT1314.DivisionID, AT1314.InventoryID'

	EXEC (@sSQL+ @sSQL02)
END 