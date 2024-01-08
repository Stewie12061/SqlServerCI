IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1501]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1501]
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
---- Modified on 03/04/2018 by Bảo Anh: Bổ sung Mã chi phí SXC
---- Modified on 18/07/2018 by Bảo Anh: Sửa lỗi khấu hao không đúng ở tháng đầu tiên đối với TS đã được khấu hao bên ngoài trước khi dùng PM
---- Modified on 19/08/2020 by Bảo Anh: Merge Code: MEKIO và MTE -- Tách Store AP1501
---- Modified on 30/10/2020 by Hoài Phong: Tính lại Khấu hao lũy kế
---- Modified on 30/10/2020 by Hoài Phong: Thấy đổi điều kiện tính Khấu hao lũy kế
---- Modified on 16/12/2022 by Kiều Nga: Bổ sung Mpt từ 7 =>10
-- <Example>
---- 
CREATE PROCEDURE [dbo].[AP1501]
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
	@Ana04ID1 NVARCHAR(50) = NULL, @Ana05ID1 NVARCHAR(50) = NULL, @Ana06ID1 NVARCHAR(50) = NULL,@Ana07ID1 NVARCHAR(50) = NULL,@Ana08ID1 NVARCHAR(50) = NULL,@Ana09ID1 NVARCHAR(50) = NULL,@Ana10ID1 NVARCHAR(50) = NULL,
	@Ana04ID2 NVARCHAR(50) = NULL, @Ana05ID2 NVARCHAR(50) = NULL, @Ana06ID2 NVARCHAR(50) = NULL,@Ana07ID2 NVARCHAR(50) = NULL,@Ana08ID2 NVARCHAR(50) = NULL,@Ana09ID2 NVARCHAR(50) = NULL,@Ana10ID2 NVARCHAR(50) = NULL,
	@Ana04ID3 NVARCHAR(50) = NULL, @Ana05ID3 NVARCHAR(50) = NULL, @Ana06ID3 NVARCHAR(50) = NULL,@Ana07ID3 NVARCHAR(50) = NULL,@Ana08ID3 NVARCHAR(50) = NULL,@Ana09ID3 NVARCHAR(50) = NULL,@Ana10ID3 NVARCHAR(50) = NULL,
	@Ana04ID4 NVARCHAR(50) = NULL, @Ana05ID4 NVARCHAR(50) = NULL, @Ana06ID4 NVARCHAR(50) = NULL,@Ana07ID4 NVARCHAR(50) = NULL,@Ana08ID4 NVARCHAR(50) = NULL,@Ana09ID4 NVARCHAR(50) = NULL,@Ana10ID4 NVARCHAR(50) = NULL,
	@Ana04ID5 NVARCHAR(50) = NULL, @Ana05ID5 NVARCHAR(50) = NULL, @Ana06ID5 NVARCHAR(50) = NULL,@Ana07ID5 NVARCHAR(50) = NULL,@Ana08ID5 NVARCHAR(50) = NULL,@Ana09ID5 NVARCHAR(50) = NULL,@Ana10ID5 NVARCHAR(50) = NULL,	
	@Ana04ID6 NVARCHAR(50) = NULL, @Ana05ID6 NVARCHAR(50) = NULL, @Ana06ID6 NVARCHAR(50) = NULL,@Ana07ID6 NVARCHAR(50) = NULL,@Ana08ID6 NVARCHAR(50) = NULL,@Ana09ID6 NVARCHAR(50) = NULL,@Ana10ID6 NVARCHAR(50) = NULL,
	@MaterialTypeID01 NVARCHAR(50) = NULL, @MaterialTypeID02 NVARCHAR(50) = NULL, @MaterialTypeID03 NVARCHAR(50) = NULL,
	@MaterialTypeID04 NVARCHAR(50) = NULL, @MaterialTypeID05 NVARCHAR(50) = NULL, @MaterialTypeID06 NVARCHAR(50) = NULL
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
		@Ana06ID AS NVARCHAR(50),
		@Ana07ID AS NVARCHAR(50),
		@Ana08ID AS NVARCHAR(50),
		@Ana09ID AS NVARCHAR(50),
		@Ana10ID AS NVARCHAR(50),
		@cCoefficient AS CURSOR,
		@DepMonths AS INT,
		@CustomerName INT 

