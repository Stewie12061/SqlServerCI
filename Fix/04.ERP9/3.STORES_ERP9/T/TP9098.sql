IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TP9098]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[TP9098]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-----<Summary>
---- Đổ nguồn kế thừa ngân sách lưới detail
---- 
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Như Hàn, Date: 14/11/2018
---- Modified by Tuấn Anh on 09/12/2019: Bổ sung điều kiện load detail: Chỉ load các detail đã duyệt (TT2101.Status = 1)
----<Example>
/*
 EXEC TP9098 'BS','<Data><APK>359B3973-3E52-4C92-85CB-2B603A6D3F93</APK></Data>','769B5053-9A14-452B-994D-EF2E9206A838'
*/

CREATE PROCEDURE [dbo].[TP9098]
		@DivisionID nvarchar(50),				
		@APKList XML,
		@VoucherID nvarchar(50) = '' --- Addnew   truyen ''; Load Edit :  so chung tu vua duoc chon sua
				
AS

IF @APKList IS NOT NULL
BEGIN
	CREATE TABLE #TP9098 (APK VARCHAR(50))
	INSERT INTO #TP9098 (APK)
	SELECT X.Data.query('APK').value('.', 'VARCHAR(50)') AS OrderID
	FROM @APKList.nodes('//Data') AS X (Data)
END
	
Declare @sSQL VARCHAR(MAX),
	@sSQL1 VARCHAR(MAX),
	@sSQL2 VARCHAR(MAX)

SET @sSQL = ''
SET @sSQL1 = ''
SET @sSQL2 = ''

Set  @sSQL = '
SELECT	DivisionID, APK, APKDetail,
	ISNULL(OriginalAmount,0) - ISNULL(ActualOAmount_T90,0) as EndOAmount,
	ISNULL(ConvertedAmount,0) - ISNULL(ActualCAmount_T90,0) as EndCAmount
