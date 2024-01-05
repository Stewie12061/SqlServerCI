IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP2006]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP2006]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




---- Created BY Như Hàn
---- Created date 22/12/2018
---- Purpose: Đổ nguồn lưới kế thừa công nợ kế toán
/********************************************
EXEC FNP2006 'HCM', 11, 2018, 12, 2020, '2018-02-01 00:00:00.000', '2018-02-01 00:00:00.000', 0, '', '', '', 'T02', 1, 25, 1
EXEC FNP2006 @DivisionID, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate, @IsDate, @FromObjectID, @ToObjectID,@TransactionType,  @PageNumber, @PageSize, @Mode

'********************************************/
---- Modified by .. on .. 

CREATE PROCEDURE [dbo].[FNP2006]
    @DivisionID AS NVARCHAR(50), 
    @FromMonth			INT,
	@FromYear			INT,
	@ToMonth			INT,
	@ToYear				INT,
	@FromDate			DATETIME,
	@ToDate				DATETIME,
	@IsDate				TINYINT, ----0 theo kỳ, 1 theo ngày
	@FromObjectID		VARCHAR(50),
	@ToObjectID			VARCHAR(50),
	@StrObjectID		VARCHAR(MAX),
	@TransactionType	VARCHAR(50),
	@PageNumber			INT,
	@PageSize			INT,
	@Mode				INT

AS

DECLARE @CurrencyID VARCHAR(50),
		@FromAccountID VARCHAR(50), 
		@ToAccountID VARCHAR(50),
		@TypeD TINYINT

IF @IsDate = 1 SET @TypeD = 2 ELSE SET  @TypeD = 4

IF ISNULL(@FromObjectID,'') = ''
SELECT @FromObjectID = ObjectID FROM AT1202 WITH (NOLOCK) WHERE DivisionID IN (@DivisionID,'@@@') AND Disabled = 0 ORDER BY ObjectID DESC

IF ISNULL(@ToObjectID,'') = ''
SELECT @ToObjectID = ObjectID FROM AT1202 WITH (NOLOCK) WHERE DivisionID IN (@DivisionID,'@@@') AND Disabled = 0 ORDER BY ObjectID

SELECT TOP 1 @CurrencyID = BaseCurrencyID FROM AT1101 WHERE DivisionID = @DivisionID 

IF ISNULL(@TransactionType,'') = 'T02' --- Chi tiền
BEGIN 
	SELECT TOP 1 @FromAccountID = AccountID FROM AT1005 WHERE GroupID = 'G04' ORDER BY AccountID 
	SELECT TOP 1 @ToAccountID = AccountID FROM AT1005 WHERE GroupID = 'G04' ORDER BY AccountID DESC

	EXEC AP7408 @DivisionID,@FromMonth,@FromYear,@ToMonth,@ToYear,@TypeD,@FromDate,@ToDate,@CurrencyID,@FromAccountID,@ToAccountID,@FromObjectID,@ToObjectID,@SqlFind=N'1=1',@DatabaseName=N'',@StrDivisionID=@DivisionID
	

	IF @Mode = 0 --- Tổng
	BEGIN
		SELECT 
		--CONVERT(INT, ROW_NUMBER() OVER (ORDER BY ObjectID, ObjectName)) AS RowNum, COUNT(*) OVER () AS TotalRow,
		ObjectID, ObjectName, Note, 
		ABS(SUM(OpeningConvertedAmount) - SUM(CreditConvertedAmount) + SUM (DebitConvertedAmount)) AS Camount,
		ABS(SUM(OpeningOriginalAmount) - SUM(CreditOriginalAmount) + SUM (DebitOriginalAmount)) AS Oamount,
		Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, 
		Ana01Name, Ana02Name, Ana03Name, Ana04Name, Ana05Name, Ana06Name, Ana07Name, Ana08Name, Ana09Name, Ana10Name
		INTO #AV7408_TAIC
		FROM AV7408
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) WHERE AV7408.VoucherID = AT9000.VoucherID AND AV7408.BatchID = AT9000.BatchID)
		GROUP BY 
		OpeningConvertedAmount,OpeningOriginalAmount,
		ObjectID, ObjectName, Note, 
		Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, 
		Ana01Name, Ana02Name, Ana03Name, Ana04Name, Ana05Name, Ana06Name, Ana07Name, Ana08Name, Ana09Name, Ana10Name
		ORDER BY ObjectID, ObjectName
        --OFFSET (@PageNumber-1) * @PageSize ROWS
        --FETCH NEXT @PageSize ROWS ONLY


		SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY ObjectID, ObjectName)) AS RowNum, COUNT(*) OVER () AS TotalRow,
		* FROM #AV7408_TAIC
		ORDER BY ObjectID, ObjectName
        OFFSET (@PageNumber-1) * @PageSize ROWS
        FETCH NEXT @PageSize ROWS ONLY
	END
	IF @Mode = 1 --- Detail
	BEGIN
		SELECT 
		CONVERT(INT, ROW_NUMBER() OVER (ORDER BY ObjectID, ObjectName)) AS RowNum, COUNT(*) OVER () AS TotalRow,
		VoucherID, BatchID, ObjectID, ObjectName, Note, 
		ABS(OpeningConvertedAmount - (CreditConvertedAmount) + (DebitConvertedAmount)) AS Camount,
		ABS(OpeningOriginalAmount - (CreditOriginalAmount) + (DebitOriginalAmount)) AS Oamount,
		Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, 
		Ana01Name, Ana02Name, Ana03Name, Ana04Name, Ana05Name, Ana06Name, Ana07Name, Ana08Name, Ana09Name, Ana10Name
		FROM AV7408
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) WHERE AV7408.VoucherID = AT9000.VoucherID AND AV7408.BatchID = AT9000.BatchID)
		AND ObjectID IN (@StrObjectID)
		ORDER BY ObjectID, ObjectName
		OFFSET (@PageNumber-1) * @PageSize ROWS
        FETCH NEXT @PageSize ROWS ONLY

	END

END

IF ISNULL(@TransactionType,'') = 'T01' --- Thu Tiền
BEGIN
	SELECT TOP 1 @FromAccountID = AccountID FROM AT1005 WHERE GroupID = 'G03' ORDER BY AccountID 
	
	SELECT TOP 1 @ToAccountID = AccountID FROM AT1005 WHERE GroupID = 'G03' ORDER BY AccountID DESC

	EXEC AP7405 @DivisionID,@FromMonth,@FromYear,@ToMonth,@ToYear,@TypeD,@FromDate,@ToDate,@CurrencyID,@FromAccountID,@ToAccountID,@FromObjectID,@ToObjectID,@SqlFind=N'1=1',@DatabaseName=N'',@StrDivisionID=@DivisionID
	IF @Mode = 0 --- Tổng
	BEGIN
		SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY ObjectID, ObjectName)) AS RowNum, COUNT(*) OVER () AS TotalRow,
		ObjectID, ObjectName, Note, 
		ABS(OpeningConvertedAmount + SUM(DebitConvertedAmount) - SUM (CreditConvertedAmount)) AS Camount,
		ABS(OpeningOriginalAmount - SUM(DebitOriginalAmount) + SUM (CreditOriginalAmount)) AS Oamount,
		Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, 
		Ana01Name, Ana02Name, Ana03Name, Ana04Name, Ana05Name, Ana06Name, Ana07Name, Ana08Name, Ana09Name, Ana10Name
		FROM AV7405
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) WHERE AV7405.VoucherID = AT9000.VoucherID AND AV7405.BatchID = AT9000.BatchID)
		GROUP BY 
		OpeningConvertedAmount,OpeningOriginalAmount,
		ObjectID, ObjectName, Note, 
		Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, 
		Ana01Name, Ana02Name, Ana03Name, Ana04Name, Ana05Name, Ana06Name, Ana07Name, Ana08Name, Ana09Name, Ana10Name
		ORDER BY ObjectID, ObjectName
        OFFSET (@PageNumber-1) * @PageSize ROWS
        FETCH NEXT @PageSize ROWS ONLY
	END
	IF @Mode = 1 --- Detail
	BEGIN
		SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY ObjectID, ObjectName)) AS RowNum, COUNT(*) OVER () AS TotalRow,
		VoucherID, BatchID, ObjectID, ObjectName, Note, 
		ABS(OpeningConvertedAmount + (DebitConvertedAmount) - (CreditConvertedAmount)) AS Camount,
		ABS(OpeningOriginalAmount - (DebitOriginalAmount) + (CreditOriginalAmount)) AS Oamount,
		Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, 
		Ana01Name, Ana02Name, Ana03Name, Ana04Name, Ana05Name, Ana06Name, Ana07Name, Ana08Name, Ana09Name, Ana10Name
		FROM AV7405
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) WHERE AV7405.VoucherID = AT9000.VoucherID AND AV7405.BatchID = AT9000.BatchID)
		AND ObjectID IN (@StrObjectID)
		ORDER BY ObjectID, ObjectName
        OFFSET (@PageNumber-1) * @PageSize ROWS
        FETCH NEXT @PageSize ROWS ONLY
	END

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