SELECT @CustomerName = CustomerName FROM dbo.CustomerIndex
IF(@CustomerName = 50 OR @CustomerName = 115) -- Mekio hoặc Mte
BEGIN
	EXEC AP1501_MK @DivisionID , 
    @TranMonth , 
    @TranYear , 
    @AssetID , 
    @DepAccountID , 
    @ResidualValue , 
    @DebitDepAccountID1 , 
    @DepPercent1 , 
    @DebitDepAccountID2 , 
    @DepPercent2 , 
    @DebitDepAccountID3 , 
    @DepPercent3 , 
    @DebitDepAccountID4 , 
    @DepPercent4 , 
    @DebitDepAccountID5 , 
    @DepPercent5 , 
    @DebitDepAccountID6 , 
    @DepPercent6 , 
    @Ana01ID1 , 
    @Ana02ID1 , 
    @Ana03ID1 , 
    @Ana01ID2 , 
    @Ana02ID2 , 
    @Ana03ID2 , 
    @Ana01ID3 , 
    @Ana02ID3 , 
    @Ana03ID3 , 
    @Ana01ID4 , 
    @Ana02ID4 , 
    @Ana03ID4 , 
    @Ana01ID5 , 
    @Ana02ID5 , 
    @Ana03ID5 , 
    @Ana01ID6 , 
    @Ana02ID6 , 
    @Ana03ID6 , 
    @TotalDepAmount , --- muc khau hao trong ky
    @DepPercent , 
    @SourceID1 , 
    @SourceID2 , 
    @SourceID3 , 
    @SourcePercent1 , 
    @SourcePercent2 , 
    @SourcePercent3 , 
    @PeriodID01 , 
    @PeriodID02 , 
    @PeriodID03 , 
    @PeriodID04 , 
    @PeriodID05 , 
    @PeriodID06 , 
    @VoucherTypeID , 
    @VoucherNo , 
    @VoucherDate , 
    @BDescription , 
    @UserID ,
	@UseCofficientID ,
	@CoefficientID ,
	@Ana04ID1 , @Ana05ID1 , @Ana06ID1 , 
	@Ana04ID2 , @Ana05ID2 , @Ana06ID2 , 
	@Ana04ID3 , @Ana05ID3 , @Ana06ID3 , 
	@Ana04ID4 , @Ana05ID4 , @Ana06ID4 , 
	@Ana04ID5 , @Ana05ID5 , @Ana06ID5 , 	
	@Ana04ID6 , @Ana05ID6 , @Ana06ID6 
