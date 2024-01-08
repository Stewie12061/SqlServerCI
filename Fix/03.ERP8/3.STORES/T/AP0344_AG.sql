IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0344_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0344_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



------ Created by Tieu Mai on 13/03/2017
------- Purpose: Truy van so cai theo dang tong hop
------ Updated by Nhật Thanh on 24/03/2022: Bổ sung điều kiện division @@@ khi join AT1005
/*
exec AP0344_AG @DivisionID=N'ANG',@TranMonthFrom=2,@TranYearFrom=2017,@TranMonthTo=3,@TranYearTo=2017,@FromDate='2017-03-13 08:17:15.490',@ToDate='2017-03-13 08:17:15.490',
@IsDate=0,@AccountIDFrom=N'001',@AccountIDTo=N'N00',@Level1=0,@UserID=N'ASOFTADMIN',@StrDivisionID=N'ANG',@StrFinderMaster=N'1=1'
*/


CREATE PROCEDURE [dbo].[AP0344_AG]
    @DivisionID AS NVARCHAR(50), 
    @TranMonthFrom AS INT, 
    @TranYearFrom AS INT, 
    @TranMonthTo AS INT, 
    @TranYearTo AS INT, 
    @FromDate AS DATETIME, 
    @ToDate AS DATETIME, 
    @IsDate AS TINYINT, 
    @AccountIDFrom AS NVARCHAR(50), 
    @AccountIDTo AS NVARCHAR(50), 
    @Level1 AS TINYINT,
    @UserID AS NVARCHAR(50) = 'ASOFTADMIN',
    @StrDivisionID AS NVARCHAR(4000) = '',
	@StrFinderMaster AS NVARCHAR(MAX)
    
AS

DECLARE @strSQL AS NVARCHAR(4000)

IF @Level1 = 0
    SET @strSQL = '
        SELECT '''+@DivisionID +''' AS DivisionID, 
			BatchID, TransactionTypeID, 
            AccountID, CorAccountID, D_C, 
            DebitAccountID AS DebitAccountID, 
            CreditAccountID AS CreditAccountID, 
            VoucherDate, VoucherTypeID, VoucherNo, 
            InvoiceDate, InvoiceNo, Serial, ISNULL(ConvertedAmount, 0) AS ConvertedAmount, 
            ISNULL(OriginalAmount, 0) AS OriginalAmount, 
            CurrencyID, ExchangeRate, SignAmount, 
            ISNULL(OSignAmount, 0) AS OSignAmount, 
            TranMonth, TranYear, TranMonth + TranYear * 100 AS Period, 
            CreateUserID, 
            VDescription, BDescription, TDescription, 
            ObjectID, VATObjectID, 
            VATNo, VATObjectName, Object_Address, 
            VATTypeID, VATGroupID, 
            AccountID AS LinkAccountID
    '
ELSE
    SET @strSQL = '
        SELECT '''+@DivisionID +''' AS DivisionID, 
			BatchID, TransactionTypeID, 
            AccountID, CorAccountID, D_C, 
            DebitAccountID AS DebitAccountID, 
            CreditAccountID AS CreditAccountID, 
            VoucherDate, VoucherTypeID, VoucherNo, 
            InvoiceDate, InvoiceNo, Serial, 
            ISNULL(ConvertedAmount, 0) AS ConvertedAmount, 
            ISNULL(OriginalAmount, 0) AS OriginalAmount, 
            CurrencyID, ExchangeRate, 
            ISNULL(SignAmount, 0) AS SignAmount, 
            ISNULL(OSignAmount, 0) AS OSignAmount, 
            TranMonth, TranYear, TranMonth + TranYear * 100 AS Period, 
            CreateUserID, 
            VDescription, BDescription, TDescription, 
            ObjectID, VATObjectID, 
            VATNo, VATObjectName, Object_Address, 
            VATTypeID, VATGroupID, 
            LEFT(AccountID, ' + STR(@Level1 + 2) + ') AS LinkAccountID
    '

SET @strSQL = @strSQL + '
    FROM AV5000 
    WHERE DivisionID LIKE '''+@StrDivisionID+'''
        AND(AccountID LIKE ''' + @AccountIDFrom + '%''
            OR AccountID LIKE ''' + @AccountIDTo + '%''
            OR(AccountID > = ''' + @AccountIDFrom + '''
            AND AccountID < = ''' + @AccountIDTo + '''))
            AND  '+@StrFinderMaster+'
'

