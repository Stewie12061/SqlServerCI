IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1309_AG3_All]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1309_AG3_All]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--------- Created by Huỳnh Thử on 05/05/2020: Tách riêng store cho Angel, Tính giá all kho

CREATE PROCEDURE [dbo].[AP1309_AG3_All]
	@DivisionID NVARCHAR(50), 
    @TranMonth INT, 
    @TranYear INT,
	@FromInventoryID NVARCHAR(50), 
    @ToInventoryID NVARCHAR(50)
AS

DECLARE 
    @CountUpdate INT,
    @TableID NVARCHAR(50),
    @InheritTransactionID NVARCHAR(50),
    @InheritVoucherID NVARCHAR(50),
    @InheritImTransactionID NVARCHAR(50)

IF OBJECT_ID('tempdb..#TAM1') IS NOT NULL
    DROP TABLE #TAM1

IF OBJECT_ID('tempdb..#TAM2') IS NOT NULL
    DROP TABLE #TAM2

IF OBJECT_ID('tempdb..#TAM3') IS NOT NULL
    DROP TABLE #TAM3

CREATE TABLE #TAM1
(
	InventoryID NVARCHAR(50),
	KindVoucherID TINYINT,
	TableID NVARCHAR(50),
	AccountID NVARCHAR(50),
	TransactionID NVARCHAR(50),
	InheritVoucherID NVARCHAR(50),
	InheritTransactionID NVARCHAR(50),
	ConvertedAmount DECIMAL(28)
)

CREATE TABLE #TAM2
(
	KindVoucherID TINYINT,
	InventoryID NVARCHAR(50),
	TableID NVARCHAR(50),
	AccountID NVARCHAR(50),
	TransactionID NVARCHAR(50),
	InheritVoucherID NVARCHAR(50),
	InheritTransactionID NVARCHAR(50),
	Orders INT
)

CREATE TABLE #TAM3
(
	InheritImTransactionID NVARCHAR(50),
	VoucherID NVARCHAR(50),
	EndAmount DECIMAL(28),
	Orders INT
)

