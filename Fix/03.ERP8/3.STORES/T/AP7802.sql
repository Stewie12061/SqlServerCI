IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP7802]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7802]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Chay but toan phan bo.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
------- Created By Nguyen Van Nhan.
------ Date 20.08.2003.
---------- Edit by: Dang Le Bao Quynh; Date: 18/06/2007 
---------- Purpose: Bo sung cap nhat ma phan tich
------- Edit By: Dang Le Bao Quynh; Date 11/01/2008
------- Purpose: Bo sung ket chuyen chi tiet theo doi tuong
---- Modified on 19/11/2011 by Le Thi Thu Hien : Bo sung check @IsTransferGeneral
---- Modified on 24/11/2011 by Le Thi Thu Hien : Bo sung Loc theo khoan muc
---- Modified on 15/02/2012 by Nguyễn Bình Minh : Sửa format đúng số lẻ
---- Modified on 11/04/2012 by Nguyễn Bình Minh : Sửa lỗi lấy format số lẻ không lấy top 1 -> báo lỗi
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 07/12/2016: Fix bug kết chuyển chi phí theo tỷ lệ chưa đúng
---- Modified by Phương Thảo on 22/02/2017: Fix lỗi kết chuyển sai
---- Modified on 12/05/2017 by Tiểu Mai: Bổ sung chỉnh sửa danh mục dùng chung
-- <Example>
---- 

CREATE PROCEDURE [dbo].[AP7802]
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
IF ISNULL(@Ana01ID,'') <> '' BEGIN SET @VGAna01ID = ', Ana01ID' SET @VGAna01Where = 'AND ISNULL(Ana01ID,'''') = '''+@Ana01ID+'''' END
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
SET @ConvertedDecimals = ISNULL((SELECT TOP 1 ConvertedDecimals FROM AV1004 WHERE DivisionID IN( @DivisionID,'@@@')), 0)
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
        @ObjectID AS nvarchar(50)

IF @AllocationID <> 'KC_CHOAN01'
BEGIN
	IF @DetailForObject = 0
	BEGIN
		SET @sSQL = N'
SELECT	AccountID '+@VGAna01ID+', SUM(SignAmount) AS ConvertedAmount
FROM	AV4300
WHERE   AccountID >= '''+@SourceAccountIDFrom +'''
	AND AccountID <= '''+@SourceAccountIDTo +'''
	AND ( TranYear * 12 + TranMonth ) >= '''+STR(@TranPeriodFrom) +'''
	AND ( TranYear * 12 + TranMonth ) <= '''+STR(@TranPeriodTo) +'''
	-- Rem lai, chi sua cho Angel, vi Angel thiet lap cung ma TK nguon nhung khong nhap ma phan tich trong cung 1 ma KC
	-- AND Isnull(VoucherNo,'''') <> '''+@VoucherNo+''' 
	'+@VGAna01Where+'
	AND DivisionID = '''+@DivisionID+''' AND ISNULL(RefVoucherNo,'''') <> ''T99'''
	+ CASE WHEN @AnaTypeID = 'A01' THEN 'AND AV4300.Ana01ID >= '''+@FromAnaID+''' AND AV4300.Ana01ID <= '''+@ToAnaID+''''
		   WHEN @AnaTypeID = 'A02' THEN 'AND AV4300.Ana02ID >= '''+@FromAnaID+''' AND AV4300.Ana02ID <= '''+@ToAnaID+''''
		   WHEN @AnaTypeID = 'A03' THEN 'AND AV4300.Ana03ID >= '''+@FromAnaID+''' AND AV4300.Ana03ID <= '''+@ToAnaID+''''
		   WHEN @AnaTypeID = 'A04' THEN 'AND AV4300.Ana04ID >= '''+@FromAnaID+''' AND AV4300.Ana04ID <= '''+@ToAnaID+''''
		   WHEN @AnaTypeID = 'A05' THEN 'AND AV4300.Ana05ID >= '''+@FromAnaID+''' AND AV4300.Ana05ID <= '''+@ToAnaID+''''
		   WHEN @AnaTypeID = 'A06' THEN 'AND AV4300.Ana06ID >= '''+@FromAnaID+''' AND AV4300.Ana06ID <= '''+@ToAnaID+''''
		   WHEN @AnaTypeID = 'A07' THEN 'AND AV4300.Ana07ID >= '''+@FromAnaID+''' AND AV4300.Ana07ID <= '''+@ToAnaID+''''
		   WHEN @AnaTypeID = 'A08' THEN 'AND AV4300.Ana08ID >= '''+@FromAnaID+''' AND AV4300.Ana08ID <= '''+@ToAnaID+''''
		   WHEN @AnaTypeID = 'A09' THEN 'AND AV4300.Ana09ID >= '''+@FromAnaID+''' AND AV4300.Ana09ID <= '''+@ToAnaID+''''
		   WHEN @AnaTypeID = 'A10' THEN 'AND AV4300.Ana10ID >= '''+@FromAnaID+''' AND AV4300.Ana10ID <= '''+@ToAnaID+''''
		   ELSE '' END 
	+ CASE WHEN @AllocationMode = 3 THEN CASE WHEN @SourceAmountID = 0 THEN ' AND D_C = ''D''' ELSE ' AND D_C = ''C''' END
		   ELSE '' END + '
