IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0134]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0134]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load dropdown chọn quy cách cho từng mặt hàng 
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by:Thanh Sơn on: 19/04/2015
---- Modified on 26/10/2015 by Tiểu Mai: Bổ sung tham số @UnitID
---- Modified on 05/05/2017 by Thị Phượng: Bổ sung Điều kiện bản giá để tránh load trùng dữ liệu của nhiều bảng giá
---- Modified by Bảo Thy on 22/05/2017: Sửa danh mục dùng chung
---- Modified by Phương Thảo on 10/09/2017: Đổ nguồn quy cách cho Đông Dương
---- Modified by Bảo Thy on 13/03/2018: Sửa danh mục dùng chung
-- <Example>
/*
	AP0134 'AS','','BUDDY_1.20', 'KHK1', 'NBNoDiscount','S1'
*/
CREATE PROCEDURE AP0134
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@InventoryID VARCHAR(50),
	@ObjectID VARCHAR(50),
	@PriceID VARCHAR(50),
	@StandardTypeID VARCHAR(50),
	@UnitID VARCHAR(50)
)
AS
DECLARE @sSQL NVARCHAR(MAX),		
		@CustomerIndex int


SELECT @sSQL = N''

SELECT TOP 1 @CustomerIndex = CustomerName From CustomerIndex


IF (@PriceID = NULL OR @PriceID = '' )
BEGIN
	SET @sSQL = '	
	SELECT A23.StandardID, A28.StandardName, A28.StandardTypeID,
		0 as UnitPrice
	FROM AT1323 A23
	LEFT JOIN AT0128 A28 ON A28.StandardID = A23.StandardID AND A28.StandardTypeID =  A23.StandardTypeID
	LEFT JOIN AT0005 A05 ON A28.DivisionID IN (A05.DivisionID,''@@@'') AND A05.TypeID = A28.StandardTypeID
	WHERE A23.DivisionID IN ('''+@DivisionID+''',''@@@'')
	AND A23.InventoryID = '''+@InventoryID+'''
	AND A23.IsUsed = 1
	AND A28.StandardTypeID = '''+@StandardTypeID+'''
	ORDER BY A28.StandardTypeID, A23.StandardID '

END
ELSE
	IF(@CustomerIndex = 73)
	BEGIN

		SET @sSQL = '	
		SELECT '+@StandardTypeID+'ID AS StandardID, AT0128.StandardName AS StandardName, '''+@StandardTypeID+''' AS StandardTypeID, UnitPrice
		FROM OT1302
		INNER JOIN AT0128 ON OT1302.'+@StandardTypeID+'ID = AT0128.StandardID AND AT0128.StandardTypeID = '''+@StandardTypeID+'''
		WHERE OT1302.DivisionID = '''+@DivisionID+'''
		AND OT1302.InventoryID = '''+@InventoryID+'''				
		AND OT1302.ID = '''+@PriceID+'''	
		'	

	END
	ELSE
	BEGIN
		SET @sSQL = '	SELECT A23.StandardID, A28.StandardName, A28.StandardTypeID,
			CASE WHEN IsExtraFee = 1 THEN A00.UnitPrice ELSE A35.UnitPrice END UnitPrice
		FROM AT1323 A23
		LEFT JOIN AT0135 A35 ON A35.DivisionID = A23.DivisionID AND A35.InventoryID = A23.InventoryID AND A35.StandardID = A23.StandardID
		LEFT JOIN OT1300 A00 ON A00.DivisionID = A23.DivisionID AND A00.StandardID = A23.StandardID AND A00.PriceID = '''+@PriceID+'''
		LEFT JOIN AT0128 A28 ON A28.StandardID = A23.StandardID AND A28.StandardTypeID =  A23.StandardTypeID
		LEFT JOIN AT0005 A05 ON A28.DivisionID IN (A05.DivisionID,''@@@'') AND A05.TypeID = A28.StandardTypeID
		WHERE A23.DivisionID IN ('''+@DivisionID+''',''@@@'')
		AND A23.InventoryID = '''+@InventoryID+'''
		AND A23.IsUsed = 1
		AND A28.StandardTypeID = '''+@StandardTypeID+'''
		AND A35.UnitID = '''+@UnitID+'''
		AND A35.PriceID = '''+@PriceID+'''
		ORDER BY A28.StandardTypeID, A23.StandardID '
	END
	
--print @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

