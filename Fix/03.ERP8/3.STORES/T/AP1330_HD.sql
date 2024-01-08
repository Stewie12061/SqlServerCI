IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1330_HD]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1330_HD]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created by Văn Tài
----- Created Date 06/07/2020
----- Purpose: Lấy dữ liệu tính giá xuất kho [HUYNDEA].
----- Modified by Huỳnh Thử on 06/07/2020 : Nếu số lượng bằng 0 thì Amount lấy từ ConvertedAmount.
----- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
----- Modified by Nhựt Trường on 04/07/2022: CONCAT(InventoryID,AccountID) tính giá mặt hàng theo tài khoản
/*

exec AP1330_HD
@DivisionID=N'HD'
, @TranMonth=N'4'
, @TranYear=N'2019'
, @FromInventoryID=N'AAGTEST'
, @ToInventoryID=N'WALW.19.002'
, @FromWareHouseID=N'BH.NDC'
, @ToWareHouseID=N'MD.PDT'
, @FromAccountID=N'152'
, @ToAccountID=N'158'
, @UserID=N'ASOFTADMIN'
, @GroupID=N'ADMIN'
, @TransProcessesID=N''
, @IsAllWareHouse = 0
*/

CREATE PROCEDURE  [dbo].[AP1330_HD] 
		@DivisionID  as nvarchar(50), 
		@TranMonth as nvarchar(50) , 
		@TranYear as nvarchar(50),
		@FromInventoryID NVARCHAR(50) = '', 
		@ToInventoryID NVARCHAR(50) = '',
		@FromWareHouseID NVARCHAR(50) = '', 
		@ToWareHouseID NVARCHAR(50) = '',
		@FromAccountID NVARCHAR(50) = '',
		@ToAccountID NVARCHAR(50) = '',
		@UserID NVARCHAR(50) = '',
		@GroupID NVARCHAR(50) = '',
		@TransProcessesID NVARCHAR(50) = '',
		@IsAllWareHouse TINYINT = 0 --  Tính giá không phân biệt kho ( 1: check, 0: không check) 

AS
DECLARE @sSQL NVARCHAR(4000)  = N'',
		@sSQL_01 NVARCHAR(4000)  = N'',
		@sWhere NVARCHAR(4000) = N'',
		@sWhere1 NVARCHAR(4000) = N'',
		@sWhere2 NVARCHAR(4000) = N'';