GROUP BY  AccountID'+@VGAna01ID+''
            		
		IF EXISTS (SELECT id FROM SysObjects WITH (NOLOCK) WHERE id = Object_id('AV4310') AND xType = 'V')
			DROP VIEW AV4310

		EXEC ( 'CREATE VIEW AV4310 -- Create by AP7802
		AS '+@sSQL )

		SET @D90T0002Cursor = CURSOR SCROLL KEYSET FOR 
			SELECT AccountID , ConvertedAmount
			FROM   AV4310
		OPEN @D90T0002Cursor
		FETCH NEXT FROM @D90T0002Cursor INTO @AccountID,@ConvertedAmount
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
					EXEC AP7809 @DivisionID , @TranMonth , @TranYear , @VoucherID , @VoucherTypeID , @VoucherNo , @VoucherDate , @VDescription , @BDescription , @TDescription , @DebitAccountID , @CreditAccountID , @ConvertedAmount , @CreateUserID , @LastModifyUserID , @Ana01ID , @Ana02ID , @Ana03ID , @Ana04ID , @Ana05ID , @Ana06ID , @Ana07ID , @Ana08ID , @Ana09ID , @Ana10ID , @ObjectID, @IsTransferGeneral
				END
			END
			FETCH NEXT FROM @D90T0002Cursor INTO @AccountID, @ConvertedAmount
		END
		CLOSE @D90T0002Cursor
		DEALLOCATE @D90T0002Cursor
END
ELSE
BEGIN
	SET @sSQL = '
SELECT	AV4300.DivisionID, AccountID, ObjectID,	sum(SignAmount) as ConvertedAmount
FROM 	AV4300
WHERE	AccountID >= ''' + @SourceAccountIDFrom + '''
	AND AccountID <= ''' + @SourceAccountIDTo + '''
	AND (TranYear * 12 + TranMonth) >= '+ltrim(@TranPeriodFrom)+'
	AND (TranYear * 12 + TranMonth) <= '+ltrim(@TranPeriodTo)+'
	AND	DivisionID = '''+@DivisionID+''' 
	'+CASE WHEN @FilterObjectID = '' OR @FilterObjectID IS NULL THEN ''
		   ELSE ' AND ObjectID In (Select ObjectID From AT1202 Where ' + @FilterObjectID + ') ' END + ' 
	'+CASE WHEN @AnaTypeID = 'A01' THEN 'AND AV4300.Ana01ID >= '''+@FromAnaID+''' AND AV4300.Ana01ID <= '''+@ToAnaID+''''
		   WHEN @AnaTypeID = 'A02' THEN 'AND AV4300.Ana02ID >= '''+@FromAnaID+''' AND AV4300.Ana02ID <= '''+@ToAnaID+''''
		   WHEN @AnaTypeID = 'A03' THEN 'AND AV4300.Ana03ID >= '''+@FromAnaID+''' AND AV4300.Ana03ID <= '''+@ToAnaID+''''
		   WHEN @AnaTypeID = 'A04' THEN 'AND AV4300.Ana04ID >= '''+@FromAnaID+''' AND AV4300.Ana04ID <= '''+@ToAnaID+''''
		   WHEN @AnaTypeID = 'A05' THEN 'AND AV4300.Ana05ID >= '''+@FromAnaID+''' AND AV4300.Ana05ID <= '''+@ToAnaID+''''
		   WHEN @AnaTypeID = 'A06' THEN 'AND AV4300.Ana06ID >= '''+@FromAnaID+''' AND AV4300.Ana06ID <= '''+@ToAnaID+''''
		   WHEN @AnaTypeID = 'A07' THEN 'AND AV4300.Ana07ID >= '''+@FromAnaID+''' AND AV4300.Ana07ID <= '''+@ToAnaID+''''
		   WHEN @AnaTypeID = 'A08' THEN 'AND AV4300.Ana08ID >= '''+@FromAnaID+''' AND AV4300.Ana08ID <= '''+@ToAnaID+''''
		   WHEN @AnaTypeID = 'A09' THEN 'AND AV4300.Ana09ID >= '''+@FromAnaID+''' AND AV4300.Ana09ID <= '''+@ToAnaID+''''
		   WHEN @AnaTypeID = 'A10' THEN 'AND AV4300.Ana10ID >= '''+@FromAnaID+''' AND AV4300.Ana10ID <= '''+@ToAnaID+''''
		   ELSE '' END + '
GROUP BY AV4300.DivisionID,AccountID,ObjectID'
	IF EXISTS ( SELECT id FROM SysObjects WITH (NOLOCK) WHERE id = Object_id('AV4309') AND xType = 'V' )
		DROP VIEW AV4309
		
	EXEC ( 'CREATE VIEW AV4309 -- Create by AP7802
	AS '+@sSQL )

	SET @D90T0002Cursor = CURSOR SCROLL KEYSET FOR 
	SELECT AccountID , ObjectID , ConvertedAmount
	FROM   AV4309
	
	OPEN @D90T0002Cursor
	FETCH NEXT FROM @D90T0002Cursor INTO @AccountID, @ObjectID, @ConvertedAmount
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
					 @CreateUserID, @LastModifyUserID, @Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, @Ana06ID,
					 @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID, @ObjectID, @IsTransferGeneral
            END
        FETCH NEXT FROM @D90T0002Cursor INTO @AccountID, @ObjectID, @ConvertedAmount

	END
	CLOSE @D90T0002Cursor
	DEALLOCATE @D90T0002Cursor
END
   END  
ELSE   --------------- ================================================ Viet rieng cho cong ty chung khoan - Ket chuyen theo BatchID ------------------------------------------------------------------
   BEGIN
		SET @D90T0002Cursor = CURSOR SCROLL KEYSET FOR
		SELECT AccountID, VoucherID, SUM(SignAmount) ConvertedAmount
        FROM AV4300
        WHERE AccountID >= @SourceAccountIDFrom 
			AND AccountID <= @SourceAccountIDTo
			AND ( TranYear * 12 + TranMonth ) >= @TranPeriodFrom
			AND ( TranYear * 12 + TranMonth ) <= @TranPeriodTo
			AND DivisionID = @DivisionID
			AND ISNULL(RefVoucherNo,'') <> 'T99'
		GROUP BY AccountID, VoucherID
		
        OPEN @D90T0002Cursor
        FETCH NEXT FROM @D90T0002Cursor INTO @AccountID, @VoucherID, @ConvertedAmount
        WHILE @@FETCH_STATUS = 0
        BEGIN        	
		---Print '@AllocationMode ='+str(@AllocationMode)	
			IF @ConvertedAmount > 0
			BEGIN		---- Bªn Cã lín h¬n bªn Nî
				SET @DebitAccountID = @TargetAccountID
				SET @CreditAccountID = @AccountID
                              SET @ConvertedAmount = @ConvertedAmount
            END
            ELSE
            BEGIN
				SET @CreditAccountID = @TargetAccountID
				SET @DebitAccountID = @AccountID
                SET @ConvertedAmount = @ConvertedAmount * -1
			END
			IF @ConvertedAmount <> 0
            BEGIN
				SET @ConvertedAmount = ROUND(@ConvertedAmount * @Percentage / 100, @ConvertedDecimals)
				-- Exec AP0000  @VoucherID OUTPUT, 'AT9000', 'AV', @TranYear ,'',15, 3, 0, '-'
                -- Print ' @DebitAccountID,@CreditAccountID'+@DebitAccountID+' :' +@CreditAccountID
                EXEC AP7809 @DivisionID, @TranMonth, @TranYear, @VoucherID, @VoucherTypeID, @VoucherNo, @VoucherDate,
					@VDescription, @BDescription, @TDescription, @DebitAccountID, @CreditAccountID, @ConvertedAmount,
					@CreateUserID, @LastModifyUserID, @Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, @Ana06ID,
					@Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID, @ObjectID, @IsTransferGeneral
             END
             FETCH NEXT FROM @D90T0002Cursor INTO @AccountID, @VoucherID, @ConvertedAmount
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

