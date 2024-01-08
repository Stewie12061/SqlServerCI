IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0039]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0039]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In báo cáo sản lượng sản xuất
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 17/01/2017 by Phan Hải Long
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.

-- <Example>
---- 
CREATE PROCEDURE [dbo].[MP0039]
( 
	@DivisionID NVARCHAR(50),
	@FromPeriod INT,
	@ToPeriod INT,
	@FromDate DATETIME,
	@ToDate DATETIME,		
	@FromInventoryID NVARCHAR(50),
	@ToInventoryID NVARCHAR(50),
	@FromI03ID NVARCHAR(50),
	@ToI03ID NVARCHAR(50),		
	@FromTeamID NVARCHAR(50),
	@ToTeamID NVARCHAR(50),		
	@TimeMode TINYINT
)
AS 

SET NOCOUNT ON 

DECLARE @sSql NVARCHAR(MAX) = '',
		@sWhere NVARCHAR(MAX) = '',
		@TeamName NVARCHAR(4000) = ''


IF @TimeMode = 0
BEGIN
	SET @sWhere = @sWhere + '
	AND MT1801.TranMonth + MT1801.TranYear * 100 BETWEEN '+Convert(Nvarchar(10),@FromPeriod)+' AND '+CONVERT(NVARCHAR(10),@ToPeriod)										
END	
ELSE
BEGIN
	SET @sWhere = @sWhere + '
	AND MT1801.VoucherDate  BETWEEN '''+Convert(nvarchar(10),@FromDate,21)+''' AND '''+convert(nvarchar(10), @ToDate,21)+''''								
END	

IF @FromTeamID = @ToTeamID
BEGIN
	SELECT @TeamName = TeamName FROM HT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TeamID = @FromTeamID
END
ELSE
BEGIN
	SELECT @TeamName = N'Từ ' + TeamName + N' - ' FROM HT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TeamID = @FromTeamID
	SELECT @TeamName = @TeamName + N'Đến ' + TeamName FROM HT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TeamID = @ToTeamID
END

--PRINT @TeamName

SET @sSQL = '
	SELECT MT1802.ProductID, AT1302.InventoryName AS ProductName, AT1302.I07ID, AT1015.AnaName AS Ana07Name, MT1802.ProductUnitID, AT1304.UnitName AS ProductUnitName,
	MT1801.TeamID, N''' + @TeamName + ''' AS TeamName, MT1802.Shift, HT1020.ShiftName, MT1801.VoucherDate, MT1801.ProductDate, MT1801.VoucherNo,
	SUM(ISNULL(MT1802.ActualQuantity, 0)) as ActualQuantity, SUM(ISNULL(MT1802.ErrorQuantity, 0)) as ErrorQuantity 
	FROM MT1802 WITH (NOLOCK)
	INNER JOIN MT1801 WITH (NOLOCK) ON MT1801.DivisionID = MT1802.DivisionID AND MT1801.VoucherID = MT1802.VoucherID
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT1304.UnitID = MT1802.ProductUnitID
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = MT1802.ProductID AND AT1302.DivisionID IN (MT1802.DivisionID,''@@@'')
	LEFT JOIN HT1020 WITH (NOLOCK) ON HT1020.DivisionID = MT1802.DivisionID AND HT1020.ShiftID = MT1802.Shift
	LEFT JOIN AT1015 WITH (NOLOCK) ON AT1015.AnaID = AT1302.I07ID AND AT1015.AnaTypeID = ''I07'' AND AT1302.DivisionID IN (AT1015.DivisionID,''@@@'')
	WHERE MT1801.DivisionID = ''' + @DivisionID + '''
	AND MT1802.ProductID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + '''
	AND AT1302.I03ID BETWEEN ''' + @FromI03ID + ''' AND ''' + @ToI03ID + '''
	AND MT1801.TeamID BETWEEN ''' + @FromTeamID + ''' AND ''' + @ToTeamID + '''
	AND (MT1802.TypeTab = 2 OR MT1802.TypeTab = 3) ' + @sWhere + '
	GROUP BY MT1802.ProductID, AT1302.InventoryName, AT1302.I07ID, AT1015.AnaName, MT1802.ProductUnitID, AT1304.UnitName,
	MT1801.TeamID, MT1802.Shift, HT1020.ShiftName, MT1801.VoucherDate, MT1801.ProductDate, MT1801.VoucherNo
'

EXEC(@sSQL)
PRINT @sSQL


SET NOCOUNT OFF

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO