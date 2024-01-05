IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0377_BT]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0377_BT]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In báo cáo chi phí theo khoản mục phí từng phòng ban cho khách hàng Bê tông Long An (CustomizeIndex = 80) tại ERP 9.0\T
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tiểu Mai on 25/09/2017
---- Modified by ... on ...
-- <Example>
/*
exec AP0377_BT 'BT', '2017-07-01 00:00:00.000', '2017-07-31 00:00:00.000', 7, 2017, 7, 2017, 0, 'CL/02/2016/0001', 'XN03', 'CH01', 'TO03'

*/


CREATE PROCEDURE [dbo].[AP0377_BT]
				 	@DivisionID NVARCHAR(50) ,
					@FromDate DATETIME,
					@ToDate DATETIME,
					@FromMonth INT,
					@FromYear INT,
					@ToMonth INT,
					@ToYear INT,
					@IsDate TINYINT,	--- 0: theo kỳ
										--- 1: theo ngày
					@FromAna01ID NVARCHAR(50),
					@ToAna01ID NVARCHAR(50),
					@FromDepartmentID NVARCHAR(50),
					@ToDepartmentID NVARCHAR(50) 
 AS

DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX)

SET @sSQL = N''
SET @sSQL1 = N''
SET @sWhere = N''

IF @IsDate = 1
BEGIN
	SET @sWhere = @sWhere + N' AND CONVERT(NVARCHAR(10),VoucherDate,101) BETWEEN '''+CONVERT(NVARCHAR(10),@FromDate,101)+''' AND '''+CONVERT(NVARCHAR(10),@ToDate,101)+''''
END
ELSE
BEGIN
	SET @sWhere = @sWhere + N' AND TranMonth + TranYear*100 BETWEEN '+CONVERT(NVARCHAR(10),@FromMonth+@FromYear*100)+' AND '+CONVERT(NVARCHAR(10),@ToMonth+@ToYear*100)
END

SET @sSQL = '
	SELECT AV5000.DivisionID, Ana01ID, A01.AnaName AS Ana01Name, Ana02ID, A02.AnaName AS Ana02Name,
		SUM(CASE WHEN D_C = ''D'' THEN OriginalAmount ELSE -OriginalAmount END) AS OriginalAmount,
		SUM(CASE WHEN D_C = ''D'' THEN ConvertedAmount ELSE -ConvertedAmount END) AS ConvertedAmount
	INTO #TEMP
	FROM AV5000
	LEFT JOIN AT1005 A15 WITH (NOLOCK) ON A15.AccountID  = AV5000.AccountID
	LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaID  = AV5000.Ana01ID AND A01.AnaTypeID  = ''A01''
	LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaID  = AV5000.Ana02ID AND A02.AnaTypeID  = ''A02''
	WHERE AV5000.DivisionID = '''+@DivisionID+'''
		AND A15.GroupID = ''G06''
		AND ISNULL(Ana01ID,'''') BETWEEN '''+@FromAna01ID+''' AND '''+@ToAna01ID+'''
		AND ISNULL(Ana02ID,'''') BETWEEN '''+@FromDepartmentID+''' AND '''+@ToDepartmentID+'''
		' +@sWhere+ '
	GROUP BY AV5000.DivisionID, Ana01ID, Ana02ID, A01.AnaName, A02.AnaName
	
'

SET @sSQL1 = '
	SELECT T.*, A.Amount_Ana01, B.Amount_Ana02, C.TotalAmount,
			 CASE WHEN ISNULL(C.TotalAmount,0) <> 0 THEN A.Amount_Ana01/C.TotalAmount*100 ELSE 0 END as Rate_Ana01,
			 CASE WHEN ISNULL(B.Amount_Ana02,0) <> 0 THEN T.ConvertedAmount/B.Amount_Ana02*100 ELSE 0 END as Rate_Ana02
	FROM #TEMP T
	LEFT JOIN (
	SELECT Ana01ID, SUM(ISNULL(ConvertedAmount,0)) AS Amount_Ana01 FROM #TEMP
	GROUP BY Ana01ID ) A ON ISNULL(A.Ana01ID,'''') = ISNULL(T.Ana01ID,'''')
	LEFT JOIN (
	SELECT Ana02ID, SUM(ISNULL(ConvertedAmount,0)) AS Amount_Ana02 FROM #TEMP
	GROUP BY Ana02ID ) B ON ISNULL(B.Ana02ID,'''') = ISNULL(T.Ana02ID,'''')
	LEFT JOIN (
	SELECT DivisionID, SUM(ISNULL(ConvertedAmount,0)) AS TotalAmount FROM #TEMP
	GROUP BY DivisioNID ) C ON C.DivisionID  = T.DivisionID
'

--PRINT @sSQL
--PRINT @sSQL1

EXEC (@sSQL+@sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
