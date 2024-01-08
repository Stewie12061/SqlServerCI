IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0425]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0425]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---- Created by Kiều Nga
---- Date 13/04/2022
---- Purpose: Lấy dữ liệu cho màn hình phân bổ
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE [dbo].[AP0425] 
    @DivisionID AS NVARCHAR(50),
    @FromMonth AS INT,
    @FromYear AS INT, 
    @ToMonth AS INT,
    @ToYear AS INT, 
    @D_C AS NVARCHAR(50)
AS

DECLARE @sSQL1 AS NVARCHAR(4000)

IF @D_C = 'D'
    BEGIN
        SET @sSQL1 =' 
        SELECT 
		AT0421.APK,AT0421.DivisionID,AT0421.JobID,AT0421.JobName,AT0421.SerialNo,AT0421.CreditAccountID,AT0421.DebitAccountID
		,AT0421.Periods,AT0421.APercent,AT0421.ConvertedAmount,AT0421.BeginMonth,AT0421.BeginYear,AT0421.TranMonth
		,AT0421.TranYear,AT0421.Description,AT0421.CreateDate,AT0421.CreateUserID,AT0421.LastModifyDate
		,AT0421.LastModifyUserID,AT0421.Ana01ID,AT0421.Ana02ID,AT0421.Ana03ID,AT0421.ObjectID,AT0421.VoucherNo
		,AT0421.VoucherID,AT0421.D_C,AT0421.UseStatus,AT0421.Ana04ID,AT0421.Ana05ID
		,(SELECT ISNULL(SUM(ISNULL(DepAmount,0)),0) FROM AT0422 T04 WHERE T04.DivisionID = AT0421.DivisionID AND T04.JobID = AT0421.JobID) AS DepValue
		,(select count(*) from (Select distinct JobID, TranMonth, TranYear, DivisionID From AT0422 T04 Where T04.DivisionID = AT0421.DivisionID AND T04.JobID = AT0421.JobID) A) AS DepMonths
		,AT0421.ConvertedAmount - (ISNULL(AT0421.DepValue,0) + (SELECT ISNULL(SUM(ISNULL(DepAmount,0)),0) FROM AT0422 T04 WHERE T04.DivisionID = AT0421.DivisionID AND T04.JobID = AT0421.JobID)) AS ResidualValue
		,(AT0421.Periods - (Isnull(AT0421.DepMonths,0) + (select count(*) from (Select distinct JobID, TranMonth, TranYear, DivisionID From AT0422 T04 Where T04.DivisionID = AT0421.DivisionID AND T04.JobID = AT0421.JobID) A))) As ResidualMonths
		,AT0421.InvoiceNo,AT0421.InvoiceDate,AT0421.TransactionID,AT0421.PeriodID
		,AT0421.ApportionAmount,AT0421.IsMultiAccount,AT0421.Ana06ID,AT0421.Ana07ID,AT0421.Ana08ID,AT0421.Ana09ID,AT0421.Ana10ID
		,AT0421.BeginDate,AT0421.SignDate,AT0421.InheritTableID,AT0421.ContractNo,AT0421.FirstMonthValue,
        AT1202.ObjectName,
        AT0421.ApportionAmount AS ConvertedUnit,
        CASE AT0421.UseStatus 
            WHEN 0 THEN ''AFML000179'' 
            WHEN 1 THEN ''AFML000180'' 
            WHEN 8 THEN ''AFML000181'' 
                   ELSE ''AFML000182'' END AS IsStop,
        --CAST(AT0421.BeginMonth AS NVARCHAR) + ''/'' + CAST(AT0421.BeginYear AS NVARCHAR) AS MonthYearBegin,
		AT0421.BeginDate AS MonthYearBegin,
        CAST(AT0421.TranMonth AS NVARCHAR) + ''/'' + CAST(AT0421.TranYear AS NVARCHAR) AS MonthYear --,
        --AV1702.VDescription
        FROM AT0421
        LEFT JOIN AT1202 ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT0421.ObjectID
        --INNER JOIN AV1702 ON AV1702.DivisionID = AT0421.DivisionID AND AV1702.AccountID = AT0421.CreditAccountID AND AV1702.VoucherID = AT0421.VoucherID 
        WHERE AT0421.DivisionID = '''+ @DivisionID+ '''
        AND AT0421.D_C = ''D'' 
        AND AT0421.TranMonth + AT0421.TranYear * 12 BETWEEN ' + LTRIM(@FromMonth + @FromYear * 12) + ' AND ' + LTRIM(@ToMonth + @ToYear * 12)
    END
ELSE IF @D_C = 'C'
    BEGIN
        SET @sSQL1 =' 
        SELECT 
		AT0421.APK,AT0421.DivisionID,AT0421.JobID,AT0421.JobName,AT0421.SerialNo,AT0421.CreditAccountID,AT0421.DebitAccountID
		,AT0421.Periods,AT0421.APercent,AT0421.ConvertedAmount,AT0421.BeginMonth,AT0421.BeginYear,AT0421.TranMonth
		,AT0421.TranYear,AT0421.Description,AT0421.CreateDate,AT0421.CreateUserID,AT0421.LastModifyDate
		,AT0421.LastModifyUserID,AT0421.Ana01ID,AT0421.Ana02ID,AT0421.Ana03ID,AT0421.ObjectID,AT0421.VoucherNo
		,AT0421.VoucherID,AT0421.D_C,AT0421.UseStatus,AT0421.Ana04ID,AT0421.Ana05ID
		,(SELECT ISNULL(SUM(ISNULL(DepAmount,0)),0) FROM AT0422 T04 WHERE T04.DivisionID = AT0421.DivisionID AND T04.JobID = AT0421.JobID) AS DepValue
		,(select count(*) from (Select distinct JobID, TranMonth, TranYear, DivisionID From AT0422 T04 Where T04.DivisionID = AT0421.DivisionID AND T04.JobID = AT0421.JobID) A) AS DepMonths
		,AT0421.ConvertedAmount - (ISNULL(AT0421.DepValue,0) + (SELECT ISNULL(SUM(ISNULL(DepAmount,0)),0) FROM AT0422 T04 WHERE T04.DivisionID = AT0421.DivisionID AND T04.JobID = AT0421.JobID)) AS ResidualValue
		,(AT0421.Periods - (Isnull(AT0421.DepMonths,0) + (select count(*) from (Select distinct JobID, TranMonth, TranYear, DivisionID From AT0422 T04 Where T04.DivisionID = AT0421.DivisionID AND T04.JobID = AT0421.JobID) A))) As ResidualMonths
		,AT0421.InvoiceNo,AT0421.InvoiceDate,AT0421.TransactionID,AT0421.PeriodID
		,AT0421.ApportionAmount,AT0421.IsMultiAccount,AT0421.Ana06ID,AT0421.Ana07ID,AT0421.Ana08ID,AT0421.Ana09ID,AT0421.Ana10ID
		,AT0421.BeginDate,AT0421.SignDate,AT0421.InheritTableID,AT0421.ContractNo,AT0421.FirstMonthValue,
        AT1202.ObjectName,
        AT0421.ApportionAmount AS ConvertedUnit,
        CASE AT0421.UseStatus 
            WHEN 0 THEN ''AFML000179'' 
            WHEN 1 THEN ''AFML000180'' 
            WHEN 8 THEN ''AFML000181'' 
                   ELSE ''AFML000182'' END AS IsStop,
        --CAST(AT0421.BeginMonth AS NVARCHAR) + ''/'' + CAST(AT0421.BeginYear AS NVARCHAR) AS MonthYearBegin,
		AT0421.BeginDate AS MonthYearBegin,
        CAST(AT0421.TranMonth AS NVARCHAR) + ''/'' + CAST(AT0421.TranYear AS NVARCHAR) AS MonthYear --,
        --AV1702.VDescription
        FROM AT0421
        LEFT JOIN AT1202 ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT0421.ObjectID
        --INNER JOIN AV1702 ON AV1702.DivisionID = AT0421.DivisionID AND AV1702.AccountID = AT0421.DebitAccountID AND AV1702.VoucherID = AT0421.VoucherID 
        WHERE AT0421.DivisionID = '''+ @DivisionID+ '''
        AND AT0421.D_C = ''C'' 
        AND AT0421.TranMonth + AT0421.TranYear * 12 BETWEEN ' + LTRIM(@FromMonth + @FromYear * 12) + ' AND ' + LTRIM(@ToMonth + @ToYear * 12)
    END
	--PRINT @sSQL1
IF NOT EXISTS (SELECT 1 FROM SysObjects WHERE Xtype ='V' AND Name = 'AV1705_SK')
    EXEC('CREATE VIEW AV1705_SK --tao boi AP0425
        AS '+@sSQL1)
ELSE
    EXEC('ALTER VIEW AV1705_SK --- tao boi AP0425
        AS '+@sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
