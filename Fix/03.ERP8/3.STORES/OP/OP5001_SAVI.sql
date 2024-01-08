IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP5001_SAVI]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP5001_SAVI]
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO
---Created by: Vo Thanh Huong, date: 13/04/2005  
---purpose: Cap nhat lai tinh trang don hang   
---Last Edit : Thuy Tuyen, date 11/09/2008  
---Edit by: Dang Le Bao Quynh; Date: 30/10/2008  
---Purpose: Cai thien toc do  
/********************************************  
'* Edited by: [GS] [Thành Nguyên] [04/08/2010]  
'********************************************/

--- Edited by Bao Anh	Date: 27/11/2012	
--- Purpose:	1/ Sua loi DHSX khong ke thua qua Asoft-M nhung van cap nhat tinh trang la hoan tat
---				2/ Cap nhat tinh trang la Dang san xuat doi voi cac DHSX chưa duoc ke thua het
---- Modified on 31/05/2016 by Bảo Thy: Bổ sung WITH (NOLOCK)
---- Modified by TIểu Mai on 24/05/2017: Bổ sung chỉnh sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 02/01/2019: Song Bình: cập nhật trạng thái dựa vào thành tiền
---- Modified by Huỳnh Thử on 25/07/2019: Fix lỗi Run tool all Fix
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Thông on 21/10/2020 : Tách store cho SAVI để xử lí trường hợp đổi đvt ở hóa đơn bán hàng
-- EXEC OP5001_SAVI 'ANG', 2,2016

CREATE PROCEDURE [dbo].[OP5001_SAVI] @DivisionID NVARCHAR(50), 
                                    @TranMonth  INT, 
                                    @TranYear   INT
AS
     DECLARE @sSQL NVARCHAR(4000), @sSQL1 NVARCHAR(4000), @CustomerName INT, @sSQL2 NVARCHAR(MAX);
     SET @sSQL = '--Giu cho SO  
Select   
 ''SO'' as TypeID,   
 T01.DivisionID,   
 T00.SOrderID as OrderID,  
 sum(T00.ConvertedAmount)  as ConvertedAmount,
 T00.InventoryID, T00.TransactionID,  
 (  
  case when T00.Finish = 1   
  then 0  
  else   
   (  
    Case When AT1302.IsStocked = 0   
    then 
		CASE WHEN T00.UnitID = T02.UnitID -- Ko đổi đvt
		THEN SUM(ISNULL(OrderQuantity, 0)) - SUM(ISNULL(AdjustQuantity, 0)) - AVG(ISNULL(ActualQuantityHD, 0))
		WHEN T02.UnitID = AT1309.UnitID -- Đvt chuẩn --> Qui đổi
			THEN CASE AT1309.Operator
					WHEN 1
						THEN SUM(ISNULL(OrderQuantity, 0)) - SUM(ISNULL(AdjustQuantity, 0)) - AVG(ISNULL(ActualQuantityHD, 0) / ISNULL(ConversionFactor, 1))
					ELSE SUM(ISNULL(OrderQuantity, 0)) - SUM(ISNULL(AdjustQuantity, 0)) - AVG(ISNULL(ActualQuantityHD, 0) * ISNULL(ConversionFactor, 1)) END
		ELSE -- Đvt qui đổi --> Chuẩn
			CASE AT1309.Operator
				WHEN 1
					THEN SUM(ISNULL(OrderQuantity, 0)) - SUM(ISNULL(AdjustQuantity, 0)) - AVG(ISNULL(ActualQuantityHD, 0) * ISNULL(ConversionFactor, 1))
				ELSE SUM(ISNULL(OrderQuantity, 0)) - SUM(ISNULL(AdjustQuantity, 0)) - AVG(ISNULL(ActualQuantityHD, 0) / ISNULL(ConversionFactor, 1)) END
		END   
    else
		CASE WHEN T00.UnitID = T02.UnitID -- Ko đổi đvt
		THEN SUM(ISNULL(OrderQuantity, 0)) - SUM(ISNULL(AdjustQuantity, 0)) - AVG(ISNULL(ActualQuantity, 0))
		WHEN T02.UnitID = AT1309.UnitID -- Đvt chuẩn --> Qui đổi
			THEN CASE AT1309.Operator
					WHEN 1
						THEN SUM(ISNULL(OrderQuantity, 0)) - SUM(ISNULL(AdjustQuantity, 0)) - AVG(ISNULL(ActualQuantity, 0) / ISNULL(ConversionFactor, 1))
					ELSE SUM(ISNULL(OrderQuantity, 0)) - SUM(ISNULL(AdjustQuantity, 0)) - AVG(ISNULL(ActualQuantity, 0) * ISNULL(ConversionFactor, 1)) END
		ELSE -- Đvt qui đổi --> Chuẩn
			CASE AT1309.Operator
				WHEN 1
					THEN SUM(ISNULL(OrderQuantity, 0)) - SUM(ISNULL(AdjustQuantity, 0)) - AVG(ISNULL(ActualQuantity, 0) * ISNULL(ConversionFactor, 1))
				ELSE SUM(ISNULL(OrderQuantity, 0)) - SUM(ISNULL(AdjustQuantity, 0)) - AVG(ISNULL(ActualQuantity, 0) / ISNULL(ConversionFactor, 1)) END
		END
    end  
   )   
  end   
 ) as RemainQuantity ,  
 SUM(ISNULL(ActualQuantity, 0)) AS ActualQuantity
