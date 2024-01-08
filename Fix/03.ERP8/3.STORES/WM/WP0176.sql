IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0176]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[WP0176]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





---- Created by: Kiều Nga
---- Date: 08/04/2022
---- Purpose: Load danh sách kế thừa hợp đồng
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE WP0176
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

SET @sql = @sql + N'
SELECT T1.APK,T1.DivisionID,T1.ContractNo,T1.ContractName,T1.ContractType,T1.SignDate,T1.ObjectID,T2.ObjectName,T1.BeginDate,T1.EndDate,
T1.CurrencyID,T1.ExchangeRate,T1.Description,T1.OriginalAmount,T1.ConvertedAmount
FROM CT0155 T1 WITH (NOLOCK) 
LEFT JOIN AT1202 T2 WITH (NOLOCK) ON T2.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T2.ObjectID = T1.ObjectID
WHERE T1.DivisionID = '''+@DivisionID +''' ' +@sqlWhere

PRINT @sql
EXEC (@sql)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

