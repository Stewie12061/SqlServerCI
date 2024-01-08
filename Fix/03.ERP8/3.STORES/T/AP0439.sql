IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0439]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0439]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Bảng tổng hợp môi giới hợp đồng cho thuê
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 19/07/2022 by Kiều Nga
----Modify on 10/08/2022 by Kiều Nga : Điều chỉnh lấy ngày ký hợp đồng, Sum các dòng thanh toán
----Modify on 07/02/2023 by Kiều Nga : [2023/02/IS/0018] In báo cáo cho chỉnh sửa lại cho phép chọn in 1 hoặc nhiều hợp đồng
----Modify on 08/02/2023 by Kiều Nga : [2023/02/IS/0037] Cột diện tích là tộng cộng lại diện tích, đơn giá lấy trung bình bằng cách thành tiền/diện tích
----Modify on 15/02/2023 by Kiều Nga : [2023/02/IS/0049] Fix lỗi sai dữ liệu thành tiền (phí môi giới)
-- <Example>
/*  
EXEC AP0439 @DivisionID, @FromYear , @ToYear
EXEC AP0439 'MHS', 2021 , 2022,'A-KH-001','XD-XLNT-01'

*/
----
CREATE PROCEDURE AP0439 (
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
		@Sql2 AS NVARCHAR(MAX)='',
		@Sql3 AS NVARCHAR(MAX)='',
		@Sql4 AS NVARCHAR(MAX)='',
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

IF(@LstContract IS NOT NULL)
BEGIN
	SELECT X.Data.query('ContractNo').value('.', 'NVARCHAR(50)') AS ContractNo
	INTO #TBL_ContractNo
	FROM @LstContract.nodes('//Data') AS X (Data)

	SET @sWhere = @sWhere +' 
	AND T3.ContractNo IN (SELECT ContractNo FROM #TBL_ContractNo)'
END

-- Thông tin hợp đồng 
SET @Sql =N' SELECT DISTINCT 
	T1.ContractNo
	,T3.ObjectID as LandLeaseObjectID --  Mã khách hàng
	,T6.ObjectName as LandLeaseObjectName -- Tên khách hàng
	,T1.ObjectID -- Mã nhà môi giới
	,T2.ObjectName -- Tên nhà môi giới
	,T5.ContractNo as MemorandumContractNo -- Biên bản ghi nhớ
	,T5.SignDate as MemorandumDate --  Ngày biên bản ghi nhớ
	,T4.ContractNo as OriginalContractNo -- Hợp đồng nguyên tắc,
	,T4.SignDate as OriginalContractDate --  Ngày hợp đồng nguyên tắc
	,T3.ContractNo as LandLeaseContractNo -- Hợp đồng thuê đất
	,T3.SignDate as LandLeaseContractDate --  Ngày hợp đồng thuê đất
	,(SELECT STUFF((
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
	(SELECT STUFF((
			SELECT ''; ''+LTRIM(STR(convert(DECIMAL(28,8),CT0156.UnitPrice)))
			FROM CT0156
			WHERE CT0156.APKMaster = T3.APK
			FOR xml path (''''), type).value(''.'',''nvarchar(MAX)'')
		  ,1,1,'''')
		  )as UnitPrice -- Đơn giá HDTD
	,
	(SELECT STUFF((
			SELECT ''; ''+LTRIM(STR(convert(DECIMAL(28,8),CT0156.UnitPriceBrokerage)))
			FROM CT0156
			WHERE CT0156.APKMaster = T1.APK
			FOR xml path (''''), type).value(''.'',''nvarchar(MAX)'')
		  ,1,1,'''')
		  )as UnitPriceBrokerage -- Đơn giá HDMG
	,T3.OriginalAmount -- Thành tiền HDTD
	,T1.OriginalAmount as OriginalAmountBrokerage -- Thành tiền HDMG
	,T3.ConvertedAmount -- Quy đổi HDTD
	,T1.ConvertedAmount as  ConvertedAmountBrokerage -- Quy đổi HDMG
	,T3.ExchangeRate  -- Tỷ giá HDTD
	,T1.ExchangeRate as  ExchangeRateBrokerage -- Tỷ giá HDTD
	,(SELECT STUFF((
			SELECT ''; ''+LTRIM(STR(convert(DECIMAL(28,8),ISNULL(CT0156.UnitPrice,0) - ISNULL(CT0156.UnitPriceBrokerage,0))))
			FROM CT0156
			WHERE CT0156.APKMaster = T1.APK
			FOR xml path (''''), type).value(''.'',''nvarchar(MAX)'')
		  ,1,1,'''')
		  )as TotalUnitPriceBrokerage -- Đơn giá phí xúc tiến đầu tư
	,T1.ConvertedAmountBrokerage/T1.ExchangeRate as TotalOriginalAmountBrokerage -- Thành tiền phí xúc tiến đầu tư
	,T3.ExchangeRate as TotalExchangeRate -- Tỷ giá phí xúc tiến đầu tư
	,T1.ConvertedAmountBrokerage as TotalConvertedAmountBrokerage -- Phí xúc tiến đầu tư
	,T1.Description
	,ISNULL(A.ConvertedAmount,0) as PaymentAmountBrokerage
	,SUM(ISNULL(B.ConvertedAmount,0)) as PaymentAmount
	,T1.ConvertedAmountBrokerage - ISNULL(A.ConvertedAmount,0) as UnpaidPaymentBrokerage
	INTO #tempAP0439
	'

SET @Sql1=N'
	FROM CT0155 T1 WITH (NOLOCK)
	LEFT JOIN AT1202 T2 WITH (NOLOCK) ON T2.DivisionID IN (''@@@'',T1.DivisionID) AND T2.ObjectID = T1.ObjectID -- Nhà môi giới
	LEFT JOIN CT0155 T3 WITH (NOLOCK) ON T1.DivisionID = T3.DivisionID AND T3.ContractType = 3 AND T3.ContractNo = T1.InheritLandLeaseID -- Hợp đồng thuê đất
	LEFT JOIN CT0155 T4 WITH (NOLOCK) ON T3.DivisionID = T4.DivisionID AND T4.ContractType = 2 AND T4.ContractNo = T3.InheritOriginalContractID -- Hợp đồng nguyên tắc
	LEFT JOIN CT0155 T5 WITH (NOLOCK) ON T5.ContractType = 1 
		AND ((T4.DivisionID = T5.DivisionID AND T5.ContractNo = T4.InheritMemorandumID) OR (T3.DivisionID = T5.DivisionID AND T5.ContractNo = T3.InheritMemorandumID))  -- Biên bản ghi nhớ
	LEFT JOIN AT1202 T6 WITH (NOLOCK) ON T6.DivisionID IN (''@@@'',T3.DivisionID) AND T6.ObjectID = T3.ObjectID -- Khách hàng
	LEFT JOIN CT0157 T7 WITH (NOLOCK) ON T7.APKMaster = T1.APK
	LEFT JOIN (
			SELECT T3.APK ,SUM(ISNULL(T2.ConvertedAmount,0)) AS ConvertedAmount
	        FROM CT0157 T1 WITH (NOLOCK)
			INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.ContractDetailID) = T2.InheritVoucherID
			LEFT JOIN CT0155 T3 WITH (NOLOCK) ON T1.APKMaster = T3.APK
			WHERE T3.ContractType = 4 AND T2.InheritTableID = ''CT0157'' 
			GROUP BY T3.APK) as A ON A.APK = T1.APK
	LEFT JOIN (
			SELECT T1.APKDetailID ,SUM(ISNULL(T2.ConvertedAmount,0)) AS ConvertedAmount
			FROM CT0157 T1 WITH (NOLOCK)
			INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.ContractDetailID) = T2.InheritVoucherID
			LEFT JOIN CT0155 T3 WITH (NOLOCK) ON T1.APKMaster = T3.APK
			WHERE T2.InheritTableID = ''CT0157'' AND T3.ContractType <> 4
			GROUP BY T1.APKDetailID) as B ON B.APKDetailID = T7.APKDetailID
	WHERE T1.ContractType = 4 
	'+@sWhere+'
	GROUP BY T1.ContractNo,T3.ObjectID,T6.ObjectName,T1.ObjectID,T2.ObjectName,T5.ContractNo,T5.SignDate,T4.ContractNo,T4.SignDate,T3.ContractNo,T3.SignDate,T1.APK,T3.APK
	,T3.OriginalAmount,T1.OriginalAmount,T3.ConvertedAmount,T1.ConvertedAmount,T3.ExchangeRate,T1.ExchangeRate,T3.ExchangeRate,T1.ConvertedAmountBrokerage
	,T1.Description,A.ConvertedAmount	
	ORDER BY T3.ObjectID

	Drop Table #TBL_ObjectID
	Drop Table #TBL_ContractNo
	'

SET @Sql2 ='
	SELECT ContractNo,LandLeaseObjectID,LandLeaseObjectName,ObjectID,ObjectName,MemorandumContractNo,MemorandumDate
	,OriginalContractNo,OriginalContractDate,LandLeaseContractNo,LandLeaseContractDate,PlotID,Area
	,CASE WHEN Area > 0 THEN OriginalAmount/Area ELSE 0 END as UnitPrice
	,CASE WHEN Area > 0 THEN OriginalAmountBrokerage/Area ELSE 0 END as UnitPriceBrokerage
	,OriginalAmount,OriginalAmountBrokerage,ConvertedAmount,ConvertedAmountBrokerage,ExchangeRate,ExchangeRateBrokerage
	,CASE WHEN Area > 0 THEN TotalOriginalAmountBrokerage/Area ELSE 0 END as TotalUnitPriceBrokerage
	,TotalOriginalAmountBrokerage,TotalExchangeRate,TotalConvertedAmountBrokerage,Description,PaymentAmountBrokerage,PaymentAmount,UnpaidPaymentBrokerage
	FROM #tempAP0439
	'

PRINT @Sql
PRINT @Sql1

EXEC (@Sql +@Sql1 + @Sql2)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
