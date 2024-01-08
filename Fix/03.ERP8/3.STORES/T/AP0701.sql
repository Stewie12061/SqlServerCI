IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0701]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0701]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Kiem tra trang thai phieu co duoc phep Sua, Xoa hay khong.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 07/06/2004 by Nguyen Van Nhan
---- Edit by: Dang Le Bao Quynh; Date: 16/01/2009
---- Purpose: Bo sung truong hop xuat hang mua tra lai
---- Modified on 25/10/2011 by Nguyễn Bình Minh: Bổ sung kiểm tra phiếu nhận hàng trước đã có hóa đơn thì không được Sửa/Xóa. 
--												Bổ sung Division vào các điều kiện kiểm tra
---- Modified by Bao Anh	Date: 11/09/2012	Kiểm tra phiếu xuất đã được chọn khi nhập kho thành phẩm thì không cho Sửa/Xóa (2T)
---- Modified by Bao Anh	Date: 21/08/2014	Kiểm tra phiếu nhập hàng TTDD/theo lô/hết hạn đã được xuất thì không cho sửa/xóa
---- Modified by Lê Thị Thu Hiền on 31/07/2014 : Bổ sung kiểm tra Phiếu kết chuyển từ POS Hàng bán trả lại
---- Modified by Quốc Tuấn on 18/09/2014 : Bổ sung thêm KindVoucherID  kiểm tra Phiếu kết chuyển từ POS Hàng bán trả lại và bán hàng xuất kho
---- Modified by Tiểu Mai on 18/08/2015: Bổ sung kiểm tra phiếu Xuất kho tự động tạo từ phiếu Kết quả sản xuất đã tập hợp chi phí
---- Modified by Hoàng Vũ on 23/03/2016: BỔ sung kiểm tra trước khi xóa/sửa phiếu nhập/xuất sinh ra từ moduleT hoặc sinh ra từ xuất kho theo bộ, phiếu nhập/xuất theo bộ sinh ra từ moduleT 
---- Modified by Phương Thảo on 18/05/2016 : Bổ sung with(nolock)
---- Modified by Phương Thảo on 10/05/2016 : Sửa danh mục dùng chung
---- Modified by Hải Long on 11/07/2017 : Bổ sung thông báo tập hợp chi phí cho trường hợp đã tập hợp chi phí nhân công, sản xuất chung
---- Modified by Kim Thư on 13/12/2018: Kiểm tra phiếu VCNB đã phát hành hóa đơn điện tử hay chưa (CustomizeIndex = 16 - Siêu Thanh)
---- Modified by Kim Thư on 05/03/2019: Kiểm tra phiếu VCNB đã phát hành hóa đơn điện tử thì cho sửa 1 số trường
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
-- <Example>
---- 
CREATE PROCEDURE [dbo].[AP0701]
(
	@DivisionID AS NVARCHAR(50),
	@TranMonth AS INT,
	@TranYear AS INT,
	@VoucherID AS NVARCHAR(50),
	@FromID as nvarchar(50),
	@Status AS TINYINT OUTPUT,
	@EngMessage AS NVARCHAR(250) OUTPUT,
	@VieMessage AS NVARCHAR(250) OUTPUT
)	
AS
DECLARE @Message AS NVARCHAR(250), @CustomerName INT
SET @Status = 0
SET @CustomerName = (SELECT CustomerName FROM CustomerIndex)

IF EXISTS (SELECT TOP 1 1 FROM   AT9000 WITH (NOLOCK) WHERE TableID = 'AT2006' AND VoucherID = @VoucherID AND (STATUS <> 0 OR IsCost <> 0) AND DivisionID = @DivisionID)
BEGIN
    SET @Status = 1
    SET @Message = N'AFML000096'
	GOTO MESS
END	

