IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP6500]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP6500]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created by Nguyen Van Nhan, Date 21/11/2003
----- Edited by Nguyen Quoc Huy, Date 28/09/2005
----- Bao cao luan chuyen tien te
/********************************************
'* Edited by: [GS] [Thanh Nguyen] [01/08/2010]
'********************************************/
--Last Edit by Thiên Huỳnh  on 21/06/2012: Gán lại theo @AmountUnit
---- Modified on 22/10/2012 by Lê Thị Thu Hiền : Bổ sung in nhiều đơn vị
---- Modified on 15/04/2015 by hoàng vũ : bổ sung thêm chức năng hiển thị dấu âm dương
---- Modified by Bảo Thy on 23/05/2017: Sửa danh mục dùng chung
---- Modified by Tiểu Mai on 14/09/2017: Bổ sung MPT lưu chuyển tiền tệ
---- Modified by Như Hàn on 24/09/2018: Bổ sung lấy dữ liệu Kỳ trước là kỳ liền kề(Mode = 0) hay Kỳ trước là cùng kỳ của năm trước(Mode = 1)
---- Modified by Văn Tài on 25/11/2020: Bổ sung param ngày lập báo cáo. Customize Store Tiên Tiến.

CREATE PROCEDURE [dbo].[AP6500]
		@DivisionID AS nvarchar(50),
		@TranMonthFrom1 AS INT,
		@TranYearFrom1 AS INT,
		@TranMonthTo1 AS INT,
		@TranYearTo1 AS INT,
		@ReportCode AS nvarchar(50),
		@AmountUnit AS TINYINT,
		@StrDivisionID AS NVARCHAR(4000) = '',
		@Mode As TINYINT = 0, --Mode = 0: Lấy dữ liệu kỳ trước là kỳ liền kề, Mode = 1 Lấy dữ liệu kỳ trước là cùng kỳ năm trước
		@ReportDate AS DATETIME = NULL
AS
DECLARE @TranMonthFrom AS INT,
        @TranYearFrom AS INT,
        @TranMonthTo AS INT,
        @TranYearTo AS INT,
        @LastTranMonthTo AS INT,
        @LastTranYearTo AS INT,
        @LastTranMonthTo1 AS INT,
        @LastTranYearTo1 AS INT,
        @ConvertAmountUnit AS DECIMAL(28, 8),
        @AT6502_Cursor AS CURSOR,
        @LineCode AS NVARCHAR(50),
        @LineDescription AS NVARCHAR(250),
        @LineDescriptionE AS NVARCHAR(250),
        @AccountIDFrom AS NVARCHAR(50),
        @AccountIDTo AS NVARCHAR(50),
        @CorAccountIDFrom AS NVARCHAR(50),
        @CorAccountIDTo AS NVARCHAR(50),
        @AmountSign AS TINYINT,
        @D_C AS TINYINT,
        @PeriodAmount AS TINYINT,
        @AccuSign AS NVARCHAR(50),
        @Accumulator AS NVARCHAR(50),
        @PrintStatus AS TINYINT,
        @PrintCode AS NVARCHAR(50),
        @Level AS TINYINT,
        @Notes AS NVARCHAR(250),
        @Space AS INT,
        @DisplayedMark AS TINYINT,
        @AccCaseFlowAnaFrom NVARCHAR(50),
        @AccCaseFlowAnaTo NVARCHAR(50),
        @CorAccCaseFlowAnaFrom NVARCHAR(50),
        @CorAccCaseFlowAnaTo NVARCHAR(50),
        @IsAna TINYINT,
        --Xu ly bien table de tang toc do xu ly
        @AV4201 AS TypeOfAV4201,
        @AV4202 AS TypeOfAV4202,
        @CaseAnaTypeID NVARCHAR(50),
		@CustomerName INT

SET @CustomerName = (SELECT TOP 1 CustomerName FROM CustomerIndex)

IF (@CustomerName = 13) -- Tiên Tiến
BEGIN
	EXEC AP6500_TIENTIEN @DivisionID = @DivisionID,
						 @TranMonthFrom1 = @TranMonthFrom1,
						 @TranYearFrom1 = @TranYearFrom1,
						 @TranMonthTo1 = @TranMonthTo1,
						 @TranYearTo1 = @TranYearTo1,
						 @ReportCode = @ReportCode,
						 @AmountUnit = @AmountUnit,
						 @StrDivisionID = @StrDivisionID,
						 @Mode = @Mode,
						 @ReportDate = @ReportDate;
END
ELSE
BEGIN

SELECT @CaseAnaTypeID = ISNULL(CaseFlowAnaTypeID,'') FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID

IF ISNULL(@CaseAnaTypeID,'') <> ''
BEGIN 
	SET @IsAna = 1
	--AV4201
	INSERT INTO @AV4201(DivisionID,AccountID,ConvertedAmount,TranMonth,TranYear,CorAccountID,D_C,TransactionTypeID, AnaID)
	SELECT DivisionID, DebitAccountID AS AccountID,   
	 SUM(ConvertedAmount) AS ConvertedAmount,   
	 TranMonth,TranYear,   
	 CreditAccountID AS CorAccountID,   -- tai khoan doi ung  
	 'D' AS D_C, TransactionTypeID,
	 CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A01' THEN Ana01ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A02' THEN Ana02ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A03' THEN Ana03ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A04' THEN Ana04ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A05' THEN Ana05ID ELSE 
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A06' THEN Ana06ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A07' THEN Ana07ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A08' THEN Ana08ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A09' THEN Ana09ID ELSE Ana10ID END END END END END END END END END AS AnaID
	FROM AT9000 WITH (NOLOCK)  
	WHERE isnull(DebitAccountID,'') <> ''  
	GROUP BY DivisionID, DebitAccountID, TranMonth, TranYear, CreditAccountID, TransactionTypeID,
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A01' THEN Ana01ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A02' THEN Ana02ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A03' THEN Ana03ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A04' THEN Ana04ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A05' THEN Ana05ID ELSE 
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A06' THEN Ana06ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A07' THEN Ana07ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A08' THEN Ana08ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A09' THEN Ana09ID ELSE Ana10ID END END END END END END END END END
	UNION ALL  
	------------------- So phat sinh co, lay am  
	SELECT DivisionID, CreditAccountID AS AccountID,   
	 SUM(ConvertedAmount*-1) AS ConvertedAmount,   
	 TranMonth, TranYear,   
	 DebitAccountID AS CorAccountID,   
	 'C' AS D_C, TransactionTypeID,
	 CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A01' THEN Ana01ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A02' THEN Ana02ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A03' THEN Ana03ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A04' THEN Ana04ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A05' THEN Ana05ID ELSE 
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A06' THEN Ana06ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A07' THEN Ana07ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A08' THEN Ana08ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A09' THEN Ana09ID ELSE Ana10ID END END END END END END END END END AS AnaID   
	FROM AT9000 WITH (NOLOCK)   
	WHERE isnull(CreditAccountID,'')<> ''  
	GROUP BY DivisionID, CreditAccountID, TranMonth, TranYear, DebitAccountID, TransactionTypeID,
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A01' THEN Ana01ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A02' THEN Ana02ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A03' THEN Ana03ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A04' THEN Ana04ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A05' THEN Ana05ID ELSE 
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A06' THEN Ana06ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A07' THEN Ana07ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A08' THEN Ana08ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A09' THEN Ana09ID ELSE Ana10ID END END END END END END END END END

	--AV4202
	INSERT INTO @AV4202(ObjectID,CurrencyIDCN,VoucherDate,InvoiceDate,DueDate,
	DivisionID,AccountID,InventoryID,ConvertedAmount,OriginalAmount,TranMonth,TranYear,
	CorAccountID,D_C,TransactionTypeID, AnaID)

	SELECT  ObjectID,    ---- PHAT SINH NO  
	  CurrencyIDCN,VoucherDate, InvoiceDate, DueDate,  
	  AT9000.DivisionID, DebitAccountID AS AccountID, InventoryID,  
	  SUM(isnull(ConvertedAmount,0)) AS ConvertedAmount,   
	  sum(isnull(OriginalAmountCN,0)) AS OriginalAmount,  
	  TranMonth,TranYear,   
	  CreditAccountID AS CorAccountID,   -- tai khoan doi ung  
	  'D' AS D_C, TransactionTypeID,
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A01' THEN Ana01ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A02' THEN Ana02ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A03' THEN Ana03ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A04' THEN Ana04ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A05' THEN Ana05ID ELSE 
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A06' THEN Ana06ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A07' THEN Ana07ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A08' THEN Ana08ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A09' THEN Ana09ID ELSE Ana10ID END END END END END END END END END AS AnaID  
	FROM AT9000 WITH (NOLOCK)  inner join AT1005 WITH (NOLOCK)  on AT1005.AccountID = AT9000.DebitAccountID
	WHERE DebitAccountID IS NOT NULL and AT1005.GroupID  in ('G03', 'G04')  
	GROUP BY ObjectID, Ana01ID, CurrencyIDCN, VoucherDate, InvoiceDate, DueDate, AT9000.DivisionID, DebitAccountID,   
	 TranMonth, TranYear, CreditAccountID, TransactionTypeID, InventoryID,
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A01' THEN Ana01ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A02' THEN Ana02ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A03' THEN Ana03ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A04' THEN Ana04ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A05' THEN Ana05ID ELSE 
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A06' THEN Ana06ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A07' THEN Ana07ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A08' THEN Ana08ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A09' THEN Ana09ID ELSE Ana10ID END END END END END END END END END       
	UNION ALL  
	------------------- So phat sinh co, lay am  
	SELECT    ---- PHAT SINH CO   
	 (Case when TransactionTypeID ='T99' then CreditObjectID else ObjectID end) as ObjectID,   
	 CurrencyIDCN,VoucherDate, InvoiceDate, DueDate,  
	 AT9000.DivisionID, CreditAccountID AS AccountID, InventoryID,  
	 SUM(isnull(ConvertedAmount,0)*-1) AS ConvertedAmount,   
	 sum(isnull(OriginalAmountCN,0)*-1) AS OriginalAmount,  
	 TranMonth, TranYear,   
	 DebitAccountID AS CorAccountID,   
	 'C' AS D_C, TransactionTypeID,
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A01' THEN Ana01ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A02' THEN Ana02ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A03' THEN Ana03ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A04' THEN Ana04ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A05' THEN Ana05ID ELSE 
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A06' THEN Ana06ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A07' THEN Ana07ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A08' THEN Ana08ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A09' THEN Ana09ID ELSE Ana10ID END END END END END END END END END AS AnaID   
	FROM AT9000 WITH (NOLOCK)  inner join AT1005 WITH (NOLOCK)  on AT1005.AccountID = AT9000.CreditAccountID
	WHERE CreditAccountID IS NOT NULL  and AT1005.GroupID in ('G03', 'G04')  
	GROUP BY (Case when TransactionTypeID ='T99' then CreditObjectID else ObjectID end), Ana01ID,  
	 CurrencyIDCN, VoucherDate, InvoiceDate, DueDate, AT9000.DivisionID, CreditAccountID,   
	 TranMonth, TranYear, DebitAccountID, TransactionTypeID, InventoryID,
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A01' THEN Ana01ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A02' THEN Ana02ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A03' THEN Ana03ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A04' THEN Ana04ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A05' THEN Ana05ID ELSE 
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A06' THEN Ana06ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A07' THEN Ana07ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A08' THEN Ana08ID ELSE
		CASE WHEN ISNULL(@CaseAnaTypeID,'') = 'A09' THEN Ana09ID ELSE Ana10ID END END END END END END END END END
END
ELSE
BEGIN
	SET @IsAna = 0
	--AV4201
	INSERT INTO @AV4201(DivisionID,AccountID,ConvertedAmount,TranMonth,TranYear,CorAccountID,D_C,TransactionTypeID)
	SELECT DivisionID, DebitAccountID AS AccountID,   
	 SUM(ConvertedAmount) AS ConvertedAmount,   
	 TranMonth,TranYear,   
	 CreditAccountID AS CorAccountID,   -- tai khoan doi ung  
	 'D' AS D_C, TransactionTypeID
	FROM AT9000 WITH (NOLOCK)  
	WHERE isnull(DebitAccountID,'') <> ''  
	GROUP BY DivisionID, DebitAccountID, TranMonth, TranYear, CreditAccountID, TransactionTypeID
	UNION ALL  
	------------------- So phat sinh co, lay am  
	SELECT DivisionID, CreditAccountID AS AccountID,   
	 SUM(ConvertedAmount*-1) AS ConvertedAmount,   
	 TranMonth, TranYear,   
	 DebitAccountID AS CorAccountID,   
	 'C' AS D_C, TransactionTypeID   
	FROM AT9000 WITH (NOLOCK)   
	WHERE isnull(CreditAccountID,'')<> ''  
	GROUP BY DivisionID, CreditAccountID, TranMonth, TranYear, DebitAccountID, TransactionTypeID

	--AV4202
	INSERT INTO @AV4202(ObjectID,CurrencyIDCN,VoucherDate,InvoiceDate,DueDate,
	DivisionID,AccountID,InventoryID,ConvertedAmount,OriginalAmount,TranMonth,TranYear,
	CorAccountID,D_C,TransactionTypeID)

	SELECT  ObjectID,    ---- PHAT SINH NO  
	  CurrencyIDCN,VoucherDate, InvoiceDate, DueDate,  
	  AT9000.DivisionID, DebitAccountID AS AccountID, InventoryID,  
	  SUM(isnull(ConvertedAmount,0)) AS ConvertedAmount,   
	  sum(isnull(OriginalAmountCN,0)) AS OriginalAmount,  
	  TranMonth,TranYear,   
	  CreditAccountID AS CorAccountID,   -- tai khoan doi ung  
	  'D' AS D_C, TransactionTypeID 
	FROM AT9000 WITH (NOLOCK)  inner join AT1005 WITH (NOLOCK)  on AT1005.AccountID = AT9000.DebitAccountID
	WHERE DebitAccountID IS NOT NULL and AT1005.GroupID  in ('G03', 'G04')  
	GROUP BY ObjectID, Ana01ID, CurrencyIDCN, VoucherDate, InvoiceDate, DueDate, AT9000.DivisionID, DebitAccountID,   
	 TranMonth, TranYear, CreditAccountID, TransactionTypeID, InventoryID       
	UNION ALL  
	------------------- So phat sinh co, lay am  
	SELECT    ---- PHAT SINH CO   
	 (Case when TransactionTypeID ='T99' then CreditObjectID else ObjectID end) as ObjectID,   
	 CurrencyIDCN,VoucherDate, InvoiceDate, DueDate,  
	 AT9000.DivisionID, CreditAccountID AS AccountID, InventoryID,  
	 SUM(isnull(ConvertedAmount,0)*-1) AS ConvertedAmount,   
	 sum(isnull(OriginalAmountCN,0)*-1) AS OriginalAmount,  
	 TranMonth, TranYear,   
	 DebitAccountID AS CorAccountID,   
	 'C' AS D_C, TransactionTypeID 
	FROM AT9000 WITH (NOLOCK)  inner join AT1005 WITH (NOLOCK)  on AT1005.AccountID = AT9000.CreditAccountID
	WHERE CreditAccountID IS NOT NULL  and AT1005.GroupID in ('G03', 'G04')  
	GROUP BY (Case when TransactionTypeID ='T99' then CreditObjectID else ObjectID end), Ana01ID,  
	 CurrencyIDCN, VoucherDate, InvoiceDate, DueDate, AT9000.DivisionID, CreditAccountID,   
	 TranMonth, TranYear, DebitAccountID, TransactionTypeID, InventoryID	
