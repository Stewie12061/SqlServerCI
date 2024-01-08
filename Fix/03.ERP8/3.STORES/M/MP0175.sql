IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0175]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0175]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Customize Angel: load edit màn hình chi tiết các đợt sản xuất
---- Created by Bảo Anh, Date: 10/03/2016
---- Modified by Tiểu Mai on 17/02/2017: Bổ sung lấy tồn đầu của kho thành phẩm, kho bán phẩm, kho NL, Kho VT (yêu cầu mail ngày 17/02/2017)
---- MP0175 'CTY','',''

CREATE PROCEDURE [dbo].[MP0175] 
    @DivisionID NVARCHAR(50),
	@TranMonth int,
	@TranYear int,
	@VoucherID NVARCHAR(50),
	@VoucherDate as datetime,
	@TransactionID NVARCHAR(50)
	
AS
Declare @Quantity decimal(28,8),
		@InventoryID nvarchar(50)

SELECT @InventoryID = InventoryID, @Quantity = Quantity
FROM MT0170
WHERE DivisionID = @DivisionID AND TransactionID = @TransactionID

IF NOT EXISTS (Select Top 1 1 From MT0171 WHERE DivisionID = @DivisionID AND TransactionID = @TransactionID)	--- addnew
	Select	@VoucherID as VoucherID, @TransactionID as TransactionID, @InventoryID as InventoryID, 1 as Orders,
			(dateadd(d,
					(Round(
						(
							(Select SUM(SignQuantity)
							From AV7000 Where DivisionID = @DivisionID
							And InventoryID = @InventoryID
							And (VoucherDate <= @VoucherDate Or D_C = 'BD') AND WareHouseID IN ('KTP','KBP', 'KNL', 'KVT')
							)/(@Quantity*60/100/14)
						),0)-2),
					@VoucherDate)
			) as RequestDate,
			(dateadd(d,
					(Round(
						(
							(Select SUM(SignQuantity)
							From AV7000 Where DivisionID = @DivisionID
							And InventoryID = @InventoryID
							And (VoucherDate <= @VoucherDate Or D_C = 'BD') AND WareHouseID IN ('KTP','KBP', 'KNL', 'KVT')
							)/(@Quantity*60/100/14)
						),0)-2),
					@VoucherDate)
			) as BeginDate, NULL as FinishDate, @Quantity as Quantity

ELSE	--- edit
	SELECT * FROM MT0171
	WHERE DivisionID = @DivisionID
	AND TransactionID = @TransactionID
	ORDER BY Orders


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
