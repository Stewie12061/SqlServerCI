IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0140]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0140]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- In báo cáo tổng hợp phát sinh tài khoản (ANGEL)
-- <Param>

CREATE PROCEDURE [dbo].[AP0140] 
		@DivisionID NVARCHAR(50),
		@FromPeriod NVARCHAR(50),
		@ToPeriod NVARCHAR(50),		
		@FromDate DATETIME,
		@ToDate DATETIME,
		@FromAccountID NVARCHAR(50),
		@ToAccountID NVARCHAR(50),
		@FromCorAccountID NVARCHAR(50),
		@ToCorAccountID NVARCHAR(50),				
		@FromObjectID NVARCHAR(50),
		@ToObjectID NVARCHAR(50),
		@FromAna04ID NVARCHAR(50),
		@ToAna04ID NVARCHAR(50),			
		@FromAna06ID NVARCHAR(50),
		@ToAna06ID NVARCHAR(50),
		@IsDate TINYINT, -- 0: Theo kỳ, 1: Theo ngày
		@Mode TINYINT -- 0: Nhóm theo đối tương
		              -- 1: Nhóm theo khooản mục chi phí
		              -- 2: Nhóm theo thuế suất thuế TNDN									
AS

DECLARE @sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sSQL3 NVARCHAR(MAX),
		@FromPeriodText NVARCHAR(10),
		@ToPeriodText NVARCHAR(10),
		@FromDateText NVARCHAR(10),
		@ToDateText NVARCHAR(10)
		
SET @FromPeriodText = CONVERT(NVARCHAR(10), @FromPeriod)		
SET @ToPeriodText = CONVERT(NVARCHAR(10), @ToPeriod)	
SET @FromDateText = CONVERT(NVARCHAR(10), @FromDate, 21)		
SET @ToDateText = CONVERT(NVARCHAR(10), @ToDate, 21)	