From  OT2002 T00  WITH (NOLOCK)  
 inner join OT2001 T01 WITH (NOLOCK) on T00.SOrderID = T01.SOrderID and T00.DivisionID = T01.DivisionID   
 Inner join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (''@@@'', T00.DivisionID) AND AT1302.InventoryID = T00.InventoryID 
 left  join    
 (--Giao hang thuc te  
  Select T00.OrderID, InventoryID, sum(ActualQuantity) as ActualQuantity, OTransactionID, T00.UnitID
  From AT2007 T00 WITH (NOLOCK) inner join AT2006 T01 WITH (NOLOCK) on T00.VoucherID = T01.VoucherID and T00.DivisionID = T01.DivisionID  
  Where KindVoucherID in (2, 4) and isnull(T00.OrderID, '''') <> ''''   
  and T00.DivisionID = ''' + @DivisionID + ''' 
  Group by T00.OrderID, InventoryID,OTransactionID, T00.UnitID  
 ) T02 on T02.InventoryID = T00.InventoryID and   
    T02.OrderID = T00.SOrderID and   
    T02.OTransactionID = T00.TransactionID   
';
     SET @sSQL1 = N'left join   
 (-- Lap Hoa don doi voi nhung mat hang AT1302.IsStocked = 0)  
  Select AT9000.DivisionID, AT9000.OrderID, OTransactionID, InventoryID, sum(Quantity) As ActualQuantityHD  
  From AT9000 WITH (NOLOCK)    
  Where isnull(AT9000.OrderID,'''') <>''''   
  and  TransactionTypeID =''T04''  
  and DivisionID = ''' + @DivisionID + '''  
  Group by AT9000.DivisionID, AT9000.OrderID, InventoryID, OTransactionID  
 ) as G   
  on  T01.DivisionID = G.DivisionID and  
   T00.SOrderID = G.OrderID and  
   T00.InventoryID = G.InventoryID and  
   T00.TransactionID = G.OTransactionID  
   LEFT JOIN AT1309 ON T00.InventoryID = AT1309.InventoryID
Where OrderStatus not in (0,4, 5, 9) and   
  T01.Disabled = 0 and T01.DivisionID like isnull(N''' + @DivisionID + ''', '''')  and   
  T01.TranMonth + T01.TranYear*100 < = ' + CAST(@TranMonth + @TranYear * 100 AS NVARCHAR(50)) + '      
Group by T01.DivisionID,  T00.SOrderID, T00.InventoryID,TransactionID, T00.Finish, T00.UnitID, T02.UnitID, AT1302.IsStocked, AT1309.UnitID, AT1309.Operator';
     IF EXISTS
     (
         SELECT TOP 1 1
         FROM sysObjects WITH(NOLOCK)
         WHERE XType = 'V'
               AND Name = 'OV5101'
     )
         EXEC ('Alter view OV5101 ---tao boi OP5001_SAVI   
 as '+@sSQL+@sSQL1);
         ELSE
         EXEC ('Create view OV5101 ---tao boi OP5001_SAVI   
 as '+@sSQL+@sSQL1);

     --Union all  
     SET @sSQL = '--Hang dang ve PO  
Select   
 ''PO'' as TypeID, T01.DivisionID, T00.POrderID as OrderID, T00.InventoryID, TransactionID ,  
 -------sum(isnull(OrderQuantity, 0)) - sum(isnull(AdjustQuantity,0)) - avg(isnull(ActualQuantity,0))  as RemainQuantity ,  
 (   
  case when T00.Finish = 1   
  then 0     
  else   
  (    
   Case When AT1302.IsStocked = 0   
   then sum(isnull(OrderQuantity, 0)) - sum(isnull(AdjustQuantity,0)) - avg(isnull(ActualQuantityHD,0))   
   else sum(isnull(OrderQuantity, 0)) - sum(isnull(AdjustQuantity,0)) - avg(isnull(ActualQuantity,0))   
   end  
  )   
  end   
 )   as RemainQuantity ,  
 sum(isnull(ActualQuantity,0)) as ActualQuantity  
From  OT3002 T00 WITH (NOLOCK) inner join OT3001 T01 WITH (NOLOCK) on T00.POrderID = T01.POrderID and T00.DivisionID = T01.DivisionID  
  inner join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (''@@@'', T00.DivisionID) AND AT1302.InventoryID = T00.InventoryID  
  left Join   
  (--Nhap hang PO  
   Select T00.DivisionID, T00.OrderID, InventoryID, sum(ActualQuantity) as ActualQuantity, OTransactionID  
   From AT2007 T00 WITH (NOLOCK) inner join AT2006 T01 WITH (NOLOCK) on T00.VoucherID = T01.VoucherID and T00.DivisionID = T01.DivisionID  
   Where KindVoucherID in (1, 5, 7) and isnull(T00.OrderID, '''') <> ''''  
   and T00.DivisionID = ''' + @DivisionID + '''  
   Group by T00.DivisionID, T00.OrderID, InventoryID,OTransactionID  
  ) T03 on T03.OrderID = T00.POrderID and   
     T03.InventoryID = T00.InventoryID and    
     T03.DivisionID = T00.DivisionID and    
     T03.OTRansactionID = T00.TRansactionID    
';
     SET @sSQL1 = N'Left join   
 (-- Lap phi?u mua hàng  doi voi nhung mat hang AT1302.IsStocked = 0)  
  Select AT9000.DivisionID, AT9000.OrderID, OTransactionID, InventoryID, sum(Quantity) As ActualQuantityHD  
  From AT9000  WITH (NOLOCK)   
  Where isnull(AT9000.OrderID,'''') <>'''' and TransactionTypeID =''T05''  
  Group by AT9000.DivisionID, AT9000.OrderID, InventoryID, OTransactionID  
 ) as G on T01.DivisionID = G.DivisionID and   
    T00.POrderID = G.OrderID and   
    T00.InventoryID = G.InventoryID and  
    T00.TransactionID = G.OTransactionID  
Where OrderStatus not in (0, 3,4, 9) and   
  T01.Disabled = 0 and   
  T01.DivisionID like isnull(N''' + @DivisionID + ''', '''')  and   
  T01.TranMonth + T01.TranYear*100 < = ' + CAST(@TranMonth + @TranYear * 100 AS NVARCHAR(50)) + '    
Group by T01.DivisionID, T00.POrderID, T00.InventoryID, TransactionID,T00.Finish, AT1302.IsStocked';

     --Union all  
     IF EXISTS
     (
         SELECT TOP 1 1
         FROM sysObjects WITH(NOLOCK)
         WHERE XType = 'V'
               AND Name = 'OV5102'
     )
         EXEC ('Alter view OV5102 ---tao boi OP5001_SAVI   
  
      as '+@sSQL+@sSQL1);
         ELSE
         EXEC ('Create view OV5102 ---tao boi OP5001_SAVI   
  
      as '+@sSQL+@sSQL1);
     SET @sSQL = '--Giu cho du tru ES  
Select ''ES'' as TypeID, T01.DivisionID,  T00.EstimateID as OrderID, MaterialID as InventoryID, '''' as TransactionID ,  
  sum(isnull(MaterialQuantity, 0)) - avg(isnull(ActualQuantity,0))  as RemainQuantity ,  
  sum(isnull(ActualQuantity,0))  as ActualQuantity  
From  OT2203 T00 WITH (NOLOCK) inner join OT2201 T01 WITH (NOLOCK) on T00.EstimateID = T01.EstimateID and T00.DivisionID = T01.DivisionID  
 left join (--Xuat hang ES  
 Select T00.DivisionID, T00.OrderID, InventoryID, sum(ActualQuantity) as ActualQuantity  
 From AT2007 T00 WITH (NOLOCK) inner join AT2006 T01 WITH (NOLOCK) on T00.VoucherID = T01.VoucherID and T00.DivisionID = T01.DivisionID  
 Where KindVoucherID in (2, 4) and isnull(T00.OrderID, '''') <> ''''  
 Group by T00.DivisionID, T00.OrderID, InventoryID  
 ) T03 on T03.OrderID = T00.EstimateID and T03.InventoryID = T00.MaterialID  and T03.DivisionID = T00.DivisionID   
';
     SET @sSQL1 = N'Where OrderStatus not in (0, 3,4, 9) -- and T01.Disabled = 0   
  and T01.DivisionID like isnull(N''' + @DivisionID + ''', '''')  and   
 T01.TranMonth + T01.TranYear*100 < = ' + CAST(@TranMonth + @TranYear * 100 AS NVARCHAR(50)) + '    
Group by T01.DivisionID, T00.EstimateID, MaterialID';  
     --print @sSQL + @sSQL1  
     IF EXISTS
     (
         SELECT TOP 1 1
         FROM sysObjects WITH(NOLOCK)
         WHERE XType = 'V'
               AND Name = 'OV5103'
     )
         EXEC ('Alter view OV5103 ---tao boi OP5001_SAVI   
      as '+@sSQL+@sSQL1);
         ELSE
         EXEC ('Create view OV5103 ---tao boi OP5001_SAVI   
      as '+@sSQL+@sSQL1);
     SET @sSQL = 'Select TypeID, DivisionID, OrderID, sum(isnull(ActualQuantity,0)) as ActualQuantity,  sum(isnull(ConvertedAmount,0)) as ConvertedAmount,
 sum(case when RemainQuantity <0 then 0 else RemainQuantity end) as RemainQuantity  
From OV5101 where DivisionID  = ''' + @DivisionID + '''  
Group by TypeID, DivisionID, OrderID  
-------Having sum(case when RemainQuantity <0 then 0 else RemainQuantity end) = 0';
     IF EXISTS
     (
         SELECT TOP 1 1
         FROM sysObjects WITH(NOLOCK)
         WHERE XType = 'V'
               AND Name = 'OV5001'
     )
         EXEC ('Alter view OV5001 ---tao boi OP5001_SAVI  
      as '+@sSQL);
         ELSE
         EXEC ('Create view OV5001 ---tao boi OP5001_SAVI  
      as '+@sSQL);
     SET @sSQL = 'Select TypeID, DivisionID, OrderID, sum(isnull(ActualQuantity,0)) as ActualQuantity,  
 sum(case when RemainQuantity <0 then 0 else RemainQuantity end) as RemainQuantity  
From OV5102 where DivisionID  = ''' + @DivisionID + '''  
Group by TypeID, DivisionID, OrderID';
     IF EXISTS
     (
         SELECT TOP 1 1
         FROM sysObjects WITH(NOLOCK)
         WHERE XType = 'V'
               AND Name = 'OV5002'
     )
         EXEC ('Alter view OV5002 ---tao boi OP5001_SAVI  
      as '+@sSQL);
         ELSE
         EXEC ('Create view OV5002 ---tao boi OP5001_SAVI  
      as '+@sSQL);
     SET @sSQL = 'Select TypeID, DivisionID, OrderID, sum(isnull(ActualQuantity,0)) as ActualQuantity,  
 sum(case when RemainQuantity <0 then 0 else RemainQuantity end) as RemainQuantity  
From OV5103 where DivisionID  = ''' + @DivisionID + '''  
Group by TypeID, DivisionID, OrderID';
     IF EXISTS
     (
         SELECT TOP 1 1
         FROM sysObjects WITH(NOLOCK)
         WHERE XType = 'V'
               AND Name = 'OV5003'
     )
         EXEC ('Alter view OV5003 ---tao boi OP5001_SAVI  
      as '+@sSQL);
         ELSE
         EXEC ('Create view OV5003 ---tao boi OP5001_SAVI  
      as '+@sSQL);

     -- CAp nhat tinh trang don hang  
     -- CAp nhat tinh trang don hang bán  

     UPDATE OT2001
       SET 
           OrderStatus = CASE
                             WHEN(ISNULL(RemainQuantity, 0) > 0
                                  AND ISNULL(ActualQuantity, 0) = 0)
                             THEN 1 -- Chap Nhan  
                             WHEN(ISNULL(RemainQuantity, 0) > 0
                                  AND ISNULL(ActualQuantity, 0) > 0)
                             THEN 2 -- Dang Giao Hang  
                             WHEN(ISNULL(RemainQuantity, 0) = 0
                                  AND ISNULL(ActualQuantity, 0) > 0)
                             THEN 3 -- Da Hoan Tat  
                             ELSE OrderStatus
                         END
     FROM OT2001 T00
          INNER JOIN OV5001 V00 ON T00.SOrderID = V00.OrderID
                                   AND T00.DivisionID = V00.DivisionID
     WHERE T00.DivisionID = @DivisionID
           AND T00.OrderType = 0;

     -- CAp nhat tinh trang don hang sản xuất
     UPDATE OT2001
       SET 
           OrderStatus = 2
     WHERE SOrderID NOT IN
     (
         SELECT SOrderID
         FROM(
             SELECT OT2002.DivisionID, 
                    OT2002.SOrderID, 
                    OT2002.OrderQuantity, 
                    TransactionID
             FROM OT2002 WITH(NOLOCK)
                  INNER JOIN OT2001 ON OT2002.SOrderID = OT2001.SOrderID
             WHERE OrderType = 1
                   AND TranMonth + 12 * TranYear <= @TranMonth + 12 * @TranYear) O
             LEFT JOIN(
             SELECT MT1001.DivisionID, 
                    OTransactionID, 
                    SUM(ISNULL(Quantity, 0)) AS MQuantity
             FROM MT0810 WITH(NOLOCK)
                  INNER JOIN MT1001 WITH(NOLOCK) ON MT0810.DivisionID = MT1001.DivisionID
                                                    AND MT0810.VoucherID = MT1001.VoucherID
             WHERE ResultTypeID = 'R01'
             GROUP BY MT1001.DivisionID, 
                      OTransactionID) M ON O.DivisionID = M.DivisionID
                                           AND O.TransactionID = M.OTransactionID
         WHERE O.OrderQuantity - ISNULL(M.MQuantity, 0) > 0
     )
             AND OrderType = 1
             AND TranMonth + TranYear <= @TranMonth + 12 * @TranYear;
     UPDATE OT2001
       SET 
           OrderStatus = 1
     WHERE SOrderID IN
     (
         SELECT SOrderID
         FROM(
             SELECT OT2002.DivisionID, 
                    OT2002.SOrderID, 
                    OT2002.OrderQuantity, 
                    TransactionID
             FROM OT2002 WITH(NOLOCK)
                  INNER JOIN OT2001 ON OT2002.SOrderID = OT2001.SOrderID
             WHERE OrderType = 1
                   AND TranMonth + 12 * TranYear <= @TranMonth + 12 * @TranYear) O
             INNER JOIN(
             SELECT MT1001.DivisionID, 
                    OTransactionID, 
                    SUM(ISNULL(Quantity, 0)) AS MQuantity
             FROM MT0810 WITH(NOLOCK)
                  INNER JOIN MT1001 WITH(NOLOCK) ON MT0810.DivisionID = MT1001.DivisionID
                                                    AND MT0810.VoucherID = MT1001.VoucherID
             WHERE ResultTypeID = 'R01'
             GROUP BY MT1001.DivisionID, 
                      OTransactionID) M ON O.DivisionID = M.DivisionID
                                           AND O.TransactionID = M.OTransactionID
         WHERE O.OrderQuantity - ISNULL(M.MQuantity, 0) > 0
     )
             AND OrderType = 1
             AND TranMonth + TranYear <= @TranMonth + 12 * @TranYear;
     --------------------------------------------------------------------
     -- CAp nhat tinh trang don hang mua, giống đơn hàng bán  
     UPDATE OT3001
       SET 
           OrderStatus = CASE
                             WHEN(ISNULL(RemainQuantity, 0) > 0
                                  AND ISNULL(ActualQuantity, 0) = 0)
                             THEN 1 -- Chap Nhan  
                             ELSE CASE
                                      WHEN(ISNULL(RemainQuantity, 0) > 0
                                           AND ISNULL(ActualQuantity, 0) > 0)
                                      THEN 2 -- Dang Giao Hang  
                                      ELSE CASE
                                               WHEN(ISNULL(RemainQuantity, 0) = 0)
                                               THEN 3 -- Da Hoan Tat  
                                               ELSE OrderStatus
                                           END
                                  END
                         END
     FROM OT3001 T00
          INNER JOIN OV5002 V00 ON T00.POrderID = V00.OrderID
                                   AND T00.DivisionID = V00.DivisionID
     WHERE T00.DivisionID = @DivisionID;

/*  
Update OT3001 Set OrderStatus =  3  
From OT3001 T00 inner join OV5002 V00 on T00.POrderID = V00.OrderID where ISNULL( RemainQuantity,0) = 0  
*/

     UPDATE OT2201
       SET 
           OrderStatus = 2
     FROM OT2201 T00
          INNER JOIN OV5003 V00 ON T00.EstimateID = V00.OrderID
                                   AND T00.DivisionID = V00.DivisionID
     WHERE ISNULL(RemainQuantity, 0) = 0
           AND T00.DivisionID = @DivisionID;