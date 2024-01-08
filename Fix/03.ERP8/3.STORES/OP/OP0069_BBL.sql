IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0069_BBL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0069_BBL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Kiểm tra sửa /xóa xác nhận hoàn thành của BOURBON
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 09/08/2023 by Thành Sang
---- Modified by Thành Sang on 09/08/2023: [2023/08/IS/0087] - Bổ sung @SOrderID để check đơn hàng mua kế thừa hết chưa
-- <Example>
---- 
CREATE PROCEDURE OP0069_BBL
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@TranMonth AS TINYINT,
	@TranYear AS INT,
	@VoucherID AS NVARCHAR(50),
	@SOrderID AS NVARCHAR(50) = NULL,
	@Mode TINYINT	----0: Sửa
					----1: Xóa	
) 
AS 
DECLARE @Status AS tinyint, 
		@EngMessage as NVARCHAR(2000), 
		@VieMessage as NVARCHAR(2000),
		@CustomerIndex INT = -1,
		@IsExistsPONotInherit INT = -1  -- Nếu tồn tại đơn hàng mua chưa được kế thừa >
										-- @IsExistsPONotInherit = 1: Vẫn cho phép chỉnh sửa. 
										-- @IsExistsPONotInherit = 0: Show cảnh báo
PRINT 'OP0069_BBL'

SELECT 	@Status = 0, 
		@EngMessage = '',
		@VieMessage = ''

IF @Mode = 0
BEGIN 

	IF EXISTS (SELECT TOP 1 1 FROM OT3002 WITH (NOLOCK) WHERE POrderID = @VoucherID AND TransactionID IN (SELECT HT0410.InheritPTransactionID FROM HT0410 WITH (NOLOCK)))
		AND EXISTS (SELECT TOP 1 1 FROM OT3002 WITH (NOLOCK) WHERE POrderID = @VoucherID AND TransactionID NOT IN (SELECT HT0410.InheritPTransactionID FROM HT0410 WITH (NOLOCK)))
	BEGIN
      
		 SELECT	@Status = 3, 
				@VieMessage = N'OFML000276',
				@EngMessage = N'OFML000276'
                                                 
		GOTO LB_RESULT
	END
	IF NOT EXISTS (SELECT TOP 1 1 FROM OT3002 WITH (NOLOCK) WHERE POrderID = @VoucherID AND TransactionID NOT IN (SELECT HT0410.InheritPTransactionID FROM HT0410 WITH (NOLOCK)))
	BEGIN
      
		 SELECT	@Status = 1, 
				@VieMessage = N'OFML000267',
				@EngMessage = N'OFML000267'
                                                 
		GOTO LB_RESULT
	END

END
ELSE
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM OT3002 WITH (NOLOCK) WHERE POrderID = @VoucherID AND TransactionID IN (SELECT HT0410.InheritPTransactionID FROM HT0410 WITH (NOLOCK)))
	BEGIN
		 SELECT	@Status = 1, 
				@VieMessage = N'OFML000267',
				@EngMessage = N'OFML000267'
                                                 
		GOTO LB_RESULT
	END
END

---------------- Lấy dữ liệu kế thừa ----------------
CREATE TABLE #CheckDataInherit (
    InventoryID NVARCHAR(50),
    Notes01 NVARCHAR(250),
    Ana04ID NVARCHAR(50),
    Ana07ID NVARCHAR(50),
    Ana08ID NVARCHAR(50),
    Ana10ID NVARCHAR(50),
    IsSaleOrder INT --  = 1 > đơn hàng bán
);
INSERT INTO #CheckDataInherit (InventoryID, Notes01, Ana04ID, Ana07ID, Ana08ID, Ana10ID, IsSaleOrder)(
SELECT	OT2002.InventoryID, OT3001.VoucherNo AS Notes01,
		OT3002.Ana04ID, OT3002.Ana07ID, OT3002.Ana08ID, OT3002.Ana10ID,
		0 as IsSaleOrder 
