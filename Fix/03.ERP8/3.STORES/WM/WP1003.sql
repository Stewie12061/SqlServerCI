IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP1003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP1003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Truy vấn lịch sử Pallet
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by Huỳnh Thử on 27/03/2020
---- Modified by 
---- 
---- Modified on by 
-- <Example>
/*
        EXEC WP1003 @DivisionID='',@FromMonth='',@FromYear='',@ToMonth='',@ToYear='',@FromDate='',@ToDate='',@IsDate=''
*/

CREATE PROCEDURE [WP1003]
    @DivisionID NVARCHAR(50),
    @FromMonth AS INT,
    @FromYear AS INT,
    @ToMonth AS INT,
    @ToYear AS INT,
    @FromDate AS DATETIME,
    @ToDate AS DATETIME,
    @IsDate AS TINYINT
AS
DECLARE @sSQL NVARCHAR(MAX),
        @sWhere AS NVARCHAR(MAX)
IF @IsDate = 0
BEGIN
    SET @sWhere
        = ' AND (WT2005.TranMonth + WT2005.TranYear * 100 BETWEEN ' + STR(@FromMonth + @FromYear * 100) + ' AND '
          + STR(@ToMonth + @ToYear * 100) + ')';
END;
IF @IsDate = 1
BEGIN
    SET @sWhere
        = ' AND (CONVERT(VARCHAR, WT2005.VoucherDate,112) BETWEEN ' + CONVERT(VARCHAR, @FromDate, 112) + ' AND '
          + CONVERT(VARCHAR, @ToDate, 112) + ' ) ';
END;
SET @sSQL
    = N'
		Select  WT2001.APK,WT2005.*,CASE WHEN WT2003.IsOutStock = 1 THEN 0 ELSE 1 END AS IsOutStock 
		FROM WT2005
		LEFT JOIN WT2003 WITH (NOLOCK) ON WT2003.ReVoucherID = WT2005.VoucherID
		LEFT JOIN WT2001 WITH (NOLOCK) ON WT2001.VoucherID = WT2005.VoucherID
		Where WT2005.DivisionID = ''' + @DivisionID + '''
';
--print @sSQL
--print @sWhere
EXEC (@sSQL + @sWhere);

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
