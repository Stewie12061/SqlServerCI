IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0440]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0440]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo chi tiết thanh toán tiến độ tiền thuê đất
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 20/07/2022 by Kiều Nga
----Modify on 09/08/2022 by Kiều Nga : Fix lỗi Lấy sai cột Số HĐ 
----Modify on 09/08/2022 by Kiều Nga : Fix lỗi Lấy sai ngày bbgn, hdnt, hdtd
----Modify on 09/08/2022 by Kiều Nga : Fix lỗi sai thứ tự ngày thanh toán 
----Modify on 09/08/2022 by Kiều Nga : Fix lỗi sai Cột tỷ lệ thanh toán MG
----Modify  on 07/02/2023 by Kiều Nga : [2023/02/IS/0018] In báo cáo cho chỉnh sửa lại cho phép chọn in 1 hoặc nhiều hợp đồng
----Modify  on 14/02/2023 by Kiều Nga : [2023/02/IS/0050] Bỏ hiển thị dòng môi giới

-- <Example>
/*  
EXEC AP0440 @DivisionID, @FromYear , @ToYear
EXEC AP0440 'MHS', 2021 , 2022,'A-KH-001','XD-XLNT-01'

*/
----
CREATE PROCEDURE AP0440 (
		@DivisionID Nvarchar(50),
        @LstDivisionID Nvarchar(Max),
		@IsDate INT,
		@FromDate Datetime,
		@ToDate Datetime,
		@LstPeriod Nvarchar(Max),
		@LstObject XML = NULL,
		@ContractNo Nvarchar(Max))
AS

