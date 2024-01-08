IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP3001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP3001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-----<Summary>
---- Đổ nguồn báo cáo so sánh thu/chi thực tế với kế hoạch thu chi
---- 
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Như Hàn, Date: 28/03/2019
---- Modified by ... on ...:
----<Example>
/*
 EXEC FNP3001 '','',0,'','','',''
*/

CREATE PROCEDURE [dbo].[FNP3001]
		@DivisionID VARCHAR(50),
		@DivisionList NVARCHAR(max) = '',  --Chọn
		@IsDate INT, ---- 1: là ngày, 0: là kỳ
		@FromDate DATETIME,
		@ToDate DATETIME,
		@PeriodList VARCHAR(MAX),
		@TransactionType VARCHAR(50),
		@Ana02ID VARCHAR(50),
		@Ana03ID VARCHAR(50)
				
AS

DECLARE 
	@sSQL VARCHAR(MAX) = '',
	@sWHERE NVARCHAR(MAX) = ''


IF ISNULL(@DivisionList, '') <> '' 
	SET @sWHERE = @sWHERE + ' AND T10.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWHERE = @sWHERE + ' AND T10.DivisionID = '''+@DivisionID+''''

IF @IsDate = 0
	BEGIN
	IF ISNULL(@PeriodList,'') <> ''
		SET @sWHERE = @sWHERE + ' AND ((CASE WHEN T10.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T10.TranMonth)))+''/''+ltrim(Rtrim(str(T10.TranYear))) in ('''+@PeriodList +'''))'
	END
ELSE
	BEGIN
	IF ISNULL(@FromDate,'') <> '' AND ISNULL(@ToDate,'') <> ''
		SET @sWHERE = @sWHERE + ' AND (Convert(varchar(20),T10.VoucherDate,112) Between ''' + Convert(varchar(20),@FromDate,112) + ''' AND ''' + Convert(varchar(20),Isnull(@ToDate,'12/31/9999'),112) + ''')'
	END

IF ISNULL(@TransactionType,'') <> ''
	SET @sWHERE = @sWHERE + ' AND T10.PaymentTypeID = '''+@TransactionType+''''

IF ISNULL(@Ana02ID,'') <> ''
	SET @sWHERE = @sWHERE + ' AND (T11.Ana02ID like ''%' + @Ana02ID + '%'' OR A12.AnaName like N''%' + @Ana02ID + '%'')'

IF ISNULL(@Ana03ID,'') <> ''
	SET @sWHERE = @sWHERE + ' AND (T11.Ana03ID like ''%' + @Ana03ID + '%'' OR A13.AnaName like N''%' + @Ana03ID + '%'')'

SET @sSQL = @sSQL+'
SELECT 
T11.Ana02ID, A12.AnaName As Ana02Name, 
T11.Ana03ID, A13.AnaName As Ana03Name, 
T10.PaymentTypeID As TransactionType, F99.Description AS TransactionTypeName, 
T00.PayMentPlanDate, T10.VoucherDate,
SUM(ISNULL(T01.ApprovalOAmount,T01.OriginalAmount)) As PlanOAmount, SUM(ISNULL(T01.ApprovalCAmount,T01.ConvertedAmount)) As PlanCAmount, 
SUM(T11.RemainOAmount) As RemainOAmount, SUM(T11.RemainCAmount) As RemainCAmount, 
SUM(T11.ActualOAmount) As ActualOAmount, SUM(T11.ActualCAmount) As ActualCAmount
FROM FNT2010 T10 WITH (NOLOCK) 
INNER JOIN FNT2011 T11 WITH (NOLOCK) ON T10.APK = T11.APKMaster
INNER JOIN FNT2001 T01 WITH (NOLOCK) ON T01.APKMaster = T11.InheritAPKMaster AND T01.APK = T11.InheritAPK
INNER JOIN FNT2000 T00 WITH (NOLOCK) ON T01.APKMaster = T00.APK
LEFT JOIN AT1011 A12 WITH (NOLOCK) ON T11.Ana02ID = A12.AnaID AND A12.AnaTypeID = ''A02''
LEFT JOIN AT1011 A13 WITH (NOLOCK) ON T11.Ana03ID = A13.AnaID AND A13.AnaTypeID = ''A03''
LEFT JOIN FNT0099 F99 WITH (NOLOCK) ON T10.PaymentTypeID = F99.ID AND F99.CodeMaster = ''TransactionType''
WHERE 1=1 '+@sWHERE+'
GROUP BY T11.Ana02ID,A12.AnaName,T11.Ana03ID,A13.AnaName,T10.PaymentTypeID, F99.Description, T00.PayMentPlanDate, T10.VoucherDate 
ORDER BY T10.VoucherDate
'


EXEC(@sSQL)
--PRINT @sSQL
	

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
