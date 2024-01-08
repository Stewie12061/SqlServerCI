IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0433]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0433]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
---- Load danh sách detail các khoản doanh thu theo ô vựa 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 19/04/2022 by Kiều Nga
----Modify on 23/04/2022 by Kiều Nga : Fix lỗi Load khoản thu đã kế thừa
-- <Example>
/*  

 EXEC AP0433 @DivisionID = 'CBD', @ContractNo = N'A1'',''B1'',''B2', @VoucherID = '4854C969-111A-41B7-AE4D-4B76310ADCE6',@IsDate= 0, @isType = '1',@FromMonth = 12,@FromYear = 2018,@ToMonth = 12,@ToYear = 2018

 AP0433 @DivisionID, @ContractNo , @VoucherID, @isType,@FromMonth,@FromYear,@ToMonth,@ToYear

*/
----
CREATE PROCEDURE AP0433 ( 
        @DivisionID VARCHAR(50),
		@ContractNo XML,
		@VoucherID VARCHAR (50), 
		@IsDate TINYINT,
		@isType TINYINT, --- 0 new, 1: edit
		@FromMonth INT,
		@FromYear INT, 
		@ToMonth INT,
		@ToYear INT

)
AS

Declare @sSQL as varchar(max),
        @sWhere as varchar (max)= ''

IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#TBLContractNoTmp')) 
		DROP TABLE #TBLContractNoTmp

 CREATE TABLE #TBLContractNoTmp
	(
		ContractNo varchar(50),
		ObjectID varchar(50)
	)

CREATE CLUSTERED INDEX ix_TBLContractNoTmp ON #TBLContractNoTmp ([ContractNo],[ObjectID]);

INSERT INTO	#TBLContractNoTmp		
SELECT	DISTINCT
		X.Data.query('ContractNo').value('.', 'VARCHAR(50)') AS ContractNo,
		X.Data.query('ObjectID').value('.', 'VARCHAR(50)') AS ObjectID
FROM	@ContractNo.nodes('//Data') AS X (Data)

 IF @IsDate = 1
 SET @sWhere = 'And (T1.TranMonth + T1.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' and ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50)) + ')'

 	IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#TAM')) 
		DROP TABLE #TAM

 CREATE TABLE #TAM
	(
		APK nvarchar(50) ,
		ConvertedAmount decimal(28,8),
		OriginalAmount decimal(28,8)
	)

-----Lấy khoản thu chưa thanh toán đủ tiền 
 Set  @sSQL = '
	INSERT INTO #TAM  (APK,ConvertedAmount,OriginalAmount)
	SELECT T1.APK AS APK,ISNULL(H.ConvertedAmount,0),ISNULL(H.OriginalAmount,0)
	FROM AT0420 T1 WITH (NOLOCK)
	LEFT JOIN (SELECT SUM(ISNULL(T2.ConvertedAmount,0)) AS ConvertedAmount,SUM(ISNULL(T2.OriginalAmount,0)) as OriginalAmount,T1.APK 
				FROM AT0420 T1 WITH (NOLOCK)
				INNER JOIN AT9000 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.APK) = T2.InheritVoucherID
				INNER JOIN #TBLContractNoTmp Temp WITH (NOLOCK) ON Temp.ContractNo = T1.ContractNo AND Temp.ObjectID = T1.ObjectID
				WHERE T2.InheritTableID = ''AT0420''
				GROUP BY T1.APK) AS H ON H.APK = T1.APK  
	INNER JOIN #TBLContractNoTmp Temp WITH (NOLOCK) ON Temp.ContractNo = T1.ContractNo AND Temp.ObjectID = T1.ObjectID
	WHERE T1.DivisionID = ''' +@DivisionID+ ''' 
	AND T1.Amount > ISNULL(H.ConvertedAmount,0)
	' + @sWhere + ' 
	ORDER BY T1.ContractNo	
	'

	EXEC(@sSQL)

	SET @sSQL = '
	SELECT T1.APK, T1.ContractNo,T1.CostTypeID,T1.Amount, ISNULL (T1.Amount,0) - ISNULL(SUM(T5.ConvertedAmount),0) AS EndConvertedAmount, T2.Description as CostTypeName,
	CAST (T1.TranMonth AS nvarchar)  + ''/'' + CAST (T1.TranYear AS nvarchar) AS Date,T1.ObjectID, T4.ObjectName, T4.Contactor,T4.Address,T1.Description,T1.CurrencyID,
	T1.ExchangeRate, ISNULL (T1.OriginalAmount,0) - ISNULL(SUM(T5.OriginalAmount),0) AS OriginalAmount
	FROM AT0420 T1 WITH (NOLOCK)
	LEFT JOIN AT0099 T2 WITH (NOLOCK) ON T2.ID = T1.CostTypeID AND T2.CodeMaster = ''CostTypeID'' AND T2.Disabled = 0
	LEFT JOIN AT1202 T4 WITH (NOLOCK) ON T4.DivisionID IN  (T1.DivisionID,''@@@'') AND T4.ObjectID = T1.ObjectID
	LEFT JOIN (SELECT SUM(OriginalAmount) AS OriginalAmount,SUM(ConvertedAmount) AS ConvertedAmount,InheritVoucherID FROM AT9000 WITH (NOLOCK) WHERE DivisionID = ''' + @DivisionID + ''' AND InheritTableID = ''AT0420''
				GROUP BY InheritVoucherID
				) AS T5 ON T5.InheritVoucherID = CONVERT (VARCHAR (50),T1.APK )
	INNER JOIN (SELECT * FROM #TBLContractNoTmp WITH (NOLOCK)) R2 ON R2.ContractNo = T1.ContractNo AND R2.ObjectID = T1.ObjectID
	INNER JOIN #TAM WITH (NOLOCK) ON #TAM.APK = T1.APK
	WHERE T1.DivisionID = ''' + @DivisionID + ''' 
	' + @sWhere + ' 
	GROUP BY T1.APK, T1.ContractNo , T1.CostTypeID,T1.Amount,T5.ConvertedAmount,T2.Description,T1.TranMonth,
	T1.TranYear,T1.ObjectID, T4.ObjectName, T4.Contactor,T4.Address,T1.Description,T1.CurrencyID,T1.ExchangeRate,T1.OriginalAmount
	ORDER BY T1.ContractNo
	
	'

print (@sSQL)
EXEC(@sSQL)









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
