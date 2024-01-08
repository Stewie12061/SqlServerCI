IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP2051]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP2051]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- Create by: Huynh Trung Dung; date 18/04/2011  
--- Purpose: Xuat detail cho phieu nhap kho thanh pham tu dong  
--- Edit by: Văn Tài on Date 05/02/2021: Bổ sung WT2007 theo DivisionID.
--- Edit by: Văn Tài on Date 18/02/2021: Bổ sung WT2007 theo DivisionID. Check ProductID.
--- Purpose: Bo sung dieu kien loc de xuat nhung mat hang khong co trong danh sach loai tru (AQ2007)
CREATE PROCEDURE WP2051
	@DivisionID AS VARCHAR(20)
	, @TranMonth AS INT
	, @TranYear AS INT
	, @VoucherID AS VARCHAR(50)
	, @exVoucherID AS VARCHAR(20)  
  
AS  
  
DECLARE  
 @ProductID AS VARCHAR(20),
 @ConvertedQuantity AS DECIMAL(28,8),
 @Quantity AS DECIMAL(28,8),
 @ConvertedUnitID AS VARCHAR(20),
 @UnitID AS VARCHAR(20),
 @ConvertedPrice AS DECIMAL(28,8),
 @Price AS DECIMAL(28,8),
 @ConvertedAmount AS DECIMAL(28,8),
 @Parameter01 AS MONEY,
 @Parameter02 AS MONEY,
 @Parameter03 AS MONEY,
 @Parameter04 AS MONEY,
 @Parameter05 AS MONEY,
 @DebitAccountID AS VARCHAR(20),
 @CreditAccountID AS VARCHAR(20),
 @Ana01ID AS VARCHAR(20),
 @Ana02ID AS VARCHAR(20),
 @Ana03ID AS VARCHAR(20),
 @Ana04ID AS VARCHAR(20),
 @Ana05ID AS VARCHAR(20),
 @OTransactionID AS VARCHAR(20),  
 @MTransactionID AS VARCHAR(20),  
 @ProductID1 AS VARCHAR(20),  
  
 @Orders as int,  
 @TransactionID as varchar(20),   
 @cur as cursor  
  
Set @Orders = 1  
Set @DebitAccountID = '155'  
Set @CreditAccountID = '154'  

Set @cur = CURSOR STATIC FOR  

Select InventoryID
		, ConvertedQuantity
		, ActualQuantity
		, ConvertedUnitID
		, UnitID
		, ConvertedPrice
		, UnitPrice
		, ConvertedAmount
		, isnull(Parameter01, 0)
		, isnull(Parameter02, 0)
		, isnull(Parameter03, 0)
		, isnull(Parameter04, 0)
		, isnull(Parameter05,0)
		, Ana01ID
		, Ana02ID
		, Ana03ID
		, Ana04ID
		, Ana05ID
		, OTransactionID
		, MTransactionID
		, ProductID  
From AT2007 AT07 WITH (NOLOCK)
Where VoucherID = @VoucherID 
		AND DivisionID = @DivisionID 
		AND TranMonth = @TranMonth 
		And TranYear = @TranYear  
  
OPEN @CUR  
FETCH NEXT FROM @cur INTO @ProductID
							, @ConvertedQuantity
							, @Quantity
							, @ConvertedUnitID
							, @UnitID
							, @ConvertedPrice
							, @Price
							, @ConvertedAmount
							, @Parameter01
							, @Parameter02
							, @Parameter03
							, @Parameter04
							, @Parameter05
							, @Ana01ID
							, @Ana02ID
							, @Ana03ID
							, @Ana04ID
							, @Ana05ID
							, @OTransactionID
							, @MTransactionID
							, @ProductID1  
WHILE @@FETCH_STATUS = 0  
BEGIN  
 IF NOT EXISTS (SELECT WT2007.ProductID FROM WT2007 WITH (NOLOCK) WHERE WT2007.DivisionID = @DivisionID AND WT2007.ProductID = @ProductID)  
 BEGIN  
  EXEC AP0000 @DivisionID, @TransactionID Output, 'MT1001', 'MQ', @TranYear, '', 16, 3, 0, '-'  

  INSERT INTO MT1001  
				(TransactionID
				 , VoucherID
				 , TranMonth
				 , TranYear
				 , DivisionID
				 , ConvertedQuantity
				 , Quantity
				 , ConvertedUnitID
				 , UnitID
				 , ConvertedPrice
				 , Price
				 , ConvertedAmount
				 , Parameter01
				 , Parameter02
				 , Parameter03
				 , Parameter04
				 , Parameter05
				 , Note
				 , ProductID
				 , DebitAccountID
				 , CreditAccountID
				 , SourceNo
				 , LimitDate
				 , Ana01ID
				 , Ana02ID
				 , Ana03ID
				 , Ana04ID
				 , Ana05ID
				 , OTransactionID
				 , MTransactionID
				 , ProductID1
				)  
  VALUES   
   (@TransactionID
	, @exVoucherID
	, @TranMonth
	, @TranYear
	, @DivisionID
	, @ConvertedQuantity
	, @Quantity
	, @ConvertedUnitID
	, @UnitID
	, isnull(@ConvertedPrice, 0)
	, isnull(@Price,0)
	, isnull(@ConvertedAmount, 0)
	, @Parameter01
	, @Parameter02
	, @Parameter03
	, @Parameter04
	, @Parameter05
	, ''
	, @ProductID
	, @DebitAccountID
	, @CreditAccountID
	, Null
	, Null
	, @Ana01ID
	, @Ana02ID
	, @Ana03ID
	, @Ana04ID
	, @Ana05ID
	, @OTransactionID
	, @MTransactionID
	, @ProductID1)  
 END  
 SET @Orders = @Orders + 1  
 FETCH NEXT FROM @cur Into @ProductID
							, @ConvertedQuantity
							, @Quantity
							, @ConvertedUnitID
							, @UnitID
							, @ConvertedPrice
							, @Price
							, @ConvertedAmount
							, @Parameter01
							, @Parameter02
							, @Parameter03
							, @Parameter04
							, @Parameter05
							, @Ana01ID
							, @Ana02ID
							, @Ana03ID
							, @Ana04ID
							, @Ana05ID
							, @OTransactionID
							, @MTransactionID
							, @ProductID1  
END  
  
Close @cur
DEALLOCATE @cur

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
