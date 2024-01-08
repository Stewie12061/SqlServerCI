IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP2202]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP2202]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---Createdby: Vo Thanh Huong, date: 28/12/2004
---purpose: Tinh du tru nguyen vat lieu
---Date: Thuy Tuyen, 10/11/2009. Thêm  truong ObjectID, periodID
-- Edit: Tuyen, date : 18/11/2009. them truong Orderstatus
--- Modify on 28/02/2016 by Bảo Anh: Nhân thêm tỷ lệ hao hụt khi tính MaterialQuantity và ConvertedAmount nếu là Angel
--- Modified by Tiểu Mai on 26/07/2016: Customize ANGEL, làm tròn theo thiết lập số lẻ ở phân hệ M
--- Modified by Tiểu Mai on 10/12/2016: Customize ANGEL, bổ sung load NPL thay thế 
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Huỳnh Thử on 16/07/2021 : Tính lại cột số lượng = SL thành phẩm * SL NVL + SLx %hao hut + SL * ti le hao hut phế phẩm
---- Modified by Huỳnh Thử on 28/07/2021 : Tính lại cột số lượng = SL thành phẩm * SL NVL + (SLx * SL NVL * %hao hut )+ (SL * SL NVL * ti le hao hut phế phẩm)
/********************************************
'* Edited by: [GS] [Tố Oanh] [02/08/2010]
'********************************************/
---- Modified by Phương Thảo on 10/05/2016 : Sửa danh mục dùng chung
---- Modified by Thanh Lượng on 07/11/2022 : [2022/11/TA/0088] - Customize THIENNAM, thêm cột 'Số lượng NLV tồn kho'(WareHouseQuantity) 
---- Modified by Thành Sang on 08/02/2023 :  - Customize THIENNAM, cải tiến tốc độ Load khi lấy sl tồn kho
---- Modified by Thành Sang on 17/02/2023 :  - Bổ sung isnul cho cột RateWastage tránh kết quả = null 
---- Modified by Đức Duy on 10/04/2023 :  [2023/04/IS/0060] - Customize THIENNAM, cải tiến tốc độ load dữ liệu

CREATE PROCEDURE [dbo].[OP2202]  @DivisionID nvarchar(50),
				@ApportionType int, --0 - Dinh muc nguyen vat lieu Asoft-M, 1- Dinh muc ton kho Asoft-T, 2- Khong su dung dinh muc
				@EstimateID nvarchar(50)
AS
DECLARE @sSQL nvarchar(max), @sSQL1 nvarchar(max),
	@cur cursor,
	@ProductID nvarchar(50),
	@ApportionID nvarchar(50),
	@ProductQuantity decimal (28,8),
	@WareHouseID nvarchar(50),
	@sWhere nvarchar(4000),
	@Is621 tinyint,
	@Is622 tinyint,
	@Is627 tinyint,
	@CustomerIndex int,
	@DecimalQuantity INT,
	@sSQL3 nvarchar(max) = ''

Select @WareHouseID = WareHouseID From OT2201 WITH (NOLOCK)  Where DivisionID = @DivisionID and EstimateID = @EstimateID
SELECT @CustomerIndex = CustomerName From CustomerIndex
SELECT @DecimalQuantity = QuantityDecimal  FROM MT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID

SET @sSQL3 = N'
SELECT * 
FROM (
--- So du No cua tai khoan ton kho
SELECT  D17.DivisionID, ''BD'' AS D_C, D17.InventoryID, D16.WareHouseID, ActualQuantity AS SignQuantity 
From AT2017 AS D17 WITH (NOLOCK)
INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID in ('''+@DivisionID+''', ''@@@'')
INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.InventoryID = D17.InventoryID AND D02.DivisionID IN ('''+@DivisionID+''', ''@@@'')
LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID AND D04.DivisionID in ('''+@DivisionID+''', ''@@@'')
INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D16.WareHouseID AND D03.DivisionID in ('''+@DivisionID+''', ''@@@'')
Where isnull(DebitAccountID,'''') <>'''' AND D17.DivisionID LIKE '''+@DivisionID+'''

UNION ALL --- So du co hang ton kho

SELECT  D17.DivisionID, ''BC'' AS D_C, D17.InventoryID, D16.WareHouseID, -ActualQuantity AS SignQuantity 
FROM AT2017 AS D17 WITH (NOLOCK) 
INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID in ('''+@DivisionID+''', ''@@@'') 
INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.InventoryID = D17.InventoryID  AND D02.DivisionID IN ('''+@DivisionID+''', ''@@@'')
LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID  AND D04.DivisionID in ('''+@DivisionID+''', ''@@@'')
INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D16.WareHouseID  AND D03.DivisionID in ('''+@DivisionID+''', ''@@@'')
WHERE ISNULL(CreditAccountID,'''') <>'''' AND D17.DivisionID LIKE '''+@DivisionID+'''

UNION ALL  -- Nhap kho

SELECT  D07.DivisionID, ''D'' AS D_C, D07.InventoryID, D06.WareHouseID, ActualQuantity AS SignQuantity
FROM AT2007 AS D07 WITH (NOLOCK)
INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID in ('''+@DivisionID+''', ''@@@'')
INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D02.InventoryID = D07.InventoryID
LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID  AND D04.DivisionID in ('''+@DivisionID+''', ''@@@'')
INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D06.WareHouseID  AND D03.DivisionID in ('''+@DivisionID+''', ''@@@'')
WHERE D06.KindVoucherID in (1,3,5,7,9,15,17) AND Isnull(D06.TableID,'''') <> ''AT0114'' ------- Phiếu nhập bù của ANGEL
	AND D07.DivisionID LIKE '''+@DivisionID+'''
UNION ALL  -- xuat kho

SELECT  D07.DivisionID, ''C'' AS D_C, D07.InventoryID, D06.WareHouseID, -ActualQuantity AS SignQuantity
From AT2007 AS D07 WITH (NOLOCK)
INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID in ('''+@DivisionID+''', ''@@@'')
INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D02.InventoryID = D07.InventoryID
LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID AND D04.DivisionID in ('''+@DivisionID+''', ''@@@'')
INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D06.WareHouseID AND D03.DivisionID in ('''+@DivisionID+''', ''@@@'')
Where D06.KindVoucherID in (2,3,4,6,8,10,14,20) AND D07.DivisionID LIKE '''+@DivisionID+'''
) AV7000
WHERE WareHouseID = ''SG02'' '
	
If exists (Select Top 1 1 From sysObjects  Where XType = 'V' and Name = 'OV2204')
	Drop view OV2204
EXEC('Create view OV2204   ---tao boi OP2202
		as ' + @sSQL3)

Set @sSQL = 'Select DivisionID, EDetailID, ProductID, Orders as POrders,  ApportionID,  ProductQuantity, SOrderID, MOrderID, EstimateID
From OT2202 WITH (NOLOCK)
Where DivisionID = ''' + @DivisionID + ''' and EstimateID = ''' + @EstimateID + ''''

If exists (Select Top 1 1 From sysObjects  Where XType = 'V' and Name = 'OV2203')
	Drop view OV2203
EXEC('Create view OV2203   ---tao boi OP2202
		as ' + @sSQL)

If  @ApportionType = 0   ---DINH MUC M
Begin
	Select @Is621 = isnull(Is621,0), @Is622 = isnull(Is622, 0), @Is627 = isnull(Is627,0)  From OT0001 Where TypeID= 'ES'
	Select @Is621= isnull(@Is621,0), @Is622 = isnull(@Is622, 0), @Is627 = isnull(@Is627,0)

	If @Is621 = 0 and @Is622 = 0 and @Is627 = 0
		Set @sWhere = ''
	ELSE
		BEGIN
		Set @sWhere = '  and  T00.ExpenseID  in (' + case when @Is621 = 1 then  '''COST001'','  else '' end + 
				case when @Is622 = 1 then '''COST002'',' else '' end +
				case when @Is627 = 1 then '''COST003'',' else '' end 
		Set @sWhere  =  left(@sWhere, len(@sWhere) - 1) + ')'
		END	
				
	Set @sSQL = '
	Select ''' + @DivisionID + ''' as DivisionID, ''' + @EstimateID  + ''' as EstimateID, 
		OV2203.EDetailID, T00.MaterialID, OT2201.TranMonth, OT2201.TranYear,  OT2201.ObjectID,AT1202.ObjectName, OT2201.PeriodID,
		AT1302.InventoryName as MaterialName, T00.MaterialUnitID as UnitID, '''' as MDescripton, 
		OV2203.ProductID, 
		OV2203.ProductQuantity,'
		
	SET @sSQL1 = '
	UNION
	Select ''' + @DivisionID + ''' as DivisionID, ''' + @EstimateID  + ''' as EstimateID, 
		OV2203.EDetailID, MT0007.MaterialID, OT2201.TranMonth, OT2201.TranYear,  OT2201.ObjectID,AT1202.ObjectName, OT2201.PeriodID,
		AT1302.InventoryName as MaterialName, T00.MaterialUnitID as UnitID, '''' as MDescripton, 
		OV2203.ProductID, 
		OV2203.ProductQuantity,'

	IF @CustomerIndex <> 57
		Set @sSQL = @sSQL + 'isnull(T00.QuantityUnit,0)	* OV2203.ProductQuantity + (isnull(T00.QuantityUnit,0) * OV2203.ProductQuantity * isnull(RateWastage,0))/100 + (isnull(T00.QuantityUnit,0) * OV2203.ProductQuantity * isnull(RateWastage02,0))/100 as MaterialQuantity,
							 	isnull(T00.StandardQuantityUnit,0)	* OV2203.ProductQuantity + (isnull(T00.QuantityUnit,0) * OV2203.ProductQuantity * isnull(RateWastage,0)) / 100 + (isnull(T00.QuantityUnit,0) * OV2203.ProductQuantity * isnull(RateWastage02,0)) / 100 as StandardMaterialQuantity,			
								isnull(T00.MaterialPrice,0) * (isnull(T00.QuantityUnit,0)	* OV2203.ProductQuantity + (isnull(T00.QuantityUnit,0) * OV2203.ProductQuantity * isnull(RateWastage,0))/100 + (isnull(T00.QuantityUnit,0) * OV2203.ProductQuantity * isnull(RateWastage02,0))/100) as ConvertedAmount,'
	ELSE --- Angel
	BEGIN
		Set @sSQL = @sSQL + 'Round((isnull(T00.QuantityUnit,0)	* OV2203.ProductQuantity * case when Isnull(T00.RateWastage,0) = 0 then 1 else T00.RateWastage end),'+CONVERT(NVARCHAR(5),@DecimalQuantity)+') as MaterialQuantity,
							isnull(T00.ConvertedUnit,0) * OV2203.ProductQuantity * Isnull(T00.RateWastage,0) as ConvertedAmount,'
		
		Set @sSQL1 = @sSQL1 + 'Round((isnull(T00.QuantityUnit,0)	* OV2203.ProductQuantity * case when Isnull(T00.RateWastage,0) = 0 then 1 else T00.RateWastage end) * Isnull(MT0007.CoValues,1),'+CONVERT(NVARCHAR(5),@DecimalQuantity)+') as MaterialQuantity,
							isnull(T00.ConvertedUnit,0) * OV2203.ProductQuantity * Isnull(T00.RateWastage,0) * Isnull(MT0007.CoValues,1) as ConvertedAmount,'
	END
		
IF @CustomerIndex =92 --THIENNAM
BEGIN
		Set @sSQL = @sSQL + '
		isnull(T00.ConvertedUnit,0) as ConvertedUnit,
		isnull(T00.QuantityUnit,0) as QuantityUnit,
		isnull(T00.StandardQuantityUnit,0) as StandardQuantityUnit,				
		isnull(T00.MaterialPrice,0) as MaterialPrice,	
		isnull(T00.StandardMaterialPrice,0) as StandardMaterialPrice,			
		T00.ExpenseID, 
		T00.MaterialTypeID,  
		MT0699.UserName as MaterialTypeName,
		''' + isnull(@WareHouseID, '') + ''' as WareHouseID,
		CASE WHEN  ''' + Isnull(@WareHouseID, '') + '''  = ''''  THEN 0 else 1 end as IsPicking, 
		POrders , OT2201.OrderStatus,
		(Select SUM(ISNULL(SignQuantity, 0)) AS Quantity  
			 FROM OV2204 
			 WHERE   
			 OV2204.WareHouseID = ''SG02''  
			 AND OV2204.InventoryID = ISNULL((SELECT TOP 1 MT0007.MaterialID  
            FROM MT0007 WITH (NOLOCK)  
            INNER JOIN MT0006 WITH (NOLOCK) ON MT0006.MaterialGroupID = MT0007.MaterialGroupID  
            INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID = MT0006.MaterialID  
            WHERE MT0006.MaterialID = T00.MaterialID), T00.MaterialID)) AS WareHouseQuantity,
		T00.Parameter01, T00.Parameter02, T00.Parameter03, T00.Parameter04, T00.Parameter05 
	From MT1603 T00 WITH (NOLOCK)  inner join MT1602 WITH (NOLOCK)   on T00.ApportionID = MT1602.ApportionID And T00.DivisionID = MT1602.DivisionID
	inner join OV2203  on OV2203.ApportionID = T00.ApportionID and  T00.ProductID = OV2203.ProductID And T00.DivisionID = OV2203.DivisionID
	left  join AT1302 WITH (NOLOCK)  on AT1302.DivisionID IN (''@@@'', T00.DivisionID) AND AT1302.InventoryID = T00.MaterialID
	inner join OT2201 WITH (NOLOCK) on OT2201.EstimateID = ''' + @EstimateID + ''' and OT2201.DivisionID = ''' + @DivisionID + ''' And T00.DivisionID = OT2201.DivisionID
	left join MT0699 WITH (NOLOCK) on MT0699.MaterialTypeID = T00.MaterialTypeID And MT0699.DivisionID = T00.DivisionID
	Left join AT1202 WITH (NOLOCK) on AT1202.ObjectID = OT2201.ObjectID
	Where isnull(T00.ConvertedUnit,0) + isnull(T00.QuantityUnit,0) > 0  ' + 
		@sWhere  

END
ELSE --Luồng chuẩn
	Set @sSQL = @sSQL + '
		isnull(T00.ConvertedUnit,0) as ConvertedUnit,
		isnull(T00.QuantityUnit,0) as QuantityUnit,
		isnull(T00.StandardQuantityUnit,0) as StandardQuantityUnit,				
		isnull(T00.MaterialPrice,0) as MaterialPrice,	
		isnull(T00.StandardMaterialPrice,0) as StandardMaterialPrice,			
		T00.ExpenseID, 
		T00.MaterialTypeID,  
		MT0699.UserName as MaterialTypeName,
		''' + isnull(@WareHouseID, '') + ''' as WareHouseID,
		CASE WHEN  ''' + Isnull(@WareHouseID, '') + '''  = ''''  THEN 0 else 1 end as IsPicking, 
		POrders , OT2201.OrderStatus, T00.Parameter01, T00.Parameter02, T00.Parameter03, T00.Parameter04, T00.Parameter05 
	From MT1603 T00 WITH (NOLOCK)  inner join MT1602 WITH (NOLOCK)   on T00.ApportionID = MT1602.ApportionID And T00.DivisionID = MT1602.DivisionID
	inner join OV2203  on OV2203.ApportionID = T00.ApportionID and  T00.ProductID = OV2203.ProductID And T00.DivisionID = OV2203.DivisionID
	left  join AT1302 WITH (NOLOCK)  on AT1302.DivisionID IN (''@@@'', T00.DivisionID) AND AT1302.InventoryID = T00.MaterialID
	inner join OT2201 WITH (NOLOCK) on OT2201.EstimateID = ''' + @EstimateID + ''' and OT2201.DivisionID = ''' + @DivisionID + ''' And T00.DivisionID = OT2201.DivisionID
	left join MT0699 WITH (NOLOCK) on MT0699.MaterialTypeID = T00.MaterialTypeID And MT0699.DivisionID = T00.DivisionID
	Left join AT1202 WITH (NOLOCK) on AT1202.ObjectID = OT2201.ObjectID
	Where isnull(T00.ConvertedUnit,0) + isnull(T00.QuantityUnit,0) > 0  ' + 
		@sWhere  
		
	Set @sSQL1 = @sSQL1 + '
		isnull(T00.ConvertedUnit,0) * Isnull(MT0007.CoValues,1) as ConvertedUnit,
		isnull(T00.QuantityUnit,0) * Isnull(MT0007.CoValues,1) as QuantityUnit,
		isnull(T00.MaterialPrice,0) * Isnull(MT0007.CoValues,1) as MaterialPrice,	
		T00.ExpenseID, 
		T00.MaterialTypeID,  
		MT0699.UserName as MaterialTypeName,
		''' + isnull(@WareHouseID, '') + ''' as WareHouseID,
		CASE WHEN  ''' + Isnull(@WareHouseID, '') + '''  = ''''  THEN 0 else 1 end as IsPicking, 
		POrders , OT2201.OrderStatus
	From MT1603 T00 WITH (NOLOCK)  inner join MT1602 WITH (NOLOCK)   on T00.ApportionID = MT1602.ApportionID And T00.DivisionID = MT1602.DivisionID
	inner join OV2203  on OV2203.ApportionID = T00.ApportionID and  T00.ProductID = OV2203.ProductID And T00.DivisionID = OV2203.DivisionID
	inner join OT2201 WITH (NOLOCK)  on OT2201.EstimateID = ''' + @EstimateID + ''' and OT2201.DivisionID = ''' + @DivisionID + ''' And T00.DivisionID = OT2201.DivisionID
	left join MT0699 WITH (NOLOCK) on MT0699.MaterialTypeID = T00.MaterialTypeID And MT0699.DivisionID = T00.DivisionID
	Left join AT1202 WITH (NOLOCK) on AT1202.ObjectID = OT2201.ObjectID
	INNER JOIN MT0007 WITH (NOLOCK) ON MT0007.DivisionID = T00.DivisionID AND MT0007.MaterialGroupID = T00.MaterialGroupID
	left  join AT1302 WITH (NOLOCK)  on AT1302.DivisionID IN (''@@@'', MT0007.DivisionID) AND AT1302.InventoryID = MT0007.MaterialID
	Where isnull(T00.ConvertedUnit,0) + isnull(T00.QuantityUnit,0) > 0  ' + 
		@sWhere 

End
Else IF @ApportionType = 1 --DINH MUC T
	Set @sSQL = '
	Select  ''' + @DivisionID + ''' as DivisionID, ''' + @EstimateID  + ''' as EstimateID, EDetailID, T00.ItemID as MaterialID, 
		OT2201.TranMonth, OT2201.TranYear,  
		AT1302.InventoryName as MaterialName, 
		T00.ItemUnitID as UnitID, '''' as MDescripton, OV2203.ProductID,  OT2201.ObjectID,AT1202.ObjectName,OT2201.PeriodID,
		OV2203.ProductQuantity, 
		case when isnull(T00.InventoryQuantity, 0) = 0 then 0 else isnull(T00.ItemQuantity,0) * isnull(OV2203.ProductQuantity,0)/ T00.InventoryQuantity end  as MaterialQuantity,  
		case when isnull(T00.InventoryQuantity, 0) = 0 then 0 else isnull(T00.ItemQuantity,0) * isnull(OV2203.ProductQuantity,0)/ T00.InventoryQuantity end  as StandardMaterialQuantity,  		
		NULL as ConvertedAmount,			
		NULL as ConvertedUnit,
		case when isnull(T00.InventoryQuantity, 0)   = 0 then 0 else isnull(T00.ItemQuantity,0)/T00.InventoryQuantity end as QuantityUnit,
		case when isnull(T00.InventoryQuantity, 0)   = 0 then 0 else isnull(T00.ItemQuantity,0)/T00.InventoryQuantity end as StandardQuantityUnit,		
		NULL as MaterialPrice, 
		NULL as StandardMaterialPrice,			
		''COST001'' as ExpenseID, 
		NULL as MaterialTypeID,
		NULL as MaterialTypeName,
		''' + isnull(@WareHouseID, '') + ''' as WareHouseID,
		CASE WHEN  ''' + Isnull(@WareHouseID, '') + '''  = ''''  THEN 0 else 1 end as IsPicking, OV2203.POrders, OT2201.OrderStatus,
		NULL AS Parameter01, NULL AS Parameter02, NULL AS Parameter03, NULL AS Parameter04, NULL AS Parameter05 		
	From AT1326 T00  WITH (NOLOCK) 	inner join OV2203  on OV2203.ApportionID = T00.KITID and  OV2203.ProductID =  T00.InventoryID
	inner join AT1302 WITH (NOLOCK)  on AT1302.DivisionID IN (''@@@'', T00.DivisionID) AND AT1302.InventoryID = T00.ItemID
	inner join OT2201 WITH (NOLOCK) on OT2201.EstimateID = ''' + @EstimateID + ''' and OT2201.DivisionID = ''' + @DivisionID + ''' And T00.DivisionID = OT2201.DivisionID
	Left join AT1202 WITH (NOLOCK) on AT1202.ObjectID = OT2201.ObjectID
	Where isnull(T00.ItemID,'''') <> ''''' 

ELSE -- KHONG SU DUNG DINH MUC
BEGIN
	Set @sSQL = '
	Select  ''' + @DivisionID + ''' as DivisionID, ''' + @EstimateID  + ''' as EstimateID, EDetailID, T00.ItemID as MaterialID, 
		OT2201.TranMonth, OT2201.TranYear,  
		AT1302.InventoryName as MaterialName, 
		T00.ItemUnitID as UnitID, '''' as MDescripton, OV2203.ProductID,  OT2201.ObjectID,AT1202.ObjectName,OT2201.PeriodID,
		OV2203.ProductQuantity, 
		case when isnull(T00.InventoryQuantity, 0) = 0 then 0 else 
		isnull(T00.ItemQuantity,0) end  as MaterialQuantity ,  
		isnull(T00.ItemQuantity,0) end  as StandardMaterialQuantity,  		
		NULL as ConvertedAmount,			
		NULL as ConvertedUnit,
		case when isnull(T00.InventoryQuantity, 0)   = 0 then 0 else isnull(T00.ItemQuantity,0)/T00.InventoryQuantity end as QuantityUnit,
		case when isnull(T00.InventoryQuantity, 0)   = 0 then 0 else isnull(T00.ItemQuantity,0)/T00.InventoryQuantity end as StandardQuantityUnit,			
		NULL as MaterialPrice, 
		NULL as StandardMaterialPrice,				
		''COST001'' as ExpenseID, 
		NULL as MaterialTypeID,
		NULL as MaterialTypeName,
		''' + isnull(@WareHouseID, '') + ''' as WareHouseID,
		CASE WHEN  ''' + Isnull(@WareHouseID, '') + '''  = ''''  THEN 0 else 1 end as IsPicking, OV2203.POrders, OT2201.OrderStatus, T00.SOrderID, T00.MOrderID,
		NULL AS Parameter01, NULL AS Parameter02, NULL AS Parameter03, NULL AS Parameter04, NULL AS Parameter05 		
	From OT1326 T00  WITH (NOLOCK)	inner join OV2203  on OV2203.EstimateID = T00.EstimateID and isnull(OV2203.SOrderID,'''') = isnull(T00.SOrderID,'''') and isnull(OV2203.MOrderID, '''') = isnull(T00.MOrderID, '''') and  OV2203.ProductID =  T00.InventoryID And OV2203.DivisionID =  T00.DivisionID
	inner join AT1302 WITH (NOLOCK)  on AT1302.DivisionID IN (''@@@'', T00.DivisionID) AND AT1302.InventoryID = T00.ItemID
	inner join OT2201 WITH (NOLOCK)  on OT2201.EstimateID = ''' + @EstimateID + ''' and OT2201.DivisionID = ''' + @DivisionID + ''' And T00.DivisionID = OT2201.DivisionID
	Left join AT1202 WITH (NOLOCK) on AT1202.ObjectID = OT2201.ObjectID
	Where isnull(T00.ItemID,'''') <> ''''' 
END
print @sSQL3
print @sSQL

If exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name = 'OV2202')
	Drop view OV2202
IF @CustomerIndex = 57 --------- ANGEL
	EXEC('Create view OV2202 ---tao boi OP2202
			as ' + @sSQL + @sSQL1)
ELSE 
	EXEC('Create view OV2202 ---tao boi OP2202
			as ' + @sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
