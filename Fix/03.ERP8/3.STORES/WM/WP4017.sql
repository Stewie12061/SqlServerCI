IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP4017]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP4017]
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



---- Create by Văn Tài, Date 02/03/2021
---- Purpose: Kiểm tra và xóa các phiếu nhập kho thành phẩm tự động và xuất kho NVL tự động : Move từ bản ERP 7 lên.
---- Modified on 04/03/2021 by	Văn Tài	: Điều chỉnh điều kiện xóa.
---- Modified on 09/03/2021 by	Văn Tài	: Bồ sung điều kiện DivisionID.

CREATE PROCEDURE [dbo].[WP4017] 
			@DivisionID VARCHAR(50),
			@UserID VARCHAR(50),
			@VoucherID VARCHAR(50),
			@BatchID VARCHAR(50),
			@TranMonth AS INT,
			@TranYear AS INT
AS
	-- VoucherID của KQSX.
DECLARE @VoucherMT0810 VARCHAR(50)
-- VoucherID của phiếu xuất kho Nguyên vật liệu.
DECLARE @VoucherAT2006_Material VARCHAR(50)

SET @VoucherMT0810 = (SELECT TOP 1 VoucherID FROM MT0810 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND BatchID = @VoucherID)

-- Phiếu xuất NVL từ KQSX với OrderID từ VoucherID của MT0810.
SET @VoucherAT2006_Material = (SELECT TOP 1 VoucherID FROM AT2006 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND OrderID = @VoucherMT0810)

-------- Xoa phieu nhap kho thanh pham tu dong neu co  ----------
DELETE MT1001 WHERE DivisionID = @DivisionID
					AND VoucherID IN (
										SELECT VoucherID 
										FROM MT0810 WITH (NOLOCK) 
										WHERE DivisionID = @DivisionID 
												AND TranYear = @TranYear 
												AND TranMonth = @TranMonth 
												AND BatchID = @VoucherID
									)

DELETE MT0810 WHERE DivisionID = @DivisionID 
						AND TranYear = @TranYear 
						AND TranMonth = @TranMonth 
						AND BatchID = @VoucherID

-------- Xoa phieu nhap xuat kho NVL tu dong neu co  ----------
DELETE AT2007 WHERE DivisionID = @DivisionID
						AND VoucherID IN (
											SELECT VoucherID 
											FROM AT2006 WITH (NOLOCK)
											WHERE DivisionID = @DivisionID 
													AND TranYear = @TranYear 
													AND TranMonth = @TranMonth 
													AND KindVoucherID = 2
													AND VoucherID = @VoucherAT2006_Material --@VoucherMT0810
										)

DELETE AT2006 WHERE DivisionID = @DivisionID 
						AND TranYear = @TranYear  
						AND TranMonth = @TranMonth 
						AND KindVoucherID = 2 
						AND VoucherID = @VoucherAT2006_Material --@VoucherMT0810

DELETE AT9000 where DivisionID = @DivisionID AND VoucherID = @VoucherMT0810
DELETE AT9000 where DivisionID = @DivisionID AND VoucherID = @VoucherAT2006_Material


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