IF @IsAllWareHouse = 1
	BEGIN
	 SET @sSQL = N' --- Lấy số lượng phiếu nhập đầu kỳ + số lượng nhập kho + số lượng chuyển kho trong 1 kỳ
					SELECT InventoryID, SUM(ISNULL(ActualQuantity,0)) as ActualQuantity, ''ALL'' as WareHouseID from (
					Select   CONCAT(InventoryID,InventoryAccountID) AS InventoryID,  BeginQuantity as ActualQuantity
					From AT2008  WITH (NOLOCK)
					WHERE	AT2008.DivisionID = '''+@DivisionID+''' and InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+'''  and AT2008.TranMonth = '+@TranMonth+' and AT2008.TranYear= '+@TranYear+'
					UNION ALL
					SELECT CONCAT(InventoryID,DebitAccountID) AS InventoryID,  SUM(AT2007.ActualQuantity) as ActualQuantity
					From AT2007  WITH (NOLOCK)	inner join AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID and AT2006.DivisionID = AT2007.DivisionID 
					WHERE	AT2007.DivisionID = '''+@DivisionID+''' and InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' and AT2006.TranMonth = '+@TranMonth+' and AT2006.TranYear= '+@TranYear+'
					and KindVoucherID IN (1,5,7,9) 
					GROUP BY   AT2007.InventoryID,DebitAccountID
			
					 ) A   -- where ActualQuantity != 0 
					  GROUP BY  InventoryID  
					  HAVING SUM(ISNULL(ActualQuantity,0)) != 0
				
							  -- CHuyển kho
					select ''ALL'' as WareHouseID2,''ALL'' as WareHouseID , CONCAT(InventoryID,DebitAccountID) AS InventoryID,  0 as ActualQuantity
					From AT2007  WITH (NOLOCK)	inner join AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID and AT2006.DivisionID = AT2007.DivisionID 
					WHERE	AT2007.DivisionID = '''+@DivisionID+''' and InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' and AT2006.TranMonth = '+@TranMonth+' and AT2006.TranYear= '+@TranYear+'
					and KindVoucherID = 3 
					and ActualQuantity > 0 
					GROUP BY AT2007.InventoryID,DebitAccountID
					--- Giá trị nhập kho + giá trị tồn 
					Select InventoryID, ISNULL(sum(Amount),0) AS Amount ,''ALL'' as  WareHouseID INTO #Tranfer from (
					Select   CONCAT(InventoryID,InventoryAccountID) AS InventoryID, BeginAmount AS Amount,'''' as  WareHouseID
					From AT2008  WITH (NOLOCK)
						WHERE	AT2008.DivisionID = '''+@DivisionID+''' and InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' and AT2008.TranMonth = '+@TranMonth+' and AT2008.TranYear= '+@TranYear+'
					GROUP BY  WareHouseID, InventoryID,BeginAmount,InventoryAccountID
						UNION ALL
					SELECT CONCAT(AT2007.InventoryID,DebitAccountID), SUM(AT2007.ConvertedAmount) AS Amount,'''' as WareHouseID
					From AT2007  WITH (NOLOCK)	inner join AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID and AT2006.DivisionID = AT2007.DivisionID 
					WHERE	AT2007.DivisionID = '''+@DivisionID+''' and InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' and AT2006.TranMonth = '+@TranMonth+' and AT2006.TranYear= '+@TranYear+'
					and KindVoucherID IN (1,5,7,9) and AT2006.WareHouseID between '''+@FromWareHouseID+''' and '''+@ToWareHouseID+'''
					 GROUP BY  AT2006.WareHouseID, AT2007.InventoryID,AT2007.UnitPrice,ActualQuantity,DebitAccountID
					 ) A 
					 GROUP BY WareHouseID, InventoryID
					 SELECT * FROM #Tranfer where Amount != 0 
					  ---- DS mặt hàng 
					SELECT DISTINCT InventoryID FROM (
					SELECT DISTINCT CONCAT(inventoryid,accountid) AS InventoryID,divisionid  FROM dbo.AT1302 WITH (NOLOCK) 
					Where DivisionID IN ('''+@DivisionID+''',''@@@'') AND At1302.MethodID = 4
					GROUP BY divisionid,inventoryid,AccountID
					UNION ALL
					SELECT DISTINCT CONCAT(inventoryid,accountid)AS InventoryID, divisionid  FROM dbo.AT1312 WITH (NOLOCK) 
					WHERE InventoryID IN (SELECT InventoryID FROM AT1302 WHERE DivisionID IN ('''+@DivisionID+''',''@@@'') AND MethodID =4)
					GROUP BY divisionid,inventoryid,AccountID)
						#tranfer3
						WHERE #tranfer3.DivisionID in ('''+@DivisionID+''',''@@@'')
					AND InventoryID  IN ( SELECT InventoryID FROM #Tranfer where Amount != 0)
	 ' 
	END 
ELSE
	BEGIN
		SET @sSQL = N'	--- Lấy số lượng phiếu nhập đầu kỳ + số lượng nhập kho + số lượng chuyển kho trong 1 kỳ
					SELECT InventoryID,  ISNULL(SUM(ActualQuantity),0) as ActualQuantity, WareHouseID INTO #Tranfer1 from (
					Select   CONCAT(InventoryID,InventoryAccountID) AS  InventoryID,  BeginQuantity as ActualQuantity, WareHouseID
					From AT2008  WITH (NOLOCK)
					WHERE	AT2008.DivisionID = '''+@DivisionID+''' and InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+'''  and AT2008.TranMonth = '+@TranMonth+' and AT2008.TranYear= '+@TranYear+'
					and AT2008.WareHouseID between '''+@FromWareHouseID+''' and '''+@ToWareHouseID+'''
				
					UNION ALL

					SELECT CONCAT(AT2007.InventoryID,DebitAccountID) AS InventoryID,  SUM(AT2007.ActualQuantity) as ActualQuantity, AT2006.WareHouseID
					From AT2007  WITH (NOLOCK)	inner join AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID and AT2006.DivisionID = AT2007.DivisionID 
					WHERE	AT2007.DivisionID = '''+@DivisionID+''' and InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' and AT2006.TranMonth = '+@TranMonth+' and AT2006.TranYear= '+@TranYear+'
					and KindVoucherID IN (1,5,7,9) and AT2006.WareHouseID between '''+@FromWareHouseID+''' and '''+@ToWareHouseID+'''
					GROUP BY   AT2006.WareHouseID,AT2007.InventoryID,DebitAccountID
								 
					UNION ALL 

					SELECT CONCAT(AT2007.InventoryID,DebitAccountID) AS InventoryID,  sum(AT2007.ActualQuantity) AS ActualQuantity, UPPER(AT2006.WareHouseID)  AS WareHouseID
					From AT2007  WITH (NOLOCK)	inner join AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID and AT2006.DivisionID = AT2007.DivisionID 
					WHERE	AT2007.DivisionID = '''+@DivisionID+''' and InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' and AT2006.TranMonth = '+@TranMonth+' and AT2006.TranYear= '+@TranYear+'
					and KindVoucherID  = 3  and AT2006.WareHouseID between '''+@FromWareHouseID+''' and '''+@ToWareHouseID+'''
					GROUP BY   AT2006.WareHouseID,AT2007.InventoryID,DebitAccountID
					 ) A where ActualQuantity > 0  GROUP BY WareHouseID, InventoryID
				
					SELECT * FROM #Tranfer1  

					-- CHuyển kho
					select AT2006.WareHouseID2,AT2006.WareHouseID , CONCAT(AT2007.InventoryID,DebitAccountID) AS InventoryID,  SUM(AT2007.ActualQuantity) as ActualQuantity
					From AT2007  WITH (NOLOCK)	inner join AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID and AT2006.DivisionID = AT2007.DivisionID 
					WHERE	AT2007.DivisionID = '''+@DivisionID+''' and InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' and AT2006.TranMonth = '+@TranMonth+' and AT2006.TranYear= '+@TranYear+'
					and KindVoucherID = 3 and AT2006.WareHouseID2 between '''+@FromWareHouseID+''' and '''+@ToWareHouseID+'''
					and ActualQuantity > 0 
					GROUP BY AT2006.WareHouseID, AT2006.WareHouseID2 , AT2007.InventoryID,DebitAccountID
				
					--- Giá trị nhập kho + giá trị tồn 
					Select InventoryID, ISNULL(sum(Amount),0) AS Amount , WareHouseID INTO #Tranfer from (
					Select   CONCAT(InventoryID,InventoryAccountID) AS  InventoryID, BeginAmount AS Amount, WareHouseID
					From AT2008  WITH (NOLOCK)
						WHERE	AT2008.DivisionID = '''+@DivisionID+''' and InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' and AT2008.TranMonth = '+@TranMonth+' and AT2008.TranYear= '+@TranYear+'
					and AT2008.WareHouseID between '''+@FromWareHouseID+''' and '''+@ToWareHouseID+'''
					GROUP BY  WareHouseID, InventoryID,BeginAmount,InventoryAccountID
					'
		SET @sSQL_01 =' UNION ALL

					SELECT CONCAT(AT2007.InventoryID,DebitAccountID) AS InventoryID
					, SUM(AT2007.ConvertedAmount) AS Amount
					, AT2006.WareHouseID
					FROM AT2007 WITH (NOLOCK)
					INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID 
															AND AT2006.DivisionID = AT2007.DivisionID 
					WHERE AT2007.DivisionID = '''+@DivisionID+''' 
							AND InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+''' 
							AND AT2006.TranMonth = '+@TranMonth+' 
							AND AT2006.TranYear= '+@TranYear+'
							AND KindVoucherID IN (1, 5, 7, 9) 
							AND AT2006.WareHouseID BETWEEN '''+@FromWareHouseID+''' AND '''+@ToWareHouseID+'''
					 GROUP BY  AT2006.WareHouseID, AT2007.InventoryID, AT2007.UnitPrice, ActualQuantity,DebitAccountID
					 ) A  
					 -- Các trường hợp số lượng = 0, Amount âm vẫn cho phép lấy.
					 -- WHERE Amount > 0 
					 GROUP BY WareHouseID, InventoryID

					SELECT #Tranfer.* FROM #Tranfer
					INNER JOIN (SELECT InventoryID, WareHouseID FROM #Tranfer1) TBL1 
					ON TBL1.InventoryID = #Tranfer.InventoryID AND TBL1.WareHouseID = #Tranfer.WareHouseID

					 	---- DS mặt hàng 
							SELECT DISTINCT InventoryID FROM (
							SELECT DISTINCT CONCAT(inventoryid,accountid) AS InventoryID,divisionid  FROM dbo.AT1302 WITH (NOLOCK) 
							Where DivisionID IN ('''+@DivisionID+''',''@@@'') AND At1302.MethodID = 4
							GROUP BY divisionid,inventoryid,AccountID
							UNION ALL
							SELECT DISTINCT CONCAT(inventoryid,accountid)AS InventoryID, divisionid  FROM dbo.AT1312 WITH (NOLOCK) 
							WHERE InventoryID IN (SELECT InventoryID FROM AT1302 WHERE DivisionID IN ('''+@DivisionID+''',''@@@'') AND MethodID =4)
							GROUP BY divisionid,inventoryid,AccountID)
								#tranfer3
								WHERE #tranfer3.DivisionID in (''' + @DivisionID+''',''@@@'')
							AND InventoryID  IN ( SELECT InventoryID FROM #Tranfer)'
	END

EXEC (@sSQL + @sSQL_01)
PRINT (@sSQL + @sSQL_01)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
