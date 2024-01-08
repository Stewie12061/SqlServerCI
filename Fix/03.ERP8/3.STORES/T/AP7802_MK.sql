IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP7802_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7802_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Kết chuyển cuối kỳ: Customize Meiko (kết chuyển chi tiết theo mã pT)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Gọi từ SP AP7801
-- <History>
------- Created By Phương Thảo on 29/04/2016
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified on 12/05/2017 by Tiểu Mai: Bổ sung chỉnh sửa danh mục dùng chung
---- Modified on 12/05/2017 by Tiểu Mai: Merge Code: MEKIO và MTE
-- <Example>
---- 

CREATE PROCEDURE [dbo].[AP7802_MK]
(
       @AllocationID nvarchar(50) ,
       @DivisionID nvarchar(50) ,
       @TranMonth AS int ,
       @TranYear AS int ,
       @VoucherTypeID AS nvarchar(50) ,
       @VoucherNo AS nvarchar(50) ,
       @VoucherDate datetime ,
       @VDescription AS nvarchar(250) ,
       @BDescription AS nvarchar(250) ,
       @TDescription AS nvarchar(250) ,
       @SourceAccountIDFrom AS nvarchar(50) ,
       @SourceAccountIDTo AS nvarchar(50) ,
       @TargetAccountID AS nvarchar(50) ,
       @SourceAmountID AS tinyint ,
       @AllocationMode AS tinyint ,
       @Percentage AS decimal(28,8) ,
       @SequenceDesc AS nvarchar(100) ,
       @CreateUserID AS nvarchar(50) ,
       @LastModifyUserID AS nvarchar(50) ,
       @Ana01ID AS nvarchar(50) ,
       @Ana02ID AS nvarchar(50) ,
       @Ana03ID AS nvarchar(50) ,
       @Ana04ID AS nvarchar(50) ,
       @Ana05ID AS nvarchar(50) ,
       @Ana06ID AS nvarchar(50) ,
       @Ana07ID AS nvarchar(50) ,
       @Ana08ID AS nvarchar(50) ,
       @Ana09ID AS nvarchar(50) ,
       @Ana10ID AS nvarchar(50) ,
       @DetailForObject AS tinyint = 0 ,
       @FilterObjectID AS nvarchar(4000),
       @AnaTypeID AS NVARCHAR(50) = '',
       @FromAnaID AS NVARCHAR(50) = '',
       @ToAnaID AS NVARCHAR(50) = '',
       @VGAna01ID NVARCHAR(50)= '',
       @VGAna01Where NVARCHAR(100) =''
)       
AS
SET NOCOUNT ON
--IF ISNULL(@Ana01ID,'') <> '' BEGIN SET @VGAna01ID = ', Ana01ID' SET @VGAna01Where = 'AND ISNULL(Ana01ID,'''') = '''+@Ana01ID+'''' END
DECLARE
        @TranPeriodFrom AS int ,
        @TranPeriodTo AS int ,
        @IsTransferGeneral AS TINYINT,
        @sSQL AS nvarchar(4000)

DECLARE	@ConvertedDecimals AS INT
--If ISNULL(@AnaTypeID,'')=''		
--Set @AnaTypeID = (Case when ISNULL(@Ana10ID,'')<>'' then 'A10' else 
--				(Case when ISNULL(@Ana09ID,'')<>'' then 'A09' else 
--				(Case when ISNULL(@Ana08ID,'')<>'' then 'A08' else
--				(Case when ISNULL(@Ana07ID,'')<>'' then 'A07' else
--				(Case when ISNULL(@Ana06ID,'')<>'' then 'A06' else
--				(Case when ISNULL(@Ana05ID,'')<>'' then 'A05' else
--				(Case when ISNULL(@Ana04ID,'')<>'' then 'A04' else
--				(Case when ISNULL(@Ana03ID,'')<>'' then 'A03' else
--				(Case when ISNULL(@Ana02ID,'')<>'' then 'A02' else
--				(Case when ISNULL(@Ana01ID,'')<>'' then 'A07' else '' end)end)end)end)end)end)end)end)end)end)
--If ISNULL(@FromAnaID,'')=''		
--Set @FromAnaID = (Case when ISNULL(@Ana10ID,'')<>'' then @Ana10ID else 
--				(Case when ISNULL(@Ana09ID,'')<>'' then @Ana09ID else 
--				(Case when ISNULL(@Ana08ID,'')<>'' then @Ana08ID else
--				(Case when ISNULL(@Ana07ID,'')<>'' then @Ana07ID else
--				(Case when ISNULL(@Ana06ID,'')<>'' then @Ana06ID else
--				(Case when ISNULL(@Ana05ID,'')<>'' then @Ana05ID else
--				(Case when ISNULL(@Ana04ID,'')<>'' then @Ana04ID else
--				(Case when ISNULL(@Ana03ID,'')<>'' then @Ana03ID else
--				(Case when ISNULL(@Ana02ID,'')<>'' then @Ana02ID else
--				(Case when ISNULL(@Ana01ID,'')<>'' then @Ana01ID else '' end)end)end)end)end)end)end)end)end)end)
--If ISNULL(@ToAnaID,'')=''							
--Set @ToAnaID = (Case when ISNULL(@Ana10ID,'')<>'' then @Ana10ID else 
--				(Case when ISNULL(@Ana09ID,'')<>'' then @Ana09ID else 
--				(Case when ISNULL(@Ana08ID,'')<>'' then @Ana08ID else
--				(Case when ISNULL(@Ana07ID,'')<>'' then @Ana07ID else
--				(Case when ISNULL(@Ana06ID,'')<>'' then @Ana06ID else
--				(Case when ISNULL(@Ana05ID,'')<>'' then @Ana05ID else
--				(Case when ISNULL(@Ana04ID,'')<>'' then @Ana04ID else
--				(Case when ISNULL(@Ana03ID,'')<>'' then @Ana03ID else
--				(Case when ISNULL(@Ana02ID,'')<>'' then @Ana02ID else
--				(Case when ISNULL(@Ana01ID,'')<>'' then @Ana01ID else '' end)end)end)end)end)end)end)end)end)end)			
SET @ConvertedDecimals = ISNULL((SELECT TOP 1 ConvertedDecimals FROM AV1004 WHERE DivisionID IN ( @DivisionID,'@@@')), 0)
SET @IsTransferGeneral = (SELECT TOP 1 IsTransferGeneral FROM AT7801 WITH (NOLOCK) WHERE AllocationID = @AllocationID AND DivisionID = @DivisionID)

IF @AllocationMode = 0   ----- Lay so trong ky 
BEGIN
     SET @TranPeriodFrom = @TranYear * 12 + @TranMonth
     SET @TranPeriodTo = @TranYear * 12 + @TranMonth
END
ELSE
BEGIN
     IF @AllocationMode = 1 --- Lay so trong Nam
        BEGIN
              SET @TranPeriodFrom = @TranYear * 12 + 1
              SET @TranPeriodTo = @TranYear * 12 + @TranMonth
        END
END

IF @AllocationMode = 2  --- Lay so du
BEGIN
     SET @TranPeriodFrom = 0
     SET @TranPeriodTo = @TranYear * 12 + @TranMonth
END

IF @AllocationMode = 3 -- Phat sinh trong ky
BEGIN
   SET @TranPeriodFrom = @TranYear * 12 + @TranMonth
   SET @TranPeriodTo = @TranYear * 12 + @TranMonth
END
DECLARE
        @D90T0002Cursor AS cursor ,
        @AccountID AS nvarchar(50) ,
        @VoucherID AS nvarchar(50) ,
        @DebitAccountID AS nvarchar(50) ,
        @CreditAccountID AS nvarchar(50) ,
        @ConvertedAmount AS decimal(28,8) ,
        @ObjectID AS nvarchar(50),
		@cAna01ID AS nvarchar(50),
		@cAna02ID AS nvarchar(50),
		@cAna03ID AS nvarchar(50),
		@cAna04ID AS nvarchar(50),
		@cAna05ID AS nvarchar(50),
		@cAna06ID AS nvarchar(50),
		@cAna07ID AS nvarchar(50),
		@cAna08ID AS nvarchar(50),
		@cAna09ID AS nvarchar(50),
		@cAna10ID AS nvarchar(50)



IF @DetailForObject = 0
BEGIN	
	SET @sSQL = N'
	SELECT	AccountID, ISNULL(Ana01ID,'''') AS Ana01ID, ISNULL(Ana02ID,'''') AS Ana02ID, ISNULL(Ana03ID,'''') AS Ana03ID, ISNULL(Ana04ID,'''') AS Ana04ID, 
			ISNULL(Ana05ID,'''') AS Ana05ID, ISNULL(Ana06ID,'''') AS Ana06ID, ISNULL(Ana07ID,'''') AS Ana07ID, 
			ISNULL(Ana08ID,'''') AS Ana08ID, ISNULL(Ana09ID,'''') AS Ana09ID, ISNULL(Ana10ID,'''') AS Ana10ID, SUM(SignAmount) AS ConvertedAmount	
	FROM	AV4300
	WHERE    AccountID >= '''+@SourceAccountIDFrom +'''
		AND AccountID <= '''+@SourceAccountIDTo +'''
		AND ( TranYear * 12 + TranMonth ) >= '''+STR(@TranPeriodFrom) +'''
		AND ( TranYear * 12 + TranMonth ) <= '''+STR(@TranPeriodTo) +'''
		AND DivisionID = '''+@DivisionID+'''  AND ISNULL(RefVoucherNo,'''') <> ''T99''
	   '+ CASE WHEN ISNULL(@Ana01ID,'') <> '' THEN ' AND Ana01ID = '''+@Ana01ID+''''  ELSE '' END
		+ CASE WHEN ISNULL(@Ana02ID,'') <> '' THEN ' AND Ana02ID = '''+@Ana02ID+''''  ELSE '' END
		+ CASE WHEN ISNULL(@Ana03ID,'') <> '' THEN ' AND Ana03ID = '''+@Ana03ID+''''  ELSE '' END
		+ CASE WHEN ISNULL(@Ana04ID,'') <> '' THEN ' AND Ana04ID = '''+@Ana04ID+''''  ELSE '' END
		+ CASE WHEN ISNULL(@Ana05ID,'') <> '' THEN ' AND Ana05ID = '''+@Ana05ID+''''  ELSE '' END
		+ CASE WHEN ISNULL(@Ana06ID,'') <> '' THEN ' AND Ana06ID = '''+@Ana06ID+''''  ELSE '' END
		+ CASE WHEN ISNULL(@Ana07ID,'') <> '' THEN ' AND Ana07ID = '''+@Ana07ID+''''  ELSE '' END
		+ CASE WHEN ISNULL(@Ana08ID,'') <> '' THEN ' AND Ana08ID = '''+@Ana08ID+''''  ELSE '' END
		+ CASE WHEN ISNULL(@Ana09ID,'') <> '' THEN ' AND Ana09ID = '''+@Ana09ID+''''  ELSE '' END
		+ CASE WHEN ISNULL(@Ana10ID,'') <> '' THEN ' AND Ana10ID = '''+@Ana10ID+''''  ELSE '' END
		+ CASE WHEN @AllocationMode = 3 THEN CASE WHEN @SourceAmountID = 0 THEN ' AND D_C = ''D''' ELSE ' AND D_C = ''C''' END
		   ELSE '' END + '
	GROUP BY  AccountID, ISNULL(Ana01ID,''''), ISNULL(Ana02ID,''''), ISNULL(Ana03ID,''''), ISNULL(Ana04ID,''''),
			ISNULL(Ana05ID,''''), ISNULL(Ana06ID,''''), ISNULL(Ana07ID,''''), 
			ISNULL(Ana08ID,''''), ISNULL(Ana09ID,''''), ISNULL(Ana10ID,'''')
        '

	IF EXISTS (SELECT id FROM SysObjects WITH (NOLOCK) WHERE id = Object_id('AV4310_MK') AND xType = 'V')
			DROP VIEW AV4310_MK

		EXEC ( 'CREATE VIEW AV4310_MK -- Create by AP7802_MK
		AS '+@sSQL )

	SET @D90T0002Cursor = CURSOR SCROLL KEYSET FOR 
		SELECT AccountID , ConvertedAmount, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID
		FROM   AV4310_MK
	OPEN @D90T0002Cursor
	FETCH NEXT FROM @D90T0002Cursor INTO @AccountID,@ConvertedAmount, @cAna01ID, @cAna02ID, @cAna03ID, @cAna04ID,
										 @cAna05ID, @cAna06ID, @cAna07ID, @cAna08ID, @cAna09ID, @cAna10ID
	WHILE @@FETCH_STATUS = 0
	BEGIN
	---Print '@AllocationMode ='+str(@AllocationMode)		
		IF @SourceAmountID = 0   ---- Neu la lay do du No thi phai ket chuyen vao tai khoan Co (tai khoan dich)
		BEGIN
			SET @DebitAccountID = @TargetAccountID
			SET @CreditAccountID = @AccountID
		END
		ELSE
		BEGIN
			IF @SourceAmountID = 1  ---- Neu la lay so du co thi phai ket chuyen vao tai khoan No
			BEGIN
				SET @CreditAccountID = @TargetAccountID
				SET @DebitAccountID = @AccountID
				SET @ConvertedAmount = @ConvertedAmount * -1
			END
			ELSE
			BEGIN
				IF @SourceAmountID = 2  ---- Tr­êng hîp lÊy sè lín h¬n
				BEGIN
					IF @ConvertedAmount >= 0  --- Bªn Nî lín h¬n bªn Cã
					BEGIN
						SET @CreditAccountID = @AccountID
						SET @DebitAccountID = @TargetAccountID
					END
					ELSE
					BEGIN		---- Bªn Cã lín h¬n bªn Nî
						SET @CreditAccountID = @TargetAccountID
						SET @DebitAccountID = @AccountID
						SET @ConvertedAmount = @ConvertedAmount * -1
					END
				END
			END
		END
		IF @ConvertedAmount <> 0
		BEGIN
			SET @ConvertedAmount = ROUND(@ConvertedAmount * @Percentage / 100, @ConvertedDecimals)
			BEGIN
				EXEC AP0000 @DivisionID, @VoucherID OUTPUT , 'AT9000' , 'AV' , @TranYear , '' , 15 , 3 , 0 , '-'
	--   Print ' @DebitAccountID,@CreditAccountID'+@DebitAccountID+' :' +@CreditAccountID
				EXEC AP7809 @DivisionID , @TranMonth , @TranYear , @VoucherID , @VoucherTypeID , @VoucherNo , @VoucherDate , @VDescription , @BDescription , @TDescription , @DebitAccountID , @CreditAccountID , @ConvertedAmount , @CreateUserID , @LastModifyUserID , @cAna01ID , @cAna02ID , @cAna03ID , @cAna04ID , @cAna05ID , @cAna06ID , @cAna07ID , @cAna08ID , @cAna09ID , @cAna10ID , @ObjectID, @IsTransferGeneral
			END
		END
		FETCH NEXT FROM @D90T0002Cursor INTO @AccountID, @ConvertedAmount, @cAna01ID, @cAna02ID, @cAna03ID, @cAna04ID,
										 @cAna05ID, @cAna06ID, @cAna07ID, @cAna08ID, @cAna09ID, @cAna10ID
	END
	CLOSE @D90T0002Cursor
	DEALLOCATE @D90T0002Cursor
END
ELSE
BEGIN
	SET @sSQL = '
	SELECT	AV4300.DivisionID, ISNULL(Ana01ID,'''') AS Ana01ID, ISNULL(Ana02ID,'''') AS Ana02ID, ISNULL(Ana03ID,'''') AS Ana03ID, ISNULL(Ana04ID,'''') AS Ana04ID, 
			ISNULL(Ana05ID,'''') AS Ana05ID, ISNULL(Ana06ID,'''') AS Ana06ID, ISNULL(Ana07ID,'''') AS Ana07ID, 
			ISNULL(Ana08ID,'''') AS Ana08ID, ISNULL(Ana09ID,'''') AS Ana09ID, ISNULL(Ana10ID,'''') AS Ana10ID,
			AccountID, ObjectID,	sum(SignAmount) as ConvertedAmount
	FROM 	AV4300
	WHERE	AccountID >= ''' + @SourceAccountIDFrom + '''
		AND AccountID <= ''' + @SourceAccountIDTo + '''
		AND (TranYear * 12 + TranMonth) >= '+ltrim(@TranPeriodFrom)+'
		AND (TranYear * 12 + TranMonth) <= '+ltrim(@TranPeriodTo)+'
		AND	DivisionID = '''+@DivisionID+''' 
		'+CASE WHEN @FilterObjectID = '' OR @FilterObjectID IS NULL THEN ''
			   ELSE ' AND ObjectID In (Select ObjectID From AT1202 Where ' + @FilterObjectID + ') ' END + ' 
		'+ CASE WHEN ISNULL(@Ana01ID,'') <> '' THEN ' AND Ana01ID = '''+@Ana01ID+''''  ELSE '' END
		+ CASE WHEN ISNULL(@Ana02ID,'') <> '' THEN  ' AND Ana02ID = '''+@Ana02ID+''''  ELSE '' END
		+ CASE WHEN ISNULL(@Ana03ID,'') <> '' THEN  ' AND Ana03ID = '''+@Ana03ID+''''  ELSE '' END
		+ CASE WHEN ISNULL(@Ana04ID,'') <> '' THEN  ' AND Ana04ID = '''+@Ana04ID+''''  ELSE '' END
		+ CASE WHEN ISNULL(@Ana05ID,'') <> '' THEN  ' AND Ana05ID = '''+@Ana05ID+''''  ELSE '' END
		+ CASE WHEN ISNULL(@Ana06ID,'') <> '' THEN  ' AND Ana06ID = '''+@Ana06ID+''''  ELSE '' END
		+ CASE WHEN ISNULL(@Ana07ID,'') <> '' THEN  ' AND Ana07ID = '''+@Ana07ID+''''  ELSE '' END
		+ CASE WHEN ISNULL(@Ana08ID,'') <> '' THEN  ' AND Ana08ID = '''+@Ana08ID+''''  ELSE '' END
		+ CASE WHEN ISNULL(@Ana09ID,'') <> '' THEN  ' AND Ana09ID = '''+@Ana09ID+''''  ELSE '' END
		+ CASE WHEN ISNULL(@Ana10ID,'') <> '' THEN  ' AND Ana10ID = '''+@Ana10ID+''''  ELSE '' END+'

	GROUP BY AV4300.DivisionID,AccountID,ObjectID, ISNULL(Ana01ID,''''), ISNULL(Ana02ID,''''), ISNULL(Ana03ID,''''), ISNULL(Ana04ID,''''),
			ISNULL(Ana05ID,''''), ISNULL(Ana06ID,''''), ISNULL(Ana07ID,''''), 
			ISNULL(Ana08ID,''''), ISNULL(Ana09ID,''''), ISNULL(Ana10ID,'''')'

		IF EXISTS ( SELECT id FROM SysObjects WITH (NOLOCK) WHERE id = Object_id('AV4309_MK') AND xType = 'V' )
			DROP VIEW AV4309_MK
		
		EXEC ( 'CREATE VIEW AV4309_MK -- Create by AP7802_MK
		AS '+@sSQL )

		
	SET @D90T0002Cursor = CURSOR SCROLL KEYSET FOR 
	SELECT AccountID , ObjectID , ConvertedAmount, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID
	FROM   AV4309_MK
	
	OPEN @D90T0002Cursor
	FETCH NEXT FROM @D90T0002Cursor INTO @AccountID, @ObjectID, @ConvertedAmount, @cAna01ID, @cAna02ID, @cAna03ID, @cAna04ID,
										 @cAna05ID, @cAna06ID, @cAna07ID, @cAna08ID, @cAna09ID, @cAna10ID
	IF @@FETCH_STATUS = 0
	BEGIN
		EXEC AP0000 @DivisionID, @VoucherID OUTPUT , 'AT9000' , 'AV' , @TranYear , '' , 15 , 3 , 0 , '-'
	END
    WHILE @@FETCH_STATUS = 0
	BEGIN	
	---Print '@AllocationMode ='+str(@AllocationMode)		
		IF @SourceAmountID = 0   ---- Neu la lay do du No thi phai ket chuyen vao tai khoan Co (tai khoan dich)
		BEGIN
			SET @DebitAccountID = @TargetAccountID
			SET @CreditAccountID = @AccountID
		END
		ELSE
		BEGIN
			IF @SourceAmountID = 1  ---- Neu la lay so du co thi phai ket chuyen vao tai khoan No
			BEGIN
				SET @CreditAccountID = @TargetAccountID
				SET @DebitAccountID = @AccountID
				SET @ConvertedAmount = @ConvertedAmount * -1
			END
			ELSE
            BEGIN
                IF @SourceAmountID = 2  ---- Tr­êng hîp lÊy sè lín h¬n
                BEGIN
                    IF @ConvertedAmount >= 0  --- Bªn Nî lín h¬n bªn Cã
                    BEGIN
                            SET @CreditAccountID = @AccountID
                            SET @DebitAccountID = @TargetAccountID
                    END
                    ELSE
                    BEGIN		---- Bªn Cã lín h¬n bªn Nî
                            SET @CreditAccountID = @TargetAccountID
                            SET @DebitAccountID = @AccountID
                            SET @ConvertedAmount = @ConvertedAmount * -1
                    END
                END
            END
		END


        IF @ConvertedAmount <> 0
            BEGIN
                SET @ConvertedAmount = @ConvertedAmount * @Percentage / 100					
				-- Print ' @DebitAccountID,@CreditAccountID'+@DebitAccountID+' :' +@CreditAccountID
					 EXEC AP7809 @DivisionID, @TranMonth, @TranYear, @VoucherID, @VoucherTypeID, @VoucherNo, @VoucherDate,
					 @VDescription, @BDescription, @TDescription, @DebitAccountID, @CreditAccountID, @ConvertedAmount,
					 @CreateUserID, @LastModifyUserID, @cAna01ID, @cAna02ID, @cAna03ID, @cAna04ID,
					 @cAna05ID, @cAna06ID, @cAna07ID, @cAna08ID, @cAna09ID, @cAna10ID, @ObjectID, @IsTransferGeneral
            END
        FETCH NEXT FROM @D90T0002Cursor INTO @AccountID, @ObjectID, @ConvertedAmount, @cAna01ID, @cAna02ID, @cAna03ID, @cAna04ID,
										 @cAna05ID, @cAna06ID, @cAna07ID, @cAna08ID, @cAna09ID, @cAna10ID

	END
	CLOSE @D90T0002Cursor
	DEALLOCATE @D90T0002Cursor
END


--PRINT (@sSQL)
SET NOCOUNT OFF


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

