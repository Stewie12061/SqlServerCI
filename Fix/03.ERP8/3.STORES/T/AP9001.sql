IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP9001]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP9001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created by Nguyen Thi Ngoc Minh
---- Created Date 04/11/2004
---- Purpose: Tra ra view truy van but toan
--- EDIT BY NGUYEN QUOC HUY
---- Edit by: Dang Le Bao Quynh; Date: 24/11/2008
---- Purpose: Bi sung them ma phan tich 4, ma phan tich 5
---- Modified on 20/01/2012 by Le Thi Thu Hien : Sua dieu kien CONVERT theo ngay
---- Modified on 25/06/2012 by Bao Anh : Them TransactionTypeID, VoucherID va khong lay cac but toan cua cac module khac Asoft-T
---- Modified on 27/06/2012 by Bao Anh : Bo sung but toan ngan sach chi phi- chi tieu doanh thu (lay tu AT9090)
---- Modified on 04/09/2012 by Thiên Huỳnh : Bổ sung BudgetType (but toan ngan sach chi phi- chi tieu doanh thu)
---- Modified on 23/12/2012 by Bao Anh : Bo sung cac but toan thuoc phan he khac Asoft-T, them truong TableID
---- Modified on 21/01/2013 by Bao Anh : Bo sung phieu VCNB, nhap kho mua hang tu Asoft-WM, them truong KindVoucherID
---- Modified on 05/03/2013 by Khanh Van : Bo sung load het tat ca ma phan tich theo yeu cau cua Sieu Thanh
---- Modified on 14/03/2013 by Bao Anh : Sua kieu du lieu cac bien @Ssql thanh varchar(max) vi nvarchar(max) khong du chieu dai
---- Modified on 12/04/2013 by Le Thi Thu Hien : Doi UNION thanh UNION ALL  (0020484 )
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 11/07/2016: Fix bug không lên đúng số lượng, đơn giá. Bỏ những đoạn thừa.
---- Modify on 25/04/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified by Bảo Thy on 09/08/2017: lấy VATObjectName lên thay cho T1202.ObjectName trường hợp đối tượng là vãng lai (IsUpdateName = 1)
---- Modified by Tiểu Mai on 25/10/2017: Bổ sung lấy DueDate (Ngày đáo hạn)
---- Modified by Kim Thư on 25/02/2019: Sửa cách lấy ObjectName cho khách vãng lai là ISNULL(AT9000.VATObjectName,AT1202.ObjectName), khách không vãng lai thì lấy AT1202.ObjectName.
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Nhựt Trường on 03/02/2021: Bổ sung điều kiện DivisionID IN khi join bảng AT1103.
---- Modified by Nhật Thanh on 23/03/2022: [Angel] không lấy cột vatconvertedAmount ở AT9090
---- Modified by Xuân Nguyên on 14/04/2022: [SieuThanh] Bổ sung điều kiện DivisionID khi join bảng AT1202.
---- Modified by Xuân Nguyên on 14/04/2022: [SieuThanh] Bổ sung điều kiện DivisionID IN khi join bảng AT1202.
---- Modified by Xuân Nguyên on 05/05/2022: Bổ sung Distinct
---- Modified by Xuân Nguyên on 04/07/2022: [2022/07/IS/0008]Bổ sung điều kiện DivisionID IN khi join bảng AT1304
---- Modified by Nhựt Trường on 12/08/2022: [2022/08/IS/0092] - Lấy lên diễn giải chứng từ AT2006.Description, AT2007.Notes.
---- Modified by Thành Sang  on 08/09/2022: Bổ sung thêm điều kiện DivisionID khi join các bảng dùng chung.
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.

/********************************************
'* Edited by: [GS] [Hoàng Phước] [29/07/2010]
'********************************************/

CREATE PROCEDURE [dbo].[AP9001] 	
				@FromMonth int,
				@FromYear int,
				@ToMonth int,
				@ToYear int,
				@FromDate datetime,
				@ToDate datetime,
				@IsDate tinyint,	
				@DivisionID nvarchar(50),
				@IsBalance tinyint,
				@strColumns as nvarchar(max),
				@strOrder as nvarchar(max)

AS

Declare @Ssql varchar(MAX),
	@Sfrom nvarchar(4000),
	@Swhere nvarchar(4000),
	@Ssql_AT9090 varchar(max),
	@strColumns_AT9090 NVARCHAR(MAX),
	@Sfrom_AT9090 nvarchar(4000),
	@Ssql_AT2006_W03 varchar(max),
	@strColumns_AT2006 NVARCHAR(MAX),
	@Sfrom_AT2006 nvarchar(4000),
	@Ssql_AT2006_W05 varchar(max),
	@CustomerName INT

SELECT top 1 @CustomerName = CustomerName from CustomerIndex
Set @Ssql = ''
Set @Sfrom = ''
Set @Swhere = ''
SET @Ssql_AT9090 = ''
SET @strColumns_AT9090 = @strColumns
SET @Sfrom_AT9090 = ''
SET @Ssql_AT2006_W03 = ''
SET @strColumns_AT2006 = @strColumns
SET @Sfrom_AT2006 = ''
SET @Ssql_AT2006_W05 = ''

---------------Loc theo thoi gian------------------------------
If @IsDate = 0		--theo ky
	Set @Swhere = @Swhere + ' and T90.TranMonth + T90.TranYear*100 between ' + ltrim(str(@FromMonth + @FromYear*100)) + ' and ' + ltrim(str(@ToMonth + @ToYear*100)) 
Else			--theo ngay
	Set @Swhere = @Swhere + ' and CONVERT(DATETIME,CONVERT(VARCHAR(10),T90.VoucherDate,101),101) between ''' + convert(nvarchar(20),@FromDate,101) + ''' and ''' + convert(nvarchar(20),@ToDate,101) + ''''

--------------Loc so du-----------------
If @IsBalance = 0	--khong lay so du
	Set @Swhere = @Swhere + '
	and Isnull(T90.TransactionTypeID,'''') <> ''T00'''

-----------Tao cau lien ket cac bang------------------
If PATINDEX('%ObjectName%',@strColumns) <> 0
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT1202 T1202 WITH (NOLOCK) on T1202.DivisionID in(T90.DivisionID,''@@@'') and T1202.ObjectID = T90.ObjectID '

If PATINDEX('%CreditObjectName%',@strColumns) <> 0
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT1202 T1202A WITH (NOLOCK) on T1202A.DivisionID in(T90.DivisionID,''@@@'') and T1202A.ObjectID = T90.CreditObjectID '

If PATINDEX('%VATObjectName%',@strColumns) <> 0
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT1202 T1202B WITH (NOLOCK) on T1202B.DivisionID in(T90.DivisionID,''@@@'') and T1202B.ObjectID = isnull(T90.VATObjectID,T90.ObjectID)'

If PATINDEX('%VATObjectAddress%',@strColumns) <> 0 and PATINDEX('%VATObjectName%',@strColumns) = 0
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT1202 T1202B WITH (NOLOCK) on T1202B.DivisionID in(T90.DivisionID,''@@@'') and T1202B.ObjectID = isnull(T90.VATObjectID,T90.ObjectID)'

If PATINDEX('%VATNo%',@strColumns) <> 0 and PATINDEX('%VATObjectName%',@strColumns) = 0 
		and PATINDEX('%VATObjectAddress%',@strColumns) = 0
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT1202 T1202B WITH (NOLOCK) on T1202B.DivisionID in(T90.DivisionID,''@@@'') and T1202B.ObjectID = isnull(T90.VATObjectID,T90.ObjectID)'

--If PATINDEX('%InventoryID%',@strColumns) <> 0
--	Set @Sfrom = @Sfrom + ' 
--		LEFT JOIN AT2007 T2007 WITH (NOLOCK) on T2007.TransactionID = T90.TransactionID and T2007.DivisionID = T90.DivisionID '

If PATINDEX('%InventoryName%',@strColumns) <> 0 and PATINDEX('%InventoryID%',@strColumns) <> 0
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT1302 T1302 WITH (NOLOCK) on T1302.DivisionID IN (T90.DivisionID,''@@@'') AND T1302.InventoryID = T90.InventoryID '
--Else If PATINDEX('%InventoryName%',@strColumns) <> 0 and PATINDEX('%InventoryID%',@strColumns) = 0
--	Set @Sfrom = @Sfrom + ' 
--		LEFT JOIN AT2007 T2007 WITH (NOLOCK) on T2007.TransactionID = T90.TransactionID and T2007.DivisionID = T90.DivisionID
--		LEFT JOIN AT1302 T1302 WITH (NOLOCK) on T1302.InventoryID = T2007.InventoryID and T1302.DivisionID = T2007.DivisionID '

If PATINDEX('%UnitName%',@strColumns) <> 0 and (PATINDEX('%InventoryName%',@strColumns) <> 0 or PATINDEX('%InventoryID%',@strColumns) <> 0) 
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT1304 T1304 WITH (NOLOCK) on T1304.DivisionID in(T90.DivisionID,''@@@'') and T1304.UnitID = T90.UnitID '
--Else If PATINDEX('%UnitName%',@strColumns) <> 0 and PATINDEX('%InventoryName%',@strColumns) = 0 and PATINDEX('%InventoryID%',@strColumns) = 0
--	Set @Sfrom = @Sfrom + ' 
--		--LEFT JOIN AT2007 T2007 WITH (NOLOCK) on T2007.TransactionID = T90.TransactionID and T2007.DivisionID = T90.DivisionID
--		LEFT JOIN AT1304 T1304 WITH (NOLOCK) on T1304.UnitID = T90.UnitID and T1304.DivisionID = T90.DivisionID '

--If PATINDEX('%Quantity%',@strColumns) <> 0 and (PATINDEX('%InventoryName%',@strColumns) = 0 and  (PATINDEX('%InventoryID%',@strColumns) = 0) AND PATINDEX('%UnitName%',@strColumns) = 0)
--	Set @Sfrom = @Sfrom + ' 
--		LEFT JOIN AT2007 T2007 WITH (NOLOCK) on T2007.TransactionID = T90.TransactionID and T2007.DivisionID = T90.DivisionID '

--If PATINDEX('%UnitPrice%',@strColumns) <> 0 and (PATINDEX('%InventoryName%',@strColumns) = 0 and PATINDEX('%UnitName%',@strColumns) = 0 and (PATINDEX('%InventoryID%',@strColumns) = 0) 
--			and PATINDEX('%Quantity%',@strColumns) = 0)
--	Set @Sfrom = @Sfrom + ' 
--		LEFT JOIN AT2007 T2007 WITH (NOLOCK) on T2007.TransactionID = T90.TransactionID and T2007.DivisionID = T90.DivisionID '

If PATINDEX('%EmployeeName%',@strColumns) <> 0
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT1103 T1103 WITH (NOLOCK)on T1103.DivisionID IN (T90.DivisionID,''@@@'') AND T1103.EmployeeID = T90.EmployeeID '

If PATINDEX('%WareHouseID%',@strColumns) <> 0
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT2006 T2006 WITH (NOLOCK) on T2006.VoucherID = T90.VoucherID and T2006.DivisionID = T90.DivisionID '

If PATINDEX('%WareHouseName%',@strColumns) <> 0 and PATINDEX('%WareHouseID%',@strColumns) = 0
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT2006 T2006 WITH (NOLOCK) on T2006.VoucherID = T90.VoucherID and T2006.DivisionID = T90.DivisionID
		LEFT JOIN AT1303 T1303 WITH (NOLOCK) on T1303.DivisionID in(T90.DivisionID,''@@@'') AND T1303.WareHouseID = T2006.WareHouseID '
Else If PATINDEX('%WareHouseName%',@strColumns) <> 0 and PATINDEX('%WareHouseID%',@strColumns) <> 0
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT1303 T1303 WITH (NOLOCK) on T1303.DivisionID in(''' + @DivisionID + ''',''@@@'') AND T1303.WareHouseID = T2006.WareHouseID '

If PATINDEX('%Ana01Name%',@strColumns) <> 0
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT1011 T1011A WITH (NOLOCK) on (T1011A.AnaID = T90.Ana01ID and T1011A.DivisionID = T90.DivisionID and
						T1011A.AnaTypeID = ''A01'')'

If PATINDEX('%Ana02Name%',@strColumns) <> 0
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT1011 T1011B WITH (NOLOCK) on (T1011B.AnaID = T90.Ana02ID and T1011B.DivisionID = T90.DivisionID and
						T1011B.AnaTypeID = ''A02'')'

If PATINDEX('%Ana03Name%',@strColumns) <> 0
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT1011 T1011C WITH (NOLOCK) on (T1011C.AnaID = T90.Ana03ID and T1011C.DivisionID = T90.DivisionID and
						T1011C.AnaTypeID = ''A03'')'

If PATINDEX('%Ana04Name%',@strColumns) <> 0
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT1011 T1011D WITH (NOLOCK) on (T1011D.AnaID = T90.Ana04ID and T1011D.DivisionID = T90.DivisionID and
						T1011D.AnaTypeID = ''A04'')'

If PATINDEX('%Ana05Name%',@strColumns) <> 0
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT1011 T1011E WITH (NOLOCK) on (T1011E.AnaID = T90.Ana05ID and T1011E.DivisionID = T90.DivisionID and
						T1011E.AnaTypeID = ''A05'')'

If PATINDEX('%Ana06Name%',@strColumns) <> 0
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT1011 T1011F WITH (NOLOCK) on (T1011F.AnaID = T90.Ana06ID and T1011F.DivisionID = T90.DivisionID and
						T1011F.AnaTypeID = ''A06'')'

If PATINDEX('%Ana07Name%',@strColumns) <> 0
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT1011 T1011G WITH (NOLOCK) on (T1011G.AnaID = T90.Ana07ID and T1011G.DivisionID = T90.DivisionID and
						T1011G.AnaTypeID = ''A07'')'

If PATINDEX('%Ana08Name%',@strColumns) <> 0
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT1011 T1011H WITH (NOLOCK) on (T1011H.AnaID = T90.Ana08ID and T1011H.DivisionID = T90.DivisionID and
						T1011H.AnaTypeID = ''A08'')'

If PATINDEX('%Ana09Name%',@strColumns) <> 0
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT1011 T1011I WITH (NOLOCK) on (T1011I.AnaID = T90.Ana09ID and T1011I.DivisionID = T90.DivisionID and
						T1011I.AnaTypeID = ''A09'')'	
																			
If PATINDEX('%Ana10Name%',@strColumns) <> 0
	Set @Sfrom = @Sfrom + ' 
		LEFT JOIN AT1011 T1011J WITH (NOLOCK) on (T1011J.AnaID = T90.Ana10ID and T1011J.DivisionID = T90.DivisionID and
						T1011J.AnaTypeID = ''A10'')'				