FROM OT3002 OT3002 WITH (NOLOCK)
INNER JOIN OT3001 OT3001 WITH (NOLOCK) ON OT3001.DivisionID = OT3002.DivisionID AND OT3001.POrderID = OT3002.POrderID 
INNER JOIN OT2002 OT2002 WITH (NOLOCK) ON OT2002.DivisionID = OT3002.DivisionID AND OT2002.InventoryID = OT3002.Notes04 AND OT2002.Ana04ID = OT3002.Ana04ID
INNER JOIN OT2001 OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
LEFT JOIN AT1011 Ana04 WITH (NOLOCK) ON OT3002.Ana04ID = Ana04.AnaID AND Ana04.AnaTypeID = 'A04'
LEFT JOIN AT1011 Ana07 WITH (NOLOCK) ON OT3002.Ana07ID = Ana07.AnaID AND Ana07.AnaTypeID = 'A07'
LEFT JOIN AT1011 Ana08 WITH (NOLOCK) ON OT3002.Ana08ID = Ana08.AnaID AND Ana08.AnaTypeID = 'A08'
LEFT JOIN AT1011 Ana10 WITH (NOLOCK) ON OT3002.Ana10ID = Ana10.AnaID AND Ana10.AnaTypeID = 'A10'
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN ('' +@DivisionID+ '', '@@@') AND AT1202.ObjectID = OT3001.ObjectID
WHERE OT3002.DivisionID = '' + @DivisionID + ''
AND OT3001.KindVoucherID = 1
AND	OT2001.SOrderID = '' + @SOrderID + ''
AND OT3001.OrderStatus < 3

UNION
SELECT	
		OT3002.Notes04 as InventoryID, OT3001.VoucherNo AS Notes01,
		OT3002.Ana04ID, OT3002.Ana07ID, OT3002.Ana08ID, OT3002.Ana10ID,
	    0 as IsSaleOrder 
FROM OT3002 OT3002 WITH (NOLOCK)
INNER JOIN OT3001 OT3001 WITH (NOLOCK) ON OT3001.DivisionID = OT3002.DivisionID AND OT3001.POrderID = OT3002.POrderID 
LEFT JOIN AT1011 Ana04 WITH (NOLOCK) ON OT3002.Ana04ID = Ana04.AnaID AND Ana04.AnaTypeID = 'A04'
LEFT JOIN AT1011 Ana07 WITH (NOLOCK) ON OT3002.Ana07ID = Ana07.AnaID AND Ana07.AnaTypeID = 'A07'
LEFT JOIN AT1011 Ana08 WITH (NOLOCK) ON OT3002.Ana08ID = Ana08.AnaID AND Ana08.AnaTypeID = 'A08'
LEFT JOIN AT1011 Ana10 WITH (NOLOCK) ON OT3002.Ana10ID = Ana10.AnaID AND Ana10.AnaTypeID = 'A10'
WHERE OT3002.DivisionID =  '' + @DivisionID + ''
AND OT3001.KindVoucherID = 1
AND OT3002.Notes03 =  '' + @SOrderID + ''
AND OT3001.OrderStatus < 3
AND ISNULL(OT3002.Notes03, '') + ISNULL(OT3002.Notes04, '') + ISNULL(Ot3002.Ana04ID, '') NOT IN (
	SELECT
		ISNULL(OT2001.SOrderID, '') + ISNULL(OT2002.InventoryID, '') + ISNULL(OT2002.Ana04ID, '')
		FROM OT2002 OT2002 WITH (NOLOCK)
		INNER JOIN OT2001 OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID 
		WHERE OT2001.SOrderID = '' + @SOrderID + ''
		AND OT2001.DivisionID = '' + @DivisionID + ''
)

UNION
----------- Lay dong dịch vu ma khong co trong LDD
SELECT 	OT2002.InventoryID, '' as Notes01,
		OT2002.Ana04ID, OT2002.Ana07ID, OT2002.Ana08ID, OT2002.Ana10ID,
		1 as IsSaleOrder 
FROM OT2002 OT2002 WITH (NOLOCK)
INNER JOIN AT1302 AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN ('@@@', OT2002.DivisionID) AND AT1302.InventoryID = OT2002.InventoryID 
INNER JOIN OT2001 OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
LEFT JOIN AT1011 Ana04 WITH (NOLOCK) ON OT2002.Ana04ID = Ana04.AnaID AND Ana04.AnaTypeID = 'A04'
LEFT JOIN AT1011 Ana07 WITH (NOLOCK) ON OT2002.Ana07ID = Ana07.AnaID AND Ana07.AnaTypeID = 'A07'
LEFT JOIN AT1011 Ana08 WITH (NOLOCK) ON OT2002.Ana08ID = Ana08.AnaID AND Ana08.AnaTypeID = 'A08'
LEFT JOIN AT1011 Ana10 WITH (NOLOCK) ON OT2002.Ana10ID = Ana10.AnaID AND Ana10.AnaTypeID = 'A10'
WHERE OT2002.DivisionID =  '' + @DivisionID + ''
AND	OT2002.SOrderID =  '' + @SOrderID + '')

-- insert data tới #_TempIsExistsPONotInherit
SELECT IsSaleOrder
INTO #_TempIsExistsPONotInherit 
FROM #CheckDataInherit WITH (NOLOCK)
WHERE 
CONCAT(InventoryID, '|', Notes01, '|', Ana04ID, '|', Ana07ID, '|', Ana08ID, '|', Ana10ID, '|', IsSaleOrder) NOT IN (
SELECT CONCAT(_DataInherited.InventoryID, '|', _DataInherited.Notes01, '|', _DataInherited.Ana04ID, '|', _DataInherited.Ana07ID, '|', _DataInherited.Ana08ID, '|', _DataInherited.Ana10ID,
'|', _DataInherited.IsSaleOrder)
FROM OT3002 WITH (NOLOCK)															   										
LEFT JOIN AT1011 Ana04 WITH (NOLOCK) ON Ana04.DivisionID IN ('@@@', OT3002.DivisionID) AND OT3002.Ana04ID = Ana04.AnaID AND Ana04.AnaTypeID = 'A04'
LEFT JOIN AT1011 Ana07 WITH (NOLOCK) ON Ana07.DivisionID IN ('@@@', OT3002.DivisionID) AND OT3002.Ana07ID = Ana07.AnaID AND Ana07.AnaTypeID = 'A07'
LEFT JOIN AT1011 Ana08 WITH (NOLOCK) ON Ana08.DivisionID IN ('@@@', OT3002.DivisionID) AND OT3002.Ana08ID = Ana08.AnaID AND Ana08.AnaTypeID = 'A08'
LEFT JOIN AT1011 Ana10 WITH (NOLOCK) ON Ana10.DivisionID IN ('@@@', OT3002.DivisionID) AND OT3002.Ana10ID = Ana10.AnaID AND Ana10.AnaTypeID = 'A10'
INNER JOIN OT3001 WITH (NOLOCK) ON OT3001.POrderID = OT3002.POrderID AND OT3001.DivisionID = OT3002.DivisionID
LEFT JOIN #CheckDataInherit _DataInherited WITH (NOLOCK) ON _DataInherited.InventoryID = OT3002.InventoryID
		   AND ISNULL(_DataInherited.Notes01,'') = ISNULL(OT3002.Notes01,'')
		   AND ISNULL(_DataInherited.Ana04ID,'') = ISNULL(OT3002.Ana04ID,'') AND ISNULL(_DataInherited.Ana07ID,'') = ISNULL(OT3002.Ana07ID,'')
		   AND ISNULL(_DataInherited.Ana08ID,'') = ISNULL(OT3002.Ana08ID,'') AND ISNULL(_DataInherited.Ana10ID,'') = ISNULL(OT3002.Ana10ID,'')
WHERE OT3002.DivisionID = @DivisionID
AND OT3002.POrderID = @VoucherID ) 
AND #CheckDataInherit.IsSaleOrder = 0

SET @IsExistsPONotInherit = ISNULL((SELECT TOP 1 1 IsSaleOrder FROM #_TempIsExistsPONotInherit), 0)

PRINT @IsExistsPONotInherit

DROP TABLE #CheckDataInherit
---------------- * ----------------


--- Đã quyết toán thì không cho sửa/xóa 
IF NOT EXISTS (SELECT TOP 1 1 FROM OT3002 WITH (NOLOCK) WHERE OT3002.POrderID = @VoucherID AND ISNULL(OT3002.Finish, 0) = 0) OR @IsExistsPONotInherit = 0
BEGIN
	
	 SELECT	@Status = 1, 
			@VieMessage = N'OFML000303',
			@EngMessage = N'OFML000303'
                                             
	GOTO LB_RESULT
END


LB_RESULT:
SELECT @Status AS Status, @EngMessage AS EngMessage, @VieMessage as VieMessage


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
