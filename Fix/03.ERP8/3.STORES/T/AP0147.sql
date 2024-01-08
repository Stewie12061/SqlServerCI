IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0147]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0147]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- AP0147
-- <Summary>
---- Stored xử lý tạo dữ liệu hóa đơn điện tử
---- Created on 16/08/2017 Hải Long
---- Modified on 07/11/2018 by Kim Thư: Lưu thêm cột InvoiceGuid - mã hóa đơn điện tử BKAV phát hành
---- Modified on 09/11/2018 by Kim Thư: Lưu thêm cột DiscountedUnitPrice và ConvertedDiscountedUnitPrice tính đơn giá sau khi đã chiết khấu
---- Modified on 03/12/2018 by Kim Thư: Lưu thêm cột InvoicePublishDate - lưu ngày phát hành hóa đơn (Phân biệt với InvoiceDate - Phúc Long)
---- Modified on 11/12/2018 by Kim Thư: Bổ sung lưu cột IsLastEInvoice - Hóa đơn phát hành mới nhất
----									Lưu hóa đơn từ phiếu VCNB - CustomerIndex=16 - Siêu Thanh
---- Modified on 28/1/2019 by Kim Thư:Lấy thông tin số hóa đơn vào RefNo02
---- Modified on 21/2/2019 by Kim Thư: Bổ sung cho insert hóa đơn chiết khấu T64
---- Modified on 21/3/2019 by Kim Thư: Cập nhật thông tin chi nhánh vào hóa đơn đã phát hành thành công	
---- Modified on 23/04/2019 by Kim Thư: Sửa insert vào AT1035 lấy tổng tiền thuế do có trường hợp hóa đơn nhiều nhóm thuế
---- Modified on 26/04/2019 by Kim Thư: Nếu là Seabornes thì ko update ngày phát hành vào ngày hóa đơn (giống Phúc Long)
---- Modified on 28/05/2019 by Kim Thư: Cập nhật thông tin chi nhánh đưa vào câu insert AT1035
---- Modified on 01/07/2019 by Kim Thư: Không update ngày phát hành vào ngày hóa đơn (Phúc Long, Seabornes, Koyo)
---- Modified on 31/07/2019 by Văn Tài: Không update ngày phát hành vào ngày hóa đơn (FUYUEH)
---- Modified on 04/09/2019 by Văn Tài: Không update ngày phát hành vào ngày hóa đơn (GODREJ) : 74
---- Modified on 28/11/2019 by Văn Tài: Không update ngày phát hành vào ngày hóa đơn (SEAHORSE) : 100
---- Modified on 27/12/2019 by Văn Tài: Không update ngày phát hành vào ngày hóa đơn (SONGBINH) : 110
---- Modified on 05/03/2020 by Văn Minh: Không update ngày phát hành vào ngày hóa đơn (LIENBANG) : 122
---- Modified on 10/03/2020 by Huỳnh Thử: Không update ngày phát hành vào ngày hóa đơn (KAJIMA) : 94
---- Modified on 21/10/2020 by Hoài Phong: Bổ sung insert TableID Cho AT1035
---- Modified on 13/11/2020 by Hoài Phong: không cho update ngày hiện ngày khi phát hàng hóa đơn điện tử TECHNO
---- Modified on 01/12/2020 by Hoài Phong: Nếu là BKAV thì k có update ngày hóa đơn bằng ngày hiện hành
---- Modified on 16/12/2020 by Huỳnh Thử: Insert Phiếu VCNB vào AT1035 và AT1036 đưa vào chuẩn
---- Modified on 21/01/2021 by Hoài Phong: KH Phúc Long Dùng hóa đơn điện tử VNPT thì k cho update ngày hiện hành
---- Modified on 21/01/2021 by Đức Thông: [Siêu Thanh] 2021/01/IS/0311: Bổ sung dữ liệu HDDT cho phiếu xuất
---- Modified on 11/08/2014 by 
---- Modified on 22/12/2020 by Đức Thông: 2020/12/IS/0472: SIEUTHANH: Fix lỗi lấy đối tác phát hành bị lỗi do khách có nhiều division
---- Modified on 03/02/2021 by Văn Tài: Loại bỏ KindVoucherID = 4 và khách hàng SIEUTHANH mới dùng KindVoucherID = 2.
---- Modified on 08/03/2021 by Huỳnh Thử: [KoYo] Không update EInvoiceStatus = 1 Update vào lấy số hóa đơn
---- Modified on 18/02/2022 by Xuân Nguyên: [2022/02/IS/0061] [Bình Tây] Bổ sung ISNULL cho điều kiện Serial và InvoiceSign
---- Modified on 28/02/2022 by Nhật Thanh: [Siêu Thanh] Bổ sung cột người vận chuyển cho phiếu xuất kho và vcnb
---- Modified on 16/03/2022 by Nhựt Trường: Bổ sung TransactionTypeID thuộc 'T34'.
---- Modified on 20/05/2022 by Nhật Thanh: Fei thì không update ngày hóa đơn AT9000
---- Modified on 08/06/2022 by Nhật Thanh: Xóa dữ liệu trước khi insert cho phiếu VCNB
-- <Example>
---- EXEC AP0147 @DivisionID = 'SC',@UserID='ASOFTADMIN',@InvoiceCode='01GTKT',@Serial='AA/17E',@InvoiceNo='000001',@VoucherID='AV600bf5fd-f532-4d6f-a73b-6805f720b8bc'