IF @CustomerName = 57
BEGIN
	-- Bổ sung thành tiền chiết khấu, chiết khấu doanh số, cột VAT, Cột MPT mặt hàng số 4, MPT mặt hàng số 8, các MPT đơn hàng bán (SA-PG, SUP, ASM, ADMIN, QLADMIN), ghi chú							
	If PATINDEX('%VATConvertedAmount%',@strColumns) <> 0
		Set @Sfrom = @Sfrom + ' 
			LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.DivisionID = T90.DivisionID AND AT1010.VATGroupID = T90.VATGroupID'	
		
	If PATINDEX('%AT1015A.AnaName AS I04Name%',@strColumns) <> 0
		Set @Sfrom = @Sfrom + ' 
			LEFT JOIN AT1015 AT1015A WITH (NOLOCK) ON AT1015A.DivisionID = T1302.DivisionID AND AT1015A.AnaID = T1302.I04ID AND AT1015A.AnaTypeID = ''I04'''	
		
	If PATINDEX('%AT1015B.AnaName AS I08Name%',@strColumns) <> 0
		Set @Sfrom = @Sfrom + ' 
			LEFT JOIN AT1015 AT1015B WITH (NOLOCK) ON AT1015B.DivisionID = T1302.DivisionID AND AT1015B.AnaID = T1302.I08ID AND AT1015B.AnaTypeID = ''I08'''
		
	If PATINDEX('%OT2001.Ana01ID AS SAna01ID%',@strColumns) <> 0
	BEGIN
		IF PATINDEX('%LEFT JOIN OT2001 WITH (NOLOCK) ON T90.DivisionID = OT2001.DivisionID AND T90.OrderID = OT2001.SOrderID%',@Sfrom) = 0
		BEGIN
			Set @Sfrom = @Sfrom + ' 
			LEFT JOIN OT2001 WITH (NOLOCK) ON T90.DivisionID = OT2001.DivisionID AND T90.OrderID = OT2001.SOrderID'			
		END
	END
		
	If PATINDEX('%OT1002A.AnaName AS SAna01Name%',@strColumns) <> 0
	BEGIN
		IF PATINDEX('%LEFT JOIN OT2001 WITH (NOLOCK) ON T90.DivisionID = OT2001.DivisionID AND T90.OrderID = OT2001.SOrderID%',@Sfrom) = 0
		BEGIN
			Set @Sfrom = @Sfrom + ' 
			LEFT JOIN OT2001 WITH (NOLOCK) ON T90.DivisionID = OT2001.DivisionID AND T90.OrderID = OT2001.SOrderID'			
		END
	
		Set @Sfrom = @Sfrom + ' 
			LEFT JOIN OT1002 OT1002A ON OT2001.DivisionID = OT1002A.DivisionID AND OT2001.Ana01ID = OT1002A.AnaID AND OT1002A.AnaTypeID = ''S01'''			
	END	

	If PATINDEX('%OT2001.Ana02ID AS SAna02ID%',@strColumns) <> 0
	BEGIN
		IF PATINDEX('%LEFT JOIN OT2001 WITH (NOLOCK) ON T90.DivisionID = OT2001.DivisionID AND T90.OrderID = OT2001.SOrderID%',@Sfrom) = 0
		BEGIN
			Set @Sfrom = @Sfrom + ' 
			LEFT JOIN OT2001 WITH (NOLOCK) ON T90.DivisionID = OT2001.DivisionID AND T90.OrderID = OT2001.SOrderID'			
		END
	END
		
	If PATINDEX('%OT1002B.AnaName AS SAna02Name%',@strColumns) <> 0
	BEGIN
		IF PATINDEX('%LEFT JOIN OT2001 WITH (NOLOCK) ON T90.DivisionID = OT2001.DivisionID AND T90.OrderID = OT2001.SOrderID%',@Sfrom) = 0
		BEGIN
			Set @Sfrom = @Sfrom + ' 
			LEFT JOIN OT2001 WITH (NOLOCK) ON T90.DivisionID = OT2001.DivisionID AND T90.OrderID = OT2001.SOrderID'			
		END
	
		Set @Sfrom = @Sfrom + ' 
			LEFT JOIN OT1002 OT1002B ON OT2001.DivisionID = OT1002B.DivisionID AND OT2001.Ana02ID = OT1002B.AnaID AND OT1002B.AnaTypeID = ''S02'''			
	END			

	If PATINDEX('%OT2001.Ana03ID AS SAna03ID%',@strColumns) <> 0
	BEGIN
		IF PATINDEX('%LEFT JOIN OT2001 WITH (NOLOCK) ON T90.DivisionID = OT2001.DivisionID AND T90.OrderID = OT2001.SOrderID%',@Sfrom) = 0
		BEGIN
			Set @Sfrom = @Sfrom + ' 
			LEFT JOIN OT2001 WITH (NOLOCK) ON T90.DivisionID = OT2001.DivisionID AND T90.OrderID = OT2001.SOrderID'			
		END
	END
		
	If PATINDEX('%OT1002C.AnaName AS SAna03Name%',@strColumns) <> 0
	BEGIN
		IF PATINDEX('%LEFT JOIN OT2001 WITH (NOLOCK) ON T90.DivisionID = OT2001.DivisionID AND T90.OrderID = OT2001.SOrderID%',@Sfrom) = 0
		BEGIN
			Set @Sfrom = @Sfrom + ' 
			LEFT JOIN OT2001 WITH (NOLOCK) ON T90.DivisionID = OT2001.DivisionID AND T90.OrderID = OT2001.SOrderID'			
		END
	
		Set @Sfrom = @Sfrom + ' 
			LEFT JOIN OT1002 OT1002C ON OT2001.DivisionID = OT1002C.DivisionID AND OT2001.Ana03ID = OT1002C.AnaID AND OT1002C.AnaTypeID = ''S03'''			
	END					

	If PATINDEX('%OT2001.Ana04ID AS SAna04ID%',@strColumns) <> 0
	BEGIN
		IF PATINDEX('%LEFT JOIN OT2001 WITH (NOLOCK) ON T90.DivisionID = OT2001.DivisionID AND T90.OrderID = OT2001.SOrderID%',@Sfrom) = 0
		BEGIN
			Set @Sfrom = @Sfrom + ' 
			LEFT JOIN OT2001 WITH (NOLOCK) ON T90.DivisionID = OT2001.DivisionID AND T90.OrderID = OT2001.SOrderID'			
		END
	END
		
	If PATINDEX('%OT1002D.AnaName AS SAna04Name%',@strColumns) <> 0
	BEGIN
		IF PATINDEX('%LEFT JOIN OT2001 WITH (NOLOCK) ON T90.DivisionID = OT2001.DivisionID AND T90.OrderID = OT2001.SOrderID%',@Sfrom) = 0
		BEGIN
			Set @Sfrom = @Sfrom + ' 
			LEFT JOIN OT2001 WITH (NOLOCK) ON T90.DivisionID = OT2001.DivisionID AND T90.OrderID = OT2001.SOrderID'			
		END
	
		Set @Sfrom = @Sfrom + ' 
			LEFT JOIN OT1002 OT1002D ON OT2001.DivisionID = OT1002D.DivisionID AND OT2001.Ana04ID = OT1002D.AnaID AND OT1002D.AnaTypeID = ''S04'''			
	END	

	If PATINDEX('%OT2001.Ana05ID AS SAna05ID%',@strColumns) <> 0
	BEGIN
		IF PATINDEX('%LEFT JOIN OT2001 WITH (NOLOCK) ON T90.DivisionID = OT2001.DivisionID AND T90.OrderID = OT2001.SOrderID%',@Sfrom) = 0
		BEGIN
			Set @Sfrom = @Sfrom + ' 
			LEFT JOIN OT2001 WITH (NOLOCK) ON T90.DivisionID = OT2001.DivisionID AND T90.OrderID = OT2001.SOrderID'			
		END
	END
		
	If PATINDEX('%OT1002E.AnaName AS SAna05Name%',@strColumns) <> 0
	BEGIN
		IF PATINDEX('%LEFT JOIN OT2001 WITH (NOLOCK) ON T90.DivisionID = OT2001.DivisionID AND T90.OrderID = OT2001.SOrderID%',@Sfrom) = 0
		BEGIN
			Set @Sfrom = @Sfrom + ' 
			LEFT JOIN OT2001 WITH (NOLOCK) ON T90.DivisionID = OT2001.DivisionID AND T90.OrderID = OT2001.SOrderID'			
		END
	
		Set @Sfrom = @Sfrom + ' 
			LEFT JOIN OT1002 OT1002E ON OT2001.DivisionID = OT1002E.DivisionID AND OT2001.Ana05ID = OT1002E.AnaID AND OT1002E.AnaTypeID = ''S05'''			
	END	
END
------------------------Tao cau sql tra ra view---------------
SET @strColumns = REPLACE(@strColumns,'T1202.ObjectName','CASE WHEN ISNULL(T1202.IsUpdateName,0) = 1 THEN ISNULL(T90.VATObjectName,T1202.ObjectName) ELSE T1202.ObjectName END ObjectName')
SET @strColumns = REPLACE(@strColumns,'T2007.InventoryID','T90.InventoryID')
SET @strColumns = REPLACE(@strColumns,'T2007.ActualQuantity as Quantity','T90.Quantity')
SET @strColumns = REPLACE(@strColumns,'T2007.UnitPrice','T90.UnitPrice')

Set @Ssql = N'
SELECT 	T90.TransactionTypeID, T90.VoucherID, T90.BatchID, T90.TableID, T90.DivisionID, NULL As BudgetType, T2006.KindVoucherID, ' + @strColumns + '
FROM	AT9000 T90 WITH (NOLOCK) ' + @Sfrom + '
WHERE	T90.DivisionID = ''' + @DivisionID + ''' and
		T90.VoucherTypeID in (' + @strOrder + ')
		' + @Swhere
--PRINT @Ssql

-------- lay du lieu nghiep vu ngan sach, chi tieu (AT9090)
SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T90.InvoiceNo','NULL as InvoiceNo')
SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T90.Serial','NULL as Serial')
SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T90.InvoiceDate','NULL as InvoiceDate')
SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T90.CreditObjectID','NULL as CreditObjectID')
SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T1202A.ObjectName as CreditObjectName','NULL as CreditObjectName')
SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'isnull(T90.VATNo,T1202B.VATNo) as VATNo','NULL as VATNo')
SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T90.SenderReceiver','NULL as SenderReceiver')
SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T90.SRDivisionName','NULL as SRDivisionName')
SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T90.SRAddress','NULL as SRAddress')
SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T90.RefNo01','NULL as RefNo01')
SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T90.RefNo02','NULL as RefNo02')
SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T90.BDescription','NULL as BDescription')
SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T2007.InventoryID','T90.InventoryID')
SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T2007.ActualQuantity as Quantity','Quantity')
SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T2007.UnitPrice','UnitPrice')
SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T2006.WareHouseID','NULL as WarehouseID')
SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T1303.WareHouseName','NULL as WarehouseName')
SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T90.PeriodID','NULL as PeriodID')
SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T90.ProductID','NULL as ProductID')
SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T90.DueDate','NULL as DueDate')
IF @CustomerName = 57
BEGIN
	SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T90.DiscountAmount','NULL as DiscountAmount')
	SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T90.DiscountSaleAmountDetail','NULL as DiscountSaleAmountDetail')
	SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'ISNULL(AT1010.VATRate, 0)*T90.ConvertedAmount/100 AS VATConvertedAmount','NULL as VATConvertedAmount')
	SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'VATConvertedAmount','NULL as VATConvertedAmount')
	SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T1302.I04ID','NULL as I04ID')
	SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'AT1015A.AnaName AS I04Name','NULL as I04Name')
	SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T1302.I08ID','NULL as I08ID')
	SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'AT1015B.AnaName AS I08Name','NULL as I08Name')
	SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'OT2001.Ana01ID AS SAna01ID','NULL as SAna01ID')
	SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'OT1002A.AnaName AS SAna01Name','NULL as SAna01Name')
	SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'OT2001.Ana02ID AS SAna02ID','NULL as SAna02ID')
	SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'OT1002B.AnaName AS SAna02Name','NULL as SAna02Name')
	SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'OT2001.Ana03ID AS SAna03ID','NULL as SAna03ID')
	SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'OT1002C.AnaName AS SAna03Name','NULL as SAna03Name')
	SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'OT2001.Ana04ID AS SAna04ID','NULL as SAna04ID')
	SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'OT1002D.AnaName AS SAna04Name','NULL as SAna04Name')
	SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'OT2001.Ana05ID AS SAna05ID','NULL as SAna05ID')
	SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'OT1002E.AnaName AS SAna05Name','NULL as SAna05Name')
	SET @strColumns_AT9090 = REPLACE(@strColumns_AT9090,'T90.DParameter03','NULL as DParameter03')
END


If PATINDEX('%ObjectName%',@strColumns_AT9090) <> 0
	Set @Sfrom_AT9090 = @Sfrom_AT9090 + ' 
		LEFT JOIN AT1202 T1202 WITH (NOLOCK) on T1202.ObjectID = T90.ObjectID and T1202.DivisionID IN (T90.DivisionID,''@@@'') '
		
If PATINDEX('%InventoryName%',@strColumns_AT9090) <> 0
	Set @Sfrom_AT9090 = @Sfrom_AT9090 + ' 
		LEFT JOIN AT1302 T1302 WITH (NOLOCK) on T1302.DivisionID IN (T90.DivisionID,''@@@'') AND T1302.InventoryID = T90.InventoryID '

If PATINDEX('%UnitName%',@strColumns_AT9090) <> 0
	Set @Sfrom_AT9090 = @Sfrom_AT9090 + ' 
		LEFT JOIN AT1304 T1304 WITH (NOLOCK) on T1304.UnitID = T90.UnitID '
		
If PATINDEX('%EmployeeName%',@strColumns_AT9090) <> 0
	Set @Sfrom_AT9090 = @Sfrom_AT9090 + ' 
		LEFT JOIN AT1103 T1103 WITH (NOLOCK) on T1103.DivisionID IN (T90.DivisionID,''@@@'') AND T1103.EmployeeID = T90.EmployeeID '

If PATINDEX('%Ana01Name%',@strColumns_AT9090) <> 0
	Set @Sfrom_AT9090 = @Sfrom_AT9090 + ' 
		LEFT JOIN AT1011 T1011A WITH (NOLOCK) on T1011A.DivisionID in(T90.DivisionID,''@@@'') AND (T1011A.AnaID = T90.Ana01ID and
						T1011A.AnaTypeID = ''A01'')'

If PATINDEX('%Ana02Name%',@strColumns_AT9090) <> 0
	Set @Sfrom_AT9090 = @Sfrom_AT9090 + ' 
		LEFT JOIN AT1011 T1011B WITH (NOLOCK) on (T1011B.AnaID = T90.Ana02ID and T1011B.DivisionID = T90.DivisionID and
						T1011B.AnaTypeID = ''A02'')'

If PATINDEX('%Ana03Name%',@strColumns_AT9090) <> 0
	Set @Sfrom_AT9090 = @Sfrom_AT9090 + ' 
		LEFT JOIN AT1011 T1011C WITH (NOLOCK) on (T1011C.AnaID = T90.Ana03ID and T1011C.DivisionID = T90.DivisionID and
						T1011C.AnaTypeID = ''A03'')'

If PATINDEX('%Ana04Name%',@strColumns_AT9090) <> 0
	Set @Sfrom_AT9090 = @Sfrom_AT9090 + ' 
		LEFT JOIN AT1011 T1011D WITH (NOLOCK) on (T1011D.AnaID = T90.Ana04ID and T1011D.DivisionID = T90.DivisionID and
						T1011D.AnaTypeID = ''A04'')'

If PATINDEX('%Ana05Name%',@strColumns_AT9090) <> 0
	Set @Sfrom_AT9090 = @Sfrom_AT9090 + ' 
		LEFT JOIN AT1011 T1011E WITH (NOLOCK) on (T1011E.AnaID = T90.Ana05ID and T1011E.DivisionID = T90.DivisionID and
						T1011E.AnaTypeID = ''A05'')'
						
If PATINDEX('%Ana06Name%',@strColumns_AT9090) <> 0
	Set @Sfrom_AT9090 = @Sfrom_AT9090 + ' 
		LEFT JOIN AT1011 T1011F WITH (NOLOCK) on (T1011F.AnaID = T90.Ana06ID and T1011F.DivisionID = T90.DivisionID and
						T1011F.AnaTypeID = ''A06'')'						

If PATINDEX('%Ana07Name%',@strColumns_AT9090) <> 0
	Set @Sfrom_AT9090 = @Sfrom_AT9090 + ' 
		LEFT JOIN AT1011 T1011G WITH (NOLOCK) on (T1011G.AnaID = T90.Ana07ID and T1011G.DivisionID = T90.DivisionID and
						T1011G.AnaTypeID = ''A07'')'						

If PATINDEX('%Ana08Name%',@strColumns_AT9090) <> 0
	Set @Sfrom_AT9090 = @Sfrom_AT9090 + ' 
		LEFT JOIN AT1011 T1011H WITH (NOLOCK) on (T1011H.AnaID = T90.Ana08ID and T1011H.DivisionID = T90.DivisionID and
						T1011H.AnaTypeID = ''A08'')'

If PATINDEX('%Ana09Name%',@strColumns_AT9090) <> 0
	Set @Sfrom_AT9090 = @Sfrom_AT9090 + ' 
		LEFT JOIN AT1011 T1011I WITH (NOLOCK) on (T1011I.AnaID = T90.Ana09ID and T1011I.DivisionID = T90.DivisionID and
						T1011I.AnaTypeID = ''A09'')'

If PATINDEX('%Ana10Name%',@strColumns_AT9090) <> 0
	Set @Sfrom_AT9090 = @Sfrom_AT9090 + ' 
		LEFT JOIN AT1011 T1011J WITH (NOLOCK) on (T1011J.AnaID = T90.Ana10ID and T1011J.DivisionID = T90.DivisionID and
						T1011J.AnaTypeID = ''A10'')'																		
Set @Ssql_AT9090 = N'	UNION ALL
SELECT	T90.TransactionTypeID, T90.VoucherID, '''' As BatchID, '''' as TableID, T90.DivisionID, BudgetType, '''' as KindVoucherID, ' + @strColumns_AT9090 + '
FROM	AT9090 T90 WITH (NOLOCK) ' + @Sfrom_AT9090 + '
WHERE	T90.DivisionID = ''' + @DivisionID + ''' and
		T90.VoucherTypeID in (' + @strOrder + ')
' + @Swhere



-------- Lay cac phieu ben kho (AT2007)
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.InvoiceNo','NULL as InvoiceNo')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.Serial','NULL as Serial')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.InvoiceDate','NULL as InvoiceDate')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.CreditObjectID','NULL as CreditObjectID')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T1202A.ObjectName as CreditObjectName','NULL as CreditObjectName')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'isnull(T90.VATNo,T1202B.VATNo) as VATNo','NULL as VATNo')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.SenderReceiver','NULL as SenderReceiver')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.SRDivisionName','NULL as SRDivisionName')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.SRAddress','NULL as SRAddress')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.BDescription','NULL as BDescription')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.VDescription','T90.Description as VDescription')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.TDescription','T2007.NOTES as TDescription')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.CurrencyID','NULL as CurrencyID')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.ExchangeRate','NULL as ExchangeRate')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.OriginalAmount','T2007.OriginalAmount')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.ConvertedAmount','T2007.ConvertedAmount')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.DebitAccountID','T2007.DebitAccountID')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.CreditAccountID','T2007.CreditAccountID')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.Ana01ID','T2007.Ana01ID')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.Ana02ID','T2007.Ana02ID')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.Ana03ID','T2007.Ana03ID')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.Ana04ID','T2007.Ana04ID')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.Ana05ID','T2007.Ana05ID')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.Ana06ID','T2007.Ana06ID')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.Ana07ID','T2007.Ana07ID')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.Ana08ID','T2007.Ana08ID')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.Ana09ID','T2007.Ana09ID')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.Ana10ID','T2007.Ana10ID')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.PeriodID','T2007.PeriodID as PeriodID')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.ProductID','NULL as ProductID')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T2006.WarehouseID','T90.WarehouseID')
SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.DueDate','NULL as DueDate')
IF @CustomerName = 57
BEGIN
	-- Bổ sung thành tiền chiết khấu, chiết khấu doanh số, cột VAT, Cột MPT mặt hàng số 4, MPT mặt hàng số 8, các MPT đơn hàng bán (SA-PG, SUP, ASM, ADMIN, QLADMIN), ghi chú	
	SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.DiscountAmount','NULL as DiscountAmount')
	SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.DiscountSaleAmountDetail','NULL as DiscountSaleAmountDetail')
	SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'VATConvertedAmount','NULL as VATConvertedAmount')
	SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T1302.I04ID','NULL as I04ID')
	SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'AT1015A.AnaName AS I04Name','NULL as I04Name')
	SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T1302.I08ID','NULL as I08ID')
	SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'AT1015B.AnaName AS I08Name','NULL as I08Name')
	SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'OT2001.Ana01ID AS SAna01ID','NULL as SAna01ID')
	SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'OT1002A.AnaName AS SAna01Name','NULL as SAna01Name')
	SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'OT2001.Ana02ID AS SAna02ID','NULL as SAna02ID')
	SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'OT1002B.AnaName AS SAna02Name','NULL as SAna02Name')
	SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'OT2001.Ana03ID AS SAna03ID','NULL as SAna03ID')
	SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'OT1002C.AnaName AS SAna03Name','NULL as SAna03Name')
	SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'OT2001.Ana04ID AS SAna04ID','NULL as SAna04ID')
	SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'OT1002D.AnaName AS SAna04Name','NULL as SAna04Name')
	SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'OT2001.Ana05ID AS SAna05ID','NULL as SAna05ID')
	SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'OT1002E.AnaName AS SAna05Name','NULL as SAna05Name')
	SET @strColumns_AT2006 = REPLACE(@strColumns_AT2006,'T90.DParameter03','NULL as DParameter03')
END
If PATINDEX('%ObjectName%',@strColumns_AT2006) <> 0
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT1202 T1202 WITH (NOLOCK) on T1202.ObjectID = T90.ObjectID and T1202.DivisionID IN (T90.DivisionID,''@@@'') '
		
If PATINDEX('%InventoryID%',@strColumns_AT2006) <> 0
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		INNER JOIN AT2007 T2007 WITH (NOLOCK) on T2007.VoucherID = T90.VoucherID and T2007.DivisionID = T90.DivisionID '

If PATINDEX('%InventoryName%',@strColumns_AT2006) <> 0 and PATINDEX('%InventoryID%',@strColumns_AT2006) <> 0
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT1302 T1302 WITH (NOLOCK) on T1302.DivisionID IN (T2007.DivisionID,''@@@'') AND T1302.InventoryID = T2007.InventoryID '
Else If PATINDEX('%InventoryName%',@strColumns_AT2006) <> 0 and PATINDEX('%InventoryID%',@strColumns_AT2006) = 0
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT2007 T2007 WITH (NOLOCK) on T2007.VoucherID = T90.VoucherID and T2007.DivisionID = T90.DivisionID
		LEFT JOIN AT1302 T1302 WITH (NOLOCK) on T1302.DivisionID IN (T2007.DivisionID,''@@@'') AND T1302.InventoryID = T2007.InventoryID '
		
If PATINDEX('%UnitName%',@strColumns_AT2006) <> 0 and (PATINDEX('%InventoryName%',@strColumns_AT2006) <> 0 or PATINDEX('%InventoryID%',@strColumns_AT2006) <> 0) 
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT1304 T1304 WITH (NOLOCK) on T1304.UnitID = T2007.UnitID and T1304.DivisionID = T2007.DivisionID '
Else If PATINDEX('%UnitName%',@strColumns_AT2006) <> 0 and PATINDEX('%InventoryName%',@strColumns_AT2006) = 0 and PATINDEX('%InventoryID%',@strColumns_AT2006) = 0
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT2007 T2007 WITH (NOLOCK) on T2007.VoucherID = T90.VoucherID and T2007.DivisionID = T90.DivisionID
		LEFT JOIN AT1304 T1304 WITH (NOLOCK) on T1304.UnitID = T2007.UnitID and T1304.DivisionID = T2007.DivisionID '

If PATINDEX('%Quantity%',@strColumns_AT2006) <> 0 and (PATINDEX('%InventoryName%',@strColumns_AT2006) = 0 and  (PATINDEX('%InventoryID%',@strColumns_AT2006) = 0) AND PATINDEX('%UnitName%',@strColumns_AT2006) = 0)
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT2007 T2007 WITH (NOLOCK) on T2007.VoucherID = T90.VoucherID and T2007.DivisionID = T90.DivisionID '

If PATINDEX('%UnitPrice%',@strColumns_AT2006) <> 0 and (PATINDEX('%InventoryName%',@strColumns_AT2006) = 0 and PATINDEX('%UnitName%',@strColumns_AT2006) = 0 and (PATINDEX('%InventoryID%',@strColumns_AT2006) = 0) 
			and PATINDEX('%Quantity%',@strColumns_AT2006) = 0)
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT2007 T2007 WITH (NOLOCK) on T2007.VoucherID = T90.VoucherID and T2007.DivisionID = T90.DivisionID '

If PATINDEX('%OriginalAmount%',@strColumns_AT2006) <> 0 and (PATINDEX('%InventoryName%',@strColumns_AT2006) = 0 and PATINDEX('%UnitName%',@strColumns_AT2006) = 0 and PATINDEX('%InventoryID%',@strColumns_AT2006) = 0
			and PATINDEX('%Quantity%',@strColumns_AT2006) = 0 and PATINDEX('%UnitPrice%',@strColumns_AT2006) = 0)
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT2007 T2007 WITH (NOLOCK) on T2007.VoucherID = T90.VoucherID and T2007.DivisionID = T90.DivisionID '
If PATINDEX('%ConvertedAmount%',@strColumns_AT2006) <> 0 and (PATINDEX('%InventoryName%',@strColumns_AT2006) = 0 and PATINDEX('%UnitName%',@strColumns_AT2006) = 0 and PATINDEX('%InventoryID%',@strColumns_AT2006) = 0
			and PATINDEX('%Quantity%',@strColumns_AT2006) = 0 and PATINDEX('%UnitPrice%',@strColumns_AT2006) = 0 and PATINDEX('%OriginalAmount%',@strColumns_AT2006) = 0)
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT2007 T2007 WITH (NOLOCK) on T2007.VoucherID = T90.VoucherID and T2007.DivisionID = T90.DivisionID '
		
If PATINDEX('%EmployeeName%',@strColumns_AT2006) <> 0
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT1103 T1103 WITH (NOLOCK) on T1103.DivisionID IN (T90.DivisionID,''@@@'') AND T1103.EmployeeID = T90.EmployeeID '

If PATINDEX('%WareHouseName%',@strColumns) <> 0
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT1303 T1303 WITH (NOLOCK) on T1303.DivisionID IN (T90.DivisionID,''@@@'') AND T1303.WareHouseID = T90.WareHouseID '
		
If PATINDEX('%Ana01Name%',@strColumns_AT2006) <> 0
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT1011 T1011A WITH (NOLOCK) on (T1011A.AnaID = T2007.Ana01ID and T1011A.DivisionID = T2007.DivisionID and
						T1011A.AnaTypeID = ''A01'')'
		
