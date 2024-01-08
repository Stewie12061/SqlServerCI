IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0018_AG]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OP0018_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- In lich su bang gia mua theo so luong (CustomizeIndex = 57 --- ANGEL)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tiểu Mai on 17/07/2017
---- Modified by Phương Thảo on 28/12/2017: Chỉnh sửa lại cách lên dữ liệu báo cáo: Lấy theo đối tượng in (không dựa trên mã bảng giá in)
-- <Example>
---- 
CREATE PROCEDURE OP0018_AG
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@ID AS NVARCHAR(50)
) 
AS 

DECLARE @InheritID AS NVARCHAR(50), @PrevInheritID AS NVARCHAR(50), @sSQL NVARCHAR(MAX) = '', @sSQL1 NVARCHAR(MAX) = '', @ObjectID NVarchar(50) = ''

CREATE TABLE #TAM
	(
		Price_ID NVARCHAR(50),
		OID NVARCHAR(50),
		OName NVARCHAR(250),
		InventoryName NVARCHAR(MAX),
		InventoryID NVARCHAR(50),
		UnitID NVARCHAR(50),
		UnitPrice DECIMAL(28,8),
		FromDate DATETIME,
		ToDate DATETIME,
		Qtyfrom DECIMAL(28,8),
		QtyTo DECIMAL(28,8)
	)

SELECT @ObjectID = OID
FROM OT1301
WHERE ID = @ID


SELECT TOP 1 @InheritID = T1.ID
FROM OT1301 T1
WHERE OID = @ObjectID AND NOT EXISTS (SELECT TOP 1 1 FROM OT1301 T2 WHERE T1.ID = T2.InheritID)

