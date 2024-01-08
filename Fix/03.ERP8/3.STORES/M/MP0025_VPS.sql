IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0025_VPS]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0025_VPS]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- MF0025
 ---- 
 -- <Param>
 ---- Load tự động đơn giá theo mặt hàng
 -- <Return>
 ----  
 -- <Reference>
 ---- MF0025
 -- <History>
 ----Created by: Bảo Thy, Date: 05/05/2016
 ---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
 ---- Modified by Tiểu Mai on 12/01/2017: Bổ sung chỉnh sửa cho VPS theo yêu cầu của CARE
 ---- Modified by Bảo Thy on 22/05/2017: Sửa danh mục dùng chung
 ---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
 /*-- <Example>
 MP0025_VPS 'JA', 'TEST'
 ----*/
CREATE PROCEDURE MP0025_VPS
(
	@DivisionID VARCHAR(50),
	@ApportionID VARCHAR(50)
)
AS

select InventoryID, InventoryName, UnitID, Convert(Decimal(28,8),0) as UnitPrice
into #AT1302
from AT1302 WITH (NOLOCK)
Where  IsStocked=1 and Disabled=0 
	  AND AT1302.DivisionID IN (@DivisionID,'@@@')
      and AT1302.InventoryID  NOT IN (Select Distinct ProductID From MT1603 WITH (NOLOCK) Where ApportionID=@ApportionID)
      And (AT1302.InventoryID in (('')) Or ( (0=0) ))
      And AT1302.InventoryID Not In 
      (Select MaterialID From MT0007  WITH (NOLOCK)
      Where MaterialGroupID In 
         (Select MaterialGroupID From MT1603 WITH (NOLOCK)
            Where ApportionID= @ApportionID And IsExtraMaterial=1)
       And MaterialGroupID <>  '')
       And AT1302.DivisionID IN (@DivisionID,'@@@')
       Order By AT1302.InventoryID

update T1
set  T1.UnitPrice = T.UnitPrice
from #AT1302 T1
INNER JOIN 
(
SELECT t0.InventoryID, t0.UnitPrice
FROM 
(
 (select b.InventoryID, a.VoucherDate, b.UnitPrice
 from AT2006 a WITH (NOLOCK) inner join AT2007 b WITH (NOLOCK) on a.VoucherID = b.VoucherID 
       WHERE KindVoucherID IN (1,5,7,9,15,17) and WareHouseID <> 'KTP' and CreditAccountID like '331%') t0 
 inner join 
 (select InventoryID, max(voucherdate) as voucherdate
 From AT2007 A WITH (NOLOCK) inner join AT2006 B WITH (NOLOCK) ON B.DivisionID = A.DivisionID and B.VoucherID = A.VoucherID
  WHERE KindVoucherID IN (1,5,7,9,15,17)  and WareHouseID <> 'KTP' and CreditAccountID like '331%'
 group by InventoryID
 ) t2 on t0.InventoryID = t2.InventoryID and t0.VoucherDate = t2.voucherdate 
) ) T on T1.InventoryID = T.InventoryID

SELECT * FROM #AT1302 ORDER BY InventoryID

DROP TABLE #AT1302

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

       
