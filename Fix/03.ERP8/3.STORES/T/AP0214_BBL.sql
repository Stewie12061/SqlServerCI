IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0214_BBL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0214_BBL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-----Created by Nguyen Van Nhan.
-----Created Date 27/03/2006.
-----Purpose: In chi tiet phieu xuat theo thuc te dich danh.
-----Last Update: Nguyen Thi Thuy Tuyen Date:05/09/2006 , Purpose: Lay them truong ObjectID, ObjectName
-----Edited by Nguyen Quoc Huy, Date 07/11/2006
-----Last Edit by  Nguyen Quoc Huy ,Date 29/12/2006-- Them phan union 
-----Modified on 08/02/2012 by Le Thi Thu Hien : Bo sung them JOIN DivisionID
-----Edited by: [GS] [Tố Oanh] [27/09/2013]: bổ sung trường RefNo01, RefNo02, UnitName
-----Modified by Thanh Sơn on 16/07/2014: lấy dữ liệu trực tiếp từ store, không sinh view AV0214
-----Modified by Tiểu Mai on 02/12/2015: Lấy trường Ana01ID và AnaName01 từ AV2777
---- Modified by Tiểu Mai on 16/01/2017: Fix ko load dữ liệu khi quản lý theo ngày hết hạn
---- Modified by Bảo Anh on 20/04/2017: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified by Bảo Thy on 26/04/2017: Bổ sung in báo cáo khi quản lý theo quy cách
---- Modified by Hải Long on 10/07/2017: Bổ sung 5 tham số Parameter01 - Parameter05
---- Modified by Bảo Anh on 02/01/2018: Sửa lỗi tràn chuỗi @sSQLWhere khi in theo tháng
---- Modified by Đức Thông on 08/07/2020: Thêm groupID, groupName
---- Modified by Đức Thông on 01/09/2020: Fix bug in báo cáo tồn kho theo lô nhập (chi tiết theo phiếu)
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Nhựt Trường on 03/02/2021: Chia nhỏ độ dài của các biến @sSQLSelect và @sSQLWhere để fix lỗi tràn dữ liệu.
---- Modified by Nhựt Trường on 19/08/2021: Bổ sung điều kiện DivisionID khi join bảng AT1401.
---- Modified by Nhựt Trường on 31/08/2021: Bổ sung lấy phiếu chuyển kho (KindVoucherID = 3) khi load dữ liệu chi tiết theo phiếu (@IsInner = 0).
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Đình Định on 11/08/2023: BBL - Mẫu AR0214: Lấy lên thẻ BeginConvertedQuantity, DebitConvertedQuantity, CreditConvertedQuantity, EndConvertedQuantity, ConvertedUnitID
---- Modified by Nhựt Trường on 08/09/2023: 2023/08/IS/0335, Lấy thêm cột tồn đầu kỳ (BeQuantity, BeConvertedQauntity) : bằng requantity của phiếu nhập - sum(dequantity) của phiếu xuất tính tới trước thời điểm in báo cáo).
---- Modified by Nhựt Trường on 08/09/2023: 2023/08/IS/0335, Cải tiến tốc độ.
---- Modified by Nhựt Trường on 11/10/2023: Thêm các trường lấy tổng cộng.

/********************************************
'* Edited by: [GS] [Tố Oanh] [28/07/2010]
'********************************************/
---AP0214_BBL 'HT','','',1,2017,1,2017,'20170101','20170131',0,'','',1
CREATE PROCEDURE  [dbo].[AP0214_BBL] 
				@DivisionID AS nvarchar(50), 
				@FromWareHouseID AS nvarchar(50),
				@ToWareHouseID AS nvarchar(50),
				@FromMonth AS int,
				@FromYear AS int,
				@ToMonth AS int,
				@ToYear AS int,
				@FromDate datetime,
				@ToDate datetime,
				@IsDate AS tinyint,
				@FromInventoryID AS nvarchar(50),
				@ToInventoryID AS  nvarchar(50),
				@IsInner  AS tinyint, ----- (0; khong co VCNB, 1: VCNB),
				@UserID VARCHAR(50)
	
 AS
 

DECLARE @sSQLSelect_A AS NVARCHAR(max),
		@sSQLSelect_B AS NVARCHAR(max),
		@sSQLFrom AS NVARCHAR(max),
		@sSQLWhere_A AS NVARCHAR(max),
		@sSQLWhere_B AS NVARCHAR(max),
		@sSQLWhere_C AS NVARCHAR(max),
		@KindVoucherListEx  AS nvarchar(200),
		@KindVoucherListIm  AS nvarchar(200),
		@WareHouseID1 AS nvarchar(200), 
        @FromMonthYearText NVARCHAR(20), 
        @ToMonthYearText NVARCHAR(20), 
        @FromDateText NVARCHAR(20), 
        @ToDateText NVARCHAR(20),
	    @GroupID varchar (50),
	    @CustomerName INT

SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

