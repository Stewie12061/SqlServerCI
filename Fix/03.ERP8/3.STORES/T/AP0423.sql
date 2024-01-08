IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0423]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0423]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





---- Created by: Kiều Nga
---- Date: 08/04/2022
---- Purpose: Load danh sách kế thừa hợp đồng
---- Modify on 21/06/2022 Kiều Nga : Lấy thông tin Số tiền chưa thanh toán
---- Modify on 23/06/2022 Kiều Nga : Fix Lỗi kế thừa hợp đồng môi giới không hiển thị đợt thanh toán
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE AP0423
(	
	@DivisionID NVARCHAR(50),
	@FromDate DATETIME,
	@ToDate DATETIME,
	@ContractType NVARCHAR(50),---1 Biên bản ghi nhớ,2 Hợp đồng nguyên tắc,3 hợp đồng thuê đất,4 Hợp đồng môi giới
	@ObjectID NVARCHAR(50)
)			
AS
DECLARE @sql NVARCHAR(MAX) = '',
		@sqlWhere  NVARCHAR(MAX) = '',
		@CustomerName INT

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF ISNULL(@ContractType,'') ='PT'
	SET @sqlWhere = @sqlWhere + ' AND T1.ContractType IN (1,2,3) '
ELSE IF ISNULL(@ContractType,'')<>''
	SET @sqlWhere = @sqlWhere + ' AND T1.ContractType = '+LTRIM(STR(@ContractType))+''

IF ISNULL(@ObjectID,'') <> '' AND ISNULL(@ObjectID,'') <> '%'
SET @sqlWhere = @sqlWhere + ' AND T1.ObjectID = '''+@ObjectID+''''

Set  @sqlWhere = @sqlWhere + ' AND CONVERT(VARCHAR(10), CONVERT(DATE,T1.SignDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''''

IF ISNULL(@ContractType,'') <> '4'
BEGIN
	SET @sql = @sql + N'
	SELECT DISTINCT T1.APK,T1.DivisionID,T1.ContractNo,T1.ContractName,T1.ContractType,T1.SignDate,T1.ObjectID,T2.ObjectName,T1.BeginDate,T1.EndDate,
	T1.CurrencyID,T1.ExchangeRate,T1.Description,T1.OriginalAmount,T1.ConvertedAmount
	FROM CT0155 T1 WITH (NOLOCK) 
	LEFT JOIN CT0157 T3 WITH (NOLOCK) ON T1.APK = T3.APKMaster
	LEFT JOIN AT1202 T2 WITH (NOLOCK) ON T2.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T2.ObjectID = T1.ObjectID
	LEFT JOIN (SELECT T1.APKDetailID ,SUM(ISNULL(T2.ConvertedAmount,0)) AS ConvertedAmount,SUM(ISNULL(T2.OriginalAmount,0)) as OriginalAmount
				FROM CT0157 T1 WITH (NOLOCK)
				INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.ContractDetailID) = T2.InheritVoucherID
				LEFT JOIN CT0155 T3 WITH (NOLOCK) ON T1.APKMaster = T3.APK
				WHERE T2.InheritTableID = ''CT0157'' AND T3.ContractType <> 4
				GROUP BY T1.APKDetailID) A ON A.APKDetailID = T3.APKDetailID
	WHERE T1.DivisionID = '''+@DivisionID +''' AND T1.ConvertedAmount > ISNULL(A.ConvertedAmount,0) ' +@sqlWhere
END
ELSE
BEGIN
	SET @sql = @sql + N'
	SELECT DISTINCT T1.APK,T1.DivisionID,T1.ContractNo,T1.ContractName,T1.ContractType,T1.SignDate,T1.ObjectID,T2.ObjectName,T1.BeginDate,T1.EndDate,
	T1.CurrencyID,T1.ExchangeRate,T1.Description,T1.OriginalAmount,T1.ConvertedAmount
	FROM CT0155 T1 WITH (NOLOCK) 
	LEFT JOIN CT0157 T3 WITH (NOLOCK) ON T1.APK = T3.APKMaster
	LEFT JOIN AT1202 T2 WITH (NOLOCK) ON T2.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T2.ObjectID = T1.ObjectID
	LEFT JOIN (SELECT T1.APK,SUM(ISNULL(T2.ConvertedAmount,0)) AS ConvertedAmount,SUM(ISNULL(T2.OriginalAmount,0)) as OriginalAmount
				FROM CT0157 T1 WITH (NOLOCK)
				INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.ContractDetailID) = T2.InheritVoucherID
				WHERE T2.InheritTableID = ''CT0157''
				GROUP BY T1.APK) A ON A.APK = T3.APK
	WHERE T1.DivisionID = '''+@DivisionID +''' AND T1.ConvertedAmount > ISNULL(A.ConvertedAmount,0) ' +@sqlWhere
END

PRINT @sql
EXEC (@sql)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

