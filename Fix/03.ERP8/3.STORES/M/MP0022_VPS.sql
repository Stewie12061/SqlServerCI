IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0022_VPS]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0022_VPS]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

   
 -- <Summary>  
 ---- MF0022 ( Menu Cập nhật đơn giá)
 ----   
 -- <Param>  
 ---- Update tự động đơn giá theo mặt hàng cho bộ định mức (cutstomize cho VPS) 
 -- <Return>  
 ----    
 -- <Reference>  
 ---- MF0025  
 -- <History>  
 ----Created by: Tiểu Mai on 20/09/2016
 ---- Modified by Tiểu Mai on 12/01/2017: Bổ sung chỉnh sửa cho VPS theo yêu cầu của CARE
 ---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
 ---- Modified by Tiểu Mai on 08/09/2017: Bổ sung chỉnh sửa cho VPS theo yêu cầu của CARE (chỉ update đơn giá <> 0)
 /*-- <Example>  
 MP0025_VPS 'JA', 'TEST'  
 ----*/  
CREATE PROCEDURE MP0022_VPS  
(  
	@DivisionID VARCHAR(50)  
)  
AS  
  
SELECT  InventoryID, InventoryName, UnitID, CONVERT(DECIMAL(28,8),0) AS UnitPrice  
INTO  #AT1302  
FROM  AT1302 WITH (NOLOCK)  
WHERE   IsStocked=1 and Disabled=0   
      AND  AT1302.InventoryID  NOT IN (SELECT  DISTINCT  ProductID FROM  MT1603 WITH (NOLOCK) )  
      AND  (AT1302.InventoryID IN  (('')) Or ( (0=0) ))  
      AND  AT1302.InventoryID NOT  IN    
      (SELECT  MaterialID FROM  MT0007  WITH (NOLOCK)  
       WHERE  MaterialGroupID IN   
         (SELECT  MaterialGroupID FROM  MT1603 WITH (NOLOCK)  
          WHERE   IsExtraMaterial=1)  
       AND  MaterialGroupID <>  '')  
       AND  AT1302.DivisionID IN (@DivisionID, '@@@')  
       ORDER  BY  AT1302.InventoryID  
  
UPDATE  T1  
SET   T1.UnitPrice = T.UnitPrice  
FROM  #AT1302 T1  
INNER JOIN   
(  
SELECT t0.InventoryID, t0.UnitPrice  
FROM   
(  
 (SELECT  b.InventoryID, a.VoucherDate, b.UnitPrice  
  FROM  AT2006 a WITH (NOLOCK) INNER  JOIN  AT2007 b WITH (NOLOCK) ON  a.VoucherID = b.VoucherID   
       WHERE KindVoucherID IN (1,5,7,9,15,17) AND  WareHouseID <> 'KTP' AND  CreditAccountID LIKE '331%' ) t0   
 INNER  JOIN    
 (SELECT  InventoryID, MAX(voucherdate) AS  voucherdate  
  FROM  AT2007 A WITH (NOLOCK) INNER  JOIN  AT2006 B WITH (NOLOCK) ON B.DivisionID = A.DivisionID AND  B.VoucherID = A.VoucherID  
  WHERE KindVoucherID IN (1,5,7,9,15,17)  AND  WareHouseID <> 'KTP' AND  CreditAccountID like '331%' 
  GROUP  BY  InventoryID  
 ) t2 ON  t0.InventoryID = t2.InventoryID AND  t0.VoucherDate = t2.voucherdate   
) ) T ON  T1.InventoryID = T.InventoryID  
  

UPDATE MT1603
SET MaterialPrice = (CASE WHEN ISNULL(T1.UnitPrice,0) <> 0 THEN T1.UnitPrice ELSE MaterialPrice END),
	MaterialAmount = (CASE WHEN ISNULL(T1.UnitPrice,0) <> 0 THEN T1.UnitPrice ELSE MaterialPrice END) * MT1603.MaterialQuantity,
	ConvertedUnit = ((CASE WHEN ISNULL(T1.UnitPrice,0) <> 0 THEN T1.UnitPrice ELSE MaterialPrice END) * MT1603.MaterialQuantity) / ProductQuantity
FROM MT1603 
LEFT JOIN #AT1302 T1 ON MT1603.MaterialID = T1.InventoryID AND MT1603.MaterialUnitID = T1.UnitID
WHERE  MT1603.DivisionID = @DivisionID

 
DROP TABLE #AT1302  
  

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
