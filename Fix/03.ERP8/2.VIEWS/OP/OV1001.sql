/****** Object:  View [dbo].[OV1001]    Script Date: 12/16/2010 14:42:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

---Create dby : Vo Thanh Huong, date: 01/09/2004 , view chet 
---Purpose: tao du lieu ngam tinh trang don hang
-- Modified by Đức Thông	22/10/2020	Bổ sung các trạng thái cho báo cáo đơn hàng trên app (Plugins SAVI)
-- Modified by Đức Thông	23/10/2020	Bổ sung các trạng thái kế thừa từ app qua OP cho báo cáo đơn hàng trên app (Plugins SAVI)
ALTER VIEW [dbo].[OV1001]
AS      

      SELECT 0 AS OrderStatus, N'OFML000171' AS Description, N'OFML000171' AS EDescription, 'SO' as TypeID, DivisionID from AT1101 
UNION SELECT 1 AS OrderStatus, N'OFML000172' AS Description, N'OFML000172' AS EDescription, 'SO' as TypeID, DivisionID from AT1101 
UNION SELECT 2 AS OrderStatus, N'OFML000173' AS Description, N'OFML000173' AS EDescription, 'SO' as TypeID, DivisionID from AT1101 
UNION SELECT 3 AS OrderStatus, N'OFML000174' AS Description, N'OFML000174' AS EDescription, 'SO' as TypeID, DivisionID from AT1101 
UNION SELECT 4 AS OrderStatus, N'OFML000175' AS Description, N'OFML000175' AS EDescription, 'SO' as TypeID, DivisionID from AT1101 
UNION SELECT 5 AS OrderStatus, N'OFML000176' AS Description, N'OFML000176' AS EDescription, 'SO' as TypeID, DivisionID from AT1101 
UNION SELECT 9 AS OrderStatus, N'OFML000177' AS Description, N'OFML000177' AS EDescription, 'SO' as TypeID, DivisionID from AT1101 

UNION SELECT 0 AS OrderStatus, N'OFML000298' AS Description, N'OFML000298' AS EDescription, 'SOAPP' as TypeID, DivisionID from AT1101 -- Chưa duyệt
UNION SELECT 1 AS OrderStatus, N'OFML000299' AS Description, N'OFML000299' AS EDescription, 'SOAPP' as TypeID, DivisionID from AT1101 -- Đã duyệt
UNION SELECT 2 AS OrderStatus, N'OFML000300' AS Description, N'OFML000300' AS EDescription, 'SOAPP' as TypeID, DivisionID from AT1101 -- Không duyệt

UNION SELECT 0 AS OrderStatus, N'OFML000301' AS Description, N'OFML000301' AS EDescription, 'SOAPP1' as TypeID, DivisionID from AT1101 -- Đã kế thừa
UNION SELECT 1 AS OrderStatus, N'OFML000302' AS Description, N'OFML000302' AS EDescription, 'SOAPP1' as TypeID, DivisionID from AT1101 -- Chưa kế thừa

UNION SELECT 0 AS OrderStatus, N'OFML000171' AS Description, N'OFML000171' AS EDescription, 'PO' as TypeID, DivisionID from AT1101 
UNION SELECT 1 AS OrderStatus, N'OFML000172' AS Description, N'OFML000172' AS EDescription, 'PO' as TypeID, DivisionID from AT1101 
UNION SELECT 2 AS OrderStatus, N'OFML000173' AS Description, N'OFML000173' AS EDescription, 'PO' as TypeID, DivisionID from AT1101 
UNION SELECT 3 AS OrderStatus, N'OFML000174' AS Description, N'OFML000174' AS EDescription, 'PO' as TypeID, DivisionID from AT1101 
UNION SELECT 4 AS OrderStatus, N'OFML000175' AS Description, N'OFML000175' AS EDescription, 'PO' as TypeID, DivisionID from AT1101 
UNION SELECT 9 AS OrderStatus, N'OFML000177' AS Description, N'OFML000177' AS EDescription, 'PO' as TypeID, DivisionID from AT1101 

UNION SELECT 0 AS OrderStatus, N'OFML000178' AS Description, N'OFML000178' AS EDescription, 'MO' as TypeID, DivisionID from AT1101 
UNION SELECT 1 AS OrderStatus, N'OFML000179' AS Description, N'OFML000179' AS EDescription, 'MO' as TypeID, DivisionID from AT1101 
UNION SELECT 2 AS OrderStatus, N'OFML000174' AS Description, N'OFML000174' AS EDescription, 'MO' as TypeID, DivisionID from AT1101 
UNION SELECT 4 AS OrderStatus, N'OFML000175' AS Description, N'OFML000175' AS EDescription, 'MO' as TypeID, DivisionID from AT1101 
UNION SELECT 9 AS OrderStatus, N'OFML000177' AS Description, N'OFML000177' AS EDescription, 'MO' as TypeID, DivisionID from AT1101 

UNION SELECT 0 AS OrderStatus, N'OFML000171' AS Description, N'OFML000171' AS EDescription, 'QO' as TypeID, DivisionID from AT1101 
UNION SELECT 1 AS OrderStatus, N'OFML000172' AS Description, N'OFML000172' AS EDescription, 'QO' as TypeID, DivisionID from AT1101 
UNION SELECT 2 AS OrderStatus, N'OFML000173' AS Description, N'OFML000173' AS EDescription, 'QO' as TypeID, DivisionID from AT1101 
UNION SELECT 3 AS OrderStatus, N'OFML000174' AS Description, N'OFML000174' AS EDescription, 'QO' as TypeID, DivisionID from AT1101 
UNION SELECT 4 AS OrderStatus, N'OFML000175' AS Description, N'OFML000175' AS EDescription, 'QO' as TypeID, DivisionID from AT1101 
UNION SELECT 9 AS OrderStatus, N'OFML000177' AS Description, N'OFML000177' AS EDescription, 'QO' as TypeID, DivisionID from AT1101 

UNION SELECT 0 AS OrderStatus, N'OFML000178' AS Description, N'OFML000178' AS EDescription, 'ES' as TypeID, DivisionID from AT1101 
UNION SELECT 1 AS OrderStatus, N'OFML000172' AS Description, N'OFML000172' AS EDescription, 'ES' as TypeID, DivisionID from AT1101 
UNION SELECT 2 AS OrderStatus, N'OFML000174' AS Description, N'OFML000174' AS EDescription, 'ES' as TypeID, DivisionID from AT1101 
UNION SELECT 9 AS OrderStatus, N'OFML000177' AS Description, N'OFML000177' AS EDescription, 'ES' as TypeID, DivisionID from AT1101 

UNION SELECT 1 AS OrderStatus, N'OFML000172' AS Description, N'OFML000172' AS EDescription, 'AO' as TypeID, DivisionID from AT1101 
UNION SELECT 2 AS OrderStatus, N'OFML000174' AS Description, N'OFML000174' AS EDescription, 'AO' as TypeID, DivisionID from AT1101 
UNION SELECT 9 AS OrderStatus, N'OFML000177' AS Description, N'OFML000177' AS EDescription, 'AO' as TypeID, DivisionID from AT1101 

UNION SELECT 0 AS OrderStatus, N'OFML000171' AS Description, N'OFML000171' AS EDescription, 'RO' as TypeID, DivisionID from AT1101 
UNION SELECT 1 AS OrderStatus, N'OFML000172' AS Description, N'OFML000172' AS EDescription, 'RO' as TypeID, DivisionID from AT1101 
UNION SELECT 2 AS OrderStatus, N'OFML000173' AS Description, N'OFML000173' AS EDescription, 'RO' as TypeID, DivisionID from AT1101 
UNION SELECT 3 AS OrderStatus, N'OFML000174' AS Description, N'OFML000174' AS EDescription, 'RO' as TypeID, DivisionID from AT1101 
UNION SELECT 4 AS OrderStatus, N'OFML000175' AS Description, N'OFML000175' AS EDescription, 'RO' as TypeID, DivisionID from AT1101 
UNION SELECT 9 AS OrderStatus, N'OFML000177' AS Description, N'OFML000177' AS EDescription, 'RO' as TypeID, DivisionID from AT1101

GO
