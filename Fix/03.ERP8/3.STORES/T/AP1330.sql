IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1330]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1330]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created by Trà Giang
----- Created Date 26/06/2019
----- Purpose: Lấy dữ liệu tính giá xuất kho
----- Modified by Huỳnh Thử on 08/01/2020 : Upper() kho cho đồng nhất
----- Modified by Lê Hoàng on 20/01/2020 : bảng 1 hết số lượng của kho X nhưng bảng 3 vẫn còn số tiền của kho X => bỏ kho X ko tính
----- Modified by Huỳnh Thử on 20/02/2020 : Customer Phú Long: tồn đầu = 0 vẫn lấy đưa vào bảng 3 để áp giá = 0
----- Modidied by Văn Tài on 06/07/2020: Customzie [HUYNDEA]: Tách store tính giá xuất kho, đọc dữ liệu số lượng = 0.
----- Modified by Huỳnh Thử on 09/07/2020 : CONCAT(InventoryID,AccountID) tính giá mặt hàng theo tài khoản
----- Modified by Huỳnh Thử on 31/07/2020 : Tách chuỗi @SQL
----- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
----- Modified by Đức Thông on 24/11/2020: Đối với những phiếu điều chỉnh giá trị nhập kho không có đơn giá và số lượng thì lấy tổng thành tiền qui đối
----- Modified by Huỳnh Thử on 01/12/2020: Đổi Amount bằng thành tiền -- Không lấy số lượng * đơn giá, bị lỗi khi có phiếu điều chỉnh hoặc sửa giá thành tiền phiếu nhập; 
-----									   Thêm điều kiên Amount <> 0 vì sẽ sai khi trường hợp xuất kho âm
----- Modified by Nhật Thanh on 23/11/2021: Khóa điều kiện Amount <> 0
/*
exec AP1330  @DivisionID = 'AT',@TranMonth =4,@TranYear = 2019,@FromInventoryID ='AM20147.01.39',@ToInventoryID ='AM20147.01.39',	@FromWareHouseID = 'KHOBAN.LBB', 	@ToWareHouseID ='KHOBAN.QT',@FromAccountID=N'152',@ToAccountID=N'158',@UserID=N'ASOFTADMIN',@GroupID=N'ADMIN',@TransProcessesID=N'',@IsAllWareHouse = 0
exec AP1330 @DivisionID=N'AT',@TranMonth=N'4',@TranYear=N'2019',@FromInventoryID=N'AAGTEST',@ToInventoryID=N'WALW.19.002',@FromWareHouseID=N'BH.NDC',@ToWareHouseID=N'MD.PDT',@FromAccountID=N'152',@ToAccountID=N'158',@UserID=N'ASOFTADMIN',@GroupID=N'ADMIN',@TransProcessesID=N'',@IsAllWareHouse = 0
*/

CREATE PROCEDURE  [dbo].[AP1330]
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

IF(@CustomerName = 46)
BEGIN
	EXEC AP1330_HD @DivisionID, @TranMonth, @TranYear, @FromInventoryID, @ToInventoryID, @FromWareHouseID, @ToWareHouseID
