IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP4710]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP4710]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-------- Created by Nguyen Van Nhan, Date 05/11/2003.
-------- Purpose In bao cao phan tich tai chinh dang 1
--------- Edit by: Dang Le Bao Quynh; Date : 07/03/2007
--------- Purpose: Bo sung them dieu kien tim kiem gia tri rong cho cac chi tieu
--------- Edit by: Nguyen Quoc Huy; Date : 31/07/2007 
--------- Purpose: Bo sung them dieu kien theo ngày
--------- Edit by: Dang Le Bao Quynh; Date : 11/01/2008 
--------- Purpose: Bo sung dieu kien tim kiem LIKE
---- Modified by on 10/08/2012 by Le Thi Thu Hien : Bo sung thêm 10 c?t báo cáo
---- Modified by on 09/10/2012 by Le Thi Thu Hien : Bo sung thêm strDivisionID
---- Modified by on 09/10/2012 by Le Thi Thu Hien : Bo sung thêm strDivisionID
---- Modified by on 26/11/2012 by B?o Anh:	Bo sung VDescription, VoucherDate
---- Modified by on 09/10/2012 by Le Thi Thu Hien : Bo sung SUMO02Level01
---- Modified by on 09/10/2012 by Le Thi Thu Hien : Bo sung Mantis 0020115 tru?ng ghi chú c?a MPT d?i tu?ng
---- Modified by on 09/05/2013 by Bao Quynh : Dùng l?nh max cho 2 field VDescription, VoucherDate, tránh tru?ng h?p các ch? tiêu khác ngày d? ra nhi?u dòng
---- Modified on 05/03/2014 by Le Thi Thu Hien : Bo sung phan quyen xem du lieu cua nguoi khac
---- Modified on 11/06/2014 by Mai Duyen : Sửa lỗi @IsUsed = Null (KH KingCom)
---- Modified on 24/06/2016 by Quốc Tuấn : Bổ sung ObjectID và ObjectName
---- Modified by Hải Long on 18/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified on 07/03/2019 by Kim Thư : thêm trường O01ID->O05ID , O01Name->O05Name lên view AV4706
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

-- <Example>
---- 
-- 

CREATE PROCEDURE [dbo].[AP4710] 
    @DivisionID NVARCHAR(50), 
    -------------------------------------------------------------------------edit by Quoc huy ---------------------------------------------------------------
    @isDate AS INT, -- 0: theo thang, 1: theo ngay VoucherDate, 2: theo ngay InvoiceDate
    @FromVoucherDate AS DATETIME, 
    @ToVoucherDate AS DATETIME, 
    -------------------------------------------------------------------------END edit by Quoc huy ---------------------------------------------------------------
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
    
    @ColumnAType NVARCHAR(20), 
    @ColumnBType NVARCHAR(20), 
    @ColumnCType NVARCHAR(20), 
    @ColumnDType NVARCHAR(20),
    @ColumnEType NVARCHAR(20), 
    @ColumnFType NVARCHAR(20), 
    @ColumnGType NVARCHAR(20), 
    @ColumnHType NVARCHAR(20),
    @ColumnIType NVARCHAR(20), 
    @ColumnJType NVARCHAR(20), 
    @ColumnKType NVARCHAR(20), 
    @ColumnLType NVARCHAR(20), 
    @ColumnMType NVARCHAR(20), 
    @ColumnNType NVARCHAR(20),
    @ColumnOType NVARCHAR(20), 
    @ColumnPType NVARCHAR(20), 
    @ColumnQType NVARCHAR(20), 
    @ColumnRType NVARCHAR(20),
    @ColumnSType NVARCHAR(20), 
    @ColumnTType NVARCHAR(20), 
    @ColumnUType NVARCHAR(20),
    
    @ColumnAOriginal TINYINT,
    @ColumnBOriginal TINYINT, 
    @ColumnCOriginal TINYINT, 
    @ColumnDOriginal TINYINT, 
    @ColumnEOriginal TINYINT,
    @ColumnFOriginal TINYINT, 
    @ColumnGOriginal TINYINT, 
    @ColumnHOriginal TINYINT, 
    @ColumnIOriginal TINYINT,
    @ColumnJOriginal TINYINT, 
    @ColumnKOriginal TINYINT, 
    @ColumnLOriginal TINYINT,
    @ColumnMOriginal TINYINT, 
    @ColumnNOriginal TINYINT, 
    @ColumnOOriginal TINYINT, 
    @ColumnPOriginal TINYINT,
    @ColumnQOriginal TINYINT, 
    @ColumnROriginal TINYINT, 
    @ColumnSOriginal TINYINT, 
    @ColumnTOriginal TINYINT,
    @ColumnUOriginal TINYINT, 
    
    @ColumnABudget TINYINT, 
    @ColumnBBudget TINYINT,
    @ColumnCBudget TINYINT, 
    @ColumnDBudget TINYINT, 
    @ColumnEBudget TINYINT, 
    @ColumnFBudget TINYINT,
    @ColumnGBudget TINYINT, 
    @ColumnHBudget TINYINT, 
    @ColumnIBudget TINYINT, 
    @ColumnJBudget TINYINT,
    @ColumnKBudget TINYINT,
    @ColumnLBudget TINYINT, 
    @ColumnMBudget TINYINT, 
    @ColumnNBudget TINYINT, 
    @ColumnOBudget TINYINT, 
    @ColumnPBudget TINYINT, 
    @ColumnQBudget TINYINT, 
    @ColumnRBudget TINYINT, 
    @ColumnSBudget TINYINT, 
    @ColumnTBudget TINYINT, 
    @ColumnUBudget TINYINT,
      
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
    @strSQL1 NVARCHAR(max),
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

