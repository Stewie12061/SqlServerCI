IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7906_TIENTIEN]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7906_TIENTIEN]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Tinh toan so lieu Psinh No (PD), PSC (PC), Du No (BD), du co (BC),  Sodu ky truoc (LD, LC) 
---- Su dung cho bang thuyet minh tai chinh phan TSCD
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 24/09/2008 by Van Nhan
---- 
---- Modified on 11/01/2012 by Le Thi Thu Hien : Chinh sua lai
---- Modified by on 11/10/2012 by Lê Thị Thu Hiền : Bổ sung thêm strDivisionID
---- Modified by on 02/01/2013 by Lê Thị Thu Hiền : Thay đổi INSERT #DivisionID bằng Bảng tạm A00007
---- Modified on 31/03/2021 by Huỳnh Thử: Tách Store TienTien -- Xuất Execl nhiều divisionID
-- <Example>
---- 


CREATE PROCEDURE [dbo].[AP7906_TIENTIEN]
       @DivisionID AS nvarchar(20) ,
       @TranYear AS int ,
       @ReportCode AS nvarchar(20) ,
       @GroupID AS nvarchar(20) ,
       @TitleID AS nvarchar(20) ,
       @OperatorID AS nvarchar(20) ,
       @FromAccountID AS nvarchar(20) ,
       @ToAccountID AS nvarchar(20) ,
       @FromCorAccountID AS nvarchar(20) ,
       @ToCorAccountID AS nvarchar(20) ,
       @ColID AS TINYINT,
       @StrDivisionID AS NVARCHAR(4000) = ''
AS
SET @FromCorAccountID = ( CASE WHEN isnull(@FromCorAccountID , '') = '' THEN '' ELSE @FromCorAccountID END )
SET @ToCorAccountID = ( CASE WHEN isnull(@ToCorAccountID , '') = '' THEN '999' ELSE @ToCorAccountID END )

--PRINT @FromCorAccountID
--PRINT @ToCorAccountID

--------------->>>> Chuỗi DivisionID
DECLARE @StrDivisionID_New AS NVARCHAR(4000)
	
SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END
		
DELETE FROM	A00007 WHERE SPID = @@SPID
INSERT INTO A00007(SPID, DivisionID) 
EXEC('SELECT '''+@@SPID+''', DivisionID FROM AT1101 WHERE DivisionID '+@StrDivisionID_New+'')

---------------------<<<<<<<<<< Chuỗi DivisionID

DECLARE @Amount AS decimal(28,8) ,
        @sSQL AS nvarchar(4000)	

----Print @GroupID +'  '+@TitleID+'= '+str(@ColID)+'  = '+@OperatorID

---- Số dư kỳ trước (Last Period Balance)
IF @OperatorID IN ( 'BL', 'LB' )
   BEGIN 
         SET @Amount = ( SELECT Sum(SignAmount)                        
                         FROM	AV4301
                         WHERE	DivisionID = @DivisionID
								AND AccountID BETWEEN @FromAccountID AND @ToAccountID 
								AND ( ( TranMonth + TranYear * 100 < 1 + @TranYear * 100 ) 
									OR ( TranMonth + TranYear * 100 = 1 + @TranYear * 100 
									AND TransactionTypeID = 'T00' ) ) 
								AND BudgetID = 'AA' 
								AND CorAccountID BETWEEN @FromCorAccountID AND @ToCorAccountID )
   END


---- Số dư trong kỳ (Period Balance)
IF @OperatorID IN ( 'BA')
   BEGIN 
         SET @Amount = ( SELECT Sum(SignAmount)                        
                         FROM	AV4301
                         WHERE	DivisionID = @DivisionID
								AND AccountID BETWEEN @FromAccountID AND @ToAccountID 
								AND TranYear  <= @TranYear									
								AND BudgetID = 'AA' 
								AND CorAccountID BETWEEN @FromCorAccountID AND @ToCorAccountID )
   END

------- 'YC' Phát sinh có trong năm (Year Credit)
------- 'PC' Xuất kho kỳ này
IF @OperatorID IN ( 'YC' , 'PC' )
   BEGIN 
         SET @Amount = ( SELECT Sum(SignAmount)
                         FROM   AV4301
                         WHERE  DivisionID = @DivisionID
								AND AccountID BETWEEN @FromAccountID AND @ToAccountID 
								AND TranYear = @TranYear 
								AND BudgetID = 'AA' AND D_C = 'C'
								AND CorAccountID BETWEEN @FromCorAccountID AND @ToCorAccountID )
   END

------- 'YD' Phát sinh nợ trong năm (Year Debit)
------- 'PD' Nhập kho kỳ này 'PD'
IF @OperatorID IN ( 'YD', 'PD' )
   BEGIN 
         SET @Amount = ( SELECT Sum(SignAmount)
                         FROM   AV4301
                         WHERE  DivisionID = @DivisionID
								AND AccountID BETWEEN @FromAccountID AND @ToAccountID 
								AND TranYear = @TranYear 
								AND BudgetID = 'AA' AND D_C = 'D'
								AND CorAccountID BETWEEN @FromCorAccountID AND @ToCorAccountID )
   END

------- Số dư Có   
IF @OperatorID = 'BC' 
   BEGIN 
         SET @Amount =   ( SELECT	Sum(SignAmount)
						   FROM		AV4301
						   WHERE	DivisionID = @DivisionID
									AND AccountID BETWEEN @FromAccountID AND @ToAccountID 
									AND TranYear <= @TranYear 
									AND BudgetID = 'AA' 
									AND CorAccountID BETWEEN @FromCorAccountID AND @ToCorAccountID )
		IF @Amount < 0
			BEGIN
				SET @Amount = - @Amount
			END
		ELSE
			BEGIN
				SET @Amount = 0
			END
   END

--------'PA' Trong kỳ (Period Actual) 
--------'YA' Trong năm (Year Actual)
IF @OperatorID IN ( 'PA', 'YA') 
   BEGIN 
         SET @Amount = ( SELECT Sum(SignAmount)          
                         FROM  AV4301
                         WHERE DivisionID = @DivisionID
								AND AccountID BETWEEN @FromAccountID AND @ToAccountID 
								AND TranYear = @TranYear
								AND BudgetID = 'AA' 
								AND CorAccountID BETWEEN @FromCorAccountID AND @ToCorAccountID )
   END

IF ISNULL(@Amount , 0) <> 0
   BEGIN
         SET @sSQL = '
			UPDATE	AT7910 
			SET		Amount0' + ltrim(rtrim(str(@ColID))) + ' = ' + str(@Amount, 28,8) + '
			WHERE	DivisionID = ''' + @DivisionID + ''' 
					AND TitleID=''' + @TitleID + ''' 
					AND ReportCode = '''+@ReportCode+''''
         EXEC ( @sSQL )
   END
--PRINT(@sSQL)
--Print 'test '+@TitleID+ ' Cot so: '+str(@ColID)+' Tu TK: '+@FromAccountID+' den TK '+@ToAccountID+' phat sinh '+@OperatorID+'Nam :'+str(@TranYear)+' doi ung :'+@FromCorAccountID+' va: '+@ToCorAccountID+' so tien: '+Str(isnull(@Amount,0))

DELETE FROM	A00007 WHERE SPID = @@SPID
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

