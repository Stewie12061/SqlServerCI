IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CP0198]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CP0198]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





---- Created by: Kiều Nga
---- Date: 29/03/2022
---- Purpose: Loc danh sách hợp đồng thuê đất SIKICO
---- Modify on 20/04/2022 Kiều Nga: Bổ sung load các trường chỉ số ban đầu
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE CP0198
(	
	@DivisionID NVARCHAR(50),
	@FromMonth INT,
  	@FromYear INT,
	@ToMonth INT,
	@ToYear INT,  
	@FromDate DATETIME,
	@ToDate DATETIME,
	@IsDate TINYINT, ----0 theo ky, 1 theo ngày
	@ContractType TINYINT,---1 Biên bản ghi nhớ,2 Hợp đồng nguyên tắc,3 hợp đồng thuê đất,4 Hợp đồng môi giới
	@ObjectID NVARCHAR(50)
)			
AS
DECLARE @sql NVARCHAR(MAX) = '',
		@sqlWhere  NVARCHAR(MAX) = '',
		@CustomerName INT

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF ISNULL(@ContractType,'')<>''
SET @sqlWhere = @sqlWhere + ' AND T1.ContractType = '+LTRIM(STR(@ContractType))+''

IF ISNULL(@ObjectID,'') <> '' AND ISNULL(@ObjectID,'') <> '%'
SET @sqlWhere = @sqlWhere + ' AND T1.ObjectID = '''+@ObjectID+''''

SET @sql = @sql + N'
SELECT T1.APK,T1.DivisionID,T1.ContractNo,T1.VoucherTypeID,T1.ContractName,T1.ContractType,T1.SignDate,T1.ObjectID,T2.ObjectName,
T2.Address,T2.VATNo,T2.Contactor,T2.Tel,T2.Fax,T1.BeginDate,T1.EndDate,T1.CurrencyID,T1.ExchangeRate,T1.Description,
T1.OriginalAmount,T1.ConvertedAmount,T1.AdministrativeExpenses,T1.RegistrationWater,T1.RegistrationElectricity,T1.RegistrationEnvironmentalFees,
T1.ConvertedAmountLandLease,T1.ConvertedAmountBrokerage,T1.HandOverDate,T1.AdministrativeExpensesDate,T1.ContractID
FROM CT0155 T1 WITH (NOLOCK) 
LEFT JOIN AT1202 T2 WITH (NOLOCK) ON T2.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T2.ObjectID = T1.ObjectID
WHERE T1.DivisionID = '''+@DivisionID +'''' +@sqlWhere

EXEC (@sql)
PRINT @sql

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