END
ELSE
BEGIN
	SELECT	@BeginMonth = BeginMonth, @BeginYear = BeginYear, @BeginDate = StartDate, @DepMonths = ISNULL(DepMonths,0)
	FROM	AT1503  WITH (NOLOCK)
	WHERE	AssetID = @AssetID

	SET @ConvertedDecimals  = ISNULL((SELECT TOP 1 ConvertedDecimals FROM AT1101 WHERE DivisionID = @DivisionID), 0)

	SET @ReMainAmount = @ResidualValue 
			- (	CASE WHEN EXISTS (SELECT	TOP 1 AssetID 
								 FROM		AT1506  WITH (NOLOCK) 
								 WHERE		AT1506.AssetID = @AssetID AND AT1506.DivisionID = @DivisionID
											AND AT1506.TranMonth + 100 * AT1506.TranYear < = @TranMonth + 100 * @TranYear)
						THEN (	SELECT	ISNULL (SUM(DepAmount), 0) 
	 	 								FROM	AT1504 WITH (NOLOCK) 
	 	 								WHERE	AssetID = @AssetID AND AT1504.DivisionID = @DivisionID 
	 	 										AND AT1504.TranMonth + 100 * AT1504.TranYear BETWEEN 
												(SELECT TOP 1 TRANMONTH + TRANYEAR * 100 FROM AT1506 WHERE AT1506.AssetID = @AssetID AND AT1506.DivisionID = @DivisionID
												AND AT1506.TranMonth + 100 * AT1506.TranYear < = @TranMonth + 100 * @TranYear
												ORDER BY AT1506.TranYear DESC, AT1506.TranMonth DESC) 
												AND	 @TranMonth + @TranYear * 100)
				ELSE (	SELECT	ISNULL (SUM(DepAmount), 0) 
	 	 		FROM	AT1504 WITH (NOLOCK) 
	 	 		WHERE	AssetID = @AssetID AND AT1504.DivisionID = @DivisionID 
	 	 				AND AT1504.TranMonth + 100 * AT1504.TranYear < = @TranMonth + @TranYear * 100) END)
			

	SET  @DayInMonth = DAY (DATEADD(d,-1, DATEADD(mm, DATEDIFF(mm, 0 ,@VoucherDate)+1, 0)))
	-- Trường hợp không sử dụng bộ hệ số, làm như cũ
	IF @ReMainAmount > 0 AND ISNULL(@UseCofficientID, 0) = 0
	BEGIN
		IF @TranMonth + @TranYear * 100 = @BeginMonth + @BeginYear * 100 AND @BeginDate IS NOT NULL AND @DepMonths = 0
		BEGIN
			SET @Days = @DayInMonth - DAY(@BeginDate) + 1
			 SET @TotalDepAmount = ROUND(@TotalDepAmount * @Days / @DayInMonth, @ConvertedDecimals)
		END

		IF @ReMainAmount - @TotalDepAmount < @TotalDepAmount / 2
			SET @TotalDepAmount = ROUND(@ReMainAmount, @ConvertedDecimals)

		IF ISNULL(@DebitDepAccountID1, '') <>'' AND ISNULL(@SourceID1, '')<>''
		BEGIN
			SET @DepAmount = ROUND(@SourcePercent1 * @DepPercent1 * @TotalDepAmount/10000, @ConvertedDecimals)
			EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID1, @BDescription, @DepAccountID, @DebitDepAccountID1, @DepAmount, @DepPercent, @UserID, @Ana01ID1, @Ana02ID1, @Ana03ID1, @PeriodID01, @Ana04ID1, @Ana05ID1, NULL, @Ana06ID1 ,@MaterialTypeID01,@Ana07ID1, @Ana08ID1, @Ana09ID1, @Ana10ID1
		END 

		IF ISNULL(@DebitDepAccountID1, '') <>'' AND ISNULL(@SourceID2, '')<>''
		BEGIN
			SET @DepAmount = ROUND(@SourcePercent2 * @DepPercent1 * @TotalDepAmount/10000, @ConvertedDecimals)
			EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID2, @BDescription, @DepAccountID, @DebitDepAccountID1, @DepAmount, @DepPercent, @UserID, @Ana01ID1, @Ana02ID1, @Ana03ID1, @PeriodID01, @Ana04ID1, @Ana05ID1, NULL, @Ana06ID1,@MaterialTypeID01,@Ana07ID1, @Ana08ID1, @Ana09ID1, @Ana10ID1 
		END 

		IF ISNULL(@DebitDepAccountID1, '') <>'' AND ISNULL(@SourceID3, '')<>''
		BEGIN
			SET @DepAmount = ROUND(@SourcePercent3 * @DepPercent1 * @TotalDepAmount/10000, @ConvertedDecimals)
			EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID3, @BDescription, @DepAccountID, @DebitDepAccountID1, @DepAmount, @DepPercent, @UserID, @Ana01ID1, @Ana02ID1, @Ana03ID1, @PeriodID01, @Ana04ID1, @Ana05ID1, NULL, @Ana06ID1, @MaterialTypeID01,@Ana07ID1, @Ana08ID1, @Ana09ID1, @Ana10ID1
		END 
        
		IF ISNULL(@DebitDepAccountID2, '') <>'' AND ISNULL(@SourceID1, '')<>''
		BEGIN
			SET @DepAmount = ROUND(@SourcePercent1 * @DepPercent2 * @TotalDepAmount/10000, @ConvertedDecimals)
			EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID1, @BDescription, @DepAccountID, @DebitDepAccountID2, @DepAmount, @DepPercent, @UserID, @Ana01ID2, @Ana02ID2, @Ana03ID2, @PeriodID02, @Ana04ID2, @Ana05ID2, NULL, @Ana06ID2, @MaterialTypeID02,@Ana07ID2, @Ana08ID2, @Ana09ID2, @Ana10ID2
		END 

		IF ISNULL(@DebitDepAccountID2, '') <>'' AND ISNULL(@SourceID2, '')<>''
		BEGIN
			SET @DepAmount = ROUND(@SourcePercent2 * @DepPercent2 * @TotalDepAmount/10000, @ConvertedDecimals)
			EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID2, @BDescription, @DepAccountID, @DebitDepAccountID2, @DepAmount, @DepPercent, @UserID, @Ana01ID2, @Ana02ID2, @Ana03ID2, @PeriodID02, @Ana04ID2, @Ana05ID2, NULL, @Ana06ID2, @MaterialTypeID02,@Ana07ID2, @Ana08ID2, @Ana09ID2, @Ana10ID2
		END 
        
		IF ISNULL(@DebitDepAccountID2, '') <>'' AND ISNULL(@SourceID3, '')<>''
		BEGIN
			SET @DepAmount = ROUND(@SourcePercent3 * @DepPercent2 * @TotalDepAmount/10000, @ConvertedDecimals)
			EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID3, @BDescription, @DepAccountID, @DebitDepAccountID2, @DepAmount, @DepPercent, @UserID, @Ana01ID2, @Ana02ID2, @Ana03ID2, @PeriodID02, @Ana04ID2, @Ana05ID2, NULL, @Ana06ID2, @MaterialTypeID02,@Ana07ID2, @Ana08ID2, @Ana09ID2, @Ana10ID2
		END 
        
		IF ISNULL(@DebitDepAccountID3, '') <>'' AND ISNULL(@SourceID1, '')<>''
		BEGIN
			SET @DepAmount = ROUND(@SourcePercent1 * @DepPercent3 * @TotalDepAmount/10000, @ConvertedDecimals)
			EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID1, @BDescription, @DepAccountID, @DebitDepAccountID3, @DepAmount, @DepPercent, @UserID, @Ana01ID3, @Ana02ID3, @Ana03ID3, @PeriodID03, @Ana04ID3, @Ana05ID3, NULL, @Ana06ID3, @MaterialTypeID03,@Ana07ID3, @Ana08ID3, @Ana09ID3, @Ana10ID3
		END 
        
		IF ISNULL(@DebitDepAccountID3, '') <>'' AND ISNULL(@SourceID2, '')<>''
		BEGIN
			SET @DepAmount = ROUND(@SourcePercent2 * @DepPercent3 * @TotalDepAmount/10000, @ConvertedDecimals)
			EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID2, @BDescription, @DepAccountID, @DebitDepAccountID3, @DepAmount, @DepPercent, @UserID, @Ana01ID3, @Ana02ID3, @Ana03ID3, @PeriodID03, @Ana04ID3, @Ana05ID3, NULL, @Ana06ID3, @MaterialTypeID03, @Ana07ID3, @Ana08ID3, @Ana09ID3, @Ana10ID3
		END 
        
		IF ISNULL(@DebitDepAccountID3, '') <>'' AND ISNULL(@SourceID3, '')<>''
		BEGIN
			SET @DepAmount = ROUND(@SourcePercent3 * @DepPercent3 * @TotalDepAmount/10000, @ConvertedDecimals)
			EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID3, @BDescription, @DepAccountID, @DebitDepAccountID3, @DepAmount, @DepPercent, @UserID, @Ana01ID3, @Ana02ID3, @Ana03ID3, @PeriodID03, @Ana04ID3, @Ana05ID3, NULL, @Ana06ID3, @MaterialTypeID03, @Ana07ID3, @Ana08ID3, @Ana09ID3, @Ana10ID3
		END 
        
		------ Phan bo sung
		IF ISNULL(@DebitDepAccountID4, '') <>'' AND ISNULL(@SourceID1, '')<>''
		BEGIN
			SET @DepAmount = ROUND(@SourcePercent1 * @DepPercent4 * @TotalDepAmount/10000, @ConvertedDecimals)
			EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID1, @BDescription, @DepAccountID, @DebitDepAccountID4, @DepAmount, @DepPercent, @UserID, @Ana01ID4, @Ana02ID4, @Ana03ID4, @PeriodID04, @Ana04ID4, @Ana05ID4, NULL, @Ana06ID4, @MaterialTypeID04, @Ana07ID4, @Ana08ID4, @Ana09ID4, @Ana10ID4
		END 

		IF ISNULL(@DebitDepAccountID4, '') <>'' AND ISNULL(@SourceID2, '')<>''
		BEGIN
			SET @DepAmount = ROUND(@SourcePercent2 * @DepPercent4 * @TotalDepAmount/10000, @ConvertedDecimals)
			EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID2, @BDescription, @DepAccountID, @DebitDepAccountID4, @DepAmount, @DepPercent, @UserID, @Ana01ID4, @Ana02ID4, @Ana03ID4, @PeriodID04, @Ana04ID4, @Ana05ID4, NULL, @Ana06ID4, @MaterialTypeID04, @Ana07ID4, @Ana08ID4, @Ana09ID4, @Ana10ID4
		END 

		IF ISNULL(@DebitDepAccountID4, '') <>'' AND ISNULL(@SourceID3, '')<>''
		BEGIN
			SET @DepAmount = ROUND(@SourcePercent3 * @DepPercent1 * @TotalDepAmount/10000, @ConvertedDecimals)
			EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID3, @BDescription, @DepAccountID, @DebitDepAccountID4, @DepAmount, @DepPercent, @UserID, @Ana01ID4, @Ana02ID4, @Ana03ID4, @PeriodID04, @Ana04ID4, @Ana05ID4, NULL, @Ana06ID4, @MaterialTypeID04, @Ana07ID4, @Ana08ID4, @Ana09ID4, @Ana10ID4
		END 
    
		IF ISNULL(@DebitDepAccountID5, '') <>'' AND ISNULL(@SourceID1, '')<>''
		BEGIN
			SET @DepAmount = ROUND(@SourcePercent1 * @DepPercent2 * @TotalDepAmount/10000, @ConvertedDecimals)
			EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID1, @BDescription, @DepAccountID, @DebitDepAccountID5, @DepAmount, @DepPercent, @UserID, @Ana01ID5, @Ana02ID5, @Ana03ID5, @PeriodID05, @Ana04ID5, @Ana05ID5, NULL, @Ana06ID5, @MaterialTypeID05, @Ana07ID5, @Ana08ID5, @Ana09ID5, @Ana10ID5
		END 

		IF ISNULL(@DebitDepAccountID5, '') <>'' AND ISNULL(@SourceID2, '')<>''
		BEGIN
			SET @DepAmount = ROUND(@SourcePercent2 * @DepPercent2 * @TotalDepAmount/10000, @ConvertedDecimals)
			EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID2, @BDescription, @DepAccountID, @DebitDepAccountID5, @DepAmount, @DepPercent, @UserID, @Ana01ID5, @Ana02ID5, @Ana03ID5, @PeriodID05, @Ana04ID5, @Ana05ID5, NULL, @Ana06ID5, @MaterialTypeID05, @Ana07ID5, @Ana08ID5, @Ana09ID5, @Ana10ID5
		END 
        
		IF ISNULL(@DebitDepAccountID5, '') <>'' AND ISNULL(@SourceID3, '')<>''
		BEGIN
			SET @DepAmount = ROUND(@SourcePercent3 * @DepPercent2 * @TotalDepAmount/10000, @ConvertedDecimals)
			EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID3, @BDescription, @DepAccountID, @DebitDepAccountID5, @DepAmount, @DepPercent, @UserID, @Ana01ID5, @Ana02ID5, @Ana03ID5, @PeriodID05, @Ana04ID5, @Ana05ID5, NULL, @Ana06ID5, @MaterialTypeID05, @Ana07ID5, @Ana08ID5, @Ana09ID5, @Ana10ID5
		END 
        
		IF ISNULL(@DebitDepAccountID6, '') <>'' AND ISNULL(@SourceID1, '')<>''
		BEGIN
			SET @DepAmount = ROUND(@SourcePercent1 * @DepPercent3 * @TotalDepAmount/10000, @ConvertedDecimals)
			EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID1, @BDescription, @DepAccountID, @DebitDepAccountID6, @DepAmount, @DepPercent, @UserID, @Ana01ID6, @Ana02ID6, @Ana03ID6, @PeriodID06, @Ana04ID6, @Ana05ID6, NULL, @Ana06ID6, @MaterialTypeID06, @Ana07ID6, @Ana08ID6, @Ana09ID6, @Ana10ID6
		END 
        
		IF ISNULL(@DebitDepAccountID6, '') <>'' AND ISNULL(@SourceID2, '')<>''
		BEGIN
			SET @DepAmount = ROUND(@SourcePercent2 * @DepPercent3 * @TotalDepAmount/10000, @ConvertedDecimals)
			EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID2, @BDescription, @DepAccountID, @DebitDepAccountID6, @DepAmount, @DepPercent, @UserID, @Ana01ID6, @Ana02ID6, @Ana03ID6, @PeriodID06, @Ana04ID6, @Ana05ID6, NULL, @Ana06ID6, @MaterialTypeID06, @Ana07ID6, @Ana08ID6, @Ana09ID6, @Ana10ID6
		END 
        
		IF ISNULL(@DebitDepAccountID6, '') <>'' AND ISNULL(@SourceID3, '')<>''
		BEGIN
			SET @DepAmount = ROUND(@SourcePercent3 * @DepPercent3 * @TotalDepAmount/10000, @ConvertedDecimals)
			EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, @SourceID3, @BDescription, @DepAccountID, @DebitDepAccountID6, @DepAmount, @DepPercent, @UserID, @Ana01ID6, @Ana02ID6, @Ana03ID6, @PeriodID06, @Ana04ID6, @Ana05ID6, NULL, @Ana06ID6, @MaterialTypeID06, @Ana07ID6, @Ana08ID6, @Ana09ID6, @Ana10ID6
		END 

		------- Xu ly so le, lam tron so
		EXEC AP1511 @DivisionID, @TranMonth, @TranYear, @AssetID, @TotalDepAmount
	END

	-- Phân bổ theo bộ hệ số
	IF @ReMainAmount > 0 AND ISNULL(@UseCofficientID, 0) = 1
	BEGIN
		-- Kỳ đầu tiên, giá trị phân bổ theo số ngày bắt đầu đưa vào sử dụng
		IF @TranMonth + @TranYear * 100 = @BeginMonth + @BeginYear * 100 AND @BeginDate IS NOT NULL AND @DepMonths = 0
		BEGIN
			SET @Days = @DayInMonth - DAY(@BeginDate) + 1
			SET @TotalDepAmount = ROUND(@TotalDepAmount * @Days / @DayInMonth , @ConvertedDecimals)
		END

		IF @ReMainAmount - @TotalDepAmount < @TotalDepAmount / 2
			SET @TotalDepAmount = ROUND(@ReMainAmount, @ConvertedDecimals)
		        
		SET @cCoefficient = CURSOR STATIC FOR
			SELECT		S.SourceID, ROUND(D.CoValue * S.SourcePercent * @TotalDepAmount / 10000, @ConvertedDecimals) AS DepAmount, D.AccountID, D.Ana01ID, D.Ana02ID, D.Ana03ID, D.Ana04ID, D.Ana05ID, D.Ana06ID, D.Ana07ID, D.Ana08ID,D.Ana09ID,D.Ana10ID, D.PeriodID
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
		FETCH NEXT FROM @cCoefficient INTO @SourceID, @DepAmount, @DebitDepAccountID, @Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, @Ana06ID,@Ana07ID,@Ana08ID,@Ana09ID,@Ana10ID, @PeriodID
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC AP1500 @DivisionID, @AssetID, @VoucherNo, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear, 
						@SourceID, @BDescription, @DepAccountID, @DebitDepAccountID, @DepAmount, @DepPercent, @UserID, 
						@Ana01ID, @Ana02ID, @Ana03ID, @PeriodID, @Ana04ID, @Ana05ID,@CoefficientID,@Ana06ID,null,@Ana07ID,@Ana08ID,@Ana09ID,@Ana10ID
			FETCH NEXT FROM @cCoefficient INTO @SourceID, @DepAmount, @DebitDepAccountID, @Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, @Ana06ID,@Ana07ID,@Ana08ID,@Ana09ID,@Ana10ID, @PeriodID
		END
	
		------- Xu ly so le, lam tron so
		EXEC AP1511 @DivisionID, @TranMonth, @TranYear, @AssetID, @TotalDepAmount
	END

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
