IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0336]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0336]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by Tieu Mai on 05/05/2016
---- Purpose: In báo cáo doanh số bán hàng theo MPT nghiệp vụ (CustomizeIndex = 52 - KOYO)
---- Modified by Tiểu Mai on 24/06/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 15/05/2017: Bổ sung chỉnh sửa danh mục dùng chung
/*
	exec AP0336 'KVC', '05/05/2016', 'AR0333', '', '', 'KVC001', 'NNN06', '1311', '171', 'VND'
 */


CREATE PROCEDURE [dbo].[AP0336] 	
					@DivisionID as nvarchar(50),
					@ReportDate as Datetime,
					@ReportID AS NVARCHAR(10),
					@FromObjectID AS NVARCHAR(50) = '',
					@ToObjectID AS NVARCHAR(50)= '',
					@FromEmployeeID AS NVARCHAR(50),
					@ToEmployeeID AS NVARCHAR(50),
					@FromAccountID as nvarchar(50),
					@ToAccountID as nvarchar(50),
					@CurrencyID as nvarchar(50)
					
 AS
Declare @sSQL AS nvarchar(MAX) = '',
		@Month AS int,
		@Year AS int

SET @Month = month(@ReportDate)
SET @Year = year(@ReportDate)

IF @ReportID = 'AR0333'
BEGIN
	----- Lấy công nợ trong năm
	----- Lấy tổng doanh thu chưa thuế
	Exec AP03361	@DivisionID, @ReportDate, @FromAccountID, @ToAccountID,@FromEmployeeID, @ToEmployeeID, @CurrencyID

	----- Lấy số đã thu
	Exec AP03362	@DivisionID, @ReportDate, @FromAccountID, @ToAccountID,@FromEmployeeID, @ToEmployeeID, @CurrencyID

	SET @sSQL = '
	SELECT AV03361.Ana05ID, A02.Ananame, AV03361.AccountID, AV03361.TranMonth, AV03361.TranYear, AV03361.DivisionID, A01.SaleAmount,
			Convert(Nvarchar(2),AV03361.TranMonth)+''/''+Convert(Nvarchar(5), AV03361.TranYear) as Period, 0 AS StatusID, ISNULL(AV03361.DebitConAmount,0) AS Amount
	FROM AV03361
	LEFT JOIN (SELECT AV03361.Ana05ID, AV03361.AccountID, AV03361.DivisionID, SUM(ISNULL(AV03361.SaleAmount,0)) as SaleAmount
				FROM AV03361
	           GROUP BY AV03361.Ana05ID, AV03361.AccountID, AV03361.DivisionID) A01 ON A01.DivisionID = AV03361.DivisionID AND A01.Ana05ID = AV03361.Ana05ID AND A01.AccountID = AV03361.AccountID
	LEFT JOIN AT1011 A02 WITH (NOLOCK) ON AV03361.Ana05ID = A02.AnaID AND A02.AnaTypeID = ''A05''
	
UNION ALL	
	SELECT AV03361.Ana05ID, A02.Ananame, AV03361.AccountID, AV03361.TranMonth, AV03361.TranYear, AV03361.DivisionID, A01.SaleAmount,
			Convert(Nvarchar(2),AV03361.TranMonth)+''/''+Convert(Nvarchar(5), AV03361.TranYear) as Period, 1 AS StatusID, ISNULL(AV03362.ReceiptConvertedAmount,0) AS Amount
	FROM AV03361
	LEFT JOIN AV03362 ON AV03361.DivisionID = AV03362.DivisionID AND AV03361.AccountID = AV03362.AccountID AND AV03361.Ana05ID = AV03362.Ana05ID AND
							AV03361.TranMonth = AV03362.TranMonth AND AV03361.TranYear = AV03362.TranYear
	LEFT JOIN (SELECT AV03361.Ana05ID, AV03361.AccountID, AV03361.DivisionID, SUM(ISNULL(AV03361.SaleAmount,0)) as SaleAmount
				FROM AV03361
	           GROUP BY AV03361.Ana05ID, AV03361.AccountID, AV03361.DivisionID) A01 ON A01.DivisionID = AV03361.DivisionID AND A01.Ana05ID = AV03361.Ana05ID AND A01.AccountID = AV03361.AccountID
	LEFT JOIN AT1011 A02 WITH (NOLOCK) ON AV03361.Ana05ID = A02.AnaID AND A02.AnaTypeID = ''A05''
	'

	--PRINT @sSQL
	EXEC (@sSQL)

	DROP VIEW AV033611
	DROP VIEW AV03361
	DROP VIEW AV033621
	DROP VIEW AV03362
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
