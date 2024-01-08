IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP4710_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP4710_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Báo cáo chi phí theo phòng ban (mã phân tích) - Customize Meiko
-- <Param>
---- 
-- <Return>
---- 
-- <Reference> T/Báo cáo/ Quản trị/ Phân tích dạng 1
---- 
-- <History>
----- Created by Phuong Thao, Date 26/09/2016
----- Modified by 
-- <Example>
---- 


CREATE PROCEDURE [dbo].[AP4710_MK] 
    @DivisionID NVARCHAR(50),     
    @isDate AS INT, -- 0: theo thang, 1: theo ngay VoucherDate, 2: theo ngay InvoiceDate
    @FromVoucherDate AS DATETIME, 
    @ToVoucherDate AS DATETIME,     
    @TranMonthFrom AS INT,
    @TranYearFrom AS INT,
    @TranMonthTo AS INT,
    @TranYearTo AS INT,
    @ReportCode NVARCHAR(50), ---- Ma bao cao
    @Sel01Type AS NVARCHAR(20), ---- Chi tieu 1
    @Sel01IDFrom AS NVARCHAR(50), --- Tu chi tieu 1
    @Sel01IDTo AS NVARCHAR(50), --- Den chi tieu mot 
    @Sel02Type AS NVARCHAR(20), --- Chi tieu 2
    @Sel02IDFrom AS NVARCHAR(50),
    @Sel02IDTo AS NVARCHAR(50),
    @Sel03Type AS NVARCHAR(20),
    @Sel03IDFrom AS NVARCHAR(50),
    @Sel03IDTo AS NVARCHAR(50),
    @Sel04Type AS NVARCHAR(20),
    @Sel04IDFrom AS NVARCHAR(50),
    @Sel04IDTo AS NVARCHAR(50),
    @Sel05Type AS NVARCHAR(20),
    @Sel05IDFrom AS NVARCHAR(50),
    @Sel05IDTo AS NVARCHAR(50),
    @StrDivisionID AS NVARCHAR(4000) = '',
    @UserID AS VARCHAR(50) = ''

AS

DECLARE 
    @AccountIDFrom NVARCHAR(50),
    @AccountIDTo NVARCHAR(50),
    @CorAccountIDFrom NVARCHAR(50),
    @CorAccountIDTo NVARCHAR(50),      
    @Level00 AS NVARCHAR(20), 
    @Level01 NVARCHAR(20), 
    @Level02 NVARCHAR(20), 
    @Level03 NVARCHAR(20),
    @AmountFormat TINYINT,
    @LineZeroSuppress TINYINT,
    @IsUsed TINYINT,
    @Sign1 VARCHAR(5), 
    @Sign2 VARCHAR(5) , 
    @Sign3 VARCHAR(5), 
    @Sign4 VARCHAR(5), 
    @ColumnID1 VARCHAR(1), 
    @ColumnID2 VARCHAR(1), 
    @ColumnID3 VARCHAR(1), 
    @ColumnID4 VARCHAR(1),
    @FromInvoiceDate AS DATETIME, 
    @ToInvoiceDate AS DATETIME,
    @Select1 AS NVARCHAR(max),
    @From1 AS NVARCHAR(max),
    @strSQL NVARCHAR(max),
	@strSQLsetting NVARCHAR(max),
    @strSQL1 NVARCHAR(max),
	@strSQL2 NVARCHAR(max),
	@strSQL3 NVARCHAR(max),
    @Temp NVARCHAR(max),
    @Temp1 NVARCHAR(max),
    @ConversionFactor decimal(28,8),
    @StrDivisionID_New AS NVARCHAR(4000)
----------------->>>>>> Phân quyền xem chứng từ của người dùng khác		
DECLARE @sSQLPer AS NVARCHAR(MAX),
		@sWHEREPer AS NVARCHAR(MAX)
SET @sSQLPer = ''
SET @sWHEREPer = ''		

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @DivisionID AND IsPermissionView = 1 ) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
	BEGIN
		SET @sSQLPer = ' LEFT JOIN AT0010 ON AT0010.DivisionID = V00.DivisionID 
											AND AT0010.AdminUserID = '''+@UserID+''' 
											AND AT0010.UserID = V00.CreateUserID '
		SET @sWHEREPer = ' AND (V00.CreateUserID = AT0010.UserID
								OR  V00.CreateUserID = '''+@UserID+''') '		
	END

