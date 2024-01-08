IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP2041]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP2041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Purpose: Kiem ke mat hang theo kho
---- Created by Nguyen Quoc Huy, Date 05/01/2007
---- Edit by Mai Duyen, Date 01/10/2014: Bo sung truong hop kiem ke kho theo ngay
---- Modified by Tieu Mai on 10/11/2015: Bổ sung trường hợp có thiết lập quản lý hàng theo quy cách.
---- Modified by Bảo Thy on 27/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Bảo Anh on 18/05/2017: Sửa danh mục dùng chung
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Thanh Lượng on 22/02/2023: [2023/02/TA/0106] - Bổ sung Customize index hiển thị SourceNo(số lô)(KH EXD và INT).
---- Modified by Thanh Lượng on 22/02/2023: [2023/02/TA/0106] - Thay đổi Customize index hiển thị SourceNo đưa vào bản chuẩn.

CREATE PROCEDURE 	[dbo].[AP2041] @DivisionID as nvarchar(50),
				@WareHouseID as nvarchar(50),
				@FromInventoryID as nvarchar(50),
				@ToInventoryID as nvarchar(50),
				@Month as int,
				@Year as int,
				@Date as Datetime,
				@IsDate  as tinyint 

				

AS
Declare @sSQL as nvarchar(4000),
	@KindVoucherListIm  as nvarchar(4000),
	@KindVoucherListEx  as nvarchar(4000),
	@WareHouseID1 as nvarchar(4000),
	@CustomerName INT

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

Set @KindVoucherListIm ='(1,3,5,7,9) '
Set @KindVoucherListEx ='(2,3,4,6,8,10) '
Set  @WareHouseID1 = ' Case When KindVoucherID = 3 then AT2006.WareHouseID2 else AT2006.WareHouseID end '

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	EXEC AP2041_QC @DivisionID, @WareHouseID, @FromInventoryID, @ToInventoryID, @Month, @Year, @Date, @IsDate
ELSE
BEGIN

--Step01: Xac dinh so du ton dau AT2017
Set @sSQL ='SELECT    AT2017.VoucherID as ReVoucherID, AT2017.TransactionID as ReTransactionID, AT2017.VoucherID, AT2017.TransactionID, AT2016.WareHouseID,
			AT2016.VoucherNo, AT2017.InventoryID,  AT2017.DebitAccountID,
			--AT2017.SourceNo, 
			AT2017.SourceNo AS SourceNo, 
			ISNULL(AT2017.UnitID, AT2017.ConvertedUnitID) AS UnitID, AT2017.ActualQuantity, AT2017.UnitPrice,
			ISNULL(AT2017.OriginalAmount, 0) AS OriginalAmount, ISNULL(AT2017.ConvertedAmount, 0) AS ConvertedAmount, AT2017.DivisionID
				FROM AT2017 WITH (NOLOCK) INNER JOIN AT2016 WITH (NOLOCK) ON AT2016.VoucherID = AT2017.VoucherID AND AT2016.DivisionID = AT2017.DivisionID
				WHERE AT2016.DivisionID =''' + @DivisionID + ''' and 
			(AT2017.InventoryID like N'''+@FromInventoryID+''' or 
				AT2017.InventoryID between N'''+@FromInventoryID+''' and N'''+@ToInventoryID+''') and
			(AT2016.WareHouseID = N'''+@WareHouseID+''' )
'
If not Exists (Select 1 From SysObjects WITH (NOLOCK) Where Xtype='V' and Name ='AV2141')
	Exec('Create view AV2141  -----tao boi AP2041
		as '+@sSQL) 
Else
	Exec('Alter view AV2141  -----tao boi AP2041
		as '+@sSQL)


--Step02: Xac dinh so du tu thoi diem nay tro ve truoc AT2007
-- Step 021: Xac dinh cac phieu nhap
		If @IsDate = 1 -- theo ky 
			Set @sSQL =' SELECT AT2007.VoucherID as ReVoucherID, AT2007.TransactionID as ReTransactionID, AT2007.VoucherID, AT2007.TransactionID, AT2006.WareHouseID,
			AT2006.VoucherNo, AT2007.InventoryID, AT2007.DebitAccountID ,
			 --AT2007.SourceNo, 
			AT2007.SourceNo AS SourceNo, 
			 ISNULL(AT2007.UnitID, AT2007.ConvertedUnitID) AS UnitID, AT2007.ActualQuantity, AT2007.UnitPrice,
			ISNULL(AT2007.OriginalAmount, 0) AS OriginalAmount, ISNULL(AT2007.ConvertedAmount, 0) AS ConvertedAmount, AT2007.DivisionID
				 FROM AT2007 WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.VoucherID = AT2007.VoucherID
				 WHERE AT2006.DivisionID =''' + @DivisionID + ''' and 
				(AT2007.InventoryID like N'''+@FromInventoryID+''' or 
				 AT2007.InventoryID between N'''+@FromInventoryID+''' and N'''+@ToInventoryID+''') and
				(AT2006.WareHouseID = N'''+@WareHouseID+''' ) and
				(AT2006.TranMonth + AT2006.TranYear*100 <= '+str(@Month)+' + 100*'+str(@Year)+ ')  and
				KindVoucherID in '+ @KindVoucherListIm+'

	'
		Else --theo ngay
			Set @sSQL =' SELECT AT2007.VoucherID as ReVoucherID, AT2007.TransactionID as ReTransactionID, AT2007.VoucherID, AT2007.TransactionID, AT2006.WareHouseID,
			AT2006.VoucherNo, AT2007.InventoryID, AT2007.DebitAccountID ,
			 --AT2007.SourceNo, 
			AT2007.SourceNo AS SourceNo, 
			 ISNULL(AT2007.UnitID, AT2007.ConvertedUnitID) AS UnitID, AT2007.ActualQuantity, AT2007.UnitPrice,
			ISNULL(AT2007.OriginalAmount, 0) AS OriginalAmount, ISNULL(AT2007.ConvertedAmount, 0) AS ConvertedAmount, AT2007.DivisionID
				 FROM AT2007 WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.VoucherID = AT2007.VoucherID
				 WHERE AT2006.DivisionID =''' + @DivisionID + ''' and 
				(AT2007.InventoryID like N'''+@FromInventoryID+''' or 
				 AT2007.InventoryID between N'''+@FromInventoryID+''' and N'''+@ToInventoryID+''') and
				(AT2006.WareHouseID = N'''+@WareHouseID+''' ) and
				(AT2006.VoucherDate  <= '''+Convert(Varchar(10),@Date,101)+''' )  and
				KindVoucherID in '+ @KindVoucherListIm+'
	'

If not Exists (Select 1 From SysObjects WITH (NOLOCK) Where Xtype='V' and Name ='AV2241')
	Exec('Create view AV2241  -----tao boi AP2041
		as '+@sSQL)
Else
	Exec('Alter view AV2241  -----tao boi AP2041
		as '+@sSQL)


-- Step 022: Xac dinh cac phieu xuat
		If @IsDate = 1 -- theo ky 
			Set @sSQL =' SELECT AT2007.ReVoucherID, AT2007.ReTransactionID, AT2007.VoucherID, AT2007.TransactionID, '+ @WareHouseID1 +' as WareHouseID,
			AT2006.VoucherNo, AT2007.InventoryID, AT2007.CreditAccountID as  DebitAccountID,
			---- AT2007.SourceNo, 
			AT2007.SourceNo AS SourceNo, 
			ISNULL(AT2007.UnitID, AT2007.ConvertedUnitID) AS UnitID, -AT2007.ActualQuantity as ActualQuantity, AT2007.UnitPrice,
			 -ISNULL(AT2007.OriginalAmount, 0) as OriginalAmount,  -ISNULL(AT2007.ConvertedAmount, 0) as ConvertedAmount, AT2007.DivisionID
				 FROM AT2007 WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
				 WHERE AT2006.DivisionID =''' + @DivisionID + ''' and 
				(AT2007.InventoryID like N'''+@FromInventoryID+''' or 
				 AT2007.InventoryID between N'''+@FromInventoryID+''' and N'''+@ToInventoryID+''') and
				('+ @WareHouseID1 +' = N'''+@WareHouseID+''' ) and
				(AT2006.TranMonth + AT2006.TranYear*100 <= '+str(@Month)+' + 100*'+str(@Year)+ '  )  and
				KindVoucherID  in '+ @KindVoucherListEx+'

	'
		Else
			Set @sSQL =' SELECT AT2007.ReVoucherID, AT2007.ReTransactionID, AT2007.VoucherID, AT2007.TransactionID, '+ @WareHouseID1 +' as WareHouseID,
			AT2006.VoucherNo, AT2007.InventoryID, AT2007.CreditAccountID as  DebitAccountID,
			---- AT2007.SourceNo, 
			AT2007.SourceNo AS SourceNo, 
			ISNULL(AT2007.UnitID, AT2007.ConvertedUnitID) AS UnitID, -AT2007.ActualQuantity as ActualQuantity, AT2007.UnitPrice,
			 -ISNULL(AT2007.OriginalAmount, 0) as OriginalAmount,  -ISNULL(AT2007.ConvertedAmount, 0) as ConvertedAmount, AT2007.DivisionID
				 FROM AT2007 WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
				 WHERE AT2006.DivisionID =''' + @DivisionID + ''' and 
				(AT2007.InventoryID like N'''+@FromInventoryID+''' or 
				 AT2007.InventoryID between N'''+@FromInventoryID+''' and N'''+@ToInventoryID+''') and
				('+ @WareHouseID1 +' = N'''+@WareHouseID+''' ) and
				(AT2006.VoucherDate  <= '''+Convert(Varchar(10),@Date,101)+''' )  and
				KindVoucherID  in '+ @KindVoucherListEx+'

	'

If not Exists (Select 1 From SysObjects WITH (NOLOCK) Where Xtype='V' and Name ='AV2341')
	Exec('Create view AV2341  -----tao boi AP2041
		as '+@sSQL)
Else
	Exec('Alter view AV2341  -----tao boi AP2041
		as '+@sSQL)



-- Step 023: Xac dinh so du thuc te
	Set @sSQL ='Select ReVoucherID, ReTransactionID, VoucherID, TransactionID, WareHouseID, 
		VoucherNo, InventoryID, DebitAccountID,
		LTrim(RTrim(SourceNo)) AS SourceNo, UnitID, 
		ActualQuantity, UnitPrice, OriginalAmount, ConvertedAmount , DivisionID
	From 	AV2141

Union All

	        Select ReVoucherID, ReTransactionID, VoucherID, TransactionID, WareHouseID, 
		VoucherNo, InventoryID, DebitAccountID,
		LTrim(RTrim(SourceNo)) AS SourceNo, UnitID, 
		ActualQuantity, UnitPrice, OriginalAmount, ConvertedAmount , DivisionID
	From AV2241 
Union All

	        Select ReVoucherID, ReTransactionID, VoucherID, TransactionID,WareHouseID, 
		VoucherNo, InventoryID, DebitAccountID,
		LTrim(RTrim(SourceNo)) AS SourceNo, UnitID, 
		ActualQuantity, UnitPrice, OriginalAmount, ConvertedAmount , DivisionID
	From AV2341

'

If not Exists (Select 1 From SysObjects WITH (NOLOCK) Where Xtype='V' and Name ='AV2441')
	Exec('Create view AV2441  -----tao boi AP2041
		as '+@sSQL)
Else
	Exec('Alter view AV2441  -----tao boi AP2041
		as '+@sSQL)


--PRINT @sSQL
	Set @sSQL ='Select AV2441.InventoryID, AT1302.InventoryName, AV2441.WareHouseID, AT1303.WareHouseName, AV2441.SourceNo, AV2441.UnitID, AV2441.DebitAccountID,
		Sum(AV2441.ActualQuantity) as ActualQuantity , 
		Sum(AV2441.OriginalAmount) as OriginalAmount, 
		Sum(AV2441.ConvertedAmount) as ConvertedAmount ,
		Case when Sum(AV2441.ActualQuantity) <> 0 then
			ABS(Sum(AV2441.ConvertedAmount) / Sum(AV2441.ActualQuantity))
		else
			0 end as UnitPrice ,
		AV2441.DivisionID

	From 	AV2441  Inner join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (AV2441.DivisionID,''@@@'') AND AT1302.InventoryID = AV2441.InventoryID
		 	Inner join AT1303 WITH (NOLOCK) on AT1303.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND AT1303.WareHouseID = AV2441.WareHouseID
	Group by AV2441.InventoryID, AT1302.InventoryName,AV2441.WareHouseID,  AT1303.WareHouseName, AV2441.SourceNo, AV2441.UnitID, AV2441.DebitAccountID, AV2441.DivisionID
	
'

If not Exists (Select 1 From SysObjects WITH (NOLOCK) Where Xtype='V' and Name ='AV2041')
	Exec('Create view AV2041  -----tao boi AP2041
		as '+@sSQL)
Else
	Exec('Alter view AV2041  -----tao boi AP2041
		as '+@sSQL)
	
END	
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