Recal:
	DELETE FROM #TAM1
	DELETE FROM #TAM2
	DELETE FROM #TAM3

	INSERT INTO #TAM1 (InventoryID, KindVoucherID, TableID, AccountID, TransactionID, InheritVoucherID, InheritTransactionID, ConvertedAmount)
	SELECT	InventoryID,KindVoucherID, TableID, CreditAccountID AS AccountID, TransactionID, InheritVoucherID, InheritTransactionID,ConvertedAmount
	FROM AT20072 WITH (NOLOCK)
	WHERE KindVoucherID IN (2, 3, 4, 6, 8,7)
		AND ISNULL(IsNotUpdatePrice,0) = 0
		AND NOT EXISTS (SELECT 1 FROM AT0112 WITH (NOLOCK) WHERE DivisionID = AT20072.DivisionID AND VoucherID = AT20072.InheritVoucherID AND [Type] = 1)
		AND EXISTS (Select 1 From AT20082 WITH (NOLOCK)
					Where EndQuantity = 0 And EndAmount <> 0 And CreditQuantity <> 0 And InventoryID = AT20072.InventoryID And InventoryAccountID = AT20072.CreditAccountID
					)
	
	--- Tìm phiếu xuất có số tiền lớn nhất để làm tròn
	INSERT INTO #TAM2 (KindVoucherID, InventoryID, AccountID, TransactionID, TableID, InheritVoucherID, InheritTransactionID, Orders)
	SELECT 0 as KindVoucherID, A.*
	FROM
	(
		SELECT	InventoryID, AccountID, TransactionID, TableID, InheritVoucherID, InheritTransactionID,
				ROW_NUMBER() OVER (partition by InventoryID, AccountID Order by ConvertedAmount DESC, TransactionID) AS Orders	
		FROM #TAM1
		WHERE KindVoucherID <> 3
	) A
	WHERE Orders = 1
	
	--- Tìm phiếu VCNB có số tiền lớn nhất để làm tròn	
	INSERT INTO #TAM2 (KindVoucherID, InventoryID, AccountID, TransactionID, TableID, InheritVoucherID, InheritTransactionID, Orders)
	SELECT 1 as KindVoucherID, A.* FROM
	(
		SELECT InventoryID, AccountID, TransactionID, TableID, InheritVoucherID, InheritTransactionID,
				ROW_NUMBER() OVER (partition by InventoryID, AccountID Order by ConvertedAmount DESC, TransactionID) AS Orders	
		FROM #TAM1
		WHERE KindVoucherID = 3
		AND NOT EXISTS (Select 1 From #TAM2 Where InventoryID = #TAM1.InventoryID 
						And AccountID = #TAM1.AccountID And KindVoucherID = 0)
	) A
	WHERE Orders = 1

	-------------- Update về phiếu lắp ráp, tháo dỡ phần xuất kho
	UPDATE AT0113
	SET OriginalAmount = ISNULL(OriginalAmount, 0) + T08.EndAmount,
		ConvertedAmount = ConvertedAmount + T08.EndAmount
	FROM AT0113 WITH (ROWLOCK)
	INNER JOIN (Select * From #TAM2	Where ISNULL(TableID,'') = 'AT0112') AT2007
		ON DivisionID = @DivisionID AND AT0113.VoucherID = AT2007.InheritVoucherID AND AT0113.TransactionID = AT2007.InheritTransactionID
	INNER JOIN (Select InventoryID, InventoryAccountID, EndAmount From AT20082 WITH (NOLOCK) 
				Where EndQuantity = 0 And EndAmount <> 0) T08
		ON AT2007.InventoryID = T08.InventoryID And AT2007.AccountID = T08.InventoryAccountID
	
	-------------- Update về phiếu lắp ráp, tháo dỡ phần nhập kho
	INSERT INTO #TAM3 (InheritImTransactionID, VoucherID, EndAmount, Orders)
	SELECT	AT0113.TransactionID as InheritImTransactionID, AT0113.VoucherID, T08.EndAmount,
			ROW_NUMBER() OVER (partition by AT0113.VoucherID Order by AT0113.ConvertedAmount DESC) AS Orders
	FROM AT0113 WITH (NOLOCK)
	INNER JOIN #TAM2 ON AT0113.DivisionID = @DivisionID AND AT0113.VoucherID = #TAM2.InheritVoucherID AND AT0113.KindVoucherID = 1
	INNER JOIN (Select InventoryID, InventoryAccountID, EndAmount From AT20082 WITH (NOLOCK) 
				Where EndQuantity = 0 And EndAmount <> 0) T08
		ON #TAM2.InventoryID = T08.InventoryID And #TAM2.AccountID = T08.InventoryAccountID

	DELETE #TAM3 WHERE Orders > 1

	UPDATE AT0113
	SET OriginalAmount = ISNULL(OriginalAmount, 0) + #TAM3.EndAmount,
		ConvertedAmount = ConvertedAmount + #TAM3.EndAmount
	FROM AT0113 WITH (ROWLOCK)
	INNER JOIN #TAM3 ON AT0113.KindVoucherID = 1 AND AT0113.VoucherID = #TAM3.VoucherID AND AT0113.TransactionID = #TAM3.InheritImTransactionID
	
	-------------- Update về phần nhập kho ở kho (phiếu lắp ráp, tháo dỡ bắn qua)
	UPDATE AT2007
	SET ConvertedAmount = Isnull(ConvertedAmount,0) + #TAM3.EndAmount,
		OriginalAmount = Isnull(OriginalAmount,0) + #TAM3.EndAmount
	FROM AT20072 AT2007 WITH (ROWLOCK)
	INNER JOIN #TAM3 ON AT2007.DivisionID = @DivisionID AND AT2007.InheritVoucherID = #TAM3.VoucherID AND AT2007.InheritTransactionID = #TAM3.InheritImTransactionID AND AT2007.InheritTableID = 'AT0112'
	
	--- Làm tròn phiếu xuất/VCNB
	UPDATE T07
	SET T07.ConvertedAmount = ISNULL(T07.ConvertedAmount,0) + T08.EndAmount,
		T07.OriginalAmount = ISNULL(T07.OriginalAmount,0) + T08.EndAmount
	FROM AT20072 T07 WITH (ROWLOCK)
	INNER JOIN #TAM2 T2 WITH (NOLOCK) ON T07.TransactionID = T2.TransactionID
	INNER JOIN (Select InventoryID, InventoryAccountID, EndAmount From AT20082 WITH (NOLOCK) 
				Where EndQuantity = 0 And EndAmount <> 0) T08
		ON T2.InventoryID = T08.InventoryID And T2.AccountID = T08.InventoryAccountID

--IF EXISTS 
--(
--    SELECT TOP 1 1 
--    FROM AT20082 WITH (NOLOCK)
--    WHERE EndQuantity = 0 
--        AND EndAmount <> 0
--		And CreditQuantity <> 0
--)
	--GOTO ReCal




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
