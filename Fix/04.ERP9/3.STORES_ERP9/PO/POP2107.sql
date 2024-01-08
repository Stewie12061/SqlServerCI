IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2107]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2107]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load detail cho màn hình POF2104 - kế thừa thông tin vận chuyển
-- <History>
---- Create on 21/12/2023 by Lê Thanh Lượng 
-- <Example>
/*
POP2107 @DivisionID = 'VG', @FromMonth = 11, @FromYear = 2023, @ToMonth = 11, @ToYear = 2023, 
       @FromDate = '2023-11-02 14:39:51.283', @ToDate = '2023-12-02 14:39:51.283', @IsDate = 0, 
       @ObjectID = '%', @SOVoucherID = 'TV20140000000002'  
 */
 
CREATE PROCEDURE [dbo].[POP2107]	
	@DivisionID NVARCHAR(50),
	@VoucherIDList NVARCHAR(MAX),
	@BillOfLadingNo NVARCHAR(MAX),
	@Mode INT = 0,
	@PageNumber INT = 1,
	@PageSize INT = 25,
	@ScreenID VARCHAR(50) = ''
AS
DECLARE @sSQL1 NVARCHAR(MAX),

		@Parameters NVARCHAR(MAX) = '',
		@OrderBy NVARCHAR(MAX) = N''

	SET @OrderBy = N'O.InventoryID'
	SET @sSQL1 = N'
		SELECT 
		  OT3008.DivisionID
		, OT3007.VoucherNO
		, OT3001.ObjectID
		, OT3001.ObjectName
		, AT1302.InventoryID
		, AT1302.InventoryName
		, AT1302.UnitID
		, AT1304.UnitName
		, OT3008.OrderQuantity
		, OT3008.PurchasePrice	
		, OT3008.ContQuantity
		, OT3008.TransactionID
		, SUM(ISNULL(WT96.ActualQuantity, 0)) AS InheritQuantity
		, ISNULL(OT3008.OrderQuantity,0) - SUM(ISNULL(WT96.ActualQuantity, 0)) AS RemainQuantity
		INTO #TempOT3008
		FROM OT3008 WITH (NOLOCK)	
		LEFT JOIN OT3007 WITH (NOLOCK) on  OT3007.BillOfLadingNo = OT3008.BillOfLadingNo	
		LEFT JOIN OT3001 WITH (NOLOCK) on  OT3001.POrderID = OT3007.POrderID
		LEFT JOIN AT1302 WITH (NOLOCK) on  OT3008.InventoryID = AT1302.InventoryID
		LEFT JOIN AT1304 WITH (NOLOCK) on  AT1304.UnitID = AT1302.UnitID
		LEFT JOIN AT1010 T10 WITH (NOLOCK) ON T10.VATGroupID = AT1302.VATGroupID 
		LEFT JOIN WT0096 WT96 WITH (NOLOCK) ON WT96.InheritTransactionID = OT3008.TransactionID AND WT96.InheritTableID = ''OT3007''
		WHERE OT3007.BillOfLadingNo = ''' + @BillOfLadingNo + '''		

		GROUP BY OT3001.ObjectID,OT3001.ObjectName
		,OT3008.DivisionID
		,OT3007.VoucherNO
		, AT1302.InventoryID
		, AT1302.InventoryName
		, AT1302.UnitID
		, AT1304.UnitName
		, OT3008.OrderQuantity
		, OT3008.PurchasePrice	
		, OT3008.ContQuantity
		, OT3008.TransactionID, WT96.ActualQuantity
		HAVING (ISNULL(OT3008.OrderQuantity,0) - SUM(ISNULL(WT96.ActualQuantity, 0))) > 0
		DECLARE @Count INT
		SELECT @Count = COUNT(InventoryID) FROM #TempOT3008

		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
			 , O.VoucherNO	as VoucherNo
			 , O.InventoryID
			 , O.InventoryName
			 , O.UnitID 
			 , O.UnitName 
			 , O.ObjectID 
			 , O.ObjectName
			 , O.InheritQuantity
			 , O.RemainQuantity
			 , O.OrderQuantity
			 , O.TransactionID
			 , O.PurchasePrice
		FROM #TempOT3008 O
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

			  

	EXEC(@sSQL1)
	PRINT(@sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
