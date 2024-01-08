IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP2001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP2001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Quản lý tồn kho theo Pallet
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by Khánh Đoan on 23/09/2019
---- Modified by Huỳnh Thử 14/11/2019 Sum (EnQuantity)
---- Modified by Huỳnh Thử 07/01/2020 Sửa điều kiện Xóa lệnh xuất kho
---- Modified by Huỳnh Thử 20/03/2020 Thêm điều kiện update vị trí ô khi lưu lệch nhập kho
---- Modified by Huỳnh Thử 21/08/2020: Cập nhật trạng thái vị trí move sang nghiệp vụ xuất kho

---- 
---- Modified on by 
-- <Example>
/*
    EXEC WP2012 @DivisionID =@DivisionID, @TransactionID ='',@VoucherID='',@WarehouseID ='',@VoucherNo ='',@TranYear ='',@TranMonth ='',@VoucherDate ='',@InventoryID ='',
	@ActualQuantity ='',@SourceNo ='',@LimitDate ='',@IsOutStock ='',@ExVoucherDate ='',@Mode =''
*/




CREATE PROCEDURE [dbo].[WP2001]
    @DivisionID NVARCHAR(50),
    @TransactionID NVARCHAR(50),
    @VoucherID NVARCHAR(50),
    @WarehouseID NVARCHAR(50),
	@VoucherNo NVARCHAR(50),
    @TranYear INT,
    @TranMonth INT,
    @VoucherDate DATETIME,
    @InventoryID NVARCHAR(50),
    @ActualQuantity DECIMAL(28, 8),
    @SourceNo NVARCHAR(50),
    @LimitDate AS DATETIME,
    @IsOutStock TINYINT, 
	@ExVoucherDate DATETIME,
    @Mode TINYINT
AS
Declare @LocationID as Nvarchar(50)

IF @Mode = 1 --N THEM MOI 
BEGIN
    IF NOT EXISTS
    (
        SELECT ReTransactionID
        FROM WT2003
        WHERE ReVoucherID = @VoucherID
              AND ReTransactionID = @TransactionID
    )
    BEGIN
        INSERT WT2003
        (	DivisionID,InventoryID,
			WareHouseID,ReVoucherNo,
            ReVoucherID,ReTransactionID,
			ReVoucherDate,ReTranMonth,
            ReTranYear,ReSourceNo,
            LimitDate,ReQuantity,
            DeQuantity,EndQuantity,IsOutStock,
			ExVoucherDate)
        VALUES
        (@DivisionID, @InventoryID, @WarehouseID,@VoucherNo ,@VoucherID, 
		@TransactionID, @VoucherDate, @TranMonth, @TranYear, @SourceNo,
		 @LimitDate, @ActualQuantity, 0,@ActualQuantity, @IsOutStock, @ExVoucherDate)
    END
    ELSE
    BEGIN
        -- Đổi số lượng khi chưa xuat kho
        UPDATE WT2003 WITH (ROWLOCK)
        SET ReQuantity = @ActualQuantity,
            EndQuantity = @ActualQuantity
        WHERE DivisionID = @DivisionID
              AND ReVoucherID = @VoucherID
              AND ReTransactionID = @TransactionID
    END
