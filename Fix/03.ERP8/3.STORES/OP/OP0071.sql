IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0071]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0071]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In Lệnh điều động mẫu cũ, lấy số lượng xác nhận hoàn thành
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 29/09/2014 by Mai Trí Thiện
---- Modify on 26/04/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Đình Định on 10/04/2023: BOURBON - Hiển thị tên khách hàng, vị trí làm hàng, tên mặt hàng khi in lệnh điều động.
-- <Example>
/*
	EXEC OP0071 'BBL', 'ADMIN', 'LD/01/15/0004'
*/

CREATE PROCEDURE OP0071
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@VoucherID AS NVARCHAR(50)
)
AS 

SELECT 
	o2.TransactionID,	
	o1.ObjectID AS AObjectID, -- Thầu phụ
	a1.ObjectName AS AObjectName, -- Tên thầu phụ
	o1.OrderDate, o1.POrderID, o1.ContractDate, o1.Notes, 
	o2.Notes05, o2.Notes06, o2.Notes07, o2.Notes08, o2.Notes09,
	o2.Notes03 AS SOrderID, o21.ObjectID, a.ObjectName, o2.InventoryID, a2.InventoryName,		
	o2.Ana04ID, Ana04.AnaName AS Ana04Name, 
	o2.Ana05ID, Ana05.AnaName AS Ana05Name, o2.Ana07ID, ana07.Ananame AS Ana07Name, 
	o2.Ana10ID, Ana10.AnaName,
	o2.UnitID, a4.UnitName, ISNULL(SUM(x1.OrderQuantity), 0) OrderQuantity, a.TradeName
FROM OT3001 o1 WITH(NOLOCK) 
	LEFT JOIN OT3002 o2	    WITH(NOLOCK) ON o2.POrderID = o1.POrderID
	LEFT JOIN OT2001 o21	WITH(NOLOCK) ON o21.SOrderID = o2.Notes03
	LEFT JOIN AT1202 a		WITH(NOLOCK) ON a.DivisionID IN (@DivisionID, '@@@') AND a.ObjectID = o21.ObjectID
	LEFT JOIN AT1202 a1		WITH(NOLOCK) ON a1.DivisionID IN (@DivisionID, '@@@') AND a1.ObjectID = o1.ObjectID
	LEFT JOIN AT1011 Ana01	WITH(NOLOCK) ON o2.Ana01ID = Ana01.AnaID AND Ana01.AnaTypeID = 'A01'
	LEFT JOIN AT1011 Ana02	WITH(NOLOCK) ON o2.Ana02ID = Ana02.AnaID AND Ana02.AnaTypeID = 'A02'
	LEFT JOIN AT1011 Ana03	WITH(NOLOCK) ON o2.Ana03ID = Ana03.AnaID AND Ana03.AnaTypeID = 'A03'
	LEFT JOIN AT1011 Ana04	WITH(NOLOCK) ON o2.Ana04ID = Ana04.AnaID AND Ana04.AnaTypeID = 'A04'
	LEFT JOIN AT1011 Ana05	WITH(NOLOCK) ON o2.Ana05ID = Ana05.AnaID AND Ana05.AnaTypeID = 'A05'
	LEFT JOIN AT1011 Ana06	WITH(NOLOCK) ON o2.Ana06ID = Ana06.AnaID AND Ana06.AnaTypeID = 'A06'
	LEFT JOIN AT1011 Ana07	WITH(NOLOCK) ON o2.Ana07ID = Ana07.AnaID AND Ana07.AnaTypeID = 'A07'
	LEFT JOIN AT1011 Ana08	WITH(NOLOCK) ON o2.Ana08ID = Ana08.AnaID AND Ana08.AnaTypeID = 'A08'
	LEFT JOIN AT1011 Ana09	WITH(NOLOCK) ON o2.Ana09ID = Ana09.AnaID AND Ana09.AnaTypeID = 'A09'
	LEFT JOIN AT1011 Ana10	WITH(NOLOCK) ON o2.Ana10ID = Ana10.AnaID AND Ana10.AnaTypeID = 'A10'
	LEFT JOIN AT1302 a2		WITH(NOLOCK) ON a2.DivisionID IN ('@@@', o2.DivisionID) AND a2.InventoryID= o2.InventoryID
	LEFT JOIN AT1302 a3		WITH(NOLOCK) ON a3.DivisionID IN ('@@@', o2.DivisionID) AND a3.InventoryID= o2.Notes04
	LEFT JOIN AT1304 a4		WITH(NOLOCK) ON a4.UnitID = o2.UnitID
	LEFT JOIN (
			SELECT 
				o2.Notes03,	o21.ObjectID, o2.InventoryID,		
				o2.Notes04,	o2.Ana04ID,
				o2.Ana05ID, o2.Ana07ID,
				o2.Ana08ID,	o2.Ana10ID,
				o2.UnitID,
				SUM(o3.OrderQuantity) OrderQuantity
			FROM OT3001 o1 WITH(NOLOCK)   
				LEFT JOIN OT3002 o2	 WITH(NOLOCK) ON o2.POrderID = o1.POrderID
				LEFT JOIN OT2001 o21 WITH(NOLOCK) ON o21.SOrderID = o2.Notes03
				LEFT JOIN AT1202 a	 WITH(NOLOCK) ON a.DivisionID IN (@DivisionID, '@@@') AND a.ObjectID = o21.ObjectID
				LEFT JOIN (
					SELECT	o31.SOrderID, o32.Notes01, o32.Notes04, o32.InventoryID, 
							o32.Ana04ID, o32.Ana07ID, o32.Ana08ID, o32.Ana10ID, o31.POrderID,
							o32.OrderQuantity, o32.PurchasePrice, o32.ReceiveDate
					FROM OT3001 o31 WITH(NOLOCK)
						LEFT JOIN OT3002 o32 WITH(NOLOCK) ON o32.POrderID = o31.POrderID
					WHERE ISNULL(o31.KindVoucherID, 0) = 2
						AND ISNULL(o32.Notes01, '') <> ''
				) o3
				ON o3.Notes01		= o1.POrderID 
				AND o3.SOrderID		= o2.Notes03 
				AND o3.InventoryID	= o2.Notes04 
				AND o3.Notes04		= o2.InventoryID 
				AND o3.Ana04ID		= o2.Ana04ID 
				AND o3.Ana10ID		= o2.Ana10ID
			WHERE ISNULL(o1.KindVoucherID, 0) = 1
				AND o1.POrderID = @VoucherID
				AND o3.ReceiveDate IS NOT NULL
				AND o1.DivisionID = @DivisionID
			GROUP BY 
				o2.Notes03,	o21.ObjectID, a.ObjectName, o2.InventoryID,		
				o2.Notes04,	o2.Ana04ID,
				o2.Ana05ID, o2.Ana07ID,
				o2.Ana08ID,	o2.Ana10ID,
				o2.UnitID
	) x1 ON x1.UnitID = o2.UnitID	AND x1.InventoryID = o2.InventoryID 
	AND x1.Notes03 = o2.Notes03 	AND x1.ObjectID = o21.ObjectID	
	AND x1.Ana04ID = o2.Ana04ID		AND x1.Ana10ID = o2.Ana10ID 
	AND x1.Ana08ID = o2.Ana08ID		AND x1.Notes04 = o2.Notes04
WHERE ISNULL(o1.KindVoucherID, 0) = 1
	AND o1.POrderID = @VoucherID
	AND o1.DivisionID = @DivisionID
GROUP BY 
	o2.TransactionID,
	o1.ObjectID, -- Thầu phụ
	a1.ObjectName, -- Tên thầu phụ
	o1.OrderDate, o1.POrderID, o1.ContractDate, o1.Notes, 
	o2.Notes05, o2.Notes06, o2.Notes07, o2.Notes08, o2.Notes09,
	o2.Notes03, o21.ObjectID, a.ObjectName, o2.InventoryID, a2.InventoryName,		
	o2.Ana04ID, Ana04.AnaName, 
	o2.Ana05ID, Ana05.AnaName, o2.Ana07ID, ana07.ananame, 
	o2.Ana10ID, Ana10.AnaName,
	o2.UnitID, a4.UnitName, a.TradeName


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO