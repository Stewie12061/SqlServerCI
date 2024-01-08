IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1520]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1520]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--Created by Hoang  Thi Lan
--Date 15/12/2003
--Purpose :Thẻ tài sản cố định
--Edit by: Nguyen Quoc Huy, Date 11/04/2007
--Edit by: Thuy Tuyen, date 06/06/2008, 20/08,2008
 
/********************************************
'* Edited by: [GS] [Ng?c Nh?t] [29/07/2010]
'********************************************/
--Edit by: Trung Dung, date 28/03/2013 - Sua lai cach lay du lieu truong DepAmount,AccuDepAmount theo nam.
--Bo sung dieu kien tu ky den ky de dam  bao du lieu chi len dung theo khoang thoi gian nguoi dung chon tren form
--Edit by: Tấn Phú, date 27/01/2016 - trường hợp chưa tính khấu khao thì vẫn lên thẻ TSCD
---- Modified by Phương Thảo on 28/01/2016: Bo sung cac truong ma phan tich va tham so
---- Modified by Phương Thảo on 16/05/2017: Sửa danh mục dùng chung
---- Modified by Trà Giang on 18/08/2020: Bổ sung trường AT1523.Notes: Diễn giải ghi giảm TSCD
---- Modified by Kiều Nga on 03/02/2023: [2023/01/IS/0053] Mẫu in thẻ tài sản cố định hiển thị giá trị khấu hao theo từng kỳ trong năm (merge từ BlueSky)
-- <Example>
/*
	 exec AP1520 'ht', '', '', 1,2016,12,2016
	 select * from AV1520
*/

