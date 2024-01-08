IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP00341]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OP00341]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Create on 15/07/2019 by Kim Thư: Kiểm tra nếu 1 đơn hàng sau khi duyệt sinh ra nhiều hóa đơn bán hàng, phiếu xuất kho thì tự động xóa bớt, chỉ chừa lại 1 hóa đơn - 1 phiếu xuất

---- Example: EXEC OP00341 @DivisionID='MP', @UserID='ASOFTADMIN', @SOrderID='XO/05/2019/0124'
CREATE PROCEDURE [DBO].[OP00341]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50) = '',	
	@SOrderID AS NVARCHAR(250)
) 
AS
SET NOCOUNT ON

DECLARE @VoucherID VARCHAR(50)

-- Chọn phiếu bán hàng đc tạo gần nhất để giữ lại
SET @VoucherID = (SELECT TOP 1 AT9000.VoucherID FROM AT9000 WITH(NOLOCK) INNER JOIN AT2006 WITH(NOLOCK) ON AT9000.VoucherID = AT2006.VoucherID and AT2006.KindVoucherID=4
					WHERE AT9000.OrderID = @SOrderID ORDER BY AT9000.CreateDate DESC)

-- Xóa phiếu bán hàng dư
DELETE AT9000
WHERE DivisionID=@DivisionID AND OrderID = @SOrderID AND VoucherID <> @VoucherID

-- Xóa những phiếu xuất kho dư
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	DELETE WT8899
	FROM AT2007 WITH(NOLOCK) INNER JOIN WT8899 WITH(NOLOCK) ON AT2007.VoucherID = WT8899.VoucherID AND AT2007.TransactionID = WT8899.TransactionID
	WHERE AT2007.OrderID=@SOrderID AND AT2007.VoucherID <> @VoucherID

DELETE AT2007
WHERE DivisionID=@DivisionID AND OrderID = @SOrderID AND VoucherID <> @VoucherID

DELETE AT2006
WHERE DivisionID=@DivisionID AND OrderID = @SOrderID AND VoucherID <> @VoucherID AND KindVoucherID=4






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO