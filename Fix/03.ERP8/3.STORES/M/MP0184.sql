IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0184]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0184]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Xử lý dữ liệu khi bỏ duyệt đề nghị định mức (AN PHÁT - CustomizeIndex = 54)
-- <History>
---- Created by Tiểu Mai on 07/09/2016
---- Modified on ... by 
-- <Example>

/*
 * exec MP0181 'PC'
 */

CREATE PROCEDURE [dbo].[MP0184] 	
	@DivisionID NVARCHAR(50),
	@VoucherID NVARCHAR(50)
AS
DECLARE @IsApportionConfirm INT, @NumberSuggest INT, @ApportionID NVARCHAR(50), @VoucherID2 NVARCHAR(50)

 --------- Update trạng thái duyệt cho đề nghị
SET @IsApportionConfirm = ISNULL((SELECT IsApportionConfirm FROM MT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID),0)

IF @IsApportionConfirm = 1
BEGIN
	UPDATE MT0176 
	SET [Status] = 0
	WHERE DivisionID = @DivisionID
	AND Isnull(IsConfirm01,0) = 0
	AND VoucherID = @VoucherID
                                                                                          
END
ELSE IF @IsApportionConfirm = 2
BEGIN
	UPDATE MT0176 
	SET [Status] = 0
	WHERE DivisionID = @DivisionID
	AND ISNULL(IsConfirm02,0) = 0
	AND VoucherID = @VoucherID

END

IF EXISTS (SELECT TOP 1 1 FROM MT0176 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID AND ((
	@IsApportionConfirm = 1 AND ISNULL(MT0176.IsConfirm01,0) IN (0,2)) OR (@IsApportionConfirm = 2 and ISNULL(MT0176.IsConfirm02,0) IN (0,2)))
	)
BEGIN 
	--------- Lấy dữ liệu của đề nghị định mức kế cuối
	SET @ApportionID = (SELECT TOP 1 InheritApportionID FROM MT0176 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID )
	SET @NumberSuggest = (SELECT TOP 1 NumberSuggest FROM MT0176 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID)

	SET @VoucherID2 = (SELECT TOP 1 VoucherID FROM MT0176
	WHERE DivisionID = @DivisionID
	 AND InheritApportionID = @ApportionID
	 AND NumberSuggest < @NumberSuggest
	ORDER BY NumberSuggest DESC  )


	--------- Update lại dữ liệu cho bộ định mức gốc
	IF Isnull(@VoucherID2,'') <> ''
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
		AND MT0176.VoucherID = @VoucherID2

		UPDATE MT0136
		SET ProductQuantity = Isnull(MT0176.ProductQuantity,0)
		FROM MT0136
		LEFT JOIN MT0135 WITH (NOLOCK) ON MT0135.DivisionID = MT0136.DivisionID AND MT0135.ApportionID = MT0136.ApportionID
		LEFT JOIN MT0176 WITH (NOLOCK) ON MT0136.DivisionID = MT0135.DivisionID AND MT0136.ApportionID = MT0135.ApportionID AND MT0136.TransactionID = MT0176.InheritTransactionID
		LEFT JOIN MT0177 WITH (NOLOCK) ON MT0177.DivisionID = MT0176.DivisionID AND MT0177.VoucherID = MT0176.VoucherID AND MT0177.ReTransactionID = MT0176.TransactionID
		LEFT JOIN MT0137 WITH (NOLOCK) ON MT0137.DivisionID = MT0136.DivisionID AND MT0137.ReTransactionID = MT0136.TransactionID AND MT0137.TransactionID = MT0177.InheritTransactionID
		WHERE MT0176.DivisionID = @DivisionID
		AND MT0135.InheritVoucherID = MT0176.VoucherID
		AND Isnull(MT0176.[Status],0) = 1
		AND MT0176.VoucherID = @VoucherID2

		UPDATE MT0137
		SET MaterialQuantity = Isnull(MT0177.MaterialQuantity,0),
		MaterialPrice	=	Isnull(MT0177.MaterialPrice,0),
		RateDecimalApp	=	Isnull(MT0177.RateDecimalApp,0),
		MaterialAmount	=	Isnull(MT0177.MaterialAmount,0),
		QuantityUnit	=	Isnull(MT0177.QuantityUnit,0),
		ConvertedUnit	=	Isnull(MT0177.ConvertedUnit,0)
		FROM MT0137
		LEFT JOIN MT0136 WITH (NOLOCK) ON MT0136.DivisionID = MT0137.DivisionID AND MT0136.TransactionID = MT0137.ReTransactionID
		LEFT JOIN MT0135 WITH (NOLOCK) ON MT0135.DivisionID = MT0136.DivisionID AND MT0135.ApportionID = MT0136.ApportionID
		LEFT JOIN MT0176 WITH (NOLOCK) ON MT0136.DivisionID = MT0176.DivisionID AND MT0176.InheritApportionID = MT0136.ApportionID AND MT0176.InheritTransactionID = MT0136.TransactionID
		LEFT JOIN MT0177 WITH (NOLOCK) ON MT0177.DivisionID = MT0176.DivisionID AND MT0177.VoucherID = MT0176.VoucherID AND MT0177.ReTransactionID = MT0176.TransactionID AND MT0177.InheritTransactionID = MT0137.TransactionID
		WHERE MT0176.DivisionID = @DivisionID
		AND MT0135.InheritVoucherID = MT0176.VoucherID
		AND Isnull(MT0176.[Status],0) = 1
		AND MT0176.VoucherID = @VoucherID2

	END
	ELSE ---- Bỏ duyệt đề nghị đầu tiên
		BEGIN
			UPDATE MT0135 
			SET InheritVoucherID = NULL,
				LastModifyDate = MT0176.LastModifyDate,
				LastModifyUserID = MT0176.LastModifyUserID
			FROM MT0135
			LEFT JOIN MT0176 WITH (NOLOCK) ON MT0135.DivisionID = MT0176.DivisionID AND MT0135.ApportionID = MT0176.InheritApportionID
			LEFT JOIN MT0177 WITH (NOLOCK) ON MT0177.DivisionID = MT0176.DivisionID AND MT0177.VoucherID = MT0176.VoucherID AND MT0177.ReTransactionID = MT0176.TransactionID
			LEFT JOIN MT0136 WITH (NOLOCK) ON MT0136.DivisionID = MT0135.DivisionID AND MT0136.ApportionID = MT0135.ApportionID AND MT0136.TransactionID = MT0176.InheritTransactionID
			LEFT JOIN MT0137 WITH (NOLOCK) ON MT0137.DivisionID = MT0136.DivisionID AND MT0137.ReTransactionID = MT0136.TransactionID AND MT0137.TransactionID = MT0177.InheritTransactionID
			WHERE MT0176.DivisionID = @DivisionID
			AND MT0176.VoucherID = @VoucherID

			UPDATE MT0136
			SET ProductQuantity = Isnull(MT0176.Begin_ProductQuantity,0)
			FROM MT0136
			LEFT JOIN MT0135 WITH (NOLOCK) ON MT0135.DivisionID = MT0136.DivisionID AND MT0135.ApportionID = MT0136.ApportionID
			LEFT JOIN MT0176 WITH (NOLOCK) ON MT0136.DivisionID = MT0135.DivisionID AND MT0136.ApportionID = MT0135.ApportionID AND MT0136.TransactionID = MT0176.InheritTransactionID
			LEFT JOIN MT0177 WITH (NOLOCK) ON MT0177.DivisionID = MT0176.DivisionID AND MT0177.VoucherID = MT0176.VoucherID AND MT0177.ReTransactionID = MT0176.TransactionID
			LEFT JOIN MT0137 WITH (NOLOCK) ON MT0137.DivisionID = MT0136.DivisionID AND MT0137.ReTransactionID = MT0136.TransactionID AND MT0137.TransactionID = MT0177.InheritTransactionID
			WHERE MT0176.DivisionID = @DivisionID
			AND MT0135.InheritVoucherID = MT0176.VoucherID
			AND MT0176.VoucherID = @VoucherID

			UPDATE MT0137
			SET 
				MaterialQuantity	=	Isnull(MT0177.Begin_MaterialQuantity,0),
				MaterialPrice		=	Isnull(MT0177.Begin_MaterialPrice,0),
				RateDecimalApp		=	Isnull(MT0177.Begin_RateDecimalApp,0),
				MaterialAmount		=	Isnull(MT0177.Begin_MaterialAmount,0),
				QuantityUnit		=	Isnull(MT0177.Begin_QuantityUnit,0),
				ConvertedUnit		=	Isnull(MT0177.Begin_ConvertedUnit,0)
			FROM MT0137
			LEFT JOIN MT0136 WITH (NOLOCK) ON MT0136.DivisionID = MT0137.DivisionID AND MT0136.TransactionID = MT0137.ReTransactionID
			LEFT JOIN MT0135 WITH (NOLOCK) ON MT0135.DivisionID = MT0136.DivisionID AND MT0135.ApportionID = MT0136.ApportionID
			LEFT JOIN MT0176 WITH (NOLOCK) ON MT0136.DivisionID = MT0176.DivisionID AND MT0176.InheritApportionID = MT0136.ApportionID AND MT0176.InheritTransactionID = MT0136.TransactionID
			LEFT JOIN MT0177 WITH (NOLOCK) ON MT0177.DivisionID = MT0176.DivisionID AND MT0177.VoucherID = MT0176.VoucherID AND MT0177.ReTransactionID = MT0176.TransactionID AND MT0177.InheritTransactionID = MT0137.TransactionID
			WHERE MT0176.DivisionID = @DivisionID
			AND MT0135.InheritVoucherID = MT0176.VoucherID
			AND MT0176.VoucherID = @VoucherID
		END
END 

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
