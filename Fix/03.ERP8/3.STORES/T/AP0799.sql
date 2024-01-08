IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0799]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0799]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Chuyển dữ liệu qua POS
-- <Param>
---- Cusomize PHUCLONG (Gọi từ trigger AY2007)
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Phương Thảo on 24/11/2016
---- Modified by: Kim Vũ on 07/04/2017 Bổ sung đẩy phiếu nhập kho N11 từ db ERP sang db trung gian
---- Modified by: Kim Vũ on 12/04/2017 Bổ sung đẩy thong tin phiếu nhập kho N11 từ db ERP sang db trung gian
-- <Example>

CREATE PROCEDURE [dbo].[AP0799]
    @TransactionID NVARCHAR(50), 
    @DivisionID NVARCHAR(50), 
    @RDVoucherID NVARCHAR(50), 
    @TranYear INT, 
    @TranMonth INT, 
    @RDVoucherDate DATETIME, 
    @RDVoucherNo NVARCHAR(50), 
    @EmployeeID NVARCHAR(50),
    @ObjectID NVARCHAR(50), -- @VoucherTypeID NVARCHAR(50),
    @CreateUserID NVARCHAR(50), 
    @CreateDate DATETIME, 
    @Description NVARCHAR(225), 
    @WareHouseID NVARCHAR(50), 
    @WareHouseID2 NVARCHAR(50), 
    @Status INT, 
    @KindVoucherID INT, 
    @CurrencyID NVARCHAR(50), 
    @ExchangeRate DECIMAL(28, 8), 
    @InventoryID NVARCHAR(50), 
    @UnitID NVARCHAR(50), 
    @MethodID TINYINT, 
    @ActualQuantity DECIMAL(28, 8), 
    @UnitPrice DECIMAL(28, 8), 
    @ConvertedQuantity DECIMAL(28, 8), 
    @ConvertedUnitPrice DECIMAL(28, 8), 
    @OriginalAmount DECIMAL(28, 8), 
    @ConvertedAmount DECIMAL(28, 8), 
    @DebitAccountID NVARCHAR(50), 
    @CreditAccountID NVARCHAR(50), 
    @SourceNo NVARCHAR(50), 
    @IsLimitDate TINYINT, 
    @IsSource TINYINT, 
    @LimitDate AS DATETIME, 
    @TableID AS NVARCHAR(50), 
    @BatchID AS NVARCHAR(50), 
    @Ana01ID AS NVARCHAR(50), 
    @Ana02ID AS NVARCHAR(50), 
    @Ana03ID AS NVARCHAR(50), 
    @Ana04ID AS NVARCHAR(50), 
    @Ana05ID AS NVARCHAR(50), 
    @Ana06ID AS NVARCHAR(50), 
    @Ana07ID AS NVARCHAR(50), 
    @Ana08ID AS NVARCHAR(50), 
    @Ana09ID AS NVARCHAR(50), 
    @Ana10ID AS NVARCHAR(50), 
    @Notes AS NVARCHAR(250), 
    @VoucherTypeID NVARCHAR(50), 
    @PeriodID NVARCHAR(50), 
    @ProductID NVARCHAR(50), 
    @IsTemp TINYINT, 
    @OrderID NVARCHAR(50), 
    @OTransactionID AS NVARCHAR(50), 
    @MOrderID AS NVARCHAR(50), 
    @SOrderID AS NVARCHAR(50),
    @IsGoodsFirstVoucher AS TINYINT,
    @ReVoucherID AS NVARCHAR(50),
    @ReTransactionID NVARCHAR(50),
    @Parameter01 AS DECIMAL(28,8),
    @Parameter02 AS DECIMAL(28,8),
    @Parameter03 AS DECIMAL(28,8),
    @Parameter04 AS DECIMAL(28,8),
    @Parameter05 AS DECIMAL(28,8),
    @MarkQuantity AS DECIMAL(28,8),
    @ConvertedUnitID NVARCHAR(50),
    @RefNo01 NVARCHAR(100),
	@RefNo02 NVARCHAR(100),
	@IsProduct AS TINYINT,
	@KITID NVARCHAR(50),
	@KITQuantity DECIMAL(28,8),
	@IsLedger TINYINT = 0,
	@DepartmentCode NVarchar(250)
AS


IF ((@VoucherTypeID IN ('VC1','VC2','VC5') And @KindVoucherID = 3) OR (@VoucherTypeID = 'N11' AND @KindVoucherID = 1) )
BEGIN

    INSERT INTO [ERP_TO_POS].[dbo].[WarehouseObject]
    (	
		DivisionID,
		TransactionID,
		VoucherID,
		BatchID,
		VoucherTypeID,
		VoucherDate,
		VoucherNo,
		Description,
		InventoryID,
		DepartmentCode,
		UnitID,
		ActualQuantity,
		UnitPrice,
		OriginalAmount,
		ConvertedAmount,
		Notes,
		TranMonth,
		TranYear,
		CurrencyID,
		ExchangeRate,
		DebitAccountID,
		CreditAccountID,
		ObjectID,
		KindVoucherID,
		WareHouseID,
		[WareHouseID2],
		EmployeeID,
		CreateDate,
		CreateUserID,
		LastModifyUserID,
		LastModifyDate) 
    VALUES
    (	@DivisionID, @TransactionID, @RDVoucherID, ISNULL(@BatchID, ''), @VoucherTypeID, @RDVoucherDate,
		@RDVoucherNo, @Description, @InventoryID, 
		case when (@VoucherTypeID = 'N11' AND @KindVoucherID = 1) then @WareHouseID else @DepartmentCode end , 
		@UnitID,
		@ActualQuantity, @UnitPrice, @OriginalAmount, @ConvertedAmount, 
		@Notes,  @TranMonth, @TranYear, @CurrencyID, @ExchangeRate, 
		@DebitAccountID, @CreditAccountID, @ObjectID,  
		@KindVoucherID, @WareHouseID, case when (@VoucherTypeID = 'N11' AND @KindVoucherID = 1) then @ObjectID else @WarehouseID2 end , 
		@EmployeeID,
		@CreateDate,
		@CreateUserID,
		@CreateUserID,
		@CreateDate
		)

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
