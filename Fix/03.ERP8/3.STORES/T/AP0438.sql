IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0438]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0438]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo chi tiết môi giới phải trả theo khách hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 14/07/2022 by Kiều Nga
----Modify on 09/08/2022 by Kiều Nga : Fix lỗi dữ liệu báo cáo chi tiết phí môi giới phải trả theo khách hàng
----Modify on 09/01/2023 by Kiều Nga : Bổ sung thêm cột số tiền và  phần trăm tiền thuê đất
----Modify on 06/02/2023 by Kiều Nga : [2023/02/IS/0017] Ghi chú chỉnh sửa lấy mã đối tượng ngân hàng,Đơn giá => lấy kết quả trung bình 
----Modify on 07/02/2023 by Kiều Nga : [2023/02/IS/0018] In báo cáo cho chỉnh sửa lại cho phép chọn in 1 hoặc nhiều hợp đồng
----Modify on 08/02/2023 by Kiều Nga : [2023/02/IS/0017] Lấy tổng cộng diện tích 
----Modify on 23/02/2023 by Văn Tài	 : [2023/02/IS/0083] Xử lý lấy thông tin chứng từ Bút toán tổng hợp sử dụng MPT4 dành cho hợp đồng.
-- <Example>
/*  
EXEC AP0438 @DivisionID, @FromYear , @ToYear
EXEC AP0438 'MHS', 2021 , 2022,'A-KH-001','XD-XLNT-01'

*/
----
CREATE PROCEDURE AP0438 (
		@DivisionID Nvarchar(50),
        @LstDivisionID Nvarchar(Max),
		@IsDate INT,
		@FromDate Datetime,
		@ToDate Datetime,
		@LstPeriod Nvarchar(Max),
		@LstYear Nvarchar(Max),
		@LstObject XML = NULL,
		@ContractNo Nvarchar(Max))
AS

DECLARE @Sql AS NVARCHAR(MAX)='',
		@Sql1 AS NVARCHAR(MAX)='',
		@Sql2 AS NVARCHAR(MAX)='',
		@Sql3 AS NVARCHAR(MAX)='',
		@Sql4 AS NVARCHAR(MAX)='',
		@Sql5 AS NVARCHAR(MAX)='',
		@sWhere AS NVARCHAR(MAX)=''

IF(ISNULL(@LstDivisionID,'') <> '')
BEGIN
	SET @sWhere = @sWhere +' AND T1.DivisionID IN ('''+@LstDivisionID+''')'
END
ELSE
BEGIN
	SET @sWhere = @sWhere +' 
	AND T1.DivisionID = '''+@LstDivisionID+''''
END

IF(@IsDate = 1)
BEGIN
	SET  @sWhere = @sWhere + ' 
	AND CONVERT(VARCHAR(10), CONVERT(DATE,T3.SignDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''''
END
ELSE IF(@IsDate = 2)
BEGIN
	SET  @sWhere = @sWhere + ' 
	AND (CASE WHEN T3.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T3.TranMonth)))+''/''+ltrim(Rtrim(str(T3.TranYear))) in ('''+@LstPeriod +''')'
END
ELSE IF(@IsDate = 3)
BEGIN
	SET  @sWhere = @sWhere + ' 
	AND YEAR(T3.SignDate) IN ('''+@LstYear+''')'
END

