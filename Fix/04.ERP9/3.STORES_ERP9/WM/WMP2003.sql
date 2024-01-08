IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP2003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP2003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Kiểm tra số lượng mặt hàng
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Bảo Thy, Date: 13/01/2016
 /*-- <Example>
 	WMP2003 @DivisionID='ESP',@ActualQuantity=10, @ContractID = 'CT20170000000007', @InventoryID='ONGNHOM', @VoucherID='46af2a56-e4db-4f5e-8d22-4d7367ee1c9b', @Mode = 1
 	
 ----*/
 
 CREATE PROCEDURE WMP2003
 ( 
   @DivisionID varchar(50),
   @ActualQuantity decimal(28,8),
   @ContractID varchar(50),
   @InventoryID varchar(50),
   @VoucherID varchar(50),
   @Mode TINYINT --0: YCNK, 1: YCXK
 ) 
 AS
 DECLARE @Remain decimal(28,8)

IF @Mode = 0
BEGIN	 
SELECT @Remain = ISNULL(SUM(AT1025.Quantity),0) - ISNULL(SUM(WT96.ActualQuantity),0) 

--+ (SELECT ISNULL(SUM(ActualQuantity),0) 
--FROM WT0096 WHERE DivisionID= @DivisionID AND VoucherID = @VoucherID 
--AND InventoryID = @InventoryID)
FROM AT1025 WITH (NOLOCK)
LEFT JOIN WT0095 WT95 WITH (NOLOCK) ON AT1025.DivisionID = WT95.DivisionID AND AT1025.ContractID = WT95.ContractID AND WT95.KindVoucherID IN (1,3,5,7,9)
										AND WT95.VoucherID <> @VoucherID
LEFT JOIN WT0096 WT96 WITH (NOLOCK) ON WT96.DivisionID = WT95.DivisionID AND WT96.VoucherID = WT95.VoucherID AND AT1025.InventoryID = WT96.InventoryID
WHERE AT1025.DivisionID = @DivisionID
AND AT1025.ContractID = @ContractID
AND AT1025.InventoryID LIKE @InventoryID


END
ELSE 
BEGIN	 
SELECT @Remain = ISNULL(SUM(WT96.ActualQuantity),0) - ISNULL(SUM(WT961.ActualQuantity),0) 

--- ISNULL(SUM(WT961.ActualQuantity),0) + (SELECT ISNULL(SUM(ActualQuantity),0) 
--FROM WT0096 WHERE DivisionID= @DivisionID AND VoucherID = @VoucherID 
--AND InventoryID = @InventoryID)  
FROM AT1025 WITH (NOLOCK)
LEFT JOIN WT0095 WT95 WITH (NOLOCK) ON AT1025.DivisionID = WT95.DivisionID AND AT1025.ContractID = WT95.ContractID AND WT95.KindVoucherID IN (1,3,5,7,9)
LEFT JOIN WT0096 WT96 WITH (NOLOCK) ON WT96.DivisionID = WT95.DivisionID AND WT96.VoucherID = WT95.VoucherID AND AT1025.InventoryID = WT96.InventoryID
LEFT JOIN WT0095 WT951 WITH (NOLOCK) ON AT1025.DivisionID = WT951.DivisionID AND AT1025.ContractID = WT951.ContractID AND WT951.KindVoucherID IN (2,4,6,8,10)
										AND WT951.VoucherID <> @VoucherID
LEFT JOIN WT0096 WT961 WITH (NOLOCK) ON WT961.DivisionID = WT951.DivisionID AND WT961.VoucherID = WT951.VoucherID AND AT1025.InventoryID = WT961.InventoryID
WHERE AT1025.DivisionID = @DivisionID
AND AT1025.ContractID = @ContractID
AND AT1025.InventoryID LIKE @InventoryID

END

--select @Remain Remain
IF @ActualQuantity > @Remain SELECT 1 AS Status
ELSE SELECT 0 AS Status

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
