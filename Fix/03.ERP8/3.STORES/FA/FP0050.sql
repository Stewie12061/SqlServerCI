IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FP0050]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FP0050]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Báo cáo theo dõi XDCB dở dang
-- <Param>
---- 
-- <Return>
---- 
-- <Reference> Customize Meiko
---- Báo cáo/ TSCĐ/ Theo dõi XDCB
-- <History>
---- Create on 16/11/2015 by Phương Thảo
---- Modified on 02/02/2016 by Phương Thảo: Không lấy dữ liệu từ Module Tài sản, chỉ lấy từ Module T
---- Modified on 09/03/2016 by Phương Thảo: Lấy thêm dữ liệu 10 mã phân tích
---- Modified on 12/03/2016 by Quốc tuấn: Lấy thêm mã tài sản hình thành
---- Modified on 14/03/2016 by Phương Thảo: Chỉnh sửa cách thể hiện báo cáo (lấy ra thêm thông tin Tài sản tại module FA)
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Khanh Doan on  24/06/2019: Them Dieu kien loc
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>e
---- EXEC FP0050 'GS', 0, '2015-12-31','2015-12-31', 11, 2015, 11, 2015 
CREATE PROCEDURE FP0050
( 		
   @DivisionID Varchar(50),
   @IsTime Tinyint, -- 0: Ngày, 1: Kỳ
   @FromDate Datetime,
   @ToDate Datetime,
   @FromMonth Tinyint,
   @FromYear Int,
   @ToMonth Tinyint,
   @ToYear Int
   --@IsNotTransferToFA Tinyint

)
AS
DECLARE	@sSQL1 NVARCHAR(4000) = '',
		@sSQL2 NVARCHAR(4000) = '',
		@sSQL3 NVARCHAR(4000) = '',
		@sWhere NVARCHAR(4000) = ''