END 

DELETE AT6503 
--WHERE DivisionID = @DivisionID

IF @Mode = 0 
BEGIN

		IF @TranMonthFrom1 > 1
			BEGIN	---- Thang truoc do; nam cua ky truoc do
			SET @TranMonthTo = @TranMonthFrom1 -1
			SET @TranYearTo = @TranYearFrom1
			END
		ELSE
			BEGIN
			SET @TranMonthTo = 12
			SET @TranYearTo = @TranYearFrom1 -1
			END

		------- Xac dinh ky truoc ch­a chÝnh x¸c
		Set @Space =(@TranMonthTo1+@TranYearTo1*12) -  (@TranMonthFrom1+@TranYearFrom1*12)

		--Print ' KC :'+str(@Space)
		Set @Space=(@TranMonthTo+12*@TranYearTo)-@Space

		---Print str(@Space)
		If @Space%12 =0 
		Begin
			set @TranYearFrom = @Space/12 -1
			Set @TranMonthFrom=12
		End
		Else
		Begin
			set @TranYearFrom = @Space/12
			Set @TranMonthFrom=@Space%12
		End
END
ELSE 
	BEGIN
		SET @TranMonthFrom = @TranMonthFrom1
		SET @TranYearFrom = @TranYearFrom1 - 1
		SET @TranMonthTo = @TranMonthTo1
		SET @TranYearTo = @TranYearTo1 - 1
	END

--Print 'tu: '+str(@TranMonthFrom)+'/'+str(@TranYearFrom)+' den: '++str(@TranMonthTo)+'/'+str(@TranYearTo)

SET @ConvertAmountUnit =1

IF @AmountUnit = 1 SET @ConvertAmountUnit = 1
IF @AmountUnit = 2 SET @ConvertAmountUnit = 10
IF @AmountUnit = 3 SET @ConvertAmountUnit = 100
IF @AmountUnit = 4 SET @ConvertAmountUnit = 1000
IF @AmountUnit = 5 SET @ConvertAmountUnit = 10000
IF @AmountUnit = 6 SET @ConvertAmountUnit = 100000
IF @AmountUnit = 7 SET @ConvertAmountUnit = 1000000

---- Buoc 1: Insert gia tri vao bang tam

SET @AT6502_Cursor = CURSOR SCROLL KEYSET FOR
	SELECT	T32.LineCode, 		T32.LineDescription,	T32.LineDescriptionE,	
			T32.PrintStatus,	T32.AccuSign,			T32.Accumulator,
			T32.PrintCode,		isnull(Level1,3),		T32.Notes, T32.DisplayedMark
	FROM	AT6502 AS T32
	WHERE	T32.ReportCode = @ReportCode 
			AND DivisionID = @DivisionID

OPEN @AT6502_Cursor
FETCH NEXT FROM @AT6502_Cursor INTO
			@LineCode,		@LineDescription, 	@LineDescriptionE, 	@PrintStatus,		@AccuSign,	
			@Accumulator,		@PrintCode,  @Level,	@Notes, @DisplayedMark
WHILE @@FETCH_STATUS = 0
    BEGIN
	
	INSERT INTO AT6503  (DivisionID, 
		LineCode,		LineDescription,	LineDescriptionE,		PrintStatus, 		
		Amount1,		Amount2,  	
		AccuSign,		Accumulator,		PrintCode, 				Level1,			Notes, DisplayedMark
		)
	    VALUES ( @DivisionID,
		@LineCode,		@LineDescription,	@LineDescriptionE, 		@PrintStatus,		
		0,				0,
		@AccuSign,		@Accumulator,		@PrintCode ,			@Level,			@Notes	, @DisplayedMark	
		)     	

	FETCH NEXT FROM @AT6502_Cursor INTO
			@LineCode,		@LineDescription, 	@LineDescriptionE, 	@PrintStatus,		@AccuSign,	@Accumulator,
			@PrintCode,		@Level,				@Notes, @DisplayedMark
    END
CLOSE @AT6502_Cursor
DEALLOCATE @AT6502_Cursor

---------- Buoc 2: Xu ly so lieu tung dong.



DECLARE @Amount1 AS decimal(28, 8),		
		@Amount2 AS decimal(28, 8)		

SET @AT6502_Cursor = CURSOR SCROLL KEYSET FOR
	SELECT	T32.LineCode, 		T32.AccountIDFrom,	T32.AccountIDTo,	T32.CorAccountIDFrom,
			T32.CorAccountIDTo,	T32.D_C,		T32.AmountSign,	T32.AccuSign,
			T32.Accumulator,	T32.PeriodAmount, T32.AccCaseFlowAnaFrom, T32.AccCaseFlowAnaTo, T32.CorAccCaseFlowAnaFrom, T32.CorAccCaseFlowAnaTo
	FROM	AT6502  AS T32
	WHERE	T32.ReportCode = @ReportCode 
			AND DivisionID = @DivisionID
			
/*			
Print ltrim(@TranMonthFrom1) + '/' + ltrim(@TranYearFrom1)
Print ltrim(@TranMonthTo1) + '/' + ltrim(@TranYearTo1)
Print ltrim(@TranMonthFrom) + '/' + ltrim(@TranYearFrom)
Print ltrim(@TranMonthTo) + '/' + ltrim(@TranYearTo)
*/

OPEN @AT6502_Cursor
FETCH NEXT FROM @AT6502_Cursor INTO
			@LineCode,		@AccountIDFrom,	@AccountIDTo,		@CorAccountIDFrom,	
			@CorAccountIDTo,	@D_C,			@AmountSign,		@AccuSign,
			@Accumulator,		@PeriodAmount, @AccCaseFlowAnaFrom, @AccCaseFlowAnaTo, @CorAccCaseFlowAnaFrom, @CorAccCaseFlowAnaTo
WHILE @@FETCH_STATUS = 0
    BEGIN
	SET @Amount1 = 0
	SET @Amount2 = 0
	
	IF @PeriodAmount = 2   --- So dau nam
	    BEGIN
			EXEC  AP760301 @DivisionID, @AccountIDFrom, @AccountIDTo, @CorAccountIDFrom, @CorAccountIDTo,@TranMonthFrom1,@TranYearFrom1, @TranMonthTo1, @TranYearTo1, 1, @D_C, @OutputAmount = @Amount1 OUTPUT , @StrDivisionID = @StrDivisionID, @AV4201 = @AV4201, @AV4202 = @AV4202, @IsAna = @IsAna, @AccCaseFlowAnaFrom=@AccCaseFlowAnaFrom, @AccCaseFlowAnaTo=@AccCaseFlowAnaTo, @CorAccCaseFlowAnaFrom=@CorAccCaseFlowAnaFrom, @CorAccCaseFlowAnaTo=@CorAccCaseFlowAnaTo
			EXEC  AP760301 @DivisionID, @AccountIDFrom, @AccountIDTo, @CorAccountIDFrom, @CorAccountIDTo, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, 1, @D_C, @OutputAmount = @Amount2 OUTPUT	, @StrDivisionID = @StrDivisionID, @AV4201 = @AV4201, @AV4202 = @AV4202, @IsAna = @IsAna, @AccCaseFlowAnaFrom=@AccCaseFlowAnaFrom, @AccCaseFlowAnaTo=@AccCaseFlowAnaTo, @CorAccCaseFlowAnaFrom=@CorAccCaseFlowAnaFrom, @CorAccCaseFlowAnaTo=@CorAccCaseFlowAnaTo
	    END	
	    
	IF @PeriodAmount = 0   --- So cuoi nam
	    BEGIN
			IF @AmountSign In (0,1)
			BEGIN
				EXEC  AP760301 @DivisionID, @AccountIDFrom, @AccountIDTo, @CorAccountIDFrom, @CorAccountIDTo,@TranMonthFrom1,@TranYearFrom1, @TranMonthTo1, @TranYearTo1, 7, @D_C, @OutputAmount = @Amount1 OUTPUT , @StrDivisionID = @StrDivisionID, @AV4201 = @AV4201, @AV4202 = @AV4202, @IsAna = @IsAna, @AccCaseFlowAnaFrom=@AccCaseFlowAnaFrom, @AccCaseFlowAnaTo=@AccCaseFlowAnaTo, @CorAccCaseFlowAnaFrom=@CorAccCaseFlowAnaFrom, @CorAccCaseFlowAnaTo=@CorAccCaseFlowAnaTo
				EXEC  AP760301 @DivisionID, @AccountIDFrom, @AccountIDTo, @CorAccountIDFrom, @CorAccountIDTo, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, 7, @D_C, @OutputAmount = @Amount2 OUTPUT	, @StrDivisionID = @StrDivisionID, @AV4201 = @AV4201, @AV4202 = @AV4202, @IsAna = @IsAna, @AccCaseFlowAnaFrom=@AccCaseFlowAnaFrom, @AccCaseFlowAnaTo=@AccCaseFlowAnaTo, @CorAccCaseFlowAnaFrom=@CorAccCaseFlowAnaFrom, @CorAccCaseFlowAnaTo=@CorAccCaseFlowAnaTo
			END
						
			IF @AmountSign = 2
			BEGIN
				EXEC  AP760301 @DivisionID, @AccountIDFrom, @AccountIDTo, @CorAccountIDFrom, @CorAccountIDTo,@TranMonthFrom1,@TranYearFrom1, @TranMonthTo1, @TranYearTo1, 6, @D_C, @OutputAmount = @Amount1 OUTPUT , @StrDivisionID = @StrDivisionID, @AV4201 = @AV4201, @AV4202 = @AV4202, @IsAna = @IsAna, @AccCaseFlowAnaFrom=@AccCaseFlowAnaFrom, @AccCaseFlowAnaTo=@AccCaseFlowAnaTo, @CorAccCaseFlowAnaFrom=@CorAccCaseFlowAnaFrom, @CorAccCaseFlowAnaTo=@CorAccCaseFlowAnaTo
				EXEC  AP760301 @DivisionID, @AccountIDFrom, @AccountIDTo, @CorAccountIDFrom, @CorAccountIDTo, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, 6, @D_C, @OutputAmount = @Amount2 OUTPUT	, @StrDivisionID = @StrDivisionID, @AV4201 = @AV4201, @AV4202 = @AV4202, @IsAna = @IsAna, @AccCaseFlowAnaFrom=@AccCaseFlowAnaFrom, @AccCaseFlowAnaTo=@AccCaseFlowAnaTo, @CorAccCaseFlowAnaFrom=@CorAccCaseFlowAnaFrom, @CorAccCaseFlowAnaTo=@CorAccCaseFlowAnaTo
			END
	    END	

	IF @PeriodAmount = 1 ---- So trong ky	
	    BEGIN
		IF @AmountSign = 0	---- Phat sinh Co
		    BEGIN
			EXEC  AP760301 @DivisionID, @AccountIDFrom, @AccountIDTo, @CorAccountIDFrom, @CorAccountIDTo, @TranMonthFrom1, @TranYearFrom1, @TranMonthTo1, @TranYearTo1, 5, @D_C, @OutputAmount = @Amount1 OUTPUT , @StrDivisionID = @StrDivisionID, @AV4201 = @AV4201, @AV4202 = @AV4202, @IsAna = @IsAna, @AccCaseFlowAnaFrom=@AccCaseFlowAnaFrom, @AccCaseFlowAnaTo=@AccCaseFlowAnaTo, @CorAccCaseFlowAnaFrom=@CorAccCaseFlowAnaFrom, @CorAccCaseFlowAnaTo=@CorAccCaseFlowAnaTo
			EXEC  AP760301 @DivisionID, @AccountIDFrom, @AccountIDTo, @CorAccountIDFrom, @CorAccountIDTo, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, 5, @D_C, @OutputAmount = @Amount2 OUTPUT , @StrDivisionID = @StrDivisionID , @AV4201 = @AV4201, @AV4202 = @AV4202, @IsAna = @IsAna, @AccCaseFlowAnaFrom=@AccCaseFlowAnaFrom, @AccCaseFlowAnaTo=@AccCaseFlowAnaTo, @CorAccCaseFlowAnaFrom=@CorAccCaseFlowAnaFrom, @CorAccCaseFlowAnaTo=@CorAccCaseFlowAnaTo
		    END
		IF @AmountSign = 1   	 --- Phat sinh No
		    BEGIN
			EXEC  AP760301 @DivisionID, @AccountIDFrom, @AccountIDTo, @CorAccountIDFrom, @CorAccountIDTo, @TranMonthFrom1, @TranYearFrom1, @TranMonthTo1, @TranYearTo1, 4, @D_C, @OutputAmount = @Amount1 OUTPUT, @StrDivisionID = @StrDivisionID, @AV4201 = @AV4201, @AV4202 = @AV4202, @IsAna = @IsAna, @AccCaseFlowAnaFrom=@AccCaseFlowAnaFrom, @AccCaseFlowAnaTo=@AccCaseFlowAnaTo, @CorAccCaseFlowAnaFrom=@CorAccCaseFlowAnaFrom, @CorAccCaseFlowAnaTo=@CorAccCaseFlowAnaTo
			EXEC  AP760301 @DivisionID, @AccountIDFrom, @AccountIDTo, @CorAccountIDFrom, @CorAccountIDTo, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, 4, @D_C, @OutputAmount = @Amount2 OUTPUT, @StrDivisionID = @StrDivisionID, @AV4201 = @AV4201, @AV4202 = @AV4202, @IsAna = @IsAna, @AccCaseFlowAnaFrom=@AccCaseFlowAnaFrom, @AccCaseFlowAnaTo=@AccCaseFlowAnaTo, @CorAccCaseFlowAnaFrom=@CorAccCaseFlowAnaFrom, @CorAccCaseFlowAnaTo=@CorAccCaseFlowAnaTo
		    END
		IF @AmountSign = 2   --- Ca hai
		    BEGIN
			EXEC  AP760301 @DivisionID, @AccountIDFrom, @AccountIDTo, @CorAccountIDFrom, @CorAccountIDTo, @TranMonthFrom1, @TranYearFrom1, @TranMonthTo1, @TranYearTo1, 3, @D_C, @OutputAmount = @Amount1 OUTPUT, @StrDivisionID = @StrDivisionID, @AV4201 = @AV4201, @AV4202 = @AV4202, @IsAna = @IsAna, @AccCaseFlowAnaFrom=@AccCaseFlowAnaFrom, @AccCaseFlowAnaTo=@AccCaseFlowAnaTo, @CorAccCaseFlowAnaFrom=@CorAccCaseFlowAnaFrom, @CorAccCaseFlowAnaTo=@CorAccCaseFlowAnaTo
			EXEC  AP760301 @DivisionID, @AccountIDFrom, @AccountIDTo, @CorAccountIDFrom, @CorAccountIDTo, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, 3, @D_C, @OutputAmount = @Amount2 OUTPUT, @StrDivisionID = @StrDivisionID, @AV4201 = @AV4201, @AV4202 = @AV4202, @IsAna = @IsAna, @AccCaseFlowAnaFrom=@AccCaseFlowAnaFrom, @AccCaseFlowAnaTo=@AccCaseFlowAnaTo, @CorAccCaseFlowAnaFrom=@CorAccCaseFlowAnaFrom, @CorAccCaseFlowAnaTo=@CorAccCaseFlowAnaTo
		    END
	    END
	
	
	SET @Amount1 = @Amount1/@ConvertAmountUnit
	SET @Amount2 = @Amount2/@ConvertAmountUnit

	IF (@Amount1<>0 OR @Amount2<>0)
		EXEC AP6501 @DivisionID,@ReportCode, @LineCode, @Amount2, @Amount1, '+', @LineCode	

	FETCH NEXT FROM @AT6502_Cursor INTO
			@LineCode,		@AccountIDFrom,	@AccountIDTo,		@CorAccountIDFrom,	
			@CorAccountIDTo,	@D_C,			@AmountSign,		@AccuSign,
			@Accumulator,		@PeriodAmount, @AccCaseFlowAnaFrom, @AccCaseFlowAnaTo, @CorAccCaseFlowAnaFrom, @CorAccCaseFlowAnaTo
    END

CLOSE @AT6502_Cursor

DEALLOCATE @AT6502_Cursor

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
