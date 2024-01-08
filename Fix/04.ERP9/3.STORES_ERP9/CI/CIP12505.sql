IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP12505]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP12505]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form CIP12505 IN Danh muc bảng giá bán chi tiết
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 08/04/2016
-- <Example>
----    EXEC CIP12505 'KC','BGLOTTEF6','ASOFTADMIN'


CREATE PROCEDURE CIP12505 ( 
        @DivisionID VARCHAR(50),
        @ID nvarchar(50),
		@UserID VARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL02 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX)
		
		SET @sWhere = ''
	
	--Check DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionID,'') != ''
		SET @sWhere = @sWhere + 'and (OT1302.DivisionID = '''+ @DivisionID+''')'
	IF Isnull(@ID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1302.ID,'''') IN ('''+@ID+''') '
	
	--Kiểm tra load mac84 định thì lấy tổng số trang, ngược lại thì không lấy tổng số trang (Cải tiến tốc độ )
	SET @sSQL = N'   
				DECLARE @OT1302 TABLE (
  				DivisionID NVARCHAR(50),
  				ID NVARCHAR(50),
  				Description NVARCHAR(MAx),
  				FromDate DATETIME,
  				ToDate DATETIME,
  				OID NVARCHAR(50),
  				OIDName NVARCHAR(250),
  				InventoryID NVARCHAR(50),
  				InventoryName NVARCHAR(250),
  				UnitID NVARCHAR(50),
  				UnitName NVARCHAR(250),
  				UnitPrice Decimal(28,8),
  				MinPrice Decimal(28,8),
  				MaxPrice Decimal(28,8),
  				DiscountPercent Decimal(28,8),
  				DiscountAmount Decimal(28,8),
  				DiscountPriceA Decimal(28,8),
				InventoryTypeID NVARCHAR(MAX),
				InventoryTypeName NVARCHAR(MAX),
				CurrencyID NVARCHAR(MAX),
				CurrencyName NVARCHAR(MAX),
				VATPercent Decimal(28,8),
				VATAmount Decimal(28,8),
				IsTaxIncluded INT,
				TotalAmount Decimal(28,8),
				Notes NVARCHAR(MAX)
			  )
			 INSERT INTO @OT1302
			 (
 				DivisionID, ID, Description, FromDate, ToDate, 
 				OID, OIDName, InventoryID, InventoryName, UnitID, UnitName, UnitPrice,
 				MinPrice, MaxPrice, DiscountPercent, DiscountAmount, DiscountPriceA,InventoryTypeID,InventoryTypeName,
				CurrencyID,CurrencyName,VATPercent,VATAmount,IsTaxIncluded,TotalAmount, Notes
			 )
			 SELECT OT1302.DivisionID, OT1302.ID, OT1301.Description, OT1301.FromDate,
					OT1301.ToDate, OT1301.OID,
					case when OT1301.OID = ''%'' then N''Tất cả'' else AT1015.AnaName end as OIDName, OT1302.InventoryID,  AT1302.InventoryName,
					OT1302.UnitID, AT1304.UnitName, ISNULL(OT1302.UnitPrice,0), ISNULL(OT1302.MinPrice,0), ISNULL(OT1302.MaxPrice,0),
					ISNULL(OT1302.DiscountPercent,0), ISNULL(OT1302.DiscountAmount,0), (OT1302.UnitPrice -  OT1302.DiscountAmount) as DiscountPriceA,
					OT1301.InventoryTypeID,
					case when OT1301.InventoryTypeID = ''%'' then N''Tất cả'' else AT1301.InventoryTypeName end AS InventoryTypeName,OT1301.CurrencyID, AT1004.CurrencyName,
					OT1302.VATPercent, OT1302.VATAmount,OT1301.IsTaxIncluded,OT1302.TotalAmount,OT1302.Notes
			 FROM OT1302 WITH (NOLOCK)
			 Left Join OT1301 WITH (NOLOCK) on OT1302.ID= OT1301.ID
			 LEFT JOIN AT1015 WITH (NOLOCK) ON AT1015.AnaID = OT1301.OID 
			 Left Join AT1302 WITH (NOLOCK) ON AT1302.InventoryID = OT1302.InventoryID
			 Left Join AT1304 WITH (NOLOCK) ON AT1304.UnitID = OT1302.UnitID
			 Left Join AT1301 WITH (NOLOCK) ON AT1301.InventoryTypeID = OT1301.InventoryTypeID
			 LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = OT1301.CurrencyID
					'
  
    ---lấy kết quả
	SET @sSQL02 = N'
				 SELECT OT1302.DivisionID , 
				 OT1302.ID, OT1302.Description, OT1302.FromDate, OT1302.ToDate,
				 OT1302.OID, OT1302.OIDName, OT1302.InventoryID, OT1302.InventoryName,
				 OT1302.UnitID, OT1302.UnitName, OT1302.UnitPrice, OT1302.MinPrice, OT1302.MaxPrice,
				OT1302.DiscountPercent, OT1302.DiscountAmount, OT1302.DiscountPriceA,OT1302.InventoryTypeID,InventoryTypeName,
				OT1302.CurrencyID, OT1302.CurrencyName,OT1302.VATPercent,OT1302.VATAmount,IsTaxIncluded,TotalAmount,Notes
				 FROM @OT1302 OT1302
				 WHERE 1=1 '+@sWhere+'
				ORDER BY OT1302.InventoryID'
				
	EXEC (@sSQL +@sSQL02)
	print (@sSQL +@sSQL02)

		



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
