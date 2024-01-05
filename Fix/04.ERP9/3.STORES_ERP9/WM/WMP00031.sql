IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP00031]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP00031]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created by Hoài Bảo
----- Created 25/07/2022
----- Purpose: Lấy dữ liệu tính giá xuất kho - Kế thừa từ store AP1330
----- Modified by ... on ...
/*
 EXEC WMP00031 @DivisionID=N'DTI',@TranMonth=N'4',@TranYear=N'2021',@FromInventoryID=N'02/2022/DTI/0001',@ToInventoryID=N'XIPHONG02',@FromWareHouseID=N'CK',@ToWareHouseID=N'KHO_A',@FromAccountID=N'152',@ToAccountID=N'158',@UserID=N'ASOFTADMIN',@GroupID=N'ADMIN',@TransProcessesID=N'',@IsAllWareHouse=0
*/

CREATE PROCEDURE  [dbo].[WMP00031]
		@DivisionID  AS nvarchar(50),
		@TranMonth AS nvarchar(50) , 
		@TranYear AS nvarchar(50),
		@FromInventory NVARCHAR(50) = '',
		@ToInventory NVARCHAR(50) = '',
		@WareHouseID NVARCHAR(MAX) = '',
		@UserID NVARCHAR(50) = '',
		@TransProcessesID NVARCHAR(50) = '',
		@IsAllWareHouse TINYINT = 0 -- Tính giá không phân biệt kho ( 1: check, 0: không check)

AS
DECLARE @sSQL NVARCHAR(MAX)  = N'',
		@sSQL1 NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@sWhere1 NVARCHAR(MAX) = N'',
		@sWhere2 NVARCHAR(MAX) = N'',
		@CustomerName INT
		
	--Tao bang tam de kiem tra day co phai la khach hang 
	CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
	INSERT #CustomerName EXEC AP4444
	SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName);

	IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND ISNULL(IsSpecificate,0) = 1)
		-- Thay thế store AP1330_QC
		EXEC WMP00031_QC @DivisionID, @TranMonth, @TranYear, @FromInventory, @ToInventory, @WareHouseID
	ELSE
	BEGIN
		IF @IsAllWareHouse = 1
			BEGIN
			SET @sSQL = N' --- Lấy số lượng phiếu nhập đầu kỳ + số lượng nhập kho + số lượng chuyển kho trong 1 kỳ
						SELECT InventoryID, SUM(ISNULL(ActualQuantity,0)) AS ActualQuantity, ''ALL'' AS WareHouseID FROM (
						SELECT CONCAT(InventoryID,InventoryAccountID) AS InventoryID,  BeginQuantity AS ActualQuantity
						FROM AT2008 WITH (NOLOCK)
						WHERE AT2008.DivisionID = '''+@DivisionID+''' AND (InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''') AND AT2008.TranMonth = '+@TranMonth+' AND AT2008.TranYear = '+@TranYear+'
							
						UNION ALL

						SELECT CONCAT(InventoryID,DebitAccountID) AS InventoryID,  SUM(AT2007.ActualQuantity) AS ActualQuantity
						FROM AT2007 WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID 
						WHERE AT2007.DivisionID = '''+@DivisionID+''' AND (InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''') AND AT2006.TranMonth = '+@TranMonth+' AND AT2006.TranYear = '+@TranYear+'
						AND KindVoucherID IN (1,5,7,9)
						GROUP BY AT2007.InventoryID,DebitAccountID
						) A   -- where ActualQuantity != 0
						GROUP BY  InventoryID
						HAVING SUM(ISNULL(ActualQuantity,0)) != 0
				
						-- CHuyển kho
						SELECT ''ALL'' AS WareHouseID2,''ALL'' AS WareHouseID , CONCAT(InventoryID,DebitAccountID) AS InventoryID, 0 AS ActualQuantity
						FROM AT2007 WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID 
						WHERE AT2007.DivisionID = '''+@DivisionID+''' AND (InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''') AND AT2006.TranMonth = '+@TranMonth+' AND AT2006.TranYear = '+@TranYear+'
						AND KindVoucherID = 3 
						AND ActualQuantity <> 0 
						GROUP BY AT2007.InventoryID,DebitAccountID
				
						--- Giá trị nhập kho + giá trị tồn
						SELECT InventoryID, ISNULL(SUM(Amount),0) AS Amount ,''ALL'' AS  WareHouseID INTO #Tranfer FROM (
						SELECT CONCAT(InventoryID,InventoryAccountID) AS InventoryID, BeginAmount AS Amount,'''' AS  WareHouseID
						FROM AT2008  WITH (NOLOCK)
						WHERE AT2008.DivisionID = '''+@DivisionID+''' AND (InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''') AND AT2008.TranMonth = '+@TranMonth+' AND AT2008.TranYear = '+@TranYear+'
						GROUP BY  WareHouseID, InventoryID,BeginAmount,InventoryAccountID
				
						UNION ALL

						SELECT CONCAT(AT2007.InventoryID,DebitAccountID), SUM(ConvertedAmount) AS Amount,'''' AS WareHouseID
						FROM AT2007 WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
						WHERE AT2007.DivisionID = '''+@DivisionID+''' AND (InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''') AND AT2006.TranMonth = '+@TranMonth+' AND AT2006.TranYear= '+@TranYear+'
						AND KindVoucherID IN (1,5,7,9) AND AT2006.WareHouseID IN (''' +@WareHouseID+ ''')
						GROUP BY  AT2006.WareHouseID, AT2007.InventoryID,AT2007.UnitPrice,ActualQuantity,DebitAccountID
						) A
						GROUP BY WareHouseID, InventoryID
						SELECT * FROM #Tranfer where Amount != 0 '

			SET @sSQL1 = '
				---- DS mặt hàng 
			SELECT DISTINCT InventoryID FROM (
			SELECT DISTINCT CONCAT(InventoryID,AccountID) AS InventoryID, DivisionID FROM dbo.AT1302 WITH (NOLOCK) 
			Where DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1302.MethodID = 4
			GROUP BY DivisionID,InventoryID,AccountID
			UNION ALL
			SELECT DISTINCT CONCAT(InventoryID,AccountID) AS InventoryID, DivisionID FROM dbo.AT1312 WITH (NOLOCK) 
			WHERE InventoryID IN (SELECT InventoryID FROM AT1302 WHERE DivisionID IN ('''+@DivisionID+''',''@@@'') AND MethodID = 4)
			GROUP BY DivisionID,InventoryID,AccountID)
			#tranfer3
			WHERE #tranfer3.DivisionID IN ('''+@DivisionID+''',''@@@'')
			AND InventoryID  IN ( SELECT InventoryID FROM #Tranfer where Amount != 0) ' 
		
		END
		ELSE
			BEGIN
				SET @sSQL = N'	--- Lấy số lượng phiếu nhập đầu kỳ + số lượng nhập kho + số lượng chuyển kho trong 1 kỳ
							SELECT InventoryID, ISNULL(SUM(ActualQuantity),0) AS ActualQuantity, WareHouseID INTO #Tranfer1 FROM (
							SELECT CONCAT(InventoryID,InventoryAccountID) AS InventoryID, BeginQuantity AS ActualQuantity, WareHouseID
							FROM AT2008  WITH (NOLOCK)
							WHERE AT2008.DivisionID = '''+@DivisionID+''' AND (InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''') AND AT2008.TranMonth = '+@TranMonth+' AND AT2008.TranYear = '+@TranYear+'
							AND AT2008.WareHouseID IN (''' +@WareHouseID+ ''')

							UNION ALL

							SELECT CONCAT(AT2007.InventoryID,DebitAccountID) AS InventoryID, SUM(AT2007.ActualQuantity) AS ActualQuantity, AT2006.WareHouseID
							FROM AT2007 WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID 
							WHERE AT2007.DivisionID = '''+@DivisionID+''' AND (InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''') AND AT2006.TranMonth = '+@TranMonth+' AND AT2006.TranYear = '+@TranYear+'
							AND KindVoucherID IN (1,5,7,9) AND AT2006.WareHouseID IN (''' +@WareHouseID+ ''')
							GROUP BY AT2006.WareHouseID,AT2007.InventoryID,DebitAccountID
								 
							UNION ALL 

							SELECT CONCAT(AT2007.InventoryID,DebitAccountID) AS InventoryID, SUM(AT2007.ActualQuantity) AS ActualQuantity, UPPER(AT2006.WareHouseID)  AS WareHouseID
							FROM AT2007 WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID 
							WHERE AT2007.DivisionID = '''+@DivisionID+''' AND (InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''') AND AT2006.TranMonth = '+@TranMonth+' AND AT2006.TranYear= '+@TranYear+'
							AND KindVoucherID  = 3  AND AT2006.WareHouseID IN (''' +@WareHouseID+ ''')
							GROUP BY AT2006.WareHouseID,AT2007.InventoryID,DebitAccountID
							) A where ActualQuantity <> 0  
							GROUP BY WareHouseID, InventoryID  
				
							SELECT * FROM #Tranfer1  

							-- CHuyển kho
							SELECT AT2006.WareHouseID2, AT2006.WareHouseID, CONCAT(AT2007.InventoryID,DebitAccountID) AS InventoryID, SUM(AT2007.ActualQuantity) AS ActualQuantity
							FROM AT2007 WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID 
							WHERE AT2007.DivisionID = '''+@DivisionID+''' AND (InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''') AND AT2006.TranMonth = '+@TranMonth+' AND AT2006.TranYear = '+@TranYear+'
							AND KindVoucherID = 3 AND AT2006.WareHouseID2 IN (''' +@WareHouseID+ ''')
							AND ActualQuantity <> 0
							GROUP BY AT2006.WareHouseID, AT2006.WareHouseID2 , AT2007.InventoryID,DebitAccountID'
		SET @sSQL1 = N'
							--- Giá trị nhập kho + giá trị tồn 
							SELECT InventoryID, ISNULL(SUM(Amount),0) AS Amount, WareHouseID INTO #Tranfer FROM (
							SELECT CONCAT(InventoryID,InventoryAccountID) AS InventoryID, BeginAmount AS Amount, WareHouseID
							FROM AT2008 WITH (NOLOCK)
							WHERE AT2008.DivisionID = '''+@DivisionID+''' AND (InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''') AND AT2008.TranMonth = '+@TranMonth+' AND AT2008.TranYear = '+@TranYear+'
							AND AT2008.WareHouseID IN (''' +@WareHouseID+ ''')
							GROUP BY WareHouseID, InventoryID,BeginAmount,InventoryAccountID
				
							UNION ALL

							SELECT CONCAT(AT2007.InventoryID,DebitAccountID) AS InventoryID, SUM(ConvertedAmount) AS Amount, AT2006.WareHouseID
							FROM AT2007  WITH (NOLOCK)	INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID 
							WHERE	AT2007.DivisionID = '''+@DivisionID+''' AND (InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''') AND AT2006.TranMonth = '+@TranMonth+' AND AT2006.TranYear = '+@TranYear+'
							AND KindVoucherID IN (1,5,7,9) AND AT2006.WareHouseID IN (''' +@WareHouseID+ ''')
							GROUP BY  AT2006.WareHouseID, AT2007.InventoryID,AT2007.UnitPrice,ActualQuantity,DebitAccountID
							) A
				 			GROUP BY WareHouseID, InventoryID'
		SET @sSQL1 += N'
							SELECT #Tranfer.* FROM #Tranfer
							INNER JOIN (SELECT InventoryID, WareHouseID FROM #Tranfer1) TBL1 
							ON TBL1.InventoryID = #Tranfer.InventoryID AND TBL1.WareHouseID = #Tranfer.WareHouseID
					
							---- DS mặt hàng
							SELECT DISTINCT InventoryID FROM (
							SELECT DISTINCT CONCAT(InventoryID,AccountID) AS InventoryID,DivisionID FROM dbo.AT1302 WITH (NOLOCK) 
							Where DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1302.MethodID = 4
							GROUP BY DivisionID,InventoryID,AccountID
							UNION ALL
							SELECT DISTINCT CONCAT(InventoryID,AccountID)AS InventoryID, DivisionID FROM dbo.AT1312 WITH (NOLOCK) 
							WHERE InventoryID IN (SELECT InventoryID FROM AT1302 WHERE DivisionID IN ('''+@DivisionID+''',''@@@'') AND MethodID = 4)
							GROUP BY DivisionID,InventoryID,AccountID)
							#tranfer3
							WHERE #tranfer3.DivisionID IN (''' + @DivisionID+''',''@@@'')
							AND InventoryID  IN ( SELECT InventoryID FROM #Tranfer) '
		
		END
		
	END

PRINT(@sSQL + @sSQL1)
EXEC (@sSQL + @sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO