IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0020]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[WP0020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load Grid chi tiết màn hình điều chỉnh kho khi kế thừa từ phiếu kiểm kê kho
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Thanh Sơn on: 23/06/2015
---- Modified on 29/10/2015 by Tiểu Mai: Bổ sung điều kiện Left join WT8899
---- Modified on 10/12/2015 by Phương Thảo: Chỉnh sửa, nếu khi kiểm kê không nhập số lượng thì hiểu ko điều chỉnh gì --> không load dòng đó lên
---- Modified on 29/11/2016 by Hải Long: Chỉnh sửa trường hợp điều chỉnh kho về 0 khi kế thừa không load lên
---- Modified by TIểu Mai on 24/05/2017: Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Hoài Bảo on 23/11/2022 : Bổ sung load tên tài khoản, tên đơn vị tính
-- <Example>
/*
	WP0020 'HD', '', 'dc5d4f8c-6c19-4ca7-9cd9-e96ec6f70c86' 
*/
CREATE PROCEDURE WP0020
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@VoucherID VARCHAR(50),
	@IsType TINYINT -- 0: Tất cả
					-- 1: Tăng
					-- 2: Giảm
)
AS

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	EXEC WP0020_QC @DivisionID, @UserID, @VoucherID, @IsType
ELSE 
BEGIN

	IF @IsType = 0
	BEGIN
			SELECT	A37.*,		
					A02.InventoryName, A04.UnitName, A05.AccountName AS DebitAccountName
			FROM AT2037 A37 WITH (NOLOCK) 
			LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID IN ('@@@', A37.DivisionID) AND A02.InventoryID = A37.InventoryID
			LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.DivisionID IN ('@@@', A37.DivisionID) AND A04.UnitID = A37.UnitID
			LEFT JOIN AT1005 A05 WITH (NOLOCK) ON A05.DivisionID IN ('@@@', A37.DivisionID) AND A05.AccountID = A37.DebitAccountID
			WHERE A37.DivisionID = @DivisionID
			AND A37.VoucherID = @VoucherID
			AND ISNULL(ReTransactionID, '') = ''
			AND A37.AdjustQuantity IS NOT NULL
			AND IsAdjust = 0
	END
	ELSE IF @IsType = 1
	BEGIN
			SELECT A37.*, A02.InventoryName, A04.UnitName, A05.AccountName AS DebitAccountName
			FROM AT2037 A37 WITH (NOLOCK) 
			LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.InventoryID = A37.InventoryID
			LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.DivisionID IN ('@@@', A37.DivisionID) AND A04.UnitID = A37.UnitID
			LEFT JOIN AT1005 A05 WITH (NOLOCK) ON A05.DivisionID IN ('@@@', A37.DivisionID) AND A05.AccountID = A37.DebitAccountID
			WHERE A37.DivisionID = @DivisionID
			AND A37.VoucherID = @VoucherID
			AND ISNULL(ReTransactionID, '') = ''
			AND IsAdjust = 0
			AND A37.AdjustQuantity IS NOT NULL
			AND ( Isnull(OriginalAmount,0)-Isnull(AdjutsOriginalAmount,0) < case when isnull(Quantity,0) =isnull(AdjustQuantity,0) then 0 end 
		  or Isnull(Quantity,0)-Isnull(AdjustQuantity,0)< case when isnull(Quantity,0)<>isnull(AdjustQuantity,0) then 0 end)

	END
	ELSE 
		SELECT A37.*, A02.InventoryName, A04.UnitName, A05.AccountName AS DebitAccountName
		FROM AT2037 A37 WITH (NOLOCK) 
		LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID IN ('@@@', A37.DivisionID) AND A02.InventoryID = A37.InventoryID
		LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.DivisionID IN ('@@@', A37.DivisionID) AND A04.UnitID = A37.UnitID
		LEFT JOIN AT1005 A05 WITH (NOLOCK) ON A05.DivisionID IN ('@@@', A37.DivisionID) AND A05.AccountID = A37.DebitAccountID
		WHERE A37.DivisionID = @DivisionID
		AND A37.VoucherID = @VoucherID
		AND ISNULL(ReTransactionID, '') = ''
		AND IsAdjust = 0
		AND A37.AdjustQuantity IS NOT NULL
		AND (Isnull(OriginalAmount,0)-Isnull(AdjutsOriginalAmount,0) > case when isnull(Quantity,0) =isnull(AdjustQuantity,0) then 0 end 
			or Isnull(Quantity,0)-Isnull(AdjustQuantity,0)> case when isnull(Quantity,0)<>isnull(AdjustQuantity,0) then 0 end)

	
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

