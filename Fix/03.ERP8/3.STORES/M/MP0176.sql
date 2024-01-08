IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0176]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0176]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Customize Angel: In báo cáo kế hoạch sản xuất theo công đoạn
---- Created by Bảo Anh, Date: 10/03/2016
---- Modified on 26/12/2016 by Tiểu Mai: Bổ sung cho ANGEL lấy số lượng QuantityUnit
---- Modified on 26/04/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified on 13/10/2020 by Nhựt Trường: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
---- MP0176 'CTY','DG','%',1,'ZZZ'

CREATE PROCEDURE [dbo].[MP0176] 
    @DivisionID NVARCHAR(50),
	@TeamID NVARCHAR(50),
	@InventoryTypeID nvarchar(50),
	@IsDetail tinyint,	--- 0: tổng hợp, 1: chi tiết
    @VoucherID AS NVARCHAR(50)
AS

IF @IsDetail = 0	--- in KHSX tổng hợp từng công đoạn
	SELECT	OT02.ProductID, T01.InventoryName as ProductName, T04.UnitName as ProductUnitName,
			OT01.TeamID, OT02.ProductQuantity, T14.MinQuantity as ProductMinQuantity,
			T01.I01ID, T01.I02ID, T01.I03ID, T01.I04ID, T01.I05ID,
			T151.AnaName as I01Name, T152.AnaName as I02Name, T153.AnaName as I03Name, T154.AnaName as I04Name, T155.AnaName as I05Name,   
			OT03.MaterialID, T011.InventoryName as MaterialName, T041.UnitName as MaterialUnitName,
			OT03.MaterialQuantity, --T141.MinQuantity as MaterialMinQuantity,
			MT1603.QuantityUnit,
			MT1603.RateWastage  

	FROM OT2203 OT03
	INNER JOIN OT2202 OT02 On OT03.DivisionID = OT02.DivisionID And OT03.EstimateID = OT02.EstimateID and OT03.EDetailID = OT02.EDetailID
	INNER JOIN OT2201 OT01 On OT03.DivisionID = OT01.DivisionID And OT03.EstimateID = OT01.EstimateID
	LEFT JOIN MT1603 ON MT1603.DivisionID = OT02.DivisionID AND MT1603.ProductID = OT02.ProductID AND MT1603.ApportionID = OT02.ApportionID AND OT03.MaterialID = MT1603.MaterialID
	LEFT JOIN AT1302 T01 On OT02.ProductID = T01.InventoryID AND T01.DivisionID IN (OT02.DivisionID,'@@@')
	LEFT JOIN AT1302 T011 On OT03.MaterialID = T011.InventoryID AND T011.DivisionID IN (OT03.DivisionID,'@@@')
	LEFT JOIN AT1304 T04 On OT02.UnitID = T04.UnitID
	LEFT JOIN AT1304 T041 On OT03.UnitID = T041.UnitID
	LEFT JOIN AT1314 T14 On OT02.ProductID = T14.InventoryID and (OT01.VoucherDate between T14.FromDate and T14.ToDate)
	--LEFT JOIN AT1314 T141 On OT03.DivisionID = T141.DivisionID And OT03.MaterialID = T141.InventoryID and (OT01.VoucherDate between T141.FromDate and T141.ToDate)
	LEFT JOIN AT1015 T151 On T01.I01ID = T151.AnaID And T151.AnaTypeID = 'I01'
	LEFT JOIN AT1015 T152 On T01.I02ID = T152.AnaID And T152.AnaTypeID = 'I02'
	LEFT JOIN AT1015 T153 On T01.I03ID = T153.AnaID And T153.AnaTypeID = 'I03'
	LEFT JOIN AT1015 T154 On T01.I04ID = T154.AnaID And T154.AnaTypeID = 'I04'
	LEFT JOIN AT1015 T155 On T01.I05ID = T155.AnaID And T155.AnaTypeID = 'I05'
	WHERE OT03.DivisionID = @DivisionID AND OT03.ExpenseID = 'COST001' AND OT03.EstimateID = @VoucherID
	AND T01.InventoryTypeID like @InventoryTypeID
	ORDER BY OT02.ProductID, OT03.Orders


