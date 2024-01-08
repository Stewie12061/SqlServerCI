IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0139]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0139]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Bao cao thu chi (Income & Expenese report) (ANGEL)
---- Modified by Bảo Anh on 27/05/2017: Sửa danh mục dùng chung
---- Modified by Hải Long on 31/05/2017: Sửa dữ liệu của dòng Selling
---- Modified by Nhật Thanh on 8/12/2021: Customize Angel
---- Modified by Nhật Thanh on 24/03/2022: Bổ sung điều kiện load dữ liệu cho angel
-- <Param>

CREATE PROCEDURE [dbo].[AP0139] 
		@DivisionID NVARCHAR(50),
		@FromPeriod NVARCHAR(50),
		@ToPeriod NVARCHAR(50),		
		@FromDate NVARCHAR(50),
		@ToDate NVARCHAR(50),
		@IsDate TINYINT -- 0: Theo kỳ, 1: Theo ngày

AS

DECLARE	@sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sSQL3 NVARCHAR(MAX),
		@sSQL4 NVARCHAR(MAX),		
		@sWhere NVARCHAR(MAX),
		@sWhere2 NVARCHAR(MAX),		
		@FromPeriodText NVARCHAR(10),
		@ToPeriodText NVARCHAR(10),
		@FromDateText NVARCHAR(10),
		@ToDateText NVARCHAR(10),
		@CustomerName int

SET @CustomerName = (Select top 1 CustomerName from CustomerIndex)		
SET @FromPeriodText = CONVERT(NVARCHAR(10), @FromPeriod)		
SET @ToPeriodText = CONVERT(NVARCHAR(10), @ToPeriod)	
SET @FromDateText = CONVERT(NVARCHAR(10), @FromDate, 21)		
SET @ToDateText = CONVERT(NVARCHAR(10), @ToDate, 21)					

IF @IsDate = 0
BEGIN
	SET @sWhere = 'AND TranMonth + TranYear*100 BETWEEN ' + @FromPeriodText + ' AND ' + @ToPeriodText
	SET @sWhere2 = 'V01.TranMonth + V01.TranYear*100 < ' + @FromPeriodText
END
ELSE
BEGIN
	SET @sWhere = 'AND VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''''
	SET @sWhere2 = 'V01.VoucherDate < ''' + @FromDateText + ''''
END	

SET @sSQL1 = '
SELECT Ana04ID, SUM(ConvertedAmount) AS ConvertedAmount
INTO #TEMP1
FROM AT9000 WITH (NOLOCK)
INNER JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AT9000.CreditAccountID
WHERE AT9000.DivisionID = ''' + @DivisionID + ''' 
AND AT1005.GroupID <> ''G00''
AND (CreditAccountID LIKE ''111%'' OR CreditAccountID LIKE ''112%'''+case when @CustomerName=57 then ' OR CreditAccountID LIKE ''113%'' OR CreditAccountID LIKE ''121%''' else '' end +  ' OR CreditAccountID IN (''1132'', ''1411'', ''1412'''+ case when @CustomerName=57 then ', ''1414''' else '' end +'))
' + @sWhere + '
AND TransactionTypeID NOT IN (''T00'', ''Z00'')
AND Ana04ID IS NOT NULL 
GROUP BY Ana04ID

SELECT		V01.DivisionID, SUM(ISNULL(SignAmount, 0)) AS Opening	
INTO #TEMP2				
FROM		AV4301 AS V01
INNER JOIN	AT1005 AS T1 with (nolock) ON T1.AccountID = V01.AccountID
WHERE		V01.DivisionID = ''' + @DivisionID + ''' 
			AND T1.GroupID <> ''G00''
			' + case when @CustomerName = 57 then '	AND (V01.AccountID LIKE ''111%'' OR V01.AccountID LIKE ''112%'' OR V01.AccountID LIKE ''113%'' 
				OR V01.AccountID LIKE ''121%'' OR V01.AccountID LIKE ''1281%'' OR V01.AccountID LIKE ''1282%'' OR V01.AccountID IN (''1132'', ''1411'', ''1412'',''1414''))'
			else '
			AND (V01.AccountID LIKE ''111%'' OR V01.AccountID LIKE ''112%'' OR V01.AccountID LIKE ''1281%'' OR V01.AccountID IN (''1132'', ''1411'', ''1412''))' end + '
			AND V01.Ana04ID IS NOT NULL 
			AND (' + @sWhere2 + ' OR V01.TransactionTypeID IN(''T00'', ''Z00''))