-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác	

SET @FromInvoiceDate = @FromVoucherDate
SET @ToInvoiceDate = @ToVoucherDate

SET @strSQL = ''

SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END

SELECT 
@Level00 = Level00, 
@Level01 = Level01, 
@Level02 = Level02, 
@Level03 = Level03, 
@AmountFormat = AmountFormat,
@LineZeroSuppress = LineZeroSuppress
FROM AT4700
WHERE ReportCode = @ReportCode and DivisionID = @DivisionID

SET @ConversionFactor = 1

IF @AmountFormat = 0
    SET @ConversionFactor = 1
ELSE IF @AmountFormat = 1
    SET @ConversionFactor = 1000 
ELSE IF @AmountFormat = 2
    SET @ConversionFactor = 1000000 


SET @strSQL =  'SELECT '''+@DivisionID +''' AS DivisionID, V00.AccountID, V00.Quantity, V00.SignQuantity, V00.SignAmount, V00.SignOriginal, V00.VoucherDate, V00.InvoiceDate, V00.TranMonth, V00.TranYear, V00.TransactionTypeID, BudgetID, V00.CorAccountID , V00.D_C, V00.VDescription,V00.ObjectID,V00.ObjectName '
SET @strSQL1 = 'SELECT '''+@DivisionID +''' AS DivisionID, V00.AccountID, V00.Quantity, V00.SignQuantity, V00.SignAmount, V00.SignOriginal, V00.VoucherDate, V00.InvoiceDate, V00.TranMonth, V00.TranYear, V00.TransactionTypeID, BudgetID, V00.CorAccountID , V00.D_C, V00.VDescription,V00.ObjectID,V00.ObjectName '


IF @Level03 <> '' AND @Level03 IS NOT NULL
    BEGIN
        EXEC AP4700 @Level03, @LevelColumn = @Temp OUTPUT
        SET @strSQL = @strSQL + ', ISNULL('+@Temp + ','''') AS Level03'
        SET @strSQL1 = @strSQL1 + ', ISNULL('+@Temp + ','''') AS Level03'
    END

IF @Level02 <> '' AND @Level02 IS NOT NULL
    BEGIN
        EXEC AP4700 @Level02, @LevelColumn = @Temp OUTPUT
        SET @strSQL = @strSQL + ', ISNULL(' +@Temp + ','''') AS Level02 '
        SET @strSQL1 =@strSQL1 + ', ISNULL(' +@Temp + ','''') AS Level02 '
    END

IF @Level01 <> '' AND @Level01 IS NOT NULL
    BEGIN
        EXEC AP4700 @Level01, @LevelColumn = @Temp OUTPUT 
        SET @strSQL = @strSQL + ', ISNULL (' + @Temp + ','''') AS Level01'
        SET @strSQL1 =@strSQL1 + ', ISNULL (' + @Temp + ','''') AS Level01'
    END
    
IF @Level00 <> '' AND @Level00 IS NOT NULL
    BEGIN
        EXEC AP4700 @Level00, @LevelColumn = @Temp OUTPUT 
        SET @strSQL = @strSQL + ', ISNULL (' + @Temp + ','''') AS Level00'
        SET @strSQL1 =@strSQL1 + ', ISNULL (' + @Temp + ','''') AS Level00'
    END

SET @strSQL = @strSQL + ' FROM AV4301 V00'
SET @strSQL = @strSQL + @sSQLPer
SET @strSQL1 = @strSQL1 + ' FROM AV4302 V00'
SET @strSQL1 = @strSQL1 + @sSQLPer

SET @strSQL = @strSQL + ' WHERE V00.DivisionID '+ @StrDivisionID_New +''
SET @strSQL = @strSQL + @sWHEREPer
SET @strSQL1 = @strSQL1 + ' WHERE V00.DivisionID '+ @StrDivisionID_New +''
SET @strSQL1 = @strSQL1 + @sWHEREPer

---PRINT( @strSQL)

IF @isDate = 0 --by Month
    BEGIN
        SET @strSQL = @strSQL + ' AND V00.TranYear*100+V00.TranMonth <= ''' + str(@TranYearTo*100+@TranMonthTo) + ''''
        SET @strSQL1 = @strSQL1 + ' AND V00.TranYear*100+V00.TranMonth <= ''' + str(@TranYearTo*100+@TranMonthTo) + ''''
    END
    
IF @isDate = 1 --VoucherDate
    BEGIN
        SET @strSQL = @strSQL + ' AND  CONVERT(DATETIME,CONVERT(VARCHAR(10),V00.VoucherDate,21),21)  <= ''' + CONVERT(NVARCHAR(10),@ToVoucherDate,21) + ''''
        SET @strSQL1 = @strSQL1 + ' AND  CONVERT(DATETIME,CONVERT(VARCHAR(10),V00.VoucherDate,21),21)  <= ''' + convert(NVARCHAR(10),@ToVoucherDate,21) + ''''
    END

IF @isDate = 2 --InvoiceDate
    BEGIN
        SET @strSQL = @strSQL + ' AND  CONVERT(DATETIME,CONVERT(VARCHAR(10),V00.InvoiceDate,21),21)  <= ''' + convert(NVARCHAR(10),@ToInvoiceDate,21) + ''''
        SET @strSQL1 = @strSQL1 + ' AND  CONVERT(DATETIME,CONVERT(VARCHAR(10),V00.InvoiceDate,21),21)  <= ''' + convert(NVARCHAR(10),@ToInvoiceDate,21) + ''''
    END


IF @Sel01Type IS NOT NULL AND @Sel01Type <> '' ---- Tim kiem theo chi tieu 1
    BEGIN
        EXEC AP4700 @Sel01Type, @LevelColumn = @Temp OUTPUT
        IF @Sel01IDFrom IS NOT NULL AND @Sel01IDFrom <> '' AND PatIndex('%[%]%',@Sel01IDFrom) = 0
            BEGIN
                SET @strSQL = @strSQL + ' AND ISNULL(' + @Temp + ','''') >= ''' + Replace(@Sel01IDFrom,'[]','') + ''' AND ISNULL(' + @Temp + ','''') <= ''' + Replace(@Sel01IDTo,'[]','') + '''' 
                SET @strSQL1 = @strSQL1 + ' AND ISNULL(' + @Temp + ','''') >= ''' + Replace(@Sel01IDFrom,'[]','') + ''' AND ISNULL(' + @Temp + ','''') <= ''' + Replace(@Sel01IDTo,'[]','') + '''' 
            END
        ELSE
            BEGIN
                SET @strSQL = @strSQL + ' AND ISNULL(' + @Temp + ','''') LIKE ''' + @Sel01IDFrom + '''' 
                SET @strSQL1 = @strSQL1 + ' AND ISNULL(' + @Temp + ','''') LIKE ''' + @Sel01IDFrom + '''' 
            END 
    END


IF @Sel02Type IS NOT NULL AND @Sel02Type <> '' ---- Tim kiem theo chi tieu 2 
    BEGIN
        EXEC AP4700 @Sel02Type, @LevelColumn = @Temp OUTPUT
        IF @Sel02IDFrom IS NOT NULL AND @Sel02IDFrom <> '' AND PatIndex('%[%]%',@Sel02IDFrom) = 0
            BEGIN
                SET @strSQL = @strSQL + ' AND ISNULL(' + @Temp + ','''') >= ''' + Replace(@Sel02IDFrom,'[]','') + ''' AND ISNULL(' + @Temp + ','''') <= ''' + Replace(@Sel02IDTo,'[]','') + '''' 
                SET @strSQL1 = @strSQL1 + ' AND ISNULL(' + @Temp + ','''') >= ''' + Replace(@Sel02IDFrom,'[]','') + ''' AND ISNULL(' + @Temp + ','''') <= ''' + Replace(@Sel02IDTo,'[]','') + '''' 
            END
        ELSE
            BEGIN
                SET @strSQL = @strSQL + ' AND ISNULL(' + @Temp + ','''') LIKE ''' + @Sel02IDFrom + '''' 
                SET @strSQL1 = @strSQL1 + ' AND ISNULL(' + @Temp + ','''') LIKE ''' + @Sel02IDFrom + '''' 
            END 
    END

IF @Sel03Type IS NOT NULL AND @Sel03Type <> '' ---- Tim kiem theo chi tieu 3
    BEGIN
        EXEC AP4700 @Sel03Type, @LevelColumn = @Temp OUTPUT
        IF @Sel03IDFrom IS NOT NULL AND @Sel03IDFrom <> '' AND PatIndex('%[%]%',@Sel03IDFrom) = 0
            BEGIN
                SET @strSQL = @strSQL + ' AND ISNULL(' + @Temp + ','''') >= ''' + Replace(@Sel03IDFrom,'[]','') + ''' AND ISNULL(' + @Temp + ','''') <= ''' + Replace(@Sel03IDTo,'[]','') + '''' 
                SET @strSQL1 = @strSQL1 + ' AND ISNULL(' + @Temp + ','''') >= ''' + Replace(@Sel03IDFrom,'[]','') + ''' AND ISNULL(' + @Temp + ','''') <= ''' + Replace(@Sel03IDTo,'[]','') + '''' 
            END
        ELSE
            BEGIN
                SET @strSQL = @strSQL + ' AND ISNULL(' + @Temp + ','''') LIKE ''' + @Sel03IDFrom + '''' 
                SET @strSQL1 = @strSQL1 + ' AND ISNULL(' + @Temp + ','''') LIKE ''' + @Sel03IDFrom + '''' 
            END 
    END

IF @Sel04Type IS NOT NULL AND @Sel04Type <> '' ---- Tim kiem theo chi tieu 4
    BEGIN
        EXEC AP4700 @Sel04Type, @LevelColumn = @Temp OUTPUT
        IF @Sel04IDFrom IS NOT NULL AND @Sel04IDFrom <> '' AND PatIndex('%[%]%',@Sel04IDFrom) = 0
            BEGIN
                SET @strSQL = @strSQL + ' AND ISNULL(' + @Temp + ','''') >= ''' + Replace(@Sel04IDFrom,'[]','') + ''' AND ISNULL(' + @Temp + ','''') <= ''' + Replace(@Sel04IDTo,'[]','') + '''' 
                SET @strSQL1 = @strSQL1 + ' AND ISNULL(' + @Temp + ','''') >= ''' + Replace(@Sel04IDFrom,'[]','') + ''' AND ISNULL(' + @Temp + ','''') <= ''' + Replace(@Sel04IDTo,'[]','') + '''' 
            END
        ELSE
            BEGIN
                SET @strSQL = @strSQL + ' AND ISNULL(' + @Temp + ','''') LIKE ''' + @Sel04IDFrom + '''' 
                SET @strSQL1 = @strSQL1 + ' AND ISNULL(' + @Temp + ','''') LIKE ''' + @Sel04IDFrom + '''' 
            END 
    END

IF @Sel05Type IS NOT NULL AND @Sel05Type <> '' ---- Tim kiem theo chi tieu 5
    BEGIN
        EXEC AP4700 @Sel05Type, @LevelColumn = @Temp OUTPUT
        IF @Sel05IDFrom IS NOT NULL AND @Sel05IDFrom <> '' AND PatIndex('%[%]%',@Sel05IDFrom) = 0
            BEGIN
                SET @strSQL = @strSQL + ' AND ISNULL(' + @Temp + ','''') >= ''' + Replace(@Sel05IDFrom,'[]','') + ''' AND ISNULL(' + @Temp + ','''') <= ''' + Replace(@Sel05IDTo,'[]','') + '''' 
                SET @strSQL1 = @strSQL1 + ' AND ISNULL(' + @Temp + ','''') >= ''' + Replace(@Sel05IDFrom,'[]','') + ''' AND ISNULL(' + @Temp + ','''') <= ''' + Replace(@Sel05IDTo,'[]','') + '''' 
            END
        ELSE
            BEGIN
                SET @strSQL = @strSQL + ' AND ISNULL(' + @Temp + ','''') LIKE ''' + @Sel05IDFrom + '''' 
                SET @strSQL1 = @strSQL1 + ' AND ISNULL(' + @Temp + ','''') LIKE ''' + @Sel05IDFrom + '''' 
            END 
    END

SET @strSQL = @strSQL+' 
UNION ALL 
'+@strSQL1

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE SYSOBJECTS.NAME = 'AV4700' AND SYSOBJECTS.XTYPE = 'V')
    EXEC ('CREATE VIEW AV4700 AS ' + @strSQL)
ELSE
    EXEC ('ALTER VIEW AV4700 AS ' + @strSQL)


SET @strSQL = '
SELECT '''+@DivisionID +''' AS DivisionID, 
Max(V00.VDescription) As VDescription, Max(V00.VoucherDate) As VoucherDate,
Max(V00.ObjectID) As ObjectID, Max(V00.ObjectName) As ObjectName '

IF @Level03 <> '' AND @Level03 IS NOT NULL
    SET @strSQL = @strSQL + ', V00.Level03 AS Level03'
ELSE
    SET @strSQL = @strSQL + ' , NULL AS Level03'
    
IF @Level02 <> '' AND @Level02 IS NOT NULL
    SET @strSQL = @strSQL + ' ,V00.Level02 AS Level02'
ELSE
    SET @strSQL = @strSQL + ' , NULL AS Level02'

IF @Level01 <> '' AND @Level01 IS NOT NULL
    SET @strSQL = @strSQL + ' , V00.Level01 AS Level01'
ELSE
    SET @strSQL = @strSQL + ' , NULL AS Level01'

IF @Level00 <> '' AND @Level00 IS NOT NULL
    SET @strSQL = @strSQL + ' , V00.Level00 AS Level00'
ELSE
    SET @strSQL = @strSQL + ' , NULL AS Level00'

CREATE TABLE #AP4710_RS_1 (	DivisionID  Varchar(50), VDescription Nvarchar(4000),VoucherDate Datetime, 
							ObjectID Varchar(50), ObjectName NVarchar(250),
							Level03 Varchar(50), Level02 Varchar(50), Level01 Varchar(50), Level00 Varchar(50),
							Amount Decimal(28,8), ColumnID Varchar(50))

Declare	@AP4710_MK_1 as cursor,	
		@AP4710_MK_2 as cursor,	
		@ColumnID as varchar(50)


select @strSQL2 = '', @strSQL3 = ''

IF @Level03 <> '' AND @Level03 IS NOT NULL SET @strSQL2 = @strSQL2 + 'GROUP BY V00.Level03 '    
		IF @Level02 <> '' AND @Level02 IS NOT NULL SET @strSQL2 = @strSQL2 + ' ,V00.Level02 '
		IF @Level01 <> '' AND @Level01 IS NOT NULL SET @strSQL2 = @strSQL2 + ' ,V00.Level01 '
		IF @Level00 <> '' AND @Level00 IS NOT NULL SET @strSQL2 = @strSQL2 + ' ,V00.Level00 '

-- Print (@strSQL)
-- Print (@strSQL2)

DECLARE @FromDate DATETIME,
		@ToDate DATETIME

IF @isDate = 1      SELECT @FromDate = @FromVoucherDate, @ToDate = @ToVoucherDate --VoucherDate
ELSE IF @isDate = 2 SELECT @FromDate = @FromInvoiceDate, @ToDate = @ToInvoiceDate --InvoiceDate

SET @AP4710_MK_2 = Cursor Scroll KeySet FOR
	SELECT	ColumnID
	FROM	AT4701
	WHERE	ReportCode = @ReportCode AND DivisionID = @DivisionID and IsUsed = 1
	ORDER BY Convert(int,ColumnID)

	OPEN	@AP4710_MK_2
	FETCH NEXT FROM @AP4710_MK_2 INTO  @ColumnID
	WHILE @@Fetch_Status = 0
	Begin
		EXEC AP4701 @DivisionID, @ReportCode , @ColumnID, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
		
		PRINT ( @strSQL + ' , '+ @Temp + ' /' + STR(@ConversionFactor) + ' AS Amount, ''ColumnID'+@ColumnID+''' 
		FROM AV4700 V00	' + @strSQL2)
				
		INSERT INTO #AP4710_RS_1 			
		EXEC ( @strSQL +  ' , ' + @Temp + ' /' + @ConversionFactor + ' AS Amount, ''ColumnID'+@ColumnID+''' 
		FROM AV4700 V00	' + @strSQL2)

	FETCH NEXT FROM @AP4710_MK_2 INTO  @ColumnID
	End

	Close @AP4710_MK_2


	--Select * from #AP4710_RS_1

SELECT	DISTINCT  Convert(int,RIGHT(ColumnID, LEN(ColumnID) - 8)) AS Orders, ColumnID
INTO	#AP4710_RS_2
FROM	#AP4710_RS_1 
ORDER BY Convert(int,RIGHT(ColumnID, LEN(ColumnID) - 8))

	-- Select * from #AP4710_RS_2

IF EXISTS (SELECT TOP 1 1 FROM #AP4710_RS_2)
BEGIN

	SELECT @strSQL2 = 
	'
	SELECT	*
	INTO  #AP4710_RS
	FROM	
	(
	SELECT	 DivisionID, VDescription, VoucherDate, ObjectID, ObjectName,
			 Level03, Level02, Level01, Level00, Amount, ColumnID 			
	FROM	 #AP4710_RS_1 V00
	
	WHERE 1=1  	
	'+ CASE WHEN @LineZeroSuppress = 1 THEN 'AND Amount <> 0' ELSE '' END + '
	) P
	PIVOT
	(SUM(Amount) FOR ColumnID IN ('
	SELECT	@strSQL3 = @strSQL3 + CASE WHEN @strSQL3 <> '' THEN ',' ELSE '' END + '['+ColumnID+']'
	FROM	#AP4710_RS_2

	SELECT	@strSQL3 = @strSQL3 +')
	) As T
	
	
	SELECT V00.*   
	'+ CASE WHEN @Level03 <> '' AND @Level03 IS NOT NULL THEN  ', V923.SelectionName AS Level03Description' ELSE ', NULL AS Level03Description' END
	+ CASE WHEN  @Level02 <> '' AND @Level02 IS NOT NULL THEN  ', V922.SelectionName AS Level02Description' ELSE ', NULL AS Level02Description' END
	+ CASE WHEN @Level01 <> '' AND @Level01 IS NOT NULL THEN   ', V921.SelectionName AS Level01Description' ELSE ', NULL AS Level01Description' END
	+ CASE WHEN @Level00 <> '' AND @Level00 IS NOT NULL THEN   ', V920.SelectionName AS Level00Description' ELSE ', NULL AS Level00Description' END +'
	INTO #AP4710
	FROM	#AP4710_RS V00
	'+ CASE WHEN @Level03 <> '' AND @Level03 IS NOT NULL THEN 
		' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Level03 + ''' AND V923.SelectionID = V00.Level03 AND V923.DivisionID = V00.DivisionID' ELSE '' END
	+ CASE WHEN @Level02 <> '' AND @Level02 IS NOT NULL THEN 
		' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Level02 + ''' AND V922.SelectionID = V00.Level02 AND V922.DivisionID = V00.DivisionID'
	ELSE '' END
	+ CASE WHEN @Level01 <> '' AND @Level01 IS NOT NULL THEN 
		' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Level01 + ''' AND V921.SelectionID = V00.Level01 AND V921.DivisionID = V00.DivisionID'  ELSE '' END
	+ CASE WHEN @Level00 <> '' AND @Level00 IS NOT NULL THEN 
		' LEFT JOIN AV6666 AS V920 ON V920.SelectionType = ''' + @Level00 + ''' AND V920.SelectionID = V00.Level00 AND V920.DivisionID = V00.DivisionID'
	ELSE '' END +'

	SELECT *, CASE WHEN ISNULL(Level00,'''') <> '''' THEN Level00 ELSE 
					CASE WHEN ISNULL(Level01,'''') <> '''' THEN Level01 ELSE
						CASE WHEN ISNULL(Level02,'''') <> '''' THEN Level02 ELSE
							CASE WHEN ISNULL(Level03,'''') <> '''' THEN Level03  END END END END AS LevelID,
			CASE WHEN ISNULL(Level00Description,'''') <> '''' THEN Level00Description ELSE 
				CASE WHEN ISNULL(Level01Description,'''') <> '''' THEN Level01Description ELSE
					CASE WHEN ISNULL(Level02Description,'''') <> '''' THEN Level02Description ELSE
						CASE WHEN ISNULL(Level03Description,'''') <> '''' THEN Level03Description END END END END AS LevelName
	FROM   #AP4710
	ORDER BY LevelID

	'

END
--Print @strSQL2
--Print @strSQL3
EXEC (@strSQL2 + @strSQL3)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

