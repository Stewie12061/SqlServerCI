IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0034]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0034]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Cập nhật đơn giá cho phiếu nhập kho khi lưu đơn hàng mua
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 21/01/2013 by Lê Thị Thi Thu Hiền
---- Modified on 22/07/2014 by Bảo Anh: Dùng bảng tạm thay AT9000 để cải thiện tốc độ
---- Modified on 06/11/2014 by Lê Thị Hạnh: Fix bug kế thừa nhiều phiếu nhập kho
---- Modified on 11/03/2015 by Lê Thị Hạnh: Bổ sung cập nhật giá có chi phí mua hàng khi phân bổ chi phí mua hàng [LAVO]
---- Modified on 24/05/2016 by Bảo Anh: Sửa lỗi cập nhật giá phiếu nhập sai khi kế thừa nhập kho lập phiếu mua hàng
---- Modified by Bảo Thy on 25/05/2016: Bổ sung WITH (NOLOCK)
---- Modified on 06/10/2016 by Hải Long: Bổ sung trường hợp tạo phiếu mua hàng nhập kho
---- Modified by Bảo Thy on 14/09/2016: Sửa cách lấy đơn giá cho phiếu nhập kho = đơn giá bình quân của các dòng trong phiếu mua hàng (trường hợp phiếu mua hàng kế thừa PNK)
---- Modified by Bảo Anh on 28/03/2018: Cộng thêm thuế TTĐB cho giá nhập kho
---- Modified by Nhựt Trường on 14/04/2021: Bổ sung làm tròn theo thiết lập ở trường hợp phiếu mua hàng kế thừa phiếu nhập kho, khi cập nhật giá có chi phí mua hàng AF0322.
---- Modified by Nhựt Trường on 11/05/2021: Bổ sung làm tròn đơn giá theo thiết lập (UnitCostDecimals) ở trường hợp phiếu mua hàng kế thừa phiếu nhập kho, khi cập nhật giá có chi phí mua hàng AF0322.
-- <Example>
/*
  exec AP0034 @DivisionID=N'MK',@VoucherID=N'TV620bb655-4042-4ead-abed-e77f70b00a3a'
*/
CREATE PROCEDURE AP0034
( 
		@DivisionID AS NVARCHAR(50),
		@VoucherID AS NVARCHAR(50)
) 
AS 

----- Lấy hệ số làm tròn
DECLARE @ConvertedDecimals AS TINYINT,
		@UnitCostDecimals AS TINYINT

SELECT TOP 1  @ConvertedDecimals = ConvertedDecimals FROM AT1101 WHERE DivisionID = @DivisionID
SELECT TOP 1  @UnitCostDecimals = UnitCostDecimals FROM AT1101 WHERE DivisionID = @DivisionID

DECLARE @PurchaseID AS NVARCHAR(50),
		@IsUpdatePrice AS TINYINT

SET @IsUpdatePrice = 0

----- Check Cập nhật giá cho phiếu nhập khi lưu phiếu mua hàng
SET @IsUpdatePrice = (SELECT TOP 1 IsUpdatePrice FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID)
SET @PurchaseID = ''
IF ISNULL (@IsUpdatePrice,0) = 1
BEGIN
--- Lấy mã phiếu nhập kho
SET @PurchaseID = (SELECT TOP 1 WOrderID FROM AT9000 WITH (NOLOCK) WHERE VoucherID = @VoucherID AND @DivisionID = @DivisionID AND ISNULL(WOrderID,'') <> '')

--- Lấy giá phiếu mua hàng
SELECT  InventoryID, WOrderID, WTransactionID, SUM(ConvertedAmount) ConvertedAmount, SUM(Quantity) Quantity,
		SUM(Isnull(ExpenseConvertedAmount,0)) as ExpenseConvertedAmount, SUM(Isnull(ImTaxConvertedAmount,0)) as ImTaxConvertedAmount, -- , UnitPrice,VoucherID,
		ISNULL((Select T90.ConvertedAmount FROM AT9000 T90 WITH (NOLOCK) Where T90.DivisionID = @DivisionID And T90.VoucherID = @VoucherID
		And T90.TransactionTypeID = 'T96' and T90.InventoryID = AT9000.InventoryID),0) as SpecialTaxConvertedAmount
INTO #TAM
FROM AT9000 WITH (NOLOCK)
WHERE AT9000.DivisionID = @DivisionID 
AND TransactionTypeID = 'T03'
AND EXISTS (SELECT TOP 1 1 FROM AT9000 T1 WITH (NOLOCK) 
			WHERE T1.DivisionID = @DivisionID AND T1.VoucherID = @VoucherID 
			AND T1.WOrderID = AT9000.WOrderID AND T1.WTransactionID = AT9000.WTransactionID)
GROUP BY InventoryID, WOrderID, WTransactionID

--SELECT DISTINCT A.InventoryID, A.Quantity, A.UnitPrice
--FROM AT9000 a WHERE a.VoucherID = @VoucherID AND ISNULL (a.WOrderID,'') <> ''

--UPDATE AT2007
--SET AT2007.UnitPrice = AT9000.UnitPrice,
--	AT2007.OriginalAmount = AT9000.UnitPrice * AT2007.ActualQuantity,
--	AT2007.ConvertedAmount = AT9000.UnitPrice * AT2007.ActualQuantity
--FROM AT2007 AT2007
--INNER JOIN #TAM AT9000
--		ON AT9000.WTransactionID = AT2007.TransactionID
--WHERE	AT2007.DivisionID = @DivisionID
--		AND AT2007.VoucherID = @PurchaseID

