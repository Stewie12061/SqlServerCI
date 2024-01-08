IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7406]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7406]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In chi tiet no phai thu cho khách hàng Bê tông Long An (CustomizeIndex = 80)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tiểu Mai on 17/08/2017
---- Modified by Tiểu Mai on 20/10/2017: Lấy ContractNo thay cho ContractID
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/*
	exec AP7406 'BT', 'CAGI-000001', 'CAGI-000001', 'HD/08/16/00000012', 'HD/08/16/00000012', '2017-08-23'
 */

CREATE PROCEDURE [dbo].[AP7406]
				 	@DivisionID NVARCHAR(50) ,
					@FromObjectID  NVARCHAR(50),
					@ToObjectID  NVARCHAR(50),
					@FromAna05ID NVARCHAR(50),
					@ToAna05ID NVARCHAR(50),
					@ReportDate DATETIME
 AS

---- Lấy thông tin hợp đồng
SELECT A20.ObjectID, A02.ObjectName, A20.ContractNo AS ContractID, A20.ConvertedAmount AS ContractAmount, AT90.TU_ConvertedAmount AS AdvancePayAmount,
		B.InvoiceNo AS DInvoiceNo, B.InvoiceDate AS DInvoiceDate, B.HD_ConvertedAmount AS DAmount, 
		B.VoucherNo AS CVoucherNo, B.VoucherDate AS CVoucherDate, B.GV_ConvertedAmount AS CAmount, 
		C.KT_ConvertedAmount AS Amount01, B.EndAmount, B.DueDate, B.EndAmount AS DueAmount

FROM AT1020 A20 WITH (NOLOCK)
LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (@DivisionID, '@@@') AND A02.ObjectID = A20.ObjectID
LEFT JOIN (
	SELECT A90.DivisionID, A90.Ana05ID, SUM(A90.OriginalAmount) AS TU_OriginalAmount, SUM(A90.ConvertedAmount) AS TU_ConvertedAmount
	FROM AT9000 A90 WITH (NOLOCK)
	WHERE A90.DivisionID = @DivisionID
		AND A90.TransactionTypeID IN ( 'T01', 'T21') AND ISNULL(IsAdvancePayment,0) <> 0
	GROUP BY A90.DivisionID, A90.Ana05ID	
) AT90 ON AT90.DivisionID = A20.DivisionID AND A20.ContractNo = AT90.Ana05ID
	
---- Lấy thông tin hóa đơn bán hàng
LEFT JOIN (
	SELECT A90.DivisionID, A90.InvoiceNo, A90.InvoiceDate, A90.DueDate, A90.Ana05ID, 
		SUM(A90.OriginalAmount) AS HD_OriginalAmount, SUM(A90.ConvertedAmount) AS HD_ConvertedAmount, 
		A09.VoucherNo, A90.VoucherDate, A03.GV_OriginalAmount, A03.GV_ConvertedAmount,
		SUM(A90.ConvertedAmount) - E.GV_ConvertedAmount AS EndAmount
	FROM AT9000 A90 WITH (NOLOCK)
	LEFT JOIN (SELECT A03.DivisionID, A03.DebitVoucherID, A03.CreditVoucherID, SUM(A03.OriginalAmount) AS GV_OriginalAmount, SUM(A03.ConvertedAmount) AS GV_ConvertedAmount FROM AT0303 A03 WITH (NOLOCK) 
			   GROUP BY A03.DivisionID, A03.DebitVoucherID, A03.CreditVoucherID) A03 ON A03.DivisionID = A90.DivisionID AND A90.VoucherID = A03.DebitVoucherID
	LEFT JOIN (SELECT A03.DivisionID, A03.DebitVoucherID, SUM(A03.OriginalAmount) AS GV_OriginalAmount, SUM(A03.ConvertedAmount) AS GV_ConvertedAmount FROM AT0303 A03 WITH (NOLOCK) 
			   GROUP BY A03.DivisionID, A03.DebitVoucherID) E ON E.DivisionID = A90.DivisionID AND A90.VoucherID = E.DebitVoucherID
	LEFT JOIN AT9000 A09 WITH (NOLOCK) ON A09.DivisionID = A03.DivisionID AND A09.VoucherID = A03.CreditVoucherID
	WHERE A90.DivisionID = @DivisionID
		AND A90.VoucherDate <= @ReportDate
		AND A90.TransactionTypeID IN ( 'T04', 'T14')
	GROUP BY A90.DivisionID, A90.InvoiceNo, A90.InvoiceDate, A90.DueDate, A90.Ana05ID, A09.VoucherNo, A90.VoucherDate, A03.GV_OriginalAmount, A03.GV_ConvertedAmount, E.GV_ConvertedAmount
) B ON A20.DivisionID = B.DivisionID AND A20.ContractNo = B.Ana05ID

LEFT JOIN (
	---- Lấy thông tin phiếu thu tạm ứng đã khấu trừ
	SELECT AT9000.DivisionID, AT9000.Ana05ID, SUM(AT0303.OriginalAmount) AS KT_OriginalAmount, SUM(AT0303.ConvertedAmount) AS KT_ConvertedAmount
	FROM AT0303 WITH (NOLOCK) 
	LEFT JOIN AT9000 WITH (NOLOCK) ON AT9000.DivisionID = AT0303.DivisionID AND AT9000.VoucherID = AT0303.CreditVoucherID AND AT9000.BatchID = AT0303.CreditBatchID
	WHERE AT0303.DivisionID = @DivisionID 
	AND AT9000.TransactionTypeID IN ( 'T01', 'T21')
	AND ISNULL(AT9000.IsAdvancePayment,0) <> 0 
	GROUP BY AT9000.DivisionID, AT9000.Ana05ID
) C ON A20.DivisionID = C.DivisionID AND A20.ContractNo = C.Ana05ID

WHERE A20.DivisionID = @DivisionID AND A20.ObjectID BETWEEN @FromObjectID AND @ToObjectID
	AND A20.ContractNo BETWEEN @FromAna05ID AND @ToAna05ID
	AND A20.SignDate <= @ReportDate
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