GROUP BY 	V01.DivisionID		
'

SET @sSQL2 = '						
SELECT		ABS(SUM(ISNULL(SignAmount, 0))) AS ConvertedAmount	
INTO #TEMP3			
FROM		AV4301 AS V01
INNER JOIN	AT1005 AS T1 with (nolock) ON T1.AccountID = V01.AccountID
WHERE		V01.DivisionID = ''' + @DivisionID + ''' 
			AND T1.GroupID <> ''G00''
			AND V01.AccountID LIKE ''131%''
			AND D_C = ''C''			
			AND (V01.CorAccountID LIKE ''111%'' OR V01.CorAccountID LIKE ''112%'')
			' + @sWhere + '			
			
SELECT SUM(ConvertedAmount) AS ConvertedAmount
INTO #TEMP4
FROM AT9000 WITH (NOLOCK)
INNER JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AT9000.CreditAccountID
WHERE AT9000.DivisionID = ''' + @DivisionID + ''' 
AND AT1005.GroupID <> ''G00''
AND (DebitAccountID LIKE ''111%'' OR DebitAccountID LIKE ''112%'' OR DebitAccountID IN (''1411'', ''1412'''+ case when @CustomerName=57 then ', ''1414''' else '' end +'))
' + @sWhere + '
AND TransactionTypeID NOT IN (''T00'', ''Z00'')
AND Ana04ID IS NOT NULL 
AND Ana04ID NOT IN (''22'', ''00'')
'		
						
SET @sSQL3 = '
SELECT 	
''' + @DivisionID + ''' AS DivisionID, ''I'' AS Part, ''1'' AS ID, ''Selling'' AS Name, ConvertedAmount AS Amount
INTO #TEMP5
FROM #TEMP3 

UNION ALL

SELECT 	
''' + @DivisionID + ''' AS DivisionID, ''I'' AS Part, ''2'' AS ID, ''Investment'' AS Name, 0 AS Amount 

UNION ALL

SELECT 	
''' + @DivisionID + ''' AS DivisionID, ''I'' AS Part, ''3'' AS ID, ''Others'' AS Name, ConvertedAmount AS Amount 
FROM #TEMP4

UNION ALL

SELECT 
''' + @DivisionID + ''' AS DivisionID, ''II'' AS Part, ''1'' AS ID, ''Salary'' AS Name, 
SUM(CASE WHEN Ana04ID IN (''01'', ''09'', ''10'', ''11'', ''17'', ''19'') THEN ConvertedAmount ELSE 0 END) AS Amount 
FROM #TEMP1

UNION ALL

SELECT 
''' + @DivisionID + ''' AS DivisionID, ''II'' AS Part, ''2'' AS ID, ''Material, carton box' + case when @CustomerName = 57 then ''else ' (Zlink: 1,086 USD;  Fabric - CHANGXING: 92,316.82 USD,   Guangzhou: 14,225 USD )' end + ''' AS Name, 
SUM(CASE WHEN Ana04ID IN (''04'', ''16'', ''20'', ''21'', ''34'') THEN ConvertedAmount ELSE 0 END) AS Amount 
FROM #TEMP1

UNION ALL

SELECT 
''' + @DivisionID + ''' AS DivisionID, ''II'' AS Part, ''3'' AS ID, ''Fixed assets'' AS Name, 
SUM(CASE WHEN Ana04ID IN (''15'', ''29'') THEN ConvertedAmount ELSE 0 END) AS Amount 
FROM #TEMP1

UNION ALL

SELECT 
''' + @DivisionID + ''' AS DivisionID, ''II'' AS Part, ''4'' AS ID, ''Internet, power, tel, water fee'' AS Name, 
SUM(CASE WHEN Ana04ID IN (''06'', ''07'', ''23'') THEN ConvertedAmount ELSE 0 END) AS Amount 
FROM #TEMP1

UNION ALL

SELECT	
''' + @DivisionID + ''' AS DivisionID, ''II'' AS Part, ''5'' AS ID, ''Office, factory, land rental fee'' AS Name, 
SUM(CASE WHEN Ana04ID IN (''12'') THEN ConvertedAmount ELSE 0 END) AS Amount 
FROM #TEMP1

UNION ALL

SELECT 
''' + @DivisionID + ''' AS DivisionID, ''II'' AS Part, ''6'' AS ID, ''VAT and import tax'' AS Name, 
SUM(CASE WHEN Ana04ID IN (''27'') THEN ConvertedAmount ELSE 0 END) AS Amount 
FROM #TEMP1

UNION ALL

SELECT 
''' + @DivisionID + ''' AS DivisionID, ''II'' AS Part, ''7'' AS ID, ''Delivery fee (include importing and exporting fee)'' AS Name, 
SUM(CASE WHEN Ana04ID IN (''13'') THEN ConvertedAmount ELSE 0 END) AS Amount 
FROM #TEMP1

UNION ALL

SELECT 
''' + @DivisionID + ''' AS DivisionID, ''II'' AS Part, ''8'' AS ID, ''Promotion and business fee'' AS Name, 
SUM(CASE WHEN Ana04ID IN (''05'', ''08'') THEN ConvertedAmount ELSE 0 END) AS Amount 
FROM #TEMP1

UNION ALL

SELECT 
''' + @DivisionID + ''' AS DivisionID, ''II'' AS Part, ''9'' AS ID, ''Goods returns'' AS Name, 
SUM(CASE WHEN Ana04ID IN (''28'') THEN ConvertedAmount ELSE 0 END) AS Amount 
FROM #TEMP1

UNION ALL

SELECT 
''' + @DivisionID + ''' AS DivisionID, ''II'' AS Part, ''10'' AS ID, ''Others'' AS Name, 
SUM(CASE WHEN Ana04ID IN (''02'', ''14'', ''24'', ''25'', ''26'', ''30'', ''31'', ''32'', ''33'', ''36'', ''37'', ''38'', ''39'', ''40'''+case when @CustomerName = 57 then ', ''41''' else '' end +', ''99'') THEN ConvertedAmount ELSE 0 END) AS Amount 
FROM #TEMP1

UNION ALL

SELECT 
''' + @DivisionID + ''' AS DivisionID, ''II'' AS Part, ''11'' AS ID, ''Fostering for female workers'' AS Name, 
SUM(CASE WHEN Ana04ID IN (''44'') THEN ConvertedAmount ELSE 0 END) AS Amount 
FROM #TEMP1

UNION ALL

SELECT 
''' + @DivisionID + ''' AS DivisionID, ''II'' AS Part, ''12'' AS ID, ''Goods'' AS Name, 
SUM(CASE WHEN Ana04ID IN (''45'') THEN ConvertedAmount ELSE 0 END) AS Amount 
FROM #TEMP1
'+ case when @CustomerName = 57 then '
UNION ALL
SELECT 
''' + @DivisionID + ''' AS DivisionID, ''II'' AS Part, ''13'' AS ID, ''Loan'' AS Name, 
SUM(CASE WHEN Ana04ID IN (''48'') THEN ConvertedAmount ELSE 0 END) AS Amount 
FROM #TEMP1' else '' end

SET @sSQL4 = '
SELECT #TEMP5.*, #TEMP2.Opening
FROM #TEMP5
LEFT JOIN #TEMP2 ON #TEMP2.DivisionID = #TEMP5.DivisionID
' 


PRINT @sSQL1
PRINT @sSQL2
PRINT @sSQL3
PRINT @sSQL4
EXEC (@sSQL1 + @sSQL2 + @sSQL3 + @sSQL4)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
