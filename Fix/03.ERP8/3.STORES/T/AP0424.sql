IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0424]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0424]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





---- Created by: Kiều Nga
---- Date: 08/04/2022
---- Purpose: Load danh sách kế thừa hợp đồng
---- Modify on 10/05/2022 Kiều Nga : Lấy thông tin nhóm thuế
---- Modify on 01/06/2022 Kiều Nga : Lấy thông tin tên hợp đồng
---- Modify on 21/06/2022 Kiều Nga : Lấy thông tin Số tiền chưa thanh toán
---- Modify on 23/06/2022 Kiều Nga : Fix Lỗi kế thừa hợp đồng môi giới không hiển thị đợt thanh toán

CREATE PROCEDURE AP0424
(	
	@DivisionID NVARCHAR(50),
	@lstContractID nvarchar(4000)
)			
AS

DECLARE @sql NVARCHAR(MAX) = ''
DECLARE @ContractType NVARCHAR(MAX) = (SELECT TOP 1 ContractType FROM CT0155 WITH (NOLOCK) WHERE APK IN (@lstContractID))

IF ISNULL(@ContractType,'') <> '4'
BEGIN
	SET @sql = @sql + N'
	SELECT cast(0 as tinyint) as IsCheck,T1.APK,T1.DivisionID,T2.CurrencyID,T2.ObjectID,T3.ObjectName,T3.VATNo,T2.ContractNo,
	T2.ExchangeRate,T2.OriginalAmount,T2.ConvertedAmount,T1.Orders,T1.StepName,T1.PaymentPercent,T1.PaymentAmount,T1.RequestDate,
	T1.Notes,T1.ContractDetailID
	,Case when A.ConvertedAmount >0  then 1 else T1.PaymentStatus end as PaymentStatus
	,case when B.VoucherDate is not null then B.VoucherDate else T1.PaymentDate end  as PaymentDate
	,Case when A.ConvertedAmount >0 then A.ConvertedAmount else T1.Paymented end as Paymented
	,T1.PaymentAmount - ISNULL(A.ConvertedAmount,0) as UnpaidPayment,
	(SELECT TOP 1 ISNULL(CT0156.VATGroupID,'''') FROM CT0156 WITH (NOLOCK) WHERE APKMaster =T1.APKMaster) as VATGroupID,
	T2.ContractName
	FROM CT0157 T1 WITH (NOLOCK)
	LEFT JOIN CT0155 T2 WITH (NOLOCK) ON T1.APKMaster = T2.APK
	LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN (''@@@'', T2.DivisionID) AND T2.ObjectID = T3.ObjectID
	LEFT JOIN (SELECT T1.APKDetailID ,SUM(ISNULL(T2.ConvertedAmount,0)) AS ConvertedAmount,SUM(ISNULL(T2.OriginalAmount,0)) as OriginalAmount
				FROM CT0157 T1 WITH (NOLOCK)
				INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.ContractDetailID) = T2.InheritVoucherID
				LEFT JOIN CT0155 T3 WITH (NOLOCK) ON T1.APKMaster = T3.APK
				WHERE T2.InheritTableID = ''CT0157'' AND T3.ContractType <> 4
				GROUP BY T1.APKDetailID) A ON A.APKDetailID = T1.APKDetailID
	LEFT JOIN (SELECT * FROM
				(SELECT ROW_NUMBER() OVER (PARTITION BY T1.APKDetailID ORDER BY T2.VoucherDate DESC) AS rn, T1.APKDetailID, T2.VoucherDate 
						FROM CT0157 T1 WITH (NOLOCK)
						INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.ContractDetailID) = T2.InheritVoucherID
						WHERE T2.InheritTableID = ''CT0157''
				) cte
				WHERE cte.rn = 1) B ON B.APKDetailID = T1.APKDetailID
	WHERE T1.DivisionID = '''+@DivisionID +''' and T1.PaymentAmount > ISNULL(A.ConvertedAmount ,0) and T1.APKMaster in (''' + @lstContractID + ''')' 
END
ELSE
BEGIN
	SET @sql = @sql + N'
	SELECT cast(0 as tinyint) as IsCheck,T1.APK,T1.DivisionID,T2.CurrencyID,T2.ObjectID,T3.ObjectName,T3.VATNo,T2.ContractNo,
	T2.ExchangeRate,T2.OriginalAmount,T2.ConvertedAmount,T1.Orders,T1.StepName,T1.PaymentPercent,T1.PaymentAmount,T1.RequestDate,
	T1.Notes,T1.ContractDetailID
	,Case when A.ConvertedAmount >0  then 1 else T1.PaymentStatus end as PaymentStatus
	,case when B.VoucherDate is not null then B.VoucherDate else T1.PaymentDate end  as PaymentDate
	,Case when A.ConvertedAmount >0 then A.ConvertedAmount else T1.Paymented end as Paymented
	,T1.PaymentAmount - ISNULL(A.ConvertedAmount,0) as UnpaidPayment,
	(SELECT TOP 1 ISNULL(CT0156.VATGroupID,'''') FROM CT0156 WITH (NOLOCK) WHERE APKMaster =T1.APKMaster) as VATGroupID,
	T2.ContractName
	FROM CT0157 T1 WITH (NOLOCK)
	LEFT JOIN CT0155 T2 WITH (NOLOCK) ON T1.APKMaster = T2.APK
	LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN (''@@@'', T2.DivisionID) AND T2.ObjectID = T3.ObjectID
	LEFT JOIN (SELECT T1.APK ,SUM(ISNULL(T2.ConvertedAmount,0)) AS ConvertedAmount,SUM(ISNULL(T2.OriginalAmount,0)) as OriginalAmount
				FROM CT0157 T1 WITH (NOLOCK)
				INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.ContractDetailID) = T2.InheritVoucherID
				WHERE T2.InheritTableID = ''CT0157''
				GROUP BY T1.APK) A ON A.APK = T1.APK
	LEFT JOIN (SELECT * FROM
				(SELECT ROW_NUMBER() OVER (PARTITION BY T1.APK ORDER BY T2.VoucherDate DESC) AS rn, T1.APK, T2.VoucherDate 
						FROM CT0157 T1 WITH (NOLOCK)
						INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.ContractDetailID) = T2.InheritVoucherID
						WHERE T2.InheritTableID = ''CT0157''
				) cte
				WHERE cte.rn = 1) B ON B.APK = T1.APK
	WHERE T1.DivisionID = '''+@DivisionID +''' and T1.PaymentAmount > ISNULL(A.ConvertedAmount ,0) and T1.APKMaster in (''' + @lstContractID + ''')' 
END

EXEC (@sql)
PRINT @sql

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

