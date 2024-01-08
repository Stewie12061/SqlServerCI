IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0020]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by Tieu Mai on 24/04/2016
---- Purpose: In bao cao phan tich han muc cong no phai thu theo tuoi no (CustomizeIndex = 52 - KOYO)
---- Modified by Tiểu Mai on 27/06/2016: Sửa lại cách lấy dữ liệu
---- Modified by Tiểu Mai on 22/02/2017: Bổ sung thêm trường MPT đối tượng, Công nợ khách hàng đã thanh toán cho khoản nợ của năm trước 
---- Modified by Tiểu Mai on 21/03/2017: Bổ sung NetCreditAmountInYear, NetCreditConvertedAmountInYear, 5 tên MPT đối tượng
---- Modified on 16/05/2017 by Hải Long: Chỉnh sửa danh mục dùng chung
---- Modified by Bảo Anh on 30/05/2017: Bổ sung UnderOneUnexpiredDebitConAmount và NineUnexpiredDebitConAmount
---- Modified by Hải Long on 13/06/2017: Bổ sung thêm điều kiện lấy dữ liệu giải trừ công nợ trước ngày in báo cáo báo
---- Modified by Tiểu Mai on 26/07/2017: Bổ sung Doanh số hàng bán trả lại trong năm ConvertedAmountTLInYear
---- Modified by Bảo Anh on 03/01/2017: Sửa lỗi dữ liệu lên double dòng do AV0316.Group02ID khác nhau
---- Modified by Kim Thư on 27/03/2019: Sửa cột ConvertedAmountTLInYear lấy tới ngày in, AV00201, LastYearConvertedAmount nhóm theo từng Ana05ID do 1 KH phát sinh 2 MPT
---- Modified by Kim Thư on 15/05/2019: Thay AV00201 thành #AV00201 cải thiện tốc độ, bổ sung Order by ObjectID
---- Modified by Văn Minh on 14/01/2020: Bổ sung thêm điều kiện để lọc phiếu
---- Modified by Nhật Thanh on 24/08/2022: Bổ sung quá hạn 2, 4 ,5 tháng cho koyo
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Hoàng Lâm on 29/09/2023: [2023/09/IS/0199] - Comment code Bổ sung quá hạn 2, 4 ,5 tháng cho koyo - Chỉ lấy lên 3 và 6 tháng
/*
exec AP0020 @DivisionID=N'KVC',@ReportDate='2016-06-30 10:08:12.543',@FromAccountID=N'1311',@ToAccountID=N'171',@FromObjectID=N'KH-BUIF',@ToObjectID=N'KH-BUIF',@CurrencyID=N'VND',@IsGroup=0,@GroupID=N'A01'
*/

CREATE PROCEDURE [dbo].[AP0020] 	
					@DivisionID as nvarchar(50),
					@ReportDate as Datetime,
					@FromAccountID as nvarchar(50),
					@ToAccountID as nvarchar(50),
					@FromObjectID as nvarchar(50),
					@ToObjectID as nvarchar(50),
					@CurrencyID as nvarchar(50),
					@IsGroup as tinyint,
					@GroupID as nvarchar(50)
					
 AS
Declare @sSQL as nvarchar(4000), @sSQL1 as nvarchar(4000), @sSQL0 as nvarchar(4000), @sSQL2 as nvarchar(4000), 
	@Month as int,
	@Year as int,
	@Period01 as INT,
	@FromAna02ID NVARCHAR(50),
	@ToAna02ID NVARCHAR(50),
	@FromAna05ID NVARCHAR(50),
	@ToAna05ID NVARCHAR(50)


Declare @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang KOYO khong (CustomerName = 52)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

Set nocount off
set @Month = month(@ReportDate)
set @Year = year(@ReportDate)

SET @FromAna02ID = (SELECT TOP 1 AnaID FROM AT1011 WHERE DivisionID = @DivisionID AND AnaTypeID = 'A02'
ORDER BY AnaID ASC)

SET @ToAna02ID = (SELECT TOP 1 AnaID FROM AT1011 WHERE DivisionID = @DivisionID AND AnaTypeID = 'A02'
ORDER BY AnaID DESC)

SET @FromAna05ID = (SELECT TOP 1 AnaID FROM AT1011 WHERE DivisionID = @DivisionID AND AnaTypeID = 'A05'
ORDER BY AnaID ASC)

SET @ToAna05ID = (SELECT TOP 1 AnaID FROM AT1011 WHERE DivisionID = @DivisionID AND AnaTypeID = 'A05'
ORDER BY AnaID DESC)