WHILE (Isnull(@InheritID,'') <> '')
BEGIN

	SELECT Distinct OT1312.InventoryID
	INTO #OP0018_AG_1
	FROM	OT1301 WITH (NOLOCK) 
	LEFT JOIN OT1302 WITH (NOLOCK) ON OT1302.ID = OT1301.ID AND OT1302.DivisionID = OT1301.DivisionID
	LEFT JOIN OT1312 WITH (NOLOCK) ON OT1312.DivisionID = OT1302.DivisionID AND OT1302.ID = OT1312.PriceID AND OT1302.DetailID = OT1312.ID AND OT1312.InventoryID = OT1302.InventoryID	
	where  ISNULL(OT1302.InventoryID,'') <> ''
			AND OT1301.ID = @InheritID 
			AND OT1301.DivisionID = @DivisionID		
			AND NOT EXISTS (SELECT TOP 1 1 FROM #TAM WHERE OT1302.InventoryID = #TAM.InventoryID AND OT1302.UnitID = #TAM.UnitID AND OT1312.Qtyfrom = #TAM.Qtyfrom 
						AND OT1312.QtyTo= #TAM.QtyTo AND OT1312.UnitPrice = #TAM.UnitPrice )
			--AND OT1302.InventoryID = 'VLNEPVCS01'
	--select '#OP0018_AG_1', @InheritID, * from #OP0018_AG_1

	INSERT INTO #TAM
	SELECT	OT1301.ID, OT1301.OID, AT1015.AnaName, AT1302.InventoryName, OT1302.InventoryID, OT1302.UnitID,
			OT1312.UnitPrice, 
			OT1301.FromDate, OT1301.ToDate,
			OT1312.Qtyfrom, OT1312.QtyTo		
	FROM	OT1301 WITH (NOLOCK) 
	LEFT JOIN OT1302 WITH (NOLOCK) ON OT1302.ID = OT1301.ID AND OT1302.DivisionID = OT1301.DivisionID
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = OT1302.InventoryID AND AT1302.DivisionID = OT1302.DivisionID
	LEFT JOIN OT1312 WITH (NOLOCK) ON OT1312.DivisionID = OT1302.DivisionID AND OT1302.ID = OT1312.PriceID AND OT1302.DetailID = OT1312.ID AND OT1312.InventoryID = OT1302.InventoryID
	LEFT JOIN AT1015 WITH (NOLOCK) ON AT1015.DivisionID = OT1301.DivisionID AND AT1015.AnaID = OT1301.OID 
										AND AT1015.AnaTypeID = ( SELECT TOP 1 OPriceTypeID
																	FROM OT0000 WITH (NOLOCK)
																	WHERE DivisionID = @DivisionID
																	)
	WHERE	ISNULL(OT1302.InventoryID,'') <> ''
			AND OT1301.ID = @InheritID 
			AND OT1301.DivisionID = @DivisionID	
			AND EXISTS (SELECT TOP 1 1 FROM #OP0018_AG_1 WHERE OT1312.InventoryID = #OP0018_AG_1.InventoryID)	
			


	UPDATE	#TAM 
	SET		#TAM.FromDate = CASE WHEN #TAM.FromDate < T.FromDate THEN #TAM.FromDate  ELSE T.FromDate END,
			#TAM.ToDate = CASE WHEN #TAM.ToDate > T.ToDate THEN  #TAM.ToDate ELSE T.ToDate END,
			Price_ID = @InheritID
	FROM #TAM 
	INNER JOIN 
	(SELECT OT1312.InventoryID, OT1312.Qtyfrom, OT1312.QtyTo, Min(FromDate) AS FromDate, Max(ToDate) AS ToDate
	FROM OT1301
	LEFT JOIN OT1302 WITH (NOLOCK) ON OT1302.ID = OT1301.ID AND OT1302.DivisionID = OT1301.DivisionID
	LEFT JOIN OT1312 WITH (NOLOCK) ON OT1312.DivisionID = OT1302.DivisionID AND OT1302.ID = OT1312.PriceID AND OT1302.DetailID = OT1312.ID AND OT1312.InventoryID = OT1302.InventoryID
	WHERE	OT1301.ID = @InheritID 
			AND OT1301.DivisionID = @DivisionID	 
	GROUP BY OT1312.InventoryID, OT1312.Qtyfrom, OT1312.QtyTo				
			) T ON #TAM.InventoryID = T.InventoryID AND #TAM.Qtyfrom = T.Qtyfrom AND #TAM.QtyTo = T.QtyTo
	WHERE #TAM.Price_ID = @PrevInheritID  AND 
	NOT EXISTS (SELECT TOP 1 1 FROM #OP0018_AG_1 WHERE #TAM.InventoryID = #OP0018_AG_1.InventoryID)	
	
	--select '#TAM', @InheritID InheritID, @PrevInheritID PrevInheritID, * from #TAM

	SET @PrevInheritID = @InheritID

	SET @InheritID = (SELECT TOP 1 InheritID FROM OT1301 WITH (NOLOCK) WHERE OT1301.ID = @InheritID 
					AND DivisionID = @DivisionID)
	DROP TABLE #OP0018_AG_1
END
	
--select * from #TAM
SELECT Price_ID, OID, OName, InventoryName, InventoryID, UnitID,
		UnitPrice, 
		--MIN(FromDate) AS FromDate, MAX(ToDate) AS ToDate,	
		FromDate, ToDate,
		CASE WHEN  QtyTo >= 0 THEN N'Từ ' + PARSENAME(convert(varchar,convert(money,Qtyfrom),1),2) + N' Đến ' + PARSENAME(convert(varchar,convert(money,QtyTo),1),2) 
			ELSE N'Trên (>=) ' + PARSENAME(convert(varchar,convert(money,Qtyfrom),1),2) END AS Qty ,
		convert(varchar(50),Qtyfrom)+convert(varchar(50),QtyTo) as ID
FROM #TAM
WHERE UnitPrice IS NOT NULL
--GROUP BY OID, OName, InventoryName, InventoryID, UnitID, UnitPrice, Qtyfrom, QtyTo, FromDate, ToDate
ORDER BY InventoryID, Qtyfrom, FromDate




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

