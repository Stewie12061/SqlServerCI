IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP7302]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7302]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- Created BY Nguyen Van Nhan AND Nguyen Thi Ngoc Minh
---- Created Date 06/04/2004
----- Purpose: Insert vao Table AT7301(Temp Tabled) de in Bang can doi so phat sinh theo nhieu cap
--- Edited BY Nguyen Quoc Huy
---- Date 29/09/2005

/********************************************
'* Edited by: [GS] [Việt Khánh] [29/07/2010]
	Hoang Phuoc: modified [28/09/2010]
	them apk, divisionid cho AT7301
'********************************************/
---- Edited by Bao Anh		Date: 20/12/2012
---- Purpose: Sua loi khong khop so du khi in theo cap TK chi tiet va cac cap cha
---- -Modified on 05/11/2012 by Lê Thị Thu Hiền : LEFT JOIN bảng DivisionID kết với @DivisionID (0019537 )
----- Modified on 16/04/2014 by Mai Duyen : Sua cach lay so du dau ky, so du cuoi ky (Customized KH Sun Viet)
----- Modified on 25/06/2014 by Mai Duyen : Sua cach lay so du dau ky, so du cuoi ky cua tai khoan cap cha (KH Vimec)
----- Modified on 02/10/2015 by Phuong Thao : Chinh sua in cho tiet so du No/Co cho cac TK cong no theo doi theo doi tuong
----- Modify on 16/03/2016 by Bảo Anh: Thiết lập mức lock data dạng Snapshot để giải quyết deadlock khi thực thi store (lỗi Ngân Hà) 
----- Modify on 14/04/2016 by Bảo Anh: Bổ sung with nolock, bỏ thiết lập Snapshot
----- Modify on 26/05/2016 by Bảo Anh: Cải tiến tốc độ 
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Phương Thảo on 20/07/2016: Bổ sung customize KH KimHoanVu tương tự như Vimec (@Customerindex = 67)
---- Modified by Bảo Thy on 24/05/2017: Sửa danh mục dùng chung
---- Modified by Bảo Anh on 19/06/2017: Loại trừ TK 024910 ra khỏi báo cáo (Customize Bông Sen)
---- Modified by Văn Tài on 26/11/2020: Format SQL, không thay đổi về code.
---- Modified by Huỳnh Thử on 01/04/2021: Tách store Tiên Tiến

CREATE PROCEDURE [dbo].[AP7302] 
    @DivisionID AS NVARCHAR(50), 
    @GROUP AS TINYINT,
    @StrDivisionID AS NVARCHAR(4000) = '',
	@TranMonthFrom AS INT = 0, 
    @TranYearFrom AS INT = 0, 
    @TranMonthTo AS INT = 0, 
    @TranYearTo AS INT = 0,
	@IsNotClear AS Tinyint = 0 -- Không bù trừ số dư với các TK lưỡng tính
AS
Declare @CustomerName INT

--Tao bang tam de kiem tra day co phai la khach hang Sieu Thanh khong (CustomerName = 16)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
IF @CustomerName = 16 --- Customize Sieu Thanh
	Exec AP7302_ST @DivisionID, @GROUP, @StrDivisionID, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @IsNotClear
ELSE
IF @CustomerName = 13 --- Customize Tiên Tiến
	Exec AP7302_TIENTIEN @DivisionID, @GROUP, @StrDivisionID, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @IsNotClear
Else
Begin