CREATE PROCEDURE AP1520
(
	@DivisionID NVARCHAR(50),
	@AssetIDFrom NVARCHAR(50),
	@AssetIDTo NVARCHAR(50),
	@FromMonth INT,
	@FromYear INT,
	@ToMonth INT,
	@ToYear INT
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sSQLAT1523 NVARCHAR(MAX),
		@sSQLAT1504 NVARCHAR(MAX),
		@sSQLFT0011 NVARCHAR(MAX)
/*Rem by Trung Dung - 28/03/2013
	DepAmount =isnull((Select Sum(DepAmount) 
						From AT1504 
						Where DivisionID = AT1503.DivisionID and AssetID = At1503.AssetID 
							and	AT1504.TranMonth + AT1504.TranYear * 100 between (' + str(@FromMonth) + ' + ' + str(@FromYear) + ' *100) 
							and ' + str(@ToMonth) + ' + ' + str(@ToYear) + ' *100),0),
	 -----AccuDepAmount = (AT1503.ConvertedAmount  -  Isnull(ResidualValue,0)),	
	AccuDepAmount = (isnull (AT1503.ConvertedAmount,0) 	-  
					isnull(AT1503.ResidualValue,0) + 
					isnull((Select Sum(DepAmount) 
							From AT1504 
							Where DivisionID = AT1503.DivisionID and AssetID = At1503.AssetID 
								and	AT1504.TranMonth + AT1504.TranYear * 100 <= ' + str(@ToMonth) + ' + ' + str(@ToYear) + ' *100),0)),
	*/
SET @sSQL = '
SELECT DISTINCT CONVERT(VARCHAR(10),GETDATE(),103) AS ReportDate, A03.AssetID, A03.AssetName, 
	(CASE WHEN EXISTS (SELECT TOP 1 AssetID FROM AT1506 A06 WHERE AssetID = A03.AssetID AND DivisionID = A03.DivisionID
							AND A06.TranMonth + A06.TranYear * 100 <= '+STR(@ToMonth + @ToYear * 100)+')
		  THEN (SELECT TOP 1 A06.ConvertedNewAmount FROM AT1506 A06
		        WHERE A06.AssetID = A03.AssetID AND A06.DivisionID = A03.DivisionID
					AND A06.TranMonth + A06.TranYear * 100 <= '+STR(@ToMonth + @ToYear * 100)+'
				ORDER BY A06.TranYear DESC, A06.TranMonth DESC) ELSE A03.ConvertedAmount END) ConvertedAmount, 
	A03.Serial, A01.CountryName, A03.MadeYear, A03.BeginYear, A03.DepartmentID, A02.DepartmentName, A.TranYear,
	--A.DepAmount, ISNULL(A03.ConvertedAmount, 0) - ISNULL(A03.ResidualValue, 0) + ISNULL(A.DepAmount, 0) AccuDepAmount,
	NULL as DepAmount, NULL as AccuDepAmount,
	A23.ReduceVoucherNo, A23.AssetStatus, A23.ReduceDate, A03.DivisionID, A03.Years,
	V99.MonthYear BeginMonthYear, A03.AssetAccountID, A03.DepAccountID,
	A03.DebitDepAccountID1, A03.DebitDepAccountID2, A03.DebitDepAccountID3,
	A03.DebitDepAccountID4, A03.DebitDepAccountID5, A03.DebitDepAccountID6,
	A03.InvoiceNo, A03.InvoiceDate, A03.SerialNo, A03.EstablishDate,
	A03.Ana01ID1, A03.Ana02ID1, A03.Ana03ID1, A03.Ana04ID1, A03.Ana05ID1, A03.Ana06ID1, A03.Ana07ID1, A03.Ana08ID1, A03.Ana09ID1, A03.Ana10ID1,
	A11.AnaName AS Ana01Name1, A12.AnaName AS Ana02Name1, A13.AnaName AS Ana03Name1, A14.AnaName AS Ana04Name1, A15.AnaName AS Ana05Name1,
	A16.AnaName AS Ana06Name1, A17.AnaName AS Ana07Name1, A18.AnaName AS Ana08Name1, A19.AnaName AS Ana09Name1, A110.AnaName AS Ana10Name1,
	A03.Parameter01, A03.Parameter02, A03.Parameter03, A03.Parameter04, A03.Parameter05, A03.Parameter06, A03.Parameter07, A03.Parameter08, A03.Parameter09, A03.Parameter10,
	A03.Parameter11, A03.Parameter12, A03.Parameter13, A03.Parameter14, A03.Parameter15, A03.Parameter16, A03.Parameter17, A03.Parameter18, A03.Parameter19, A03.Parameter20,
	MAX(AT9000.VoucherNo) AS ReVoucherNo,A03.EstablishDate as VoucherDate, YEAR(A03.StartDate) as StartYear, MAX(AT9000.VDescription) as VDescription, '''' AS AssetStatusName,NULL as Notes, A03.Notes as Description
FROM AT1503 A03
LEFT JOIN FV9999 V99 ON V99.DivisionID = A03.DivisionID AND V99.TranMonth = A03.BeginMonth AND V99.TranYear = A03.BeginYear
--LEFT JOIN AT1504 A04 ON A03.AssetID = A04.AssetID
LEFT JOIN AT1102 A02 ON A02.DepartmentID = A03.DepartmentID
LEFT JOIN AT1001 A01 ON A01.CountryID = A03.CountryID
LEFT JOIN AT1523 A23 ON A23.AssetID = A03.AssetID'
SET @sSQL1 = N'
LEFT JOIN (
		SELECT DivisionID, AssetID, TranYear, SUM(DepAmount) DepAmount
		FROM AT1504 WHERE AT1504.TranMonth + AT1504.TranYear * 100 BETWEEN '+STR(@FromMonth+@FromYear*100)+' AND '+STR(@ToMonth+@ToYear*100)+'
		GROUP BY DivisionID, AssetID, TranYear)A ON A.DivisionID = A03.DivisionID AND A.AssetID = A03.AssetID --AND A.TranYear = A04.TranYear	
LEFT JOIN AT1011 A11 WITH(NOLOCK) ON A03.Ana01ID1 = A11.AnaID AND A11.AnaTypeID = ''A01''
LEFT JOIN AT1011 A12 WITH(NOLOCK) ON A03.Ana02ID1 = A12.AnaID AND A12.AnaTypeID = ''A02''
LEFT JOIN AT1011 A13 WITH(NOLOCK) ON A03.Ana03ID1 = A13.AnaID AND A13.AnaTypeID = ''A03''
LEFT JOIN AT1011 A14 WITH(NOLOCK) ON A03.Ana04ID1 = A14.AnaID AND A14.AnaTypeID = ''A04''
LEFT JOIN AT1011 A15 WITH(NOLOCK) ON A03.Ana05ID1 = A15.AnaID AND A15.AnaTypeID = ''A05''
LEFT JOIN AT1011 A16 WITH(NOLOCK) ON A03.Ana06ID1 = A16.AnaID AND A16.AnaTypeID = ''A06''
LEFT JOIN AT1011 A17 WITH(NOLOCK) ON A03.Ana07ID1 = A17.AnaID AND A17.AnaTypeID = ''A07''
LEFT JOIN AT1011 A18 WITH(NOLOCK) ON A03.Ana08ID1 = A18.AnaID AND A18.AnaTypeID = ''A08''
LEFT JOIN AT1011 A19 WITH(NOLOCK) ON A03.Ana09ID1 = A19.AnaID AND A19.AnaTypeID = ''A09''
LEFT JOIN AT1011 A110 WITH(NOLOCK) ON A03.Ana10ID1 = A110.AnaID AND A110.AnaTypeID = ''A10''
LEFT JOIN AT1533 A53 WITH (NOLOCK) ON A53.DivisionID = A03.DivisionID AND A53.AssetID = A03.AssetID
LEFT JOIN AT9000 WITH (NOLOCK) ON A53.ReTransactionID = AT9000.TransactionID AND A53.ReVoucherID = AT9000.VoucherID AND A53.DivisionID = AT9000.DivisionID 
		AND AT9000.TranMonth + AT9000.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+'
WHERE A03.DivisionID = '''+@DivisionID+''' 
	AND A03.AssetID BETWEEN '''+@AssetIDFrom+''' AND '''+@AssetIDTo+'''
	--AND (A04.TranMonth + A04.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+'  OR (A04.TranMonth IS NULL and A04.TranYear IS NULL))
GROUP BY A03.AssetID, A03.AssetName, A03.Serial, A01.CountryName, A03.MadeYear, A03.BeginYear, A03.DepartmentID, A02.DepartmentName, A.TranYear,
	A.DepAmount, A03.ConvertedAmount, A03.ResidualValue, A.DepAmount,
	A23.ReduceVoucherNo, A23.AssetStatus, A23.ReduceDate, A03.DivisionID, A03.Years,
	V99.MonthYear, A03.AssetAccountID, A03.DepAccountID,
	A03.DebitDepAccountID1, A03.DebitDepAccountID2, A03.DebitDepAccountID3,
	A03.DebitDepAccountID4, A03.DebitDepAccountID5, A03.DebitDepAccountID6,
	A03.InvoiceNo, A03.InvoiceDate, A03.SerialNo, A03.EstablishDate,
	A03.Ana01ID1, A03.Ana02ID1, A03.Ana03ID1, A03.Ana04ID1, A03.Ana05ID1, A03.Ana06ID1, A03.Ana07ID1, A03.Ana08ID1, A03.Ana09ID1, A03.Ana10ID1,
	A11.AnaName, A12.AnaName, A13.AnaName, A14.AnaName, A15.AnaName,
	A16.AnaName, A17.AnaName, A18.AnaName, A19.AnaName, A110.AnaName,
	A03.Parameter01, A03.Parameter02, A03.Parameter03, A03.Parameter04, A03.Parameter05, A03.Parameter06, A03.Parameter07, A03.Parameter08, A03.Parameter09, A03.Parameter10,
	A03.Parameter11, A03.Parameter12, A03.Parameter13, A03.Parameter14, A03.Parameter15, A03.Parameter16, A03.Parameter17, A03.Parameter18, A03.Parameter19, A03.Parameter20, A03.StartDate, A03.Notes'

--print @sSQL
--print @sSQL1

--- Khấu hao tài sản cố định
SET @sSQLAT1504 = '
	UNION ALL
	 SELECT  CONVERT(VARCHAR(10),GETDATE(),103) AS ReportDate, AT1504.AssetID, NULL AS AssetName, 
	0 AS ConvertedAmount, 
	NULL AS Serial, NULL AS CountryName,NULL AS MadeYear,NULL AS BeginYear, NULL AS DepartmentID, NULL AS DepartmentName, AT1504.TranYear as TranYear,
	AT1504.DepAmount,0 AS AccuDepAmount,
	NULL AS ReduceVoucherNo,0 AS AssetStatus,  NULL AS ReduceDate, AT1504.DivisionID, 0 as Years,
	NULL AS BeginMonthYear,NULL AS AssetAccountID, NULL AS DepAccountID,
	NULL AS DebitDepAccountID1,NULL AS DebitDepAccountID2, NULL AS DebitDepAccountID3,
	NULL AS DebitDepAccountID4,NULL AS DebitDepAccountID5, NULL AS DebitDepAccountID6,
	NULL AS InvoiceNo,NULL AS InvoiceDate, NULL AS SerialNo,NULL AS EstablishDate,
	NULL AS Ana01ID1,NULL AS Ana02ID1,NULL AS Ana03ID1,NULL AS Ana04ID1,NULL AS Ana05ID1,NULL AS Ana06ID1,NULL AS Ana07ID1,NULL AS Ana08ID1,NULL AS Ana09ID1,NULL AS Ana10ID1,
	NULL AS Ana01Name1, NULL AS Ana02Name1, NULL AS Ana03Name1, NULL AS Ana04Name1, NULL AS Ana05Name1,
	NULL  Ana06Name1, NULL AS Ana07Name1,NULL AS Ana08Name1, NULL AS Ana09Name1, NULL AS Ana10Name1,
	NULL AS Parameter01,NULL AS Parameter02,NULL AS Parameter03,NULL AS Parameter04,NULL AS Parameter05,NULL AS Parameter06,NULL AS Parameter07,NULL AS Parameter08,NULL AS Parameter09,NULL AS Parameter10,
	NULL AS Parameter11,NULL AS Parameter12,NULL AS Parameter13,NULL AS Parameter14,NULL AS Parameter15,NULL AS Parameter16,NULL AS Parameter17,NULL AS Parameter18,NULL AS Parameter19,NULL AS Parameter20,
	AT1504.VoucherNo AS ReVoucherNo, AT1504.VoucherDate, NULL AS StartYear, NULL AS VDescription, '''' AS AssetStatusName,NULL as Notes,AT1504.BDescription as Description
    FROM AT1504 WITH(NOLOCK)
	WHERE AT1504.DivisionID  = '''+@DivisionID+'''  AND AssetID  BETWEEN '''+@AssetIDFrom+''' AND '''+@AssetIDTo+'''
		 AND AT1504.TranMonth + AT1504.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+''
---	--- Ghi giảm tài sản
SET @sSQLAT1523 ='
	UNION ALL 
	 SELECT  CONVERT(VARCHAR(10),GETDATE(),103) AS ReportDate, AT1523.AssetID, AT1523.AssetName, 
	AT1523.ConvertedAmount AS ConvertedAmount, 
	NULL AS Serial, NULL AS CountryName,NULL AS MadeYear,NULL AS BeginYear, AT1523.DepartmentID, NULL AS DepartmentName, YEAR(AT1523.ReduceDate) as TranYear,
	0 as DepAmount, AT1523.AccuDepAmount,
	NULL AS ReduceVoucherNo, AT1523.AssetStatus, AT1523.ReduceDate, AT1523.DivisionID, 0 as Years,
	NULL AS BeginMonthYear,NULL AS AssetAccountID, NULL AS DepAccountID,
	NULL AS DebitDepAccountID1,NULL AS DebitDepAccountID2, NULL AS DebitDepAccountID3,
	NULL AS DebitDepAccountID4,NULL AS DebitDepAccountID5, NULL AS DebitDepAccountID6,
	NULL AS InvoiceNo,NULL AS InvoiceDate, NULL AS SerialNo,NULL AS EstablishDate,
	NULL AS Ana01ID1,NULL AS Ana02ID1,NULL AS Ana03ID1,NULL AS Ana04ID1,NULL AS Ana05ID1,NULL AS Ana06ID1,NULL AS Ana07ID1,NULL AS Ana08ID1,NULL AS Ana09ID1,NULL AS Ana10ID1,
	NULL AS Ana01Name1, NULL AS Ana02Name1, NULL AS Ana03Name1, NULL AS Ana04Name1, NULL AS Ana05Name1,
	NULL  Ana06Name1, NULL AS Ana07Name1,NULL AS Ana08Name1, NULL AS Ana09Name1, NULL AS Ana10Name1,
	NULL AS Parameter01,NULL AS Parameter02,NULL AS Parameter03,NULL AS Parameter04,NULL AS Parameter05,NULL AS Parameter06,NULL AS Parameter07,NULL AS Parameter08,NULL AS Parameter09,NULL AS Parameter10,
	NULL AS Parameter11,NULL AS Parameter12,NULL AS Parameter13,NULL AS Parameter14,NULL AS Parameter15,NULL AS Parameter16,NULL AS Parameter17,NULL AS Parameter18,NULL AS Parameter19,NULL AS Parameter20,
	AT1523.ReduceVoucherNo AS ReVoucherNo,AT1523.ReduceDate as VoucherDate , NULL AS StartYear, NULL AS VDescription,'''' AS AssetStatusName,AT1523.Notes,AT1523.Notes as Description
    FROM AT1523 WITH(NOLOCK)
	WHERE AT1523.DivisionID  = '''+@DivisionID+''' AND AssetID BETWEEN '''+@AssetIDFrom+''' AND '''+@AssetIDTo+'''
	AND AT1523.ReduceMonth + AT1523.ReduceYear * 100 BETWEEN  '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+''
	PRINT @sSQL 
	PRINT @sSQL1 
	PRINT @sSQLAT1504
	PRINT @sSQLAT1523 
	-- Thực hiện lấy dữ liệu
	--EXEC (@sSQL + @sSQL1 + @sSQLAT1504 + @sSQLAT1523)

	IF NOT EXISTS (SELECT TOP 1 1 FROM SysObjects WHERE name = 'AV1520' AND Xtype = 'V')
		EXEC ('CREATE VIEW AV1520 AS ' + @sSQL + @sSQL1 + @sSQLAT1504 + @sSQLAT1523)
	ELSE 
		EXEC ('ALTER VIEW AV1520 AS ' + @sSQL + @sSQL1 + @sSQLAT1504 + @sSQLAT1523)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
