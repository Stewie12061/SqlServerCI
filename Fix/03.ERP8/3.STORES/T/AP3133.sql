IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3133]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP3133]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In bao cao lãi phạt chiết khấu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 26/05/2005 by Nguyen Van Nhan
---- 
---- Modified on 20/01/2012 by Le Thi Thu Hien : Sua dieu kien CONVERT theo ngay
---- Modified by on 16/10/2012 by Lê Thị Thu Hiền : Bổ sung thêm strDivisionID
---- Modified on 19/06/2017 by Phương Thảo: Sửa danh mục dùng chung
-- <Example>
---- 
----- EXEC AP3133 @DivisionID=N'AS',@FromObjectID=N'243355677',@ToObjectID=N'SZ.0001',@IsGroupID=0,@GroupID=N'O02',@IsDetail=1,@TypeOfTime=0,@FromDate='2011-10-16 00:00:00',@ToDate='2012-10-16 00:00:00',@FromMonth=4,@FromYear=2012,@ToMonth=4,@ToYear=2012

CREATE PROCEDURE [dbo].[AP3133] 
    @DivisionID AS NVARCHAR(50), 
    @FromObjectID AS NVARCHAR(50), 
    @ToObjectID AS NVARCHAR(50), 
    @IsGroupID AS TINYINT, 
    @GroupID NVARCHAR(50), 
    @IsDetail AS TINYINT, 
    @TypeOfTime AS TINYINT, --- 0 Theo ngay Dao han; 1 Theo ngay hach toan; 2 Theo thang
    @FromDate AS DATETIME, 
    @ToDate AS DATETIME, 
    @FromMonth AS INT, 
    @FromYear AS INT, 
    @ToMonth AS INT, 
    @ToYear AS INT,
    @StrDivisionID AS NVARCHAR(4000) = ''
AS

DECLARE 
    @sSQL AS NVARCHAR(4000), 
    @GroupField AS NVARCHAR(50), 
    @FromDateText AS NVARCHAR(20),
    @ToDateText AS NVARCHAR(20),
    @FromMonthYearText AS NVARCHAR(40),
    @ToMonthYearText AS NVARCHAR(40),
    @Time AS NVARCHAR(4000),
    @StrDivisionID_New AS NVARCHAR(4000)


SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END

IF @IsGroupID = 1
    EXEC AP4700 @GroupID, @GroupField Output
ELSE 
    BEGIN 
        SET @GroupID = ''
        SET @GroupField = ''
    END 

------------------ Xac dinh kieu kien thoi gian:
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59'
SET @FromMonthYearText = STR(@FromMonth) + ' + 100 * ' + STR(@FromYear)
SET @ToMonthYearText = STR(@ToMonth) + ' + 100 * ' + STR(@ToYear)

---- Ngay Dao han
IF @TypeOfTime = 0  SET @Time = ' CONVERT(DATETIME,CONVERT(VARCHAR(10),T31.DueDate,101),101) BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''' '

---- Ngay Hach toan
ELSE IF @TypeOfTime = 1 SET @Time = ' CONVERT(DATETIME,CONVERT(VARCHAR(10),T31.VoucherDate,101),101) BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''' '

----- Theo ky
ELSE SET @Time = ' T31.CalMonth + 100 * T31.CalYear BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText + ' '

IF @IsGroupID = 1
    SET @sSQL = '
    SELECT 	T31.' + @GroupField + ' AS GroupID, 
			V6.SelectionName AS GroupName, 
			T31.DivisionID, 
			TranMonth, 
			TranYear, 
			T31.ObjectID, 
			T31.ObjectName, 
			ConvertedAmount, 
			OriginalAmount, 
			SUM(GiveOriginalAmount) AS GiveOriginalAmount, 
			SUM(GiveConvertedAmount) AS GiveConvertedAmount, 
			(OriginalAmount - SUM(GiveOriginalAmount)) AS RemainOriginalAmount, 
			(ConvertedAmount - SUM(GiveConvertedAmount)) AS RemainConvertedAmount, 
			SUM(BonusAmount) AS BonusAmount, 
			SUM(InterestAmount) AS InterestAmount, 
			VoucherNo, 
			VoucherDate, 
			InvoiceNo,
			InvoiceDate,
			Serial,
			DueDate, 
			Ana01ID,
			Ana02ID 
    FROM	AV3131 T31 
    LEFT JOIN AV6666 V6 ON V6.SelectionType = ''' + @GroupID + ''' 
			AND V6.SelectionID = T31.' + @GroupField + ' 
            AND V6.DivisionID in (T31.DivisionID,''@@@'')
    WHERE	T31.DivisionID '+@StrDivisionID_New+'
    '
ELSE
    SET @sSQL = '
    SELECT  '''' AS GroupID, 
        '''' AS GroupName, 
        T31.DivisionID, 
        TranMonth, 
        TranYear, 
        T31.ObjectID, 
        T31.ObjectName, 
        ConvertedAmount, 
        OriginalAmount, 
        SUM(GiveOriginalAmount) AS GiveOriginalAmount, 
        SUM(GiveConvertedAmount) AS GiveConvertedAmount, 
        (OriginalAmount - SUM(GiveOriginalAmount)) AS RemainOriginalAmount, 
        (ConvertedAmount - SUM(GiveConvertedAmount) ) AS RemainConvertedAmount, 
        SUM(BonusAmount) AS BonusAmount, 
        SUM(InterestAmount) AS InterestAmount, 
        VoucherNo, 
        VoucherDate, 
        InvoiceNo, 
        InvoiceDate, 
        Serial, 
        DueDate, 
        Ana01ID, 
        Ana02ID 
    FROM AV3131 T31 
    WHERE T31.DivisionID '+@StrDivisionID_New+' '

SET @sSQL = @sSQL + '
    AND T31.ObjectID BETWEEN ''' + @FromObjectID + ''' 
    AND ''' + @ToObjectID + ''' 
    AND ' + @Time + ' 
    GROUP BY T31.DivisionID, TranMonth, TranYear, T31.ObjectID, T31.ObjectName, ConvertedAmount, 
    OriginalAmount, VoucherNo, VoucherDate, InvoiceNo, InvoiceDate, Serial, DueDate, Ana01ID, Ana02ID 
'
IF @IsGroupID = 1
    SET @sSQL = @sSQL + ', T31.' + @GroupField + ', V6.SelectionName '

--PRINT @sSQL

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE SYSOBJECTS.NAME = 'AV3133' AND SYSOBJECTS.XTYPE = 'V')
    EXEC ('CREATE VIEW AV3133 --Tao boi AP3133
        AS ' + @sSQL )
ELSE
    EXEC ('ALTER VIEW AV3133 --Tao boi AP3133
        AS ' + @sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

