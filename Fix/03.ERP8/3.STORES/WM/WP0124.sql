IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0124]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0124]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load edit cho các phiếu chi phí nhập/xuất kho
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Bảo Thy on 11/01/2017
---- Modified by Bảo Thy on 26/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 07/01/2020: Lấy thêm trường Loại chi phí nhập/ xuất
---- Modified by Huỳnh Thử on 27/08/2020: Lấy thêm trường đơn vị tính, mã kho, tên kho
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

-- <Example>
/*
	 WP0124 @DivisionID=N'HT',@VoucherID=N'bb3ca221-f67e-4a1f-a7ab-39ec751ff197'
*/

CREATE PROCEDURE WP0124
(
    @DivisionID NVARCHAR(50),
	@VoucherID VARCHAR(50)
)
AS
DECLARE @TranMonth INT = 0,
		@TranYear INT = 0

SELECT @TranMonth = TranMonth, @TranYear = TranYear
FROM WT0097 WITH (NOLOCK)
WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID

SELECT W97.DivisionID, W97.TranMonth, W97.VoucherTypeID, W97.TranYear, W97.VoucherID, W97.VoucherNo, W97.VoucherDate, W97.ObjectID, A22.ObjectName, 
W97.Description, W97.CurrencyID, W98.WareHouseID,A03.WareHouseName, W97.CreateUserID, W97.CreateDate, W97.LastModifyUserID, W97.LastModifyDate, W98.TransactionID,
W98.InventoryID, A32.InventoryName, W98.CostID, A33.InventoryName AS CostName, W98.CostUnitPrice AS UnitPrice, W98.ConvertCoefficient, W98.Quantity, W98.ConvertQuantity, 
W98.OriginalAmount, W98.ConvertAmount, W98.InheritVoucherID, W98.InheritTransactionID, A26.VoucherNo AS InheritVoucherNo, W97.IsImportVoucher, W97.IsOtherCosts,
A14.ExchangeRate, A14.Operator, W98.ContractID,W98.UnitID,
CASE WHEN ISNULL(W97.IsFinalCost,0) = 0 THEN N'Chưa quyết toán'
	 WHEN ISNULL(W97.IsFinalCost,0) = 1 THEN N'Đã quyết toán' END AS IsFinalCost
FROM WT0097 W97  WITH (NOLOCK)
LEFT JOIN WT0098 W98 WITH (NOLOCK) ON W97.DivisionID = W98.DivisionID AND W97.VoucherID = W98.VoucherID
LEFT JOIN AT1202 A22 WITH (NOLOCK) ON A22.DivisionID IN (@DivisionID, '@@@') AND W97.ObjectID = A22.ObjectID
LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN ('@@@', W98.DivisionID) AND W98.InventoryID = A32.InventoryID
LEFT JOIN AT1302 A33 WITH (NOLOCK) ON W98.CostID = A33.InventoryID
LEFT JOIN AT2006 A26 WITH (NOLOCK) ON W97.DivisionID = A26.DivisionID AND W98.InheritVoucherID = A26.VoucherID
LEFT JOIN AV1004 A14 WITH (NOLOCK) ON A14.DivisionID IN (W97.DivisionID,'@@@') AND W97.CurrencyID = A14.CurrencyID
LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.DivisionID IN (W97.DivisionID,'@@@') AND A03.WareHouseID = W98.WareHouseID
WHERE W97.DivisionID = @DivisionID
AND W97.TranMonth = @TranMonth
AND W97.TranYear = @TranYear
AND W97.VoucherID = @VoucherID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