INTO #TAM
FROM
(
	SELECT	F01.DivisionID, F00.APK, F01.APK AS APKDetail,
			F01.ApprovalOAmount AS OriginalAmount, F01.ApprovalCAmount AS ConvertedAmount,
			T90.ActualOAmount_T90, T90.ActualCAmount_T90
	FROM TT2101 F01 WITH (NOLOCK)
	INNER JOIN #TP9098 ON F01.APKMaster = #TP9098.APK
	INNER JOIN TT2100 F00 WITH (NOLOCK) ON F01.DivisionID = F00.DivisionID AND F01.APKMaster = F00.APK AND F00.DeleteFlag = 0 AND F00.Status = 1  AND F01.Status = 1 
	LEFT JOIN	(Select DivisionID, InheritTransactionID, SUM(OriginalAmount) as ActualOAmount_T90, SUM(ConvertedAmount) as ActualCAmount_T90
				From AT9000 WITH (NOLOCK) 
				Where DivisionID = ''' + @DivisionID + ''' And ISNULL(InheritTableID,'''') = ''TT2100'' And Isnull(InheritTransactionID,'''') <> ''''
				Group by DivisionID, InheritTransactionID
				) T90 ON F01.DivisionID = T90.DivisionID And F01.APK = T90.InheritTransactionID
	WHERE F01.DivisionID = ''' + @DivisionID + ''' AND ISNULL(F01.ApprovalOAmount,0) <> 0
) A
WHERE ISNULL(OriginalAmount,0) - ISNULL(ActualOAmount_T90,0) > 0
'

SET @sSQL1 = '
SELECT * FROM
(
SELECT	F01.APKMaster, F01.APK, F00.VoucherNo, 
		F01.Notes,  F01.Orders,
		F01.ApprovalOAmount AS ApprovalOAmount, F01.ApprovalCAmount AS ApprovalCAmount, 
		#TAM.EndOAmount AS RemainOAmount, #TAM.EndCAmount AS RemainCAmount,
		F01.Ana01ID, F01.Ana02ID, F01.Ana03ID, F01.Ana04ID, F01.Ana05ID, F01.Ana06ID, F01.Ana07ID, F01.Ana08ID, F01.Ana09ID, F01.Ana10ID,
		A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
		A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name, A10.AnaName AS Ana10Name
FROM TT2101 F01 WITH (NOLOCK)
INNER JOIN #TAM ON F01.DivisionID = #TAM.DivisionID And F01.APK = #TAM.APKDetail
INNER JOIN TT2100 F00 WITH (NOLOCK) ON F01.DivisionID = F00.DivisionID AND F01.APKMaster = F00.APK
LEFT JOIN AT1011 A01 WITH (NOLOCK) ON F01.Ana01ID = A01.AnaID AND A01.AnaTypeID = ''A01''
LEFT JOIN AT1011 A02 WITH (NOLOCK) ON F01.Ana02ID = A02.AnaID AND A02.AnaTypeID = ''A02''
LEFT JOIN AT1011 A03 WITH (NOLOCK) ON F01.Ana03ID = A03.AnaID AND A03.AnaTypeID = ''A03''
LEFT JOIN AT1011 A04 WITH (NOLOCK) ON F01.Ana04ID = A04.AnaID AND A04.AnaTypeID = ''A04''
LEFT JOIN AT1011 A05 WITH (NOLOCK) ON F01.Ana05ID = A05.AnaID AND A05.AnaTypeID = ''A05''
LEFT JOIN AT1011 A06 WITH (NOLOCK) ON F01.Ana06ID = A06.AnaID AND A06.AnaTypeID = ''A06''
LEFT JOIN AT1011 A07 WITH (NOLOCK) ON F01.Ana07ID = A07.AnaID AND A07.AnaTypeID = ''A07''
LEFT JOIN AT1011 A08 WITH (NOLOCK) ON F01.Ana08ID = A08.AnaID AND A08.AnaTypeID = ''A08''
LEFT JOIN AT1011 A09 WITH (NOLOCK) ON F01.Ana09ID = A09.AnaID AND A09.AnaTypeID = ''A09''
LEFT JOIN AT1011 A10 WITH (NOLOCK) ON F01.Ana10ID = A10.AnaID AND A10.AnaTypeID = ''A10''

WHERE F01.DivisionID = ''' + @DivisionID + ''''

IF ISNULL(@VoucherID,'') <> ''
BEGIN
	SET @sSQL1 = @sSQL1 + ' AND NOT EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK)
											WHERE DivisionID = F01.DivisionID AND VoucherID = ''' + @VoucherID + ''' AND InheritTransactionID = F01.APK)'

	SET @sSQL2 = '
	UNION ALL
	SELECT	F01.APKMaster, F01.APK, F00.VoucherNo, 
			F01.Notes, F01.Orders,
			F01.ApprovalOAmount AS ApprovalOAmount, F01.ApprovalCAmount AS ApprovalCAmount, 
			ISNULL(#TAM.EndOAmount,0) AS RemainOAmount, ISNULL(#TAM.EndCAmount,0) AS RemainCAmount,
			F01.Ana01ID, F01.Ana02ID, F01.Ana03ID, F01.Ana04ID, F01.Ana05ID, F01.Ana06ID, F01.Ana07ID, F01.Ana08ID, F01.Ana09ID, F01.Ana10ID,
			A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
			A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name, A10.AnaName AS Ana10Name
	FROM TT2101 F01 WITH (NOLOCK)
	INNER JOIN AT9000 T90 WITH (NOLOCK) ON T90.DivisionID = ''' + @DivisionID + ''' AND T90.VoucherID = ''' + @VoucherID + '''
		AND F01.DivisionID = T90.DivisionID AND F01.APK = T90.InheritTransactionID
	INNER JOIN TT2100 F00 WITH (NOLOCK) ON F01.DivisionID = F00.DivisionID AND F01.APKMaster = F00.APK
	LEFT JOIN #TAM ON F01.DivisionID = #TAM.DivisionID And F01.APK = #TAM.APKDetail
	LEFT JOIN AT1011 A01 WITH (NOLOCK) ON F01.Ana01ID = A01.AnaID AND A01.AnaTypeID = ''A01''
	LEFT JOIN AT1011 A02 WITH (NOLOCK) ON F01.Ana02ID = A02.AnaID AND A02.AnaTypeID = ''A02''
	LEFT JOIN AT1011 A03 WITH (NOLOCK) ON F01.Ana03ID = A03.AnaID AND A03.AnaTypeID = ''A03''
	LEFT JOIN AT1011 A04 WITH (NOLOCK) ON F01.Ana04ID = A04.AnaID AND A04.AnaTypeID = ''A04''
	LEFT JOIN AT1011 A05 WITH (NOLOCK) ON F01.Ana05ID = A05.AnaID AND A05.AnaTypeID = ''A05''
	LEFT JOIN AT1011 A06 WITH (NOLOCK) ON F01.Ana06ID = A06.AnaID AND A06.AnaTypeID = ''A06''
	LEFT JOIN AT1011 A07 WITH (NOLOCK) ON F01.Ana07ID = A07.AnaID AND A07.AnaTypeID = ''A07''
	LEFT JOIN AT1011 A08 WITH (NOLOCK) ON F01.Ana08ID = A08.AnaID AND A08.AnaTypeID = ''A08''
	LEFT JOIN AT1011 A09 WITH (NOLOCK) ON F01.Ana09ID = A09.AnaID AND A09.AnaTypeID = ''A09''
	LEFT JOIN AT1011 A10 WITH (NOLOCK) ON F01.Ana10ID = A10.AnaID AND A10.AnaTypeID = ''A10''
	'
END

SET @sSQL2 = @sSQL2 + ') A ORDER BY VoucherNo, Orders'

EXEC(@sSQL + @sSQL1 + @sSQL2)
--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
	
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
