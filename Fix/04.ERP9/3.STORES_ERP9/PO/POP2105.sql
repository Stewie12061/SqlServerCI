IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2105]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2105]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Master cho màn hình POF2103 - kế thừa tiến độ nhận hàng
-- <History>
---- Create on 21/09/2023 by Lê Thanh Lượng 
---- Modify by: Thanh Nguyên on 13/11/2023 - Cập nhật : [2023/11/RS/0001] - Bổ sung lấy số PO
-- <Example>
/*
POP2105 @DivisionID = 'VG', @FromMonth = 11, @FromYear = 2023, @ToMonth = 11, @ToYear = 2023, 
       @FromDate = '2023-11-02 14:39:51.283', @ToDate = '2023-12-02 14:39:51.283', @IsDate = 0, 
       @ObjectID = '%', @SOVoucherID = 'TV20140000000002'  
 */
 
CREATE PROCEDURE [dbo].[POP2105]	
	@DivisionID NVARCHAR(50),
	@VoucherIDList NVARCHAR(MAX),
	@POrderID NVARCHAR(MAX),
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
		SELECT O4.VoucherNO
			 , O.InventoryID
			 , ''OT3003'' AS TableID
			 , O.POrderID
			 , O.TransactionID
			 , A1.InventoryName
			 , O.UnitID 
			 , O4.ObjectID 
			 , A1.Specification
			 , O.OrderQuantity
			 , O.ConvertedQuantity
			 , SUM(ISNULL(Q01.QuantityInherit, 0)) AS InheritQuantity
			 , ISNULL(O.OrderQuantity,0) - SUM(ISNULL(Q01.QuantityInherit, 0)) AS RemainQuantity
			 , O.PONumber
		INTO #TempOT3002
		FROM OT3002 O WITH (NOLOCK)
			LEFT JOIN OT3003 O1 ON CONVERT(NVARCHAR(50), O1.APK) = O.POrderID
			LEFT JOIN AT1302 A1 ON A1.InventoryID = O.InventoryID
			LEFT JOIN (
				SELECT A3.InventoryID, A3.OTransactionID AS InheritTransactionID, A3.ActualQuantity
				FROM AT2007 A3 WITH(NOLOCK) 
					LEFT JOIN AT2006 A4 WITH(NOLOCK) ON A4.VoucherID = A3.VoucherID
				WHERE A4.KindVoucherID IN (2,4,6)
			) AS A3 on O.InventoryID = A3.InventoryID AND O.TransactionID = A3.InheritTransactionID
			LEFT JOIN OT8899 O2 WITH(NOLOCK) ON O2.TransactionID = O.TransactionID
			LEFT JOIN OT3001 O3 WITH(NOLOCK) ON O3.POrderID = O.POrderID			
			LEFT JOIN OT3003 O4 WITH(NOLOCK) ON O4.POrderID = O3.POrderID
			LEFT JOIN QCT2001 Q01 WITH (NOLOCK) ON Q01.InheritTransaction = O.TransactionID AND Q01.InheritTable = ''OT3003''
			AND Q01.DivisionID = O.DivisionID
		WHERE O3.VoucherNO = ''' + @POrderID + '''		

		GROUP BY O.POrderID, O.TransactionID , O.InventoryID
		, O4.VoucherNo, A1.InventoryName, O.UnitID, O4.ObjectID 
		, O.ConvertedQuantity, O.OrderQuantity,A1.Specification, O.PONumber
		DECLARE @Count INT
		SELECT @Count = COUNT(InventoryID) FROM #TempOT3002

		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
			 , O.VoucherNO	as VoucherNo
			 , O.InventoryID
			 , O.InventoryName
			 , O.UnitID 
			 , O.ObjectID 
			 , O.Specification
			 , O.InheritQuantity
			 , O.RemainQuantity
			 , O.OrderQuantity
			 , O.ConvertedQuantity
			 , O.TransactionID
			 , O.PONumber
		FROM #TempOT3002 O
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