If @IsDate =1 --- Theo ngày
BEGIN
	SET @sSQLWhere_C = N'ReVoucherDate < '''+@FromDateText+''''
END
ELSE --- Theo kỳ
BEGIN
	SET @sSQLWhere_C = N'B.TranMonth + B.TranYear * 100 < '+@FromMonthYearText+' '	
END

-- Savi: thêm group id, group name
SET @GroupID = (SELECT TOP 1 AT1402.GroupID FROM AT1402 WITH(NOLOCK) WHERE AT1402.UserID = @UserID)

If @IsInner =0 
  Begin	
	Set @KindVoucherListIm ='(1,5,7,9,15,17) '
	Set @KindVoucherListEx ='(2,3,4,6,8,10,14,20) '
	
  End
Else
  Begin
	Set @KindVoucherListIm ='(1,3,5,7,9,15,17) '
	Set @KindVoucherListEx ='(2,3,4,6,8,10,14,20) '
	
 End

Set  @WareHouseID1 = ' CASE WHEN A.KindVoucherID = 3 then A.WareHouseID2 else A.WareHouseID end '

If @IsDate =1  --- Theo ngay
begin
Set @sSQLSelect_A ='
---lay phieu xuat kho cua ky nay tuong ung voi phieu nhap kho
SELECT 	A.VoucherDate AS DeVoucherDate, A.VoucherNo AS DeVoucherNo, ' +@WareHouseID1 +' AS WareHouseID, B.InventoryID, AT1302.InventoryName,
AT1302.UnitID, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID,AT1302.I04ID, AT1302.I05ID, I1.AnaName AS AnaName1, I2.AnaName AS AnaName2, I3.AnaName AS AnaName3, 
I4.AnaName AS AnaName4, I5.AnaName AS AnaName5, AT1302.VATPercent, AT1302.Notes01, AT1302.Notes02,AT1302.Notes03, AT1302.Specification,
B.ActualQuantity AS DeQuantity, B.ConvertedAmount AS DeAmount, E.ActualQuantity AS ReQuantity, E.ConvertedAmount AS ReAmount, B.ReVoucherID,
D.VoucherNo AS ReVoucherNo, D.VoucherDate AS ReVoucherDate, D.ObjectID AS ReObjectID, F.ObjectName AS ReObjectName, B.ReTransactionID, B.SourceNo AS ReSourceNo, B.WarrantyNo AS ReWarrantyNo, B.ShelvesID AS ReShelvesID, B.FloorID AS ReFloorID,		wt0169.ShelvesName AS ReShelvesName, wt0170.FloorName AS ReFloorName,		
B.LimitDate, A.ObjectID, AT1202.ObjectName, B.DivisionID, A.RefNo01, A.RefNo02, G.UnitName, B.Ana01ID, A01.AnaName as AnaName01,
ISNULL(B.S01ID,'''') AS S01ID, ISNULL(B.S02ID,'''') AS S02ID, ISNULL(B.S03ID,'''') AS S03ID, ISNULL(B.S04ID,'''') AS S04ID, ISNULL(B.S05ID,'''') AS S05ID, 
ISNULL(B.S06ID,'''') AS S06ID, ISNULL(B.S07ID,'''') AS S07ID, ISNULL(B.S08ID,'''') AS S08ID, ISNULL(B.S09ID,'''') AS S09ID, ISNULL(B.S10ID,'''') AS S10ID,
ISNULL(B.S11ID,'''') AS S11ID, ISNULL(B.S12ID,'''') AS S12ID, ISNULL(B.S13ID,'''') AS S13ID, ISNULL(B.S14ID,'''') AS S14ID, ISNULL(B.S15ID,'''') AS S15ID, 
ISNULL(B.S16ID,'''') AS S16ID, ISNULL(B.S17ID,'''') AS S17ID, ISNULL(B.S18ID,'''') AS S18ID, ISNULL(B.S19ID,'''') AS S19ID, ISNULL(B.S20ID,'''') AS S20ID,
B.Parameter01, B.Parameter02, B.Parameter03, B.Parameter04, B.Parameter05, N'''+@GroupID+''' as GroupID, AT1401.GroupName,
B.ConvertedQuantity AS DeConvertedQuantity, E.ConvertedQuantity AS ReConvertedQuantity, B.ConvertedUnitID
From  AV2777 B 
left join wt0169 on b.ShelvesID = wt0169.ShelvesID
left join wt0170 on b.FloorID = wt0170.FloorID
INNER JOIN AV2666  A on A.VoucherID = B.VoucherID AND A.DivisionID = B.DivisionID
INNER JOIN AT1302 C WITH (NOLOCK) on C.DivisionID IN (B.DivisionID,''@@@'') AND C.InventoryID = B.InventoryID
INNER JOIN AV2666 D on D.VoucherID = B.ReVoucherID and D.DivisionID = B.DivisionID
INNER JOIN AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (B.DivisionID,''@@@'') AND AT1302.InventoryID = B.InventoryID
INNER JOIN AV2777 E on E.TransactionID = B.ReTransactionID and E.DivisionID = B.DivisionID
LEFT JOIN AT1015 I1 WITH (NOLOCK) on AT1302.DivisionID IN (I1.DivisionID,''@@@'') AND I1.AnaID = AT1302.I01ID and I1.AnaTypeID =''I01''
LEFT JOIN AT1015 I2 WITH (NOLOCK) on AT1302.DivisionID IN (I2.DivisionID,''@@@'') AND I2.AnaID = AT1302.I01ID and I2.AnaTypeID =''I02''
LEFT JOIN AT1015 I3 WITH (NOLOCK) on AT1302.DivisionID IN (I3.DivisionID,''@@@'') AND I3.AnaID = AT1302.I01ID and I3.AnaTypeID =''I03''
LEFT JOIN AT1015 I4 WITH (NOLOCK) on AT1302.DivisionID IN (I4.DivisionID,''@@@'') AND I4.AnaID = AT1302.I01ID and I4.AnaTypeID =''I04''
LEFT JOIN AT1015 I5 WITH (NOLOCK) on AT1302.DivisionID IN (I5.DivisionID,''@@@'') AND I5.AnaID = AT1302.I01ID and I5.AnaTypeID =''I05''
LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = A.ObjectID
LEFT JOIN AT1202 F WITH (NOLOCK) on    F.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND F.ObjectID = D.ObjectID
LEFT JOIN AT1304 G WITH (NOLOCK) on AT1302.DivisionID IN (G.DivisionID,''@@@'') AND G.UnitID = AT1302.UnitID
LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaID = B.Ana01ID and A01.AnaTypeID = ''A01''
LEFT JOIN AT1401 WITH (NOLOCK) on AT1401.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND AT1401.GroupID = N''' +@GroupID+ '''
'
Set @sSQLSelect_B ='
Where  (B.InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''') and 
	B.ReTransactionID in (Select ReTransactionID From AT0114
				Where
					(ReVoucherDate < ='''+@ToDateText+''' ) and
					( '+@WareHouseID1+' between '''+@FromWareHouseID+''' and ''' + @ToWareHouseID + ''') and
					DivisionID ='''+@DivisionID+''' ) And

	B.VoucherID IN (Select  VoucherID FROM AV2666 
				WHERE KINDVOUCHERID IN  '+ @KindVoucherListEx+'  AND 
					(VoucherDate  Between   '''+@FromDateText+'''  and  '''+@ToDateText+''' ) And
						( '+@WareHouseID1+' between '''+@FromWareHouseID+''' and ''' + @ToWareHouseID + ''') and
						DivisionID ='''+@DivisionID+''' ) and
	(AT1302.IsSource = 1 OR AT1302.IsLimitDate = 1) and
            A.VoucherDate <=  '''+@ToDateText+''' 

Union all

---Lay phieu chua xuat kho
Select 	null  AS DeVoucherdate,'''' AS DeVoucherNo, A.WareHouseID, B.InventoryID, AT1302.InventoryName, AT1302.UnitID, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID,
AT1302.I04ID, AT1302.I05ID, I1.AnaName AS AnaName1, I2.AnaName AS AnaName2, I3.AnaName AS AnaName3, I4.AnaName AS AnaName4, I5.AnaName AS AnaName5,
AT1302.VATPercent, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, AT1302.Specification, 0 AS DeQuantity,0 AS DeAmount,B.ReQuantity AS ReQuantity,
E.ConvertedAmount AS ReAmount, B.ReVoucherID, A.VoucherNo AS ReVoucherNo, A.VoucherDate AS ReVoucherDate, A.ObjectID AS ReObjectID, AT1202.ObjectName AS ReObjectName,
--B.ReTransactionID,
B.ReTransactionID AS ReTransactionID, B.ReSourceNo AS ReSourceNo, B.ReWarrantyNo AS ReWarrantyNo, B.ReShelvesID AS ReShelvesID, B.ReFloorID AS ReFloorID,	wt0169.ShelvesName AS ReShelvesName, wt0170.FloorName AS ReFloorName,		  B.LimitDate, null AS ObjectID, Null AS ObjectName, B.DivisionID, A.RefNo01, A.RefNo02,
G.UnitName, E.Ana01ID, A01.AnaName as AnaName01,
ISNULL(B.S01ID,'''') AS S01ID, ISNULL(B.S02ID,'''') AS S02ID, ISNULL(B.S03ID,'''') AS S03ID, ISNULL(B.S04ID,'''') AS S04ID, ISNULL(B.S05ID,'''') AS S05ID, 
ISNULL(B.S06ID,'''') AS S06ID, ISNULL(B.S07ID,'''') AS S07ID, ISNULL(B.S08ID,'''') AS S08ID, ISNULL(B.S09ID,'''') AS S09ID, ISNULL(B.S10ID,'''') AS S10ID,
ISNULL(B.S11ID,'''') AS S11ID, ISNULL(B.S12ID,'''') AS S12ID, ISNULL(B.S13ID,'''') AS S13ID, ISNULL(B.S14ID,'''') AS S14ID, ISNULL(B.S15ID,'''') AS S15ID, 
ISNULL(B.S16ID,'''') AS S16ID, ISNULL(B.S17ID,'''') AS S17ID, ISNULL(B.S18ID,'''') AS S18ID, ISNULL(B.S19ID,'''') AS S19ID, ISNULL(B.S20ID,'''') AS S20ID,
E.Parameter01, E.Parameter02, E.Parameter03, E.Parameter04, E.Parameter05, N'''+@GroupID+''' as GroupID, AT1401.GroupName,
0 AS DeConvertedQuantity, E.ConvertedQuantity AS ReConvertedQuantity, E.ConvertedUnitID
From  AT0114 B WITH (NOLOCK)
'

Set @sSQLFrom ='
left join wt0169 on b.ReShelvesID = wt0169.ShelvesID
left join wt0170 on b.ReFloorID = wt0170.FloorID
INNER JOIN AV2666 A on A.VoucherID = B.ReVoucherID and A.DivisionID = B.DivisionID
INNER JOIN AV2777 E on E.TransactionID = B.ReTransactionID and E.DivisionID = B.DivisionID
AND ISNULL(B.S01ID,'''') = Isnull(E.S01ID,'''') AND ISNULL(B.S02ID,'''') = isnull(E.S02ID,'''')
AND ISNULL(B.S03ID,'''') = isnull(E.S03ID,'''') AND ISNULL(B.S04ID,'''') = isnull(E.S04ID,'''') 
AND ISNULL(B.S05ID,'''') = isnull(E.S05ID,'''') AND ISNULL(B.S06ID,'''') = isnull(E.S06ID,'''') 
AND ISNULL(B.S07ID,'''') = isnull(E.S07ID,'''') AND ISNULL(B.S08ID,'''') = isnull(E.S08ID,'''') 
AND ISNULL(B.S09ID,'''') = isnull(E.S09ID,'''') AND ISNULL(B.S10ID,'''') = isnull(E.S10ID,'''') 
AND ISNULL(B.S11ID,'''') = isnull(E.S11ID,'''') AND ISNULL(B.S12ID,'''') = isnull(E.S12ID,'''') 
AND ISNULL(B.S13ID,'''') = isnull(E.S13ID,'''') AND ISNULL(B.S14ID,'''') = isnull(E.S14ID,'''') 
AND ISNULL(B.S15ID,'''') = isnull(E.S15ID,'''') AND ISNULL(B.S16ID,'''') = isnull(E.S16ID,'''') 
AND ISNULL(B.S17ID,'''') = isnull(E.S17ID,'''') AND ISNULL(B.S18ID,'''') = isnull(E.S18ID,'''') 
AND ISNULL(B.S19ID,'''') = isnull(E.S19ID,'''') AND ISNULL(B.S20ID,'''') = isnull(E.S20ID,'''') 
INNER JOIN AT1302 C WITH (NOLOCK) on C.DivisionID IN (B.DivisionID,''@@@'') AND C.InventoryID = B.InventoryID
INNER JOIN AT1302 WITH (NOLOCK) on 	AT1302.DivisionID IN (B.DivisionID,''@@@'') AND AT1302.InventoryID = B.InventoryID
LEFT JOIN AT1015 I1 WITH (NOLOCK) on AT1302.DivisionID IN (I1.DivisionID,''@@@'') AND I1.AnaID = AT1302.I01ID and I1.AnaTypeID =''I01''
LEFT JOIN AT1015 I2 WITH (NOLOCK) on AT1302.DivisionID IN (I2.DivisionID,''@@@'') AND I2.AnaID = AT1302.I01ID and I2.AnaTypeID =''I02''
LEFT JOIN AT1015 I3 WITH (NOLOCK) on AT1302.DivisionID IN (I3.DivisionID,''@@@'') AND I3.AnaID = AT1302.I01ID and I3.AnaTypeID =''I03''
LEFT JOIN AT1015 I4 WITH (NOLOCK) on AT1302.DivisionID IN (I4.DivisionID,''@@@'') AND I4.AnaID = AT1302.I01ID and I4.AnaTypeID =''I04''
LEFT JOIN AT1015 I5 WITH (NOLOCK) on AT1302.DivisionID IN (I5.DivisionID,''@@@'') AND I5.AnaID = AT1302.I01ID and I5.AnaTypeID =''I05''
LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = A.ObjectID
LEFT JOIN AT1304 G WITH (NOLOCK) on AT1302.DivisionID IN (G.DivisionID,''@@@'') AND G.UnitID = AT1302.UnitID
LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaID = E.Ana01ID and A01.AnaTypeID = ''A01''
LEFT JOIN AT1401 WITH (NOLOCK) on AT1401.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND AT1401.GroupID = N''' +@GroupID+ '''
Where  (B.InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''') and 
	B.DeQuantity =0 and							
	A.KindVoucherID   in '+ @KindVoucherListIm +' and 
	(ReVoucherDate Between '''+@FromDateText+'''  and  '''+@ToDateText+''' ) and
						(A.WareHouseID between '''+@FromWareHouseID+''' and ''' + @ToWareHouseID + ''') and
						A.DivisionID ='''+@DivisionID+''' and

	(AT1302.IsSource = 1 OR AT1302.IsLimitDate = 1)
'

Set @sSQLWhere_A ='
union all  
Select 	null AS DeVoucherDate, null AS DeVoucherNo, A.WareHouseID, B.InventoryID, AT1302.InventoryName, AT1302.UnitID, AT1302.I01ID, AT1302.I02ID, 
AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, 	I1.AnaName AS AnaName1, I2.AnaName AS AnaName2, I3.AnaName AS AnaName3, I4.AnaName AS AnaName4, I5.AnaName AS AnaName5, 
AT1302.VATPercent, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, AT1302.Specification, null AS DeQuantity, null  AS DeAmount, B.ActualQuantity AS ReQuantity, 
B.ConvertedAmount AS ReAmount, B.ReVoucherID, A.VoucherNo  AS ReVoucherNo, A.VoucherDate AS ReVoucherDate, A.ObjectID AS ReObjectID, AT1202.ObjectName AS ReObjectName, 
B.TransactionID AS ReTransactionID, B.SourceNo AS ReSourceNo, B.WarrantyNo AS ReWarrantyNo, B.ShelvesID AS ReShelvesID, B.FloorID AS ReFloorID, wt0169.ShelvesName AS ReShelvesName, wt0170.FloorName AS ReFloorName,		 B.LimitDate, null AS ObjectID, null AS ObjectName, B.DivisionID, A.RefNo01, A.RefNo02, G.UnitName, 
B.Ana01ID, A01.AnaName as AnaName01,
ISNULL(B.S01ID,'''') AS S01ID, ISNULL(B.S02ID,'''') AS S02ID, ISNULL(B.S03ID,'''') AS S03ID, ISNULL(B.S04ID,'''') AS S04ID, ISNULL(B.S05ID,'''') AS S05ID, 
ISNULL(B.S06ID,'''') AS S06ID, ISNULL(B.S07ID,'''') AS S07ID, ISNULL(B.S08ID,'''') AS S08ID, ISNULL(B.S09ID,'''') AS S09ID, ISNULL(B.S10ID,'''') AS S10ID,
ISNULL(B.S11ID,'''') AS S11ID, ISNULL(B.S12ID,'''') AS S12ID, ISNULL(B.S13ID,'''') AS S13ID, ISNULL(B.S14ID,'''') AS S14ID, ISNULL(B.S15ID,'''') AS S15ID, 
ISNULL(B.S16ID,'''') AS S16ID, ISNULL(B.S17ID,'''') AS S17ID, ISNULL(B.S18ID,'''') AS S18ID, ISNULL(B.S19ID,'''') AS S19ID, ISNULL(B.S20ID,'''') AS S20ID,
B.Parameter01, B.Parameter02, B.Parameter03, B.Parameter04, B.Parameter05, N'''+@GroupID+''' as GroupID, AT1401.GroupName,
0 AS DeConvertedQuantity, B.ConvertedQuantity AS ReConvertedQuantity, B.ConvertedUnitID
From  AV2777   B 
left join wt0169 on b.ShelvesID = wt0169.ShelvesID
left join wt0170 on b.FloorID = wt0170.FloorID
INNER JOIN AV2666 A on A.VoucherID = B.VoucherID and A.DivisionID = B.DivisionID
INNER JOIN AT1302 C WITH (NOLOCK) on C.DivisionID IN (B.DivisionID,''@@@'') AND C.InventoryID = B.InventoryID
INNER JOIN AT1302 WITH (NOLOCK) on 	AT1302.DivisionID IN (B.DivisionID,''@@@'') AND AT1302.InventoryID = B.InventoryID
LEFT JOIN AT1015 I1 WITH (NOLOCK) on AT1302.DivisionID IN (I1.DivisionID,''@@@'') AND I1.AnaID = AT1302.I01ID and I1.AnaTypeID =''I01''
LEFT JOIN AT1015 I2 WITH (NOLOCK) on AT1302.DivisionID IN (I2.DivisionID,''@@@'') AND I2.AnaID = AT1302.I01ID and I2.AnaTypeID =''I02''
LEFT JOIN AT1015 I3 WITH (NOLOCK) on AT1302.DivisionID IN (I3.DivisionID,''@@@'') AND I3.AnaID = AT1302.I01ID and I3.AnaTypeID =''I03''
LEFT JOIN AT1015 I4 WITH (NOLOCK) on AT1302.DivisionID IN (I4.DivisionID,''@@@'') AND I4.AnaID = AT1302.I01ID and I4.AnaTypeID =''I04''
LEFT JOIN AT1015 I5 WITH (NOLOCK) on AT1302.DivisionID IN (I5.DivisionID,''@@@'') AND I5.AnaID = AT1302.I01ID and I5.AnaTypeID =''I05'''
Set @sSQLWhere_B ='
LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = A.ObjectID
LEFT JOIN AT1304 G WITH (NOLOCK) on AT1302.DivisionID IN (G.DivisionID,''@@@'') AND G.UnitID = AT1302.UnitID
LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaID = B.Ana01ID and A01.AnaTypeID = ''A01''
LEFT JOIN AT1401 WITH (NOLOCK) on AT1401.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND AT1401.GroupID = N''' +@GroupID+ '''
Where  (B.InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''') and 
	A.KindVoucherID   in '+ @KindVoucherListIm +' and 
	B.VoucherID not in ( select ReVoucherID From AV2666 INNER JOIN AV2777 on AV2777.VoucherID = AV2666.VoucherID
				where KindVoucherID in '+ @KindVoucherListEx +'  and isnull(KindVoucherID,'''')<>'''' and (AV2666.TranMonth + 100*AV2666.TranYear  Between '+@FromMonthYearText+'  and '+@ToMonthYearText+' )) and
	( A.WareHouseID  between '''+@FromWareHouseID+''' and ''' + @ToWareHouseID + ''') and
	(AT1302.IsSource = 1 OR AT1302.IsLimitDate = 1) and
	B.DivisionID ='''+@DivisionID+''' And
	(VoucherDate Between '''+@FromDateText+'''  and  '''+@ToDateText+''' )
'
end
Else   --- Theo Ky
begin
Set @sSQLSelect_A ='
---lay phieu xuat kho cua ky nay tuong ung voi phieu nhap kho
Select 	A.VoucherDate AS DeVoucherDate, A.VoucherNo AS DeVoucherNo, ' +@WareHouseID1 +' AS WareHouseID, B.InventoryID, AT1302.InventoryName, AT1302.UnitID, 
AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, 	I1.AnaName AS AnaName1, I2.AnaName AS AnaName2, I3.AnaName AS AnaName3, I4.AnaName AS AnaName4, 
I5.AnaName AS AnaName5, AT1302.VATPercent, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, AT1302.Specification, B.ActualQuantity AS DeQuantity, 
B.ConvertedAmount AS DeAmount,
(SELECT ISNULL(SUM(ActualQuantity),0) FROM AV2777 WHERE TransactionID = B.ReTransactionID and DivisionID = B.DivisionID AND TranMonth + 100*TranYear between '+@FromMonthYearText+' AND '+@ToMonthYearText+') AS ReQuantity, 
(SELECT ISNULL(SUM(ConvertedAmount),0) FROM AV2777 WHERE TransactionID = B.ReTransactionID and DivisionID = B.DivisionID AND TranMonth + 100*TranYear between '+@FromMonthYearText+' AND '+@ToMonthYearText+') AS ReAmount, 
B.ReVoucherID, D.VoucherNo AS ReVoucherNo, D.VoucherDate AS ReVoucherDate, 
D.ObjectID AS ReObjectID, F.ObjectName AS ReObjectName, B.ReTransactionID, B.SourceNo AS ReSourceNo, B.WarrantyNo AS ReWarrantyNo, B.ShelvesID AS ReShelvesID, B.FloorID AS ReFloorID, wt0169.ShelvesName AS ReShelvesName, wt0170.FloorName AS ReFloorName,		 B.LimitDate, 
A.ObjectID, AT1202.ObjectName, B.DivisionID, A.RefNo01, A.RefNo02, G.UnitName, B.Ana01ID, A01.AnaName as AnaName01,
ISNULL(B.S01ID,'''') AS S01ID, ISNULL(B.S02ID,'''') AS S02ID, ISNULL(B.S03ID,'''') AS S03ID, ISNULL(B.S04ID,'''') AS S04ID, ISNULL(B.S05ID,'''') AS S05ID, 
ISNULL(B.S06ID,'''') AS S06ID, ISNULL(B.S07ID,'''') AS S07ID, ISNULL(B.S08ID,'''') AS S08ID, ISNULL(B.S09ID,'''') AS S09ID, ISNULL(B.S10ID,'''') AS S10ID,
ISNULL(B.S11ID,'''') AS S11ID, ISNULL(B.S12ID,'''') AS S12ID, ISNULL(B.S13ID,'''') AS S13ID, ISNULL(B.S14ID,'''') AS S14ID, ISNULL(B.S15ID,'''') AS S15ID, 
ISNULL(B.S16ID,'''') AS S16ID, ISNULL(B.S17ID,'''') AS S17ID, ISNULL(B.S18ID,'''') AS S18ID, ISNULL(B.S19ID,'''') AS S19ID, ISNULL(B.S20ID,'''') AS S20ID,
B.Parameter01, B.Parameter02, B.Parameter03, B.Parameter04, B.Parameter05, N'''+@GroupID+''' as GroupID, AT1401.GroupName, B.ConvertedQuantity AS DeConvertedQuantity,
(SELECT ISNULL(SUM(ConvertedQuantity),0) FROM AV2777 WHERE TransactionID = B.ReTransactionID and DivisionID = B.DivisionID AND TranMonth + 100*TranYear between '+@FromMonthYearText+' AND '+@ToMonthYearText+') AS ReConvertedQuantity,
B.ConvertedUnitID
From  AV2777 B 
left join wt0169 on b.ShelvesID = wt0169.ShelvesID
left join wt0170 on b.FloorID = wt0170.FloorID
INNER JOIN AV2666   A on A.VoucherID = B.VoucherID and A.DivisionID = B.DivisionID
INNER JOIN AT1302 C WITH (NOLOCK) on C.DivisionID IN (B.DivisionID,''@@@'') AND C.InventoryID = B.InventoryID
INNER JOIN  AV2666 D on D.VoucherID = B.ReVoucherID and D.DivisionID = B.DivisionID
INNER JOIN AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (B.DivisionID,''@@@'') AND AT1302.InventoryID = B.InventoryID
INNER JOIN AV2777 E on E.TransactionID = B.ReTransactionID and E.DivisionID = B.DivisionID
LEFT JOIN AT1015 I1 WITH (NOLOCK) on AT1302.DivisionID IN (I1.DivisionID,''@@@'') AND I1.AnaID = AT1302.I01ID and I1.AnaTypeID =''I01''
LEFT JOIN AT1015 I2 WITH (NOLOCK) on AT1302.DivisionID IN (I2.DivisionID,''@@@'') AND I2.AnaID = AT1302.I01ID and I2.AnaTypeID =''I02''
LEFT JOIN AT1015 I3 WITH (NOLOCK) on AT1302.DivisionID IN (I3.DivisionID,''@@@'') AND I3.AnaID = AT1302.I01ID and I3.AnaTypeID =''I03''
LEFT JOIN AT1015 I4 WITH (NOLOCK) on AT1302.DivisionID IN (I4.DivisionID,''@@@'') AND I4.AnaID = AT1302.I01ID and I4.AnaTypeID =''I04''
LEFT JOIN AT1015 I5 WITH (NOLOCK) on AT1302.DivisionID IN (I5.DivisionID,''@@@'') AND I5.AnaID = AT1302.I01ID and I5.AnaTypeID =''I05''
LEFT JOIN AT1202 WITH (NOLOCK) on    AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = A.ObjectID
LEFT JOIN AT1202 F WITH (NOLOCK) on    F.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND F.ObjectID = D.ObjectID
'
Set @sSQLSelect_B ='

LEFT JOIN AT1304 G WITH (NOLOCK) on AT1302.DivisionID IN (G.DivisionID,''@@@'') AND G.UnitID = AT1302.UnitID
LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaID = B.Ana01ID and A01.AnaTypeID = ''A01''
LEFT JOIN AT1401 WITH (NOLOCK) on AT1401.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND AT1401.GroupID = N''' +@GroupID+ '''
Where  (B.InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''') and 
	B.ReTransactionID in (Select ReTransactionID From AT0114 
					Where 
						(ReTranMonth + 100*ReTranYear < = '+@ToMonthYearText+') and
						( '+@WareHouseID1+' between '''+@FromWareHouseID+''' and ''' + @ToWareHouseID + ''') and
						DivisionID ='''+@DivisionID+''' ) and

	B.VoucherID IN (Select  VoucherID FROM AV2666 
				WHERE KINDVOUCHERID in '+ @KindVoucherListEx+' AND 
					(TranMonth + 100*TranYear Between    '+@FromMonthYearText+'  and '+@ToMonthYearText+' ) and
						( '+@WareHouseID1+' between '''+@FromWareHouseID+''' and ''' + @ToWareHouseID + ''') and
						DivisionID ='''+@DivisionID+''' ) and
					
	(AT1302.IsSource = 1 OR AT1302.IsLimitDate = 1)	and
	B.TranMonth + 100*B.TranYear  < = '+@ToMonthYearText+'

Union all'

Set @sSQLFrom ='
---Lay phieu chua xuat kho
Select 	null  AS DeVoucherdate, '''' AS DeVoucherNo, A.WareHouseID, B.InventoryID, AT1302.InventoryName, AT1302.UnitID, AT1302.I01ID, AT1302.I02ID, 
AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, I1.AnaName AS AnaName1, I2.AnaName AS AnaName2, I3.AnaName AS AnaName3, I4.AnaName AS AnaName4, I5.AnaName AS AnaName5, 
AT1302.VATPercent, AT1302.Notes01, AT1302.Notes02,AT1302.Notes03, AT1302.Specification, 0 AS DeQuantity, 0 AS DeAmount, B.ReQuantity AS ReQuantity, 
E.ConvertedAmount AS ReAmount, B.ReVoucherID, A.VoucherNo AS ReVoucherNo, A.VoucherDate AS ReVoucherDate, A.ObjectID AS ReObjectID, AT1202.ObjectName AS ReObjectName, 
--B.ReTransactionID, 
B.ReTransactionID AS ReTransactionID, B.ReSourceNo AS ReSourceNo, B.ReWarrantyNo AS ReWarrantyNo, B.ReShelvesID AS ReShelvesID, B.ReFloorID AS ReFloorID, wt0169.ShelvesName AS ReShelvesName, wt0170.FloorName AS ReFloorName,		B.LimitDate, null AS ObjectID, Null AS ObjectName, B.DivisionID, A.RefNo01, A.RefNo02, G.UnitName, 
E.Ana01ID, A01.AnaName as AnaName01,
ISNULL(B.S01ID,'''') AS S01ID, ISNULL(B.S02ID,'''') AS S02ID, ISNULL(B.S03ID,'''') AS S03ID, ISNULL(B.S04ID,'''') AS S04ID, ISNULL(B.S05ID,'''') AS S05ID, 
ISNULL(B.S06ID,'''') AS S06ID, ISNULL(B.S07ID,'''') AS S07ID, ISNULL(B.S08ID,'''') AS S08ID, ISNULL(B.S09ID,'''') AS S09ID, ISNULL(B.S10ID,'''') AS S10ID,
ISNULL(B.S11ID,'''') AS S11ID, ISNULL(B.S12ID,'''') AS S12ID, ISNULL(B.S13ID,'''') AS S13ID, ISNULL(B.S14ID,'''') AS S14ID, ISNULL(B.S15ID,'''') AS S15ID, 
ISNULL(B.S16ID,'''') AS S16ID, ISNULL(B.S17ID,'''') AS S17ID, ISNULL(B.S18ID,'''') AS S18ID, ISNULL(B.S19ID,'''') AS S19ID, ISNULL(B.S20ID,'''') AS S20ID,
E.Parameter01, E.Parameter02, E.Parameter03, E.Parameter04, E.Parameter05, N'''+@GroupID+''' as GroupID, AT1401.GroupName,
0 AS DeConvertedQuantity, E.ConvertedQuantity AS ReConvertedQuantity, E.ConvertedUnitID
From  AT0114 B WITH (NOLOCK)
left join wt0169 on b.ReShelvesID = wt0169.ShelvesID
left join wt0170 on b.ReFloorID = wt0170.FloorID
INNER JOIN AV2666  A on A.VoucherID = B.ReVoucherID and A.DivisionID = B.DivisionID
INNER JOIN  AV2777 E on E.TransactionID = B.ReTransactionID and E.DivisionID = B.DivisionID
AND ISNULL(B.S01ID,'''') = Isnull(E.S01ID,'''') AND ISNULL(B.S02ID,'''') = isnull(E.S02ID,'''')
AND ISNULL(B.S03ID,'''') = isnull(E.S03ID,'''') AND ISNULL(B.S04ID,'''') = isnull(E.S04ID,'''') 
AND ISNULL(B.S05ID,'''') = isnull(E.S05ID,'''') AND ISNULL(B.S06ID,'''') = isnull(E.S06ID,'''') 
AND ISNULL(B.S07ID,'''') = isnull(E.S07ID,'''') AND ISNULL(B.S08ID,'''') = isnull(E.S08ID,'''') 
AND ISNULL(B.S09ID,'''') = isnull(E.S09ID,'''') AND ISNULL(B.S10ID,'''') = isnull(E.S10ID,'''') 
AND ISNULL(B.S11ID,'''') = isnull(E.S11ID,'''') AND ISNULL(B.S12ID,'''') = isnull(E.S12ID,'''') 
AND ISNULL(B.S13ID,'''') = isnull(E.S13ID,'''') AND ISNULL(B.S14ID,'''') = isnull(E.S14ID,'''') 
AND ISNULL(B.S15ID,'''') = isnull(E.S15ID,'''') AND ISNULL(B.S16ID,'''') = isnull(E.S16ID,'''') 
AND ISNULL(B.S17ID,'''') = isnull(E.S17ID,'''') AND ISNULL(B.S18ID,'''') = isnull(E.S18ID,'''') 
AND ISNULL(B.S19ID,'''') = isnull(E.S19ID,'''') AND ISNULL(B.S20ID,'''') = isnull(E.S20ID,'''') 
INNER JOIN AT1302 C WITH (NOLOCK) on C.DivisionID IN (B.DivisionID,''@@@'') AND C.InventoryID = B.InventoryID
INNER JOIN AT1302 WITH (NOLOCK) on 	AT1302.DivisionID IN (B.DivisionID,''@@@'') AND AT1302.InventoryID = B.InventoryID
LEFT JOIN AT1015 I1 WITH (NOLOCK) on AT1302.DivisionID IN (I1.DivisionID,''@@@'') AND I1.AnaID = AT1302.I01ID and I1.AnaTypeID =''I01''
LEFT JOIN AT1015 I2 WITH (NOLOCK) on AT1302.DivisionID IN (I2.DivisionID,''@@@'') AND I2.AnaID = AT1302.I01ID and I2.AnaTypeID =''I02''
LEFT JOIN AT1015 I3 WITH (NOLOCK) on AT1302.DivisionID IN (I3.DivisionID,''@@@'') AND I3.AnaID = AT1302.I01ID and I3.AnaTypeID =''I03''
LEFT JOIN AT1015 I4 WITH (NOLOCK) on AT1302.DivisionID IN (I4.DivisionID,''@@@'') AND I4.AnaID = AT1302.I01ID and I4.AnaTypeID =''I04''
LEFT JOIN AT1015 I5 WITH (NOLOCK) on AT1302.DivisionID IN (I5.DivisionID,''@@@'') AND I5.AnaID = AT1302.I01ID and I5.AnaTypeID =''I05'''
Set @sSQLWhere_A ='
LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = A.ObjectID
LEFT JOIN AT1304 G WITH (NOLOCK) on AT1302.DivisionID IN (G.DivisionID,''@@@'') AND G.UnitID = AT1302.UnitID
LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaID = E.Ana01ID and A01.AnaTypeID = ''A01''
LEFT JOIN AT1401 WITH (NOLOCK) on AT1401.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND AT1401.GroupID = N''' +@GroupID+ '''
Where  (B.InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''') and 
	B.DeQuantity =0 and	
	A.KindVoucherID   in '+ @KindVoucherListIm +' and 
						
	(B.ReTranMonth + 100*B.ReTranYear Between '+@FromMonthYearText+'  and '+@ToMonthYearText+' ) and
						(A.WareHouseID between '''+@FromWareHouseID+''' and ''' + @ToWareHouseID + ''') and
						A.DivisionID ='''+@DivisionID+'''and
	(AT1302.IsSource = 1 OR AT1302.IsLimitDate = 1)
	
----Nhung phieu da xuat kho o ky truoc ma khong xuat kho o ky nay.
union all
Select 	null AS DeVoucherDate, null AS DeVoucherNo,  A.WareHouseID, 
----'+@WareHouseID1+' AS WareHouseID,
B.InventoryID, AT1302.InventoryName, AT1302.UnitID, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, I1.AnaName AS AnaName1, I2.AnaName AS AnaName2, 
I3.AnaName AS AnaName3, I4.AnaName AS AnaName4, I5.AnaName AS AnaName5, AT1302.VATPercent, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, AT1302.Specification, 
null AS DeQuantity, null  AS DeAmount, B.ActualQuantity  AS ReQuantity, B.ConvertedAmount AS ReAmount, B.ReVoucherID, A.VoucherNo  AS ReVoucherNo, 
A.VoucherDate AS ReVoucherDate, A.ObjectID AS ReObjectID, AT1202.ObjectName AS ReObjectName, B.TransactionID AS ReTransactionID, B.SourceNo AS ReSourceNo, B.WarrantyNo AS ReWarrantyNo, B.ShelvesID AS ReShelvesID, B.FloorID AS ReFloorID, wt0169.ShelvesName AS ReShelvesName, wt0170.FloorName AS ReFloorName,			B.LimitDate, 
null AS ObjectID, null AS ObjectName, B.DivisionID, A.RefNo01, A.RefNo02, G.UnitName, B.Ana01ID, A01.AnaName as AnaName01,
ISNULL(B.S01ID,'''') AS S01ID, ISNULL(B.S02ID,'''') AS S02ID, ISNULL(B.S03ID,'''') AS S03ID, ISNULL(B.S04ID,'''') AS S04ID, ISNULL(B.S05ID,'''') AS S05ID, 
ISNULL(B.S06ID,'''') AS S06ID, ISNULL(B.S07ID,'''') AS S07ID, ISNULL(B.S08ID,'''') AS S08ID, ISNULL(B.S09ID,'''') AS S09ID, ISNULL(B.S10ID,'''') AS S10ID,
ISNULL(B.S11ID,'''') AS S11ID, ISNULL(B.S12ID,'''') AS S12ID, ISNULL(B.S13ID,'''') AS S13ID, ISNULL(B.S14ID,'''') AS S14ID, ISNULL(B.S15ID,'''') AS S15ID, 
ISNULL(B.S16ID,'''') AS S16ID, ISNULL(B.S17ID,'''') AS S17ID, ISNULL(B.S18ID,'''') AS S18ID, ISNULL(B.S19ID,'''') AS S19ID, ISNULL(B.S20ID,'''') AS S20ID,
B.Parameter01, B.Parameter02, B.Parameter03, B.Parameter04, B.Parameter05, N'''+@GroupID+''' as GroupID, AT1401.GroupName,
0 AS DeConvertedQuantity, B.ConvertedQuantity AS ReConvertedQuantity, B.ConvertedUnitID
From  AV2777 B WITH (NOLOCK)
left join wt0169 WITH (NOLOCK) on b.ShelvesID = wt0169.ShelvesID
left join wt0170 WITH (NOLOCK) on b.FloorID = wt0170.FloorID
INNER JOIN AV2666 A on A.VoucherID = B.VoucherID and A.DivisionID = B.DivisionID
INNER JOIN AT1302 C WITH (NOLOCK) on C.DivisionID IN (B.DivisionID,''@@@'') AND C.InventoryID = B.InventoryID
INNER JOIN AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (B.DivisionID,''@@@'') AND AT1302.InventoryID = B.InventoryID
LEFT JOIN AT1015 I1 WITH (NOLOCK) on AT1302.DivisionID IN (I1.DivisionID,''@@@'') AND I1.AnaID = AT1302.I01ID and I1.AnaTypeID =''I01''
LEFT JOIN AT1015 I2 WITH (NOLOCK) on AT1302.DivisionID IN (I2.DivisionID,''@@@'') AND I2.AnaID = AT1302.I01ID and I2.AnaTypeID =''I02''
LEFT JOIN AT1015 I3 WITH (NOLOCK) on AT1302.DivisionID IN (I3.DivisionID,''@@@'') AND I3.AnaID = AT1302.I01ID and I3.AnaTypeID =''I03''
LEFT JOIN AT1015 I4 WITH (NOLOCK) on AT1302.DivisionID IN (I4.DivisionID,''@@@'') AND I4.AnaID = AT1302.I01ID and I4.AnaTypeID =''I04''
LEFT JOIN AT1015 I5 WITH (NOLOCK) on AT1302.DivisionID IN (I5.DivisionID,''@@@'') AND I5.AnaID = AT1302.I01ID and I5.AnaTypeID =''I05''
LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = A.ObjectID
'
Set @sSQLWhere_B ='
LEFT JOIN AT1304 G WITH (NOLOCK) on AT1302.DivisionID IN (G.DivisionID,''@@@'') AND G.UnitID = AT1302.UnitID
LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaID = B.Ana01ID and A01.AnaTypeID = ''A01''
LEFT JOIN AT1401 WITH (NOLOCK) on AT1401.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND AT1401.GroupID = N''' +@GroupID+ '''
Where  (B.InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''') and 
	A.KindVoucherID   in '+ @KindVoucherListIm +' and 
	B.VoucherID not in ( select ReVoucherID From AV2666 INNER JOIN AV2777 on AV2777.VoucherID = AV2666.VoucherID
				where KindVoucherID in  '+ @KindVoucherListEx +'  and isnull(KindVoucherID,'''')<>'''' and (AV2666.TranMonth + 100*AV2666.TranYear  Between '+@FromMonthYearText+'  and '+@ToMonthYearText+' )) and

	( A.WareHouseID  between '''+@FromWareHouseID+''' and ''' + @ToWareHouseID + ''') and

	(AT1302.IsSource = 1 OR AT1302.IsLimitDate = 1) and
	B.DivisionID ='''+@DivisionID+'''  And
	B.TranMonth + 100*B.TranYear  Between '+@FromMonthYearText+'  and '+@ToMonthYearText+'
'
end

--PRINT(@sSQLSelect_A) 
--PRINT(@sSQLSelect_B) 
--PRINT(@sSQLFrom)
--PRINT(@sSQLWhere_A)
--PRINT(@sSQLWhere_B)

IF NOT EXISTS (SELECT 1 FROM  SYSOBJECTS WHERE XTYPE ='V' AND NAME ='AV0244')
	EXEC(' CREATE VIEW AV0244  -----TAO BOI AP0214
		AS '+ @sSQLSelect_A + @sSQLSelect_B + @sSQLFrom + @sSQLWhere_A + @sSQLWhere_B)
ELSE
	EXEC(' ALTER VIEW AV0244  -----TAO BOI AP0214
		AS '+ @sSQLSelect_A + @sSQLSelect_B + @sSQLFrom + @sSQLWhere_A + @sSQLWhere_B)

Set @sSQLSelect_A ='
---- Lấy đầu kỳ
SELECT InventoryID, UnitID, ConvertedUnitID, SUM(ActualQuantity) AS ActualQuantity, SUM(ConvertedQuantity) AS ConvertedQuantity, ObjectID, SourceNo
INTO #TEMPT1
FROM (
SELECT VoucherNo, TransactionID, ReTransactionID, B.VoucherID, ReVoucherID, InventoryID, UnitID, ConvertedUnitID, B.TranMonth, B.TranYear, ActualQuantity, ConvertedQuantity, ObjectID, SourceNo
FROM AV2777 B
INNER JOIN AV2666 D ON D.VoucherID = B.VoucherID and D.DivisionID = B.DivisionID
WHERE KindVoucherID IN (1,3,5,7,9)
UNION ALL
SELECT VoucherNo, TransactionID, ReTransactionID, B.VoucherID, ReVoucherID, InventoryID, UnitID, ConvertedUnitID, B.TranMonth, B.TranYear, -ActualQuantity AS ActualQuantity, -ConvertedQuantity AS ConvertedQuantity, ObjectID, SourceNo
FROM AV2777 B
INNER JOIN AV2666 D ON D.VoucherID = B.VoucherID and D.DivisionID = B.DivisionID
WHERE KindVoucherID IN (2,4,6,8,10)) B
WHERE '+@sSQLWhere_C+'
GROUP BY InventoryID, UnitID, ConvertedUnitID, ObjectID, SourceNo

Select AV0244.*, AT1303.WareHouseName,
A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20,
(SELECT SUM(ActualQuantity) FROM #TEMPT1 WHERE ObjectID = ObjectID AND SourceNo = ReSourceNo AND InventoryID = InventoryID) AS BeQuantity,
(SELECT SUM(ConvertedQuantity) FROM #TEMPT1 WHERE ObjectID = ObjectID AND SourceNo = ReSourceNo AND InventoryID = InventoryID) AS BeConvertedQuantity'
SET @sSQLFrom = N'
INTO #TEMPT2
From AV0244 
INNER JOIN AT1303 on AT1303.WareHouseID = AV0244.WareHouseID and  AT1303.DivisionID IN ('''+@DivisionID+''', ''@@@'')  
LEFT JOIN AT0128 A01 WITH (NOLOCK) ON AV0244.S01ID = A01.StandardID AND A01.StandardTypeID = ''S01''
LEFT JOIN AT0128 A02 WITH (NOLOCK) ON AV0244.S02ID = A02.StandardID AND A02.StandardTypeID = ''S02''
LEFT JOIN AT0128 A03 WITH (NOLOCK) ON AV0244.S03ID = A03.StandardID AND A03.StandardTypeID = ''S03''
LEFT JOIN AT0128 A04 WITH (NOLOCK) ON AV0244.S04ID = A04.StandardID AND A04.StandardTypeID = ''S04''
LEFT JOIN AT0128 A05 WITH (NOLOCK) ON AV0244.S05ID = A05.StandardID AND A05.StandardTypeID = ''S05''
LEFT JOIN AT0128 A06 WITH (NOLOCK) ON AV0244.S06ID = A06.StandardID AND A06.StandardTypeID = ''S06''
LEFT JOIN AT0128 A07 WITH (NOLOCK) ON AV0244.S07ID = A07.StandardID AND A07.StandardTypeID = ''S07''
LEFT JOIN AT0128 A08 WITH (NOLOCK) ON AV0244.S08ID = A08.StandardID AND A08.StandardTypeID = ''S08''
LEFT JOIN AT0128 A09 WITH (NOLOCK) ON AV0244.S09ID = A09.StandardID AND A09.StandardTypeID = ''S09''
LEFT JOIN AT0128 A10 WITH (NOLOCK) ON AV0244.S10ID = A10.StandardID AND A10.StandardTypeID = ''S10''
LEFT JOIN AT0128 A11 WITH (NOLOCK) ON AV0244.S11ID = A11.StandardID AND A11.StandardTypeID = ''S11''
LEFT JOIN AT0128 A12 WITH (NOLOCK) ON AV0244.S12ID = A12.StandardID AND A12.StandardTypeID = ''S12''
LEFT JOIN AT0128 A13 WITH (NOLOCK) ON AV0244.S13ID = A13.StandardID AND A13.StandardTypeID = ''S13''
LEFT JOIN AT0128 A14 WITH (NOLOCK) ON AV0244.S14ID = A14.StandardID AND A14.StandardTypeID = ''S14''
LEFT JOIN AT0128 A15 WITH (NOLOCK) ON AV0244.S15ID = A15.StandardID AND A15.StandardTypeID = ''S15''
LEFT JOIN AT0128 A16 WITH (NOLOCK) ON AV0244.S16ID = A16.StandardID AND A16.StandardTypeID = ''S16''
LEFT JOIN AT0128 A17 WITH (NOLOCK) ON AV0244.S17ID = A17.StandardID AND A17.StandardTypeID = ''S17''
LEFT JOIN AT0128 A18 WITH (NOLOCK) ON AV0244.S18ID = A18.StandardID AND A18.StandardTypeID = ''S18''
LEFT JOIN AT0128 A19 WITH (NOLOCK) ON AV0244.S19ID = A19.StandardID AND A19.StandardTypeID = ''S19''
LEFT JOIN AT0128 A20 WITH (NOLOCK) ON AV0244.S20ID = A20.StandardID AND A20.StandardTypeID = ''S20''
'
SET @sSQLSelect_B = N'
SELECT CASE WHEN KindVoucherID IN (2,4,6,8) THEN VoucherDate ELSE NULL END AS DeVoucherDate, 
CASE WHEN KindVoucherID IN (2,4,6,8) THEN VoucherNo ELSE NULL END AS DeVoucherNo, D.WareHouseID, B.InventoryID, InventoryName, B.UnitID,
NULL AS I01ID, NULL AS I02ID, NULL AS I03ID, NULL AS I04ID, NULL AS I05ID, NULL AS AnaName1, NULL AS AnaName2, 
NULL AS AnaName3, NULL AS AnaName4, NULL AS AnaName5, NULL AS VATPercent, '''' AS Notes01, '''' AS Notes02, '''' AS Notes03, '''' AS Specification, 
0 AS DeQuantity, 0 AS DeAmount, 0 AS ReQuantity, 0 AS ReAmount, '''' AS ReVoucherID,
CASE WHEN KindVoucherID IN (1,3,5,7,9) THEN D.VoucherNo ELSE NULL END AS ReVoucherNo,
CASE WHEN KindVoucherID IN (1,3,5,7,9) THEN VoucherDate ELSE NULL END AS ReVoucherDate, 
D.ObjectID AS ReObjectID,
AT1202.ObjectName AS ReObjectName, '''' AS ReTransactionID, B.SourceNo AS ReSourceNo, '''' AS ReWarrantyNo, '''' AS ReShelvesID, '''' AS ReFloorID,
'''' AS ReShelvesName, '''' AS ReFloorName, NULL AS LimitDate, D.ObjectID, ObjectName, B.DivisionID, D.RefNo01, D.RefNo02, AT1304.UnitName, '''' AS Ana01ID, '''' AS AnaName01,
NULL AS S01ID, NULL AS S02ID, NULL AS S03ID, NULL AS S04ID, NULL AS S05ID, 
NULL AS S06ID, NULL AS S07ID, NULL AS S08ID, NULL AS S09ID, NULL AS S10ID,
NULL AS S11ID, NULL AS S12ID, NULL AS S13ID, NULL AS S14ID, NULL AS S15ID, 
NULL AS S16ID, NULL AS S17ID, NULL AS S18ID, NULL AS S19ID, NULL AS S20ID,
NULL AS Parameter01, NULL AS Parameter02, NULL AS Parameter03, NULL AS Parameter04, NULL AS Parameter05, '''' AS GroupID, '''' AS GroupName,
0 AS DeConvertedQuantity, 0 AS ReConvertedQuantity, 
'''' AS ConvertedUnitID, WareHouseName,
NULL AS StandardName01, NULL AS StandardName02, NULL AS StandardName03, NULL AS StandardName04, 
NULL AS StandardName05, NULL AS StandardName06, NULL AS StandardName07, NULL AS StandardName08, 
NULL AS StandardName09, NULL AS StandardName10, NULL AS StandardName11, NULL AS StandardName12,
NULL AS StandardName13, NULL AS StandardName14, NULL AS StandardName15, NULL AS StandardName16,
NULL AS StandardName17, NULL AS StandardName18, NULL AS StandardName19, NULL AS StandardName20,
(CASE WHEN KindVoucherID IN (1,3,5,7,9) THEN SUM(B.ActualQuantity) ELSE 0 END - CASE WHEN KindVoucherID IN (2,4,6,8) THEN SUM(B.ActualQuantity) ELSE 0 END) AS BeQuantity,
(CASE WHEN KindVoucherID IN (1,3,5,7,9) THEN SUM(B.ConvertedQuantity) ELSE 0 END - CASE WHEN KindVoucherID IN (2,4,6,8) THEN SUM(B.ConvertedQuantity) ELSE 0 END) AS BeConvertedQuantity
INTO #TEMPT3
FROM AV2777 B
INNER JOIN AV2666 D ON D.VoucherID = B.VoucherID and D.DivisionID = B.DivisionID
INNER JOIN #TEMPT1 E ON E.SourceNo = B.SourceNo AND E.ObjectID = D.ObjectID
INNER JOIN AT1302 WITH (NOLOCK) on AT1302.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1302.InventoryID = B.InventoryID
LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND AT1202.ObjectID = D.ObjectID
INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND AT1303.WareHouseID = D.WareHouseID
LEFT JOIN AT1304 WITH (NOLOCK) on AT1304.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND AT1304.UnitID = AT1302.UnitID'

SET @sSQLWhere_B = N'
WHERE (B.InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''') and 
	  (D.WareHouseID  between '''+@FromWareHouseID+''' and ''' + @ToWareHouseID + ''') and
	  '+@sSQLWhere_C+' AND 
	  E.ActualQuantity > 0 AND 
	  D.VoucherNo NOT IN (SELECT ReVoucherNo FROM #TEMPT2)
GROUP BY VoucherDate, VoucherNo, D.WareHouseID, AT1303.WareHouseName, B.InventoryID, InventoryName, B.UnitID,
		 B.SourceNo, D.ObjectID, ObjectName, B.DivisionID, D.RefNo01, D.RefNo02, AT1304.UnitName, KindVoucherID

SELECT * 
INTO #TEMPT4
FROM (SELECT * FROM #TEMPT2
	  UNION ALL
	  SELECT * FROM #TEMPT3) AS A
ORDER BY ReObjectID

SELECT InventoryID, ReSourceNo, ReObjectID, ReVoucherID, BeQuantity, BeConvertedQuantity
INTO #TEMPT5
FROM #TEMPT4
GROUP BY InventoryID, ReSourceNo, ReObjectID, ReVoucherID, BeQuantity, BeConvertedQuantity

SELECT *,
	   ISNULL((SELECT SUM(ISNULL(BeQuantity,0)) FROM #TEMPT5 WHERE DivisionID = A.DivisionID AND ReSourceNo = A.ReSourceNo AND ReObjectID = A.ReObjectID AND InventoryID = A.InventoryID GROUP BY ReSourceNo, ReObjectID, InventoryID),0) AS SumBeQuantity,
	   ISNULL((SELECT SUM(ISNULL(BeConvertedQuantity,0)) FROM #TEMPT5 WHERE DivisionID = A.DivisionID AND ReSourceNo = A.ReSourceNo AND ReObjectID = A.ReObjectID AND InventoryID = A.InventoryID GROUP BY ReSourceNo, ReObjectID, InventoryID),0) AS SumBeConvertedQuantity,
	   ISNULL((SELECT SUM(ISNULL(ReQuantity,0)) FROM #TEMPT4 WHERE DivisionID = A.DivisionID AND ReSourceNo = A.ReSourceNo AND ReObjectID = A.ReObjectID AND InventoryID = A.InventoryID AND DeVoucherNo = A.DeVoucherNo GROUP BY ReSourceNo, ReObjectID, InventoryID, DeVoucherNo),0) AS SumReQuantity,
	   ISNULL((SELECT SUM(ISNULL(ReConvertedQuantity,0)) FROM #TEMPT4 WHERE DivisionID = A.DivisionID AND ReSourceNo = A.ReSourceNo AND ReObjectID = A.ReObjectID AND InventoryID = A.InventoryID AND DeVoucherNo = A.DeVoucherNo GROUP BY ReSourceNo, ReObjectID, InventoryID, DeVoucherNo),0) AS SumReConvertedQuantity,
	   (ISNULL((SELECT SUM(ISNULL(BeQuantity,0)) FROM #TEMPT5 WHERE DivisionID = A.DivisionID AND ReSourceNo = A.ReSourceNo AND ReObjectID = A.ReObjectID AND InventoryID = A.InventoryID GROUP BY ReSourceNo, ReObjectID, InventoryID),0) +	    
		ISNULL((SELECT SUM(ISNULL(ReQuantity,0)) FROM #TEMPT4 WHERE DivisionID = A.DivisionID AND ReSourceNo = A.ReSourceNo AND ReObjectID = A.ReObjectID AND InventoryID = A.InventoryID AND DeVoucherNo = A.DeVoucherNo GROUP BY ReSourceNo, ReObjectID, InventoryID, DeVoucherNo),0) -		
		ISNULL((SELECT SUM(ISNULL(DeQuantity,0)) FROM #TEMPT4 WHERE DivisionID = A.DivisionID AND ReSourceNo = A.ReSourceNo AND ReObjectID = A.ReObjectID AND InventoryID = A.InventoryID GROUP BY ReSourceNo, ReObjectID, InventoryID),0)) AS SumEndQuantity,
	   (ISNULL((SELECT SUM(ISNULL(BeConvertedQuantity,0)) FROM #TEMPT5 WHERE DivisionID = A.DivisionID AND ReSourceNo = A.ReSourceNo AND ReObjectID = A.ReObjectID AND InventoryID = A.InventoryID GROUP BY ReSourceNo, ReObjectID, InventoryID),0) +	    
		ISNULL((SELECT SUM(ISNULL(ReConvertedQuantity,0)) FROM #TEMPT4 WHERE DivisionID = A.DivisionID AND ReSourceNo = A.ReSourceNo AND ReObjectID = A.ReObjectID AND InventoryID = A.InventoryID AND DeVoucherNo = A.DeVoucherNo GROUP BY ReSourceNo, ReObjectID, InventoryID, DeVoucherNo),0) -		
		ISNULL((SELECT SUM(ISNULL(DeConvertedQuantity,0)) FROM #TEMPT4 WHERE DivisionID = A.DivisionID AND ReSourceNo = A.ReSourceNo AND ReObjectID = A.ReObjectID AND InventoryID = A.InventoryID GROUP BY ReSourceNo, ReObjectID, InventoryID),0)) AS SumEndConvertedQuantity
FROM #TEMPT4 A
'

--PRINT @sSQLSelect_A
--PRINT @sSQLFrom
--PRINT @sSQLSelect_B
--PRINT @sSQLWhere_B

EXEC (@sSQLSelect_A + @sSQLFrom + @sSQLSelect_B + @sSQLWhere_B)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