CREATE PROCEDURE [dbo].[AP0147]
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@InvoiceCode AS NVARCHAR(50),
	@Serial AS NVARCHAR(50),
	@InvoiceNo AS NVARCHAR(50),
	@VoucherID AS NVARCHAR(50),
	@InvoiceGuid AS VARCHAR(MAX),
	@BranchID AS NVARCHAR(50)
AS
DECLARE @CustomerName INT, 
		@KindVoucherID TINYINT = 0,
		@EInvoicePartner NVARCHAR(50)

SET @EInvoicePartner = (SELECT TOP 1 EInvoicePartner FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID)
SET @CustomerName = (SELECT CustomerName FROM CustomerIndex WITH (NOLOCK))
SET @KindVoucherID = (SELECT KindVoucherID FROM AT2006 WITH (NOLOCK) WHERE VoucherID = @VoucherID)

IF (@KindVoucherID = 3 OR (@KindVoucherID = 2 AND @CustomerName = 16)) -- Hiện tại chỉ có khách hàng SIEUTHANH xử lý theo luồng KindVoucherID = 2.
BEGIN
	--Xóa dữ liệu
	DELETE FROM AT1035
	WHERE VoucherID = @VoucherID 

	DELETE FROM AT1036
	WHERE VoucherID = @VoucherID 
	INSERT INTO AT1035 (DivisionID, VoucherID, TranMonth, TranYear, InvoiceCode, 
						InvoiceSign, Serial, 
						InvoiceNo, InvoiceDate, ObjectID, CurrencyID, ExchangeRate, 
						EInvoiceType, Description, VoucherTypeID, VoucherDate, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID,
						InvoiceGuid, InvoicePublishDate, IsLastEInvoice,Transportation)
	SELECT DISTINCT A06.DivisionID, A06.VoucherID, A06.TranMonth, A06.Tranyear, (SELECT LEFT(InvoiceSign,6) FROM WT0000 WHERE WT0000.DefDivisionID = @DivisionID) AS InvoiceCode,
		(SELECT InvoiceSign FROM WT0000 WHERE WT0000.DefDivisionID = @DivisionID) AS InvoiceSign, (SELECT Serial FROM WT0000 WHERE WT0000.DefDivisionID = @DivisionID) AS Serial,
		@InvoiceNo, GETDATE(), A06.ObjectID, (SELECT TOP 1 CurrencyID FROM AT2007 WHERE VoucherID = A06.VoucherID) AS CurrencyID, (SELECT TOP 1 ExchangeRate FROM AT2007 WHERE VoucherID = A06.VoucherID) AS ExchangeRate,
		0, A06.Description, A06.VoucherTypeID, A06.VoucherDate, GETDATE(), @UserID, GETDATE(), @UserID,  
		@InvoiceGuid, GETDATE(), 1,Transportation
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
	-- Nếu không phải: Phúc Long, Seaborne, Koyo, FUYUEH, GODREJ, SEAHORSE, SONGBINH, LIENBANG, KAJIMA,TECHNO
	-- thì lấy ngày phát hành làm InvoiceDate 
	--IF @CustomerName NOT IN (32, 109, 52, 61, 74, 100, 110, 122, 94,127) 	
	
	IF @EInvoicePartner not in ('BKAV','EASY')
		IF @CustomerName = 16 
			UPDATE AT9000
			SET InvoiceNo = @InvoiceNo,
				InvoiceDate = CONVERT(DATE, GETDATE()),
				EInvoiceStatus = 1,
				InvoiceGuid = @InvoiceGuid,
				RefNo02 = @InvoiceNo
			WHERE DivisionID = @DivisionID
			AND InvoiceSign = @InvoiceCode
			AND Serial = @Serial
			AND VoucherID = @VoucherID
		ELSE IF @CustomerName in (61,32) --Nếu Phúc Lúc, Fei Thì không cần update ngày hóa đơn
			UPDATE AT9000
			SET InvoiceNo = @InvoiceNo,				
				EInvoiceStatus = 1,
				InvoiceGuid = @InvoiceGuid
			WHERE DivisionID = @DivisionID
			AND InvoiceSign = @InvoiceCode
			AND Serial = @Serial
			AND VoucherID = @VoucherID
	     ELSE
			UPDATE AT9000
			SET InvoiceNo = @InvoiceNo,
				InvoiceDate = CONVERT(DATE, GETDATE()),
				EInvoiceStatus = 1,
				InvoiceGuid = @InvoiceGuid
			WHERE DivisionID = @DivisionID
			AND InvoiceSign = @InvoiceCode
			AND Serial = @Serial
			AND VoucherID = @VoucherID

	ELSE
	BEGIN
		IF @CustomerName = 52 -- KoYo
		BEGIN
		    UPDATE AT9000
			SET InvoiceNo = @InvoiceNo,
				EInvoiceStatus = 0,
				InvoiceGuid = @InvoiceGuid
			WHERE DivisionID = @DivisionID
			AND ISNULL(InvoiceSign,'') lIKE @InvoiceCode
			AND ISNULL(Serial,'') LIKE @Serial
			AND VoucherID = @VoucherID		
		END
		ELSE
        BEGIN
			UPDATE AT9000
			SET InvoiceNo = @InvoiceNo,
				EInvoiceStatus = 1,
				InvoiceGuid = @InvoiceGuid
			WHERE DivisionID = @DivisionID
			AND ISNULL(InvoiceSign,'') lIKE @InvoiceCode
			AND ISNULL(Serial,'') LIKE @Serial
			AND VoucherID = @VoucherID		
		END 
	END
    
		

	--Xóa dữ liệu
	DELETE FROM AT1035
	WHERE VoucherID = @VoucherID 

	DELETE FROM AT1036
	WHERE VoucherID = @VoucherID 

	-- Insert dữ liệu
	INSERT INTO AT1035 (DivisionID, VoucherID, TranMonth, TranYear, InvoiceCode, InvoiceSign, Serial, InvoiceNo, InvoiceDate, ObjectID, CurrencyID, ExchangeRate, 
						VATGroupID, VATRate, VATOriginalAmount, VATConvertedAmount, EInvoiceType, AT9000VoucherID, AT9000VoucherNo, Description, 
						VATTypeID, VATObjectID, VATDebitAccountID, VATCreditAccountID, VoucherTypeID, VoucherDate,
						CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, InvoiceGuid, InvoicePublishDate, IsLastEInvoice, BranchID,TableID)
	SELECT AT9000.DivisionID, AT9000.VoucherID, AT9000.TranMonth, AT9000.TranYear, AT9000.InvoiceCode, AT9000.InvoiceSign, AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.ObjectID,
	AT9000.CurrencyID, AT9000.ExchangeRate, 
	MAX(AT9000.VATGroupID) AS VATGroupID,
	MAX(VATRate) AS VATRate, 
	(SELECT SUM(OriginalAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN ('T14','T35','T34')) AS VATOriginalAmount,
	(SELECT SUM(ConvertedAmount) FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN ('T14','T35','T34')) AS VATConvertedAmount,
	0, AT9000.VoucherID, AT9000.VoucherNo, AT9000.BDescription, 
	VATTypeID, VATObjectID, 
	(SELECT TOP 1 DebitAccountID FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN ('T14','T35','T34')) AS VATDebitAccountID,
	(SELECT TOP 1 CreditAccountID FROM AT9000 AT90 WITH (NOLOCK) WHERE AT90.VoucherID = AT9000.VoucherID AND TransactionTypeID IN ('T14','T35','T34')) AS VATDebitAccountID,
	VoucherTypeID, VoucherDate,	
	GETDATE(), @UserID, GETDATE(), @UserID, AT9000.InvoiceGuid, CONVERT(DATE, GETDATE()), 1, CASE WHEN @CustomerName = 110 THEN AT9000.BranchID ELSE @BranchID END,
	 AT9000.TableID
	FROM AT9000 WITH (NOLOCK)
	LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
	WHERE AT9000.DivisionID = @DivisionID
	AND VoucherID = @VoucherID
	AND TransactionTypeID IN ('T04','T25','T64', 'T24')
	GROUP BY AT9000.DivisionID, AT9000.VoucherID, AT9000.VoucherNo, AT9000.TranMonth, AT9000.TranYear, AT9000.InvoiceCode, AT9000.InvoiceSign,
	AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.ObjectID, AT9000.CurrencyID, AT9000.ExchangeRate, AT9000.BDescription,
	VATTypeID, VATObjectID, VoucherTypeID, VoucherDate, AT9000.InvoiceGuid,AT9000.BranchID,AT9000.TableID


	INSERT INTO AT1036 (DivisionID, VoucherID, TransactionID, InventoryID, UnitID, ConvertedQuantity, ConvertedPrice, 
						DiscountRate, DiscountAmount, OriginalAmount, ConvertedAmount, AT9000VoucherID, AT9000TransactionID, DiscountSaleAmountDetail, Orders, DiscountedUnitPrice, ConvertedDiscountedUnitPrice)
	SELECT AT9000.DivisionID, AT9000.VoucherID, AT9000.TransactionID, AT9000.InventoryID, AT9000.UnitID, AT9000.ConvertedQuantity, AT9000.ConvertedPrice, 
	AT9000.DiscountRate, AT9000.DiscountAmount, AT9000.OriginalAmount, AT9000.ConvertedAmount, AT9000.VoucherID, AT9000.TransactionID, AT9000.DiscountSaleAmountDetail, AT9000.Orders, AT9000.DiscountedUnitPrice, AT9000.ConvertedDiscountedUnitPrice			
	FROM AT9000 WITH (NOLOCK)
	LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID
	WHERE AT9000.DivisionID = @DivisionID
	AND VoucherID = @VoucherID
	AND TransactionTypeID IN ('T04','T25','T64', 'T24')

END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO