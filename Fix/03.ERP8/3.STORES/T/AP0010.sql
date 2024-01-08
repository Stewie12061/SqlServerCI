IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Kiểm tra số lượng hàng kế thừa từ đơn hàng bán trước khi lưu hóa đơn bán hàng (ANGEL)

-- <History>
---- Created by Kim Thư on 28/08/2018

--EXEC AP0010 @DivisionID='ANG', @VoucherID='', @XML=N'<Data>
--			<InventoryID>BBGX150</InventoryID>
--			<Quantity>5</Quantity>
--			<TransactionID>9877270a-9829-4334-bfa4-43ed1f35e556</TransactionID>
--		  </Data>
--		  <Data>
--			<InventoryID>BBCN01</InventoryID>
--			<Quantity>1</Quantity>
--			<TransactionID>076b1471-83be-4d5e-aa72-4d1a9624c374</TransactionID>
--		  </Data>
--		  <Data>
--			<InventoryID>BBIOH</InventoryID>
--			<Quantity>2</Quantity>
--			<TransactionID></TransactionID>
--		  </Data>'


CREATE PROCEDURE [dbo].[AP0010] 
		@DivisionID nvarchar(50),
		@VoucherID nvarchar(50), --- Addnew   truyen ''; Load Edit :  so chung tu vua duoc chon sua
		@XML XML			
AS

DECLARE @Status TINYINT,
		@Param VARCHAR(50),
		@MessageID VARCHAR(50)

CREATE TABLE #AP0010 (InventoryID varchar(50), Quantity INT, OTransactionID VARCHAR(50))
INSERT INTO #AP0010 (InventoryID, Quantity, OTransactionID)
SELECT	X.Data.query('InventoryID').value('.', 'VARCHAR(50)') AS InventoryID,		
		X.Data.query('Quantity').value('.', 'DECIMAL(28,2)') AS Quantity,
		X.Data.query('OTransactionID').value('.', 'VARCHAR(50)') AS OTransactionID	
FROM	@XML.nodes('//Data') AS X (Data)

IF EXISTS (
	SELECT TOP 1 1
	FROM #AP0010 T1 INNER JOIN AT9000 T2 ON T2.DivisionID = @DivisionID AND T1.OTransactionID = T2.OTransactionID AND T1.InventoryID = T2.InventoryID
					INNER JOIN OT2002 T3 ON T1.OTransactionID = T3.TransactionID AND T3.DivisionID = @DivisionID
	WHERE T2.VoucherID <> @VoucherID
	GROUP BY T1.InventoryID, T1.OTransactionID, T1.Quantity, T3.OrderQuantity
	HAVING (T3.OrderQuantity-SUM(T2.Quantity))-T1.Quantity<0 -- (Tổng Slg có thể kế thừa - Số lượng đã kế thừa)-Số lượng cần kế thừa
)
BEGIN
	SET @Status=1
	SET @MessageID='WMFML000043'
	SET @Param = NULL
	GOTO EndMess
END

EndMess:
SELECT @Status as Status, @MessageID as MesageID, @Param as Param









