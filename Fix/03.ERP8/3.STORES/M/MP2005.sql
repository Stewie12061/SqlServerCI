IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---Created by: Vo Thanh Huong, date: 09/11/2004
---purpose: In Phieu san xuat
--Edit by : Nguyen Quoc Huy
---- Modified by Tieu Mai on 04/12/2015: Bo sung 20 cot quy cach khi có thiet lap quan ly mat hang theo quy cach.
---- Modified by Tieu Mai on 04/01/2016: Bo sung truong BatchNo cua table MT0107 (phieu pha tron)
---- Modified by Tiểu Mai on 29/01/2016: Lấy tên thiết lập mã phân tích cho An Phát
---- Modified by Tiểu Mai on 06/06/2016: Bổ sung WITH (NOLOCK)
---- Modified by Bảo Anh on 26/04/2017: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.

/********************************************
'* Edited by: [GS] [Mỹ Tuyền] [02/08/2010]
'********************************************/

CREATE PROCEDURE [dbo].[MP2005] 
    @DivisionID NVARCHAR(50), 
    @VoucherID NVARCHAR(50)
AS

DECLARE @sSQL NVARCHAR(4000),
		@sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sSQL3 NVARCHAR(MAX)
SET @sSQL2 = ''
SET @sSQL3 = ''
IF EXISTS (SELECT top 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	Set @sSQL = '
SELECT 
    MT2004.VoucherNo, 
    MT2004.VoucherDate, 
    MT2005.DepartmentID, 
    MT2005.DivisionID, 
    ISNULL(DepartmentName, '''') AS DepartmentName, 
    MT2004.KCSEmployeeID, 
    ISNULL(AT1103_KCS.FullName, '''') AS KCSFullName, 
    MT2004.EmployeeID, 
    ISNULL(AT1103.FullName, '''') AS FullName, 
    MT2005.InventoryID, 
    AT1302.InventoryName, 
    ISNULL(UnitName, '''') AS UnitName, 
    MT2005.ActualQuantity, 
    MT2005.LinkNo, 
    MT2005.PlanID AS PlanNo, 
    MT2005.Description AS Notes, 
    MT2004.Description, 
    MT2005.WorkID, 
    MT1701.WorkName, 
    MT2005.LevelID, 
    MT1702.LevelName, 
    MT2005.Finish, 
    MT2005.Orders, 
    AT1302_P.InventoryName AS ProductName,
    MT2005.Ana01ID, MT2005.Ana02ID, MT2005.Ana03ID, MT2005.Ana04ID, MT2005.Ana05ID, 
			OT1002_1.AnaName AS AnaName1,
			OT1002_2.AnaName AS AnaName2,
			OT1002_3.AnaName AS AnaName3,
			OT1002_4.AnaName AS AnaName4,
			OT1002_5.AnaName AS AnaName5,
    M89.S01ID, M89.S02ID, M89.S03ID, M89.S04ID, M89.S05ID, M89.S06ID, M89.S07ID, M89.S08ID, M89.S09ID, M89.S10ID,
	M89.S11ID, M89.S12ID, M89.S13ID, M89.S14ID, M89.S15ID, M89.S16ID, M89.S17ID, M89.S18ID, M89.S19ID, M89.S20ID,
	B01.StandardName as StandardName01, B02.StandardName as StandardName02, B03.StandardName as StandardName03, B04.StandardName as StandardName04,
	B05.StandardName as StandardName05, B06.StandardName as StandardName06, B07.StandardName as StandardName07, B08.StandardName as StandardName08,
	B09.StandardName as StandardName09, B10.StandardName as StandardName10, B11.StandardName as StandardName11, B12.StandardName as StandardName12,
	B13.StandardName as StandardName13, B14.StandardName as StandardName14, B15.StandardName as StandardName15, B16.StandardName as StandardName16,
	B17.StandardName as StandardName17, B18.StandardName as StandardName18, B19.StandardName as StandardName19, B20.StandardName as StandardName20,
	MT0107.BatchNo,
	a.S01 as UserName01, a.S02 as UserName02, a.S03 as UserName03, a.S04 as UserName04, a.S05 as UserName05, 
	a.S06 as UserName06, a.S07 as UserName07, a.S08 as UserName08, a.S09 as UserName09, a.S10 as UserName10,
	a.S11 as UserName11, a.S12 as UserName12, a.S13 as UserName13, a.S14 as UserName14, a.S15 as UserName15, 
	a.S16 as UserName16, a.S17 as UserName17, a.S18 as UserName18, a.S19 as UserName19, a.S20 as UserName20 '

	SET @sSQL1 ='
	FROM MT2005  WITH (NOLOCK)
    INNER JOIN MT2004 WITH (NOLOCK)  ON MT2004.DivisionID = MT2005.DivisionID     AND MT2005.VoucherID = MT2004.VoucherID
    LEFT JOIN AT1302 WITH (NOLOCK)  ON AT1302.InventoryID =MT2005.InventoryID AND AT1302.DivisionID IN (MT2005.DivisionID,''@@@'')
    LEFT JOIN AT1304 WITH (NOLOCK)  ON AT1304.UnitID = AT1302.UnitID AND AT1302.DivisionID IN (AT1304.DivisionID,''@@@'')
    LEFT JOIN AT1102 WITH (NOLOCK)  ON AT1102.DepartmentID = MT2005.DepartmentID 
    LEFT JOIN AT1103 AT1103_KCS WITH (NOLOCK) ON AT1103_KCS.EmployeeID = MT2004.KCSEmployeeID
    LEFT JOIN AT1103 WITH (NOLOCK)  ON AT1103.EmployeeID = MT2004.EmployeeID
    LEFT JOIN MT1701 WITH (NOLOCK)  ON MT1701.DivisionID = MT2005.DivisionID     AND MT1701.WorkID = MT2005.WorkID 
    LEFT JOIN MT1702 WITH (NOLOCK)  ON MT1702.DivisionID = MT2005.DivisionID     AND MT1702.WorkID = MT2005.WorkID AND MT1702.LevelID = MT2005.LevelID
    LEFT JOIN MT2001 WITH (NOLOCK)  ON MT2001.DivisionID = MT2005.DivisionID     AND MT2001.PlanID = MT2005.PlanID
	LEFT JOIN MT0107 WITH (NOLOCK) ON MT0107.DivisionID = MT2001.DivisionID AND MT0107.VoucherID = MT2001.MixVoucherID AND MT0107.ProductID = MT2001.ProductID 
    --LEFT JOIN OT2002 WITH (NOLOCK)   ON OT2002.DivisionID = MT2005.DivisionID     AND OT2002.LinkNo = MT2005.LinkNo AND OT2002.SOrderID = MT2001.SOderID
    LEFT JOIN AT1302 AT1302_P WITH (NOLOCK)   ON AT1302_P.InventoryID = MT2005.InventoryID AND AT1302_P.DivisionID IN (MT2005.DivisionID,''@@@'')
    LEFT JOIN AT1011 OT1002_1 WITH (NOLOCK) ON OT1002_1.AnaID = MT2005.Ana01ID AND  OT1002_1.AnaTypeID = ''A01''
	LEFT JOIN AT1011 OT1002_2 WITH (NOLOCK) ON OT1002_2.AnaID = MT2005.Ana02ID AND  OT1002_2.AnaTypeID = ''A02''
	LEFT JOIN AT1011 OT1002_3 WITH (NOLOCK) ON OT1002_3.AnaID = MT2005.Ana03ID AND  OT1002_3.AnaTypeID = ''A03''
	LEFT JOIN AT1011 OT1002_4 WITH (NOLOCK) ON OT1002_4.AnaID = MT2005.Ana04ID AND  OT1002_4.AnaTypeID = ''A04''
	LEFT JOIN AT1011 OT1002_5 WITH (NOLOCK) ON OT1002_5.AnaID = MT2005.Ana05ID AND  OT1002_5.AnaTypeID = ''A05'' '
    
    SET @sSQL2 = '
    LEFT JOIN MT8899 M89 WITH (NOLOCK) ON M89.DivisionID = MT2005.DivisionID AND M89.VoucherID = MT2005.VoucherID and M89.TransactionID = MT2005.TransactionID and M89.TableID = ''MT2005''
    left join AT0128 B01 WITH (NOLOCK) ON B01.StandardTypeID = ''S01'' and B01.StandardID = M89.S01ID
	left join AT0128 B02 WITH (NOLOCK) ON B02.StandardTypeID = ''S02'' and B02.StandardID = M89.S02ID
	left join AT0128 B03 WITH (NOLOCK) ON B03.StandardTypeID = ''S03'' and B03.StandardID = M89.S03ID
	left join AT0128 B04 WITH (NOLOCK) ON B04.StandardTypeID = ''S04'' and B04.StandardID = M89.S04ID
	left join AT0128 B05 WITH (NOLOCK) ON B05.StandardTypeID = ''S05'' and B05.StandardID = M89.S05ID
	left join AT0128 B06 WITH (NOLOCK) ON B06.StandardTypeID = ''S06'' and B06.StandardID = M89.S06ID
	left join AT0128 B07 WITH (NOLOCK) ON B07.StandardTypeID = ''S07'' and B07.StandardID = M89.S07ID
	left join AT0128 B08 WITH (NOLOCK) ON B08.StandardTypeID = ''S08'' and B08.StandardID = M89.S08ID
	left join AT0128 B09 WITH (NOLOCK) ON B09.StandardTypeID = ''S09'' and B09.StandardID = M89.S09ID
	left join AT0128 B10 WITH (NOLOCK) ON B10.StandardTypeID = ''S10'' and B10.StandardID = M89.S10ID
	left join AT0128 B11 WITH (NOLOCK) ON B11.StandardTypeID = ''S11'' and B11.StandardID = M89.S11ID
	left join AT0128 B12 WITH (NOLOCK) ON B12.StandardTypeID = ''S12'' and B12.StandardID = M89.S12ID
	left join AT0128 B13 WITH (NOLOCK) ON B13.StandardTypeID = ''S13'' and B13.StandardID = M89.S13ID
	left join AT0128 B14 WITH (NOLOCK) ON B14.StandardTypeID = ''S14'' and B14.StandardID = M89.S14ID
	left join AT0128 B15 WITH (NOLOCK) ON B15.StandardTypeID = ''S15'' and B15.StandardID = M89.S15ID
	left join AT0128 B16 WITH (NOLOCK) ON B16.StandardTypeID = ''S16'' and B16.StandardID = M89.S16ID
	left join AT0128 B17 WITH (NOLOCK) ON B17.StandardTypeID = ''S17'' and B17.StandardID = M89.S17ID
	left join AT0128 B18 WITH (NOLOCK) ON B18.StandardTypeID = ''S18'' and B18.StandardID = M89.S18ID
	left join AT0128 B19 WITH (NOLOCK) ON B19.StandardTypeID = ''S19'' and B19.StandardID = M89.S19ID
	left join AT0128 B20 WITH (NOLOCK) ON B20.StandardTypeID = ''S20'' and B20.StandardID = M89.S20ID
	'
SET @sSQL3 = '
LEFT JOIN (SELECT * FROM  (SELECT UserName, TypeID, DivisionID
		                   FROM AT0005 WITH (NOLOCK) WHERE TypeID LIKE ''S__'') b PIVOT (max(Username) for TypeID IN (S01, S02, S03, S04, S05, S06, S07, S08, S09, S10,
																										S11, S12, S13, S14, S15, S16, S17, S18, S19, S20))  AS a) a ON a.DivisionID = M89.DivisionID

	WHERE MT2004.DivisionID = ''' + @DivisionID + ''' 
		AND MT2004.VoucherID = ''' + @VoucherID + ''''

END
ELSE
	BEGIN
		Set @sSQL = '
		SELECT 
			MT2004.VoucherNo, 
			MT2004.VoucherDate, 
			MT2005.DepartmentID, 
			MT2005.DivisionID, 
			ISNULL(DepartmentName, '''') AS DepartmentName, 
			MT2004.KCSEmployeeID, 
			ISNULL(AT1103_KCS.FullName, '''') AS KCSFullName, 
			MT2004.EmployeeID, 
			ISNULL(AT1103.FullName, '''') AS FullName, 
			MT2005.InventoryID, 
			AT1302.InventoryName, 
			ISNULL(UnitName, '''') AS UnitName, 
			MT2005.ActualQuantity, 
			MT2005.LinkNo, 
			MT2005.PlanID AS PlanNo, 
			MT2005.Description AS Notes, 
			MT2004.Description, 
			MT2005.WorkID, 
			MT1701.WorkName, 
			MT2005.LevelID, 
			MT1702.LevelName, 
			MT2005.Finish, 
			MT2005.Orders, 
			AT1302_P.InventoryName AS ProductName,
			MT2005.Ana01ID, MT2005.Ana02ID, MT2005.Ana03ID, MT2005.Ana04ID, MT2005.Ana05ID, 
			OT1002_1.AnaName AS AnaName1,
			OT1002_2.AnaName AS AnaName2,
			OT1002_3.AnaName AS AnaName3,
			OT1002_4.AnaName AS AnaName4,
			OT1002_5.AnaName AS AnaName5,
			MT0107.BatchNo '
		
		SET @sSQL1 = '	
		FROM MT2005  WITH (NOLOCK)
			INNER JOIN MT2004 WITH (NOLOCK)           ON MT2004.DivisionID = MT2005.DivisionID     AND MT2005.VoucherID = MT2004.VoucherID
			LEFT JOIN AT1302 WITH (NOLOCK)            ON AT1302.InventoryID =MT2005.InventoryID AND AT1302.DivisionID IN (MT2005.DivisionID,''@@@'')
			LEFT JOIN AT1304 WITH (NOLOCK)            ON AT1304.UnitID = AT1302.UnitID AND AT1302.DivisionID IN (AT1304.DivisionID,''@@@'')
			LEFT JOIN AT1102 WITH (NOLOCK)            ON AT1102.DepartmentID = MT2005.DepartmentID 
			LEFT JOIN AT1103 AT1103_KCS WITH (NOLOCK) ON AT1103_KCS.EmployeeID = MT2004.KCSEmployeeID
			LEFT JOIN AT1103 WITH (NOLOCK)            ON AT1103.EmployeeID = MT2004.EmployeeID
			LEFT JOIN MT1701 WITH (NOLOCK)            ON MT1701.DivisionID = MT2005.DivisionID     AND MT1701.WorkID = MT2005.WorkID 
			LEFT JOIN MT1702 WITH (NOLOCK)            ON MT1702.DivisionID = MT2005.DivisionID     AND MT1702.WorkID = MT2005.WorkID AND MT1702.LevelID = MT2005.LevelID
			LEFT JOIN MT2001 WITH (NOLOCK)            ON MT2001.DivisionID = MT2005.DivisionID     AND MT2001.PlanID = MT2005.PlanID
			LEFT JOIN MT0107 WITH (NOLOCK)			ON MT0107.DivisionID = MT2001.DivisionID AND MT0107.VoucherID = MT2001.MixVoucherID AND MT0107.ProductID = MT2001.ProductID  
			--LEFT JOIN OT2002 WITH (NOLOCK)        ON OT2002.DivisionID = MT2005.DivisionID     AND OT2002.LinkNo = MT2005.LinkNo AND OT2002.SOrderID = MT2001.SOderID
			LEFT JOIN AT1302 AT1302_P WITH (NOLOCK) ON AT1302_P.InventoryID = MT2005.InventoryID AND AT1302_P.DivisionID IN (MT2005.DivisionID,''@@@'')
			LEFT JOIN AT1011 OT1002_1 WITH (NOLOCK) ON OT1002_1.AnaID = MT2005.Ana01ID AND  OT1002_1.AnaTypeID = ''A01''
			LEFT JOIN AT1011 OT1002_2 WITH (NOLOCK) ON OT1002_2.AnaID = MT2005.Ana02ID AND  OT1002_2.AnaTypeID = ''A02''
			LEFT JOIN AT1011 OT1002_3 WITH (NOLOCK) ON OT1002_3.AnaID = MT2005.Ana03ID AND  OT1002_3.AnaTypeID = ''A03''
			LEFT JOIN AT1011 OT1002_4 WITH (NOLOCK) ON OT1002_4.AnaID = MT2005.Ana04ID AND  OT1002_4.AnaTypeID = ''A04''
			LEFT JOIN AT1011 OT1002_5 WITH (NOLOCK) ON OT1002_5.AnaID = MT2005.Ana05ID AND  OT1002_5.AnaTypeID = ''A05''
		WHERE MT2004.DivisionID = ''' + @DivisionID + ''' 
			AND MT2004.VoucherID = ''' + @VoucherID + ''''

	END
--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
IF EXISTS(SELECT TOP 1 1 FROM sysObjects WHERE XType = 'V' AND Name = 'MV2208')
    DROP VIEW MV2208
EXEC('CREATE VIEW MV2208 ---tao boi MP2005 
    AS ' + @sSQL + @sSQL1 + @sSQL2 + @sSQL3)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
