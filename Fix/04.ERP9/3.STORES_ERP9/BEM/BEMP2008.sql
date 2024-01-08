IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2008]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2008]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Trả về danh sách các dòng dữ liệu Phiếu mua hàng, BTTH được kế thừa cho phiếu DNTT kèm với số tiền còn lại
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by: Vĩnh Tâm on 24/07/2020
---- Modified by: Vĩnh Tâm on 18/11/2020: Bổ sung điều kiện loại các Phiếu đề nghị đã bị xóa
---- Modified by: Vĩnh Tâm on 11/12/2020: Thay đổi điều kiện lọc dữ liệu từ APK sang VoucherNo
---- Modified by: Vĩnh Tâm on 27/01/2021: Bổ sung param Mode xử lý riêng cho trường hợp Tạo phiếu và Duyệt phiếu
---- Modified by: Huỳnh Thử on 20/07/2021: Lấy thêm TransactionType T00
/* Example

 */
CREATE PROCEDURE BEMP2008
( 
    @DivisionID VARCHAR(50),
    @ListInheritVoucherNo VARCHAR(MAX),
	@Mode INT = 0			-- 0: Tạo/Cập nhật phiếu; 1: Duyệt phiếu
) 
AS 
BEGIN

	SELECT Value AS VoucherNo
	INTO #TableAPKInherit
	FROM StringSplit(@ListInheritVoucherNo, ',')

	SELECT A1.APK, A1.DivisionID, A1.VoucherNo, A1.Serial, A1.CurrencyID, A1.OriginalAmount, A1.OriginalAmount AS RemainingAmount
	INTO #BEMP2008_T0
    FROM AT9000 A1 WITH (NOLOCK)
		INNER JOIN #TableAPKInherit T1 ON A1.VoucherNo = T1.VoucherNo
    WHERE A1.TransactionTypeID IN ('T99', 'T03', 'T23', 'T00')
    GROUP BY A1.APK, A1.DivisionID, A1.VoucherNo, A1.Serial, A1.CurrencyID, A1.OriginalAmount

	SELECT T1.DivisionID, T1.VoucherNo, T1.Serial, T1.CurrencyID
		, SUM(T1.OriginalAmount) AS OriginalAmount, SUM(T1.RemainingAmount) AS RemainingAmount
	INTO #BEMP2008_T1
	FROM #BEMP2008_T0 T1
	GROUP BY T1.DivisionID, T1.VoucherNo, T1.Serial, T1.CurrencyID
	
	SELECT B1.InheritVoucherNo AS VoucherNo
		, SUM(ISNULL(IIF(ISNULL(B1.Status, 0) = 0 AND @Mode = 0, B1.RequestAmount, 0), 0))
		+ SUM(ISNULL(IIF(ISNULL(B1.Status, 0) = 1, B1.SpendAmount, 0), 0))
                AS RemainingAmount
	INTO #BEMP2008_T2
    FROM BEMT2001 B1 WITH (NOLOCK)
		INNER JOIN #TableAPKInherit T1 ON B1.InheritVoucherNo = T1.VoucherNo
    WHERE ISNULL(B1.DeleteFlg, 0) = 0
    GROUP BY B1.InheritVoucherNo
	
	SELECT T1.VoucherNo AS InheritVoucherNo, T1.RemainingAmount - ISNULL(T2.RemainingAmount, 0) AS RemainingAmount
	FROM #BEMP2008_T1 T1
		LEFT JOIN #BEMP2008_T2 T2 ON T1.VoucherNo = T2.VoucherNo
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
