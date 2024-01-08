IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP3002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP3002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-----<Summary>
---- Đổ nguồn báo cáo so sánh thực chi với ngân sách
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
 EXEC FNP3002 '','',0,'','','',''
*/

CREATE PROCEDURE [dbo].[FNP3002]
		@DivisionID VARCHAR(50),
		@DivisionList NVARCHAR(max) = '',  --Chọn
		@IsDate INT, ---- 1: là ngày, 0: là kỳ
		@FromDate DATETIME,
		@ToDate DATETIME,
		@PeriodList VARCHAR(MAX),
		@Ana02ID VARCHAR(50),
		@Ana03ID VARCHAR(50)
				
AS

DECLARE 
	@sSQL VARCHAR(MAX) = '',
	@sSQL1 VARCHAR(MAX) = '',
	@sWHERE NVARCHAR(MAX) = ''


IF ISNULL(@DivisionList, '') <> '' 
	SET @sWHERE = @sWHERE + ' AND F00.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWHERE = @sWHERE + ' AND F00.DivisionID = '''+@DivisionID+''''

IF @IsDate = 0
	BEGIN
	IF ISNULL(@PeriodList,'') <> ''
		SET @sWHERE = @sWHERE + ' AND ((CASE WHEN F00.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(F00.TranMonth)))+''/''+ltrim(Rtrim(str(F00.TranYear))) in ('''+@PeriodList +'''))'
	END
ELSE
	BEGIN
	IF ISNULL(@FromDate,'') <> '' AND ISNULL(@ToDate,'') <> ''
		SET @sWHERE = @sWHERE + ' AND (Convert(varchar(20),F00.VoucherDate,112) Between ''' + Convert(varchar(20),@FromDate,112) + ''' AND ''' + Convert(varchar(20),Isnull(@ToDate,'12/31/9999'),112) + ''')'
	END


IF ISNULL(@Ana02ID,'') <> ''
	SET @sWHERE = @sWHERE + ' AND (F01.Ana02ID like ''%' + @Ana02ID + '%'' OR A02.AnaName like N''%' + @Ana02ID + '%'')'

IF ISNULL(@Ana03ID,'') <> ''
	SET @sWHERE = @sWHERE + ' AND (F01.Ana03ID like ''%' + @Ana03ID + '%'' OR A03.AnaName like N''%' + @Ana03ID + '%'')'


SET  @sSQL = '
SELECT	DivisionID, APK, APKDetail,
	ISNULL(ActualOAmount_T90,0) As ActualOAmount_T90,
	ISNULL(ActualCAmount_T90,0) As ActualCAmount_T90
INTO #TAM
FROM
(
	SELECT	F01.DivisionID, F00.APK, F01.APK AS APKDetail,
			F01.ApprovalOriginalAmount AS OriginalAmount, F01.ApprovalConvertedAmount AS ConvertedAmount,
			T90.ActualOAmount_T90, T90.ActualCAmount_T90
	FROM TT2101 F01 WITH (NOLOCK)
	INNER JOIN TT2100 F00 WITH (NOLOCK) ON F01.DivisionID = F00.DivisionID AND F01.APKMaster = F00.APK AND F00.DeleteFlag = 0 AND F00.Status = 1
	LEFT JOIN	(Select DivisionID, InheritTransactionID, SUM(OriginalAmount) as ActualOAmount_T90, SUM(ConvertedAmount) as ActualCAmount_T90
				From AT9000 WITH (NOLOCK) 
				Where DivisionID = ''' + @DivisionID + ''' And ISNULL(InheritTableID,'''') = ''TT2100'' And Isnull(InheritTransactionID,'''') <> ''''
				Group by DivisionID, InheritTransactionID
				) T90 ON F01.DivisionID = T90.DivisionID And F01.APK = T90.InheritTransactionID
	WHERE F01.DivisionID = ''' + @DivisionID + ''' AND ISNULL(F01.ApprovalOriginalAmount,0) <> 0
) A
'
SET @sSQL1 = '

SELECT	SUM(F01.ApprovalOriginalAmount) AS ApprovalOAmount, SUM(F01.ApprovalConvertedAmount) AS ApprovalCAmount, 
		SUM(#TAM.ActualOAmount_T90) ActualOAmount_T90, SUM(#TAM.ActualOAmount_T90) ActualOAmount_T90,
		F01.Ana02ID, F01.Ana03ID,
		A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name
FROM TT2101 F01 WITH (NOLOCK)
INNER JOIN #TAM ON F01.DivisionID = #TAM.DivisionID And F01.APK = #TAM.APKDetail
INNER JOIN TT2100 F00 WITH (NOLOCK) ON F01.DivisionID = F00.DivisionID AND F01.APKMaster = F00.APK
LEFT JOIN AT1011 A02 WITH (NOLOCK) ON F01.Ana02ID = A02.AnaID AND A02.AnaTypeID = ''A02''
LEFT JOIN AT1011 A03 WITH (NOLOCK) ON F01.Ana03ID = A03.AnaID AND A03.AnaTypeID = ''A03''
WHERE 1=1 '+@sWHERE+'
GROUP BY F01.Ana02ID, F01.Ana03ID,A02.AnaName, A03.AnaName
'

EXEC(@sSQL+@sSQL1)
--PRINT @sSQL
--PRINT @sSQL1

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
