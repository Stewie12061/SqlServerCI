IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0148]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0148]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- WP0148
-- <Summary>
---- Stored đổ nguồn màn hình danh mục hóa đơn điện tử (phân hệ kho)
---- Created on 07/01/2021 by Đức Thông
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
--------------- Modified by Đức Thông on 13/01/2021: [KHV] 2020/12/TA/0801: Lấy cả phiếu xuất và phiếu VCNB + đổi lọc ngày theo date chứ không lấy time
--------------- Modified by Đức Thông on 14/01/2021: [KHV] 2020/12/TA/0801: Sửa lỗi hóa đơn hủy không hiển thị đúng
--------------- Modified by Đức Thông on 14/01/2021: [KHV] 2020/12/TA/0801: Sửa lại lọc hóa đơn theo ngày hóa đơn đối với các phiếu đã phát hành
--------------- Modified by Đức Thông on 19/01/2021: [KHV] 2020/12/TA/0801: Sửa lỗi xem phiếu
--------------- Modified by Đức Thông on 25/01/2021: [KHV] 2020/12/TA/0801: Bổ sung điều kiện lọc theo loại phiếu
--------------- Modified on 26/05/2022 by Nhật Thanh: Bổ sung điều kiện số hóa đơn 7 số để hiển thị các hóa đơn 7 số cũ
--------------- Modified on 30/06/2022 by Nhật Thanh: Bổ sung điều kiện ISNULL
--------------- Modified on 03/08/2022 by Nhật Thanh: Bổ sung điều kiện Số hóa đơn bằng 0 cho Easy
--------------- Modified on 05/09/2022 by Nhật Thanh: Bổ sung lấy invoiceGuid để hủy hóa đơn BKAV
--------------- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.


-- <Example>
---- EXEC WP0148 @DivisionID = 'SC',@UserID='ASOFTADMIN',@FromDate='2017-10-01 00:00:00',@ToDate='2017-10-31 00:00:00',@ObjectID='%',@InvoiceCode='01GTKT',@Mode=0, @Serial = '%'

CREATE PROCEDURE [dbo].[WP0148]
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@FromDate AS DATETIME,	
	@ToDate AS DATETIME,
	@ObjectID AS NVARCHAR(50),	
	@Mode AS TINYINT, --0:Tab chưa phát hành, 1: Tab đã phát hành,
	@Serial AS NVARCHAR(250),
	@KindVoucherList AS VARCHAR(20)

AS
		
DECLARE @sSQL AS NVARCHAR(MAX) = '', @CustomerName as int

