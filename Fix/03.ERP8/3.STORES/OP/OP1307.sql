IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP1307]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP1307]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Create by Tiểu Mai on 13/07/2016
---- Purpose: Load bảng giá mua cho màn hình kế hoạch mua hàng tổng hợp (ANGEL)
---- Modified by Tiểu Mai on 26/07/2016: Bổ sung lấy đơn giá theo số lượng mua hàng
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- EXEC OP1307 N'ANG', N'CTN.3.2019', '2016-07-13 00:00:00', N'VLTHUW01'

CREATE PROCEDURE OP1307
( 
	@DivisionID NVARCHAR(50),
	@ObjectID NVARCHAR(50),
	@VoucherDate DATETIME,
	@InventoryID NVARCHAR(50),
	@Quantity DECIMAL(28,8)
)
AS 
DECLARE @IsPriceControl AS TINYINT,
		@OTypeID AS NVARCHAR(50)
		
SELECT	@OTypeID = OPriceTypeID + 'ID',
		@IsPriceControl = IsPriceControl
FROM	OT0000 WITH (NOLOCK)
WHERE	DivisionID = @DivisionID

IF @IsPriceControl = 1
BEGIN
	SELECT		OT1301.ID AS PriceListID, OT1301.Description AS PriceListName, 
				ISNULL(OT1312.UnitPrice, OT1302.UnitPrice) AS UnitPrice
	FROM		OT1301 WITH (NOLOCK)
	LEFT JOIN OT1302 WITH (NOLOCK) ON OT1302.DivisionID = OT1301.DivisionID AND OT1302.ID = OT1301.ID
	LEFT JOIN OT1312 WITH (NOLOCK) ON OT1312.ID = OT1302.DetailID AND OT1312.DivisionID = OT1302.DivisionID AND OT1312.PriceID = OT1302.ID 
										AND (Isnull(@Quantity,0) BETWEEN OT1312.Qtyfrom AND OT1312.QtyTo OR (Isnull(@Quantity,0) >= OT1312.Qtyfrom AND OT1312.QtyTo = -1))			
	WHERE CONVERT(datetime,@VoucherDate, 101) BETWEEN CONVERT(datetime,FromDate,101) AND CONVERT(datetime,ISNULL (ToDate, '9999-01-01'),101)
	AND OT1301.DivisionID = @DivisionID AND [Disabled] = 0
	AND (SELECT	TOP 1
				CASE	WHEN @OTypeID = 'O01ID' THEN ISNULL(O01ID, '')
						WHEN @OTypeID = 'O02ID' THEN ISNULL(O02ID, '')
						WHEN @OTypeID = 'O03ID' THEN ISNULL(O03ID, '')
						WHEN @OTypeID = 'O04ID' THEN ISNULL(O04ID, '')
				ELSE ISNULL(O05ID, '%')												 
				END 
		        FROM AT1202 WITH (NOLOCK)
		        WHERE DivisionID IN (@DivisionID, '@@@') AND ObjectID = @ObjectID
		) LIKE OID	
	AND ISNULL(TypeID , 0 ) = 1	
	AND OT1302.InventoryID LIKE @InventoryID				
	ORDER BY	OT1301.ID			
END
ELSE
	SELECT '' AS PriceListID, '' AS PriceListName, 0 AS UnitPrice


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
