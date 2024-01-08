IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0181]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0181]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Xử lý dữ liệu khi duyệt đề nghị định mức
-- <History>
---- Created by Tiểu Mai on 20/08/2016
---- Modified on 22/11/2021 by Nhật Thanh: Customize cho Angel
---- Modified on ... by 
-- <Example>

/*
 * exec MP0181 'PC'
 */

CREATE PROCEDURE [dbo].[MP0181] 	
	@DivisionID NVARCHAR(50),
	@VoucherID NVARCHAR(50)
AS
DECLARE @IsApportionConfirm INT,
		@CustomerName int

SET @CustomerName = (select CustomerName from CustomerIndex)
SET @IsApportionConfirm = ISNULL((SELECT IsApportionConfirm FROM MT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID),0)

IF @IsApportionConfirm = 1
BEGIN
	UPDATE MT0176 
	SET [Status] = 1
	WHERE DivisionID = @DivisionID
	AND Isnull(IsConfirm01,0) IN ( 1,2)
	AND VoucherID = @VoucherID
                                                                                          
END
ELSE IF @IsApportionConfirm = 2
BEGIN
	UPDATE MT0176 
	SET [Status] = 1
	WHERE DivisionID = @DivisionID
	AND Isnull(IsConfirm01,0) = 1 AND ISNULL(IsConfirm02,0) IN ( 1,2)
	AND VoucherID = @VoucherID
	
END

IF (@CustomerName = 57)
BEGIN
	UPDATE MT0176
		SET [Status] = 0
		WHERE DivisionID = @DivisionID
		AND Isnull(IsConfirm01,0) = 0
		AND VoucherID = @VoucherID
END

IF EXISTS (SELECT TOP 1 1 FROM MT0176 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID AND ((
	@IsApportionConfirm = 1 AND ISNULL(MT0176.IsConfirm01,0) = 1) OR (@IsApportionConfirm = 2 and ISNULL(MT0176.IsConfirm02,0) = 1)) AND [Status] = 1)
BEGIN 	
	UPDATE MT0135 
	SET InheritVoucherID = MT0176.VoucherID,
		LastModifyDate = MT0176.LastModifyDate,
		LastModifyUserID = MT0176.LastModifyUserID
	FROM MT0135
	LEFT JOIN MT0176 WITH (NOLOCK) ON MT0135.DivisionID = MT0176.DivisionID AND MT0135.ApportionID = MT0176.InheritApportionID
	LEFT JOIN MT0177 WITH (NOLOCK) ON MT0177.DivisionID = MT0176.DivisionID AND MT0177.VoucherID = MT0176.VoucherID AND MT0177.ReTransactionID = MT0176.TransactionID
	LEFT JOIN MT0136 WITH (NOLOCK) ON MT0136.DivisionID = MT0135.DivisionID AND MT0136.ApportionID = MT0135.ApportionID AND MT0136.TransactionID = MT0176.InheritTransactionID
	LEFT JOIN MT0137 WITH (NOLOCK) ON MT0137.DivisionID = MT0136.DivisionID AND MT0137.ReTransactionID = MT0136.TransactionID AND MT0137.TransactionID = MT0177.InheritTransactionID
	WHERE MT0176.DivisionID = @DivisionID
	AND Isnull(MT0176.[Status],0) = 1
	AND MT0176.VoucherID = @VoucherID

	UPDATE MT0136
	SET ProductQuantity = MT0176.ProductQuantity
	FROM MT0136
	LEFT JOIN MT0135 WITH (NOLOCK) ON MT0135.DivisionID = MT0136.DivisionID AND MT0135.ApportionID = MT0136.ApportionID
	LEFT JOIN MT0176 WITH (NOLOCK) ON MT0136.DivisionID = MT0135.DivisionID AND MT0136.ApportionID = MT0135.ApportionID AND MT0136.TransactionID = MT0176.InheritTransactionID
	LEFT JOIN MT0177 WITH (NOLOCK) ON MT0177.DivisionID = MT0176.DivisionID AND MT0177.VoucherID = MT0176.VoucherID AND MT0177.ReTransactionID = MT0176.TransactionID
	LEFT JOIN MT0137 WITH (NOLOCK) ON MT0137.DivisionID = MT0136.DivisionID AND MT0137.ReTransactionID = MT0136.TransactionID AND MT0137.TransactionID = MT0177.InheritTransactionID
	WHERE MT0176.DivisionID = @DivisionID
	AND MT0135.InheritVoucherID = MT0176.VoucherID
	AND Isnull(MT0176.[Status],0) = 1
	AND MT0176.VoucherID = @VoucherID

	UPDATE MT0137
	SET MaterialQuantity = MT0177.MaterialQuantity,
	MaterialPrice	=	MT0177.MaterialPrice,
	RateDecimalApp	=	MT0177.RateDecimalApp,
	MaterialAmount	=	MT0177.MaterialAmount,
	QuantityUnit	=	MT0177.QuantityUnit,
	ConvertedUnit	=	MT0177.ConvertedUnit
	FROM MT0137
	LEFT JOIN MT0136 WITH (NOLOCK) ON MT0136.DivisionID = MT0137.DivisionID AND MT0136.TransactionID = MT0137.ReTransactionID
	LEFT JOIN MT0135 WITH (NOLOCK) ON MT0135.DivisionID = MT0136.DivisionID AND MT0135.ApportionID = MT0136.ApportionID
	LEFT JOIN MT0176 WITH (NOLOCK) ON MT0136.DivisionID = MT0176.DivisionID AND MT0176.InheritApportionID = MT0136.ApportionID AND MT0176.InheritTransactionID = MT0136.TransactionID
	LEFT JOIN MT0177 WITH (NOLOCK) ON MT0177.DivisionID = MT0176.DivisionID AND MT0177.VoucherID = MT0176.VoucherID AND MT0177.ReTransactionID = MT0176.TransactionID AND MT0177.InheritTransactionID = MT0137.TransactionID
	WHERE MT0176.DivisionID = @DivisionID
	AND MT0135.InheritVoucherID = MT0176.VoucherID
	AND Isnull(MT0176.[Status],0) = 1
	AND MT0176.VoucherID = @VoucherID

	DECLARE @Cur CURSOR,
	@ApportionID		NVARCHAR(50),
	@TransactionID		nvarchar(50),
	@ProductID			nvarchar(50),
	@UnitID				nvarchar(50),
	@ProductQuantity	DECIMAL(28,8),
	@S01ID				nvarchar(50),
	@S02ID				nvarchar(50),
	@S03ID				nvarchar(50),
	@S04ID				nvarchar(50),
	@S05ID				nvarchar(50),
	@S06ID				nvarchar(50),
	@S07ID				nvarchar(50),
	@S08ID				nvarchar(50),
	@S09ID				nvarchar(50),
	@S10ID				nvarchar(50),
	@S11ID				nvarchar(50),
	@S12ID				nvarchar(50),
	@S13ID				nvarchar(50),
	@S14ID				nvarchar(50),
	@S15ID				nvarchar(50),
	@S16ID				nvarchar(50),
	@S17ID				nvarchar(50),
	@S18ID				nvarchar(50),
	@S19ID				nvarchar(50),
	@S20ID				nvarchar(50),
	@Parameter01		nvarchar(250),
	@Parameter02		nvarchar(250),
	@Parameter03		nvarchar(250),
	@InheritTransactionID NVARCHAR(50),
	@InheritTransactionID_36 NVARCHAR(50),
	@Orders INT


	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT DISTINCT MT0176.DivisionID, MT0176.TransactionID, MT0176.VoucherID, MT0176.ProductID, MT0176.UnitID, MT0176.ProductQuantity, 
	MT0176.S01ID, MT0176.S02ID, MT0176.S03ID, MT0176.S04ID, MT0176.S05ID, MT0176.S06ID, MT0176.S07ID, MT0176.S08ID, MT0176.S09ID, MT0176.S10ID,
	MT0176.S11ID, MT0176.S12ID, MT0176.S13ID, MT0176.S14ID, MT0176.S15ID, MT0176.S16ID, MT0176.S17ID, MT0176.S18ID, MT0176.S19ID, MT0176.S20ID,
	MT0176.Parameter01, MT0176.Parameter02, MT0176.Parameter03, MT0135.ApportionID, MT0176.Orders, MT0176.InheritTransactionID
	FROM MT0176  WITH (NOLOCK)
	LEFT JOIN MT0177 WITH (NOLOCK) ON MT0177.DivisionID = MT0176.DivisionID AND MT0177.VoucherID = MT0176.VoucherID AND MT0177.ReTransactionID = MT0176.TransactionID
	LEFT JOIN MT0135 WITH (NOLOCK) ON MT0135.DivisionID = MT0176.DivisionID AND MT0135.InheritVoucherID = MT0176.VoucherID
	WHERE MT0176.DivisionID = @DivisionID
	AND Isnull(MT0176.[Status],0) = 1
	AND MT0176.VoucherID = @VoucherID
	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @DivisionID, @TransactionID, @VoucherID, @ProductID, @UnitID, @ProductQuantity, 
	@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
	@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID,
	@Parameter01, @Parameter02, @Parameter03, @ApportionID, @Orders, @InheritTransactionID
	WHILE @@Fetch_Status = 0 
		BEGIN

			SET @InheritTransactionID_36 = NEWID()
			IF Isnull(@InheritTransactionID,'') = ''
			BEGIN 
				INSERT INTO MT0136 (DivisionID, TransactionID, ApportionID, ProductID, UnitID, ProductQuantity, Begin_ProductQuantity, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
							S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID, Parameter01, Parameter02, Parameter03, Orders)
				VALUES (@DivisionID, @TransactionID, @ApportionID, @ProductID, @UnitID, @ProductQuantity, @ProductQuantity, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
							@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID, @Parameter01, @Parameter02, @Parameter03, @Orders)
		
				UPDATE MT0176 
				SET InheritApportionID = @ApportionID,
					InheritTransactionID = @TransactionID
				WHERE TransactionID = @TransactionID AND DivisionID = @DivisionID AND VoucherID = @VoucherID
			END 
		
			INSERT INTO MT0137 (DivisionID, TransactionID, ProductID, ReTransactionID, MaterialID, MaterialUnitID, MaterialTypeID, Rate, ExpenseID, MaterialQuantity, MaterialPrice, MaterialAmount,
								RateDecimalApp, QuantityUnit, ConvertedUnit, [Description], DParameter01, DParameter02, DParameter03, 
								DS01ID, DS02ID, DS03ID, DS04ID, DS05ID, DS06ID, DS07ID, DS08ID, DS09ID, DS10ID, 
								DS11ID, DS12ID, DS13ID, DS14ID, DS15ID, DS16ID, DS17ID, DS18ID, DS19ID, DS20ID,
								Begin_MaterialQuantity, Begin_MaterialPrice, Begin_RateDecimalApp, Begin_MaterialAmount, Begin_QuantityUnit, Begin_ConvertedUnit, Orders)
			SELECT MT0177.DivisionID, MT0177.TransactionID, MT0176.ProductID, MT0176.InheritTransactionID, MaterialID, MaterialUnitID, MaterialTypeID, Rate, ExpenseID, MaterialQuantity, MaterialPrice, MaterialAmount,
								RateDecimalApp, QuantityUnit, ConvertedUnit, [Description], DParameter01, DParameter02, DParameter03, 
								DS01ID, DS02ID, DS03ID, DS04ID, DS05ID, DS06ID, DS07ID, DS08ID, DS09ID, DS10ID, 
								DS11ID, DS12ID, DS13ID, DS14ID, DS15ID, DS16ID, DS17ID, DS18ID, DS19ID, DS20ID,
								MaterialQuantity, MaterialPrice, RateDecimalApp, MaterialAmount, QuantityUnit, ConvertedUnit, MT0177.Orders
			FROM MT0177  WITH (NOLOCK)
			LEFT JOIN MT0176 WITH (NOLOCK) ON MT0176.DivisionID = MT0177.DivisionID AND MT0176.VoucherID = MT0177.VoucherID AND MT0176.TransactionID = MT0177.ReTransactionID
			WHERE MT0177.DivisionID = @DivisionID AND MT0177.ReTransactionID = @TransactionID AND MT0176.VoucherID = @VoucherID AND ISNULL(MT0177.InheritTransactionID,'') = ''
		
		
			UPDATE MT0177 
			SET InheritTransactionID = MT0176.InheritTransactionID	
			FROM MT0177 
			LEFT JOIN MT0176 ON MT0176.DivisionID = MT0177.DivisionID AND MT0176.VoucherID = MT0177.VoucherID AND MT0176.TransactionID = MT0177.ReTransactionID
			WHERE MT0177.DivisionID = @DivisionID AND MT0177.ReTransactionID = @TransactionID AND MT0176.VoucherID = @VoucherID AND ISNULL(MT0177.InheritTransactionID,'') = ''
		
		FETCH NEXT FROM @Cur INTO @DivisionID, @TransactionID, @VoucherID, @ProductID, @UnitID, @ProductQuantity, 
			@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
			@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID,
			@Parameter01, @Parameter02, @Parameter03, @ApportionID, @Orders, @InheritTransactionID
		END 
	CLOSE @Cur
END 
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
