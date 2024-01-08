IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0029]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0029]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Báo cáo tồn kho theo định mức (Customize cho PMT)
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Bảo Thy, Date: 26/04/2016
 ---- Modified on 22/05/2017 by Bảo Thy: Sửa danh mục dùng chung
 ---- Modified on 23/11/2017 by Khả Vi: Fix lỗi của một số định mức không xuất excel được
 ---- Modified on 13/10/2020 by Nhựt Trường: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
 /*-- <Example>
 	MP0029 @DivisionID='PMT',@ApportionID = 'DLED 5-2016', @Date = '2016-05-24 00:00:00.000'
 ----*/

CREATE PROCEDURE MP0029

(
 @DivisionID VARCHAR(50),
 @ApportionID VARCHAR(50),
 @Date DATETIME
)
AS 
DECLARE @ProductID VARCHAR(50),
		@MaterialID VARCHAR(50),
		@Cur CURSOR		

CREATE TABLE #MP0029 ( MaterialID VARCHAR(50),MaterialName NVARCHAR(250),WHQuantity DECIMAL(28,8) )
---Tính tồn kho theo ngày của NVL
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT distinct MaterialID
FROM MT1603 WITH (NOLOCK) WHERE MT1603.DivisionID = @DivisionID
AND MT1603.ApportionID = @ApportionID
AND MT1603.ExpenseID ='COST001'

OPEN @Cur
FETCH NEXT FROM @Cur INTO @MaterialID
WHILE @@FETCH_STATUS = 0
BEGIN

	INSERT INTO #MP0029 (MaterialID, MaterialName, WHQuantity)
	SELECT InventoryID, InventoryName, SUM(CASE WHEN D_C in ('BD','D') THEN ActualQuantity ELSE ActualQuantity* (-1) END) AS WHQuantity
	FROM	AV7000
	WHERE WareHouseID = 'KNVLL'
	AND AV7000.InventoryID = @MaterialID
	AND CONVERT(DATE,AV7000.VoucherDate) < CONVERT(DATE,@Date)
	AND AV7000.DivisionID = @DivisionID
	GROUP BY  InventoryID,InventoryName

FETCH NEXT FROM @Cur INTO @MaterialID
END 
Close @Cur	

----Load báo cáo	

SELECT DISTINCT MT1603.ApportionID, MT1602.[Description],
	MT1603.ProductID, AT32.InventoryName as ProductName,
	MT1603.MaterialID, AT33.InventoryName  as MaterialName,
	IsNull(MT1603.MaterialUnitID, AT33.UnitID) AS MaterialUnitID, 
	MT1603.MaterialQuantity, ISNULL(#MP0029.WHQuantity,0) WHQuantity
 From MT1603 WITH (NOLOCK)	
LEFT JOIN AT1302 AT32 WITH (NOLOCK) on AT32.InventoryID = MT1603.ProductID AND AT32.DivisionID IN (MT1603.DivisionID,'@@@')
LEFT JOIN AT1302 AT33 WITH (NOLOCK) on AT33.InventoryID = MT1603.MaterialID AND AT33.DivisionID IN (MT1603.DivisionID,'@@@')
LEFT JOIN MT1602 WITH (NOLOCK) on MT1602.ApportionID = MT1603.ApportionID and  MT1602.DivisionID = MT1603.DivisionID
LEFT JOIN MT0699 WITH (NOLOCK) on  MT0699.MaterialTypeID = MT1603.MaterialTypeID and  MT0699.DivisionID = MT1603.DivisionID
LEFT JOIN #MP0029 ON MT1603.MaterialID = #MP0029.MaterialID
WHERE MT1603.ApportionID = @ApportionID
AND MT1603.ExpenseID ='COST001'
AND MT1603.DivisionID = @DivisionID
ORDER BY MT1603.ProductID,MT1603.MaterialID



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