IF EXISTS (SELECT TOP 1 1 FROM AT2006 WITH (NOLOCK) WHERE KindVoucherID = 3 AND VoucherID = @VoucherID AND DivisionID = @DivisionID and IsWeb = 1)
BEGIN
    SET @Status = 1
    SET @Message = N'WFML000185'
    GOTO MESS
END	


------------ Phiếu kết chuyển từ POS Hàng bán trả lại
IF EXISTS (SELECT TOP 1 1 FROM AT2006 WITH (NOLOCK)
			INNER JOIN AT9000 WITH (NOLOCK) ON AT9000.DivisionID = AT2006.DivisionID 
			AND AT9000.VoucherID = AT2006.ReVoucherID 
			Where AT9000.DivisionID =@DivisionID 
			AND AT9000.ReTableID = 'POST0016' 
			AND AT2006.KindVoucherID ='7'
			AND AT2006.VoucherID = @VoucherID)
	BEGIN
		SET @Status = 3
		SET @Message =N'AFML000381' 
		SET @Message =N'AFML000381'
		Goto MESS
	END

IF EXISTS (SELECT TOP 1 1 FROM AT2006 WITH (NOLOCK)
			INNER JOIN AT9000 WITH (NOLOCK) ON AT9000.DivisionID = AT2006.DivisionID 
			AND AT9000.VoucherID = AT2006.ReVoucherID 
			Where AT9000.DivisionID =@DivisionID 
			AND AT9000.ReTableID = 'POST0016' 
			AND AT2006.VoucherID = @VoucherID)
	BEGIN
		SET @Status = 1
		SET @Message =N'AFML000381' 
		SET @Message =N'AFML000381'
		Goto MESS
	END
	
IF EXISTS (	SELECT		TOP 1 1 
			FROM		AT0114 WITH (NOLOCK)
			INNER JOIN	AT1302 WITH (NOLOCK) ON  AT1302.DivisionID IN (AT0114.DivisionID,'@@@') AND AT1302.InventoryID = AT0114.InventoryID					
			WHERE		AT0114.DivisionID = @DivisionID
						AND ReVoucherID = @VoucherID
						AND DeQuantity <> 0
						AND (MethodID = 3 or Isnull(AT1302.IsSource,0) <> 0 or ISNULL(AT1302.IsLimitDate,0) <> 0)
			)
BEGIN
    SET @Status = 1
    SET @Message = N'AFML000090'
    GOTO MESS
END


--Phiếu nhập kho cảnh báo: Bạn không được phép Sửa, Xoá phiếu này. Phiếu này được nhập từ phân hệ khác (Mua hàng).
IF EXISTS (	SELECT TOP 1 1 FROM AT2006 t1 WITH (NOLOCK) inner join AT9000 t2 WITH (NOLOCK) ON t1.VoucherID = t2.VoucherID and t1.DivisionID = t2.DivisionID
			WHERE t1.KindVoucherID = 5 AND t1.VoucherID = @VoucherID AND t1.DivisionID = @DivisionID)
BEGIN
    SET @Status = 1
    SET @Message = N'AFML000091'
    GOTO MESS
END
--Phiếu xuất kho cảnh báo: Bạn không được phép Sửa, Xoá phiếu này. Phiếu này được nhập từ phân hệ khác (Hàng mua trả lại).
IF EXISTS (SELECT TOP 1 1 FROM AT2006 WITH (NOLOCK) WHERE KindVoucherID = 10 AND VoucherID = @VoucherID AND DivisionID = @DivisionID)
BEGIN
    SET @Status = 1
    SET @Message = N'AFML000094'
    GOTO MESS
END
--Phiếu xuất kho cảnh báo: Bạn không được phép Sửa, Xoá phiếu này. Phiếu này được nhập từ phân hệ khác (Bán hàng theo bộ).
If  Exists (Select	top 1  1 From	AT2006  WITH (NOLOCK)
			Where	KindVoucherID = 4 and DivisionID = @DivisionID and VoucherID = @VoucherID 
					and exists(select top 1 1 from AT9000 WITH (NOLOCK) where DivisionID = @DivisionID and TransactionTypeID = 'T04' and VoucherID = @VoucherID 
							   and TableID in ('AT1326','MT1603')))