DECLARE @Sql AS NVARCHAR(MAX)='',
		@Sql1 AS NVARCHAR(MAX)='',
		@Sql2 AS NVARCHAR(MAX)='',
		@Sql3 AS NVARCHAR(MAX)='',
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
	AND CONVERT(VARCHAR(10), CONVERT(DATE,T1.SignDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''''
END
ELSE IF(@IsDate = 2)
BEGIN
	SET  @sWhere = @sWhere + ' 
	AND (CASE WHEN T1.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T1.TranMonth)))+''/''+ltrim(Rtrim(str(T1.TranYear))) in ('''+@LstPeriod +''')'
END

IF(@LstObject IS NOT NULL)
BEGIN
	SELECT X.Data.query('ObjectID').value('.', 'NVARCHAR(50)') AS ObjectID
	INTO #TBL_ObjectID
	FROM @LstObject.nodes('//Data') AS X (Data)

	SET @sWhere = @sWhere +' 
	AND T1.ObjectID IN (SELECT ObjectID FROM #TBL_ObjectID)'
END

IF(ISNULL(@ContractNo,'') <> '')
BEGIN
	SET @sWhere = @sWhere +' 
	AND T1.ContractNo IN ('''+@ContractNo+''')'
END

-- Thông tin hợp đồng 
SET @Sql =N' SELECT
	T1.ContractNo
	,T1.ObjectID -- Mã khách hàng
	,T2.ObjectName -- Tên khách hàng
	,T3.ObjectID as BrokerageObjectID --  Mã nhà môi giới
	,T6.ObjectName as BrokerageObjectName -- Tên nhà môi giới
	,T5.ContractNo as MemorandumContractNo -- Biên bản ghi nhớ
	,T5.SignDate as MemorandumDate --  Ngày biên bản ghi nhớ
	,T4.ContractNo as OriginalContractNo -- Hợp đồng nguyên tắc,
	,T4.SignDate as OriginalContractDate --  Ngày hợp đồng nguyên tắc
	,T1.ContractNo as LandLeaseContractNo -- Hợp đồng thuê đất
	,T1.SignDate as LandLeaseContractDate --  Ngày hợp đồng thuê đất
	,(SELECT STUFF((
			SELECT '',''+convert(varchar(50),PlotID)
			FROM CT0156
			WHERE CT0156.APKMaster = T1.APK
			FOR xml path (''''), type).value(''.'',''nvarchar(MAX)'')
		  ,1,1,'''')
		  )as PlotID -- Lô đất
	,T1.OriginalAmount -- Thành tiền HDTD
	,T3.OriginalAmount as OriginalAmountBrokerage -- Thành tiền HDMG
	,T1.ConvertedAmount -- Quy đổi HDTD
	,T3.ConvertedAmount as  ConvertedAmountBrokerage -- Quy đổi HDMG
	,T1.ExchangeRate  -- Tỷ giá HDTD
	,T3.ExchangeRate as  ExchangeRateBrokerage -- Tỷ giá HDMG
	,T3.ConvertedAmountBrokerage as TotalConvertedAmountBrokerage -- Phí xúc tiến đầu tư'

SET @Sql1=N'
	FROM CT0155 T1 WITH (NOLOCK)
	LEFT JOIN AT1202 T2 WITH (NOLOCK) ON T2.DivisionID IN (''@@@'',T1.DivisionID) AND T2.ObjectID = T1.ObjectID -- Khách hàng
	LEFT JOIN CT0155 T3 WITH (NOLOCK) ON T1.DivisionID = T3.DivisionID AND T3.ContractType = 4 AND T1.ContractNo = T3.InheritLandLeaseID -- Hợp đồng môi giới
	LEFT JOIN CT0155 T4 WITH (NOLOCK) ON T1.DivisionID = T4.DivisionID AND T4.ContractType = 2 AND T4.ContractNo = T1.InheritOriginalContractID -- Hợp đồng nguyên tắc
	LEFT JOIN CT0155 T5 WITH (NOLOCK) ON T5.ContractType = 1 
		AND ((T4.DivisionID = T5.DivisionID AND T5.ContractNo = T4.InheritMemorandumID) OR (T1.DivisionID = T5.DivisionID AND T5.ContractNo = T1.InheritMemorandumID))  -- Biên bản ghi nhớ
	LEFT JOIN AT1202 T6 WITH (NOLOCK) ON T6.DivisionID IN (''@@@'',T3.DivisionID) AND T6.ObjectID = T3.ObjectID -- Nhà môi giới
	WHERE T1.ContractType = 3 '+@sWhere+'
	'

-- Thông tin thanh toán
	SET @Sql2 =N'
	--SELECT P.* FROM (
	SELECT M.APK
	,T1.ContractNo
	,T1.ObjectID
	,T2.VoucherDate
	,T1.ConvertedAmount as Amount
	,SUM(ISNULL(T2.ConvertedAmount,0)) AS ConvertedAmount
	,(SUM(ISNULL(T2.ConvertedAmount,0))/T1.ConvertedAmount) as PaymentRate
	,0 AS ConvertedAmountBrokerage
	,0 as PaymentBrokerageRate
	,0 as UnpaidPayment
	,0 as UnpaidPaymentRate
	,T2.VDescription as Description
   ,(SELECT STUFF((
			SELECT '',''+convert(varchar(50),AT9000.InvoiceNo)
			FROM AT9000
			WHERE AT9000.DivisionID =T1.DivisionID AND AT9000.TransactionTypeID=N''T04'' AND AT9000.Ana07ID = T1.ContractNo
			GROUP BY AT9000.InvoiceNo
			FOR xml path (''''), type).value(''.'',''nvarchar(MAX)'')
		  ,1,1,'''')
		  )as AT9000VoucherNo -- Số hóa đơn 
	,(SELECT STUFF((
			SELECT '',''+format(AT9000.InvoiceDate,''dd/MM/yyyy'')
			FROM AT9000
			WHERE AT9000.DivisionID =T1.DivisionID AND AT9000.TransactionTypeID=N''T04'' AND AT9000.Ana07ID = T1.ContractNo
			GROUP BY AT9000.InvoiceDate
			FOR xml path (''x''), type).value(''.'',''nvarchar(MAX)'')
		  ,1,1,'''')
	)as AT9000VoucherDate -- Ngày hóa đơn
	,''Thuedat'' as ContractType
	FROM CT0157 M WITH (NOLOCK)
	LEFT JOIN CT0155 T1 WITH (NOLOCK) ON M.APKMaster = T1.APK
	INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),M.ContractDetailID) = T2.InheritVoucherID
	LEFT JOIN (
		SELECT T1.APKDetailID ,SUM(ISNULL(T2.ConvertedAmount,0)) AS ConvertedAmount
				   FROM CT0157 T1 WITH (NOLOCK)
				   INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.ContractDetailID) = T2.InheritVoucherID
				   LEFT JOIN CT0155 T3 WITH (NOLOCK) ON T1.APKMaster = T3.APK
				   WHERE T2.InheritTableID = ''CT0157'' AND T3.ContractType <> 4
				   GROUP BY T1.APKDetailID) A ON A.APKDetailID = M.APKDetailID
	WHERE T2.InheritTableID = ''CT0157'' AND T1.ContractType IN (1,2,3) '+@sWhere+'
	GROUP BY M.APK,T1.DivisionID,T1.ContractNo,T1.ObjectID,T2.VoucherDate,T1.ConvertedAmount,A.ConvertedAmount,T2.VDescription
	'

	SET @Sql3=N'
	UNION ALL
	SELECT M.APK
	,T4.ContractNo
	,T4.ObjectID
	,T2.VoucherDate
	,T4.ConvertedAmount as Amount
	,0 AS ConvertedAmount
	,0 as PaymentRate
	,SUM(ISNULL(T2.ConvertedAmount,0)) AS ConvertedAmountBrokerage
	,(SUM(ISNULL(T2.ConvertedAmount,0))/T4.ConvertedAmountBrokerage) as PaymentBrokerageRate
	,0 as UnpaidPayment
	,0 as UnpaidPaymentRate
	,T2.VDescription as Description
	,'''' as AT9000VoucherNo
	,'''' as AT9000VoucherDate
	,''Moigioi'' as ContractType
	FROM CT0157 M WITH (NOLOCK)
	INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),M.ContractDetailID) = T2.InheritVoucherID
	LEFT JOIN CT0155 T4 WITH (NOLOCK) ON M.APKMaster = T4.APK
	LEFT JOIN CT0155 T1 WITH (NOLOCK) ON T4.DivisionID = T1.DivisionID AND T1.ContractType = 3 AND T1.ContractNo = T4.InheritLandLeaseID -- Hợp đồng thuê đất
	LEFT JOIN (SELECT T1.APK ,SUM(ISNULL(T2.ConvertedAmount,0)) AS ConvertedAmount
	           FROM CT0157 T1 WITH (NOLOCK)
			   INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.ContractDetailID) = T2.InheritVoucherID
			   WHERE T2.InheritTableID = ''CT0157'' 
			   GROUP BY T1.APK) A ON A.APK = M.APK
	WHERE T2.InheritTableID = ''CT0157'' AND T4.ContractType = 4 '+@sWhere+'
	GROUP BY M.APK,T4.ContractNo,T4.ObjectID,T2.VoucherDate,T4.ConvertedAmount,A.ConvertedAmount,T2.VDescription,T4.DivisionID,T4.ConvertedAmountBrokerage ) as P
	ORDER BY VoucherDate
	'

PRINT @Sql
PRINT @Sql1
PRINT @Sql2

EXEC (@Sql +@Sql1 + @Sql2)

Drop Table #TBL_ObjectID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
