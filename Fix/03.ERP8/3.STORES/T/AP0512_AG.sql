IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0512_AG]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0512_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
----- Created by Tiểu Mai on 03/01/2016
----- Cập nhật số dư và phát sinh phiếu kết quả sản xuất
---- Modified by Bảo Thy on 26/05/2016: Bổ sung WITH (NOLOCK)


CREATE PROCEDURE [dbo].[AP0512_AG]
		@DivisionID nvarchar(50), 
		@WareHouseID  nvarchar(50),
		@TranMonth  int, 
		@TranYear int, 
		@InventoryID  nvarchar(50),
		@ConvertedAmount as Decimal(28,8), 
		@ConvertedQuantity as Decimal(28,8), 
		@DebitAccountID  nvarchar(50), 
		@CreditAccountID  nvarchar(50), 
		@Type as TINYINT,
		@Parameter01 AS DECIMAL(28,8),
		@Parameter02 AS DECIMAL(28,8),
		@Parameter03 AS DECIMAL(28,8),
		@Parameter04 AS DECIMAL(28,8),
		@Parameter05 AS DECIMAL(28,8),
		@MarkQuantity AS DECIMAL(28,8),
		@VoucherID AS NVARCHAR(50),
		@PeriodID AS NVARCHAR(50),
		@CurrencyID AS NVARCHAR(50),
		@ExchangeRate AS DECIMAL(28,8),
		@VoucherNo AS NVARCHAR(50),
		@VoucherDate AS DATETIME,
		@EmployeeID AS NVARCHAR(50),
		@CreateDate AS DATETIME,
		@CreateUserID AS NVARCHAR(50), 
		@LastModifyUserID NVARCHAR(50), 
		@LastModifyDate DATETIME,
		@ObjectID NVARCHAR(50),
		@TransactionID NVARCHAR(50),
		@VoucherTypeID NVARCHAR(50), 
		@KITID NVARCHAR(50), 
		@KITQuantity DECIMAL(28,8)
 AS
	--Print ' abc'
	IF not exists (Select 1 From AT2008  WITH (NOLOCK)	Where 	InventoryID =@InventoryID and
							DivisionID =@DivisionID and
							WareHouseID =@WareHouseID and
							InventoryAccountID =@DebitAccountID and
							TranMonth =@TranMonth and
							TranYear =@TranYear)
		Insert AT2008 (InventoryID, WareHouseID,TranMonth,TranYear, DivisionID,
					InventoryAccountID,   BeginQuantity,  BeginAmount,
					DebitQuantity ,  DebitAmount , CreditQuantity ,
				CreditAmount,  EndQuantity ,  EndAmount)
		Values	(@InventoryID, @WareHouseID, @TranMonth, @TranYear, @DivisionID,
			@DebitAccountID, 0,0, @ConvertedQuantity, @ConvertedAmount , 0,0, 
			@ConvertedQuantity, @ConvertedAmount)
				
	ELSE
		BEGIN
			Update AT2008
				Set	DebitQuantity 	=	isnull(DebitQuantity,0)	+ isnull(@ConvertedQuantity,0),
					DebitAmount 	=	isnull(DebitAmount,0)	+ isnull(@ConvertedAmount,0)	
			Where 		InventoryID =@InventoryID and
					DivisionID =@DivisionID and
					WareHouseID =@WareHouseID and
					InventoryAccountID =@DebitAccountID and
					TranMonth =@TranMonth and
					TranYear =@TranYear	
			Update AT2008
				Set	EndQuantity		=	isnull(BeginQuantity,0)	+ isnull( DebitQuantity,0) - isnull( CreditQuantity,0),
					EndAmount		=	isnull(BeginAmount,0)	+ isnull( DebitAmount,0) - isnull( CreditAmount,0)
			Where 		InventoryID =@InventoryID and
					DivisionID =@DivisionID and
					WareHouseID =@WareHouseID and
					InventoryAccountID =@DebitAccountID and
					TranMonth =@TranMonth and
					TranYear =@TranYear	
		END 
	IF NOT EXISTS (SELECT TOP 1 1 FROM MT0810 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID AND TableID = 'AT2006')
	BEGIN
		--SELECT 1
		INSERT INTO MT0810
		(DivisionID, VoucherID, PeriodID, TranMonth, TranYear, CurrencyID, ExchangeRate, VoucherNo,
		DepartmentID, OriginalAmount, ConvertedAmount, VoucherDate, EmployeeID,
		[Description], CreateDate, CreateUserID, LastModifyUserID, LastModifyDate,
		ResultTypeID, InventoryTypeID, [Disabled], IsPrice, [Status], IsDistribute,
		WareHouseID, IsWareHouseID, IsWareHouse, TeamID, ObjectID, IsTransfer, TableID, VoucherTypeID
		)
		VALUES
		(@DivisionID, @VoucherID, @PeriodID, @TranMonth, @TranYear, @CurrencyID, @ExchangeRate, @VoucherNo,
		N'%', IsNULL(@ConvertedAmount,0), ISNULL(@ConvertedAmount,0), @VoucherDate, @EmployeeID,
		N'Phát sinh từ phiếu nhập kho', @CreateDate, @CreateUserID, @LastModifyUserID, @LastModifyDate,
		'R01', '%', 0, 0, 0, 0, @WareHouseID, 1, 1, N'%', @ObjectID, 0, 'AT2006', @VoucherTypeID)
		
	END			
	IF NOT EXISTS (SELECT TOP 1 1 FROM MT1001 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID AND TransactionID = @TransactionID)	
	BEGIN
		--SELECT 2
		INSERT INTO MT1001
		(DivisionID, TransactionID, VoucherID, TranMonth, TranYear, 
		InventoryID, Quantity, 
		ProductID, DebitAccountID,CreditAccountID, KITID, KITQuantity
		)
		VALUES (@DivisionID, @TransactionID, @VoucherID, @TranMonth, @TranYear,
		@InventoryID, @ConvertedQuantity, @InventoryID, @DebitAccountID, @CreditAccountID, @KITID, @KITQuantity)
		
	END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO