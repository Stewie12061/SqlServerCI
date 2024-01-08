IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0080]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0080]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- Created on 24/09/2013 by Bảo Anh
--- Truy vấn bút toán mua hàng
--- Modified by Thanh Sơn on 28/07/2014: Cải tiến tốc độ truy vấn cho Thuận Lợi
--- Modified by Phương Thảo on 29/01/2016 : Bỏ group theo tỷ giá (vì 1 hóa đơn có thể có nhiều tỷ giá)
--- Modified by Bảo Thy on 25/05/2016: Bổ sung WITH (NOLOCK)
--- Modified by Phương Thảo on 13/06/2016: Customize KH Thành Công (CustomerIndex = 65) : Order by ưu tiên theo loại phiếu
--- Modified by Hải Long on 04/11/2016: Bổ sung mã phân tích nghiệp vụ 
--- Modified on 16/05/2017 by Hải Long: Chỉnh sửa danh mục dùng chung
---Modified by Khả Vi on 30/11/2017: Bổ sung trường VAT nguyên tệ, VAT quy đổi
--- Modified by Bảo Anh on 21/06/2018: Bỏ Group by theo CreateUserID
--- Modified by Bảo Anh on 20/07/2018: Bổ sung phân quyền xem chứng từ của người dùng khác, tách riêng tiền VAT ở cột tiền hàng
--- Modified by Kim Thư on 09/04/2019: Bổ sung thay đổi kiểu dữ liệu cột OrderID của bảng #TAM để Update OrderID
--- Modified by Kim Thư on 29/05/2019: Lấy OriginalAmount và ConvertedAMount không bao gồm thuế (CustomizeIndex = 31 - VIMEC)
--- Modified by Văn Minh on 13/12/2019: Lấy OriginalAmount và ConvertedAMount không bao gồm thuế (CustomizeIndex = 44 - SAVIPHARM)
--- Modified by Huỳnh Thử on 09/07/2020: Bỏ Group by Status: bị double 2 dòng do phiếu đã giải trừ 1 phần, nhưng chưa giải trừ hết khiến cho 1 dòng status=1 , và 1 dòng status=0
--- Modified by Huỳnh Thử on 29/08/2020: Cải tiến tốc độ
--- Modified by Đức Thông on 12/11/2020: Lấy tên đối tượng lưu trên phiếu hay vì trên thiết lập (tránh sai thông tin khi phát hành sau khi thay đổi tên ở thiết lập)
--- Modified by Nhật Thanh on 28/03/2022: Thay đổi vị trí đúng đặt order by
--- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

----- EXEC AP0080 'TL','07/01/2013','07/01/2013','%','((''''))', '((0 = 0))', '((''''))', '((0 = 0))', '((''''))', '((0 = 0))'

CREATE PROCEDURE AP0080
	@DivisionID NVARCHAR(50),
	@FromDate DATETIME,
	@ToDate DATETIME,
	@ObjectID NVARCHAR(50),
	@ConditionVT NVARCHAR(MAX),
	@IsUsedConditionVT NVARCHAR(20),
	@ConditionOB NVARCHAR(MAX),
	@IsUsedConditionOB NVARCHAR(20),
	@ConditionWA NVARCHAR(MAX),
	@IsUsedConditionWA NVARCHAR(20),
	@UserID VARCHAR(50) = ''
AS
Declare @_Cur CURSOR,
		@VoucherID NVARCHAR(50),
		@SQL VARCHAR(MAX),
		@SQL2 VARCHAR(MAX),
		@sWhere NVARCHAR(500),
		@CustomerName INT
		
SET @sWhere = 'T.WOrderID'		
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)	

IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WITH (NOLOCK) WHERE ID = OBJECT_ID(N'tempdb.dbo.#TAM')) 
DROP TABLE #TAM
	
SELECT TOP 0 * INTO #TAM FROM AT9000 WITH (NOLOCK)


--- Đưa dữ liệu AT9000 cần truy vấn sang bảng tạm
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsPermissionView = 1 ) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
BEGIN
	INSERT INTO #TAM 
	SELECT AT9000.* FROM AT9000 WITH (NOLOCK)
		LEFT JOIN AT0010 WITH (NOLOCK) ON AT0010.DivisionID = AT9000.DivisionID 
											AND AT0010.AdminUserID = @UserID
											AND AT0010.UserID = AT9000.CreateUserID
		WHERE AT9000.DivisionID = @DivisionID
		AND (AT9000.VoucherDate BETWEEN @FromDate AND @ToDate)
		AND AT9000.ObjectID LIKE @ObjectID
		AND (AT9000.TransactionTypeID = 'T03' OR AT9000.TransactionTypeID = 'T13')
		AND (AT9000.CreateUserID = AT0010.UserID OR AT9000.CreateUserID = @UserID)
		
END
ELSE
BEGIN
	INSERT INTO #TAM 
	SELECT * FROM AT9000 WITH (NOLOCK)
		WHERE DivisionID = @DivisionID
		AND (VoucherDate BETWEEN @FromDate AND @ToDate)
		AND ObjectID LIKE @ObjectID
		AND (TransactionTypeID = 'T03' OR TransactionTypeID = 'T13')
	
END

ALTER TABLE #TAM ALTER COLUMN OrderID VARCHAR(MAX)

IF @CustomerName not in (12,50) -- nếu là Thuận Lợi thì không chạy đoạn này
 --- Update OrderID cho từng VoucherID
BEGIN
	SET @sWhere = '(CASE WHEN AT2006.VoucherID = T.VoucherID THEN T.VoucherID ELSE T.WOrderID END)'
	SET @_Cur = CURSOR SCROLL KEYSET FOR
	SELECT VoucherID FROM #TAM 	
	WHERE OrderID IS NOT null
	ORDER BY #TAM.VoucherID
	OPEN @_Cur
	FETCH NEXT FROM @_Cur INTO @VoucherID

	WHILE @@FETCH_STATUS = 0		
		BEGIN		
			UPDATE #TAM SET OrderID = LTRIM(STUFF((SELECT DISTINCT ', ' + OrderID FROM #TAM WHERE VoucherID = @VoucherID FOR XML PATH('')),1,1,''))
			WHERE VoucherID = @VoucherID		
			FETCH NEXT FROM @_Cur INTO @VoucherID
		END
	CLOSE @_Cur
END	

--- Trả ra dữ liệu
SET @SQL = '
SELECT *
INTO #TAM2 
FROM 

	(SELECT  #TAM.DivisionID, #Tam.VoucherID, #Tam.TranMonth, #Tam.TranYear, 
	-- #Tam.BatchID,
	#Tam. VoucherTypeID, #Tam.VoucherNo,
	#Tam.VoucherDate, #Tam.Serial, #Tam.InvoiceNo, #Tam.InvoiceDate, #TAM.CurrencyID, MAX(#Tam.ExchangeRate) AS ExchangeRate, #Tam.VDescription, #Tam.VDescription [Description],
	#TAM.ObjectID,
	CASE ISNULL(#Tam.ObjectName1, '''') WHEN '''' THEN AT1202.ObjectName ELSE #Tam.ObjectName1 END AS ObjectName,
	#Tam.OrderID, #Tam.VATTypeID,-- A.WareHouseID,
	(CASE WHEN ISNULL(IsStock,0) = 1 THEN 
		(SELECT TOP 1 WareHouseID 
		FROM AT2006 WITH (NOLOCK) INNER JOIN #TAM T ON AT2006.DivisionID = T.DivisionID AND AT2006.DivisionID = ''' + @DivisionID + '''
			AND (AT2006.VoucherID = '+@sWhere+')
		 WHERE T.DivisionID = #TAM.DivisionID AND T.VoucherID = #TAM.VoucherID
		) 
	ELSE '''' END) WareHouseID,
	--[Status],
	---(Case when ISNULL(WOrderID, '''') = '''' Then IsStock Else 1 End) As IsStock,
	IsStock,
	SUM(ISNULL(#Tam.DiscountAmount, 0)) AS DiscountAmount,
	SUM(ISNULL(#Tam.ImTaxOriginalAmount, 0)) AS ImTaxOriginalAmount,
	SUM(ISNULL(#Tam.ImTaxConvertedAmount, 0)) AS ImTaxConvertedAmount,
	'+CASE WHEN @CustomerName = 31 OR @CustomerName = 44 THEN 'SUM(CASE WHEN #TAM.TransactionTypeID = ''T03'' THEN ISNULL(#Tam.OriginalAmount, 0) ELSE 0 END)' ELSE 'SUM(ISNULL(#Tam.OriginalAmount, 0))' END +' AS OriginalAmount,
	'+CASE WHEN @CustomerName = 31 OR @CustomerName = 44 THEN 'SUM(CASE WHEN #TAM.TransactionTypeID = ''T03'' THEN ISNULL(#Tam.ConvertedAmount, 0) ELSE 0 END)' ELSE 'SUM(ISNULL(#Tam.ConvertedAmount, 0))' END +' AS ConvertedAmount,
	MAX(#TAM.CreateUserID) as CreateUserID,
	MAX(ISNULL(#TAM.Ana01ID,'''')) as Ana01ID, MAX(ISNULL(#TAM.Ana02ID,'''')) as Ana02ID, MAX(ISNULL(#TAM.Ana03ID,'''')) as Ana03ID, MAX(ISNULL(#TAM.Ana04ID,'''')) as Ana04ID, MAX(ISNULL(#TAM.Ana05ID,'''')) as Ana05ID,
	MAX(ISNULL(#TAM.Ana06ID,'''')) as Ana06ID, MAX(ISNULL(#TAM.Ana07ID,'''')) as Ana07ID, MAX(ISNULL(#TAM.Ana08ID,'''')) as Ana08ID, MAX(ISNULL(#TAM.Ana09ID,'''')) as Ana09ID, MAX(ISNULL(#TAM.Ana10ID,'''')) as Ana10ID,
	SUM(CASE WHEN #TAM.TransactionTypeID = ''T13'' THEN ConvertedAmount ELSE 0 END) TaxAmount,
	SUM(CASE WHEN #TAM.TransactionTypeID = ''T13'' THEN OriginalAmount ELSE 0 END) TaxOriginalAmount --Tiền thuế quy đổi 
	FROM #TAM 
	--LEFT JOIN (SELECT DivisionID, VoucherID, WareHouseID FROM AT2006 WITH (NOLOCK)) A ON A.DivisionID = #Tam.DivisionID AND A.VoucherID = (CASE WHEN A.VoucherID = #Tam.VoucherID THEN #TAM.VoucherID ELSE #Tam.WOrderID END)
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = #TAM.ObjectID
	GROUP BY #TAM.DivisionID, #TAM.VoucherID, #Tam.TranMonth, #Tam.TranYear, --#Tam.BatchID, 
	#Tam.VoucherNo,#Tam.VoucherTypeID,
	#Tam.VoucherDate, #Tam.Serial, #Tam.InvoiceNo, #Tam.InvoiceDate, #TAM.CurrencyID, --#Tam.ExchangeRate, 
	#Tam.VDescription, #TAM.ObjectID,
	CASE ISNULL(#Tam.ObjectName1, '''') WHEN '''' THEN AT1202.ObjectName ELSE #Tam.ObjectName1 END,
	#Tam.OrderID, VATTypeID,
	--#Tam.Status,
	 #Tam.IsStock) A 

WHERE (ISNULL(VoucherTypeID, ''#'') IN (' + @ConditionVT + ') Or ' + @IsUsedConditionVT + ')
AND (ISNULL(ObjectID, ''#'') IN (' + @ConditionOB + ') Or ' + @IsUsedConditionOB + ')
AND (ISNULL(WareHouseID, ''#'') IN (' + @ConditionWA + ') Or ' + @IsUsedConditionWA + ') '


SET @SQL2 = '
SELECT *,
ISNULL(A11.AnaName,'''') Ana01Name, ISNULL(A12.AnaName,'''') Ana02Name, ISNULL(A13.AnaName,'''') Ana03Name, ISNULL(A14.AnaName,'''') Ana04Name, ISNULL(A15.AnaName,'''') Ana05Name, 
ISNULL(A16.AnaName,'''') Ana06Name, ISNULL(A17.AnaName,'''') Ana07Name, ISNULL(A18.AnaName,'''') Ana08Name, ISNULL(A19.AnaName,'''') Ana09Name, ISNULL(A20.AnaName,'''') Ana10Name  
FROM #TAM2
LEFT JOIN AT1011 A11 WITH (NOLOCK) ON A11.AnaID = #TAM2.Ana01ID AND A11. AnaTypeID = ''A01'' 
LEFT JOIN AT1011 A12 WITH (NOLOCK) ON A12.AnaID = #TAM2.Ana02ID AND A12. AnaTypeID = ''A02''
LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A13.AnaID = #TAM2.Ana03ID AND A13. AnaTypeID = ''A03''
LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A14.AnaID = #TAM2.Ana04ID AND A14. AnaTypeID = ''A04''
LEFT JOIN AT1011 A15 WITH (NOLOCK) ON A15.AnaID = #TAM2.Ana05ID AND A15. AnaTypeID = ''A05''
LEFT JOIN AT1011 A16 WITH (NOLOCK) ON A16.AnaID = #TAM2.Ana06ID AND A16. AnaTypeID = ''A06''
LEFT JOIN AT1011 A17 WITH (NOLOCK) ON A17.AnaID = #TAM2.Ana07ID AND A17. AnaTypeID = ''A07''
LEFT JOIN AT1011 A18 WITH (NOLOCK) ON A18.AnaID = #TAM2.Ana08ID AND A18. AnaTypeID = ''A08''
LEFT JOIN AT1011 A19 WITH (NOLOCK) ON A19.AnaID = #TAM2.Ana09ID AND A19. AnaTypeID = ''A09''
LEFT JOIN AT1011 A20 WITH (NOLOCK) ON A20.AnaID = #TAM2.Ana10ID AND A20. AnaTypeID = ''A10''
' +
CASE WHEN @CustomerName = 65 THEN ' Order by VoucherTypeID, VoucherDate, VoucherNo' ELSE 'Order by VoucherDate, VoucherNo' END
EXEC(@SQL + @SQL2)
--PRINT (@SQL)
--PRINT (@SQL2)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