-------------------------------------------------------------------------edit by Quoc Huy ---------------------------------------------------------------

SET @strSQL =  'SELECT '''+@DivisionID +''' AS DivisionID, V00.AccountID, V00.Quantity, V00.SignQuantity, V00.SignAmount, V00.SignOriginal, V00.VoucherDate, V00.InvoiceDate, V00.TranMonth, V00.TranYear, V00.TransactionTypeID, BudgetID, V00.CorAccountID , V00.D_C, V00.VDescription,V00.ObjectID,V00.ObjectName '
SET @strSQL1 = 'SELECT '''+@DivisionID +''' AS DivisionID, V00.AccountID, V00.Quantity, V00.SignQuantity, V00.SignAmount, V00.SignOriginal, V00.VoucherDate, V00.InvoiceDate, V00.TranMonth, V00.TranYear, V00.TransactionTypeID, BudgetID, V00.CorAccountID , V00.D_C, V00.VDescription,V00.ObjectID,V00.ObjectName '
-------------------------------------------------------------------------END edit by Quoc Huy ---------------------------------------------------------------

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
-------------------------------------------------------------------------edit by Quoc Huy --------------------------------------------------------------- 
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
-------------------------------------------------------------------------edit by Quoc Huy --------------------------------------------------------------- 

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
SELECT '''+@DivisionID +''' AS DivisionID, NULL AS NHAN, 
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

DECLARE
@Column NVARCHAR(1),
@FromDate DATETIME,
@ToDate DATETIME

IF @isDate = 1      SELECT @FromDate = @FromVoucherDate, @ToDate = @ToVoucherDate --VoucherDate
ELSE IF @isDate = 2 SELECT @FromDate = @FromInvoiceDate, @ToDate = @ToInvoiceDate --InvoiceDate

SET @Column = 'A'
EXEC AP4701 @DivisionID, @ReportCode , @Column, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
SET @strSQL = @strSQL + ',' +@Temp + '/' +ltrim(Rtrim( str(@ConversionFactor))) + ' AS Column' + @Column

SET @Column = 'B'
EXEC AP4701 @DivisionID, @ReportCode , @Column, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
SET @strSQL = @strSQL + ',' +@Temp + '/' +ltrim(Rtrim( str(@ConversionFactor))) + ' AS Column' + @Column

SET @Column = 'C'
EXEC AP4701 @DivisionID, @ReportCode , @Column, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
SET @strSQL = @strSQL + ',' +@Temp + '/' +ltrim(Rtrim( str(@ConversionFactor))) + ' AS Column' + @Column

SET @Column = 'D'
EXEC AP4701 @DivisionID, @ReportCode , @Column, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
SET @strSQL = @strSQL + ',' +@Temp + '/' +ltrim(Rtrim( str(@ConversionFactor))) + ' AS Column' + @Column

SET @Column = 'E'
EXEC AP4701 @DivisionID, @ReportCode , @Column, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
SET @strSQL = @strSQL + ',' +@Temp + '/' +ltrim(Rtrim( str(@ConversionFactor))) + ' AS Column' + @Column

SET @Column = 'F'
EXEC AP4701 @DivisionID, @ReportCode , @Column, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
SET @strSQL = @strSQL + ',' +@Temp + '/' +ltrim(Rtrim( str(@ConversionFactor))) + ' AS Column' + @Column

SET @Column = 'G'
EXEC AP4701 @DivisionID, @ReportCode , @Column, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
SET @strSQL = @strSQL + ',' +@Temp + '/' +ltrim(Rtrim( str(@ConversionFactor))) + ' AS Column' + @Column

SET @Column = 'H'
EXEC AP4701 @DivisionID, @ReportCode , @Column, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
SET @strSQL = @strSQL + ',' +@Temp + '/' +ltrim(Rtrim( str(@ConversionFactor))) + ' AS Column' + @Column

SET @Column = 'I'
EXEC AP4701 @DivisionID, @ReportCode , @Column, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
SET @strSQL = @strSQL + ',' +@Temp + '/' +ltrim(Rtrim( str(@ConversionFactor))) + ' AS Column' + @Column

SET @Column = 'J'
EXEC AP4701 @DivisionID, @ReportCode , @Column, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
SET @strSQL = @strSQL + ',' +@Temp + '/' +ltrim(Rtrim( str(@ConversionFactor))) + ' AS Column' + @Column

SET @Column = 'K'
EXEC AP4701 @DivisionID, @ReportCode , @Column, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
SET @strSQL = @strSQL + ',' +@Temp + '/' +ltrim(Rtrim( str(@ConversionFactor))) + ' AS Column' + @Column

SET @Column = 'L'
EXEC AP4701 @DivisionID, @ReportCode , @Column, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
SET @strSQL = @strSQL + ',' +@Temp + '/' +ltrim(Rtrim( str(@ConversionFactor))) + ' AS Column' + @Column

SET @Column = 'M'
EXEC AP4701 @DivisionID, @ReportCode , @Column, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
SET @strSQL = @strSQL + ',' +@Temp + '/' +ltrim(Rtrim( str(@ConversionFactor))) + ' AS Column' + @Column

SET @Column = 'N'
EXEC AP4701 @DivisionID, @ReportCode , @Column, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
SET @strSQL = @strSQL + ',' +@Temp + '/' +ltrim(Rtrim( str(@ConversionFactor))) + ' AS Column' + @Column

SET @Column = 'O'
EXEC AP4701 @DivisionID, @ReportCode , @Column, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
SET @strSQL = @strSQL + ',' +@Temp + '/' +ltrim(Rtrim( str(@ConversionFactor))) + ' AS Column' + @Column

SET @Column = 'P'
EXEC AP4701 @DivisionID, @ReportCode , @Column, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
SET @strSQL = @strSQL + ',' +@Temp + '/' +ltrim(Rtrim( str(@ConversionFactor))) + ' AS Column' + @Column

SET @Column = 'Q'
EXEC AP4701 @DivisionID, @ReportCode , @Column, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
SET @strSQL = @strSQL + ',' +@Temp + '/' +ltrim(Rtrim( str(@ConversionFactor))) + ' AS Column' + @Column

SET @Column = 'R'
EXEC AP4701 @DivisionID, @ReportCode , @Column, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
SET @strSQL = @strSQL + ',' +@Temp + '/' +ltrim(Rtrim( str(@ConversionFactor))) + ' AS Column' + @Column

SET @Column = 'S'
EXEC AP4701 @DivisionID, @ReportCode , @Column, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
SET @strSQL = @strSQL + ',' +@Temp + '/' +ltrim(Rtrim( str(@ConversionFactor))) + ' AS Column' + @Column

SET @Column = 'T'
EXEC AP4701 @DivisionID, @ReportCode , @Column, @isDate, @FromDate, @ToDate, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ColumnData = @Temp OUTPUT
SET @strSQL = @strSQL + ',' +@Temp + '/' +ltrim(Rtrim( str(@ConversionFactor))) + ' AS Column' + @Column


SET @strSQL = @strSQL + ' FROM AV4700 V00'

IF @Level03 <> '' AND @Level03 IS NOT NULL SET @strSQL = @strSQL + ' GROUP BY V00.Level03 '    
IF @Level02 <> '' AND @Level02 IS NOT NULL SET @strSQL = @strSQL + ' ,V00.Level02 '
IF @Level01 <> '' AND @Level01 IS NOT NULL SET @strSQL = @strSQL + ' ,V00.Level01 '
IF @Level00 <> '' AND @Level00 IS NOT NULL SET @strSQL = @strSQL + ' ,V00.Level00 '

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE SYSOBJECTS.NAME = 'AV4715' AND SYSOBJECTS.XTYPE = 'V')
    EXEC ('CREATE VIEW AV4715 AS ' + @strSQL)
ELSE
    EXEC ('ALTER VIEW AV4715 AS ' + @strSQL)

----- Xu ly cong tru cot thu K

Select	@IsUsed = IsUsed, @Sign1 = Sign1, @Sign2 = Sign2, @Sign3 = Sign3, @Sign4 = Sign4, 
		@ColumnID1 = ColumnID1, @ColumnID2 = ColumnID2, @ColumnID3 = ColumnID3, @ColumnID4 = ColumnID4 
From	AT4701 
Where	ColumnID = 'U' 
		AND ReportCode = @ReportCode
SET @strSQL =' 
SELECT	'''+@DivisionID +''' AS DivisionID, NHAN,ObjectID, ObjectName, VDescription, VoucherDate,
		Level03 , Level02 , Level01 , Level00, 
		(Select Count(ObjectID) From AT1202 A Where A.O02ID = AV4715.Level01) As SUMO02Level01, 
		ColumnA , ColumnB, ColumnC , ColumnD, ColumnE, ColumnF, ColumnG , 
		ColumnH, ColumnI , ColumnJ , ColumnK, ColumnL, ColumnM, ColumnN,
		ColumnO,ColumnP,ColumnQ,ColumnR,ColumnS,ColumnT, '

IF Isnull(@IsUsed,0) =0 
    SET @strSQL = @strSQL +' 0 AS ColumnU From AV4715 '
ELSE
    BEGIN
        IF @Sign1 ='+' 
            SET @strSQL = @strSQL +' ISNULL(Column'+@ColumnID1+',0) ' 
        ELSE 
            SET @strSQL = @strSQL +' -ISNULL(Column'+@ColumnID1+',0) ' 

        IF ISNULL(@Sign2,'')<>'' 
            IF @Sign2 ='+' 
                SET @strSQL = @strSQL +' + ISNULL(Column'+@ColumnID2+',0) ' 
            ELSE 
                SET @strSQL = @strSQL +' - ISNULL(Column'+@ColumnID2+',0) ' 
                
        IF ISNULL(@Sign3,'')<>'' 
            IF @Sign3 ='+' 
                SET @strSQL = @strSQL +' + ISNULL(Column'+@ColumnID3+',0) ' 
            ELSE 
                SET @strSQL = @strSQL +' - ISNULL(Column'+@ColumnID3+',0) ' 

        IF ISNULL(@Sign4,'')<>'' 
            IF @Sign4 ='+' 
                SET @strSQL = @strSQL +' + ISNULL(Column'+@ColumnID4+',0) ' 
            ELSE 
                SET @strSQL = @strSQL +' - ISNULL(Column'+@ColumnID4+',0) ' 

        SET @strSQL = @strSQL +' AS ColumnU From AV4715 '
    END
    
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE SYSOBJECTS.NAME = 'AV4705' AND SYSOBJECTS.XTYPE = 'V')
    EXEC ('CREATE VIEW AV4705 AS ' + @strSQL)
ELSE
    EXEC ('ALTER VIEW AV4705 AS ' + @strSQL)

---- Updated by Van Nhan, Co them phan ghi chu cho Donacoop
IF LEFT(@Level03,2) ='A0'
    BEGIN 
        SET @Select1='	T11.RefDate, T11.Notes,T11.Note01, T11.Note02, T11.Note03, T11.Note04, T11.Note05, T11.Amount01, T11.Amount02,T11.Amount03,T11.Amount04,T11.Amount05,
						T11.Amount06,T11.Amount07,T11.Amount08,T11.Amount09,T11.Amount10,
						T12.O01ID, T12.O02ID, T12.O03ID, T12.O04ID, T12.O05ID, O1.AnaName As O01Name, O2.AnaName As O02Name, O3.AnaName As O03Name, O4.AnaName As O04Name, O5.AnaName As O05Name  '
        SET @From1 = '	LEFT JOIN AT1011 AS T11 ON T11.AnatypeID = ''' + @Level03 + ''' AND T11.AnaID = V00.Level03 
						lEFT JOIN AT1202 AS T12 ON T12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T12.ObjectID = V00.ObjectID
						LEFT JOIN AT1015 O1 WITH(NOLOCK) on T12.O01ID = O1.AnaID And O1.AnaTypeID = ''O01'' and O1.DivisionID = V00.DivisionID
						LEFT JOIN AT1015 O2 WITH(NOLOCK) on T12.O02ID = O2.AnaID And O2.AnaTypeID = ''O02'' and O2.DivisionID = V00.DivisionID
						LEFT JOIN AT1015 O3 WITH(NOLOCK) on T12.O03ID = O3.AnaID And O3.AnaTypeID = ''O03'' and O3.DivisionID = V00.DivisionID
						LEFT JOIN AT1015 O4 WITH(NOLOCK) on T12.O04ID = O4.AnaID And O4.AnaTypeID = ''O04'' and O4.DivisionID = V00.DivisionID
						LEFT JOIN AT1015 O5 WITH(NOLOCK) on T12.O05ID = O5.AnaID And O5.AnaTypeID = ''O05'' and O5.DivisionID = V00.DivisionID'
    END
ELSE
    BEGIN
        SET @Select1='	NULL AS RefDate, T11.Notes AS Notes, NULL AS Note01, NULL AS Note02, NULL AS Note03, NULL AS Note04, NULL AS Note05, NULL AS Amount01, NULL AS Amount02, 
						NULL AS Amount03, NULL AS Amount04, NULL AS Amount05, NULL AS Amount06, NULL AS Amount07, NULL AS Amount08, NULL AS Amount09, NULL AS Amount10,
						T12.O01ID, T12.O02ID, T12.O03ID, T12.O04ID, T12.O05ID, O1.AnaName As O01Name, O2.AnaName As O02Name, O3.AnaName As O03Name, O4.AnaName As O04Name, O5.AnaName As O05Name '
        SET @From1 ='	LEFT JOIN AT1015 AS T11 ON T11.AnaTypeID = ''' + @Level03 + ''' AND T11.AnaID = V00.Level03	
						lEFT JOIN AT1202 AS T12 ON T12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T12.ObjectID = V00.ObjectID
						LEFT JOIN AT1015 O1 WITH(NOLOCK) on T12.O01ID = O1.AnaID And O1.AnaTypeID = ''O01'' and O1.DivisionID = V00.DivisionID
						LEFT JOIN AT1015 O2 WITH(NOLOCK) on T12.O02ID = O2.AnaID And O2.AnaTypeID = ''O02'' and O2.DivisionID = V00.DivisionID
						LEFT JOIN AT1015 O3 WITH(NOLOCK) on T12.O03ID = O3.AnaID And O3.AnaTypeID = ''O03'' and O3.DivisionID = V00.DivisionID
						LEFT JOIN AT1015 O4 WITH(NOLOCK) on T12.O04ID = O4.AnaID And O4.AnaTypeID = ''O04'' and O4.DivisionID = V00.DivisionID
						LEFT JOIN AT1015 O5 WITH(NOLOCK) on T12.O05ID = O5.AnaID And O5.AnaTypeID = ''O05'' and O5.DivisionID = V00.DivisionID'
    END


SET @strSQL = 'SELECT V00.*'

IF @Level03 <> '' AND @Level03 IS NOT NULL SET @strSQL = @strSQL + ', V923.SelectionName AS Level03Description'
IF @Level02 <> '' AND @Level02 IS NOT NULL SET @strSQL = @strSQL + ', V922.SelectionName AS Level02Description'
IF @Level01 <> '' AND @Level01 IS NOT NULL SET @strSQL = @strSQL + ', V921.SelectionName AS Level01Description'
IF @Level00 <> '' AND @Level00 IS NOT NULL SET @strSQL = @strSQL + ', V920.SelectionName AS Level00Description'

SET @strSQL = @strSQL + ', '+@Select1
SET @strSQL = @strSQL + ' FROM AV4705 V00'

IF @Level03 <> '' AND @Level03 IS NOT NULL SET @strSQL = @strSQL + ' LEFT JOIN AV6666 AS V923 ON V923.SelectionType = ''' + @Level03 + ''' AND V923.SelectionID = V00.Level03 AND V923.DivisionID in (V00.DivisionID,''@@@'')'
IF @Level02 <> '' AND @Level02 IS NOT NULL SET @strSQL = @strSQL + ' LEFT JOIN AV6666 AS V922 ON V922.SelectionType = ''' + @Level02 + ''' AND V922.SelectionID = V00.Level02 AND V922.DivisionID in (V00.DivisionID,''@@@'')' 
IF @Level01 <> '' AND @Level01 IS NOT NULL SET @strSQL = @strSQL + ' LEFT JOIN AV6666 AS V921 ON V921.SelectionType = ''' + @Level01 + ''' AND V921.SelectionID = V00.Level01 AND V921.DivisionID in (V00.DivisionID,''@@@'')' 
IF @Level00 <> '' AND @Level00 IS NOT NULL SET @strSQL = @strSQL + ' LEFT JOIN AV6666 AS V920 ON V920.SelectionType = ''' + @Level00 + ''' AND V920.SelectionID = V00.Level00 AND V920.DivisionID in (V00.DivisionID,''@@@'')' 

SET @strSQL =  @strSQL + @From1

IF @LineZeroSuppress = 1
    SET @strSQL = @strSQL + 
' 
WHERE V00.ColumnA <>0 
OR V00.ColumnB <>0 
OR V00.ColumnC <>0 
OR V00.ColumnD <>0 
OR V00.ColumnE <>0 
OR V00.ColumnF <>0 
OR V00.ColumnG <>0 
OR V00.ColumnH <>0 
OR V00.ColumnI <>0 
OR V00.ColumnJ <>0 
OR V00.ColumnK <>0
OR V00.ColumnL <>0 
OR V00.ColumnM <>0 
OR V00.ColumnN <>0 
OR V00.ColumnO <>0 
OR V00.ColumnP <>0 
OR V00.ColumnQ <>0 
OR V00.ColumnR <>0 
OR V00.ColumnS <>0 
OR V00.ColumnT <>0 
OR V00.ColumnU <>0  
'

---PRINT @strSQL
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE SYSOBJECTS.NAME = 'AV4706' AND SYSOBJECTS.XTYPE = 'V')
    EXEC ('CREATE VIEW AV4706 AS ' + @strSQL )
ELSE
    EXEC ('ALTER VIEW AV4706 AS ' + @strSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