END
ELSE
	BEGIN 
		IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND ISNULL(IsSpecificate,0) = 1)
			EXEC AP1330_QC @DivisionID, @TranMonth, @TranYear, @FromInventoryID, @ToInventoryID, @FromWareHouseID, @ToWareHouseID
		ELSE
		BEGIN
				IF @IsAllWareHouse = 1
					BEGIN
				 SET @sSQL = N' --- Lấy số lượng phiếu nhập đầu kỳ + số lượng nhập kho + số lượng chuyển kho trong 1 kỳ
								SELECT InventoryID, SUM(ISNULL(ActualQuantity,0)) as ActualQuantity, ''ALL'' as WareHouseID from (
								Select CONCAT(InventoryID,InventoryAccountID) AS InventoryID,  BeginQuantity as ActualQuantity
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
								and ActualQuantity <> 0 
								GROUP BY AT2007.InventoryID,DebitAccountID
				
								--- Giá trị nhập kho + giá trị tồn 

								Select InventoryID, ISNULL(sum(Amount),0) AS Amount ,''ALL'' as  WareHouseID INTO #Tranfer from (
								Select  CONCAT(InventoryID,InventoryAccountID) AS InventoryID, BeginAmount AS Amount,'''' as  WareHouseID
								From AT2008  WITH (NOLOCK)
									WHERE	AT2008.DivisionID = '''+@DivisionID+''' and InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' and AT2008.TranMonth = '+@TranMonth+' and AT2008.TranYear= '+@TranYear+'
								GROUP BY  WareHouseID, InventoryID,BeginAmount,InventoryAccountID
				
									UNION ALL

								SELECT CONCAT(AT2007.InventoryID,DebitAccountID), SUM(ConvertedAmount) AS Amount,'''' as WareHouseID
								From AT2007  WITH (NOLOCK)	inner join AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID and AT2006.DivisionID = AT2007.DivisionID 
								WHERE	AT2007.DivisionID = '''+@DivisionID+''' and InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' and AT2006.TranMonth = '+@TranMonth+' and AT2006.TranYear= '+@TranYear+'
								and KindVoucherID IN (1,5,7,9) and AT2006.WareHouseID between '''+@FromWareHouseID+''' and '''+@ToWareHouseID+'''
								 GROUP BY  AT2006.WareHouseID, AT2007.InventoryID,AT2007.UnitPrice,ActualQuantity,DebitAccountID
								 ) A 
								 GROUP BY WareHouseID, InventoryID
								 SELECT * FROM #Tranfer where Amount != 0 
								 '
				 SET @sSQL1 = '
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
									Select  CONCAT(InventoryID,InventoryAccountID) AS  InventoryID,  BeginQuantity as ActualQuantity, WareHouseID
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
									 ) A where ActualQuantity <> 0  
									 GROUP BY WareHouseID, InventoryID  
				
									SELECT * FROM #Tranfer1  

											  -- CHuyển kho
									select AT2006.WareHouseID2,AT2006.WareHouseID , CONCAT(AT2007.InventoryID,DebitAccountID) AS InventoryID,  SUM(AT2007.ActualQuantity) as ActualQuantity
									From AT2007  WITH (NOLOCK)	inner join AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID and AT2006.DivisionID = AT2007.DivisionID 
									WHERE	AT2007.DivisionID = '''+@DivisionID+''' and InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' and AT2006.TranMonth = '+@TranMonth+' and AT2006.TranYear= '+@TranYear+'
									and KindVoucherID = 3 and AT2006.WareHouseID2 between '''+@FromWareHouseID+''' and '''+@ToWareHouseID+'''
									and ActualQuantity <> 0 
									GROUP BY AT2006.WareHouseID, AT2006.WareHouseID2 , AT2007.InventoryID,DebitAccountID'
				SET @sSQL1 = N'
									--- Giá trị nhập kho + giá trị tồn 

									Select InventoryID, ISNULL(sum(Amount),0) AS Amount , WareHouseID INTO #Tranfer from (
									Select  CONCAT(InventoryID,InventoryAccountID) AS  InventoryID, BeginAmount AS Amount, WareHouseID
									From AT2008  WITH (NOLOCK)
										WHERE	AT2008.DivisionID = '''+@DivisionID+''' and InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' and AT2008.TranMonth = '+@TranMonth+' and AT2008.TranYear= '+@TranYear+'
									and AT2008.WareHouseID between '''+@FromWareHouseID+''' and '''+@ToWareHouseID+'''
									GROUP BY  WareHouseID, InventoryID,BeginAmount,InventoryAccountID
				
										UNION ALL

									SELECT CONCAT(AT2007.InventoryID,DebitAccountID) AS InventoryID, SUM(ConvertedAmount) AS Amount, AT2006.WareHouseID
									From AT2007  WITH (NOLOCK)	inner join AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID and AT2006.DivisionID = AT2007.DivisionID 
									WHERE	AT2007.DivisionID = '''+@DivisionID+''' and InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' and AT2006.TranMonth = '+@TranMonth+' and AT2006.TranYear= '+@TranYear+'
									and KindVoucherID IN (1,5,7,9) and AT2006.WareHouseID between '''+@FromWareHouseID+''' and '''+@ToWareHouseID+'''
									 GROUP BY  AT2006.WareHouseID, AT2007.InventoryID,AT2007.UnitPrice,ActualQuantity,DebitAccountID
									 ) A  '/*+ CASE WHEN @CustomerName = 32 THEN	''  ELSE 'WHERE Amount <> 0' END*/+'
				 					  GROUP BY WareHouseID, InventoryID'
				SET @sSQL1 += N'

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
							AND InventoryID  IN ( SELECT InventoryID FROM #Tranfer) '
				
								
	
					END
		
		END
	END

PRINT(@sSQL + @sSQL1)
EXEC (@sSQL + @sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO