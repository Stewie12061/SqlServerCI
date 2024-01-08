IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP1501_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP1501_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Tinh khau hao cho mot tai san co dinh theo PP duong thang.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Nguyen van Nhan, Date 30/09/2003.
---- Last UPDATE by NguyenVan Nhan, Date 29/10/2003
---- Last Edit : Van Nhan & Thuy Tuyen, date 21/07/2008
---- Last Edit : Quoc Huy, date 22/08/2008
---- Edited by: [GS] [Việt Khánh] [29/07/2010]
---- Modified on 06/02/2012 by Nguyễn Bình Minh: Bổ sung phân bổ theo bộ hệ số
---- Modified on 08/10/2015 by Tieu Mai: Sửa phần làm tròn số lẻ theo thiết lập đơn vị-chi nhánh
---- Modified by Tiểu Mai on 22/06/2016: Fix bug tính khấu hao theo số ngày trong tháng và Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 20/07/2016: Sửa func EOMONTH vì SQL2008 ko sử dụng được.
---- Modified by Tiểu Mai on 02/11/2016: Fix không khấu hao hết cho kỳ áp cuối nếu tiền còn lại > mức khấu hao tháng
---- Modified by Phương Thảo on 09/02/2017: Bổ sung điều kiện: and @Period<@DepPeriods : dùng trong TH đã khấu hao hết kỳ KH nhưng vẫn còn số lẻ
---- Modified by Huỳnh Thử on 19/08/2020: Merge Code: MEKIO và MTE
-- <Example>
---- 
CREATE PROCEDURE [dbo].[AP1501_MK]
( 
    @DivisionID NVARCHAR(50), 
    @TranMonth INT, 
    @TranYear INT, 
    @AssetID NVARCHAR(50), 
    @DepAccountID NVARCHAR(50), 
    @ResidualValue DECIMAL(28,8), 
    @DebitDepAccountID1 NVARCHAR(50), 
    @DepPercent1 DECIMAL(28,8), 
    @DebitDepAccountID2 NVARCHAR(50), 
    @DepPercent2 DECIMAL(28,8), 
    @DebitDepAccountID3 NVARCHAR(50), 
    @DepPercent3 DECIMAL(28,8), 
    @DebitDepAccountID4 NVARCHAR(50), 
    @DepPercent4 DECIMAL(28,8), 
    @DebitDepAccountID5 NVARCHAR(50), 
    @DepPercent5 DECIMAL(28,8), 
    @DebitDepAccountID6 NVARCHAR(50), 
    @DepPercent6 DECIMAL(28,8), 
    @Ana01ID1 NVARCHAR(50), 
    @Ana02ID1 NVARCHAR(50), 
    @Ana03ID1 NVARCHAR(50), 
    @Ana01ID2 NVARCHAR(50), 
    @Ana02ID2 NVARCHAR(50), 
    @Ana03ID2 NVARCHAR(50), 
    @Ana01ID3 NVARCHAR(50), 
    @Ana02ID3 NVARCHAR(50), 
    @Ana03ID3 NVARCHAR(50), 
    @Ana01ID4 NVARCHAR(50), 
    @Ana02ID4 NVARCHAR(50), 
    @Ana03ID4 NVARCHAR(50), 
    @Ana01ID5 NVARCHAR(50), 
    @Ana02ID5 NVARCHAR(50), 
    @Ana03ID5 NVARCHAR(50), 
    @Ana01ID6 NVARCHAR(50), 
    @Ana02ID6 NVARCHAR(50), 
    @Ana03ID6 NVARCHAR(50), 
    @TotalDepAmount DECIMAL(28,8), --- muc khau hao trong ky
    @DepPercent DECIMAL(28,8), 
    @SourceID1 NVARCHAR(50), 
    @SourceID2 NVARCHAR(50), 
    @SourceID3 NVARCHAR(50), 
    @SourcePercent1 DECIMAL(28,8), 
    @SourcePercent2 DECIMAL(28,8), 
    @SourcePercent3 DECIMAL(28,8), 
    @PeriodID01 NVARCHAR(50), 
    @PeriodID02 NVARCHAR(50), 
    @PeriodID03 NVARCHAR(50), 
    @PeriodID04 NVARCHAR(50), 
    @PeriodID05 NVARCHAR(50), 
    @PeriodID06 NVARCHAR(50), 
    @VoucherTypeID NVARCHAR(50), 
    @VoucherNo NVARCHAR(50), 
    @VoucherDate DATETIME, 
    @BDescription NVARCHAR(250), 
    @UserID NVARCHAR(50),
	@UseCofficientID TINYINT = NULL,
	@CoefficientID NVARCHAR(50) = NULL,
	@Ana04ID1 NVARCHAR(50) = NULL, @Ana05ID1 NVARCHAR(50) = NULL, @Ana06ID1 NVARCHAR(50) = NULL, 
	@Ana04ID2 NVARCHAR(50) = NULL, @Ana05ID2 NVARCHAR(50) = NULL, @Ana06ID2 NVARCHAR(50) = NULL, 
	@Ana04ID3 NVARCHAR(50) = NULL, @Ana05ID3 NVARCHAR(50) = NULL, @Ana06ID3 NVARCHAR(50) = NULL, 
	@Ana04ID4 NVARCHAR(50) = NULL, @Ana05ID4 NVARCHAR(50) = NULL, @Ana06ID4 NVARCHAR(50) = NULL, 
	@Ana04ID5 NVARCHAR(50) = NULL, @Ana05ID5 NVARCHAR(50) = NULL, @Ana06ID5 NVARCHAR(50) = NULL, 	
	@Ana04ID6 NVARCHAR(50) = NULL, @Ana05ID6 NVARCHAR(50) = NULL, @Ana06ID6 NVARCHAR(50) = NULL
)     
AS

DECLARE @ReMainAmount DECIMAL(28,8), 
		@DepreciationID NVARCHAR(50), 
		@DepAmount DECIMAL(28,8), 
		@ConvertedDecimals INT, 
		@BeginMonth INT, 
		@BeginYear INT, 
		@BeginDate DATETIME, 
		@Days INT,
		@DayInMonth INT

DECLARE @SourceID AS NVARCHAR(50),
		@DebitDepAccountID AS NVARCHAR(50),
		@PeriodID AS NVARCHAR(50),
		@Ana01ID AS NVARCHAR(50),
		@Ana02ID AS NVARCHAR(50),
		@Ana03ID AS NVARCHAR(50),
		@Ana04ID AS NVARCHAR(50),
		@Ana05ID AS NVARCHAR(50),
		@cCoefficient AS CURSOR,
		@CustomerIndex AS INT,
		@Period AS INT,
		@DepPeriods AS INT

SELECT @CustomerIndex = CustomerName From CustomerIndex

SELECT	@BeginMonth = BeginMonth, @BeginYear = BeginYear, @BeginDate = StartDate 
FROM	AT1503  WITH (NOLOCK)
WHERE	AssetID = @AssetID

SELECT @Period = DepMonths 
FROM AT1503 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND AssetID = @AssetID

SELECT  @DepPeriods = CASE WHEN EXISTS (	SELECT	TOP 1 AssetID
								FROM	AT1506 WITH (NOLOCK)
								WHERE	AT1506.AssetID = AT1503.AssetID
										AND AT1506.DivisionID = AT1503.DivisionID
										AND AT1506.TranMonth + 100 * AT1506.TranYear <= @TranMonth + 100 * @TranYear
						) THEN (	SELECT		TOP 1 AT1506.DepNewPeriods
										FROM		AT1506 WITH (NOLOCK)
										WHERE		AT1506.AssetID = AT1503.AssetID
													AND AT1506.DivisionID = AT1503.DivisionID
													AND AT1506.TranMonth + 100 * AT1506.TranYear <= @TranMonth + 100 * @TranYear
						              	ORDER BY	AT1506.TranYear DESC, AT1506.TranMonth DESC
								)
				ELSE DepPeriods END
FROM AT1503 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND AssetID = @AssetID


SET @ConvertedDecimals  = ISNULL((SELECT TOP 1 ConvertedDecimals FROM AT1101 WHERE DivisionID = @DivisionID), 0)

SET @ReMainAmount = @ResidualValue 
		+ (	CASE WHEN EXISTS (SELECT	TOP 1 AssetID 
		                     FROM		AT1506  WITH (NOLOCK) 
		                     WHERE		AT1506.AssetID = @AssetID AND AT1506.DivisionID = @DivisionID
										AND AT1506.TranMonth + 100 * AT1506.TranYear < = @TranMonth + 100 * @TranYear)
					THEN (	SELECT		TOP 1 ISNULL (AT1506.AccuDepAmount, 0) - (ISNULL(T03.ConvertedAmount, 0)- ISNULL(T03.ResidualValue, 0)) 
					      	FROM		AT1506  WITH (NOLOCK)
							INNER JOIN	AT1503 T03 WITH (NOLOCK) ON T03.AssetID = AT1506.AssetID AND T03.DivisionID = AT1506.DivisionID 
							WHERE		AT1506.AssetID = @AssetID AND AT1506.DivisionID = @DivisionID
										AND AT1506.TranMonth + 100 * AT1506.TranYear < = @TranMonth + 100 * @TranYear 
					      	ORDER BY	AT1506.TranYear DESC, AT1506.TranMonth DESC)
			ELSE 0 END)
	-	(	SELECT	ISNULL (SUM(DepAmount), 0) 
	 	 	FROM	AT1504 WITH (NOLOCK) 
	 	 	WHERE	AssetID = @AssetID AND AT1504.DivisionID = @DivisionID 
	 	 			AND AT1504.TranMonth + 100 * AT1504.TranYear < = @TranMonth + @TranYear * 100)