ELSE	--- in KHSX chi tiết theo từng công đoạn (lệnh sản xuất)
	SELECT	InventoryID as ProductID, InventoryName as ProductName, UnitName as ProductUnitName, TableName, BlockName, EmployeeNum, EmployeePower, Quantity, Power, Hours,
			I01ID, I02ID, I03ID, I04ID, I05ID, I01Name, I02Name, I03Name, I04Name, I05Name,
			--- sản lượng
			sum(D01) as D01, sum(D02) as D02, sum(D03) as D03, sum(D04) as D04, sum(D05) as D05,
			sum(D06) as D06, sum(D07) as D07, sum(D08) as D08, sum(D09) as D09, sum(D10) as D10,
			sum(D11) as D11, sum(D12) as D12, sum(D13) as D13, sum(D14) as D14, sum(D15) as D15,
			sum(D16) as D16, sum(D17) as D17, sum(D18) as D18, sum(D19) as D19, sum(D20) as D20,
			sum(D21) as D21, sum(D22) as D22, sum(D23) as D23, sum(D24) as D24, sum(D25) as D25,
			sum(D26) as D26, sum(D27) as D27, sum(D28) as D28, sum(D29) as D29, sum(D30) as D30, sum(D31) as D31,
			--- giờ
			case when Isnull(Power,0) = 0 then 0 else sum(D01)/Power end as H01,
			case when Isnull(Power,0) = 0 then 0 else sum(D02)/Power end as H02,
			case when Isnull(Power,0) = 0 then 0 else sum(D03)/Power end as H03,
			case when Isnull(Power,0) = 0 then 0 else sum(D04)/Power end as H04,
			case when Isnull(Power,0) = 0 then 0 else sum(D05)/Power end as H05,
			case when Isnull(Power,0) = 0 then 0 else sum(D06)/Power end as H06,
			case when Isnull(Power,0) = 0 then 0 else sum(D07)/Power end as H07,
			case when Isnull(Power,0) = 0 then 0 else sum(D08)/Power end as H08,
			case when Isnull(Power,0) = 0 then 0 else sum(D09)/Power end as H09,
			case when Isnull(Power,0) = 0 then 0 else sum(D10)/Power end as H10,
			case when Isnull(Power,0) = 0 then 0 else sum(D11)/Power end as H11,
			case when Isnull(Power,0) = 0 then 0 else sum(D12)/Power end as H12,
			case when Isnull(Power,0) = 0 then 0 else sum(D13)/Power end as H13,
			case when Isnull(Power,0) = 0 then 0 else sum(D14)/Power end as H14,
			case when Isnull(Power,0) = 0 then 0 else sum(D15)/Power end as H15,
			case when Isnull(Power,0) = 0 then 0 else sum(D16)/Power end as H16,
			case when Isnull(Power,0) = 0 then 0 else sum(D17)/Power end as H17,
			case when Isnull(Power,0) = 0 then 0 else sum(D18)/Power end as H18,
			case when Isnull(Power,0) = 0 then 0 else sum(D19)/Power end as H19,
			case when Isnull(Power,0) = 0 then 0 else sum(D20)/Power end as H20,
			case when Isnull(Power,0) = 0 then 0 else sum(D21)/Power end as H21,
			case when Isnull(Power,0) = 0 then 0 else sum(D22)/Power end as H22,
			case when Isnull(Power,0) = 0 then 0 else sum(D23)/Power end as H23,
			case when Isnull(Power,0) = 0 then 0 else sum(D24)/Power end as H24,
			case when Isnull(Power,0) = 0 then 0 else sum(D25)/Power end as H25,
			case when Isnull(Power,0) = 0 then 0 else sum(D26)/Power end as H26,
			case when Isnull(Power,0) = 0 then 0 else sum(D27)/Power end as H27,
			case when Isnull(Power,0) = 0 then 0 else sum(D28)/Power end as H28,
			case when Isnull(Power,0) = 0 then 0 else sum(D29)/Power end as H29,
			case when Isnull(Power,0) = 0 then 0 else sum(D30)/Power end as H30,
			case when Isnull(Power,0) = 0 then 0 else sum(D31)/Power end as H31
	FROM (
	SELECT	MT70.InventoryID, AT1302.InventoryName, AT1304.UnitName, Isnull(AT0150.MachineName, AT0165.TableName) as TableName, AT0152.BlockName,
			MT70.EmployeeNum, MT70.EmployeePower, MT70.Quantity, MT70.Power, MT70.Hours,
			AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID,
			T151.AnaName as I01Name, T152.AnaName as I02Name, T153.AnaName as I03Name, T154.AnaName as I04Name, T155.AnaName as I05Name,
			case when day(MT71.BeginDate) = 1 then MT71.Quantity else 0 end as D01,
			case when day(MT71.BeginDate) = 2 then MT71.Quantity else 0 end as D02,
			case when day(MT71.BeginDate) = 3 then MT71.Quantity else 0 end as D03,
			case when day(MT71.BeginDate) = 4 then MT71.Quantity else 0 end as D04,
			case when day(MT71.BeginDate) = 5 then MT71.Quantity else 0 end as D05,
			case when day(MT71.BeginDate) = 6 then MT71.Quantity else 0 end as D06,
			case when day(MT71.BeginDate) = 7 then MT71.Quantity else 0 end as D07,
			case when day(MT71.BeginDate) = 8 then MT71.Quantity else 0 end as D08,
			case when day(MT71.BeginDate) = 9 then MT71.Quantity else 0 end as D09,
			case when day(MT71.BeginDate) = 10 then MT71.Quantity else 0 end as D10,
			case when day(MT71.BeginDate) = 11 then MT71.Quantity else 0 end as D11,
			case when day(MT71.BeginDate) = 12 then MT71.Quantity else 0 end as D12,
			case when day(MT71.BeginDate) = 13 then MT71.Quantity else 0 end as D13,
			case when day(MT71.BeginDate) = 14 then MT71.Quantity else 0 end as D14,
			case when day(MT71.BeginDate) = 15 then MT71.Quantity else 0 end as D15,
			case when day(MT71.BeginDate) = 16 then MT71.Quantity else 0 end as D16,
			case when day(MT71.BeginDate) = 17 then MT71.Quantity else 0 end as D17,
			case when day(MT71.BeginDate) = 18 then MT71.Quantity else 0 end as D18,
			case when day(MT71.BeginDate) = 19 then MT71.Quantity else 0 end as D19,
			case when day(MT71.BeginDate) = 20 then MT71.Quantity else 0 end as D20,
			case when day(MT71.BeginDate) = 21 then MT71.Quantity else 0 end as D21,
			case when day(MT71.BeginDate) = 22 then MT71.Quantity else 0 end as D22,
			case when day(MT71.BeginDate) = 23 then MT71.Quantity else 0 end as D23,
			case when day(MT71.BeginDate) = 24 then MT71.Quantity else 0 end as D24,
			case when day(MT71.BeginDate) = 25 then MT71.Quantity else 0 end as D25,
			case when day(MT71.BeginDate) = 26 then MT71.Quantity else 0 end as D26,
			case when day(MT71.BeginDate) = 27 then MT71.Quantity else 0 end as D27,
			case when day(MT71.BeginDate) = 28 then MT71.Quantity else 0 end as D28,
			case when day(MT71.BeginDate) = 29 then MT71.Quantity else 0 end as D29,
			case when day(MT71.BeginDate) = 30 then MT71.Quantity else 0 end as D30,
			case when day(MT71.BeginDate) = 31 then MT71.Quantity else 0 end as D31
	FROM MT0170 MT70
	LEFT JOIN AT1302 On MT70.InventoryID = AT1302.InventoryID AND AT1302.DivisionID IN (MT70.DivisionID,'@@@')
	LEFT JOIN AT1304 On MT70.UnitID = AT1304.UnitID
	LEFT JOIN AT0150 On MT70.DivisionID = AT0150.DivisionID And MT70.TableID = AT0150.MachineID
	LEFT JOIN AT0165 On MT70.DivisionID = AT0165.DivisionID And MT70.TableID = AT0165.TableID
	LEFT JOIN AT0152 On MT70.DivisionID = AT0152.DivisionID And MT70.BlockID = AT0152.BlockID
	LEFT JOIN MT0171 MT71 On MT70.DivisionID = MT71.DivisionID And MT70.TransactionID = MT71.TransactionID
	LEFT JOIN AT1015 T151 On AT1302.I01ID = T151.AnaID And T151.AnaTypeID = 'I01' AND AT1302.DivisionID IN (T151.DivisionID,'@@@')
	LEFT JOIN AT1015 T152 On AT1302.I02ID = T152.AnaID And T152.AnaTypeID = 'I02' AND AT1302.DivisionID IN (T152.DivisionID,'@@@')
	LEFT JOIN AT1015 T153 On AT1302.I03ID = T153.AnaID And T153.AnaTypeID = 'I03' AND AT1302.DivisionID IN (T153.DivisionID,'@@@')
	LEFT JOIN AT1015 T154 On AT1302.I04ID = T154.AnaID And T154.AnaTypeID = 'I04' AND AT1302.DivisionID IN (T154.DivisionID,'@@@')
	LEFT JOIN AT1015 T155 On AT1302.I05ID = T155.AnaID And T155.AnaTypeID = 'I05' AND AT1302.DivisionID IN (T155.DivisionID,'@@@')
	WHERE MT70.DivisionID = @DivisionID AND MT70.VoucherID = @VoucherID AND MT70.TeamID = @TeamID AND AT1302.I06ID = 'TP' AND AT1302.InventoryID like @InventoryTypeID
	) A
	GROUP BY InventoryID, InventoryName, UnitName, TableName, BlockName, EmployeeNum, EmployeePower, Quantity, Power, Hours,
				I01ID, I02ID, I03ID, I04ID, I05ID, I01Name, I02Name, I03Name, I04Name, I05Name
	

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
