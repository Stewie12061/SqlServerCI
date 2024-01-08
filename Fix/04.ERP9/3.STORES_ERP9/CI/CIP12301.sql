IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CIP12301') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CIP12301]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CIP12301 Danh muc định mức tồn kho hàng hóa
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 08/04/2016
----Modified by: Hoài Bảo, Date: 02/03/2022 - Bổ sung điều kiện search Loại định mức (NormName)
-- <Example>
----    EXEC CIP12301 'AS','','','','','','','', 'ASOFTADMIN',1,10

CREATE PROCEDURE CIP12301 ( 
        @DivisionID VARCHAR(50),  
		@DivisionIDList NVARCHAR(2000),  
        @InventoryID nvarchar(50),
        @InventoryName nvarchar(250),
        @WareHouseID nvarchar(100),
        @NormID NVARCHAR(100),
		@NormName NVARCHAR(250),
        @Description NVARCHAR(MAX),
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL01 NVARCHAR (MAX),
		@sSQL02 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
		
		SET @sWhere = ''
	SET @OrderBy = 'AT1314.DivisionID, AT1314.InventoryID'
	
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
	IF isnull(@NormName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1314.NormName,'''') LIKE N''%'+@NormName+'%'' '
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
				NormName NVARCHAR(250),
  				Description NVARCHAR(50),
  				MinQuantity Decimal(20,8),
  				MaxQuantity Decimal(20,8),
  				ReOrderQuantity Decimal(20,8),
  				WareHouseName NVARCHAR(50),
				APK uniqueidentifier
			  )
			 INSERT INTO @AT1314
			 (
 				DivisionID, InventoryNormID, InventoryID, InventoryName, WareHouseID, 
 				NormID, Description, MinQuantity, MaxQuantity, ReOrderQuantity,WareHouseName, NormName, APK
			 )
			 SELECT AT14.DivisionID, AT14.InventoryNormID, AT14.InventoryID, (AT14.InventoryID+''_'' + A.InventoryName) as InventoryName,
					AT14.WareHouseID, AT14.NormID, C.Description, AT14.MinQuantity, AT14.MaxQuantity, AT14.ReOrderQuantity,
					(AT14.WareHouseID+''_'' + B.WareHouseName) as WareHouseName, C.[Description] AS NormName, AT14.APK
			 FROM AT1314 AT14 WITH (NOLOCK)
			 LEFT JOIN AT1302 A WITH (NOLOCK) ON A.InventoryID = AT14.InventoryID 
			 LEFT JOIN AT1303 B WITH (NOLOCK) ON B.WareHouseID = AT14.WareHouseID
			 LEFT JOIN AT1313 C WITH (NOLOCK) ON C.NormID = AT14.NormID
					'
    set @sSQL01='
						Declare @CountTotal NVARCHAR(Max)
						DECLARE @CountEXEC table (CountRow NVARCHAR(Max))
						IF '+Cast(@PageNumber as varchar(2)) + ' = 1
						Begin
							Insert into @CountEXEC (CountRow)
							Select Count(AT1314.InventoryNormID) From @AT1314 AT1314 WHERE 1=1 '+@sWhere + '
						End
    '
    ---lấy kết quả
	SET @sSQL02 = N'
				 SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, (Select CountRow from @CountEXEC) AS TotalRow	,
				 AT1314.DivisionID, 
				 AT1314.InventoryNormID, AT1314.InventoryID, AT1314.InventoryName, AT1314.WareHouseID,
				 AT1314.NormID, AT1314.Description, AT1314.MinQuantity, AT1314.MaxQuantity,
				 AT1314.ReOrderQuantity, AT1314.WareHouseName, AT1314.APK
				 FROM @AT1314  as AT1314
				 WHERE 1=1 '+@sWhere+'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	EXEC (@sSQL+ @sSQL01+@sSQL02)