SET  @DayInMonth = DAY (DATEADD(d,-1, DATEADD(mm, DATEDIFF(mm, 0 ,@VoucherDate)+1, 0)))
-- Trường hợp không sử dụng bộ hệ số, làm như cũ
IF @ReMainAmount > 0 and ISNULL(@Period,0) < ISNULL(@DepPeriods,0) AND ISNULL(@UseCofficientID, 0) = 0
BEGIN
    IF @TranMonth + @TranYear * 100 = @BeginMonth + @BeginYear * 100 AND @BeginDate IS NOT NULL
    BEGIN
        SET @Days = @DayInMonth - DAY(@BeginDate) + 1
        SET @TotalDepAmount = ROUND(@TotalDepAmount * @Days / @DayInMonth, @ConvertedDecimals)
    END

    IF @ReMainAmount - @TotalDepAmount < @TotalDepAmount / 2 AND (@DepPeriods - @Period = 1)
    BEGIN 
    	
        SET @TotalDepAmount = ROUND(@ReMainAmount, @ConvertedDecimals)
	END 
	
    IF ISNULL(@DebitDepAccountID1, '') <>'' AND ISNULL(@SourceID1, '')<>''
    BEGIN
		SET @DepAmount = ROUND(@SourcePercent1 * @DepPercent1 * @TotalDepAmount/10000, @ConvertedDecimals)
		--SELECT @TotalDepAmount,@SourcePercent1, @DepPercent1, @DepAmount
        EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID1, @BDescription, @DepAccountID, @DebitDepAccountID1, @DepAmount, @DepPercent, @UserID, @Ana01ID1, @Ana02ID1, @Ana03ID1, @PeriodID01, @Ana04ID1, @Ana05ID1, NULL, @Ana06ID1
	END 

    IF ISNULL(@DebitDepAccountID1, '') <>'' AND ISNULL(@SourceID2, '')<>''
    BEGIN
		SET @DepAmount = ROUND(@SourcePercent2 * @DepPercent1 * @TotalDepAmount/10000, @ConvertedDecimals)
        EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID2, @BDescription, @DepAccountID, @DebitDepAccountID1, @DepAmount, @DepPercent, @UserID, @Ana01ID1, @Ana02ID1, @Ana03ID1, @PeriodID01, @Ana04ID1, @Ana05ID1, NULL, @Ana06ID1
	END 

    IF ISNULL(@DebitDepAccountID1, '') <>'' AND ISNULL(@SourceID3, '')<>''
    BEGIN
		SET @DepAmount = ROUND(@SourcePercent3 * @DepPercent1 * @TotalDepAmount/10000, @ConvertedDecimals)
        EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID3, @BDescription, @DepAccountID, @DebitDepAccountID1, @DepAmount, @DepPercent, @UserID, @Ana01ID1, @Ana02ID1, @Ana03ID1, @PeriodID01, @Ana04ID1, @Ana05ID1, NULL, @Ana06ID1
	END 
        
    IF ISNULL(@DebitDepAccountID2, '') <>'' AND ISNULL(@SourceID1, '')<>''
	BEGIN
		SET @DepAmount = ROUND(@SourcePercent1 * @DepPercent2 * @TotalDepAmount/10000, @ConvertedDecimals)
        EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID1, @BDescription, @DepAccountID, @DebitDepAccountID2, @DepAmount, @DepPercent, @UserID, @Ana01ID2, @Ana02ID2, @Ana03ID2, @PeriodID02, @Ana04ID2, @Ana05ID2, NULL, @Ana06ID2
	END 

    IF ISNULL(@DebitDepAccountID2, '') <>'' AND ISNULL(@SourceID2, '')<>''
    BEGIN
		SET @DepAmount = ROUND(@SourcePercent2 * @DepPercent2 * @TotalDepAmount/10000, @ConvertedDecimals)
		EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID2, @BDescription, @DepAccountID, @DebitDepAccountID2, @DepAmount, @DepPercent, @UserID, @Ana01ID2, @Ana02ID2, @Ana03ID2, @PeriodID02, @Ana04ID2, @Ana05ID2, NULL, @Ana06ID2
	END 
        
    IF ISNULL(@DebitDepAccountID2, '') <>'' AND ISNULL(@SourceID3, '')<>''
    BEGIN
		SET @DepAmount = ROUND(@SourcePercent3 * @DepPercent2 * @TotalDepAmount/10000, @ConvertedDecimals)
        EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID3, @BDescription, @DepAccountID, @DebitDepAccountID2, @DepAmount, @DepPercent, @UserID, @Ana01ID2, @Ana02ID2, @Ana03ID2, @PeriodID02, @Ana04ID2, @Ana05ID2, NULL, @Ana06ID2
	END 
        
    IF ISNULL(@DebitDepAccountID3, '') <>'' AND ISNULL(@SourceID1, '')<>''
    BEGIN
		SET @DepAmount = ROUND(@SourcePercent1 * @DepPercent3 * @TotalDepAmount/10000, @ConvertedDecimals)
        EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID1, @BDescription, @DepAccountID, @DebitDepAccountID3, @DepAmount, @DepPercent, @UserID, @Ana01ID3, @Ana02ID3, @Ana03ID3, @PeriodID03, @Ana04ID3, @Ana05ID3, NULL, @Ana06ID3
	END 
        
    IF ISNULL(@DebitDepAccountID3, '') <>'' AND ISNULL(@SourceID2, '')<>''
    BEGIN
		SET @DepAmount = ROUND(@SourcePercent2 * @DepPercent3 * @TotalDepAmount/10000, @ConvertedDecimals)
        EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID2, @BDescription, @DepAccountID, @DebitDepAccountID3, @DepAmount, @DepPercent, @UserID, @Ana01ID3, @Ana02ID3, @Ana03ID3, @PeriodID03, @Ana04ID3, @Ana05ID3, NULL, @Ana06ID3
	END 
        
    IF ISNULL(@DebitDepAccountID3, '') <>'' AND ISNULL(@SourceID3, '')<>''
    BEGIN
        SET @DepAmount = ROUND(@SourcePercent3 * @DepPercent3 * @TotalDepAmount/10000, @ConvertedDecimals)
		EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID3, @BDescription, @DepAccountID, @DebitDepAccountID3, @DepAmount, @DepPercent, @UserID, @Ana01ID3, @Ana02ID3, @Ana03ID3, @PeriodID03, @Ana04ID3, @Ana05ID3, NULL, @Ana06ID3
	END 
        
    ------ Phan bo sung
    IF ISNULL(@DebitDepAccountID4, '') <>'' AND ISNULL(@SourceID1, '')<>''
	BEGIN
		SET @DepAmount = ROUND(@SourcePercent1 * @DepPercent4 * @TotalDepAmount/10000, @ConvertedDecimals)
        EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID1, @BDescription, @DepAccountID, @DebitDepAccountID4, @DepAmount, @DepPercent, @UserID, @Ana01ID4, @Ana02ID4, @Ana03ID4, @PeriodID04, @Ana04ID4, @Ana05ID4, NULL, @Ana06ID4
	END 

    IF ISNULL(@DebitDepAccountID4, '') <>'' AND ISNULL(@SourceID2, '')<>''
    BEGIN
		SET @DepAmount = ROUND(@SourcePercent2 * @DepPercent4 * @TotalDepAmount/10000, @ConvertedDecimals)
		EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID2, @BDescription, @DepAccountID, @DebitDepAccountID4, @DepAmount, @DepPercent, @UserID, @Ana01ID4, @Ana02ID4, @Ana03ID4, @PeriodID04, @Ana04ID4, @Ana05ID4, NULL, @Ana06ID4
	END 

    IF ISNULL(@DebitDepAccountID4, '') <>'' AND ISNULL(@SourceID3, '')<>''
    BEGIN
		SET @DepAmount = ROUND(@SourcePercent3 * @DepPercent1 * @TotalDepAmount/10000, @ConvertedDecimals)
		EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID3, @BDescription, @DepAccountID, @DebitDepAccountID4, @DepAmount, @DepPercent, @UserID, @Ana01ID4, @Ana02ID4, @Ana03ID4, @PeriodID04, @Ana04ID4, @Ana05ID4, NULL, @Ana06ID4
    END 
    
    IF ISNULL(@DebitDepAccountID5, '') <>'' AND ISNULL(@SourceID1, '')<>''
	BEGIN
		SET @DepAmount = ROUND(@SourcePercent1 * @DepPercent2 * @TotalDepAmount/10000, @ConvertedDecimals)
		EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID1, @BDescription, @DepAccountID, @DebitDepAccountID5, @DepAmount, @DepPercent, @UserID, @Ana01ID5, @Ana02ID5, @Ana03ID5, @PeriodID05, @Ana04ID5, @Ana05ID5, NULL, @Ana06ID5
	END 

    IF ISNULL(@DebitDepAccountID5, '') <>'' AND ISNULL(@SourceID2, '')<>''
    BEGIN
		SET @DepAmount = ROUND(@SourcePercent2 * @DepPercent2 * @TotalDepAmount/10000, @ConvertedDecimals)
        EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID2, @BDescription, @DepAccountID, @DebitDepAccountID5, @DepAmount, @DepPercent, @UserID, @Ana01ID5, @Ana02ID5, @Ana03ID5, @PeriodID05, @Ana04ID5, @Ana05ID5, NULL, @Ana06ID5
	END 
        
    IF ISNULL(@DebitDepAccountID5, '') <>'' AND ISNULL(@SourceID3, '')<>''
    BEGIN
		SET @DepAmount = ROUND(@SourcePercent3 * @DepPercent2 * @TotalDepAmount/10000, @ConvertedDecimals)
        EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID3, @BDescription, @DepAccountID, @DebitDepAccountID5, @DepAmount, @DepPercent, @UserID, @Ana01ID5, @Ana02ID5, @Ana03ID5, @PeriodID05, @Ana04ID5, @Ana05ID5, NULL, @Ana06ID5
	END 
        
    IF ISNULL(@DebitDepAccountID6, '') <>'' AND ISNULL(@SourceID1, '')<>''
    BEGIN
		SET @DepAmount = ROUND(@SourcePercent1 * @DepPercent3 * @TotalDepAmount/10000, @ConvertedDecimals)
        EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID1, @BDescription, @DepAccountID, @DebitDepAccountID6, @DepAmount, @DepPercent, @UserID, @Ana01ID6, @Ana02ID6, @Ana03ID6, @PeriodID06, @Ana04ID6, @Ana05ID6, NULL, @Ana06ID6
	END 
        
    IF ISNULL(@DebitDepAccountID6, '') <>'' AND ISNULL(@SourceID2, '')<>''
    BEGIN
		SET @DepAmount = ROUND(@SourcePercent2 * @DepPercent3 * @TotalDepAmount/10000, @ConvertedDecimals)
        EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID2, @BDescription, @DepAccountID, @DebitDepAccountID6, @DepAmount, @DepPercent, @UserID, @Ana01ID6, @Ana02ID6, @Ana03ID6, @PeriodID06, @Ana04ID6, @Ana05ID6, NULL, @Ana06ID6
	END 
        
    IF ISNULL(@DebitDepAccountID6, '') <>'' AND ISNULL(@SourceID3, '')<>''
    BEGIN
		SET @DepAmount = ROUND(@SourcePercent3 * @DepPercent3 * @TotalDepAmount/10000, @ConvertedDecimals)
		EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID3, @BDescription, @DepAccountID, @DebitDepAccountID6, @DepAmount, @DepPercent, @UserID, @Ana01ID6, @Ana02ID6, @Ana03ID6, @PeriodID06, @Ana04ID6, @Ana05ID6, NULL, @Ana06ID6
	END 

    ------- Xu ly so le, lam tron so
    EXEC AP1511 @DivisionID, @TranMonth, @TranYear, @AssetID, @TotalDepAmount
END

-- Phân bổ theo bộ hệ số
IF @ReMainAmount > 0 AND ISNULL(@UseCofficientID, 0) = 1
BEGIN
	-- Kỳ đầu tiên, giá trị phân bổ theo số ngày bắt đầu đưa vào sử dụng
    IF @TranMonth + @TranYear * 100 = @BeginMonth + @BeginYear * 100 AND @BeginDate IS NOT NULL
    BEGIN
        SET @Days = @DayInMonth - DAY(@BeginDate) + 1
        SET @TotalDepAmount = ROUND(@TotalDepAmount * @Days / @DayInMonth , @ConvertedDecimals)
    END

    IF @ReMainAmount - @TotalDepAmount < @TotalDepAmount / 2
        SET @TotalDepAmount = ROUND(@ReMainAmount, @ConvertedDecimals)
		        
	SET @cCoefficient = CURSOR STATIC FOR
		SELECT		S.SourceID, ROUND(D.CoValue * S.SourcePercent * @TotalDepAmount / 10000, @ConvertedDecimals) AS DepAmount, D.AccountID, D.Ana01ID, D.Ana02ID, D.Ana03ID, D.Ana04ID, D.Ana05ID, D.PeriodID
		FROM		AT1511 D WITH (NOLOCK)
		INNER JOIN	AT1510 M WITH (NOLOCK)
				ON	M.DivisionID = D.DivisionID AND M.CoefficientID = D.CoefficientID
		CROSS JOIN (	SELECT @SourceID1 AS SourceID, @SourcePercent1 AS SourcePercent
						UNION ALL
						SELECT @SourceID2 AS SourceID, @SourcePercent2 AS SourcePercent
						UNION ALL
						SELECT @SourceID3 AS SourceID, @SourcePercent3 AS SourcePercent
					) S			
		WHERE		D.DivisionID = @DivisionID AND D.CoefficientID = @CoefficientID AND S.SourceID IS NOT NULL
		ORDER BY	D.Orders
		
	OPEN @cCoefficient
	FETCH NEXT FROM @cCoefficient INTO @SourceID, @DepAmount, @DebitDepAccountID, @Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, @PeriodID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, 
					@SourceID, @BDescription, @DepAccountID, @DebitDepAccountID, @DepAmount, @DepPercent, @UserID, 
					@Ana01ID, @Ana02ID, @Ana03ID, @PeriodID, @Ana04ID, @Ana05ID, @CoefficientID
		FETCH NEXT FROM @cCoefficient INTO @SourceID, @DepAmount, @DebitDepAccountID, @Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, @PeriodID
	END
	
	------- Xu ly so le, lam tron so
    EXEC AP1511 @DivisionID, @TranMonth, @TranYear, @AssetID, @TotalDepAmount
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

