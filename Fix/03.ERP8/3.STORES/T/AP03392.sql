IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP03392]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP03392]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




---- Created by Tieu Mai on 05/05/2016
---- Purpose: lấy số lượng hàng bán theo nhóm hàng (CustomizeIndex = 52 - KOYO)
---- Modified by Bảo Thy on 26/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 20/02/2017: Bổ sung chỉ lấy TransactionTypeID = 'T04'
---- Modified by Tiểu Mai on 15/05/2017: Bổ sung chỉnh sửa danh mục dùng chung
---- Modified by Bảo Thy on 19/05/2017: Bổ sung trừ đi số lượng hàng bán trả lại
---- Modified by Tiểu Mai on 14/06/2017: Lấy bổ sung Số lượng, doanh thu hàng bán trả lại
---- Modified by Hải Long on 10/07/2017: Lấy dữ liệu theo ngày in báo cáo
/*
	exec AP03392 'KVC', '05/05/2016', 'AR0334', '', '', 'KVC001', 'NNN06', '', '', 'VND'
 */


CREATE PROCEDURE [dbo].[AP03392] 	
					@DivisionID as nvarchar(50),
					@ReportDate as Datetime,
					@FromAccountID as nvarchar(50),
					@ToAccountID as nvarchar(50),
					@FromObjectID AS NVARCHAR(50),
					@ToObjectID AS NVARCHAR(50),
					@CurrencyID as nvarchar(50)
					
 AS
Declare @sSQL AS nvarchar(MAX) = '', @sSQL1 AS nvarchar(MAX) = '',
		@Month AS int,
		@Year AS int
	
SET @Month = month(@ReportDate)
SET @Year = year(@ReportDate)

	SET @sSQL='
	SELECT T1.*, ISNULL(A.QuantityTL,0) AS QuantityTL, ISNULL(A.ConvertedAmountTL,0) AS ConvertedAmountTL
	FROM 
	(SELECT DivisionID, ObjectID, TranMonth, TranYear, Ana02ID, SUM(Quantity) AS Quantity, AnaName, Period, Ana05ID
	FROM
	(
		----Doanh so ban hang
		SELECT 
			AT9000.DivisionID, AT9000.ObjectID, TranMonth, TranYear, Ana02ID, SUM(ISNULL(ConvertedQuantity,0)) AS Quantity, A01.AnaName as AnaName,
			CONVERT(varchar(2),TranMonth) +''/''+CONVERT(varchar(5),TranYear) AS Period, Ana05ID
		FROM  AT9000 WITH (NOLOCK) 
		LEFT JOIN AT1011 A01 WITH (NOLOCK) ON AT9000.Ana02ID = A01.AnaID AND A01.AnaTypeID = ''A02'' 
		WHERE 	AT9000.DivisionID = '''+@DivisionID+''' AND
				DebitAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
				TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
				AND AT9000.VoucherDate <= ''' + CONVERT(NVARCHAR(10), @ReportDate, 111) + '''					
				and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
				AND TransactionTypeID = ''T04''
		GROUP BY AT9000.DivisionID, AT9000.ObjectID, TranMonth,TranYear, Ana02ID, A01.AnaName, Ana05ID
		UNION ALL
		----Hang ban tra lai
		SELECT 
			AT9000.DivisionID, AT9000.ObjectID, TranMonth, TranYear, Ana02ID, -SUM(ISNULL(ConvertedQuantity,0)) AS Quantity, A01.AnaName as AnaName,
			CONVERT(varchar(2),TranMonth) +''/''+CONVERT(varchar(5),TranYear) AS Period, Ana05ID
		FROM  AT9000 WITH (NOLOCK) 
		LEFT JOIN AT1011 A01 WITH (NOLOCK) ON AT9000.Ana02ID = A01.AnaID AND A01.AnaTypeID = ''A02'' 
		WHERE 	AT9000.DivisionID = '''+@DivisionID+''' AND
				CreditAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
				TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
				AND AT9000.VoucherDate <= ''' + CONVERT(NVARCHAR(10), @ReportDate, 111) + '''					
				and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
				AND TransactionTypeID = ''T24''
		GROUP BY AT9000.DivisionID, AT9000.ObjectID, TranMonth,TranYear, Ana02ID, A01.AnaName, Ana05ID
	) Temp
	GROUP BY DivisionID, ObjectID, TranMonth, TranYear, Ana02ID, AnaName, Period, Ana05ID ) T1
	'
	
	SET @sSQL1 = '
	LEFT JOIN (SELECT 
			AT9000.DivisionID, AT9000.ObjectID, TranMonth, TranYear, Ana02ID, SUM(ISNULL(ConvertedQuantity,0)) AS QuantityTL, SUM(ISNULL(ConvertedAmount,0)) AS ConvertedAmountTL,
			CONVERT(varchar(2),TranMonth) +''/''+CONVERT(varchar(5),TranYear) AS Period, Ana05ID
		FROM  AT9000 WITH (NOLOCK) 
		WHERE 	AT9000.DivisionID = '''+@DivisionID+''' AND
				CreditAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				AT9000.ObjectID  between '''+@FromObjectID+''' AND '''+@ToObjectID+''' AND
				TranMonth + TranYear*100 Between '+str(@Year)+'*100 + '+str(@Month)+' AND '+str(@Month)+'+'+str(@Year)+'*100
				AND AT9000.VoucherDate <= ''' + CONVERT(NVARCHAR(10), @ReportDate, 111) + '''					
				and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
				AND TransactionTypeID = ''T24''
		GROUP BY AT9000.DivisionID, AT9000.ObjectID, TranMonth,TranYear, Ana02ID, Ana05ID) A 
	ON T1.DivisionID  = A.DivisionID AND T1.ObjectID = A.ObjectID AND T1.TranMonth = A.TranMonth AND T1.TranYear = A.TranYear 
		AND ISNULL(T1.Ana02ID,'''') = ISNULL(A.Ana02ID,'''') AND ISNULL(T1.Ana05ID,'''') = ISNULL(A.Ana05ID,'''') 
	'
		
	--print @sSQL
IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV03392]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
	DROP VIEW AV03392
	
EXEC ('  CREATE VIEW  AV03392	--CREATED BY AP03392
	AS ' + @sSQL + @sSQL1)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
