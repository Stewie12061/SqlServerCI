IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CIP12504') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CIP12504]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CIP12504 In Danh muc bảng giá bán
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 08/04/2016
-- <Example>
----    EXEC CIP12504 'KC','','','','2014-12-27 00:00:00','','', '','','','ASOFTADMIN'


CREATE PROCEDURE CIP12504 ( 
        @DivisionID VARCHAR(50),  
		@DivisionIDList NVARCHAR(2000),  
        @ID nvarchar(50),
        @Description nvarchar(100),
        @FromDate nvarchar(100),
        @ToDate NVARCHAR(100),
        @OID NVARCHAR(100),
		@InventoryTypeID  VARCHAR(50),
		@CurrencyID  VARCHAR(50),
		@DisabledName  VARCHAR(50),
		@UserID VARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL02 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX)
		SET @sWhere = ''
	
	--Check DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + 'and (OT1301.DivisionID = '''+ @DivisionID+''' or OT1301.DivisionID = ''@@@'')'
	Else 
		SET @sWhere = @sWhere + 'and (OT1301.DivisionID IN ('''+@DivisionIDList+''') or OT1301.DivisionID = ''@@@'')'
	IF Isnull(@ID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1301.ID,'''') LIKE N''%'+@ID+'%'' '
	IF isnull(@FromDate,'') != ''
		SET @sWhere = @sWhere + ' AND OT1301.FromDate = '''+CONVERT(NVARCHAR(20),@FromDate,101)+''''
	IF isnull(@ToDate, '') != ''
		SET @sWhere = @sWhere + ' AND OT1301.ToDate ='''+CONVERT(NVARCHAR(20),@ToDate,101)+''''
	IF isnull(@OID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1301.OID,'''') LIKE N''%'+@OID+'%'' '
	IF isnull(@Description, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1301.Description,'''') LIKE N''%'+@Description+'%'' '
	IF isnull(@InventoryTypeID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1301.InventoryTypeID,'''') LIKE N''%'+@InventoryTypeID+'%'' '
	IF isnull(@CurrencyID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1301.CurrencyID,0) like N''%'+@CurrencyID+'%'' '
	IF Isnull(@DisabledName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1301.Disabled,0) ='+@DisabledName
	
	--Kiểm tra load mac84 định thì lấy tổng số trang, ngược lại thì không lấy tổng số trang (Cải tiến tốc độ )
	SET @sSQL = N'   
				Declare @OT1301 TABLE (
  				DivisionID NVARCHAR(50),
  				ID NVARCHAR(50),
  				Description NVARCHAR(250),
  				FromDate DATETIME,
  				ToDate DATETIME,
  				OID NVARCHAR(50),
  				OIDName NVARCHAR(250),
  				InventoryTypeID NVARCHAR(50),
  				InventoryTypeName NVARCHAR(250),
  				CurrencyID NVARCHAR(50),
  				IsConvertedPrice NVARCHAR(50),
  				Disabled NVARCHAR(50)
			  )
			 INSERT INTO @OT1301
			 (
 				DivisionID, ID, Description, FromDate, ToDate, 
 				OID, OIDName, InventoryTypeID, InventoryTypeName, CurrencyID, IsConvertedPrice,Disabled
			 )
			 SELECT AT13.DivisionID, AT13.ID, AT13.Description, AT13.FromDate,
					AT13.ToDate, AT13.OID, C.AnaName as OIDName, AT13.InventoryTypeID, (AT13.InventoryTypeID+''_'' + B.InventoryTypeName) as InventoryTypeName,
					AT13.CurrencyID, AT13.IsConvertedPrice, AT13.Disabled
			 FROM OT1301 AT13 WITH (NOLOCK)
			 LEFT JOIN AT1015 C WITH (NOLOCK) ON C.AnaID = AT13.OID 
			 LEFT JOIN AT1301 B WITH (NOLOCK) ON B.InventoryTypeID = AT13.InventoryTypeID
					'

    ---lấy kết quả
	SET @sSQL02 = N'
				 SELECT 
				 OT1301.DivisionID , 
				 OT1301.ID, OT1301.Description, OT1301.FromDate, OT1301.ToDate,
				 OT1301.OID, OT1301.OIDName, OT1301.InventoryTypeID, OT1301.InventoryTypeName, OT1301.CurrencyID ,
				 OT1301.IsConvertedPrice, OT1301.Disabled
				 FROM @OT1301 OT1301
				 WHERE 1=1 '+@sWhere+'
				ORDER BY OT1301.DivisionID, OT1301.ID'
	EXEC (@sSQL+@sSQL02)
		