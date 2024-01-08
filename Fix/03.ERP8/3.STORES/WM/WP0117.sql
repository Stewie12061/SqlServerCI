IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0117]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0117]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
--- Cập nhật dữ liệu kho trước khi xóa phiếu lắp ráp (ANGEL)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Tiểu Mai on 27/07/2016
---- Modified by Tiểu Mai on 16/11/2016: Bổ sung cập nhật số dư tồn kho theo lô date - TTDD
---- Modified by Bảo Thy on 26/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung

-- <Example>
/*
	WP0117 'HT','abc'
*/


CREATE PROCEDURE [DBO].[WP0117]
(
    @DivisionID NVARCHAR(50),
	@VoucherID NVARCHAR(50)
	
)
AS
DECLARE 					
@VoucherID_AT2006 NVARCHAR(50), @KindVoucherID INT, @Cur_Ware AS CURSOR, 
@ReVoucherID NVARCHAR(50), @ReTransactionID NVARCHAR(50), @ActualQuantity DECIMAL(28,8), @ConvertedQuantity DECIMAL(28,8), @WareHouseID NVARCHAR(50)			


SET @VoucherID_AT2006 = (SELECT TOP 1 VoucherID FROM AT2007 WHERE DivisionID = @DivisionID AND InheritTableID  = 'AT0112' AND InheritVoucherID = @VoucherID)


SET @Cur_Ware = CURSOR SCROLL KEYSET FOR 
	SELECT KindVoucherID, AT2007.ReVoucherID, AT2007.ReTransactionID, AT2007.ActualQuantity, AT2007.ConvertedQuantity, AT2006.WareHouseID
    FROM AT2006 WITH (NOLOCK) 
    LEFT JOIN AT2007 WITH (NOLOCK) ON AT2007.DivisionID = AT2006.DivisionID AND AT2007.VoucherID = AT2006.VoucherID
    LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN ('@@@', AT2007.DivisionID) AND AT1302.InventoryID = AT2007.InventoryID
	WHERE AT2006.DivisionID = @DivisionID AND InheritTableID  = 'AT0112' AND InheritVoucherID = @VoucherID
		AND (IsSource =1 or IsLimitDate =1 or MethodID in (1,2,3))

OPEN @Cur_Ware
FETCH NEXT FROM @Cur_Ware INTO @KindVoucherID, @ReVoucherID, @ReTransactionID, @ActualQuantity, @ConvertedQuantity, @WareHouseID

WHILE @@Fetch_Status = 0 
    BEGIN
    	IF @KindVoucherID = 2
    	BEGIN 
    		UPDATE AT0114 
    		SET DeQuantity = DeQuantity - @ActualQuantity,
    			DeMarkQuantity = DeMarkQuantity - @ConvertedQuantity
    		WHERE DivisionID = @DivisionID AND ReVoucherID = @ReVoucherID AND ReTransactionID = @ReTransactionID AND WareHouseID = @WareHouseID
    		
    		UPDATE AT0114 
    		SET EndQuantity = ReQuantity - DeQuantity,
    			EndMarkQuantity = ReMarkQuantity - DeMarkQuantity 
    		WHERE DivisionID = @DivisionID AND ReVoucherID = @ReVoucherID AND ReTransactionID = @ReTransactionID AND WareHouseID = @WareHouseID
    	END 	
    		
    FETCH NEXT FROM @Cur_Ware INTO @KindVoucherID, @ReVoucherID, @ReTransactionID, @ActualQuantity, @ConvertedQuantity, @WareHouseID
    END 

CLOSE @Cur_Ware

IF EXISTS (SELECT TOP 1 1 FROM AT2007 WITH (NOLOCK) WHERE  DivisionID = @DivisionID AND InheritTableID  = 'AT0112' AND InheritVoucherID = @VoucherID )
BEGIN
    			
    DELETE FROM AT2007 WHERE DivisionID = @DivisionID AND InheritTableID  = 'AT0112' AND InheritVoucherID = @VoucherID AND BatchID = @VoucherID
    
    

END 	

DELETE FROM AT2006 WHERE DIvisionID = @DivisionID AND  TableID = 'AT0112' AND BatchID = @VoucherID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