END
ELSE IF @Mode = 2
BEGIN
    
	 UPDATE WT2003 WITH (ROWLOCK)
        SET DeQuantity = ISNULL(DeQuantity, 0) + ISNULL(@ActualQuantity, 0),
            EndQuantity = ISNULL(ReQuantity, 0) - ISNULL(DeQuantity, 0) - ISNULL(@ActualQuantity, 0)
		
        WHERE DivisionID = @DivisionID
              AND ReVoucherID = @VoucherID
              AND ReTransactionID = @TransactionID

		
		IF ((SELECT SUM(EndQuantity)  FROM WT2003 WHERE DivisionID = @DivisionID AND ReVoucherID = @VoucherID  ) > 0)
				 BEGIN
				 UPDATE WT2003 WITH (ROWLOCK)
						SET IsOutStock  = 1, ---- Còn hàng trên Pallet
						ExVoucherDate = @ExVoucherDate		
				 WHERE DivisionID = @DivisionID
						  AND ReVoucherID = @VoucherID
				END
		ELSE 
				BEGIN
				 UPDATE WT2003 WITH (ROWLOCK)
						SET IsOutStock  = 0, --- Hàng xuất hết kho
					ExVoucherDate = @ExVoucherDate		
				 WHERE DivisionID = @DivisionID
						  AND ReVoucherID = @VoucherID
				END
		-- Cập nhật trạng thái vị trí move sang nghiệp vụ xuất kho
		--IF((SELECT SUM(IsOutStock) FROM WT2003 WHERE ReVoucherID = @VoucherID) = 0 )
		--BEGIN

		--		SELECT @LocationID = LocationID FROM WT2002 where RePVoucherID = @VoucherID and RePTransactionID = @TransactionID
		--		UPDATE  CT0199 
		--		SET IsEmpty = 0
		--		FROM CT0199  WITH (NOLOCK)
		--		LEFT JOIN WT2003  T03 WITH (NOLOCK) ON  T03.WareHouseID = CT0199.WareHouseID
		--		WHERE LocationID = @LocationID

		--END

		
END


ELSE -- Xóa lệnh xuất kho
BEGIN
    
        UPDATE WT2003 WITH (ROWLOCK)
        SET DeQuantity = ISNULL(DeQuantity, 0) - ISNULL(@ActualQuantity, 0),
            EndQuantity = ISNULL(EndQuantity, 0) + ISNULL(@ActualQuantity, 0) 
        WHERE DivisionID = @DivisionID
              AND ReVoucherID = @VoucherID
              AND ReTransactionID = @TransactionID


		IF ((SELECT EndQuantity  FROM WT2003 WHERE DivisionID = @DivisionID AND ReVoucherID = @VoucherID AND ReTransactionID = @TransactionID  ) > 0)
				 UPDATE WT2003 WITH (ROWLOCK)
						SET IsOutStock  = 1, ---- Còn hàng trên Pallet
							ExVoucherDate = GETDATE()			
				 WHERE DivisionID = @DivisionID
						  AND ReVoucherID = @VoucherID
						AND ReTransactionID = @TransactionID
		ELSE 
				 UPDATE WT2003 WITH (ROWLOCK)
						SET IsOutStock  = 0, --- Hàng xuất hết kho
						ExVoucherDate = GETDATE()				
				 WHERE DivisionID = @DivisionID
						 AND ReVoucherID = @VoucherID
						 	AND ReTransactionID = @TransactionID

        -- Cập nhật trạng thái vị trí move sang nghiệp vụ xuất kho
		--IF((SELECT SUM(IsOutStock) FROM WT2003 WHERE ReVoucherID = @VoucherID) = 0 )
		--BEGIN
		--		UPDATE  CT0199 
		--		SET IsEmpty = 0
		--		FROM CT0199  WITH (NOLOCK)
		--		WHERE dbo.CT0199.LocationID IN (SELECT WT2001.LocationID FROM WT2001 LEFT JOIN WT2002 On WT2002.VoucherID = WT2001.VoucherID
		--		WHERE dbo.WT2002.VoucherID = @VoucherID AND WT2002.TransactionID =  @TransactionID ) 	

		--END
		--ELSE 
		--BEGIN
		--		UPDATE  CT0199 
		--		SET IsEmpty = 1
		--		FROM CT0199  WITH (NOLOCK)
		--		WHERE dbo.CT0199.LocationID IN (SELECT WT2001.LocationID FROM WT2001 LEFT JOIN WT2002 On WT2002.VoucherID = WT2001.VoucherID
		--		WHERE dbo.WT2002.VoucherID =@VoucherID AND WT2002.TransactionID =  @TransactionID ) 	
		--END		 
		
		
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