SET @CustomerName = (SELECT Customername FROM CustomerIndex)
IF @Mode = 0 -- Chưa phát hành
BEGIN	
	SET @sSQL = N' 	
		SELECT * FROM (
		--- Phiếu đã phát hành nhưng chưa kí (BKAV) hoặc chưa phát hành
		SELECT TOP 100 PERCENT CONVERT(bit,0) AS Choose,
		A06.DivisionID,
		A06.VoucherNo,
		ISNULL(A35.InvoiceNo, '''') AS InvoiceNo,
		A06.VoucherDate,
		A06.VoucherTypeID,
		A06.VoucherID,
		A06.KindVoucherID,
		A06.ObjectID,
		A02.ObjectName,
		SUM(ConvertedAmount) AS ConvertedAmount,
		CASE ISNULL(A35.InvoiceNo, '''') WHEN '''' THEN 0 ELSE 1 END AS [Status], --- 0: chưa phát hành, 1: đã phát hành nhưng chưa ký
		CASE WHEN A06.KindVoucherID = 3 THEN N''Phiếu VCNB'' WHEN A06.KindVoucherID = 2 OR A06.KindVoucherID = 4 THEN N''Phiếu xuất'' END AS [Types], ---- loại phiếu
		W00.Serial, -- số serial
		W00.InvoiceSign, -- kí hiệu hóa đơn
		A35.InvoiceGuid
		FROM AT2006 A06 WITH (NOLOCK)
		LEFT JOIN AT1035 A35 WITH (NOLOCK) ON A35.VoucherID = A06.VoucherID
		LEFT JOIN AT2007 A07 WITH (NOLOCK) ON A06.DivisionID = A07.DivisionID AND A06.VoucherID = A07.VoucherID
		LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = A35.ObjectID
		LEFT JOIN WT0000 W00 WITH (NOLOCK) ON A06.DivisionID = W00.DefDivisionID
		WHERE A06.DivisionID = ''' + @DivisionID + '''
			AND (ISNULL(A35.InvoiceNo, '''') = ''00000000'' OR ISNULL(A35.InvoiceNo, '''') = ''0000000'' OR ISNULL(A35.InvoiceNo, '''') = ''0'' OR ISNULL(A35.InvoiceNo, '''') = '''')
			AND ISNULL(A35.ObjectID, '''') LIKE ''' + @ObjectID + '''
			AND ISNULL(A35.Serial, '''') LIKE ''' + @Serial + '''
			AND CONVERT(NVARCHAR(10), A06.VoucherDate, 126) BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 126) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 126) + '''
			AND A06.KindVoucherID IN ' + @KindVoucherList +
		' GROUP BY 
			A06.DivisionID,
			A06.VoucherNo,
			A06.VoucherDate,
			A06.VoucherTypeID,
			A06.VoucherID,
			A06.ObjectID,
			KindVoucherID,
			A02.ObjectName,
			A35.InvoiceNo,
			W00.Serial, -- số serial
			W00.InvoiceSign, -- kí hiệu hóa đơn
			A35.InvoiceGuid
	) X
	ORDER BY VoucherDate DESC'
END
ELSE IF @Mode = 1 -- Đã phát hành (dữ liệu đã đẩy vào AT1035 và có số hóa đơn)
BEGIN
	SET @sSQL = N'  
		SELECT
		A06.DivisionID,
		A06.VoucherNo,
		A35.InvoiceNo,
		A06.VoucherDate,
		A35.InvoiceDate,
		A35.InvoicePublishDate,
		A06.VoucherTypeID,
		A06.VoucherID,
		A06.ObjectID,
		A02.ObjectName,
		SUM(ConvertedAmount) AS ConvertedAmount,
		A06.KindVoucherID,
		CASE WHEN A06.KindVoucherID = 3 THEN N''Phiếu VCNB'' WHEN A06.KindVoucherID = 2 OR A06.KindVoucherID = 4 THEN N''Phiếu xuất'' END AS [Types], ---- loại phiếu
		W00.Serial, -- số serial
		W00.InvoiceSign, -- kí hiệu hóa đơn
		A35.InvoiceGuid
		FROM AT1035 A35 WITH (NOLOCK)
		INNER JOIN AT2006 A06 WITH (NOLOCK) ON A35.VoucherID = A06.VoucherID
		LEFT JOIN AT2007 A07 WITH (NOLOCK) ON A06.DivisionID = A07.DivisionID AND A06.VoucherID = A07.VoucherID
		LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = A35.ObjectID
		LEFT JOIN WT0000 W00 WITH (NOLOCK) ON A06.DivisionID = W00.DefDivisionID
		WHERE A35.DivisionID = ''' + @DivisionID + '''
			AND (ISNULL(A35.InvoiceNo, '''') != ''0000000'' AND ISNULL(A35.InvoiceNo, '''') != ''0'')
			AND ISNULL(A35.ObjectID, '''') LIKE ''' + @ObjectID + '''
			AND ISNULL(A35.Serial, '''') LIKE ''' + @Serial + '''
			AND CONVERT(NVARCHAR(10), A35.InvoiceDate, 126) BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 126) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 126) + '''
			AND ISNULL(A35.IsCancel, 0) = 0 -- ko phải hđ hủy
			AND A06.KindVoucherID IN ' + @KindVoucherList +
		' GROUP BY 
			A06.DivisionID,
			A06.VoucherNo,
			A06.VoucherDate,
			A35.InvoiceDate,
			A35.InvoicePublishDate,
			A06.VoucherTypeID,
			A06.VoucherID,
			A06.ObjectID,
			A02.ObjectName,
			KindVoucherID,
			A35.InvoiceNo,
			W00.Serial, -- số serial
			W00.InvoiceSign, -- kí hiệu hóa đơn
			A35.InvoiceGuid
		ORDER BY VoucherDate DESC
	'
END
ELSE
BEGIN
	
	SET @sSQL = N'  
		-- Hóa đơn bị hủy
		SELECT
		A35.DivisionID,
		'''' AS VoucherNo,
		A35.InvoiceNo,
		A35.VoucherDate,
		A35.InvoiceDate,
		A35.InvoicePublishDate,
		A35.VoucherTypeID,
		A35.VoucherID,
		A35.ObjectID,		
		A02.ObjectName,
		0 AS ConvertedAmount,
		'''' AS [Types],
		W00.Serial, -- số serial
		W00.InvoiceSign, -- kí hiệu hóa đơn
		A35.InvoiceGuid
		FROM AT1035 A35 WITH (NOLOCK)
			LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = A35.ObjectID
			LEFT JOIN WT0000 W00 WITH (NOLOCK) ON A35.DivisionID = W00.DefDivisionID
		WHERE A35.DivisionID = ''' + @DivisionID + '''
			AND ISNULL(A35.InvoiceNo, '''') != ''0000000''
			AND ISNULL(A35.ObjectID, '''') LIKE ''' + @ObjectID + '''
			AND ISNULL(A35.Serial, '''') LIKE ''' + @Serial + '''
			AND CONVERT(NVARCHAR(10), A35.InvoiceDate, 126) BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 126) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 126) + '''
			AND ISNULL(A35.IsCancel, 0) = 1 -- hđ hủy
		GROUP BY 
			A35.DivisionID,
			A35.VoucherDate,
			A35.InvoiceDate,
			A35.InvoicePublishDate,
			A35.VoucherTypeID,
			A35.VoucherID,
			A35.ObjectID,
			A02.ObjectName,
			A35.InvoiceNo,
			W00.Serial, -- số serial
			W00.InvoiceSign, -- kí hiệu hóa đơn
			A35.InvoiceGuid
		UNION
		-- Hóa đơn bị thay thế
		SELECT
		A06.DivisionID,
		A06.VoucherNo,
		A35A.InvoiceNo,
		A06.VoucherDate,
		A35A.InvoiceDate,
		A35A.InvoicePublishDate,
		A06.VoucherTypeID,
		A06.VoucherID,
		A06.ObjectID,
		A02.ObjectName,
		SUM(ConvertedAmount) AS ConvertedAmount,
		CASE WHEN A06.KindVoucherID = 3 THEN N''Phiếu VCNB'' WHEN A06.KindVoucherID = 2 OR A06.KindVoucherID = 4 THEN N''Phiếu xuất'' END AS [Types], ---- loại phiếu
		W00.Serial, -- số serial
		W00.InvoiceSign, -- kí hiệu hóa đơn
		A35A.InvoiceGuid
		FROM AT1035 A35A WITH (NOLOCK)
		INNER JOIN AT1035 AT35B WITH (NOLOCK) ON AT35B.DivisionID = A35A.DivisionID AND AT35B.InheritVoucherID = A35A.VoucherID -- Phải có thông tin phiếu kế thừa
		INNER JOIN AT2006 A06 WITH (NOLOCK) ON A35A.VoucherID = A06.VoucherID
		LEFT JOIN AT2007 A07 WITH (NOLOCK) ON A06.DivisionID = A07.DivisionID AND A06.VoucherID = A07.VoucherID
		LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = A35A.ObjectID
		LEFT JOIN WT0000 W00 WITH (NOLOCK) ON A06.DivisionID = W00.DefDivisionID
		WHERE A35A.DivisionID = ''' + @DivisionID + '''
			AND ISNULL(A35A.InvoiceNo, '''') != ''0000000''
			AND A35A.ObjectID LIKE ''' + @ObjectID + '''
			AND A35A.Serial LIKE ''' + @Serial + '''
			AND CONVERT(NVARCHAR(10), A35A.InvoiceDate, 126) BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 126) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 126) + '''			
			AND ISNULL(A35A.IsCancel, 0) = 0 -- ko phải hđ hủy
			AND A06.KindVoucherID IN ' + @KindVoucherList +
		' GROUP BY 
			A06.DivisionID,
			A06.VoucherNo,
			A06.VoucherDate,
			A35A.InvoiceDate,
			A35A.InvoicePublishDate,
			A06.VoucherTypeID,
			A06.VoucherID,
			A06.ObjectID,
			KindVoucherID,
			A02.ObjectName,
			A35A.InvoiceNo,
			W00.Serial, -- số serial
			W00.InvoiceSign, -- kí hiệu hóa đơn
			A35A.InvoiceGuid
		ORDER BY VoucherDate DESC
	'
END
PRINT @sSQL
EXEC (@sSQL)