IF(@LstObject IS NOT NULL)
BEGIN
	SELECT X.Data.query('ObjectID').value('.', 'NVARCHAR(50)') AS ObjectID
	INTO #TBL_ObjectID
	FROM @LstObject.nodes('//Data') AS X (Data)

	SET @sWhere = @sWhere +' 
	AND T3.ObjectID IN (SELECT ObjectID FROM #TBL_ObjectID)'
END

IF(ISNULL(@ContractNo,'') <> '')
BEGIN
	SET @sWhere = @sWhere +' 
	AND T3.ContractNo IN ('''+@ContractNo+''')'
END

-- Thông tin hợp đồng 
SET @Sql =N' SELECT
	T1.ContractNo
	, T3.ObjectID AS LandLeaseObjectID --  Mã khách hàng
	, T6.ObjectName as LandLeaseObjectName -- Tên khách hàng
	, T1.ObjectID -- Mã nhà môi giới
	, T2.ObjectName -- Tên nhà môi giới
	, T5.ContractNo as MemorandumContractNo -- Biên bản ghi nhớ
	, T5.SignDate as MemorandumDate --  Ngày biên bản ghi nhớ
	, T4.ContractNo as OriginalContractNo -- Hợp đồng nguyên tắc,
	, T4.SignDate as OriginalContractDate --  Ngày hợp đồng nguyên tắc
	, T3.ContractNo as LandLeaseContractNo -- Hợp đồng thuê đất
	, T3.SignDate as LandLeaseContractDate --  Ngày hợp đồng thuê đất
	, (SELECT STUFF((
			SELECT '',''+convert(varchar(50),PlotID)
			FROM CT0156
			WHERE CT0156.APKMaster = T1.APK
			FOR xml path (''''), type).value(''.'',''nvarchar(MAX)'')
		  ,1,1,'''')
		  )as PlotID -- Lô đất
	,
	(SELECT SUM(ISNULL(AT0416.Area,0)) as Area
		FROM CT0156
		LEFT JOIN AT0416 ON AT0416.DivisionID IN (CT0156.DivisionID,''@@@'') AND AT0416.StoreID = CT0156.PlotID
		WHERE CT0156.APKMaster = T1.APK) as Area -- Diện tích
	,
	(SELECT AVG(CT0156.UnitPrice) as UnitPrice
		FROM CT0156
		WHERE CT0156.APKMaster = T3.APK) as UnitPrice -- Đơn giá HDTD
	,
	(SELECT AVG(CT0156.UnitPriceBrokerage) as UnitPriceBrokerage
		FROM CT0156
		WHERE CT0156.APKMaster = T1.APK) as UnitPriceBrokerage -- Đơn giá HDMG
	,T3.OriginalAmount -- Thành tiền HDTD
	,T1.OriginalAmount as OriginalAmountBrokerage -- Thành tiền HDMG
	,T3.ConvertedAmount -- Quy đổi HDTD
	,T1.ConvertedAmount as  ConvertedAmountBrokerage -- Quy đổi HDMG
	,T3.ExchangeRate  -- Tỷ giá HDTD
	,T1.ExchangeRate as  ExchangeRateBrokerage -- Tỷ giá HDTD
	,T1.ConvertedAmountBrokerage as TotalConvertedAmountBrokerage -- Phí xúc tiến đầu tư'

SET @Sql1=N'
	FROM CT0155 T1 WITH (NOLOCK)
	LEFT JOIN AT1202 T2 WITH (NOLOCK) ON T2.DivisionID IN (''@@@'',T1.DivisionID) AND T2.ObjectID = T1.ObjectID -- Nhà môi giới
	LEFT JOIN CT0155 T3 WITH (NOLOCK) ON T1.DivisionID = T3.DivisionID AND T3.ContractType = 3 AND T3.ContractNo = T1.InheritLandLeaseID -- Hợp đồng thuê đất
	LEFT JOIN CT0155 T4 WITH (NOLOCK) ON T3.DivisionID = T4.DivisionID AND T4.ContractType = 2 AND T4.ContractNo = T3.InheritOriginalContractID -- Hợp đồng nguyên tắc
	LEFT JOIN CT0155 T5 WITH (NOLOCK) ON T5.ContractType = 1 
		AND ((T4.DivisionID = T5.DivisionID AND T5.ContractNo = T4.InheritMemorandumID) OR (T3.DivisionID = T5.DivisionID AND T5.ContractNo = T3.InheritMemorandumID))  -- Biên bản ghi nhớ
	LEFT JOIN AT1202 T6 WITH (NOLOCK) ON T6.DivisionID IN (''@@@'',T3.DivisionID) AND T6.ObjectID = T3.ObjectID -- Khách hàng
	WHERE T1.ContractType = 4 '+@sWhere+'
	'

-- Thông tin thanh toán
	SET @Sql2 =N'
	SELECT P.* FROM (
	SELECT 0 type,T1.APK
	,T3.ContractNo
	,T3.ObjectID
	,T2.VoucherDate
	,T3.ConvertedAmount as Amount
	,SUM(ISNULL(T2.ConvertedAmount,0)) AS ConvertedAmount
	,(SUM(ISNULL(T2.ConvertedAmount,0))/T3.ConvertedAmount) as PaymentRate
	,0 as UnpaidPayment
	,0 as UnpaidPaymentRate
	,0 AS ConvertedAmountBrokerage
	,0 as PaymentBrokerageRate
	,0 as UnpaidPaymentBrokerage
	,0 as UnpaidPaymentRateBrokerage
	,(SELECT STUFF((
			SELECT '',''+convert(varchar(50),AT9000.ObjectID)
			FROM AT9000 
			WHERE CONVERT(VARCHAR(50),T1.ContractDetailID) = AT9000.InheritVoucherID
			GROUP BY AT9000.ObjectID
			FOR xml path (''''), type).value(''.'',''nvarchar(MAX)'')
		  ,1,1,'''')
		  )as Description -- Ghi chú đối tượng
	,'''' as AT9000VoucherNo
	,'''' as AT9000VoucherDate
	FROM CT0157 T1 WITH (NOLOCK)
	INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.ContractDetailID) = T2.InheritVoucherID
	LEFT JOIN CT0155 T3 WITH (NOLOCK) ON T1.APKMaster = T3.APK
	LEFT JOIN (
		SELECT T1.APKDetailID ,SUM(ISNULL(T2.ConvertedAmount,0)) AS ConvertedAmount
				   FROM CT0157 T1 WITH (NOLOCK)
				   INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.ContractDetailID) = T2.InheritVoucherID
				   LEFT JOIN CT0155 T3 WITH (NOLOCK) ON T1.APKMaster = T3.APK
				   WHERE T2.InheritTableID = ''CT0157'' AND T3.ContractType <> 4
				   GROUP BY T1.APKDetailID) A ON A.APKDetailID = T1.APKDetailID
	WHERE T2.InheritTableID = ''CT0157'' AND T3.ContractType IN (1,2,3) '+@sWhere+'
	GROUP BY T1.APK,T3.ContractNo,T3.ObjectID,T2.VoucherDate,T3.ConvertedAmount,A.ConvertedAmount,T2.VDescription,T1.ContractDetailID
	'

	SET @Sql3=N'
	UNION ALL
	SELECT 0 type,T1.APK
	,T4.ContractNo
	,T4.ObjectID
	,T2.VoucherDate
	,T4.ConvertedAmount as Amount
	,0 AS ConvertedAmount
	,0 as PaymentRate
	,0 as UnpaidPayment
	,0 as UnpaidPaymentRate
	,SUM(ISNULL(T2.ConvertedAmount,0)) AS ConvertedAmountBrokerage
	,(SUM(ISNULL(T2.ConvertedAmount,0))/T4.ConvertedAmountBrokerage) as PaymentBrokerageRate
	,0 as UnpaidPaymentBrokerage
	,0 as UnpaidPaymentRateBrokerage
	,(SELECT STUFF((
			SELECT '',''+convert(varchar(50),AT9000.ObjectID)
			FROM AT9000 
			WHERE CONVERT(VARCHAR(50),T1.ContractDetailID) = AT9000.InheritVoucherID
			GROUP BY AT9000.ObjectID
			FOR xml path (''''), type).value(''.'',''nvarchar(MAX)'')
		  ,1,1,'''')
		  )as Description -- Ghi chú đối tượng
	,(SELECT STUFF((
			SELECT '',''+convert(varchar(50),AT9000.InvoiceNo)
			FROM AT9000
			WHERE AT9000.DivisionID =T4.DivisionID AND AT9000.TransactionTypeID IN (N''T03'', N''T99'') AND AT9000.Ana04ID = T4.ContractNo
			GROUP BY AT9000.InvoiceNo
			FOR xml path (''''), type).value(''.'',''nvarchar(MAX)'')
		  ,1,1,'''')
		  )as AT9000VoucherNo -- Số hóa đơn phí môi giới
	,(SELECT STUFF((
			SELECT '',''+format(AT9000.InvoiceDate,''dd/MM/yyyy'')
			FROM AT9000
			WHERE AT9000.DivisionID = T4.DivisionID AND AT9000.TransactionTypeID IN (N''T03'', N''T99'') AND AT9000.Ana04ID = T4.ContractNo
			GROUP BY AT9000.InvoiceDate
			FOR xml path (''x''), type).value(''.'',''nvarchar(MAX)'')
		  ,1,1,'''')
	)as AT9000VoucherDate -- Ngày hóa đơn phí môi giới
	FROM CT0157 T1 WITH (NOLOCK)
	INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.ContractDetailID) = T2.InheritVoucherID
	LEFT JOIN CT0155 T4 WITH (NOLOCK) ON T1.APKMaster = T4.APK
	LEFT JOIN CT0155 T3 WITH (NOLOCK) ON T4.DivisionID = T3.DivisionID AND T3.ContractType = 3 AND T3.ContractNo = T4.InheritLandLeaseID -- Hợp đồng thuê đất
	LEFT JOIN (SELECT T1.APK ,SUM(ISNULL(T2.ConvertedAmount,0)) AS ConvertedAmount
	           FROM CT0157 T1 WITH (NOLOCK)
			   INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.ContractDetailID) = T2.InheritVoucherID
			   WHERE T2.InheritTableID = ''CT0157'' 
			   GROUP BY T1.APK) A ON A.APK = T1.APK
	WHERE T2.InheritTableID = ''CT0157'' AND T4.ContractType = 4 '+@sWhere+'
	GROUP BY T1.APK,T4.ContractNo,T4.ObjectID,T2.VoucherDate,T4.ConvertedAmount,A.ConvertedAmount,T2.VDescription,T4.DivisionID,T4.ConvertedAmountBrokerage,T1.ContractDetailID
	'


	SET @Sql4=N'
	UNION ALL
	SELECT 1 type,T3.APK
	,T3.ContractNo
	,T3.ObjectID
	,null as VoucherDate
	,0 as Amount
	,0 AS ConvertedAmount
	,0 as PaymentRate
	,(T3.ConvertedAmount - ISNULL(A.ConvertedAmount,0)) as UnpaidPayment
	,((T3.ConvertedAmount - ISNULL(A.ConvertedAmount,0))/T3.ConvertedAmount) as UnpaidPaymentRate
	,0 AS ConvertedAmountBrokerage
	,0 as PaymentBrokerageRate
	,0 as UnpaidPaymentBrokerage
	,0 as UnpaidPaymentRateBrokerage
	,'''' as Description
	,'''' as AT9000VoucherNo
	,'''' as AT9000VoucherDate
	FROM CT0157 T1 WITH (NOLOCK)
	LEFT JOIN CT0155 T3 WITH (NOLOCK) ON T1.APKMaster = T3.APK
	LEFT JOIN (SELECT T1.APKDetailID ,SUM(ISNULL(T2.ConvertedAmount,0)) AS ConvertedAmount
				   FROM CT0157 T1 WITH (NOLOCK)
				   INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.ContractDetailID) = T2.InheritVoucherID
				   LEFT JOIN CT0155 T3 WITH (NOLOCK) ON T1.APKMaster = T3.APK
				   WHERE T2.InheritTableID = ''CT0157'' AND T3.ContractType <> 4
				   GROUP BY T1.APKDetailID) A ON A.APKDetailID = T1.APKDetailID
	WHERE T3.ContractType IN (1,2,3) AND (T3.ConvertedAmount - ISNULL(A.ConvertedAmount,0)) > 0 '+@sWhere+'
	GROUP BY T3.APK,T3.ContractNo,T3.ObjectID,T3.ConvertedAmount,A.ConvertedAmount '

	SET @Sql5=N'
	UNION ALL
	SELECT 1 type,T4.APK
	,T4.ContractNo
	,T4.ObjectID
	,null as VoucherDate
	,0 as Amount
	,0 AS ConvertedAmount
	,0 as PaymentRate
	,0 as UnpaidPayment
	,0 as UnpaidPaymentRate
	,0 AS ConvertedAmountBrokerage
	,0 as PaymentBrokerageRate
	,(T4.ConvertedAmountBrokerage - ISNULL(A.ConvertedAmount,0)) as UnpaidPaymentBrokerage
	,((T4.ConvertedAmountBrokerage - ISNULL(A.ConvertedAmount,0))/T4.ConvertedAmountBrokerage) as UnpaidPaymentRateBrokerage
	,'''' as Description
	,'''' as AT9000VoucherNo
	,'''' as AT9000VoucherDate
	FROM CT0157 T1 WITH (NOLOCK)
	LEFT JOIN CT0155 T4 WITH (NOLOCK) ON T1.APKMaster = T4.APK
	LEFT JOIN CT0155 T3 WITH (NOLOCK) ON T4.DivisionID = T3.DivisionID AND T3.ContractType = 3 AND T3.ContractNo = T4.InheritLandLeaseID -- Hợp đồng thuê đất
	LEFT JOIN (SELECT T3.APK ,SUM(ISNULL(T2.ConvertedAmount,0)) AS ConvertedAmount
	           FROM CT0157 T1 WITH (NOLOCK)
			   INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.ContractDetailID) = T2.InheritVoucherID
			   LEFT JOIN CT0155 T3 WITH (NOLOCK) ON T1.APKMaster = T3.APK
			   WHERE T2.InheritTableID = ''CT0157'' 
			   GROUP BY T3.APK) A ON A.APK = T4.APK
	WHERE T4.ContractType = 4 AND (T4.ConvertedAmountBrokerage - ISNULL(A.ConvertedAmount,0)) > 0'+@sWhere+'
	GROUP BY T4.APK,T4.ContractNo,T4.ObjectID,T4.ConvertedAmountBrokerage,A.ConvertedAmount ) as P
	ORDER BY type,VoucherDate

	Drop Table #TBL_ObjectID
	'

PRINT @Sql
PRINT @Sql1
PRINT @Sql2
PRINT @Sql3
PRINT @Sql4
PRINT @Sql5

EXEC (@Sql +@Sql1 +@Sql2 +@Sql3 + @Sql4 +@Sql5)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