IF EXISTS(SELECT TOP 1 1 FROM SysObjects WITH (NOLOCK) WHERE Name = 'AT7301' AND Xtype = 'U')
DROP TABLE AT7301
BEGIN
    CREATE TABLE [dbo].[AT7301](
		[APK] [uniqueidentifier] NOT NULL,
		[DivisionID] [nvarchar](50) NOT NULL,
        [AccountID] [NVARCHAR](50) NOT NULL, 
        [AccountName] [NVARCHAR](250) NULL, 
        [AccountNameE] [NVARCHAR](250) NULL, 
        [DebitClosing] [DECIMAL](28, 2) NULL, 
        [CreditClosing] [DECIMAL](28, 2) NULL, 
        [DebitOpening] [DECIMAL](28, 2) NULL, 
        [CreditOpening] [DECIMAL](28, 2) NULL, 
        [PeriodDebit] [DECIMAL](28, 2) NULL, 
        [PeriodCredit] [DECIMAL](28, 2) NULL, 
        [AccumulatedDebit] [DECIMAL](28, 2) NULL, 
        [AccumulatedCredit] [DECIMAL](28, 2) NULL, 
        [AccountGroup1ID] [NVARCHAR](50) NULL, 
        [AccountGroupName1] [NVARCHAR](250) NULL, 
        [AccountGroupNameE1] [NVARCHAR](250) NULL ,
  CONSTRAINT [PK_AT7301] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[AT7301] ADD  DEFAULT (newid()) FOR [APK]
END
    
DECLARE 
    @Account_Cur AS CURSOR, 
    --@AccountID AS NVARCHAR(50), 
    @AccountName AS NVARCHAR(250), 
    @AccountNameE AS NVARCHAR(250), 
    @AccountGroup1ID AS NVARCHAR(50), 
    @AccountGroup1Name AS NVARCHAR(250), 
    
    @sSQL AS NVARCHAR(4000), 
   
    @SQL1 AS NVARCHAR(4000), --@ConversionAmountUnit = 10
    @SQL2 AS NVARCHAR(4000), --@ConversionAmountUnit = 100
    @SQL3 AS NVARCHAR(4000), --@ConversionAmountUnit = 1000
    @SQL4 AS NVARCHAR(4000), --@ConversionAmountUnit = 10000
    @tmp AS NVARCHAR(4000), 	    
    @Count AS TINYINT ,
	@PeriodFrom AS INT, 
	@PeriodTo AS INT

SET @Count = 1

DECLARE @StrDivisionID_New AS NVARCHAR(4000)
SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
@StrDivisionID + '''' ELSE ' IN (''' + REPLACE(@StrDivisionID, ',', ''',''') + ''')' END

DELETE FROM	A00007 WHERE SPID = @@SPID
INSERT INTO A00007(SPID, DivisionID) 
EXEC('SELECT ''' + @@SPID + ''', DivisionID FROM AT1101 WHERE DivisionID ' + @StrDivisionID_New + '')

SET @PeriodFrom = @TranYearFrom * 100 + @TranMonthFrom
SET @PeriodTo = @TranYearTo * 100 + @TranMonthTo

SET @sSQL = '
    SELECT '''+@DivisionID +''' AS DivisionID
			, (CASE WHEN ' + LTRIM(@GROUP) + ' = 0 THEN 0 ELSE 1 END) AS isGroup
			, T73.AccountID
			, T05.AccountName
			, T05.AccountNameE
			, T05.GroupID AS AccountGroup1ID
			, T06.GroupName AS AccountGroupName1
			, T06.GroupNameE AS AccountGroupNameE1
			, DebitOpening
			, CreditOpening
			, DebitClosing
			, CreditClosing
			, PeriodDebit
			, PeriodCredit
			, AccumulatedDebit
			, ABS(AccumulatedCredit) AS AccumulatedCredit
			, 0 AS Level1
			, ' + LTRIM(STR(@GROUP)) + ' AS Group1
    FROM AT7301 AS T73  WITH (NOLOCK)
    INNER JOIN AT1005 AS T05 WITH (NOLOCK) ON T73.AccountID = T05.AccountID
    LEFT JOIN AT1006 AS T06 WITH (NOLOCK) ON T05.GroupID = T06.GroupID AND T06.DivisionID = ''' + @DivisionID + '''
    WHERE T73.DivisionID = '''+@DivisionID +''''
    
set @SQL1=''
set @SQL2=''
set @SQL3=''
set @SQL4=''
set @tmp=''

EXEC('

--SELECT  '''+@DivisionID +''' AS DivisionID, AccountID, AccountName, AccountNameE, GroupAccountID, GroupAccountName, GroupAccountNameE, 
--    CASE WHEN Closing < = 0 THEN 0 ELSE Closing END, ---DebitClosing
--    CASE WHEN Closing > 0 THEN 0 ELSE ABS(Closing) END, ---CreditClosing
--    CASE WHEN Opening < = 0 THEN 0 ELSE Opening END, ---DebitOpening
--    CASE WHEN Opening > 0 THEN 0 ELSE ABS(Opening) END, ---CreditOpening
--    PeriodDebit, PeriodCredit, AccumulatedDebit, AccumulatedCredit
--FROM AV7301
--Where DivisionID ='''+@DivisionID +'''

INSERT INTO AT7301
(
	DivisionID
	, AccountID
	, AccountName
	, AccountNameE
	, AccountGroup1ID
	, AccountGroupName1
	, AccountGroupNameE1
	, DebitClosing
	, CreditClosing
	, DebitOpening
	, CreditOpening
	, PeriodDebit
	, PeriodCredit
	, AccumulatedDebit
	, AccumulatedCredit
)
SELECT  '''+@DivisionID +''' AS DivisionID
	, AccountID
	, AccountName
	, AccountNameE
	, GroupAccountID
	, GroupAccountName
	, GroupAccountNameE
	, CASE WHEN Closing < = 0 THEN 0 ELSE Closing END ---DebitClosing
    , CASE WHEN Closing > 0 THEN 0 ELSE ABS(Closing) END ---CreditClosing
    , CASE WHEN Opening < = 0 THEN 0 ELSE Opening END ---DebitOpening
    , CASE WHEN Opening > 0 THEN 0 ELSE ABS(Opening) END ---CreditOpening
    , PeriodDebit
	, PeriodCredit
	, AccumulatedDebit
	, AccumulatedCredit
FROM AV7301
Where DivisionID ='''+@DivisionID +''''

)

--Tinh so du theo doi tuong
DECLARE @Cursor AS CURSOR
DECLARE @AccountID AS varchar(20),
		@GroupID AS varchar(20),
		@OpeningDebitAmount AS MONEY,
		@OpeningCreditAmount AS MONEY,
		@ClosingDebitAmount AS MONEY,
		@ClosingCreditAmount AS MONEY
		
	
IF EXISTS ( SELECT TOP 1 1 FROM AT1005 WITH (NOLOCK) WHERE IsObject = 1 AND GroupID IN ('G03', 'G04') and @IsNotClear = 1 )
BEGIN
	SELECT  @DivisionID AS DivisionID
			, ObjectID
			, AccountID
			, SUM(CASE WHEN (TranYear * 100 + TranMonth) < @PeriodFrom OR TransactionTypeID IN ('T00', 'Z00') 
					   THEN ISNULL(ConvertedAmount, 0) 
					   ELSE 0 END) AS Opening
			, SUM(ISNULL(ConvertedAmount, 0)) AS Closing			
	INTO #AT7301_CT
	FROM
	(
		SELECT	ObjectID    ---- PHAT SINH NO  				 
				, AT9000.DivisionID
				, DebitAccountID AS AccountID
				, SUM(ISNULL(ConvertedAmount,0)) AS ConvertedAmount
				, SUM(ISNULL(OriginalAmountCN,0)) AS OriginalAmount
				, TranMonth
				, TranYear
				, CreditAccountID AS CorAccountID  -- tai khoan doi ung  
				, 'D' AS D_C
				, TransactionTypeID
				, AT1005.GroupID 
		FROM AT9000 WITH (NOLOCK)
		INNER JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AT9000.DebitAccountID 
		WHERE	DebitAccountID IS NOT NULL 
				AND AT1005.GroupID IN ('G03', 'G04') 
				AND AT1005.IsObject = 1 
				AND (AT9000.DivisionID IN (SELECT DivisionID FROM A00007 WITH (NOLOCK) WHERE SPID = @@SPID)) 
				AND AT1005.GroupID <> 'G00'
				AND (AT9000.TranYear * 100 + AT9000.TranMonth <= @PeriodTo OR AT9000.TransactionTypeID IN ('T00', 'Z00'))
		GROUP BY ObjectID
				, Ana01ID
				, CurrencyIDCN
				, VoucherDate
				, InvoiceDate
				, DueDate
				, AT9000.DivisionID
				, DebitAccountID
				, TranMonth
				, TranYear
				, CreditAccountID
				, TransactionTypeID
				, AT1005.GroupID     

		UNION ALL  

		------------------- So phat sinh co, lay am  
		SELECT    ---- PHAT SINH CO   
				(CASE WHEN TransactionTypeID = 'T99' THEN CreditObjectID ELSE ObjectID END) AS ObjectID
				, AT9000.DivisionID
				, CreditAccountID AS AccountID
				, SUM(ISNULL(ConvertedAmount,0) * -1) AS ConvertedAmount
				, SUM(ISNULL(OriginalAmountCN,0) * -1) AS OriginalAmount
				, TranMonth
				, TranYear
				, DebitAccountID AS CorAccountID
				, 'C' AS D_C
				, TransactionTypeID
				, AT1005.GroupID  
		FROM AT9000 WITH (NOLOCK) 
		INNER JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AT9000.CreditAccountID
		WHERE CreditAccountID IS NOT NULL  
				AND AT1005.GroupID IN ('G03', 'G04') 
				AND AT1005.IsObject = 1
				AND (AT9000.DivisionID IN (SELECT DivisionID FROM A00007 WITH (NOLOCK) WHERE SPID = @@SPID)) 
				AND AT1005.GroupID <> 'G00'
				AND (AT9000.TranYear * 100 + AT9000.TranMonth <= @PeriodTo OR AT9000.TransactionTypeID IN ('T00', 'Z00'))
		GROUP BY (CASE WHEN TransactionTypeID ='T99' THEN CreditObjectID ELSE ObjectID END)
				, AT9000.DivisionID
				, CreditAccountID
				, TranMonth
				, TranYear
				, DebitAccountID
				, TransactionTypeID
				, AT1005.GroupID 
	)	T	
	GROUP BY ObjectID, AccountID

	SET @Cursor = CURSOR SCROLL KEYSET FOR
		SELECT 	AccountID
		FROM	AT1005 WITH (NOLOCK)
		WHERE 	IsObject = 1
				AND GroupID IN ('G03', 'G04')
				AND AccountID <> '024910'
		ORDER BY AccountID	
			
	OPEN @Cursor
	FETCH NEXT FROM @Cursor INTO @AccountID
	WHILE @@FETCH_STATUS = 0
	BEGIN	
		SET @OpeningDebitAmount = 0
		SET @OpeningCreditAmount = 0
		SET @ClosingDebitAmount = 0
		SET @ClosingCreditAmount = 0
		
		SELECT		@OpeningDebitAmount = SUM(CASE WHEN #AT7301_CT.Opening >= 0 THEN #AT7301_CT.Opening ELSE 0 END), 
					@OpeningCreditAmount = SUM(CASE WHEN #AT7301_CT.Opening < 0 THEN #AT7301_CT.Opening * (-1) ELSE 0 END), 
					@ClosingDebitAmount = SUM(CASE WHEN #AT7301_CT.Closing >= 0 THEN #AT7301_CT.Closing ELSE 0 END), 
					@ClosingCreditAmount = SUM(CASE WHEN #AT7301_CT.Closing < 0 THEN #AT7301_CT.Closing * (-1) ELSE 0 END)
		FROM		#AT7301_CT 	
		WHERE		#AT7301_CT.AccountID = @AccountID
	
		UPDATE		AT7301
		SET			DebitOpening = @OpeningDebitAmount,
					CreditOpening = @OpeningCreditAmount,
					DebitClosing = @ClosingDebitAmount,
					CreditClosing = @ClosingCreditAmount
		WHERE		AccountID = @AccountID


		FETCH NEXT FROM @Cursor INTO @AccountID
	END

	DROP TABLE #AT7301_CT
END 

WHILE @Count < = @GROUP
    BEGIN
		
        SET @tmp = '
            UNION ALL
            SELECT
            	'''+@DivisionID +''' AS DivisionID
				, (CASE WHEN ' + STR(@GROUP) + ' = 0 THEN 0 ELSE 1 END) AS isGroup
				, LEFT(T73.AccountID, ' + LTRIM(RTRIM(str(2 + @count))) + ') AS AccountID
				, T05.AccountName
				, T05.AccountNameE
				, T05.GroupID AS AccountGroup1ID
				, T06.GroupName AS AccountGroupName1
				, T06.GroupNameE AS AccountGroupNameE1
				, 
		'
		IF @CustomerName IN (28, 31, 67)   -- KH Sun viet, vimec , KimHoanVu
			BEGIN
				IF @GROUP <> 0 
					SET @tmp = @tmp +    
						'(CASE WHEN SUM(ISNULL(DebitOpening, 0) - ISNULL(CreditOpening, 0)) > 0 THEN SUM(ISNULL(DebitOpening, 0) - ISNULL(CreditOpening, 0))
							ELSE 0 END) as DebitOpening
						, (CASE WHEN SUM(ISNULL(CreditOpening, 0) - ISNULL(DebitOpening, 0)) > 0 THEN SUM(ISNULL(CreditOpening, 0) - ISNULL(DebitOpening, 0))
							ELSE 0 END) AS CreditOpening
						, (CASE WHEN SUM(ISNULL(DebitClosing, 0) - ISNULL(CreditClosing, 0)) > 0 THEN SUM(ISNULL(DebitClosing, 0) - ISNULL(CreditClosing, 0))
							ELSE 0 END) AS DebitClosing
						, (CASE WHEN SUM(ISNULL(CreditClosing, 0) - ISNULL(DebitClosing, 0)) > 0 THEN SUM(ISNULL(CreditClosing, 0) - ISNULL(DebitClosing, 0))
							ELSE 0 END) AS CreditClosing
						, '
				Else
					SET @tmp = @tmp +         
						' ISNULL(SUM(ISNULL(DebitOpening, 0)), 0) AS DebitOpening
						, ISNULL(SUM(ISNULL(CreditOpening, 0)), 0) AS CreditOpening
						, ISNULL(SUM(ISNULL(DebitClosing, 0)), 0) AS DebitClosing
						, ISNULL(SUM(ISNULL(CreditClosing, 0)), 0) AS CreditClosing
						, '
			END
		Else
			SET @tmp = @tmp +         
                ' ISNULL(SUM(ISNULL(DebitOpening, 0)), 0) AS DebitOpening
				, ISNULL(SUM(ISNULL(CreditOpening, 0)), 0) AS CreditOpening
				, ISNULL(SUM(ISNULL(DebitClosing, 0)), 0) AS DebitClosing
				, ISNULL(SUM(ISNULL(CreditClosing, 0)), 0) AS CreditClosing
				, '
                
                
        SET @tmp = @tmp + 
                'ISNULL(SUM(ISNULL(PeriodDebit, 0)), 0) AS PeriodDebit
				, ISNULL(SUM(ISNULL(PeriodCredit, 0)), 0) AS PeriodCredit
				, ISNULL(SUM(ISNULL(AccumulatedDebit, 0)), 0) AS AccumulatedDebit
				, ISNULL(SUM(ISNULL(abs(AccumulatedCredit), 0)), 0) AS AccumulatedCredit
				, ' + LTRIM(RTRIM(STR(@count))) + ' AS Level1
				, ' + LTRIM(str(@GROUP)) + ' AS Group1
            FROM AT7301 AS T73 WITH (NOLOCK) 
            INNER JOIN AT1005 AS T05 WITH (NOLOCK) ON (LEFT(T73.AccountID, ' + LTRIM(RTRIM(STR(2 + @count))) + ') = T05.AccountID) 
            LEFT JOIN AT1006 AS T06 WITH (NOLOCK) ON (T05.GroupID = T06.GroupID) AND T06.DivisionID = '''+@DivisionID+'''
            WHERE len(T73.AccountID) > ' + LTRIM(RTRIM(str(2 + @count))) + ' 
					AND T73.DivisionID ='''+@DivisionID +'''
            GROUP BY T73.DivisionID
					, T05.GroupID
					, T06.GroupName
					, T06.GroupNameE
					, LEFT(T73.AccountID, ' + LTRIM(RTRIM(str(2 + @count))) + ')
					, T05.AccountName
					, T05.AccountNameE '
               
        if(@Count = 1)
			 SET @SQL1 = @tmp
		else if(@Count = 2)
			 SET @SQL2 = @tmp
		else if(@Count = 3)
			 SET @SQL3 = @tmp
		 else if(@Count = 4)
			SET @SQL4 = @tmp
			
        SET @Count = @Count + 1
    END


--print  'SELECT * FROM ( ' +@sSQL+ @SQL1 + @SQL2 + @SQL3 + @SQL4+ ') A WHERE DivisionID = '''+@DivisionID+''''

IF NOT EXISTS(SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE SYSOBJECTS.NAME = 'AV7302' AND SYSOBJECTS.XTYPE = 'V')
    EXEC('CREATE VIEW AV7302 -- AP7302
    AS SELECT * FROM (' + @sSQL+ @SQL1 + @SQL2 + @SQL3 + @SQL4+ ') A WHERE DivisionID = '''+@DivisionID+'''')
ELSE
    EXEC('ALTER VIEW AV7302

  -- AP7302
    AS SELECT * FROM (' + @sSQL+ @SQL1 + @SQL2 + @SQL3 + @SQL4+ ') A WHERE DivisionID = '''+@DivisionID+'''')

IF NOT EXISTS(SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE SYSOBJECTS.NAME = 'AT7302' AND SYSOBJECTS.XTYPE = 'U')
    EXEC('SELECT * INTO AT7302 FROM AV7302 WHERE DivisionID = '''+@DivisionID+'''')
ELSE
    BEGIN
        EXEC('DROP TABLE AT7302')
        EXEC('SELECT * INTO AT7302 FROM AV7302 WHERE DivisionID = '''+@DivisionID+'''')
    END

End


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

