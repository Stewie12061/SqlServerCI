IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0337]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0337]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by Tieu Mai on 05/05/2016
---- Purpose: In mẫu báo cáo AR0335 (kết quả hoạt động kinh doanh) (CustomizeIndex = 52 - KOYO)
---- Modified by Tiểu Mai on 24/06/2016: Bổ sung WITH (NOLOCK)
---- Modified by Kim Thư on 6/12/2018: Điều chỉnh theo những cải tiến ở bản 8.1 do trước đó chưa sửa luôn cho bản 8.3.7STD (những comment của chị Mai)
		---- Modified by Tiểu Mai on 140/06/2017: Lấy bổ sung Số lượng, doanh thu hàng bán trả lại
		---- Modified by Tiểu Mai on 26/07/2018: Chỉnh sửa lại đúng yêu cầu, cải tiến tốc độ
		---- Modified by Kim Thư on 14/11/2018: Bổ sung If exists view

/*
	exec AP0337 'KVC', '05/05/2016', 'AR0335', '', '', 'KVC001', 'NNN06', '1311', '171', 'VND'
 */


CREATE PROCEDURE [dbo].[AP0337] 	
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

IF @ReportID IN ('AR0333','AR0335')
BEGIN
	----- Lấy công nợ trong năm
	----- Lấy tổng doanh thu chưa thuế
	Exec AP03361	@DivisionID, @ReportDate, @FromAccountID, @ToAccountID,@FromEmployeeID, @ToEmployeeID, @CurrencyID

	----- Lấy số đã thu
	Exec AP03362	@DivisionID, @ReportDate, @FromAccountID, @ToAccountID,@FromEmployeeID, @ToEmployeeID, @CurrencyID

	--SET @sSQL = '
	--SELECT  AV03361.TranMonth, AV03361.TranYear, SUM(ISNULL(AV03361.SaleAmount,0)) SaleAmount,
	--		SUM(ISNULL(AV03361.DebitAmount,0)) DebitAmount , SUM(ISNULL(AV03361.DebitConAmount,0)) DebitConAmount ,			
	--		SUM(ISNULL(ReceiptOriginalAmount,0)) ReceiptOriginalAmount, SUM(ISNULL(ReceiptConvertedAmount,0))  ReceiptConvertedAmount			
	--FROM AV03361
	--LEFT JOIN AV03362 ON AV03361.DivisionID = AV03362.DivisionID AND AV03361.AccountID = AV03362.AccountID AND AV03361.Ana05ID = AV03362.Ana05ID AND
	--						AV03361.TranMonth = AV03362.TranMonth AND AV03361.TranYear = AV03362.TranYear
	--group by 	AV03361.TranMonth, AV03361.TranYear
	--ORDER BY AV03361.TranMonth asc
	--'

	SET @sSQL = '
	SELECT AV03361.Ana05ID, A02.Ananame, AV03361.AccountID, AV03361.TranMonth, AV03361.TranYear, AV03361.DivisionID, A01.SaleAmount,
			Convert(Nvarchar(2),AV03361.TranMonth)+''/''+Convert(Nvarchar(5), AV03361.TranYear) as Period, ISNULL(AV03361.DebitConAmount,0) AS DebitConAmount,
			ISNULL(AV03362.ReceiptConvertedAmount,0) AS ReceiptConvertedAmount, AV03361.QuantityTL, AV03361.ConvertedAmountTL, ISNULL(AV03361.SaleAmount,0) AS SaleAmountDetail 
	FROM AV03361
	LEFT JOIN AV03362 ON AV03361.DivisionID = AV03362.DivisionID AND AV03361.AccountID = AV03362.AccountID AND AV03361.Ana05ID = AV03362.Ana05ID AND
							AV03361.TranMonth = AV03362.TranMonth AND AV03361.TranYear = AV03362.TranYear
	LEFT JOIN (SELECT AV03361.Ana05ID, AV03361.AccountID, AV03361.DivisionID, SUM(ISNULL(AV03361.SaleAmount,0)) as SaleAmount
				FROM AV03361
	           GROUP BY AV03361.Ana05ID, AV03361.AccountID, AV03361.DivisionID) A01 ON A01.DivisionID = AV03361.DivisionID AND A01.Ana05ID = AV03361.Ana05ID AND A01.AccountID = AV03361.AccountID
	LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.DivisionID = AV03361.DivisionID AND AV03361.Ana05ID = A02.AnaID AND A02.AnaTypeID = ''A05''
	'

	--PRINT @sSQL
	EXEC (@sSQL)
	IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV033611]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
		DROP VIEW AV033611
	IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV03361]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
		DROP VIEW AV03361
	IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV033621]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
		DROP VIEW AV033621
	IF EXISTS (SELECT NAME FROM SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AV03362]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
		DROP VIEW AV03362
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
