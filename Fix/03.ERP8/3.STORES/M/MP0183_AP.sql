IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0183_AP]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0183_AP]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Tiểu Mai on 06/09/2016: Load số lượng đã sản xuất cho màn hình Kế hoạch sản xuất tháng MF0182 (AN PHÁT)

/*
 * exec MP0183_AP 'PC', '2016-01-26 00:00:00.000', 'CMNH-000001', 'TAVE-000001', 'PC', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''
 */


CREATE PROCEDURE [dbo].[MP0183_AP]
		@DivisionID NVARCHAR(50) ,
		@VoucherDate DATETIME,
		@ObjectID NVARCHAR(50),
		@InventoryID NVARCHAR(50),
		@UnitID NVARCHAR(50),
		@S01ID NVARCHAR(50),
		@S02ID NVARCHAR(50),
		@S03ID NVARCHAR(50),
		@S04ID NVARCHAR(50),
		@S05ID NVARCHAR(50),
		@S06ID NVARCHAR(50),
		@S07ID NVARCHAR(50),
		@S08ID NVARCHAR(50),
		@S09ID NVARCHAR(50),
		@S10ID NVARCHAR(50),
		@S11ID NVARCHAR(50),
		@S12ID NVARCHAR(50),
		@S13ID NVARCHAR(50),
		@S14ID NVARCHAR(50),
		@S15ID NVARCHAR(50),
		@S16ID NVARCHAR(50),
		@S17ID NVARCHAR(50),
		@S18ID NVARCHAR(50),
		@S19ID NVARCHAR(50),
		@S20ID NVARCHAR(50)
AS

	DECLARE @sSQL AS nvarchar(4000) ,
			@sSQL1 AS nvarchar(4000) 
			
SET @sSQL = '
	SELECT SUM(MT1001.Quantity) AS ReQuantity
	FROM MT0182 WITH (NOLOCK)
	LEFT JOIN MT0181 WITH (NOLOCK) ON MT0182.DivisionID = MT0181.DivisionID AND MT0182.VoucherID = MT0181.VoucherID
	LEFT JOIN MT2005 WITH (NOLOCK) ON MT2005.DivisionID = MT0182.DivisionID AND MT2005.InheritPlanMonthID = MT0182.VoucherID AND MT2005.PlanObjectID = MT0182.ObjectID2
										AND MT2005.InventoryID = MT0182.InventoryID
										AND MT2005.UnitID = MT0182.UnitID
	LEFT JOIN MT8899 WITH (NOLOCK) ON MT8899.DivisionID = MT2005.DivisionID AND MT8899.VoucherID = MT2005.VoucherID AND MT8899.TransactionID = MT2005.TransactionID AND MT8899.TableID = ''MT2005''
										AND Isnull(MT8899.S01ID,'''') = Isnull(MT0182.S01ID,'''')
										AND Isnull(MT8899.S02ID,'''') = Isnull(MT0182.S02ID,'''')
										AND Isnull(MT8899.S03ID,'''') = Isnull(MT0182.S03ID,'''')
										AND Isnull(MT8899.S04ID,'''') = Isnull(MT0182.S04ID,'''')
										AND Isnull(MT8899.S05ID,'''') = Isnull(MT0182.S05ID,'''')
										AND Isnull(MT8899.S06ID,'''') = Isnull(MT0182.S06ID,'''')
										AND Isnull(MT8899.S07ID,'''') = Isnull(MT0182.S07ID,'''')
										AND Isnull(MT8899.S08ID,'''') = Isnull(MT0182.S08ID,'''')
										AND Isnull(MT8899.S09ID,'''') = Isnull(MT0182.S09ID,'''')
										AND Isnull(MT8899.S10ID,'''') = Isnull(MT0182.S10ID,'''')	
										AND Isnull(MT8899.S11ID,'''') = Isnull(MT0182.S11ID,'''')
										AND Isnull(MT8899.S12ID,'''') = Isnull(MT0182.S12ID,'''')
										AND Isnull(MT8899.S13ID,'''') = Isnull(MT0182.S13ID,'''')
										AND Isnull(MT8899.S14ID,'''') = Isnull(MT0182.S14ID,'''')
										AND Isnull(MT8899.S15ID,'''') = Isnull(MT0182.S15ID,'''')
										AND Isnull(MT8899.S16ID,'''') = Isnull(MT0182.S16ID,'''')
										AND Isnull(MT8899.S17ID,'''') = Isnull(MT0182.S17ID,'''')
										AND Isnull(MT8899.S18ID,'''') = Isnull(MT0182.S18ID,'''')
										AND Isnull(MT8899.S19ID,'''') = Isnull(MT0182.S19ID,'''')
										AND Isnull(MT8899.S20ID,'''') = Isnull(MT0182.S20ID,'''')				
	LEFT JOIN MT1001 WITH (NOLOCK) ON MT1001.DivisionID = MT2005.DivisionID AND MT1001.InheritVoucherID = MT2005.VoucherID AND MT1001.InheritTransactionID = MT2005.TransactionID AND MT1001.InheritTableID = ''MT2004''
	LEFT JOIN MT8899 M89 WITH (NOLOCK) ON M89.DivisionID = MT1001.DivisionID AND M89.VoucherID = MT1001.VoucherID AND M89.TransactionID = MT1001.TransactionID
	'

SET @sSQL1 = '
	WHERE MT0182.DivisionID = '''+@DivisionID+'''
		AND Convert(Nvarchar(10),MT0181.VoucherDate,112) <= '+Convert(Nvarchar(10),@VoucherDate, 112)+'
		AND MT0182.ObjectID2 = '''+@ObjectID+'''
		AND MT0182.InventoryID = '''+@InventoryID+'''
		AND MT0182.UnitID = '''+@UnitID+'''
		AND Isnull(MT0182.S01ID,'''') = Isnull('''+@S01ID+''','''')
		AND Isnull(MT0182.S02ID,'''') = Isnull('''+@S02ID+''','''')
		AND Isnull(MT0182.S03ID,'''') = Isnull('''+@S03ID+''','''')
		AND Isnull(MT0182.S04ID,'''') = Isnull('''+@S04ID+''','''')
		AND Isnull(MT0182.S05ID,'''') = Isnull('''+@S05ID+''','''')
		AND Isnull(MT0182.S06ID,'''') = Isnull('''+@S06ID+''','''')
		AND Isnull(MT0182.S07ID,'''') = Isnull('''+@S07ID+''','''')
		AND Isnull(MT0182.S08ID,'''') = Isnull('''+@S08ID+''','''')
		AND Isnull(MT0182.S09ID,'''') = Isnull('''+@S09ID+''','''')
		AND Isnull(MT0182.S10ID,'''') = Isnull('''+@S10ID+''','''')
		AND Isnull(MT0182.S11ID,'''') = Isnull('''+@S11ID+''','''')
		AND Isnull(MT0182.S12ID,'''') = Isnull('''+@S12ID+''','''')
		AND Isnull(MT0182.S13ID,'''') = Isnull('''+@S13ID+''','''')
		AND Isnull(MT0182.S14ID,'''') = Isnull('''+@S14ID+''','''')
		AND Isnull(MT0182.S15ID,'''') = Isnull('''+@S15ID+''','''')
		AND Isnull(MT0182.S16ID,'''') = Isnull('''+@S16ID+''','''')
		AND Isnull(MT0182.S17ID,'''') = Isnull('''+@S17ID+''','''')
		AND Isnull(MT0182.S18ID,'''') = Isnull('''+@S18ID+''','''')
		AND Isnull(MT0182.S19ID,'''') = Isnull('''+@S19ID+''','''')
		AND Isnull(MT0182.S20ID,'''') = Isnull('''+@S20ID+''','''')
	GROUP BY MT1001.DivisionID, MT2005.PlanObjectID, MT1001.InventoryID, MT1001.UnitID, 
	M89.S01ID, M89.S02ID, M89.S03ID, M89.S04ID, M89.S05ID, M89.S06ID, M89.S07ID, M89.S08ID, M89.S09ID, M89.S10ID,
	M89.S11ID, M89.S12ID, M89.S13ID, M89.S14ID, M89.S15ID, M89.S16ID, M89.S17ID, M89.S18ID, M89.S19ID, M89.S20ID
	'

EXEC (@sSQL + @sSQL1 )
PRINT @sSQL
PRINT @sSQL1

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
