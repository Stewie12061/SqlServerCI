IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1503]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP1503]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Loc danh sach TSCD
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Nguyen Van Nhan, Date 24/09/2003
---- Edited by: Nguyen Quoc Huy, Date: 04/04/2007
---- Edit Tuyen, date: 25/01/2010, Lay them truong IsInherit
---- Edit Tuyen, date:05/02/2009, 
---- Edited by: [GS] [Việt Khánh] [29/07/2010]
---- Modified on 03/02/2012 by Nguyễn Bình Minh : Bổ sung thông tin mã bộ hệ số phân bổ (CoefficientID, UseCofficientID)
---- Modifile on 04/07/2013 by Khanh Van: Lay them truong ten nhom TSCD
---- Modifile on 03/04/2018 by Bảo Anh: Bổ sung các cột Mã chi phí SXC
---- Modifile on 05/07/2022 by Xuân Nguyên: Sửa cách lấy AccuDepAmount
---- Modifile on 18/07/2022 by Kiều Nga: Lỗi mã phân tích tại danh mục tài sản cố định
CREATE PROCEDURE [dbo].[AP1503]
(
    @DivisionID NVARCHAR(50), 
    @TranMonth INT, 
    @TranYear INT,
    @TangibleName0 NVARCHAR(50) = N'Hữu hình',
    @TangibleName1 NVARCHAR(50) = N'Vô hình',
    @AssetStatus0 NVARCHAR(50) = N'Đang sử dụng',
    @AssetStatus1 NVARCHAR(50) = N'Ngưng khấu hao',
    @AssetStatus2 NVARCHAR(50) = N'Nhựng bán',
    @AssetStatus3 NVARCHAR(50) = N'Đã thanh lý',
    @AssetStatus4 NVARCHAR(50) = N'Chưa sử dụng',
    @AssetStatus5 NVARCHAR(50) = N'Khác'
)    
AS

DECLARE 
    @sSQL1 NVARCHAR(4000),
    @sSQL2 NVARCHAR(4000),
    @sSQL3 NVARCHAR(4000)

SET @sSQL1 = '
    SELECT DivisionID, 
        AT1503.AssetID, 
        S1, 
        S2, 
        S3, 
        AssetName, 
        CountryID, 
        AT1503.AssetGroupID, 
        (Select AssetGroupName from AT1501 where AT1501.DivisionID=AT1503.DivisionID and AT1501.AssetGroupID= AT1503.AssetGroupID)as  AssetGroupName, 
        StartDate, 
        EndDate, 
        EstablishDate, 
        SerialNo, 
        InvoiceNo, 
        InvoiceDate, 
        SourceID1, 
        SourceAmount1, 
        SourcePercent1, 
        SourceID2, 
        SourceAmount2, 
        SourcePercent2, 
        SourceID3, 
        SourceAmount3, 
        SourcePercent3, 
        DebitDepAccountID1, 
        DepPercent1, 
        DebitDepAccountID2, 
        DepPercent2, 
        DebitDepAccountID3, 
        DepPercent3, 
        DebitDepAccountID4, 
        DepPercent4, 
        DebitDepAccountID5, 
        DepPercent5, 
        DebitDepAccountID6, 
        DepPercent6, 
        IsTangible, 
		Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,Parameter06,
		Parameter07,Parameter08,Parameter09,Parameter10,Parameter11,Parameter12,Parameter13,Parameter14,
		Parameter15,Parameter16,Parameter17,Parameter18,Parameter19,Parameter20,
        (CASE WHEN IsTangible = 1 THEN N''' + @TangibleName0 + ''' ELSE N''' + @TangibleName1 + ''' END) AS TangibleName, 
        MadeYear, 
        Serial, 
        (CASE WHEN EXISTS 
            (SELECT TOP 1 AssetID 
             FROM AT1506 
             WHERE AssetID = AT1503.AssetID 
                AND DivisionID = AT1503.DivisionID
                AND AT1506.TranMonth + 100 * AT1506.TranYear < = ' + STR(@TranMonth) + ' + ' + STR(@TranYear) + ' * 100)
             THEN (SELECT TOP 1 AT1506.ConvertedNewAmount 
                   FROM AT1506 
                   WHERE AT1506.AssetID = AT1503.AssetID 
                       AND AT1506.DivisionID = AT1503.DivisionID
                       AND AT1506.TranMonth + 100 * AT1506.TranYear < = ' + STR(@TranMonth) + ' + ' + STR(@TranYear) + ' * 100 
                   ORDER BY AT1506.TranYear DESC, AT1506.TranMonth DESC)
             ELSE AT1503.ConvertedAmount END) AS ConvertedAmount, 
        --DepAmount, 
        (CASE WHEN EXISTS 
            (SELECT TOP 1 AssetID 
             FROM AT1506 
             WHERE AssetID = AT1503.AssetID 
                AND DivisionID = AT1503.DivisionID
                AND AT1506.TranMonth + 100 * AT1506.TranYear < = ' + STR(@TranMonth) + ' + ' + STR(@TranYear) + ' * 100)
             THEN (SELECT TOP 1 AT1506.DepNewAmount FROM AT1506 
                   WHERE AT1506.AssetID = AT1503.AssetID 
                       AND AT1506.DivisionID = AT1503.DivisionID
                       AND AT1506.TranMonth + 100 * AT1506.TranYear < = ' + STR(@TranMonth) + ' + ' + STR(@TranYear) + ' * 100 
                   ORDER BY AT1506.TranYear DESC, AT1506.TranMonth DESC)
             ELSE AT1503.DepAmount END) AS DepAmount, 
        Isnull(AccuDepAmount,0) as AccuDepAmount, 
        ResidualValue, --- Giaù tri con lai ban dau
'
SET @sSQL2 = '
        --DepPercent, 
        (CASE WHEN EXISTS 
            (SELECT TOP 1 AssetID 
             FROM AT1506 
             WHERE AssetID = AT1503.AssetID 
                 AND DivisionID = AT1503.DivisionID
                 AND AT1506.TranMonth + 100 * AT1506.TranYear < = ' + STR(@TranMonth) + ' + ' + STR(@TranYear) + ' * 100)
             THEN (SELECT TOP 1 AT1506.DepNewPercent 
                   FROM AT1506 
                   WHERE AT1506.AssetID = AT1503.AssetID 
                       AND AT1506.DivisionID = AT1503.DivisionID
                       AND AT1506.TranMonth + 100 * AT1506.TranYear < = ' + STR(@TranMonth) + ' + ' + STR(@TranYear) + ' * 100 
                   ORDER BY AT1506.TranYear DESC, AT1506.TranMonth DESC)
             ELSE AT1503.DepPercent END) AS DepPercent, 
        --Years, 
        (CASE WHEN EXISTS 
            (SELECT TOP 1 AssetID 
             FROM AT1506 
             WHERE AssetID = AT1503.AssetID 
                 AND DivisionID = AT1503.DivisionID
                 AND AT1506.TranMonth + 100 * AT1506.TranYear < = ' + STR(@TranMonth) + ' + ' + STR(@TranYear) + ' * 100)
             THEN (SELECT TOP 1 AT1506.DepNewPeriods / 12 
                   FROM AT1506 
                   WHERE AT1506.AssetID = AT1503.AssetID 
                       AND AT1506.DivisionID = AT1503.DivisionID
                       AND AT1506.TranMonth + 100 * AT1506.TranYear < = ' + STR(@TranMonth) + ' + ' + STR(@TranYear) + ' * 100 
                   ORDER BY AT1506.TranYear DESC, AT1506.TranMonth DESC)
             ELSE AT1503.Years END) AS Years, 
        AssetAccountID, 
        DepAccountID, 
        BeginMonth, 
        BeginYear, 
        DepartmentID, 
        EmployeeID, 
        ParentAssetID, 
        MethodID, 
        CauseID, 
        --DepPeriods, 
        (CASE WHEN EXISTS 
            (SELECT TOP 1 AssetID 
             FROM AT1506 
             WHERE AssetID = AT1503.AssetID 
                 AND DivisionID = AT1503.DivisionID
                 AND AT1506.TranMonth + 100 * AT1506.TranYear < = ' + STR(@TranMonth) + ' + ' + STR(@TranYear) + ' * 100)
             THEN (SELECT TOP 1 AT1506.DepNewPeriods 
                   FROM AT1506 
                   WHERE AT1506.AssetID = AT1503.AssetID 
                       AND AT1506.DivisionID = AT1503.DivisionID
                       AND AT1506.TranMonth + 100 * AT1506.TranYear < = ' + STR(@TranMonth) + ' + ' + STR(@TranYear) + ' * 100 
                   ORDER BY AT1506.TranYear DESC, AT1506.TranMonth DESC)
             ELSE AT1503.DepPeriods END) AS DepPeriods, 
        DepMonths, 
        Notes, 
'
SET @sSQL3 = '
        (CASE WHEN BeginMonth < 10 THEN ''0'' ELSE '''' END) + LTRIM(RTRIM(STR(BeginMonth))) + ''/'' + LTRIM(RTRIM(STR(BeginYear))) AS BeginMonthYear, 
        CASE WHEN EXISTS 
            (SELECT TOP 1 AssetID 
             FROM AT1506 
             WHERE AssetID = AT1503.AssetID 
                AND DivisionID = AT1503.DivisionID
                AND AT1506.TranMonth + 100 * AT1506.TranYear < = ' + STR(@TranMonth) + ' + ' + STR(@TranYear) + ' * 100) 
             THEN 1 
        ELSE CASE WHEN EXISTS 
                (SELECT TOP 1 AssetID 
                 FROM AT1504 
                 WHERE AssetID = AT1503.AssetID 
                     AND DivisionID = AT1503.DivisionID)
                 THEN 1 
             ELSE 0 
         END END AS IsLock, 
        Ana01ID1, Ana02ID1, Ana03ID1, Ana04ID1, Ana05ID1,Ana06ID1,Ana07ID1,Ana08ID1,Ana09ID1,Ana10ID1,
        Ana01ID2, Ana02ID2, Ana03ID2, Ana04ID2, Ana05ID2,Ana06ID2,Ana07ID2,Ana08ID2,Ana09ID2,Ana10ID2,
        Ana01ID3, Ana02ID3, Ana03ID3, Ana04ID3, Ana05ID3,Ana06ID3,Ana07ID3,Ana08ID3,Ana09ID3,Ana10ID3,
        Ana01ID4, Ana02ID4, Ana03ID4, Ana04ID4, Ana05ID4,Ana06ID4,Ana07ID4,Ana08ID4,Ana09ID4,Ana10ID4,
        Ana01ID5, Ana02ID5, Ana03ID5, Ana04ID5, Ana05ID5,Ana06ID5,Ana07ID5,Ana08ID5,Ana09ID5,Ana10ID5,
        Ana01ID6, Ana02ID6, Ana03ID6, Ana04ID6, Ana05ID6,Ana06ID6,Ana07ID6,Ana08ID6,Ana09ID6,Ana10ID6,
  ---      Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,Parameter06,Parameter07,Parameter08,Parameter09,Parameter10, Parameter11,Parameter12,Parameter13,Parameter14,Parameter15,Parameter16,Parameter17,Parameter18,Parameter19,Parameter20,
        AssetStatus, 
        (CASE WHEN AssetStatus = 0 THEN N''' + @AssetStatus0 + '''
             ELSE CASE WHEN AssetStatus = 1 THEN N''' + @AssetStatus1 + ''' 
             ELSE CASE WHEN AssetStatus = 2 THEN N''' + @AssetStatus2 + ''' 
             ELSE CASE WHEN AssetStatus = 3 THEN N''' + @AssetStatus3 + '''
             ELSE CASE WHEN AssetStatus = 4 THEN N''' + @AssetStatus4 + '''
             ELSE N''' + @AssetStatus5 + '''
         END END END END END) AS AssetStatusName, 
        PeriodID01, 
        PeriodID02, 
        PeriodID03, 
        PeriodID04, 
        PeriodID05, 
        PeriodID06, 
        AT1503.IsInherist,
        CoefficientID,
		UseCofficientID, CreateUserID,
		MaterialTypeID01, MaterialTypeID02, MaterialTypeID03, MaterialTypeID04, MaterialTypeID05, MaterialTypeID06
    FROM AT1503 
	LEFT join (SELECT SUM(DepAmount) as AccuDepAmount , AssetID
             FROM AT1504 With(NOLOCK)
             WHERE TranMonth + TranYear * 100 < =  ' + STR(@TranMonth) + ' + ' + STR(@TranYear) + ' * 100 group by AssetID) g on AT1503.AssetID = g.AssetID
    WHERE DivisionID = ''' + @DivisionID + '''
'

---PRINT @sSQL

IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Name = 'AV1503')
    EXEC ('CREATE VIEW AV1503 AS ' + @sSQL1 + @sSQL2 + @sSQL3)
ELSE
    EXEC('ALTER VIEW AV1503 AS ' + @sSQL1 + @sSQL2 + @sSQL3)
