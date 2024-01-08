IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0147_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0147_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- AP0147
-- <Summary>
---- Stored xử lý tạo dữ liệu hóa đơn điện tử
---- Created on 16/08/2017 Hải Long
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified on 21/09/2020 by Huỳnh Thử: Tạo dữ liệu hóa đơn cho trường hợp xuất kho
-- <Example>
---- EXEC AP0147 @DivisionID = 'SC',@UserID='ASOFTADMIN',@InvoiceCode='01GTKT',@Serial='AA/17E',@InvoiceNo='000001',@VoucherID='AV600bf5fd-f532-4d6f-a73b-6805f720b8bc'

CREATE PROCEDURE [dbo].[AP0147_AG]
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@InvoiceCode AS NVARCHAR(50),
	@Serial AS NVARCHAR(50),
	@InvoiceNo AS NVARCHAR(50),
	@VoucherID AS NVARCHAR(50)
AS
		
DECLARE @KindVoucherID INT 
SET @KindVoucherID = (SELECT KindVoucherID FROM AT2006 WHERE VoucherID = @VoucherID)
IF (@KindVoucherID = 3 or @KindVoucherID = 2)
BEGIN
	INSERT INTO AT1035 (DivisionID, VoucherID, TranMonth, TranYear, InvoiceCode, 
						InvoiceSign, Serial, 
						InvoiceNo, InvoiceDate, ObjectID, CurrencyID, ExchangeRate, 
						EInvoiceType, Description, VoucherTypeID, VoucherDate, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID,
					    IsLastEInvoice)
	SELECT DISTINCT A06.DivisionID, A06.VoucherID, A06.TranMonth, A06.Tranyear, (SELECT LEFT(InvoiceSign,6) FROM WT0000 WHERE WT0000.DefDivisionID = @DivisionID) AS InvoiceCode,
		(SELECT InvoiceSign FROM WT0000 WHERE WT0000.DefDivisionID = @DivisionID) AS InvoiceSign, (SELECT Serial FROM WT0000 WHERE WT0000.DefDivisionID = @DivisionID) AS Serial,
		@InvoiceNo, GETDATE(), A06.ObjectID, (SELECT TOP 1 CurrencyID FROM AT2007 WHERE VoucherID = A06.VoucherID) AS CurrencyID, (SELECT TOP 1 ExchangeRate FROM AT2007 WHERE VoucherID = A06.VoucherID) AS ExchangeRate,
		0, A06.Description, A06.VoucherTypeID, A06.VoucherDate, GETDATE(), @UserID, GETDATE(), @UserID,  
	    1
	FROM AT2006 A06 WITH (NOLOCK) INNER JOIN AT2007 A07 WITH (NOLOCK) ON A06.VoucherID = A07.VoucherID
	WHERE A06.DivisionID = @DivisionID
	AND A06.VoucherID = @VoucherID

	INSERT INTO AT1036 (DivisionID, VoucherID, TransactionID, InventoryID, UnitID, ConvertedQuantity, ConvertedPrice, OriginalAmount, ConvertedAmount, Orders)
	SELECT A07.DivisionID, A07.VoucherID, A07.TransactionID, A07.InventoryID, A07.UnitID, A07.ConvertedQuantity, A07.ConvertedPrice, A07.OriginalAmount, A07.ConvertedAmount, A07.Orders
	FROM AT2006 A06 WITH (NOLOCK) INNER JOIN AT2007 A07 WITH (NOLOCK) ON A06.VoucherID = A07.VoucherID
	WHERE A06.DivisionID = @DivisionID
	AND A06.VoucherID = @VoucherID
	
	Update AT2006
	SET AT2006.RefNo02 = @InvoiceNo
	FROM AT2006
	WHERE VoucherID = @VoucherID

END
ELSE
BEGIN
	UPDATE AT9000
	SET InvoiceNo = @InvoiceNo,
		InvoiceDate = CONVERT(DATE, GETDATE()),
		EInvoiceStatus = 1
	WHERE DivisionID = @DivisionID
	AND InvoiceSign = @InvoiceCode
	AND Serial = @Serial
	AND VoucherID = @VoucherID


	--Xóa dữ liệu
	DELETE FROM AT1035
	WHERE VoucherID = @VoucherID 

	DELETE FROM AT1036
	WHERE VoucherID = @VoucherID 

	-- Insert dữ liệu
	INSERT INTO AT1035 (DivisionID, VoucherID, TranMonth, TranYear, InvoiceCode, InvoiceSign, Serial, InvoiceNo, InvoiceDate, ObjectID, CurrencyID, ExchangeRate, 
						VATGroupID, VATRate, VATOriginalAmount, VATConvertedAmount, EInvoiceType, AT9000VoucherID, AT9000VoucherNo, Description, 
						VATTypeID, VATObjectID, VATDebitAccountID, VATCreditAccountID, VoucherTypeID, VoucherDate,
						CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
	SELECT AT9000.DivisionID, AT9000.VoucherID, AT9000.TranMonth, AT9000.TranYear, AT9000.InvoiceCode, AT9000.InvoiceSign, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.ObjectID,
	AT9000.CurrencyID, AT9000.ExchangeRate, 
	MAX(AT9000.VATGroupID) AS VATGroupID,
	MAX(VATRate) AS VATRate, 
	(SELECT OriginalAmount FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN ('T14','T35')) AS VATOriginalAmount,
	(SELECT ConvertedAmount FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN ('T14','T35')) AS VATConvertedAmount,
	0, AT9000.VoucherID, AT9000.VoucherNo, AT9000.VDescription, 
	VATTypeID, VATObjectID, 
	(SELECT DebitAccountID FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN ('T14','T35')) AS VATDebitAccountID,
	(SELECT CreditAccountID FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN ('T14','T35')) AS VATDebitAccountID,
	VoucherTypeID, VoucherDate,	
	GETDATE(), @UserID, GETDATE(), @UserID
	FROM AT9000 WITH (NOLOCK)
	LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
	WHERE AT9000.DivisionID = @DivisionID
	AND VoucherID = @VoucherID
	AND TransactionTypeID IN ('T04','T25')
	GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.VoucherNo, AT9000.TranMonth, AT9000.TranYear, AT9000.InvoiceCode, AT9000.InvoiceSign,
	AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.ObjectID, AT9000.CurrencyID, AT9000.ExchangeRate, AT9000.VDescription,
	VATTypeID, VATObjectID, VoucherTypeID, VoucherDate		


	INSERT INTO AT1036 (DivisionID, VoucherID, TransactionID, InventoryID, UnitID, ConvertedQuantity, ConvertedPrice, 
						DiscountRate, DiscountAmount, OriginalAmount, ConvertedAmount, AT9000VoucherID, AT9000TransactionID, DiscountSaleAmountDetail, Orders)
	SELECT AT9000.DivisionID, AT9000.VoucherID, AT9000.TransactionID, AT9000.InventoryID, AT9000.UnitID, AT9000.ConvertedQuantity, AT9000.ConvertedPrice, 
	AT9000.DiscountRate, AT9000.DiscountAmount, AT9000.OriginalAmount, AT9000.ConvertedAmount, AT9000.VoucherID, AT9000.TransactionID, AT9000.DiscountSaleAmountDetail, AT9000.Orders			
	FROM AT9000 WITH (NOLOCK)
	LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
	WHERE AT9000.DivisionID = @DivisionID
	AND VoucherID = @VoucherID
	AND TransactionTypeID IN ('T04','T25')

end


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
