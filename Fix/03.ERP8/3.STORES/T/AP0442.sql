IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0442]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0442]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Bảng thống kê hợp đồng thuê KCN
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 25/07/2022 by Kiều Nga
----Modify  on 10/08/2022 by Kiều Nga : Báo cáo thông kê hợp đồng thuê KCN
----Modify  on 07/02/2023 by Kiều Nga : [2023/02/IS/0018] In báo cáo cho chỉnh sửa lại cho phép chọn in 1 hoặc nhiều hợp đồng
----Modify  on 15/02/2023 by Kiều Nga : [2023/02/IS/0051] Tính tổng diện tích và đơn giá
----Modify  on 24/02/2023 by Văn Tài  : [2023/02/IS/0132] Bổ sung tính thành tiền nguyên tệ có cộng thêm VAT.

-- <Example>
/*  
EXEC AP0442 @DivisionID, @FromYear , @ToYear
EXEC AP0442 'MHS', 2021 , 2022,'A-KH-001','XD-XLNT-01'

*/
----
CREATE PROCEDURE AP0442 (
		@DivisionID Nvarchar(50),
        @LstDivisionID Nvarchar(Max),
		@IsDate INT,
		@FromDate Datetime,
		@ToDate Datetime,
		@LstPeriod Nvarchar(Max),
		@LstYear Nvarchar(Max),
		@LstObject XML = NULL,
		@LstContract XML = NULL)
AS

DECLARE @Sql AS NVARCHAR(MAX)='',
		@Sql1 AS NVARCHAR(MAX)='',
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
ELSE IF(@IsDate = 3)
BEGIN
	SET  @sWhere = @sWhere + ' 
	AND YEAR(T1.SignDate) IN ('''+@LstYear+''')'
END

IF(@LstObject IS NOT NULL)
BEGIN
	SELECT X.Data.query('ObjectID').value('.', 'NVARCHAR(50)') AS ObjectID
	INTO #TBL_ObjectID
	FROM @LstObject.nodes('//Data') AS X (Data)

	SET @sWhere = @sWhere +' 
	AND T1.ObjectID IN (SELECT ObjectID FROM #TBL_ObjectID)'
END

IF(@LstContract IS NOT NULL)
BEGIN
	SELECT X.Data.query('ContractNo').value('.', 'NVARCHAR(50)') AS ContractNo
	INTO #TBL_ContractNo
	FROM @LstContract.nodes('//Data') AS X (Data)

	SET @sWhere = @sWhere +' 
	AND T1.ContractNo IN (SELECT ContractNo FROM #TBL_ContractNo)'
END

-- Thông tin hợp đồng 
SET @Sql =N' SELECT DISTINCT
	T1.ContractNo
	, T1.ObjectID -- Mã khách hàng
	, T2.ObjectName -- Tên khách hàng
	, T3.ObjectID as BrokerageObjectID --  Mã nhà môi giới
	, T6.ObjectName as BrokerageObjectName -- Tên nhà môi giới
	, T5.ContractNo as MemorandumContractNo -- Biên bản ghi nhớ6
	, T5.SignDate as MemorandumDate --  Ngày biên bản ghi nhớ
	, T4.ContractNo as OriginalContractNo -- Hợp đồng nguyên tắc,
	, T4.SignDate as OriginalContractDate --  Ngày hợp đồng nguyên tắc
	, T1.ContractNo as LandLeaseContractNo -- Hợp đồng thuê đất
	, T1.SignDate as LandLeaseContractDate --  Ngày hợp đồng thuê đất
	, (SELECT STUFF((
			SELECT '',''+convert(varchar(50),PlotID)
			FROM CT0156 WITH (NOLOCK)
			WHERE CT0156.APKMaster = T1.APK
			FOR xml path (''''), type).value(''.'',''nvarchar(MAX)'')
		  ,1,1,'''')
		  )as PlotID -- Lô đất
	, (SELECT SUM(ISNULL(AT0416.Area,0)) as Area
		FROM CT0156 WITH (NOLOCK)
		LEFT JOIN AT0416 WITH (NOLOCK) ON AT0416.DivisionID IN (CT0156.DivisionID,''@@@'') AND AT0416.StoreID = CT0156.PlotID
		WHERE CT0156.APKMaster = T1.APK) as Area -- Diện tích
	, T1.OriginalAmount -- Thành tiền HDTD
	, T3.OriginalAmount as OriginalAmountBrokerage -- Thành tiền HDMG
	, T1.ConvertedAmount -- Quy đổi HDTD
	, T3.ConvertedAmount as  ConvertedAmountBrokerage -- Quy đổi HDMG
	, T1.ExchangeRate  -- Tỷ giá HDTD
	, T3.ExchangeRate as  ExchangeRateBrokerage -- Tỷ giá HDMG
	, (SELECT STUFF((
			SELECT ''; ''+LTRIM(STR(convert(DECIMAL(28,8),ISNULL(CT0156.UnitPrice,0) - ISNULL(CT0156.UnitPriceBrokerage,0))))
			FROM CT0156 WITH (NOLOCK)
			WHERE CT0156.APKMaster = T3.APK
			FOR xml path (''''), type).value(''.'',''nvarchar(MAX)'')
		  ,1,1,'''')
		  )as TotalUnitPriceBrokerage -- Đơn giá phí xúc tiến đầu tư
	, (
		SELECT 
				ROUND(
						SUM(
							(ISNULL(CT0156.UnitPrice,0) - ISNULL(CT0156.UnitPriceBrokerage,0)) * AT0416.Area
							+ ((ISNULL(CT0156.UnitPrice,0) - ISNULL(CT0156.UnitPriceBrokerage,0)) * AT0416.Area) * (ISNULL(CT0156.VATPercent, 0) / 100)
					), MAX(AT01.ConvertedDecimals)
				)
		FROM CT0156 WITH (NOLOCK)
		LEFT JOIN AT0416 WITH (NOLOCK) ON AT0416.DivisionID IN (CT0156.DivisionID,''@@@'') AND AT0416.StoreID = CT0156.PlotID
		WHERE CT0156.APKMaster = T3.APK
		) as TotalOriginalAmountBrokerage -- Thành tiền phí xúc tiến đầu tư
	, T1.ExchangeRate as TotalExchangeRate -- Tỷ giá phí xúc tiến đầu tư
	, T3.ConvertedAmountBrokerage as TotalConvertedAmountBrokerage -- Phí xúc tiến đầu tư
	, SUM(ISNULL(A.ConvertedAmount,0)) as PaymentAmount
	, SUM(ISNULL(A.ConvertedAmount,0)/ISNULL(T1.ConvertedAmount,0)) as PaymentAmountRate
	, ISNULL(B.ConvertedAmount,0) as PaymentAmountBrokerage
	--,ISNULL(A.ConvertedAmount,0) - ISNULL(B.ConvertedAmount,0) as TotalUnpaidPayment
	--,ISNULL(T1.ConvertedAmount,0) - ISNULL(A.ConvertedAmount,0) as UnpaidPayment
	--,ISNULL(T3.ConvertedAmountBrokerage,0)*(ISNULL(A.ConvertedAmount,0)/ISNULL(T1.ConvertedAmount,0)) as PaymentInvestment
	--,ISNULL(T3.ConvertedAmountBrokerage,0) - ISNULL(B.ConvertedAmount,0) - (ISNULL(T3.ConvertedAmountBrokerage,0)*(ISNULL(A.ConvertedAmount,0)/ISNULL(T1.ConvertedAmount,0))) as  UnpaidPaymentInvestment
	,T8.Description as StatusName
	INTO #AP0422'

SET @Sql1=N'
	FROM CT0155 T1 WITH (NOLOCK)
	LEFT JOIN AT1202 T2 WITH (NOLOCK) ON T2.DivisionID IN (''@@@'',T1.DivisionID) AND T2.ObjectID = T1.ObjectID -- Khách hàng
	LEFT JOIN CT0155 T3 WITH (NOLOCK) ON T1.DivisionID = T3.DivisionID AND T3.ContractType = 4 AND T1.ContractNo = T3.InheritLandLeaseID -- Hợp đồng môi giới
	LEFT JOIN CT0155 T4 WITH (NOLOCK) ON T1.DivisionID = T4.DivisionID AND T4.ContractType = 2 AND T4.ContractNo = T1.InheritOriginalContractID -- Hợp đồng nguyên tắc
	LEFT JOIN CT0155 T5 WITH (NOLOCK) ON T5.ContractType = 1 
		AND ((T4.DivisionID = T5.DivisionID AND T5.ContractNo = T4.InheritMemorandumID) OR (T1.DivisionID = T5.DivisionID AND T5.ContractNo = T1.InheritMemorandumID))  -- Biên bản ghi nhớ
	LEFT JOIN AT1202 T6 WITH (NOLOCK) ON T6.DivisionID IN (''@@@'',T3.DivisionID) AND T6.ObjectID = T3.ObjectID -- Nhà môi giới
	LEFT JOIN CT0157 T7 WITH (NOLOCK) ON T7.APKMaster = T1.APK
	LEFT JOIN (
	SELECT T1.APKDetailID ,SUM(ISNULL(T2.ConvertedAmount, 0)) AS ConvertedAmount
				FROM CT0157 T1 WITH (NOLOCK)
				INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.ContractDetailID) = T2.InheritVoucherID
				LEFT JOIN CT0155 T3 WITH (NOLOCK) ON T1.APKMaster = T3.APK
				WHERE T2.InheritTableID = ''CT0157'' AND T3.ContractType <> 4
				GROUP BY T1.APKDetailID) A ON A.APKDetailID = T7.APKDetailID
   LEFT JOIN (
			SELECT T3.APK ,SUM(ISNULL(T2.ConvertedAmount, 0)) AS ConvertedAmount
	        FROM CT0157 T1 WITH (NOLOCK)
			INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.ContractDetailID) = T2.InheritVoucherID
			LEFT JOIN CT0155 T3 WITH (NOLOCK) ON T1.APKMaster = T3.APK
			WHERE T3.ContractType = 4 AND T2.InheritTableID = ''CT0157'' 
			GROUP BY T3.APK) as B ON B.APK = T3.APK
	LEFT JOIN AT0099 T8 WITH (NOLOCK) ON T1.StatusID = T8.ID AND T8.CodeMaster = ''StatusPlot''
	OUTER APPLY 
		(
			SELECT TOP 1 ISNULL(ConvertedDecimals, 0) ConvertedDecimals
			FROM AT0001 AT01 WITH (NOLOCK)
			WHERE AT01.DivisionID = T1.DivisionID
		) AT01
	WHERE T1.ContractType = 3 AND T1.ConvertedAmount > 0 '+@sWhere+'
	GROUP BY T1.ContractNo,T1.ObjectID,T2.ObjectName,T3.ObjectID,T6.ObjectName,T5.ContractNo,T5.SignDate,T4.ContractNo,T4.SignDate,T1.ContractNo,T1.SignDate,T1.APK,T3.APK
	,T1.OriginalAmount,T3.OriginalAmount,T1.ConvertedAmount,T3.ConvertedAmount,T1.ExchangeRate,T3.ExchangeRate,T3.ConvertedAmountBrokerage,T8.Description,B.ConvertedAmount

	SELECT ContractNo,ObjectID,ObjectName,BrokerageObjectID,BrokerageObjectName
	        ,MemorandumContractNo,MemorandumDate,OriginalContractNo,OriginalContractDate
			,LandLeaseContractNo,LandLeaseContractDate,PlotID,Area
			,CASE WHEN Area > 0 THEN OriginalAmount/Area ELSE 0 END as UnitPrice 
			,CASE WHEN Area > 0 THEN OriginalAmountBrokerage/Area ELSE 0 END as UnitPriceBrokerage
			,OriginalAmount,OriginalAmountBrokerage,ConvertedAmount,ConvertedAmountBrokerage
			,ExchangeRate,ExchangeRateBrokerage
			,CASE WHEN Area > 0 THEN TotalOriginalAmountBrokerage/Area ELSE 0 END AS TotalUnitPriceBrokerage
			,TotalOriginalAmountBrokerage,TotalExchangeRate,TotalConvertedAmountBrokerage,PaymentAmount,PaymentAmountRate,PaymentAmountBrokerage,StatusName
			 --, ISNULL(UnpaidPayment,0) - ISNULL(PaymentInvestment,0) - ISNULL(UnpaidPaymentInvestment,0) as UnpaidPaymentTT
			,PaymentAmount -PaymentAmountBrokerage as TotalUnpaidPayment
			,ISNULL(ConvertedAmount,0) - PaymentAmount as UnpaidPayment
			,ISNULL(TotalConvertedAmountBrokerage,0)* PaymentAmountRate as PaymentInvestment
			,ISNULL(TotalConvertedAmountBrokerage,0) - PaymentAmountBrokerage - (ISNULL(TotalConvertedAmountBrokerage,0)*PaymentAmountRate) as  UnpaidPaymentInvestment
			,(ISNULL(ConvertedAmount,0) - PaymentAmount) - (ISNULL(TotalConvertedAmountBrokerage,0)*PaymentAmountRate) 
			- (ISNULL(TotalConvertedAmountBrokerage,0) - PaymentAmountBrokerage - (ISNULL(TotalConvertedAmountBrokerage,0)*PaymentAmountRate)) as UnpaidPaymentTT
	 FROM #AP0422
	 ORDER BY ObjectID

	 Drop Table #TBL_ObjectID
	 Drop Table #TBL_ContractNo
	'
PRINT @Sql
PRINT @Sql1

EXEC (@Sql +@Sql1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
