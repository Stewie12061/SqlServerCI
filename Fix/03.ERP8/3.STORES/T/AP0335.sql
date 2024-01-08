IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0335]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0335]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by Tieu Mai on 05/05/2016
---- Purpose: In báo cáo doanh số bán hàng theo MPT nghiệp vụ (CustomizeIndex = 52 - KOYO)
---- Modified by Bảo Thy on 26/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 15/05/2017: Bổ sung chỉnh sửa danh mục dùng chung
---- Modified by Bảo Thy on 30/05/2017: Bổ sung trừ đi hàng bán trả lại
/*
	exec AP0335 'KVC', '05/05/2016', 'AR0334', '', '', 'KVC001', 'NNN06', '', '', 'VND'
 */


CREATE PROCEDURE [dbo].[AP0335] 	
					@DivisionID as nvarchar(50),
					@ReportDate as Datetime,
					@ReportID AS NVARCHAR(10),
					@FromObjectID AS NVARCHAR(50) = '',
					@ToObjectID AS NVARCHAR(50)= '',
					@FromEmployeeID AS NVARCHAR(50),
					@ToEmployeeID AS NVARCHAR(50),
					@FromAccountID as nvarchar(50)='',
					@ToAccountID as nvarchar(50)='',
					@CurrencyID as nvarchar(50)
					
 AS
Declare @sSQL AS nvarchar(MAX) = '',
		@Month AS int,
		@Year AS int
	
SET nocount off
SET @Month = month(@ReportDate)
SET @Year = year(@ReportDate)

IF @ReportID = 'AR0334'
	SET @sSQL='
	SELECT DivisionID, TranMonth, TranYear, Ana02ID, SUM(OrderQuantity) AS OrderQuantity, AnaName02, Ana05ID, AnaName05, Period
	FROM 
	(
		SELECT 
			AT9000.DivisionID, TranMonth, TranYear, Ana02ID, SUM(ISNULL(ConvertedQuantity,0)) AS OrderQuantity, A01.AnaName as AnaName02, 
			AT9000.Ana05ID, A02.AnaName as AnaName05,
			CONVERT(varchar(2),TranMonth) +''/''+CONVERT(varchar(5),TranYear) AS Period
		FROM  AT9000  WITH (NOLOCK)
		LEFT JOIN AT1011 A01 WITH (NOLOCK) ON AT9000.Ana02ID = A01.AnaID AND A01.AnaTypeID = ''A02'' 
		LEFT JOIN AT1011 A02 WITH (NOLOCK) ON AT9000.Ana05ID = A02.AnaID AND A02.AnaTypeID = ''A05''
		WHERE 	AT9000.DivisionID = '''+@DivisionID+''' AND
				DebitAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				AT9000.Ana05ID  between '''+@FromEmployeeID+''' AND '''+@ToEmployeeID+''' AND
				TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
				and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
				AND AT9000.TransactionTypeID = ''T04''
		GROUP BY AT9000.DivisionID, TranMonth,TranYear, Ana02ID, A01.AnaName, Ana05ID, A02.AnaName
		UNION ALL
		SELECT 
			AT9000.DivisionID, TranMonth, TranYear, Ana02ID, -SUM(ISNULL(ConvertedQuantity,0)) AS OrderQuantity, A01.AnaName as AnaName02, 
			AT9000.Ana05ID, A02.AnaName as AnaName05,
			CONVERT(varchar(2),TranMonth) +''/''+CONVERT(varchar(5),TranYear) AS Period
		FROM  AT9000  WITH (NOLOCK)
		LEFT JOIN AT1011 A01 WITH (NOLOCK) ON AT9000.Ana02ID = A01.AnaID AND A01.AnaTypeID = ''A02'' 
		LEFT JOIN AT1011 A02 WITH (NOLOCK) ON AT9000.Ana05ID = A02.AnaID AND A02.AnaTypeID = ''A05''
		WHERE 	AT9000.DivisionID = '''+@DivisionID+''' AND
				CreditAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
				AT9000.Ana05ID  between '''+@FromEmployeeID+''' AND '''+@ToEmployeeID+''' AND
				TranMonth + TranYear*100 Between '+str(@Year)+'*100 + 1 AND '+str(@Month)+'+'+str(@Year)+'*100
				and AT9000.CurrencyIDCN like '''+@CurrencyID+'''
				AND AT9000.TransactionTypeID = ''T24''
		GROUP BY AT9000.DivisionID, TranMonth,TranYear, Ana02ID, A01.AnaName, Ana05ID, A02.AnaName
	)Temp_AR0334
	GROUP BY DivisionID, TranMonth, TranYear, Ana02ID, AnaName02, Ana05ID, AnaName05, Period
	'
EXEC (@sSQL)
Set nocount on

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
