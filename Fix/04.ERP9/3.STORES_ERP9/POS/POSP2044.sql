IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP2044]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP2044]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load dữ liệu tồn kho từ ca bán hàng trước đó
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tiểu Mai on 11/06/2018
-- <Example>
/*
      exec POSP2044 'AT','SR.457TC' 
*/
CREATE PROCEDURE POSP2044
( 
		@DivisionID AS NVARCHAR(50),
		@ShopID NVARCHAR(50)
) 
AS 
DECLARE @ShiftID NVARCHAR(50),
		@ShiftDate DATETIME
		
SET @ShiftID = (SELECT TOP 1 ShiftID FROM POST2033 P33 WITH (NOLOCK)
                WHERE P33.DivisionID = @DivisionID AND P33.ShopID = @ShopID AND P33.IsLockShift = 1
                ORDER BY P33.ShiftDate desc )

SET @ShiftDate = (SELECT TOP 1 ShiftDate FROM POST2033 P33 WITH (NOLOCK)
                WHERE P33.DivisionID = @DivisionID AND P33.ShopID = @ShopID AND P33.IsLockShift = 1
                ORDER BY P33.ShiftDate desc)

SELECT DISTINCT P34.InventoryID,P34.UnitID,P34.Quantity, P34.EndQuantity as BeginQuantity, A02.InventoryName, P33.APK AS ReAPK, CardStubsNumber, VoucherStubsNumber, InvoiceNumber
FROM POST2033 P33 WITH (NOLOCK)
LEFT JOIN POST2034 P34 WITH (NOLOCK) ON P33.DivisionID = P34.DivisionID AND P33.ShopID = P34.ShopID AND P33.ShiftID = P34.ShiftID AND P33.ShiftDate = P34.ShiftDate
LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.InventoryID = P34.InventoryID
WHERE P33.DivisionID  = @DivisionID AND P33.ShopID = @ShopID 
 	AND P33.ShiftID = @ShiftID AND P33.ShiftDate = @ShiftDate
 	AND P34.TypeID = 2 AND P34.InventoryID IS NOT NULL

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