BEGIN
    SET @Status = 1
    SET @Message = N'AFML000098'
    GOTO MESS
END	

--Phiếu nhập kho cảnh báo: Bạn không được phép Sửa, Xoá phiếu này. Phiếu này được nhập từ phân hệ khác (Hàng bán trả lại theo bộ).
If  Exists (Select	top 1  1 From	AT2006 WITH (NOLOCK)
			Where	KindVoucherID = 1 and DivisionID = @DivisionID and VoucherID = @VoucherID 
					and exists(select top 1 1 from AT9000 WITH (NOLOCK) where DivisionID = @DivisionID and TransactionTypeID = 'T24' and VoucherID = @VoucherID
					and TableID in ('AT1326','MT1603')))
BEGIN
    SET @Status = 1
    SET @Message = N'AFML000402'
    GOTO MESS
END	

--Phiếu xuất kho cảnh báo: Bạn không được phép Sửa, Xoá phiếu này. Phiếu này được nhập từ phân hệ khác (Bán hàng).
IF EXISTS (SELECT TOP 1 1 FROM AT2006 WITH (NOLOCK) WHERE KindVoucherID = 4 AND VoucherID = @VoucherID AND DivisionID = @DivisionID
			and exists(select top 1 1 from AT9000 WITH (NOLOCK) where DivisionID = @DivisionID and TransactionTypeID = 'T04' and VoucherID = @VoucherID 
						and TableID = 'AT9000'))
BEGIN
    SET @Status = 1
    SET @Message = N'AFML000092'
    GOTO MESS
END	

--Phiếu nhập kho cảnh báo: Bạn không được phép Sửa, Xoá phiếu này. Phiếu này được nhập từ phân hệ khác (Hàng bán trả lại).
IF EXISTS (SELECT TOP 1 1 FROM AT2006  WITH (NOLOCK)
		   WHERE KindVoucherID = 7 AND VoucherID = @VoucherID AND DivisionID = @DivisionID
				 and exists(select top 1 1 from AT9000 WITH (NOLOCK) where DivisionID = @DivisionID and TransactionTypeID = 'T24' and VoucherID = @VoucherID
				 and TableID = 'AT9000'))
BEGIN
    SET @Status = 1
    SET @Message = N'AFML000093'
    GOTO MESS
END	
--Phiếu nhập kho cảnh báo: Bạn không được phép Sửa, Xoá phiếu này. Phiếu này được nhập từ phân hệ khác (AsoftM).
IF EXISTS (SELECT TOP 1 1 FROM AT2006 WITH (NOLOCK) WHERE TableID = 'MT0810' AND VoucherID = @VoucherID AND DivisionID = @DivisionID)
BEGIN
    SET @Status = 1
    SET @Message = N'AFML000095'
    GOTO MESS
END

--Phiếu Nhập/xuất kho cảnh báo: Bạn không được phép Sửa, Xoá phiếu này vì phiếu này thuộc phiếu nhập/xuất kho theo bộ. Bạn phải Sửa, Xóa ở màn hình phiếu nhập/xuất kho theo bộ
IF @FromID ='WF0008'		----- Danh sách phieu nhập-xuất-VCNB
BEGIN
			IF EXISTS (SELECT TOP 1 1 FROM AT2026 WITH (NOLOCK)
					   WHERE VoucherID = @VoucherID AND DivisionID = @DivisionID and 
						isnull((select top 1 1 from AT9000 WITH (NOLOCK) where DivisionID = @DivisionID and TransactionTypeID in ('T24', 'T04') and VoucherID = @VoucherID), 0) = 0
					   )
			BEGIN
				SET @Status = 1
				SET @Message = N'AFML000097'
				GOTO MESS
			END
End

--Phiếu nhập kho cảnh báo: Phiếu nhập kho hàng về trước này đã có hóa đơn sau. Bạn không thể sửa hoặc Xóa. Bạn hãy kiểm tra lại.
IF EXISTS (SELECT TOP 1 1 FROM AT2006 WITH (NOLOCK) WHERE KindVoucherID = 1 AND IsGoodsFirstVoucher = 1 AND VoucherID = @VoucherID AND DivisionID = @DivisionID)
BEGIN
	IF EXISTS(SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) WHERE ReVoucherID = @VoucherID AND IsLateInvoice = 1 AND DivisionID = @DivisionID)
	BEGIN
		SET @Status = 1
	    SET @Message = N'WFML000142'
		GOTO MESS			
	END 
END

IF EXISTS (SELECT TOP 1 1 FROM AT2006 WITH (NOLOCK) WHERE DivisionID = @DivisionID And KindVoucherID = 2 And VoucherID = @VoucherID And Isnull(EVoucherID,'') <> '')
BEGIN
	SET @Status = 1
    SET @Message = N'WFML000156'
	GOTO MESS
END

IF EXISTS (SELECT TOP 1 1 FROM AT2006 WITH (NOLOCK) INNER JOIN AT9000 WITH (NOLOCK) ON AT9000.DivisionID = AT2006.DivisionID AND AT9000.VoucherID = AT2006.VoucherID 
							Where AT9000.DivisionID =@DivisionID 
							AND AT2006.VoucherID = @VoucherID
							AND IsNull(AT9000.MaterialTypeID,'') <>''
							AND IsNull(AT9000.PeriodID,'')<>''
							AND AT9000.ExpenseID IN ('COST001', 'COST002', 'COST003'))
BEGIN
	SET @Status = 1
    SET @Message = N'WFML000176'
	GOTO MESS
END

IF EXISTS (SELECT TOP 1 1 FROM WT2026 WITH (NOLOCK) WHERE VoucherID = @VoucherID AND DivisionID = @DivisionID)
BEGIN
    SET @Status = 1
    SET @Message = N'WFML000157'
	GOTO MESS
END	

IF EXISTS (SELECT TOP 1 1 FROM WT2026 WITH (NOLOCK) WHERE @VoucherID = 'NNL'+VoucherID AND DivisionID = @DivisionID)
BEGIN
    SET @Status = 1
    SET @Message = N'WFML000157'
	GOTO MESS
END	

IF @CustomerName = 16
	IF EXISTS (SELECT TOP 1 1 FROM AT2006 WITH (NOLOCK) INNER JOIN AT1035 WITH (NOLOCK) ON AT2006.DivisionID = AT1035.DivisionID AND AT2006.VoucherID = AT1035.VoucherID
				WHERE AT2006.VoucherID = @VoucherID AND AT2006.DivisionID = @DivisionID AND AT2006.KindVoucherID = 3 AND AT1035.IsLastEInvoice = 1)
	BEGIN
		SET @Status = 3
		SET @Message = N'AFML000516'
		GOTO MESS
	END	

IF @CustomerName = 57
begin
	IF EXISTS (SELECT TOP 1 1 FROM AT2006 WITH (NOLOCK) WHERE VoucherID = @VoucherID AND DivisionID = @DivisionID AND TableID = 'AT0112')
	BEGIN
		SET @Status = 1
		SET @Message = N'WFML000224'
	END	

	-----Bổ sung kiểm tra phiếu xuất được kế thừa qua hóa đơn bán hàng lưu ở table trung gian (ANGEL)
	IF EXISTS (SELECT TOP 1 1 FROM AT0266_AG WITH (NOLOCK) WHERE InheritVoucherID = @VoucherID AND DivisionID = @DivisionID )
	BEGIN
		SET @Status = 2
		SET @Message = N''
	END	
end

MESS:

SET @VieMessage = @Message
SET @EngMessage = @Message


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