IF @IsDate = 0
    SET @strSQL = @strSQL + ' AND TranYear * 100 + TranMonth < = ''' + STR(@TranYearTo * 100 + @TranMonthTo) + ''''
ELSE 
    SET @strSQL = @strSQL + ' AND CONVERT(DATETIME,CONVERT(VARCHAR(10),VoucherDate,101),101) < = ''' + CONVERT(NVARCHAR(10), @ToDate, 101) + ''''

IF NOT EXISTS(SELECT 1 FROM SYSOBJECTS WHERE SYSOBJECTS.NAME = 'AV4310' AND SYSOBJECTS.XTYPE = 'V')
    EXEC('CREATE VIEW AV4310 AS --Created BY AP7201
     ' + @strSQL)
ELSE
    EXEC('ALTER VIEW AV4310 AS --Created BY AP7201
    ' + @strSQL)

-----------------------------------------------------------------------------------------------------------
IF @IsDate = 0
    BEGIN
        SET @strSQL = '
            SELECT V10.LinkAccountID, T01.AccountName, T01.AccountNameE, '''+@DivisionID +''' AS DivisionID, 
                SUM(CASE 
                        WHEN V10.TranYear * 12 + TranMonth < ''' + STR(@TranYearFrom * 12 + @TranMonthFrom) + ''' 
                                OR V10.TransactionTypeID = ''' + 'T00' + ''' 
                            THEN ISNULL(SignAmount, 0) 
                        ELSE 0 
                    END) AS OpeningAmount, 
                SUM(ISNULL(SignAmount, 0)) AS ClosingAmount, 
                SUM(CASE 
                        WHEN(V10.TranYear * 12 + V10.TranMonth) < = ''' + STR(@TranYearTo * 12 + @TranMonthTo) + ''' 
                                AND V10.TranYear > = ''' + STR(@TranYearFrom) + '''
                                AND V10.D_C = ''' + 'D' + ''' AND V10.TransactionTypeID <> ''' + 'T00' + '''
                            THEN ConvertedAmount 
                        ELSE 0 
                    END) AS AccumulatedDebit,
                SUM(CASE 
                        WHEN(V10.TranYear * 12 + V10.TranMonth) < = ''' + STR(@TranYearTo * 12 + @TranMonthTo) + ''' 
                                AND V10.TranYear > = ''' + STR(@TranYearFrom) + '''
                                AND V10.D_C = ''' + 'C' + ''' AND V10.TransactionTypeID <> ''' + 'T00' + '''
                            THEN ConvertedAmount 
                        ELSE 0 
                    END) AS AccumulatedCredit
            FROM AV4310 AS V10 
            LEFT JOIN AT1005 AS T01 ON T01.AccountID = V10.LinkAccountID and T01.DivisionID in (''@@@'','''+@DivisionID+''') 
        '
        
        IF @Level1 <> 0 SET @strSQL = @strSQL + ' WHERE len(V10.LinkAccountID) = ''' + STR(@Level1 + 2) + ''''

        SET @strSQL = @strSQL + ' GROUP BY V10.LinkAccountID, T01.AccountName, T01.AccountNameE'
    END
ELSE
    BEGIN
        SET @strSQL = '
            SELECT V10.LinkAccountID, T01.AccountName, T01.AccountNameE, '''+@DivisionID +''' AS DivisionID, 
                SUM(CASE 
                        WHEN CONVERT(DATETIME,CONVERT(VARCHAR(10),V10.VoucherDate,101),101) < ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' 
                                OR V10.TransactionTypeID = ''' + 'T00' + ''' 
                            THEN ISNULL(SignAmount, 0) 
                        ELSE 0 
                    END) AS OpeningAmount, 
                SUM(ISNULL(SignAmount, 0)) AS ClosingAmount, 
                SUM(CASE 
                        WHEN CONVERT(DATETIME,CONVERT(VARCHAR(10),V10.VoucherDate,101),101) < = ''' + CONVERT(NVARCHAR(10), @ToDate, 101) + ''' 
                                AND CONVERT(DATETIME,CONVERT(VARCHAR(10),V10.VoucherDate,101),101) > = ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' 
                                AND V10.D_C = ''' + 'D' + ''' AND V10.TransactionTypeID <> ''' + 'T00' + '''
                            THEN ConvertedAmount 
                        ELSE 0 
                    END) AS AccumulatedDebit, 
                SUM(CASE 
                        WHEN CONVERT(DATETIME,CONVERT(VARCHAR(10),V10.VoucherDate,101),101) < = ''' + CONVERT(NVARCHAR(10), @ToDate, 101) + ''' 
                                AND CONVERT(DATETIME,CONVERT(VARCHAR(10),V10.VoucherDate,101),101) > = ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' 
                                AND V10.D_C = ''' + 'C' + ''' AND V10.TransactionTypeID <> ''' + 'T00' + '''
                            THEN ConvertedAmount 
                        ELSE 0 
                    END) AS AccumulatedCredit
            FROM AV4310 AS V10 
            LEFT JOIN AT1005 AS T01 ON T01.AccountID = V10.LinkAccountID and T01.DivisionID in (''@@@'','''+@DivisionID+''') 
        '

        IF @Level1 <> 0 SET @strSQL = @strSQL + ' WHERE len(V10.LinkAccountID) = ''' + STR(@Level1 + 2) + ''''
        
        SET @strSQL = @strSQL + ' GROUP BY V10.LinkAccountID, T01.AccountName, T01.AccountNameE'
    END

IF NOT EXISTS(SELECT 1 FROM SYSOBJECTS WHERE SYSOBJECTS.NAME = 'AV4315' AND SYSOBJECTS.XTYPE = 'V')
    EXEC('CREATE VIEW AV4315 AS --Created BY AP7201
    ' + @strSQL)
ELSE
    EXEC('ALTER VIEW AV4315 AS --Created BY AP7201
    ' + @strSQL)

-----------------------------------------------------------------------------------------------------------
SET @strSQL = '
    SELECT V10.LinkAccountID, V10.CorAccountID, T01.AccountName, T01.AccountNameE, '''+@DivisionID +''' AS DivisionID, V10.Period, 
        SUM(CASE WHEN V10.D_C = ''' + 'D' + ''' THEN V10.ConvertedAmount ELSE 0 END) AS PeriodDebit, 
        SUM(CASE WHEN V10.D_C = ''' + 'C' + ''' THEN V10.ConvertedAmount ELSE 0 END) AS PeriodCredit
    FROM AV4310 AS V10 
    LEFT JOIN AT1005 AS T01 ON T01.AccountID = V10.CorAccountID and T01.DivisionID in (''@@@'','''+@DivisionID+''') '
    
IF @IsDate = 0
    SET @strSQL = @strSQL + ' WHERE V10.TranYear * 100 + V10.TranMonth > = ''' + STR(@TranYearFrom * 100 + @TranMonthFrom) + ''' '
ELSE
   	SET @strSQL =	@strSQL + ' WHERE (CONVERT(DATETIME,CONVERT(VARCHAR(10),V10.VoucherDate,101),101) Between ''' + convert(NVARCHAR(10), @FromDate,101)+ ''' And '''+convert(NVARCHAR(10),@ToDate,101)+ ''') '
SET @strSQL =	@strSQL + ' AND (V10.TransactionTypeID is NULL OR V10.TransactionTypeID <> ''' + 'T00' +''')'


IF @Level1 <> 0 SET @strSQL = @strSQL + ' AND len(V10.LinkAccountID) = ''' + STR(@Level1 + 2) + ''''

SET @strSQL = @strSQL + ' GROUP BY V10.LinkAccountID, V10.CorAccountID, T01.AccountName, T01.AccountNameE, V10.Period ' 

IF NOT EXISTS(SELECT 1 FROM SYSOBJECTS WHERE SYSOBJECTS.NAME = 'AV4317' AND SYSOBJECTS.XTYPE = 'V')
    EXEC('CREATE VIEW AV4317 AS --Created BY AP7201
    ' + @strSQL)
ELSE
    EXEC('ALTER VIEW AV4317 AS --Created BY AP7201
    ' + @strSQL)

-----------------------------------------------------------------------------------------------------------
SET @strSQL = '
    SELECT V15.OpeningAmount, V15.ClosingAmount, V15.AccountName AS LinkAccountName, 
        V15.AccountNameE AS LinkAccountNameE, 
        V17.Period, 
        V15.LinkAccountID, V15.AccumulatedDebit, V15.AccumulatedCredit, 
        V17.CorAccountID, V17.AccountName, V17.AccountNameE, V15.DivisionID, V17.PeriodDebit, V17.PeriodCredit
    FROM AV4315 AS V15 
    LEFT JOIN AV4317 AS V17 ON V15.LinkAccountID = V17.LinkAccountID 
        AND V17.DivisionID = '''+@DivisionID+'''
    WHERE(V17.CorAccountID IS NOT NULL) OR (V17.CorAccountID IS NULL AND V15.OpeningAmount <> 0)
'
IF NOT EXISTS(SELECT 1 FROM SYSOBJECTS WHERE SYSOBJECTS.NAME = 'AV7201' AND SYSOBJECTS.XTYPE = 'V')
    EXEC('--Created BY AP7201
        CREATE VIEW AV7201 AS --Created BY AP7201
        ' + @strSQL)
ELSE
    EXEC('--Created BY AP7201
        ALTER VIEW AV7201 AS --Created BY AP7201
        ' + @strSQL)

-----------------------------------------------------------------------------------------------------------
SET @strSQL = '
    SELECT OpeningAmount, ClosingAmount, LinkAccountName, LinkAccountNameE, 
        LinkAccountID, AccumulatedDebit, AccumulatedCredit, 
        --CorAccountID, AccountName, AccountNameE, 
        '''+@DivisionID +''' AS DivisionID, AT1101.DivisionName,
        SUM(PeriodDebit) AS PeriodDebit, SUM(PeriodCredit)AS PeriodCredit,
        '''+@UserID +''' AS UserID
    FROM AV7201 
    LEFT JOIN AT1101 ON AT1101.DivisionID = '''+@DivisionID+'''
    GROUP BY OpeningAmount, ClosingAmount, LinkAccountName, LinkAccountNameE, 
        LinkAccountID, AccumulatedDebit, AccumulatedCredit, 
        --CorAccountID, AccountName, AccountNameE, 
        AT1101.DivisionName 
    ORDER BY LinkAccountID'

EXEC (@strSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