IF EXISTS (SELECT TOP 1 1 FROM AT0321 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND POVoucherID = @VoucherID)
	BEGIN -- Cập nhật giá có chi phí mua hàng AF0322


	-- Trường hợp phiếu mua hàng kế thừa phiếu nhập kho
	UPDATE AT27 SET
		UnitPrice = Round((ISNULL(#TAM.ConvertedAmount,0) + ISNULL(#TAM.ImTaxConvertedAmount,0) + ISNULL(#TAM.ExpenseConvertedAmount,0) + ISNULL(#TAM.SpecialTaxConvertedAmount,0))/ISNULL(#TAM.Quantity,1), @UnitCostDecimals),
		OriginalAmount = Round((ISNULL(#TAM.ConvertedAmount,0) + ISNULL(#TAM.ImTaxConvertedAmount,0) + ISNULL(#TAM.ExpenseConvertedAmount,0) + ISNULL(#TAM.SpecialTaxConvertedAmount,0))/ISNULL(#TAM.Quantity,1)*ISNULL(AT27.ActualQuantity,0), @ConvertedDecimals),
		ConvertedAmount = Round((ISNULL(#TAM.ConvertedAmount,0) + ISNULL(#TAM.ImTaxConvertedAmount,0) + ISNULL(#TAM.ExpenseConvertedAmount,0) + ISNULL(#TAM.SpecialTaxConvertedAmount,0))/ISNULL(#TAM.Quantity,1)*ISNULL(AT27.ActualQuantity,0), @ConvertedDecimals),
		ConvertedPrice = Round((ISNULL(#TAM.ConvertedAmount,0) + ISNULL(#TAM.ImTaxConvertedAmount,0) + ISNULL(#TAM.ExpenseConvertedAmount,0) + ISNULL(#TAM.SpecialTaxConvertedAmount,0))/ISNULL(#TAM.Quantity,1), @UnitCostDecimals)
	FROM AT2007 AT27 
	INNER JOIN AT2006 AT26 WITH (NOLOCK) ON AT26.DivisionID = AT27.DivisionID AND AT26.VoucherID = AT27.VoucherID
	INNER JOIN #TAM ON #TAM.WOrderID = AT27.VoucherID AND #TAM.WTransactionID = AT27.TransactionID
	WHERE AT27.DivisionID = @DivisionID 
		  --AND AT27.VoucherID IN (SELECT DISTINCT WOrderID FROM #TAM)
								 --FROM AT9000  WITH (NOLOCK)
						   --      WHERE AT9000.DivisionID = @DivisionID AND AT9000.VoucherID = @VoucherID AND ISNULL(WOrderID,'') <> '')
						         
	-- Trường hợp tạo phiếu mua hàng nhập kho
	UPDATE AT2007 SET
		UnitPrice = ROUND((ISNULL(AT9000.ConvertedAmount,0) + ISNULL(AT9000.ExpenseConvertedAmount,0) + ISNULL(AT9000.ImTaxConvertedAmount,0) + ISNULL(AT9000.SpecialTaxConvertedAmount,0))/ISNULL(AT9000.Quantity,1), AT1101.UnitCostDecimals),
		OriginalAmount = ROUND(((ISNULL(AT9000.ConvertedAmount,0) + ISNULL(AT9000.ExpenseConvertedAmount,0) + ISNULL(AT9000.ImTaxConvertedAmount,0) + ISNULL(AT9000.SpecialTaxConvertedAmount,0))/ISNULL(AT9000.Quantity,1)) * ISNULL(AT2007.ActualQuantity,0), AT1101.ConvertedDecimals),
		ConvertedAmount = ROUND(((ISNULL(AT9000.ConvertedAmount,0) + ISNULL(AT9000.ExpenseConvertedAmount,0) + ISNULL(AT9000.ImTaxConvertedAmount,0) + ISNULL(AT9000.SpecialTaxConvertedAmount,0))/ISNULL(AT9000.Quantity,1)) * ISNULL(AT2007.ActualQuantity,0), AT1101.ConvertedDecimals),
		ConvertedPrice = ROUND((ISNULL(AT9000.ConvertedAmount,0) + ISNULL(AT9000.ExpenseConvertedAmount,0) + ISNULL(AT9000.ImTaxConvertedAmount,0) + ISNULL(AT9000.SpecialTaxConvertedAmount,0))/ISNULL(AT9000.Quantity,1), AT1101.UnitCostDecimals)
	FROM AT2007 
	INNER JOIN (SELECT	DivisionID, VoucherID, TransactionID, InventoryID, ConvertedAmount, ExpenseConvertedAmount, ImTaxConvertedAmount, Quantity,
						ISNULL((Select T90.ConvertedAmount FROM AT9000 T90 WITH (NOLOCK) Where T90.DivisionID = @DivisionID And T90.VoucherID = AT9000.VoucherID
								And T90.TransactionTypeID = 'T96' and T90.InventoryID = AT9000.InventoryID),0) as SpecialTaxConvertedAmount
				FROM AT9000 WITH (NOLOCK)
				WHERE AT9000.DivisionID = @DivisionID AND AT9000.VoucherID = @VoucherID AND AT9000.TransactionTypeID = 'T03'
				) AT9000 ON AT9000.DivisionID = AT2007.DivisionID AND AT9000.VoucherID = AT2007.VoucherID AND AT9000.TransactionID = AT2007.TransactionID
	LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AT2007.DivisionID
	END
ELSE
	BEGIN	

	--select AT2007.transactionID,AT2007.inventoryid, AT2007.actualquantity, AT2007.originalamount, AT2007.unitprice
	--FROM AT2007 AT2007
	--INNER JOIN #TAM ON #TAM.WOrderID = AT2007.VoucherID AND #TAM.WTransactionID = AT2007.TransactionID
	--LEFT JOIN	AT1101 A WITH (NOLOCK) ON A.DivisionID = AT2007.DivisionID
	--WHERE	AT2007.DivisionID = @DivisionID
	--		AND AT2007.VoucherID IN (SELECT DISTINCT WOrderID FROM #TAM)
	--	  order by  AT2007.inventoryid

	UPDATE AT2007
	SET AT2007.UnitPrice = ROUND((#TAM.ConvertedAmount + #TAM.ExpenseConvertedAmount + #TAM.ImTaxConvertedAmount + #TAM.SpecialTaxConvertedAmount)/ISNULL(#TAM.Quantity,1), A.UnitCostDecimals),
		AT2007.OriginalAmount = ROUND(((#TAM.ConvertedAmount + #TAM.ExpenseConvertedAmount + #TAM.ImTaxConvertedAmount + #TAM.SpecialTaxConvertedAmount)/ISNULL(#TAM.Quantity,1)) * AT2007.ActualQuantity,A.ConvertedDecimals),
		AT2007.ConvertedAmount = ROUND(((#TAM.ConvertedAmount + #TAM.ExpenseConvertedAmount + #TAM.ImTaxConvertedAmount + #TAM.SpecialTaxConvertedAmount)/ISNULL(#TAM.Quantity,1)) * AT2007.ActualQuantity,A.ConvertedDecimals)
	FROM AT2007 AT2007
	INNER JOIN #TAM ON #TAM.WOrderID = AT2007.VoucherID AND #TAM.WTransactionID = AT2007.TransactionID
	LEFT JOIN	AT1101 A WITH (NOLOCK) ON A.DivisionID = AT2007.DivisionID
	WHERE	AT2007.DivisionID = @DivisionID
			--AND AT2007.VoucherID IN (SELECT DISTINCT WOrderID FROM #TAM)
			--(SELECT WOrderID FROM AT9000 WITH (NOLOCK) WHERE VoucherID = @VoucherID AND @DivisionID = @DivisionID AND ISNULL(WOrderID,'') <> '')
	END
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
