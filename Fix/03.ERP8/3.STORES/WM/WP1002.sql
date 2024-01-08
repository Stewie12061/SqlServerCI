IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP1002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP1002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Danh mục lệnh xuất kho
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by Khánh Đoan on 21/09/2019
---- Modified by Huỳnh Thử  on 07/07/2020 -- Lấy thêm trường Nguyên tắc xuất
---- Modified by Huỳnh Thử on 15/07/2020 -- Bổ sung tình trạng đã xuất hoặc chưa
---- Modified by Huỳnh Thử on 12/10/2020 -- Bổ sung cột đã kế thừa
---- Modified by 
---- 
---- Modified on by 
-- <Example>
/*
        EXEC WP1002 @DivisionID='',@FromMonth='',@FromYear='',@ToMonth='',@ToYear='',@FromDate='',@ToDate='',@IsDate='',@WareHouseID='',@ObjectID='', @UserID=''
*/

CREATE PROCEDURE [WP1002]
    @DivisionID NVARCHAR(50),
    @FromMonth AS INT,
    @FromYear AS INT,
    @ToMonth AS INT,
    @ToYear AS INT,
    @FromDate AS DATETIME,
    @ToDate AS DATETIME,
    @IsDate AS TINYINT,
    @WareHouseID NVARCHAR(50),
    @ObjectID NVARCHAR(50),
    @UserID VARCHAR(50)
AS
DECLARE @sSQL NVARCHAR(MAX),
        @sWhere AS NVARCHAR(MAX)
IF @IsDate = 0
BEGIN
    SET @sWhere
        = ' AND (WT2001.TranMonth + WT2001.TranYear * 100 BETWEEN ' + STR(@FromMonth + @FromYear * 100) + ' AND '
          + STR(@ToMonth + @ToYear * 100) + ')';
END;
IF @IsDate = 1
BEGIN
    SET @sWhere
        = ' AND (CONVERT(VARCHAR, WT2001.VoucherDate,112) BETWEEN ' + CONVERT(VARCHAR, @FromDate, 112) + ' AND '
          + CONVERT(VARCHAR, @ToDate, 112) + ' ) ';
END;
SET @sSQL
    = N'
	SELECT  WT2001.APK, WT2001.VoucherTypeID, WT2001.VoucherDate, WT2001.VoucherNo,WT2001.WareHouseID ,
WT2001.Description, WT2001.ObjectID ,WT0095.VoucherNo AS ReVoucherNo,WT2001.VoucherID,
(CASE WHEN  ISNULL(SUM(WT2002.ActualQuantity), 0) - ISNULL(SUM(AT2007.ActualQuantity),0) = 0 THEN  N''Đã xuất kho''
	  WHEN  ISNULL(SUM(AT2007.ActualQuantity),0) = 0  THEN  N''Chưa xuất kho'' 
	  WHEN  ISNULL(SUM(WT2002.ActualQuantity), 0) <> ISNULL(SUM(AT2007.ActualQuantity),0) THEN N''Đang xuất kho'' ELSE N'''' END )AS tnxk,
(CASE WHEN  ISNULL(SUM(WT2002.ActualQuantity), 0) - ISNULL(SUM(AT2007.ActualQuantity),0) = 0 THEN  1
	  WHEN  ISNULL(SUM(AT2007.ActualQuantity),0) = 0  THEN  0
	  WHEN  ISNULL(SUM(WT2002.ActualQuantity), 0) <> ISNULL(SUM(AT2007.ActualQuantity),0) THEN 0 ELSE 0 END ) AS IsExport,
	  WT0095.TypeRule, ISNULL((SELECT TOP 1 1 FROM AT2007 WITH(NOLOCK) WHERE InheritVoucherID = WT2001.VoucherID), 0) AS IsInherit

FROM  WT2001 WITH (NOLOCK)
LEFT JOIN WT2002 WITH (NOLOCK) ON WT2002.VoucherID = WT2001.VoucherID
LEFT JOIN WT0095 WITH (NOLOCK) ON WT0095. VoucherID = WT2002.InheritVoucherID 
LEFT JOIN WT0096 WITH (NOLOCK) ON WT0096. TransactionID = WT2002.InheritTransactionID
LEFT JOIN AT2007 WITH (NOLOCK) ON AT2007.InheritTransactionID = WT2002.TransactionID 
LEFT JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.KindVoucherID = 2
Where WT2001.DivisionID = ''' + @DivisionID
      + '''
	AND WT2001.KindVoucherID = 2
	AND ISNULL(WT2001.WarehouseID,''%'') LIKE (''' + @WareHouseID + ''') AND 
	ISNULL(WT2001.ObjectID,''%'') LIKE (''' + @ObjectID + ''') 

';
print @sSQL
print @sWhere
EXEC (@sSQL + @sWhere + ' GROUP BY  WT2001.APK, WT2001.VoucherTypeID, WT2001.VoucherDate, WT2001.VoucherNo,WT2001.WareHouseID ,
WT2001.Description, WT2001.ObjectID ,WT0095.VoucherNo,WT2001.VoucherID,WT0095.TypeRule');

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