If PATINDEX('%Ana02Name%',@strColumns_AT2006) <> 0
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT1011 T1011B WITH (NOLOCK) on (T1011B.AnaID = T2007.Ana02ID and T1011B.DivisionID = T2007.DivisionID and
						T1011B.AnaTypeID = ''A02'')'
		
If PATINDEX('%Ana03Name%',@strColumns_AT2006) <> 0
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT1011 T1011C WITH (NOLOCK) on (T1011C.AnaID = T2007.Ana03ID and T1011C.DivisionID = T2007.DivisionID and
						T1011C.AnaTypeID = ''A03'')'
		
If PATINDEX('%Ana04Name%',@strColumns_AT2006) <> 0
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT1011 T1011D WITH (NOLOCK) on (T1011D.AnaID = T2007.Ana04ID and T1011D.DivisionID = T2007.DivisionID and
						T1011D.AnaTypeID = ''A04'')'

If PATINDEX('%Ana05Name%',@strColumns_AT2006) <> 0
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT1011 T1011E WITH (NOLOCK) on (T1011E.AnaID = T2007.Ana05ID and T1011E.DivisionID = T2007.DivisionID and
						T1011E.AnaTypeID = ''A05'')'

If PATINDEX('%Ana06Name%',@strColumns_AT2006) <> 0
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT1011 T1011F WITH (NOLOCK) on (T1011F.AnaID = T2007.Ana06ID and T1011F.DivisionID = T2007.DivisionID and
						T1011F.AnaTypeID = ''A06'')'

If PATINDEX('%Ana07Name%',@strColumns_AT2006) <> 0
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT1011 T1011G WITH (NOLOCK) on (T1011G.AnaID = T2007.Ana07ID and T1011G.DivisionID = T2007.DivisionID and
						T1011G.AnaTypeID = ''A07'')'

If PATINDEX('%Ana08Name%',@strColumns_AT2006) <> 0
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT1011 T1011H WITH (NOLOCK) on (T1011H.AnaID = T2007.Ana08ID and T1011H.DivisionID = T2007.DivisionID and
						T1011H.AnaTypeID = ''A08'')'

If PATINDEX('%Ana09Name%',@strColumns_AT2006) <> 0
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT1011 T1011I WITH (NOLOCK) on (T1011I.AnaID = T2007.Ana09ID and T1011I.DivisionID = T2007.DivisionID and
						T1011I.AnaTypeID = ''A09'')'

If PATINDEX('%Ana10Name%',@strColumns_AT2006) <> 0
	Set @Sfrom_AT2006 = @Sfrom_AT2006 + ' 
		LEFT JOIN AT1011 T1011J WITH (NOLOCK) on (T1011J.AnaID = T2007.Ana10ID and T1011J.DivisionID = T2007.DivisionID and
						T1011J.AnaTypeID = ''A10'')'

--- Phieu VCNB
Set @Ssql_AT2006_W03 = N'	UNION ALL
SELECT	''W03'' as TransactionTypeID, T90.VoucherID, '''' As BatchID, ''AT2006'' as TableID, T90.DivisionID, NULL as BudgetType, T90.KindVoucherID, ' + @strColumns_AT2006 + '
FROM	AT2006 T90 WITH (NOLOCK) ' + @Sfrom_AT2006 + '
WHERE	T90.DivisionID = ''' + @DivisionID + ''' and
		T90.VoucherTypeID in (' + @strOrder + ') and T90.KindVoucherID = 3 And T2007.DebitAccountID = T2007.CreditAccountID
'
--- Phieu nhap kho mua hang
Set @Ssql_AT2006_W05 = N' UNION ALL
SELECT	''W05'' as TransactionTypeID, T90.VoucherID, '''' As BatchID, ''AT9000'' as TableID, T90.DivisionID, NULL as BudgetType, T90.KindVoucherID, ' + @strColumns_AT2006 + '
FROM	AT2006 T90 WITH (NOLOCK) ' + @Sfrom_AT2006 + '
WHERE	T90.DivisionID = ''' + @DivisionID + ''' and
		T90.VoucherTypeID in (' + @strOrder + ') and T90.KindVoucherID = 5
'
		
If @IsDate = 0		--theo ky
	Begin
		Set @Ssql_AT2006_W03 = @Ssql_AT2006_W03 + ' and T90.TranMonth + T90.TranYear*100 between ' + ltrim(str(@FromMonth + @FromYear*100)) + ' and ' + ltrim(str(@ToMonth + @ToYear*100)) 
		Set @Ssql_AT2006_W05 = @Ssql_AT2006_W05 + ' and T90.TranMonth + T90.TranYear*100 between ' + ltrim(str(@FromMonth + @FromYear*100)) + ' and ' + ltrim(str(@ToMonth + @ToYear*100)) 
	End
Else			--theo ngay
	Begin
		Set @Ssql_AT2006_W03 = @Ssql_AT2006_W03 + ' and CONVERT(DATETIME,CONVERT(VARCHAR(10),T90.VoucherDate,101),101) between ''' + convert(nvarchar(20),@FromDate,101) + ''' and ''' + convert(nvarchar(20),@ToDate,101) + ''''
		Set @Ssql_AT2006_W05 = @Ssql_AT2006_W05 + ' and CONVERT(DATETIME,CONVERT(VARCHAR(10),T90.VoucherDate,101),101) between ''' + convert(nvarchar(20),@FromDate,101) + ''' and ''' + convert(nvarchar(20),@ToDate,101) + ''''
	End

print @Ssql
print @Ssql_AT9090
print @Ssql_AT2006_W03
PRINT @Ssql_AT2006_W05
--PRINT @strColumns_AT9090
--PRINT @strColumns_AT2006

IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE SYSOBJECTS.NAME = 'AV9011' AND SYSOBJECTS.XTYPE = 'V')
	EXEC ('CREATE VIEW AV9011 	--created by AP9001
		 AS ' + @Ssql + @Ssql_AT9090 + @Ssql_AT2006_W03 + @Ssql_AT2006_W05)
ELSE
	EXEC ('ALTER VIEW AV9011  	--created by AP9001

		AS ' + @Ssql + @Ssql_AT9090 + @Ssql_AT2006_W03 + @Ssql_AT2006_W05)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

