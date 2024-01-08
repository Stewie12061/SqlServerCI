IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP2017]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP2017]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



/********************************************
'* Edited by: [GS] [Minh Lâm] [28/07/2010]
'********************************************/

---- Create by Nguyen Thi Ngoc Minh, Date 10/04/2004
---- Purpose: Nhat ky nhap xuat kho
---- Last edit by Van Nhan. Date 17/01/2005
---- Edit by Nguyen Quoc Huy, Date 04/07/2007
-----Edit by: Dang Le Bao Quynh; 09/06/2008
-----Purpose: Them truong he so quy doi
-----Edit by: Dang Le Bao Quynh; 24/11/2008
-----Purpose: Bo dieu kien NOT NULL khi tao bang tam AT2018 (Orders)
---- Edit by: Dang Le Bao Quynh; Date: 16/01/2009
---- Purpose: Bo sung truong hop xuat hang mua tra lai
---- Edit By: Dang Le Bao Quynh, 20/05/2009
---- Purpose: Thêm truong Ana01Name .. Ana05Name, Notes01 vao bang AT2018
---- Edit By: Dang Le Bao Quynh, 30/09/2009
---- Purpose: Thêm tat cac ma phan tich mat hang
---- Edit By: Dang Le Bao Quynh, 19/10/2009
---- Purpose: Thêm truong ma doi tuong , ten doi tuong
---- Modified on 12/10/2011 by Le Thi Thu Hien : Bi loi tran chuoi
---- Modified on 21/11/2012 by Tan Phu : [ TT4091 ] [ESACO] Lấy trường mã tham chiếu 1,2 giúp ra bảng AT2018 phục vụ cho report AR7006, AR7007,... 
---- Modified on 22/04/2013 by Le Thi Thu Hien : Bỏ trường APK trong bảng AT2018 (0020470 )
---- Modified on 16/07/2014 by Thanh Sơn: Lấy dữ liệu trực tiếp từ store
---- Modified on 17/09/2014 by Mai Duyen: Fix lỗi báo cáo nhập xuất kho âm (KH Printech)
---- Modified on 18/05/2015 by Mai Duyen: Bo sung DebitAccountID, CreditAccountID (KH Sieu Thanh)
---- Modified on 26/11/2015 by Tiểu Mai: Bổ sung trường Notes từ AT2007
---- Modified on 04/05/2016 by Bảo Anh: Bổ sung LimitDate
---- Modified by Bảo Thy on 27/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Hải Long on 08/03/2017: Fix lỗi tạo bảng với DivisionID quá ngắn - 3 ký tự
---- Modified by Bảo Thy on 28/04/2017: Bổ sung in báo cáo khi có thiết lập quy cách
---- Modified by Bảo Thy on 08/05/2017: Sửa danh mục dùng chung
---- Modified by Hải Long on 10/07/2017: Bổ sung 5 tham số Parameter01 - Parameter05
---- Modified by Bảo Thy on 28/03/2018: Fix lỗi http://192.168.0.204:8069/web?db=ASERP#id=3718&view_type=form&model=project.issue&action=390
---- Modified by Đức Thông on 03/08/2020: Thêm trường GroupID, GroupName, UnitName, WarrantyNo, ShelvesID, ShelvesName, FloorID, FloorName
---- Modified by Nhựt Trường on 26/08/2020: Sửa lại cách join bảng WT0169 và WT0170 từ inner thành left.
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modifide by Nhựt Trường on 28/10/2020: Bổ sung parameter @GroupID để xét thêm điều kiện khi JOIN bảng AT1401. Để fix lỗi double dòng do 1 UserID có nhiều GroupID.
---- Modified by Nhựt Trường on 09/11/2020: Bỏ JOIN bảng AT1401, AT1402 và thay đổi cách lấy trường GroupID, GroupName.
---- Modified by Hoài Phong on 10/12/2020: Bổ sung  lấy thêm ngày tạo để so sánh  để tính được  nhập xuất kho
---- Modified by Văn Tài	on 18/07/2022: Thay đổi quy tắc đặt tên bảng, sử dụng bảng tạm.
---- Modified by Thành Sang	on 13/10/2022: Thêm các các cột Notes01, Notes02, Notes03, RefInfor từ AT2007
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Nhật Thanh on 22/02/2023: Bổ sung lấy mã tham chiếu từ bảng mặt hàng
---- Modified by Đức Duy on 08/05/2023: [2023/05/IS/0023] - Bổ sung thêm trường Ana06ID.
---- Modified by Thành Sang on 06/06/2023: Gộp các truy vấn con - cải thiện tốc độ Load.

-- <Example>
---- EXEC AP2017 @Divisionid=N'HT',@Fromwarehouseid=N'KBH',@Towarehouseid=N'KDA',@Frominventoryid=N'101322',@Toinventoryid=N'414143',@Fromdate='2013-01-01 00:00:00',@Todate='2013-03-10 00:00:00'

CREATE PROCEDURE [dbo].[AP2017]
       @DivisionID AS nvarchar(50) ,
       @FromWareHouseID AS nvarchar(50) ,
       @ToWareHouseID AS nvarchar(50) ,
       @FromInventoryID AS nvarchar(50) ,
       @ToInventoryID AS nvarchar(50) ,
       @FromDate AS datetime ,
       @ToDate AS datetime ,
	   @GroupID AS nvarchar(50)
AS
SET NOCOUNT ON
DECLARE
        @sSQLSelect AS varchar(MAX) ,
        @AT2018Cursor AS cursor ,
        @WareHouseID AS nvarchar(50) ,
        @VoucherID AS nvarchar(50) ,
        @TransactionID AS nvarchar(50) ,
        @VoucherDate AS datetime ,
        @InventoryID AS nvarchar(50) ,
        @BeginQuantity AS decimal(28,8) ,
        @BeginAmount AS decimal(28,8) ,
        @ImQuantity AS decimal(28,8) ,
        @ExQuantity AS decimal(28,8) ,
        @ImQuant AS decimal(28,8) ,
        @ExQuant AS decimal(28,8) ,
        @EndQuant AS decimal(28,8) ,
        @ImAmount AS decimal(28,8) ,
        @ExAmount AS decimal(28,8) ,
        @ImportAmount AS decimal(28,8) ,
        @ExportAmount AS decimal(28,8) ,
        @EndAmount AS decimal(28,8) ,
        @Orders AS nvarchar(250) ,
        @WareHouseName AS nvarchar(250) ,
        @WareHouseName1 AS nvarchar(250) ,
        @WareHouseID2 AS nvarchar(50) ,
        @WareHouseID1 AS nvarchar(200) ,
        @KindVoucherListIm AS nvarchar(200) ,
        @KindVoucherListEx1 AS nvarchar(200), 
        @KindVoucherListEx2 AS nvarchar(200), 
		@FromDateText NVARCHAR(20), 
		@ToDateText NVARCHAR(20),
		@S01ID VARCHAR (50),
		@S02ID VARCHAR (50),
		@S03ID VARCHAR (50),
		@S04ID VARCHAR (50),
		@S05ID VARCHAR (50),
		@S06ID VARCHAR (50),
		@S07ID VARCHAR (50),
		@S08ID VARCHAR (50),
		@S09ID VARCHAR (50),
		@S10ID VARCHAR (50),
		@S11ID VARCHAR (50),
		@S12ID VARCHAR (50),
		@S13ID VARCHAR (50),
		@S14ID VARCHAR (50),
		@S15ID VARCHAR (50),
		@S16ID VARCHAR (50),
		@S17ID VARCHAR (50),
		@S18ID VARCHAR (50),
		@S19ID VARCHAR (50),
		@S20ID VARCHAR (50),
		@sSelect VARCHAR(MAX)='',
		@sGroup VARCHAR(MAX)=''

SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

SET @KindVoucherListEx1 = '(2,4,3,8,10,14,20) '
SET @KindVoucherListEx2 = '(2,4,8,10,14,20) '
SET @KindVoucherListIm = '(1,3,5,7,9,15,17) '

SET @WareHouseID2 = ' AT2006.WareHouseID '
SET @WareHouseID1 = ' Case When KindVoucherID = 3 then AT2006.WareHouseID2 else AT2006.WareHouseID end '
EXEC AP7016 @DivisionID , @FromWareHouseID , @ToWareHouseID , @FromInventoryID , @ToInventoryID , '%' , 01 , 2004 , 01 , 2004 , @FromDate , @ToDate , 1 , 1


IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND ISNULL(IsSpecificate,0) = 1)
BEGIN

	SET @sSelect = '
	, ISNULL(S01ID,'''') S01ID, ISNULL(S02ID,'''') S02ID, ISNULL(S03ID,'''') S03ID, ISNULL(S04ID,'''') S04ID, ISNULL(S05ID,'''') S05ID, 
	ISNULL(S06ID,'''') S06ID, ISNULL(S07ID,'''') S07ID, ISNULL(S08ID,'''') S08ID, ISNULL(S09ID,'''') S09ID, ISNULL(S10ID,'''') S10ID, 
	ISNULL(S11ID,'''') S11ID, ISNULL(S12ID,'''') S12ID, ISNULL(S13ID,'''') S13ID, ISNULL(S14ID,'''') S14ID, ISNULL(S15ID,'''') S15ID, 
	ISNULL(S16ID,'''') S16ID, ISNULL(S17ID,'''') S17ID, ISNULL(S18ID,'''') S18ID, ISNULL(S19ID,'''') S19ID, ISNULL(S20ID,'''') S20ID '

	SET @sGroup = '
	,ISNULL(S01ID,''''), ISNULL(S02ID,''''), ISNULL(S03ID,''''), ISNULL(S04ID,''''), ISNULL(S05ID,''''), ISNULL(S06ID,''''), ISNULL(S07ID,''''), 
	ISNULL(S08ID,''''), ISNULL(S09ID,''''), ISNULL(S10ID,''''), ISNULL(S11ID,''''), ISNULL(S12ID,''''), ISNULL(S13ID,''''), ISNULL(S14ID,''''), 
	ISNULL(S15ID,''''), ISNULL(S16ID,''''), ISNULL(S17ID,''''), ISNULL(S18ID,''''), ISNULL(S19ID,''''), ISNULL(S20ID,'''') '

END
ELSE
SET @sSelect = '
	, CONVERT(VARCHAR(50),'''') AS S01ID, CONVERT(VARCHAR(50),'''') AS S02ID, CONVERT(VARCHAR(50),'''') AS S03ID, CONVERT(VARCHAR(50),'''') AS S04ID, CONVERT(VARCHAR(50),'''') AS S05ID, 
	CONVERT(VARCHAR(50),'''') AS S06ID, CONVERT(VARCHAR(50),'''') AS S07ID, CONVERT(VARCHAR(50),'''') AS S08ID, CONVERT(VARCHAR(50),'''') AS S09ID, CONVERT(VARCHAR(50),'''') AS S10ID, 
	CONVERT(VARCHAR(50),'''') AS S11ID, CONVERT(VARCHAR(50),'''') AS S12ID, CONVERT(VARCHAR(50),'''') AS S13ID, CONVERT(VARCHAR(50),'''') AS S14ID, CONVERT(VARCHAR(50),'''') AS S15ID, 
	CONVERT(VARCHAR(50),'''') AS S16ID, CONVERT(VARCHAR(50),'''') AS S17ID, CONVERT(VARCHAR(50),'''') AS S18ID, CONVERT(VARCHAR(50),'''') AS S19ID, CONVERT(VARCHAR(50),'''') AS S20ID '

SET @sSQLSelect = '
SELECT		DivisionID, WareHouseID, InventoryID,sum(isnull(BeginQuantity,0)) AS BeginQuantity,sum(isnull(BeginAmount,0)) AS BeginAmount
'+@sSelect+'
FROM		AV7016
WHERE		DivisionID = ''' + @DivisionID + '''
GROUP BY	DivisionID, WareHouseID, InventoryID'+@sGroup+'
'

IF NOT EXISTS ( SELECT
                    name
                FROM
                    sysobjects WITH (NOLOCK)
                WHERE
                    id = Object_id(N'[dbo].[AV2015]') AND OBJECTPROPERTY(id , N'IsView') = 1 )
   BEGIN
         EXEC ( '  CREATE VIEW AV2015 	--CREATED BY AP2017
					AS '+@sSQLSelect )
   END
ELSE
   BEGIN
         EXEC ( '  ALTER VIEW AV2015 	--CREATED BY AP2017
					AS '+@sSQLSelect )
   END

--PRINT(@sSQLSelect)
--Edit by: Dang Le Bao Quynh; 02/06/2009
--Purpose: chuyen AV2015 vao bang tam de tang toc do xu ly
SELECT * INTO #AP2017Inven FROM AV2015

DECLARE
        @sSQLFrom AS nvarchar(4000),
		@sSQLFrom1 AS nvarchar(4000),
        @sSQLWhere AS nvarchar(4000),
        @sSQLUnionSelect AS nvarchar(4000),
		@sSQLUnionSelect1 AS nvarchar(4000),
        @sSQLUnionFrom AS nvarchar(4000),
		@sSQLUnionFrom1 AS nvarchar(4000),
        @sSQLUnionWhere AS nvarchar(4000)

SET @sSQLSelect = '
---1 Phan Nhap kho
Select 	' + @WareHouseID2 + ' AS WareHouseID,AT1303.WareHouseName, AT2006.VoucherID,AT2007.TransactionID,
--cast(Day(AT2006.VoucherDate)+Month(AT2006.VoucherDate)* 100 + Year(AT2006.VoucherDate)*10000 AS char(8)) +  cast((Case when AT2006.KindVoucherID in' + @KindVoucherListIm + ' then 1 else 2 end) AS char(1)) + cast(AT2006.VoucherNo AS char(20))+ cast(AT2007.TransactionID AS char(20)) + cast(AT2007.InventoryID AS char(20))  AS Orders,
cast(Day(AT2006.VoucherDate)+Month(AT2006.VoucherDate)* 100 + Year(AT2006.VoucherDate)*10000 AS char(8)) +convert(nvarchar(50), AT2006.CreateDate, 120)+  cast((Case when AT2006.KindVoucherID in(1,5,7,9,15,17)  then 1  When AT2006.KindVoucherID=3 then 2 Else  3 end) AS char(1)) + cast(AT2006.VoucherNo AS char(20))+ cast(AT2007.TransactionID AS char(20)) + cast(AT2007.InventoryID AS char(20))  AS Orders,
AT2006.VoucherDate,VoucherNo, VoucherDate AS ImVoucherDate,VoucherNo AS ImVoucherNo,SourceNo AS ImSourceNo,AT2006.WareHouseID AS ImWareHouseID,		
AT2007.ActualQuantity AS ImQuantity,AT2007.UnitPrice AS ImUnitPrice ,AT2007.ConvertedAmount AS ImConvertedAmount,AT2007.OriginalAmount AS ImOriginalAmount,
isnull(AT2007.ConversionFactor ,1)*ActualQuantity AS ImConvertedQuantity,Null AS ExVoucherDate,Null AS ExVoucherNo,	Null AS ExSourceNo,Null AS ExWareHouseID,		
0 AS ExQuantity,Null AS ExUnitPrice ,0 AS ExConvertedAmount,0 AS ExOriginalAmount,0 AS ExConvertedQuantity,VoucherTypeID,AT2006.Description,AT2006.RefNo01,
AT2006.RefNo02,AT2007.InventoryID,	AT1302.InventoryName, AT1302.RefInventoryID, AT2007.UnitID,	isnull(AT2007.ConversionFactor ,1) AS ConversionFactor,AT1309.UnitID AS ConversionUnitID,
AT1309.ConversionFactor AS ConversionFactor2,AT1309.Operator,isnull(AV2015.BeginQuantity,0) AS BeginQuantity,isnull(AV2015.BeginAmount,0) AS BeginAmount,
0 AS EndQuantity,0 AS EndAmount,AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, AT2007.Ana06ID,
A1.AnaName AS Ana01Name, A2.AnaName AS Ana02Name, A3.AnaName AS Ana03Name, A4.AnaName AS Ana04Name, A5.AnaName AS Ana05Name, A6.AnaName AS Ana06Name, AT1302.Notes01, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID,I1.AnaName AS I01Name, I2.AnaName AS I02Name, I3.AnaName AS I03Name, I4.AnaName AS I04Name, 
I5.AnaName AS I05Name, AT2006.ObjectID, AT1202.ObjectName, AT2007.DivisionID, AT2007.DebitAccountID, AT2007.CreditAccountID, AT2007.Notes, AT2007.LimitDate,
ISNULL(W89.S01ID,'''') AS S01ID, ISNULL(W89.S02ID,'''') AS S02ID, ISNULL(W89.S03ID,'''') AS S03ID, ISNULL(W89.S04ID,'''') AS S04ID, 
ISNULL(W89.S05ID,'''') AS S05ID, ISNULL(W89.S06ID,'''') AS S06ID, ISNULL(W89.S07ID,'''') AS S07ID, ISNULL(W89.S08ID,'''') AS S08ID, 
ISNULL(W89.S09ID,'''') AS S09ID, ISNULL(W89.S10ID,'''') AS S10ID, ISNULL(W89.S11ID,'''') AS S11ID, ISNULL(W89.S12ID,'''') AS S12ID, 
ISNULL(W89.S13ID,'''') AS S13ID, ISNULL(W89.S14ID,'''') AS S14ID, ISNULL(W89.S15ID,'''') AS S15ID, ISNULL(W89.S16ID,'''') AS S16ID, 
ISNULL(W89.S17ID,'''') AS S17ID, ISNULL(W89.S18ID,'''') AS S18ID, ISNULL(W89.S19ID,'''') AS S19ID, ISNULL(W89.S20ID,'''') AS S20ID,
AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05,
(Select Top 1 AT1401.GroupID From At1401 With (NOLOCK) INNER JOIN AT1402 on AT1402.GroupID = AT1401.GroupID Where AT2006.EmployeeID = AT1402.UserID) as GroupID,
(Select Top 1 AT1401.Groupname From AT1401 With (NOLOCK) INNER JOIN AT1402 on AT1402.GroupID = AT1401.GroupID Where AT2006.EmployeeID = AT1402.UserID) as GroupName,
							AT2007.WarrantyNo as ImWarrantyNo,
							AT2007.ShelvesID as ImShelvesID,
							WT0169.ShelvesName as ImShelvesName,
							AT2007.FloorID as ImFloorID,
							WT0170.FloorName as ImFloorName,
							NULL as ExWarrantyNo,
							NULL as ExShelvesID,
							NULL as ExShelvesName,
							NULL as ExFloorID,
							NULL as ExFloorName,
							AT1304.UnitName,
							AT2007.Notes01 as WNotes01,
							AT2007.Notes02 as WNotes02,
							AT2007.Notes03 as WNotes03, AT2007.RefInfor as RefInfor'

SET @sSQLFrom = ' 
FROM AT2007  WITH (NOLOCK)	
LEFT JOIN WT8899 W89 WITH (NOLOCK) ON AT2007.DivisionID = W89.DivisionID AND AT2007.TransactionID = W89.TransactionID AND AT2007.VoucherID = W89.VoucherID
INNER JOIN AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT1302.InventoryID = AT2007.InventoryID
INNER JOIN AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
--INNER JOIN AT1402 WITH (NOLOCK) ON AT2006.EmployeeID = AT1402.UserID
--INNER JOIN AT1401 WITH (NOLOCK) ON AT1401.GroupID = AT1402.GroupID
LEFT JOIN WT0169 WITH (NOLOCK) on WT0169.ShelvesID = AT2007.ShelvesID
LEFT JOIN WT0170 WITH (NOLOCK) on WT0170.FloorID = AT2007.FloorID
INNER JOIN AT1304 WITH (NOLOCK) ON AT2007.UnitID = AT1304.UnitID
INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WarehouseID = AT2006.WarehouseID
LEFT JOIN #AP2017Inven AV2015 on AV2015.InventoryID = AT2007.InventoryID and
 		AV2015.WareHouseID = AT2006.WareHouseID  AND AV2015.DivisionID = AT2007.DivisionID
		AND ISNULL(W89.S01ID,'''') = isnull(AV2015.S01ID,'''') AND ISNULL(W89.S02ID,'''') = isnull(AV2015.S02ID,'''')
		AND ISNULL(W89.S03ID,'''') = isnull(AV2015.S03ID,'''') AND ISNULL(W89.S04ID,'''') = isnull(AV2015.S04ID,'''') 
		AND ISNULL(W89.S05ID,'''') = isnull(AV2015.S05ID,'''') AND ISNULL(W89.S06ID,'''') = isnull(AV2015.S06ID,'''') 
		AND ISNULL(W89.S07ID,'''') = isnull(AV2015.S07ID,'''') AND ISNULL(W89.S08ID,'''') = isnull(AV2015.S08ID,'''') 
		AND ISNULL(W89.S09ID,'''') = isnull(AV2015.S09ID,'''') AND ISNULL(W89.S10ID,'''') = isnull(AV2015.S10ID,'''') 
		AND ISNULL(W89.S11ID,'''') = isnull(AV2015.S11ID,'''') AND ISNULL(W89.S12ID,'''') = isnull(AV2015.S12ID,'''') 
		AND ISNULL(W89.S13ID,'''') = isnull(AV2015.S13ID,'''') AND ISNULL(W89.S14ID,'''') = isnull(AV2015.S14ID,'''') 
		AND ISNULL(W89.S15ID,'''') = isnull(AV2015.S15ID,'''') AND ISNULL(W89.S16ID,'''') = isnull(AV2015.S16ID,'''') 
		AND ISNULL(W89.S17ID,'''') = isnull(AV2015.S17ID,'''') AND ISNULL(W89.S18ID,'''') = isnull(AV2015.S18ID,'''') 
		AND ISNULL(W89.S19ID,'''') = isnull(AV2015.S19ID,'''') AND ISNULL(W89.S20ID,'''') = isnull(AV2015.S20ID,'''')
LEFT JOIN (SELECT	DivisionID,InventoryID,Min(UnitID) AS UnitID, Min(ConversionFactor) AS ConversionFactor, 
					Min(Operator) AS Operator, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, 
					S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
           FROM		AT1309  WITH (NOLOCK)
           GROUP BY DivisionID,InventoryID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, 
				S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
		   ) AT1309 ON AT2007.InventoryID = AT1309.InventoryID
		   AND ISNULL(W89.S01ID,'''') = isnull(AT1309.S01ID,'''') AND ISNULL(W89.S02ID,'''') = isnull(AT1309.S02ID,'''')
		   AND ISNULL(W89.S03ID,'''') = isnull(AT1309.S03ID,'''') AND ISNULL(W89.S04ID,'''') = isnull(AT1309.S04ID,'''') 
		   AND ISNULL(W89.S05ID,'''') = isnull(AT1309.S05ID,'''') AND ISNULL(W89.S06ID,'''') = isnull(AT1309.S06ID,'''') 
		   AND ISNULL(W89.S07ID,'''') = isnull(AT1309.S07ID,'''') AND ISNULL(W89.S08ID,'''') = isnull(AT1309.S08ID,'''') 
		   AND ISNULL(W89.S09ID,'''') = isnull(AT1309.S09ID,'''') AND ISNULL(W89.S10ID,'''') = isnull(AT1309.S10ID,'''') 
		   AND ISNULL(W89.S11ID,'''') = isnull(AT1309.S11ID,'''') AND ISNULL(W89.S12ID,'''') = isnull(AT1309.S12ID,'''') 
		   AND ISNULL(W89.S13ID,'''') = isnull(AT1309.S13ID,'''') AND ISNULL(W89.S14ID,'''') = isnull(AT1309.S14ID,'''') 
		   AND ISNULL(W89.S15ID,'''') = isnull(AT1309.S15ID,'''') AND ISNULL(W89.S16ID,'''') = isnull(AT1309.S16ID,'''') 
		   AND ISNULL(W89.S17ID,'''') = isnull(AT1309.S17ID,'''') AND ISNULL(W89.S18ID,'''') = isnull(AT1309.S18ID,'''') 
		   AND ISNULL(W89.S19ID,'''') = isnull(AT1309.S19ID,'''') AND ISNULL(W89.S20ID,'''') = isnull(AT1309.S20ID,'''') '
SET @sSQLFrom1 = '
LEFT JOIN AT1011 A1 WITH (NOLOCK) On AT2007.Ana01ID = A1.AnaID AND A1.AnaTypeID = ''A01''
LEFT JOIN AT1011 A2 WITH (NOLOCK) On AT2007.Ana02ID = A2.AnaID AND A2.AnaTypeID = ''A02''
LEFT JOIN AT1011 A3 WITH (NOLOCK) On AT2007.Ana03ID = A3.AnaID AND A3.AnaTypeID = ''A03''
LEFT JOIN AT1011 A4 WITH (NOLOCK) On AT2007.Ana04ID = A4.AnaID AND A4.AnaTypeID = ''A04''
LEFT JOIN AT1011 A5 WITH (NOLOCK) On AT2007.Ana05ID = A5.AnaID AND A5.AnaTypeID = ''A05''
LEFT JOIN AT1011 A6 WITH (NOLOCK) On AT2007.Ana06ID = A6.AnaID AND A6.AnaTypeID = ''A06''
LEFT JOIN AT1015 I1 WITH (NOLOCK) On AT1302.DivisionID IN (I1.DivisionID,''@@@'') AND AT1302.I01ID = I1.AnaID AND I1.AnaTypeID = ''I01''
LEFT JOIN AT1015 I2 WITH (NOLOCK) On AT1302.DivisionID IN (I2.DivisionID,''@@@'') AND AT1302.I02ID = I2.AnaID AND I2.AnaTypeID = ''I02''
LEFT JOIN AT1015 I3 WITH (NOLOCK) On AT1302.DivisionID IN (I3.DivisionID,''@@@'') AND AT1302.I03ID = I3.AnaID AND I3.AnaTypeID = ''I03''
LEFT JOIN AT1015 I4 WITH (NOLOCK) On AT1302.DivisionID IN (I4.DivisionID,''@@@'') AND AT1302.I04ID = I4.AnaID AND I4.AnaTypeID = ''I04''
LEFT JOIN AT1015 I5 WITH (NOLOCK) On AT1302.DivisionID IN (I5.DivisionID,''@@@'') AND AT1302.I05ID = I5.AnaID AND I5.AnaTypeID = ''I05''
LEFT JOIN AT1202 WITH (NOLOCK) On AT2006.ObjectID = AT1202.ObjectID '
SET @sSQLWhere = ' 
WHERE	AT2007.DivisionID =''' + @DivisionID + ''' and
	(AT2006.VoucherDate Between ''' + @FromDateText + ''' AND ''' + @ToDateText + ''' ) and
	KindVoucherID in ' + @KindVoucherListIm + ' and
	(AT2007.InventoryID between N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') and
	(AT2006.WareHouseID between N''' + @FromWareHouseID + ''' AND N''' + @ToWareHouseID + ''')'
SET @sSQLUnionSelect = ' 
UNION ALL

--- Phan Xuat kho
SELECT 	' + @WareHouseID1 + ' AS WareHouseID,AT1303.WareHouseName, AT2006.VoucherID,AT2007.TransactionID,
--cast(Day(AT2006.VoucherDate)+Month(AT2006.VoucherDate)* 100 + Year(AT2006.VoucherDate)*10000 AS char(8)) +  cast((Case when AT2006.KindVoucherID in' + @KindVoucherListIm + ' then 1 else 2 end) AS char(1)) + cast(AT2006.VoucherNo AS char(20))+ cast(AT2007.TransactionID AS char(20)) + cast(AT2007.InventoryID AS char(20))  AS Orders,
cast(Day(AT2006.VoucherDate)+Month(AT2006.VoucherDate)* 100 + Year(AT2006.VoucherDate)*10000 AS char(8)) + convert(nvarchar(50), AT2006.CreateDate, 120)+ cast((Case when AT2006.KindVoucherID in(1,5,7,9,15,17)  then 1  When AT2006.KindVoucherID=3 then 2 Else  3 end) AS char(1)) + cast(AT2006.VoucherNo AS char(20))+ cast(AT2007.TransactionID AS char(20)) + cast(AT2007.InventoryID AS char(20))  AS Orders,
AT2006.VoucherDate,VoucherNo, Null AS ImVoucherDate, Null AS ImVoucherNo, Null AS ImSourceNo, Null AS ImWareHouseID, 0 AS ImQuantity, Null AS ImUnitPrice,
0 AS ImConvertedAmount,0 AS ImOriginalAmount,0 AS ImConvertedQuantity,VoucherDate AS ExVoucherDate,VoucherNo AS ExVoucherNo, SourceNo AS ExSourceNo,
(Case when KindVoucherID = 3 then WareHouseID2 else AT2006.WareHouseID end) AS ExWareHouseID,	
AT2007.ActualQuantity AS ExQuantity, AT2007.UnitPrice AS ExUnitPrice, AT2007.ConvertedAmount AS ExConvertedAmount, AT2007.OriginalAmount AS ExOriginalAmount,
isnull(AT2007.ConversionFactor ,1)*ActualQuantity AS ExConvertedQuantity, VoucherTypeID, AT2006.Description, AT2006.RefNo01,AT2006.RefNo02,
AT2007.InventoryID,	AT1302.InventoryName,AT1302.RefInventoryID, AT2007.UnitID,	isnull(AT2007.ConversionFactor ,1) AS ConversionFactor, AT1309.UnitID AS ConversionUnitID,
AT1309.ConversionFactor AS ConversionFactor2, AT1309.Operator,isnull(AV2015.BeginQuantity,0) AS BeginQuantity, isnull(AV2015.BeginAmount,0) AS BeginAmount,
0 AS EndQuantity,0 AS EndAmount, AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, AT2007.Ana06ID,
A1.AnaName AS Ana01Name, A2.AnaName AS Ana02Name, A3.AnaName AS Ana03Name, A4.AnaName AS Ana04Name, A5.AnaName AS Ana05Name, A6.AnaName AS Ana06Name,
AT1302.Notes01, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID,
I1.AnaName AS I01Name, I2.AnaName AS I02Name, I3.AnaName AS I03Name, I4.AnaName AS I04Name, I5.AnaName AS I05Name,
AT2006.ObjectID, AT1202.ObjectName, AT2007.DivisionID ,AT2007.DebitAccountID, AT2007.CreditAccountID, AT2007.Notes, AT2007.LimitDate,
ISNULL(W89.S01ID,'''') AS S01ID, ISNULL(W89.S02ID,'''') AS S02ID, ISNULL(W89.S03ID,'''') AS S03ID, ISNULL(W89.S04ID,'''') AS S04ID, 
ISNULL(W89.S05ID,'''') AS S05ID, ISNULL(W89.S06ID,'''') AS S06ID, ISNULL(W89.S07ID,'''') AS S07ID, ISNULL(W89.S08ID,'''') AS S08ID, 
ISNULL(W89.S09ID,'''') AS S09ID, ISNULL(W89.S10ID,'''') AS S10ID, ISNULL(W89.S11ID,'''') AS S11ID, ISNULL(W89.S12ID,'''') AS S12ID, 
ISNULL(W89.S13ID,'''') AS S13ID, ISNULL(W89.S14ID,'''') AS S14ID, ISNULL(W89.S15ID,'''') AS S15ID, ISNULL(W89.S16ID,'''') AS S16ID, 
ISNULL(W89.S17ID,'''') AS S17ID, ISNULL(W89.S18ID,'''') AS S18ID, ISNULL(W89.S19ID,'''') AS S19ID, ISNULL(W89.S20ID,'''') AS S20ID,
AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05,
(Select Top 1 AT1401.GroupID From AT1401 With (NOLOCK) INNER JOIN AT1402 on AT1402.GroupID = AT1401.GroupID Where AT2006.EmployeeID = AT1402.UserID) as GroupID,
(Select Top 1 AT1401.Groupname From AT1401 With (NOLOCK) INNER JOIN AT1402 on AT1402.GroupID = AT1401.GroupID Where AT2006.EmployeeID = AT1402.UserID) as GroupName,
							NULL	as ImWarrantyNo,
							NULL	as ImShelvesID,
							NULL	as ImShelvesName,
							NULL	as ImFloorID,
							NULL	as ImFloorName,
							AT2007.WarrantyNo	 as ExWarrantyNo, AT2007.ShelvesID	 as ExShelvesID, WT0169.ShelvesName	 as ExShelvesName,
							AT2007.FloorID		 as ExFloorID, WT0170.FloorName	 as ExFloorName, AT1304.UnitName,'
SET @sSQLUnionSelect1 = 'AT2007.Notes01 as WNotes01, AT2007.Notes02 as WNotes02,AT2007.Notes03 as WNotes03, AT2007.RefInfor as RefInfor'
SET @sSQLUnionFrom = ' 
FROM AT2007  WITH (NOLOCK)	
INNER JOIN AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT1302.InventoryID = AT2007.InventoryID
INNER JOIN AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID AND  AT2006.DivisionID = AT2007.DivisionID
--INNER JOIN AT1402 WITH (NOLOCK) ON AT2006.EmployeeID = AT1402.UserID
--INNER JOIN AT1401 WITH (NOLOCK) ON AT1401.GroupID = AT1402.GroupID
LEFT JOIN WT0169 WITH (NOLOCK) on WT0169.ShelvesID = AT2007.ShelvesID
LEFT JOIN WT0170 WITH (NOLOCK) on WT0170.FloorID = AT2007.FloorID
INNER JOIN AT1304 WITH (NOLOCK) ON AT2007.UnitID = AT1304.UnitID
LEFT JOIN WT8899 W89 WITH (NOLOCK) ON AT2007.DivisionID = W89.DivisionID AND AT2007.TransactionID = W89.TransactionID AND AT2007.VoucherID = W89.VoucherID
INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = (Case When KindVoucherID = 3 then AT2006.WareHouseID2 else AT2006.WareHouseID end)
LEFT JOIN #AP2017Inven AV2015 on AV2015.InventoryID = AT2007.InventoryID and
	AV2015.WareHouseID = (Case When KindVoucherID = 3 then AT2006.WareHouseID2 else AT2006.WareHouseID end)  AND  AV2015.DivisionID = AT2007.DivisionID
	AND ISNULL(W89.S01ID,'''') = isnull(AV2015.S01ID,'''') AND ISNULL(W89.S02ID,'''') = isnull(AV2015.S02ID,'''')
	AND ISNULL(W89.S03ID,'''') = isnull(AV2015.S03ID,'''') AND ISNULL(W89.S04ID,'''') = isnull(AV2015.S04ID,'''') 
	AND ISNULL(W89.S05ID,'''') = isnull(AV2015.S05ID,'''') AND ISNULL(W89.S06ID,'''') = isnull(AV2015.S06ID,'''') 
	AND ISNULL(W89.S07ID,'''') = isnull(AV2015.S07ID,'''') AND ISNULL(W89.S08ID,'''') = isnull(AV2015.S08ID,'''') 
	AND ISNULL(W89.S09ID,'''') = isnull(AV2015.S09ID,'''') AND ISNULL(W89.S10ID,'''') = isnull(AV2015.S10ID,'''') 
	AND ISNULL(W89.S11ID,'''') = isnull(AV2015.S11ID,'''') AND ISNULL(W89.S12ID,'''') = isnull(AV2015.S12ID,'''') 
	AND ISNULL(W89.S13ID,'''') = isnull(AV2015.S13ID,'''') AND ISNULL(W89.S14ID,'''') = isnull(AV2015.S14ID,'''') 
	AND ISNULL(W89.S15ID,'''') = isnull(AV2015.S15ID,'''') AND ISNULL(W89.S16ID,'''') = isnull(AV2015.S16ID,'''') 
	AND ISNULL(W89.S17ID,'''') = isnull(AV2015.S17ID,'''') AND ISNULL(W89.S18ID,'''') = isnull(AV2015.S18ID,'''') 
	AND ISNULL(W89.S19ID,'''') = isnull(AV2015.S19ID,'''') AND ISNULL(W89.S20ID,'''') = isnull(AV2015.S20ID,'''')
LEFT JOIN (SELECT	DivisionID,InventoryID,Min(UnitID) AS UnitID, Min(ConversionFactor) AS ConversionFactor, 
					Min(Operator) AS Operator,S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, 
					S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID 
           FROM		AT1309 WITH (NOLOCK) 
           GROUP BY DivisionID,InventoryID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, 
					S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
	) AT1309 ON	AT2007.InventoryID = AT1309.InventoryID
		AND ISNULL(W89.S01ID,'''') = isnull(AT1309.S01ID,'''') AND ISNULL(W89.S02ID,'''') = isnull(AT1309.S02ID,'''')
		AND ISNULL(W89.S03ID,'''') = isnull(AT1309.S03ID,'''') AND ISNULL(W89.S04ID,'''') = isnull(AT1309.S04ID,'''') 
		AND ISNULL(W89.S05ID,'''') = isnull(AT1309.S05ID,'''') AND ISNULL(W89.S06ID,'''') = isnull(AT1309.S06ID,'''') 
		AND ISNULL(W89.S07ID,'''') = isnull(AT1309.S07ID,'''') AND ISNULL(W89.S08ID,'''') = isnull(AT1309.S08ID,'''') 
		AND ISNULL(W89.S09ID,'''') = isnull(AT1309.S09ID,'''') AND ISNULL(W89.S10ID,'''') = isnull(AT1309.S10ID,'''') 
		AND ISNULL(W89.S11ID,'''') = isnull(AT1309.S11ID,'''') AND ISNULL(W89.S12ID,'''') = isnull(AT1309.S12ID,'''') 
		AND ISNULL(W89.S13ID,'''') = isnull(AT1309.S13ID,'''') AND ISNULL(W89.S14ID,'''') = isnull(AT1309.S14ID,'''') 
		AND ISNULL(W89.S15ID,'''') = isnull(AT1309.S15ID,'''') AND ISNULL(W89.S16ID,'''') = isnull(AT1309.S16ID,'''') 
		AND ISNULL(W89.S17ID,'''') = isnull(AT1309.S17ID,'''') AND ISNULL(W89.S18ID,'''') = isnull(AT1309.S18ID,'''') 
		AND ISNULL(W89.S19ID,'''') = isnull(AT1309.S19ID,'''') AND ISNULL(W89.S20ID,'''') = isnull(AT1309.S20ID,'''') '
SET @sSQLUnionFrom1 = '
LEFT JOIN AT1011 A1 WITH (NOLOCK) On AT2007.Ana01ID = A1.AnaID AND A1.AnaTypeID = ''A01''
LEFT JOIN AT1011 A2 WITH (NOLOCK) On AT2007.Ana02ID = A2.AnaID AND A2.AnaTypeID = ''A02''
LEFT JOIN AT1011 A3 WITH (NOLOCK) On AT2007.Ana03ID = A3.AnaID AND A3.AnaTypeID = ''A03''
LEFT JOIN AT1011 A4 WITH (NOLOCK) On AT2007.Ana04ID = A4.AnaID AND A4.AnaTypeID = ''A04''
LEFT JOIN AT1011 A5 WITH (NOLOCK) On AT2007.Ana05ID = A5.AnaID AND A5.AnaTypeID = ''A05''
LEFT JOIN AT1011 A6 WITH (NOLOCK) On AT2007.Ana06ID = A6.AnaID AND A6.AnaTypeID = ''A06''
LEFT JOIN AT1015 I1 WITH (NOLOCK) On AT1302.DivisionID IN (I1.DivisionID,''@@@'') AND AT1302.I01ID = I1.AnaID AND I1.AnaTypeID = ''I01''
LEFT JOIN AT1015 I2 WITH (NOLOCK) On AT1302.DivisionID IN (I2.DivisionID,''@@@'') AND AT1302.I02ID = I2.AnaID AND I2.AnaTypeID = ''I02''
LEFT JOIN AT1015 I3 WITH (NOLOCK) On AT1302.DivisionID IN (I3.DivisionID,''@@@'') AND AT1302.I03ID = I3.AnaID AND I3.AnaTypeID = ''I03''
LEFT JOIN AT1015 I4 WITH (NOLOCK) On AT1302.DivisionID IN (I4.DivisionID,''@@@'') AND AT1302.I04ID = I4.AnaID AND I4.AnaTypeID = ''I04''
LEFT JOIN AT1015 I5 WITH (NOLOCK) On AT1302.DivisionID IN (I5.DivisionID,''@@@'') AND AT1302.I05ID = I5.AnaID AND I5.AnaTypeID = ''I05''
LEFT JOIN AT1202 WITH (NOLOCK) On AT2006.ObjectID = AT1202.ObjectID '
SET @sSQLUnionWhere = ' 
Where	AT2007.DivisionID =''' + @DivisionID + ''' and
	(AT2006.VoucherDate Between ''' + @FromDateText + ''' AND ''' + @ToDateText + ''' ) and
	(AT2007.InventoryID between N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') and
	( (KindVoucherID in ' + @KindVoucherListEx2 + ' AND  
	(AT2006.WareHouseID between N''' + @FromWareHouseID + ''' AND N''' + @ToWareHouseID + ''')) 
	or  (KindVoucherID = 3 AND (AT2006.WareHouseID2 between N''' + @FromWareHouseID + ''' AND N''' + @ToWareHouseID + ''')))
'

IF EXISTS ( SELECT TOP 1
                1
            FROM
                SysObjects WITH (NOLOCK)
            WHERE
                Name = 'AT2018' AND Xtype = 'U' )
	BEGIN
         DROP TABLE [dbo].[AT2018]
	
         CREATE TABLE [dbo].[AT2018]
         (
			--[APK] [uniqueidentifier] DEFAULT NEWID(),
           [WareHouseID] [nvarchar](50) NOT NULL ,
           [WareHouseName] [nvarchar](250) NULL ,
           [VoucherID] [nvarchar](50) NOT NULL ,
           [TransactionID] [nvarchar](50) NOT NULL ,
           [Orders] [nvarchar](250) NULL ,
           [VoucherDate] [datetime] NULL ,
           [VoucherNo] [nvarchar](50) NULL ,
           [ImVoucherDate] [datetime] NULL ,
           [ImVoucherNo] [nvarchar](50) NULL ,
           [ImSourceNo] [nvarchar](50) NULL ,
           [ImWareHouseID] [nvarchar](50) NULL ,
           [ImQuantity] [decimal](28,8) NULL ,
           [ImUnitPrice] [decimal](28,8) NULL ,
           [ImConvertedAmount] [decimal](28,8) NULL ,
           [ImOriginalAmount] [decimal](28,8) NULL ,
           [ImConvertedQuantity] [decimal](28,8) NULL ,
           [ExVoucherDate] [datetime] NULL ,
           [ExVoucherNo] [nvarchar](50) NULL ,
           [ExSourceNo] [nvarchar](50) NULL ,
           [ExWareHouseID] [nvarchar](50) NULL ,
           [ExQuantity] [decimal](28,8) NULL ,
           [ExUnitPrice] [decimal](28,8) NULL ,
           [ExConvertedAmount] [decimal](28,8) NULL ,
           [ExOriginalAmount] [decimal](28,8) NULL ,
           [ExConvertedQuantity] [decimal](28,8) NULL ,
           [VoucherTypeID] [nvarchar](50) NULL ,
           [Description] [nvarchar](250) NULL ,
           RefNo01 [nvarchar](100) NULL ,
           RefNo02 [nvarchar](100) NULL ,
           [InventoryID] [nvarchar](50) NULL ,
           [InventoryName] [nvarchar](250) NULL ,
           [RefInventoryID] [nvarchar](250) NULL ,
           [UnitID] [nvarchar](50) NULL ,
           [ConversionFactor] [decimal](28,8) NULL ,
           [ConversionUnitID] [nvarchar](50) NULL ,
           [ConversionFactor2] [decimal](28,8) NULL ,
           [Operator] [tinyint] NULL ,
           [BeginQuantity] [decimal](28,8) NULL ,
           [BeginAmount] [decimal](28,8) NULL ,
           [EndQuantity] [decimal](28,8) NULL ,
           [EndAmount] [decimal](28,8) NULL ,
           [Ana01ID] [nvarchar](50) NULL ,
           [Ana02ID] [nvarchar](50) NULL ,
           [Ana03ID] [nvarchar](50) NULL ,
           [Ana04ID] [nvarchar](50) NULL ,
           [Ana05ID] [nvarchar](50) NULL ,
		   [Ana06ID] [nvarchar](50) NULL ,
           [Ana01Name] [nvarchar](250) NULL ,
           [Ana02Name] [nvarchar](250) NULL ,
           [Ana03Name] [nvarchar](250) NULL ,
           [Ana04Name] [nvarchar](250) NULL ,
           [Ana05Name] [nvarchar](250) NULL ,
		   [Ana06Name] [nvarchar](250) NULL ,
           [Notes01] [nvarchar](500) NULL ,
           [I01ID] [nvarchar](50) NULL ,
           [I02ID] [nvarchar](50) NULL ,
           [I03ID] [nvarchar](50) NULL ,
           [I04ID] [nvarchar](50) NULL ,
           [I05ID] [nvarchar](50) NULL ,
           [I01Name] [nvarchar](250) NULL ,
           [I02Name] [nvarchar](250) NULL ,
           [I03Name] [nvarchar](250) NULL ,
           [I04Name] [nvarchar](250) NULL ,
           [I05Name] [nvarchar](250) NULL ,
           [ObjectID] [nvarchar](50) NULL ,
           [ObjectName] [nvarchar](250) NULL ,
           [DivisionID] [nvarchar] (50) NOT NULL,
           [DebitAccountID] [nvarchar] (50) NULL,
           [CreditAccountID] [nvarchar] (50) NULL,
           [Notes] [nvarchar] (250) NULL,
		   [LimitDate] [datetime] NULL,
		   [S01ID] [VARCHAR] (50) NULL,
		   [S02ID] [VARCHAR] (50) NULL,
		   [S03ID] [VARCHAR] (50) NULL,
		   [S04ID] [VARCHAR] (50) NULL,
		   [S05ID] [VARCHAR] (50) NULL,
		   [S06ID] [VARCHAR] (50) NULL,
		   [S07ID] [VARCHAR] (50) NULL,
		   [S08ID] [VARCHAR] (50) NULL,
		   [S09ID] [VARCHAR] (50) NULL,
		   [S10ID] [VARCHAR] (50) NULL,
		   [S11ID] [VARCHAR] (50) NULL,
		   [S12ID] [VARCHAR] (50) NULL,
		   [S13ID] [VARCHAR] (50) NULL,
		   [S14ID] [VARCHAR] (50) NULL,
		   [S15ID] [VARCHAR] (50) NULL,
		   [S16ID] [VARCHAR] (50) NULL,
		   [S17ID] [VARCHAR] (50) NULL,
		   [S18ID] [VARCHAR] (50) NULL,
		   [S19ID] [VARCHAR] (50) NULL,
		   [S20ID] [VARCHAR] (50) NULL,
		   [Parameter01] DECIMAL(28),
		   [Parameter02] DECIMAL(28),
		   [Parameter03] DECIMAL(28),
	       [Parameter04] DECIMAL(28),
		   [Parameter05] DECIMAL(28),
		   [GroupID] NVARCHAR(50),
		   [GroupName] NVARCHAR(250),
		   [ImWarrantyNo] NVARCHAR(250),
		   [ImShelvesID] NVARCHAR(50),
		   [ImShelvesName] NVARCHAR(250),
		   [ImFloorID] NVARCHAR(50),
		   [ImFloorName] NVARCHAR(250),
		   [ExWarrantyNo]	NVARCHAR(250),
		   [ExShelvesID]	NVARCHAR(50),
		   [ExShelvesName]	NVARCHAR(250),
		   [ExFloorID]		NVARCHAR(50),
		   [ExFloorName]	NVARCHAR(250),
		   [UnitName]		NVARCHAR(250),
		   [WNotes01]		[NVARCHAR] (50) NULL,
		   [WNotes02]		[NVARCHAR] (50) NULL,
		   [WNotes03]		[NVARCHAR] (50) NULL,
		   [RefInfor]		[NVARCHAR](250) NULL,
--	CONSTRAINT [PK_AT2018] PRIMARY KEY NONCLUSTERED 
--(
--	[APK] ASC
--    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

--) ON [PRIMARY]
) ON [PRIMARY]

   END

PRINT (@sSQLSelect)
PRINT (@sSQLFrom)
PRINT (@sSQLFrom1)
PRINT(@sSQLWhere)
PRINT(@sSQLUnionSelect)
PRINT (@sSQLUnionSelect1)
PRINT(@sSQLUnionFrom)
PRINT(@sSQLUnionFrom1)
PRINT(@sSQLUnionWhere)

EXEC ( 'INSERT INTO AT2018  (WareHouseID, WareHouseName, 	VoucherID,
	TransactionID, Orders,VoucherDate,
	VoucherNo, ImVoucherDate, ImVoucherNo,ImSourceNo, ImWareHouseID, ImQuantity, ImUnitPrice ,
	ImConvertedAmount, ImOriginalAmount, ImConvertedQuantity, ExVoucherDate,
	 ExVoucherNo,	 ExSourceNo, ExWareHouseID,	ExQuantity,ExUnitPrice ,
	ExConvertedAmount,ExOriginalAmount, ExConvertedQuantity,
	VoucherTypeID, Description, RefNo01,RefNo02,InventoryID,	
	InventoryName, RefInventoryID, UnitID,	 ConversionFactor, ConversionUnitID, ConversionFactor2, Operator, 
	BeginQuantity, BeginAmount, EndQuantity,EndAmount,
	Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana01Name, Ana02Name, Ana03Name, Ana04Name, Ana05Name, Ana06Name, Notes01,
	I01ID, I02ID, I03ID, I04ID, I05ID,I01Name, I02Name, I03Name, I04Name, I05Name, ObjectID, ObjectName, DivisionID,
	DebitAccountID ,CreditAccountID, Notes, LimitDate, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, 
	S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID, 
	Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, GroupID, GroupName, ImWarrantyNo, ImShelvesID, ImShelvesName, ImFloorID, ImFloorName, ExWarrantyNo, ExShelvesID, ExShelvesName, ExFloorID, ExFloorName, UnitName, WNotes01, WNotes02, WNotes03, RefInfor)
	'+@sSQLSelect+@sSQLFrom+@sSQLFrom1+@sSQLWhere+@sSQLUnionSelect+@sSQLUnionSelect1+@sSQLUnionFrom+@sSQLUnionFrom1+@sSQLUnionWhere )

SET @AT2018Cursor = CURSOR SCROLL KEYSET FOR 
SELECT WareHouseID,VoucherID,TransactionID,VoucherDate ,InventoryID,BeginQuantity,BeginAmount,
ImQuantity,ExQuantity,ImConvertedAmount,ExConvertedAmount,Orders, S01ID, S02ID, S03ID, S04ID, S05ID, 
S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
FROM AT2018 WITH (NOLOCK)
Where DivisionID = @DivisionID

OPEN @AT2018Cursor
FETCH NEXT FROM @AT2018Cursor INTO @WareHouseID,@VoucherID,@TransactionID,@VoucherDate,@InventoryID,@BeginQuantity,@BeginAmount,@ImQuantity,@ExQuantity,@ImAmount,
@ExAmount,@Orders, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID, @S11ID, @S12ID, @S13ID, @S14ID, @S15ID, 
@S16ID, @S17ID, @S18ID, @S19ID, @S20ID
WHILE @@FETCH_STATUS = 0
      BEGIN
				SELECT
				    @ImQuant = SUM(ISNULL(ImConvertedQuantity , 0)),
				    @ExQuant = SUM(ISNULL(ExConvertedQuantity , 0)),
				    @ImportAmount = SUM(ISNULL(ImConvertedAmount , 0)),
				    @ExportAmount = SUM(ISNULL(ExConvertedAmount , 0))
				FROM
				    AT2018 WITH (NOLOCK)
				WHERE
				    Orders < @Orders 
				    AND WareHouseID = @WareHouseID 
				    AND InventoryID = @InventoryID 
				    AND DivisionID = @DivisionID
				    AND ISNULL(S01ID,'') = ISNULL(@S01ID,'')
				    AND ISNULL(S02ID,'') = ISNULL(@S02ID,'')
				    AND ISNULL(S03ID,'') = ISNULL(@S03ID,'')
				    AND ISNULL(S04ID,'') = ISNULL(@S04ID,'')
				    AND ISNULL(S05ID,'') = ISNULL(@S05ID,'')
				    AND ISNULL(S06ID,'') = ISNULL(@S06ID,'')
				    AND ISNULL(S07ID,'') = ISNULL(@S07ID,'')
				    AND ISNULL(S08ID,'') = ISNULL(@S08ID,'')
				    AND ISNULL(S09ID,'') = ISNULL(@S09ID,'')
				    AND ISNULL(S10ID,'') = ISNULL(@S10ID,'')
				    AND ISNULL(S11ID,'') = ISNULL(@S11ID,'')
				    AND ISNULL(S12ID,'') = ISNULL(@S12ID,'')
				    AND ISNULL(S13ID,'') = ISNULL(@S13ID,'')
				    AND ISNULL(S14ID,'') = ISNULL(@S14ID,'')
				    AND ISNULL(S15ID,'') = ISNULL(@S15ID,'')
				    AND ISNULL(S16ID,'') = ISNULL(@S16ID,'')
				    AND ISNULL(S17ID,'') = ISNULL(@S17ID,'')
				    AND ISNULL(S18ID,'') = ISNULL(@S18ID,'')
				    AND ISNULL(S19ID,'') = ISNULL(@S19ID,'')
				    AND ISNULL(S20ID,'') = ISNULL(@S20ID,'')

            SET @BeginQuantity = isnull(@BeginQuantity , 0) + isnull(@ImQuant , 0) - isnull(@ExQuant , 0)


	--Set @BeginAmount = isnull(@BeginAmount,0) + isnull(@ImAmount,0) - isnull(@ExAmount,0)
            SET @BeginAmount = isnull(@BeginAmount , 0) + isnull(@ImportAmount , 0) - isnull(@ExportAmount , 0)

            SET @EndQuant = isnull(@BeginQuantity , 0) + isnull(@ImQuantity , 0) - isnull(@ExQuantity , 0)

	--Set @EndAmount = @BeginAmount + isnull(@ImportAmount,0) - isnull(@ExportAmount,0)
            SET @EndAmount = isnull(@BeginAmount , 0) + isnull(@ImAmount , 0) - isnull(@ExAmount , 0)

            UPDATE
                AT2018
            SET
                BeginQuantity = @BeginQuantity ,
                BeginAmount = @BeginAmount ,
                EndQuantity = @EndQuant ,
                EndAmount = @EndAmount
            WHERE
                WareHouseID = @WareHouseID 
				AND VoucherID = @VoucherID 
				AND TransactionID = @TransactionID 
				AND VoucherDate = @VoucherDate 
				AND InventoryID = @InventoryID 
				AND DivisionID = @DivisionID
				AND ISNULL(S01ID,'') = ISNULL(@S01ID,'')
				AND ISNULL(S02ID,'') = ISNULL(@S02ID,'')
				AND ISNULL(S03ID,'') = ISNULL(@S03ID,'')
				AND ISNULL(S04ID,'') = ISNULL(@S04ID,'')
				AND ISNULL(S05ID,'') = ISNULL(@S05ID,'')
				AND ISNULL(S06ID,'') = ISNULL(@S06ID,'')
				AND ISNULL(S07ID,'') = ISNULL(@S07ID,'')
				AND ISNULL(S08ID,'') = ISNULL(@S08ID,'')
				AND ISNULL(S09ID,'') = ISNULL(@S09ID,'')
				AND ISNULL(S10ID,'') = ISNULL(@S10ID,'')
				AND ISNULL(S11ID,'') = ISNULL(@S11ID,'')
				AND ISNULL(S12ID,'') = ISNULL(@S12ID,'')
				AND ISNULL(S13ID,'') = ISNULL(@S13ID,'')
				AND ISNULL(S14ID,'') = ISNULL(@S14ID,'')
				AND ISNULL(S15ID,'') = ISNULL(@S15ID,'')
				AND ISNULL(S16ID,'') = ISNULL(@S16ID,'')
				AND ISNULL(S17ID,'') = ISNULL(@S17ID,'')
				AND ISNULL(S18ID,'') = ISNULL(@S18ID,'')
				AND ISNULL(S19ID,'') = ISNULL(@S19ID,'')
				AND ISNULL(S20ID,'') = ISNULL(@S20ID,'')

            FETCH NEXT FROM @AT2018Cursor INTO @WareHouseID,@VoucherID,@TransactionID,@VoucherDate,@InventoryID,@BeginQuantity,@BeginAmount,@ImQuantity,@ExQuantity,
			@ImAmount,@ExAmount,@Orders, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID, @S11ID, @S12ID, @S13ID, @S14ID, @S15ID, 
			@S16ID, @S17ID, @S18ID, @S19ID, @S20ID
      END

CLOSE @AT2018Cursor
DEALLOCATE @AT2018Cursor

SET NOCOUNT OFF
-------------SELECT dữ liệu
SELECT AT2018.*, A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20
FROM AT2018 WITH (NOLOCK)
LEFT JOIN AT0128 A01 WITH (NOLOCK) ON AT2018.S01ID = A01.StandardID AND A01.StandardTypeID = 'S01'
LEFT JOIN AT0128 A02 WITH (NOLOCK) ON AT2018.S02ID = A02.StandardID AND A02.StandardTypeID = 'S02'
LEFT JOIN AT0128 A03 WITH (NOLOCK) ON AT2018.S03ID = A03.StandardID AND A03.StandardTypeID = 'S03'
LEFT JOIN AT0128 A04 WITH (NOLOCK) ON AT2018.S04ID = A04.StandardID AND A04.StandardTypeID = 'S04'
LEFT JOIN AT0128 A05 WITH (NOLOCK) ON AT2018.S05ID = A05.StandardID AND A05.StandardTypeID = 'S05'
LEFT JOIN AT0128 A06 WITH (NOLOCK) ON AT2018.S06ID = A06.StandardID AND A06.StandardTypeID = 'S06'
LEFT JOIN AT0128 A07 WITH (NOLOCK) ON AT2018.S07ID = A07.StandardID AND A07.StandardTypeID = 'S07'
LEFT JOIN AT0128 A08 WITH (NOLOCK) ON AT2018.S08ID = A08.StandardID AND A08.StandardTypeID = 'S08'
LEFT JOIN AT0128 A09 WITH (NOLOCK) ON AT2018.S09ID = A09.StandardID AND A09.StandardTypeID = 'S09'
LEFT JOIN AT0128 A10 WITH (NOLOCK) ON AT2018.S10ID = A10.StandardID AND A10.StandardTypeID = 'S10'
LEFT JOIN AT0128 A11 WITH (NOLOCK) ON AT2018.S11ID = A11.StandardID AND A11.StandardTypeID = 'S11'
LEFT JOIN AT0128 A12 WITH (NOLOCK) ON AT2018.S12ID = A12.StandardID AND A12.StandardTypeID = 'S12'
LEFT JOIN AT0128 A13 WITH (NOLOCK) ON AT2018.S13ID = A13.StandardID AND A13.StandardTypeID = 'S13'
LEFT JOIN AT0128 A14 WITH (NOLOCK) ON AT2018.S14ID = A14.StandardID AND A14.StandardTypeID = 'S14'
LEFT JOIN AT0128 A15 WITH (NOLOCK) ON AT2018.S15ID = A15.StandardID AND A15.StandardTypeID = 'S15'
LEFT JOIN AT0128 A16 WITH (NOLOCK) ON AT2018.S16ID = A16.StandardID AND A16.StandardTypeID = 'S16'
LEFT JOIN AT0128 A17 WITH (NOLOCK) ON AT2018.S17ID = A17.StandardID AND A17.StandardTypeID = 'S17'
LEFT JOIN AT0128 A18 WITH (NOLOCK) ON AT2018.S18ID = A18.StandardID AND A18.StandardTypeID = 'S18'
LEFT JOIN AT0128 A19 WITH (NOLOCK) ON AT2018.S19ID = A19.StandardID AND A19.StandardTypeID = 'S19'
LEFT JOIN AT0128 A20 WITH (NOLOCK) ON AT2018.S20ID = A20.StandardID AND A20.StandardTypeID = 'S20'



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