exec AP7403_KYO @DivisionID,1,@Year,@Month,@Year,1,@ReportDate,@ReportDate,@CurrencyID,@FromAccountID,@ToAccountID,@FromObjectID,@ToObjectID,0,N'',N''

EXEC AP0316 @DivisionID,N'CNPTH001',@FromObjectID,@ToObjectID,@FromAccountID,@ToAccountID,@CurrencyID,N'',N'',@FromAna02ID,@ToAna02ID,@FromAna05ID,@ToAna05ID,@ReportDate,1,1

SET @sSQL0 = ' 
	SELECT 	DISTINCT AT0303.ObjectID, AT0303.AccountID, AT0303.CurrencyID, 
			--AT0303.DebitVoucherID  AS VoucherID, 
			--AT0303.DebitBatchID AS BatchID,
			SUM(ISNULL(AT0303.OriginalAmount,0)) AS NetCreditAmountInYear,
			SUM(ISNULL(AT0303.ConvertedAmount,0)) AS NetCreditConvertedAmountInYear,
			AT0303.DivisionID, A.Ana05ID
	INTO #AV00201
	FROM AT0303 WITH (NOLOCK) OUTER APPLY (SELECT TOP 1 * FROM AT9000 WITH (NOLOCK) WHERE AT0303.CreditVoucherID = AT9000.VoucherID) A
	LEFT JOIN (	SELECT	DISTINCT DivisionID, VoucherID, BatchID, TableID,ObjectID,VoucherDate
				FROM AV0302
				) AS  AV0302 
		ON  AV0302.DivisionID = AT0303.DivisionID AND  AV0302.VoucherID = AT0303.CreditVoucherID 
			AND AV0302.TableID = AT0303.CreditTableID 
			AND AV0302.ObjectID = AT0303.ObjectID  AND  AV0302.BatchID = AT0303.DebitBatchID
	WHERE	AT0303.DivisionID = ''' + @DivisionID + ''' AND
			AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND 
			--MONTH(AT0303.CreditVoucherDate) = '+STR(MONTH(@ReportDate))+' AND
			YEAR(AT0303.CreditVoucherDate) = '+STR(YEAR(@ReportDate))+' AND 
			--MONTH(AT0303.DebitVoucherDate) = '+STR(MONTH(@ReportDate))+' AND
			YEAR(AT0303.DebitVoucherDate) = '+STR(YEAR(@ReportDate))+'
	GROUP BY AT0303.ObjectID, AT0303.AccountID, AT0303.CurrencyID, --AT0303.DebitVoucherID, AT0303.DebitBatchID, 
			AT0303.DivisionID, A.Ana05ID'

--IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV00201]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
--			EXEC ('  CREATE VIEW AV00201 	---CREATED BY AP0020
--						AS ' + @sSQL)
--		ELSE
--			EXEC ('  ALTER VIEW AV00201   	---CREATED BY AP0020
--						AS ' + @sSQL)


SET @sSQL = '
SELECT  AV7403.DivisionID, AV7403.ObjectID, Isnull(AV7403.Ana05ID,'''') as Ana05ID, AT1011.Ananame, AT1202.ObjectName, 
		AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
		AT1202.ReDueDays as ReDays, TradeName, MaxVoucherDate,
		EndDebitAmountLastYear =	Isnull(AV7403.DebitOriginalOpening,0), 
		EndCreditAmountLastYear =		Isnull(AV7403.CreditOriginalOpening,0), 
		EndDebitConAmountLastYear = Isnull(AV7403.DebitConvertedOpening,0), 
		EndCreditConAmountLastYear =	Isnull(AV7403.CreditConvertedOpening,0),
		
		DebitAmountInYear =		Isnull(AV7403.OriginalDebit,0), 
		CreditAmountInYear =		Isnull(AV7403.OriginalCredit,0), 
		DebitConAmountInYear =	Isnull(AV7403.ConvertedDebit,0), 
		CreditConAmountInYear =	Isnull(AV7403.ConvertedCredit,0),
		
		RemainDebitAmountInYear =		Isnull(AV7403.DebitOriginalOpening,0) +		Isnull(AV7403.OriginalDebit,0), 
		RemainCreditAmountinYear =		Isnull(AV7403.CreditOriginalOpening,0) +	Isnull(AV7403.OriginalCredit,0), 
		RemainDebitConAmountInYear =	Isnull(AV7403.DebitConvertedOpening,0) +	Isnull(AV7403.ConvertedDebit,0), 
		RemainCreditConAmountinYear =	Isnull(AV7403.CreditConvertedOpening,0) +	Isnull(AV7403.ConvertedCredit,0),
		
		OutDateDebitAmount = (ISNULL(AV0316.OriginalAmount1,0) + ISNULL(AV0316.OriginalAmount2,0) + ISNULL(AV0316.OriginalAmount3,0) + ISNULL(AV0316.OriginalAmount4,0) + ISNULL(AV0316.OriginalAmount5,0)), 
		OutDateDebitConAmount = (ISNULL(AV0316.ConvertedAmount1,0) + ISNULL(AV0316.ConvertedAmount2,0) + ISNULL(AV0316.ConvertedAmount3,0) + ISNULL(AV0316.ConvertedAmount4,0) + ISNULL(AV0316.ConvertedAmount5,0)),
		OutDateCreditAmount = 0,
		OutDateCreditConAmount = 0,
		
		UnexpiredDebitAmount =		ISNULL(AV7403.DebitOriginalOpening,0) +	ISNULL(AV7403.OriginalDebit,0) - (ISNULL(AV0316.OriginalAmount1,0) + ISNULL(AV0316.OriginalAmount2,0) + ISNULL(AV0316.OriginalAmount3,0) + ISNULL(AV0316.OriginalAmount4,0) + ISNULL(AV0316.OriginalAmount5,0)), 
		UnexpiredDebitConAmount =	ISNULL(AV7403.DebitConvertedOpening,0) +	ISNULL(AV7403.ConvertedDebit,0) - (ISNULL(AV0316.ConvertedAmount1,0) + ISNULL(AV0316.ConvertedAmount2,0) + ISNULL(AV0316.ConvertedAmount3,0) + ISNULL(AV0316.ConvertedAmount4,0) + ISNULL(AV0316.ConvertedAmount5,0)),		
		UnexpiredCreditAmount =	0,
		UnexpiredCreditConAmount = 0,

		Isnull(AV0316.ConvertedAmount1,0) as UnderOneUnexpiredDebitConAmount,	
		Isnull(AV0316.OriginalAmount1,0) as UnderOneUnexpiredDebitAmount,
		0 as UnderOneUnexpiredCreditConAmount,	
		0 as UnderOneUnexpiredCreditAmount,
		
		Isnull(AV0316.ConvertedAmount2,0) as OneUnexpiredDebitConAmount,	
		Isnull(AV0316.OriginalAmount2,0) as OneUnexpiredDebitAmount,
		0 as OneUnexpiredCreditConAmount,	
		0 as OneUnexpiredCreditAmount,
'
-- Khách hàng koyo: Lấy thêm quá hạn 2,4,5 tháng
--IF @CustomerName = 52
--	SET @sSQL1 = '
--		Isnull(AV0316.ConvertedAmount3,0) as TwoUnexpiredDebitConAmount,	
--		Isnull(AV0316.OriginalAmount3,0) as TwoUnexpiredDebitAmount,
--		0 as TwoUnexpiredCreditConAmount,	
--		0 as TwoUnexpiredCreditAmount,
		
--		Isnull(AV0316.ConvertedAmount4,0) as ThreeUnexpiredDebitConAmount,	
--		Isnull(AV0316.OriginalAmount4,0) as ThreeUnexpiredDebitAmount,
--		0 as ThreeUnexpiredCreditConAmount,	
--		0 as ThreeUnexpiredCreditAmount,

--		Isnull(AV0316.ConvertedAmount5,0) as FourUnexpiredDebitConAmount,	
--		Isnull(AV0316.OriginalAmount5,0) as FourUnexpiredDebitAmount,
--		0 as FourUnexpiredCreditConAmount,	
--		0 as FourUnexpiredCreditAmount,
		
--		Isnull(AV0316.ConvertedAmount6,0) as FiveUnexpiredDebitConAmount,	
--		Isnull(AV0316.OriginalAmount6,0) as FiveUnexpiredDebitAmount,
--		0 as FiveUnexpiredCreditConAmount,	
--		0 as FiveUnexpiredCreditAmount,
		
--		Isnull(AV0316.ConvertedAmount7,0) as SixUnexpiredDebitConAmount,	
--		Isnull(AV0316.OriginalAmount7,0) as SixUnexpiredDebitAmount,
--		0 as SixUnexpiredCreditConAmount,	
--		0 as SixUnexpiredCreditAmount,
--		Isnull(AV0316.ConvertedAmount8,0) as NineUnexpiredDebitConAmount,	
--		Isnull(AV0316.OriginalAmount8,0) as NineUnexpiredDebitAmount,
--		0 as NineUnexpiredCreditConAmount,	
--		0 as NineUnexpiredCreditAmount,

--		Isnull(A02.LastYearOriginalAmount,0) as LastYearOriginalAmount, Isnull(A02.LastYearConvertedAmount,0) as LastYearConvertedAmount,
--		AV00201.NetCreditAmountInYear,
--		AV00201.NetCreditConvertedAmountInYear,
--		A11.AnaName as O01Name,
--		A12.AnaName as O02Name,
--		A13.AnaName as O03Name,
--		A14.AnaName as O04Name,
--		A15.AnaName as O05Name,
--		A.ConvertedAmountTLInYear
--FROM AV7403
--LEFT JOIN	(Select ObjectID, Group3, SUM(OriginalAmount1) as OriginalAmount1, SUM(OriginalAmount2) OriginalAmount2, SUM(OriginalAmount3) as OriginalAmount3, SUM(OriginalAmount4) as OriginalAmount4, SUM(OriginalAmount5) as OriginalAmount5, SUM(OriginalAmount6) as OriginalAmount6, SUM(OriginalAmount7) as OriginalAmount7, SUM(OriginalAmount8) as OriginalAmount8,
--					SUM(ConvertedAmount1) as ConvertedAmount1, SUM(ConvertedAmount2) as ConvertedAmount2, SUM(ConvertedAmount3) as ConvertedAmount3, SUM(ConvertedAmount4) as ConvertedAmount4, SUM(ConvertedAmount5) as ConvertedAmount5, SUM(ConvertedAmount6) as ConvertedAmount6, SUM(ConvertedAmount7) as ConvertedAmount7, SUM(ConvertedAmount8) as ConvertedAmount8
--			From AV0316
--			Group by ObjectID, Group3
--			) AV0316  ON AV7403.ObjectID = AV0316.ObjectID AND ISNULL(AV0316.Group3,'''') = ISNULL(AV7403.Ana05ID,'''')
--		'
--ELSE
	SET @sSQL1 = '
		Isnull(AV0316.ConvertedAmount3,0) as ThreeUnexpiredDebitConAmount,	
		Isnull(AV0316.OriginalAmount3,0) as ThreeUnexpiredDebitAmount,
		0 as ThreeUnexpiredCreditConAmount,	
		0 as ThreeUnexpiredCreditAmount,

		Isnull(AV0316.ConvertedAmount4,0) as SixUnexpiredDebitConAmount,	
		Isnull(AV0316.OriginalAmount4,0) as SixUnexpiredDebitAmount,
		0 as SixUnexpiredCreditConAmount,	
		0 as SixUnexpiredCreditAmount,

		Isnull(AV0316.ConvertedAmount5,0) as NineUnexpiredDebitConAmount,	
		Isnull(AV0316.OriginalAmount5,0) as NineUnexpiredDebitAmount,
		0 as NineUnexpiredCreditConAmount,	
		0 as NineUnexpiredCreditAmount,

		Isnull(A02.LastYearOriginalAmount,0) as LastYearOriginalAmount, Isnull(A02.LastYearConvertedAmount,0) as LastYearConvertedAmount,
		AV00201.NetCreditAmountInYear,
		AV00201.NetCreditConvertedAmountInYear,
		A11.AnaName as O01Name,
		A12.AnaName as O02Name,
		A13.AnaName as O03Name,
		A14.AnaName as O04Name,
		A15.AnaName as O05Name,
		A.ConvertedAmountTLInYear

FROM AV7403
LEFT JOIN	(Select ObjectID, Group3, SUM(OriginalAmount1) as OriginalAmount1, SUM(OriginalAmount2) OriginalAmount2, SUM(OriginalAmount3) as OriginalAmount3, SUM(OriginalAmount4) as OriginalAmount4, SUM(OriginalAmount5) as OriginalAmount5,
					SUM(ConvertedAmount1) as ConvertedAmount1, SUM(ConvertedAmount2) as ConvertedAmount2, SUM(ConvertedAmount3) as ConvertedAmount3, SUM(ConvertedAmount4) as ConvertedAmount4, SUM(ConvertedAmount5) as ConvertedAmount5
			From AV0316
			Group by ObjectID, Group3
			) AV0316  ON AV7403.ObjectID = AV0316.ObjectID AND ISNULL(AV0316.Group3,'''') = ISNULL(AV7403.Ana05ID,'''')
		'

SET @sSQL2 = '
LEFT JOIN #AV00201 AV00201 ON AV00201.DivisionID = AV7403.DivisionID AND AV7403.ObjectID = AV00201.ObjectID AND AV00201.AccountID = AV7403.AccountID AND Isnull(AV00201.Ana05ID,'''') = Isnull(AV7403.Ana05ID,'''')
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AV7403.ObjectID = AT1202.ObjectID
LEFT JOIN AT1015 A11 WITH (NOLOCK) ON A11.AnaID = AT1202.O01ID AND A11.AnaTypeID = ''O01''
LEFT JOIN AT1015 A12 WITH (NOLOCK) ON A12.AnaID = AT1202.O02ID AND A12.AnaTypeID = ''O02''
LEFT JOIN AT1015 A13 WITH (NOLOCK) ON A13.AnaID = AT1202.O03ID AND A13.AnaTypeID = ''O03''
LEFT JOIN AT1015 A14 WITH (NOLOCK) ON A14.AnaID = AT1202.O04ID AND A14.AnaTypeID = ''O04''
LEFT JOIN AT1015 A15 WITH (NOLOCK) ON A15.AnaID = AT1202.O05ID AND A15.AnaTypeID = ''O05''
LEFT JOIN AT1011 WITH (NOLOCK) ON AV7403.Ana05ID = AT1011.AnaID AND AT1011.AnaTypeID = ''A05''
LEFT JOIN (SELECT DivisionID, ObjectID, Ana05ID,  Max(VoucherDate) as MaxVoucherDate
FROM AT9000 WITH (NOLOCK)
WHERE DivisionID = '''+@DivisionID+'''
AND TransactionTypeID IN (''T01'', ''T21'')
AND ObjectID between '''+@FromObjectID+''' AND '''+@ToObjectID+'''
GROUP BY DivisionID, ObjectID, Ana05ID) A01 ON A01.DivisionID = AV7403.DivisionID AND AV7403.ObjectID = A01.ObjectID AND Isnull(A01.Ana05ID,'''') = Isnull(AV7403.Ana05ID,'''')

LEFT JOIN (SELECT AT0303.DivisionID, AT0303.ObjectID, AT0303.AccountID, SUM(AT0303.OriginalAmount) AS LastYearOriginalAmount, SUM(AT0303.ConvertedAmount) AS LastYearConvertedAmount, A.Ana05ID 
			FROM AT0303 WITH (NOLOCK) OUTER APPLY (SELECT TOP 1 * FROM AT9000 WITH (NOLOCK) WHERE AT0303.CreditVoucherID = AT9000.VoucherID) A
			WHERE YEAR(AT0303.DebitVoucherDate) <= '+STR(YEAR(@ReportDate) - 1)+' 
					AND YEAR(AT0303.CreditVoucherDate) = '+STR(YEAR(@ReportDate))+' 
					AND AT0303.CreditVoucherDate <= ''' + CONVERT(NVARCHAR(10), @ReportDate, 121) + '''  
			GROUP BY AT0303.DivisionID, AT0303.ObjectID, AT0303.AccountID, A.Ana05ID ) A02 ON A02.DivisionID = AV7403.DivisionID AND AV7403.ObjectID = A02.ObjectID AND A02.AccountID = AV7403.AccountID AND ISNULL(AV7403.Ana05ID,'''') = ISNULL(A02.Ana05ID,'''')
  
LEFT JOIN (SELECT 
			AT9000.DivisionID, AT9000.ObjectID, SUM(ISNULL(ConvertedAmount,0)) AS ConvertedAmountTLInYear, Ana05ID
		FROM  AT9000 WITH (NOLOCK) 
		WHERE 	AT9000.DivisionID = '''+@DivisionID+''' AND
				CreditAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
				TranYear = '+str(@Year)+'
				AND AT9000.VoucherDate <= ''' +CONVERT(VARCHAR(10),@ReportDate,21)+' 23:59:59'' 				
				and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
				AND TransactionTypeID in (''T24'',''T34'')
		GROUP BY AT9000.DivisionID, AT9000.ObjectID, Ana05ID) A ON A.DivisionID = AV7403.DivisionID AND AV7403.ObjectID = A.ObjectID AND ISNULL(A.Ana05ID,'''') = ISNULL(AV7403.Ana05ID,'''')
ORDER BY AV7403.ObjectID
'
PRINT @sSQL
PRINT @sSQL1
PRINT @sSQL2
EXEC (@sSQL0+@sSQL+@sSQL1+@sSQL2)

Set nocount on







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