IF (@IsTime = 0)
BEGIN
	SET @sWhere = 'AND (AT9000.VoucherDate Between '''+Convert(Varchar(20),@FromDate,101)+''' AND '''+Convert(Varchar(20),@ToDate,101)+''')'
END
ELSE
BEGIN
	SET @sWhere = 'AND (AT9000.TranMonth + AT9000.TranYear*100 Between '+STR(@FromMonth+@FromYear*100)+' AND '+STR(@ToMonth+@ToYear*100)+')'
END


SET @sSQL1 = N'
SELECT	AT9000.VoucherID, AT9000.TransactionID, AT9000.DivisionID,
		AT9000.ObjectID, AT1202.ObjectName, AT9000.VoucherDate, AT9000.VoucherNo,		
		AT9000.TranMonth, AT9000.TranYear, AT9000.Serial,
		AT9000.Ana01ID AS TaskID, AT1011.AnaName AS TaskName,		
		CASE WHEN ISNULL(AT9000.IsFACost,0) =  0 THEN CASE WHEN AT9000.DebitAccountID LIKE ''241%'' THEN OriginalAmount ELSE OriginalAmount*(-1) END ELSE 0 END AS OriginalAmount, 
		CASE WHEN ISNULL(AT9000.IsFACost,0) =  0 THEN CASE WHEN AT9000.DebitAccountID LIKE ''241%'' THEN ConvertedAmount ELSE ConvertedAmount*(-1) END ELSE 0 END AS ConvertedAmount,
		CASE WHEN ISNULL(AT9000.IsFACost,0) =  1 THEN CASE WHEN AT9000.DebitAccountID LIKE ''241%'' THEN ConvertedAmount ELSE ConvertedAmount*(-1) END ELSE 0 END AS AddCostAmount, 
		AT9000.VoucherDate as AddCostDate,
		Convert(Tinyint,0) AS IsCIP,
		Convert(Tinyint,0) AS IsFA, 
		Convert(Decimal(28,8),0) AS FAAmount,
		Convert(NVarchar(50),'''') AS ContractNo,		
		AT9000.Ana01ID, A01.AnaName AS Ana01Name, AT9000.Ana02ID, A02.AnaName AS Ana02Name,
		AT9000.Ana03ID, A03.AnaName AS Ana03Name, AT9000.Ana04ID, A04.AnaName AS Ana04Name,
		AT9000.Ana05ID, A05.AnaName AS Ana05Name, AT9000.Ana06ID, A06.AnaName AS Ana06Name,
		AT9000.Ana07ID, A07.AnaName AS Ana07Name, AT9000.Ana08ID, A08.AnaName AS Ana08Name,
		AT9000.Ana09ID, A09.AnaName AS Ana09Name, AT9000.Ana10ID, A10.AnaName AS Ana10Name,
		Convert(Decimal(28,8),0) AS TransferOAmount, 
		Convert(Decimal(28,8),0) AS TransferCAmount,
		Convert(NVarchar(2000),'''') AS StrAssetID, --- Chuoi ma TS duoc hinh thanh
		Convert(NVarchar(2000),'''') AS StrAssetVoucherNo, -- Chuoi so phieu cua but toan tap hop
		Convert(NVarchar(2000),'''') AS StrAssetVoucherDate 
		
INTO	#FP0050_AT9000_XDCB
FROM	AT9000  WITH (NOLOCK)
INNER JOIN AT1011  WITH (NOLOCK) ON AT9000.Ana01ID = AT1011.AnaID and AT1011.AnaTypeID = ''A01''
INNER JOIN AT1202  WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT9000.ObjectID = AT1202.ObjectID
LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.DivisionID = AT9000.DivisionID AND A01.AnaID = AT9000.Ana01ID AND A01.AnaTypeID =''A01''
LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.DivisionID = AT9000.DivisionID AND A02.AnaID = AT9000.Ana02ID AND A02.AnaTypeID =''A02''
LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.DivisionID = AT9000.DivisionID AND A03.AnaID = AT9000.Ana03ID AND A03.AnaTypeID =''A03''
LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.DivisionID = AT9000.DivisionID AND A04.AnaID = AT9000.Ana04ID AND A04.AnaTypeID =''A04''
LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.DivisionID = AT9000.DivisionID AND A05.AnaID = AT9000.Ana05ID AND A05.AnaTypeID =''A05''
LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.DivisionID = AT9000.DivisionID AND A06.AnaID = AT9000.Ana06ID AND A06.AnaTypeID =''A06''
LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.DivisionID = AT9000.DivisionID AND A07.AnaID = AT9000.Ana07ID AND A07.AnaTypeID =''A07''
LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.DivisionID = AT9000.DivisionID AND A08.AnaID = AT9000.Ana08ID AND A08.AnaTypeID =''A08''
LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.DivisionID = AT9000.DivisionID AND A09.AnaID = AT9000.Ana09ID AND A09.AnaTypeID =''A09''
LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.DivisionID = AT9000.DivisionID AND A10.AnaID = AT9000.Ana10ID AND A10.AnaTypeID =''A10''
WHERE	AT9000.DivisionID = '''+@DivisionID+'''   		
		AND ISNULL(AT9000.IsInheritFA,0) = 0 
		AND (AT9000.DebitAccountID LIKE ''241%'' OR AT9000.CreditAccountID LIKE ''241%'')		
 ' + @sWhere 


SET @sSQL2 = N'

UPDATE #FP0050_AT9000_XDCB
SET		IsCIP = 1
WHERE	NOT EXISTS (SELECT TOP 1 1 FROM AT9000  WITH (NOLOCK) WHERE AT9000.InheritTransactionID = #FP0050_AT9000_XDCB.TransactionID AND AT9000.IsInheritFA = 1)

UPDATE #FP0050_AT9000_XDCB
SET		IsFA = 1
WHERE	EXISTS (SELECT TOP 1 1 FROM AT9000  WITH (NOLOCK) WHERE AT9000.InheritTransactionID = #FP0050_AT9000_XDCB.TransactionID AND AT9000.IsInheritFA = 1)

-- Update so tien da di tap hop
UPDATE T1
SET		T1.TransferOAmount = ISNULL(T2.OriginalAmount,0),
		T1.TransferCAmount = ISNULL(T2.ConvertedAmount,0)
FROM #FP0050_AT9000_XDCB T1
INNER JOIN 
(	SELECT DivisionID, InheritTransactionID, InheritVoucherID, SUM(OriginalAmount) AS OriginalAmount, SUM(ConvertedAmount) AS  ConvertedAmount
	FROM AT9000  WITH (NOLOCK) 
	WHERE AT9000.IsInheritFA = 1
	GROUP BY DivisionID, InheritTransactionID, InheritVoucherID
) T2 ON  T1.DivisionID = T2.DivisionID  AND T1.TransactionID = T2.InheritTransactionID


---- Update chuoi so chung tu tap hop va ngay chung tu tap hop
UPDATE	T1
SET		T1.StrAssetVoucherNo = T2.StrAssetVoucherNo,
		T1.StrAssetVoucherDate = T2.StrAssetVoucherDate
FROM	#FP0050_AT9000_XDCB T1
INNER JOIN
(
	SELECT	B.DivisionID, B.InheritTransactionID, 			
			SUBSTRING(
						( SELECT VoucherNo + '', ''
						FROM AT9000 A WITH (NOLOCK)
						WHERE A.InheritTransactionID = B.InheritTransactionID AND A.IsInheritFA = 1
						ORDER BY A.VoucherID, A.TransactionID
						FOR XML PATH ('''')
						)
						,1,								
						LEN(( SELECT VoucherNo + '', ''
								FROM AT9000 A WITH (NOLOCK)
								WHERE A.InheritTransactionID = B.InheritTransactionID AND A.IsInheritFA = 1
								ORDER BY A.VoucherID, A.TransactionID
								FOR XML PATH ('''')
								)) - 1
					) AS StrAssetVoucherNo,
				SUBSTRING(
						( SELECT Convert(Varchar(50),VoucherDate,103) + '', ''
						FROM AT9000 A WITH (NOLOCK)
						WHERE A.InheritTransactionID = B.InheritTransactionID AND A.IsInheritFA = 1
						ORDER BY A.VoucherID, A.TransactionID
						FOR XML PATH ('''')
						)
						,1,								
						LEN(( SELECT Convert(Varchar(50),VoucherDate,103) + '', ''
								FROM AT9000 A WITH (NOLOCK)
								WHERE A.InheritTransactionID = B.InheritTransactionID AND A.IsInheritFA = 1
								ORDER BY A.VoucherID, A.TransactionID
								FOR XML PATH ('''')
								)) - 1
					) AS StrAssetVoucherDate
	FROM	AT9000 B WITH (NOLOCK)
	WHERE	B.IsInheritFA = 1
	GROUP BY	B.DivisionID, B.InheritTransactionID
) T2 ON T1.DivisionID = T2.DivisionID AND T1.TransactionID = T2.InheritTransactionID 
'
SET @sSQL3 = N'

-------- Update Mã TSCĐ đã được hình thành

SELECT	T1.TransactionID AS TransXDCB, T2.TransactionID AS TransTSCD, T2.VoucherID AS VoucherTSCD, Convert(Nvarchar(2000),'''') AS StrAssetID
INTO	#FP0050_AT9000_TSCD
FROM	#FP0050_AT9000_XDCB  T1
INNER JOIN  AT9000 T2  WITH (NOLOCK)  ON  T1.DivisionID = T2.DivisionID  AND T1.TransactionID = T2.InheritTransactionID
WHERE T2.IsInheritFA = 1 AND T1.IsFA = 1

UPDATE	T1
SET		T1.StrAssetID = T2.StrAssetID
FROM	#FP0050_AT9000_TSCD T1
INNER JOIN
(
	SELECT	B.ReTransactionID, B.ReVoucherID, 			
			SUBSTRING(
						( SELECT AssetID + '', ''
						FROM AT1533  A WITH (NOLOCK)
						WHERE A.ReTransactionID = B.ReTransactionID AND A.ReVoucherID = B.ReVoucherID
						ORDER BY A.ReTransactionID, A.ReVoucherID
						FOR XML PATH ('''')
						)
						,1,								
						LEN(( SELECT AssetID + '', ''
								FROM AT1533 A WITH (NOLOCK)
								WHERE A.ReTransactionID = B.ReTransactionID AND A.ReVoucherID = B.ReVoucherID
								ORDER BY A.ReTransactionID, A.ReVoucherID
								FOR XML PATH ('''')
								)) - 1
					) AS StrAssetID
	FROM	AT1533 B WITH (NOLOCK)
	GROUP BY	B.ReTransactionID, B.ReVoucherID
) T2 ON T1.TransTSCD = T2.ReTransactionID AND T1.VoucherTSCD = T2.ReVoucherID


UPDATE	T1
SET		T1.StrAssetID = T2.StrAssetID
FROM	#FP0050_AT9000_XDCB T1
INNER JOIN
(
	SELECT	DISTINCT B.TransXDCB,			
			SUBSTRING(
						( SELECT StrAssetID + '', ''
						FROM #FP0050_AT9000_TSCD  A WITH (NOLOCK)
						WHERE A.TransXDCB = B.TransXDCB
						ORDER BY A.TransXDCB
						FOR XML PATH ('''')
						)
						,1,								
						LEN(( SELECT StrAssetID + '', ''
								FROM #FP0050_AT9000_TSCD A WITH (NOLOCK)
								WHERE A.TransXDCB = B.TransXDCB
								ORDER BY A.TransXDCB
								FOR XML PATH ('''')
								)) - 1
					) AS StrAssetID
	FROM	#FP0050_AT9000_TSCD B WITH (NOLOCK)
	GROUP BY	B.TransXDCB
) T2 ON T1.TransactionID = T2.TransXDCB AND T1.TransactionID = T2.TransXDCB

select *  from #FP0050_AT9000_XDCB 
'
-- + CASE WHEN @IsNotTransferToFA = 1 THEN 'WHERE ConvertedAmount + AddCostAmount - TransferCAmount > 0' ELSE '' END



 --SELECT @sSQL1
 -- SELECT @sSQL2
 --  SELECT @sSQL3
 
--PRINT (@sSQL1)
--PRINT (@sSQL2)
--PRINT (@sSQL3)
EXEC (@sSQL1+ @sSQL2 + @sSQL3)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