IF @IsDate = 0
BEGIN
	SET @sSQL1 = '
	SELECT		V01.DivisionID,
				V01.AccountID,
				V01.CorAccountID,				
				V01.ObjectID,
				V01.Ana04ID,
				V01.Ana06ID,
				SUM(ISNULL(SignAmount, 0)) AS Closing,
				SUM(CASE WHEN (V01.TranYear * 100 + V01.TranMonth) < ' + @FromPeriodText + '
								OR V01.TransactionTypeID IN(''T00'', ''Z00'') THEN ISNULL(SignAmount, 0) 
					ELSE 0 END) AS Opening,
				SUM(CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ' + @FromPeriodText + '
							   AND V01.D_C = ''D'' AND (V01.TransactionTypeID NOT IN(''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL) 
					THEN ISNULL(SignAmount, 0) ELSE 0 END) AS PeriodDebit,
				SUM(CASE WHEN (V01.TranYear * 100 + V01.TranMonth) >= ' + @FromPeriodText + '
								AND V01.D_C = ''C''
								AND (V01.TransactionTypeID NOT IN(''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
					THEN ISNULL(SignAmount, 0) * (-1) ELSE 0 END) AS PeriodCredit
	INTO #TEMP1				
	FROM		AV4301 AS V01
	INNER JOIN	AT1005 AS T1 with (nolock) ON T1.AccountID = V01.AccountID AND T1.DivisionID in (''@@@'',V01.DivisionID)
	WHERE		V01.DivisionID = ''' + @DivisionID + '''
				AND T1.GroupID <> ''G00''
				AND V01.AccountID BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + '''
				AND (V01.TranYear * 100 + V01.TranMonth <= ' + @ToPeriodText + ' OR V01.TransactionTypeID IN(''T00'', ''Z00''))
	GROUP BY	V01.DivisionID, V01.AccountID, V01.CorAccountID, V01.ObjectID, V01.Ana04ID, V01.Ana06ID
	'	
END
ELSE
BEGIN
	SET @sSQL1 = '
	SELECT		V01.DivisionID,
				V01.AccountID,
				V01.CorAccountID,				
				V01.ObjectID,
				V01.Ana04ID,
				V01.Ana06ID,
				SUM(ISNULL(SignAmount, 0)) AS Closing,
				SUM(CASE WHEN V01.VoucherDate < ''' + @FromDateText + '''
								OR V01.TransactionTypeID IN(''T00'', ''Z00'') THEN ISNULL(SignAmount, 0) 
					ELSE 0 END) AS Opening,
				SUM(CASE WHEN V01.VoucherDate >= ''' + @FromDateText + '''
							   AND V01.D_C = ''D'' AND (V01.TransactionTypeID NOT IN(''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL) 
					THEN ISNULL(SignAmount, 0) ELSE 0 END) AS PeriodDebit,
				SUM(CASE WHEN V01.VoucherDate >= ''' + @FromDateText + '''
								AND V01.D_C = ''C''
								AND (V01.TransactionTypeID NOT IN(''T00'', ''Z00'') OR V01.TransactionTypeID IS NULL)
					THEN ISNULL(SignAmount, 0) * (-1) ELSE 0 END) AS PeriodCredit
	INTO #TEMP1				
	FROM		AV4301 AS V01
	INNER JOIN	AT1005 AS T1 with (nolock) ON T1.AccountID = V01.AccountID AND T1.DivisionID in (''@@@'',V01.DivisionID)
	WHERE		V01.DivisionID = ''' + @DivisionID + '''
				AND T1.GroupID <> ''G00''
				AND V01.AccountID BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + '''
				AND (V01.VoucherDate <= ''' + @ToDateText + ''' OR V01.TransactionTypeID IN(''T00'', ''Z00''))
	GROUP BY	V01.DivisionID, V01.AccountID, V01.CorAccountID, V01.ObjectID, V01.Ana04ID, V01.Ana06ID
	'		
END	

IF @Mode = 0
BEGIN
	SET @sSQL2 = '
	SELECT #TEMP1.DivisionID, #TEMP1.ObjectID AS GroupID, AT1202.ObjectName AS GroupName,
		   SUM(Opening) AS Opening,
		   SUM(CASE WHEN Opening > 0 THEN Opening ELSE 0 END) AS DebitOpening,
		   SUM(CASE WHEN Opening < 0 THEN -1*Opening ELSE 0 END) AS CreditOpening,
		   SUM(PeriodDebit) AS PeriodDebit, SUM(PeriodCredit) AS PeriodCredit, 
		   SUM(Closing) AS Closing,
		   SUM(CASE WHEN Closing > 0 THEN Closing ELSE 0 END) AS DebitClosing,
		   SUM(CASE WHEN Closing < 0 THEN -1*Closing ELSE 0 END) AS CreditClosing  
	INTO #TEMP2			   	
	FROM #TEMP1	
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID in (''@@@'',#TEMP1.DivisionID) AND AT1202.ObjectID = #TEMP1.ObjectID
	WHERE #TEMP1.ObjectID BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + '''
	AND #TEMP1.CorAccountID BETWEEN ''' + @FromCorAccountID + ''' AND ''' + @ToCorAccountID + '''	
	GROUP BY #TEMP1.DivisionID, #TEMP1.ObjectID, AT1202.ObjectName
	ORDER BY #TEMP1.ObjectID
	'	
END
ELSE
IF @Mode = 1
BEGIN
	SET @sSQL2 = '
	SELECT #TEMP1.DivisionID, #TEMP1.Ana04ID AS GroupID, AT1011.AnaName AS GroupName,
		   SUM(Opening) AS Opening,
		   SUM(CASE WHEN Opening > 0 THEN Opening ELSE 0 END) AS DebitOpening,
		   SUM(CASE WHEN Opening < 0 THEN -1*Opening ELSE 0 END) AS CreditOpening,
		   SUM(PeriodDebit) AS PeriodDebit, SUM(PeriodCredit) AS PeriodCredit, 
		   SUM(Closing) AS Closing,
		   SUM(CASE WHEN Closing > 0 THEN Closing ELSE 0 END) AS DebitClosing,
		   SUM(CASE WHEN Closing < 0 THEN -1*Closing ELSE 0 END) AS CreditClosing  	
	INTO #TEMP2		   
	FROM #TEMP1	
	LEFT JOIN AT1011 WITH (NOLOCK) ON AT1011.DivisionID in (''@@@'',#TEMP1.DivisionID) AND AT1011.AnaID = #TEMP1.Ana04ID AND AT1011.AnaTypeID = ''A04''
	WHERE (#TEMP1.Ana04ID BETWEEN ''' + @FromAna04ID + ''' AND ''' + @ToAna04ID + ''') OR (#TEMP1.Ana04ID = '''')
	GROUP BY #TEMP1.DivisionID, #TEMP1.Ana04ID, AT1011.AnaName
	ORDER BY #TEMP1.Ana04ID
	'		
END
ELSE
BEGIN
	SET @sSQL2 = '
	SELECT #TEMP1.DivisionID, #TEMP1.Ana06ID AS GroupID, AT1011.AnaName AS GroupName,
		   SUM(Opening) AS Opening,
		   SUM(CASE WHEN Opening > 0 THEN Opening ELSE 0 END) AS DebitOpening,
		   SUM(CASE WHEN Opening < 0 THEN -1*Opening ELSE 0 END) AS CreditOpening,
		   SUM(PeriodDebit) AS PeriodDebit, SUM(PeriodCredit) AS PeriodCredit, 
		   SUM(Closing) AS Closing,
		   SUM(CASE WHEN Closing > 0 THEN Closing ELSE 0 END) AS DebitClosing,
		   SUM(CASE WHEN Closing < 0 THEN -1*Closing ELSE 0 END) AS CreditClosing  	
	INTO #TEMP2			   
	FROM #TEMP1	
	LEFT JOIN AT1011 WITH (NOLOCK) ON AT1011.DivisionID in (''@@@'',#TEMP1.DivisionID) AND AT1011.AnaID = #TEMP1.Ana06ID AND AT1011.AnaTypeID = ''A06''
	WHERE #TEMP1.Ana06ID BETWEEN ''' + @FromAna06ID + ''' AND ''' + @ToAna06ID + '''
	GROUP BY #TEMP1.DivisionID, #TEMP1.Ana06ID, AT1011.AnaName
	ORDER BY #TEMP1.Ana06ID
	'				
END	


SET @sSQL3 = '
	SELECT #TEMP2.DivisionID, GroupID, GroupName, Opening,
		   CASE WHEN Opening > 0 THEN Opening ELSE 0 END AS DebitOpening,
		   CASE WHEN Opening < 0 THEN -1*Opening ELSE 0 END AS CreditOpening,
		   PeriodDebit, PeriodCredit, Closing, 
		   CASE WHEN Closing > 0 THEN Closing ELSE 0 END AS DebitClosing,
		   CASE WHEN Closing < 0 THEN -1*Closing ELSE 0 END AS CreditClosing,  
		   ''' + @FromAccountID + ''' AS FromAccountID, ''' + @ToAccountID + ''' AS ToAccountID	   	
	FROM #TEMP2 		   		   
'


PRINT @sSQL1
PRINT @sSQL2
PRINT @sSQL3

EXEC (@sSQL1 + @sSQL2 + @sSQL3)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
