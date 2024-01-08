IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0302]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0302]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- In bao cao Tong hop tinh hinh nhan hang
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 15/03/2006 by Vo Thanh Huong
---- 
---ThuyTuyen 5/12/2006 ,Them bao cao doi chieu tinh hinh nhan hang
---Last Edit : Thuy tuyen 12/04/2007,18/06/2009 --  29/10/2009, 09/09/2009,9/11/2009
---- Modified on 31/01/2012 by Le Thi Thu Hien : Sua dieu kien CONVERT theo ngay
---- Modified on 03/05/2013 by Le Thi Thu Hien : Bo sung Khoan muc (Mantis 0020558 )
---- Modified on 26/01/2015 by Le Thi My Tuyen : Bo sung tinh trang hoan tat (OV2400.Finish) cua tung dong mat hang
---- Modified on 15/10/2015 by Tiểu Mai: bổ sung 10 tham số, MPT, ngày nhận hàng dự kiến đầu tiên, cuối cùng, ngày nhận hàng thực tế đầu tiên.
---- Modified on 31/05/2016 by Bảo Thy: Bổ sung WITH (NOLOCK)
---- Modified on 16/05/2017 by Hải Long: Chỉnh sửa danh mục dùng chung
---- Modified on 18/08/2020 by Đức Thông: Bổ sung số hợp đồng, diễn giải mặt hàng, nguồn gốc mặt hàng của đơn hàng mua
---- Modified on 26/08/2020 by Đức Thông: Bổ sung số hợp đồng, diễn giải mặt hàng, nguồn gốc mặt hàng của đơn hàng mua (bổ sung những phiếu chưa giao hết)
---- Modified on 28/08/2020 by Huỳnh Thử: Bổ sung cột Hàng khuyến mãi (IsProInventoryID)
---- Modified on 18/11/2020 by Đức Thông: Chỉnh sửa điều kiện kết đơn hàng mua với phiếu nhập kho là OTransactionID (AT2007) và TransactionID (OT3002) để lấy đúng số lượng đã nhận
---- Modified on 10/12/2020 by Đức Thông: Thêm group by theo số thứ tự mặt hàng trong đơn hàng mua tránh bị mất dòng khi mặt hàng trùng số lượng (Fix bug DREAMFLY)
---- Modified on 02/02/2021 by Kiều Nga : Chuyển đk lọc từ kỳ, đến kỳ sang chọn kỳ
---- Modified on 11/11/2022 by Anh Đô: Fix lỗi không nhận điều kiện lọc Mặt hàng và Nhà cung cấp
---- Modified on 13/02/2023 by Anh Đô: Tách @ListInventoryID ra khỏi biến @sSQL1 để tránh lỗi tràn chuỗi; Fix lỗi khi in với @IsCheck = 1
-- <Example>
---- exec OP0302 @Divisionid=N'PMT',@Isdate=0,@Frommonth=7,@Tomonth=7,@Fromyear=2012,@Toyear=2012,@Fromdate='2013-05-03 00:00:00',@Todate='2013-05-03 00:00:00',@Frominventoryid=N'%',@Toinventoryid=N'%',@Isgroup=1,@Groupid=N'A07',@Ischeck=0,@Fromobjectid=N'%',@Toobjectid=N'%'
---

CREATE PROCEDURE [dbo].[OP0302]  
				@DivisionID nvarchar(50),
				@DivisionIDList	NVARCHAR(MAX),
				@IsDate INT, ---- 1: là ngày, 0: là kỳ
				@FromDate DATETIME,
				@ToDate DATETIME,
				@PeriodList NVARCHAR(MAX)='',
				@FromInventoryID nvarchar(50),
				@ToInventoryID nvarchar(50),
				@IsGroup as tinyint,
				@GroupID nvarchar(50), -- GroupID: OB, CI1, CI2, CI3, I01, I02, I03, I04, I05	
				@IsCheck int,---- 0: co len du lieu cu athang truoc chua nhan,1: khong len du lieu cua thang truoc
				@FromObjectID nvarchar(50),
				@ToObjectID nvarchar(50),
				@ListInventoryID nvarchar(max) = '',
				@ListObjectID nvarchar(max) = ''
AS
DECLARE @sSQL nvarchar(4000),
		@sSQL1 nvarchar(4000),
		@sSQL11 nvarchar(4000),
		@GroupField nvarchar(20),
		@sFROM nvarchar(500),
		@sSELECT nvarchar(500),
		@sWHERE nvarchar(500),
		@Groupby nvarchar(4000), 
		@FromMonthYearText NVARCHAR(20), 
		@ToMonthYearText NVARCHAR(20), 
		@FromDateText NVARCHAR(20), 
		@ToDateText NVARCHAR(20),
		@sWhereDivision NVARCHAR(max),
		@sWhereListInventoryID NVARCHAR(MAX)

Set @sWhereDivision = ''
SET @sWhereListInventoryID = N''
    
--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
IF Isnull(@DivisionIDList, '') != ''
	SET @sWhereDivision = ' IN ('''+@DivisionIDList+''')'
ELSE 
	SET @sWhereDivision = ' = N'''+@DivisionID+''''	
    
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'


Select @sFROM = '',  @sSELECT = '', @Groupby=''

-- Convert ListObjectID/ListInventoryID từ dạng XML chuỗi các mã phân cách bởi dấu phẩy
IF @ListInventoryID != ''
BEGIN 
	DECLARE @InventoryIDTmpTable TABLE (InventoryID NVARCHAR(50))
	DECLARE @ListInventoryIDXML XML = @ListInventoryID
	INSERT INTO @InventoryIDTmpTable
	SELECT REPLACE(REPLACE(CONVERT(NVARCHAR(50), x.items.query('.')), '<D>', ''), '</D>', '') FROM @ListInventoryIDXML.nodes('/Data/*') AS x(items)
END

IF @ListObjectID != ''
BEGIN
	DECLARE @ObjectIDTmpTable TABLE (ObjectID NVARCHAR(50))
	DECLARE @ListObjectIDXML XML = @ListObjectID
	INSERT INTO @ObjectIDTmpTable
	SELECT REPLACE(REPLACE(CONVERT(NVARCHAR(50), x.items.query('.')), '<D>', ''), '</D>', '') FROM @ListObjectIDXML.nodes('/Data/*') AS x(items)
END

SELECT @ListObjectID = STUFF((SELECT ',' + o.ObjectID FROM @ObjectIDTmpTable o FOR XML PATH('')), 1, 1, '')
SELECT @ListInventoryID = STUFF((SELECT ',' + o.InventoryID FROM @InventoryIDTmpTable o FOR XML PATH('')), 1, 1, '')

IF @ListObjectID = '%'
	SET @ListObjectID = ''

IF @ListInventoryID = '%'
	SET @ListInventoryID = ''

---Step 1: Lay  so luong  giao thu te 
	--------Step 1.1: Lay  Tong so luong   giao thuc te.(OR0302)

Set @sSQL = N'
SELECT	A00.DivisionID,
		T01.POrderID as OrderID  , 
		A00.InventoryID,  
		A00.OTransactionID,
		sum(ActualQuantity) as ActualQuantity, 
		Max(A01.VoucherDate) as ActualDate,
		MIN(A01.VoucherDate) AS ActualDateBegin, 
		SUM(' + CASE WHEN @IsDate = 1 then  ' CASE WHEN CONVERT(DATETIME,CONVERT(VARCHAR(10),T01.OrderDate,101),101)  < ''' + @FromDateText  + ''' THEN  ActualQuantity ELSE 0 END ' 
		ELSE '  CASE WHEN (CASE WHEN A00.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(A00.TranMonth)))+''/''+ltrim(Rtrim(str(A00.TranYear))) in ('''+@PeriodList +''')  THEN ActualQuantity ELSE 0 END'   END + ')
		AS ActualQuantity0
FROM	AT2007 A00 WITH (NOLOCK) 
INNER JOIN AT2006 A01 WITH (NOLOCK) on A00.VoucherID = A01.VoucherID and A00.DivisionID = A01.DivisionID  and A01.KindVoucherID  in(1, 5, 7)
---INNER JOIN OT3002  T01 on T01.TransactionID  = A00.OTransactionID  ---and T01.OrderStatus not in ( 9) 
INNER JOIN OT3001 T01 WITH (NOLOCK) on T01.POrderID  = A00.OrderID  and T01.DivisionID = A00.DivisionID
Where  A01.DivisionID '+@sWhereDivision+'       /* AND    ' +
	CASE WHEN @IsDate = 1 then  ' CONVERT(DATETIME,CONVERT(VARCHAR(10),T01.OrderDate,101),101)  <= ''' + @ToDateText  + '''' 
	ELSE  '   (CASE WHEN T01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T01.TranMonth)))+''/''+ltrim(Rtrim(str(T01.TranYear))) in ('''+@PeriodList +''')'    end  + ' AND ' + 
	CASE WHEN @IsDate = 1 then  ' CONVERT(DATETIME,CONVERT(VARCHAR(10),A01.VoucherDate,101),101)  <= ''' + @ToDateText  + '''' 
	ELSE  '   (CASE WHEN A01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(A01.TranMonth)))+''/''+ltrim(Rtrim(str(A01.TranYear))) in ('''+@PeriodList +''')'   end  +  ' */'+
	--case when ISNULL(@ListInventoryID,'') <> '' then ' and ISNULL(A00.InventoryID,'''') IN (SELECT Value FROM [dbo].StringSplit('''+@ListInventoryID+''', '',''))' else '' end +
	case when ISNULL(@ListObjectID,'') <> '' then ' and ISNULL(A01.ObjectID,'''') IN (SELECT Value FROM [dbo].StringSplit('''+@ListObjectID+''', '',''))' else '' end

IF ISNULL(@ListInventoryID, '') != ''
	SET @sWhereListInventoryID = ' AND ISNULL(A00.InventoryID,'''') IN (SELECT Value FROM [dbo].StringSplit('''+@ListInventoryID+''', '','')) '

--print @sSQL;
If exists(Select Top 1 1 From sysObjects WITH (NOLOCK) Where XType = 'V' and Name = 'OV0308')
	Drop view OV0308
EXEC('Create view OV0308 ---tao boi OP0302
		as ' + @sSQL
			 + @sWhereListInventoryID
			 + 'Group by A00.DivisionID, T01.POrderID, A00.InventoryID, A00.OTransactionID')

 --------Step 1.2: Lay so luong   giao thuc te chi ti?t  theo tung chung tu.(OR0321)

Set @sSQL = N'
SELECT	A00.DivisionID , 
		A00.OrderID ,
		A01.VoucherNo,
		A00.InventoryID,  
		0 as UnitPrice,
		A00.Ana01ID, A00.Ana02ID, A00.Ana03ID, A00.Ana04ID, A00.Ana05ID,
		A00.Ana06ID, A00.Ana07ID, A00.Ana08ID, A00.Ana09ID, A00.Ana10ID,
		A00.OTransactionID,
	ActualQuantity =  Isnull ((select  sum (isnull(ActualQuantity,0)) From AT2007 WITH (NOLOCK)  Where
								 AT2007.InventoryID = A00.InventoryID	and  AT2007.OrderID = A00.OrderID  and AT2007.OTransactionID = A00.OTransactionID  
								 and AT2007.DivisionID = T01.DivisionID and AT2007.VoucherID =A00.VoucherID and AT2007.DivisionID = A00.DivisionID

/*								 and '+CASE WHEN @IsDate = 1 then  ' CONVERT(DATETIME,CONVERT(VARCHAR(10),T01.OrderDate,101),101)  <= ''' + @ToDateText  + '''' 
									ELSE  '   (CASE WHEN T01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T01.TranMonth)))+''/''+ltrim(Rtrim(str(T01.TranYear))) in ('''+@PeriodList +''')'   end  + ' AND ' + 
									CASE WHEN @IsDate = 1 then  ' CONVERT(DATETIME,CONVERT(VARCHAR(10),A01.VoucherDate,101),101)  <= ''' + @ToDateText  + '''' 
									ELSE  '   (CASE WHEN A01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(A01.TranMonth)))+''/''+ltrim(Rtrim(str(A01.TranYear))) in ('''+@PeriodList +''')'   end  +  ' */),0) ,


	OriginalAmount =  Isnull ((select  sum (isnull(OriginalAmount,0)) from AT9000 WITH (NOLOCK) Where
								 AT9000.InventoryID = A00.InventoryID	and  AT9000.OrderID = A00.OrderID   and AT9000.OTransactionID = A00.OTransactionID and AT9000.DivisionID = T01.DivisionID 
									and AT9000.VoucherID =A00.VoucherID and TransactionTypeID <> ''T13'' and AT9000.DivisionID = A00.DivisionID 

								 /* and '+CASE WHEN @IsDate = 1 then  ' CONVERT(DATETIME,CONVERT(VARCHAR(10),T01.OrderDate,101),101)  <= ''' + @ToDateText  + '''' 
									ELSE  '   (CASE WHEN T01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T01.TranMonth)))+''/''+ltrim(Rtrim(str(T01.TranYear))) in ('''+@PeriodList +''')'   end  + ' AND ' + 
									CASE WHEN @IsDate = 1 then  ' CONVERT(DATETIME,CONVERT(VARCHAR(10),A01.VoucherDate,101),101)  <= ''' + @ToDateText  + '''' 
									ELSE  '   (CASE WHEN A01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(A01.TranMonth)))+''/''+ltrim(Rtrim(str(A01.TranYear))) in ('''+@PeriodList +''')'   end  +  '  */),0) ,

	
	
	OriginalAmountVAT =(Select  (Select isnull(Sum(OriginalAmount),0) From AT9000  WITH (NOLOCK)
					Where 	OrderID = A00.OrderID 
						And InventoryID = A00.InventoryID 
						and AT9000.OTransactionID = A00.OTransactionID
						and AT9000.VoucherID = A00.VoucherID
						and AT9000.DivisionID = T01.DivisionID and AT9000.DivisionID = A00.DivisionID '


SET @sSQL11 = N'
/*			
and  '+CASE WHEN @IsDate = 1 then  ' CONVERT(DATETIME,CONVERT(VARCHAR(10),T01.OrderDate,101),101)  <= ''' + @ToDateText  + '''' 
									ELSE  '   (CASE WHEN T01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T01.TranMonth)))+''/''+ltrim(Rtrim(str(T01.TranYear))) in ('''+@PeriodList +''')'    end  + ' AND ' + 
									CASE WHEN @IsDate = 1 then  ' CONVERT(DATETIME,CONVERT(VARCHAR(10),A01.VoucherDate,101),101) <= ''' + @ToDateText  + '''' 
									ELSE  '   (CASE WHEN A01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(A01.TranMonth)))+''/''+ltrim(Rtrim(str(A01.TranYear))) in ('''+@PeriodList +''')'    end  +  ' */
						And TransactiontypeID<>''T13'')
						*
					(Select isnull(VATRate,0) from AT1010 WITH (NOLOCK) Where VATGroupID
						In 
						(Select Top 1 VATGroupID From AT9000  WITH (NOLOCK)
							Where OrderID = A00.OrderID 
							    and AT9000.OTransactionID = A00.OTransactionID
							     and AT9000.VoucherID =A00.VoucherID 
							     and InventoryID = A00.InventoryID
							/*     and  '+CASE WHEN @IsDate = 1 then  ' CONVERT(DATETIME,CONVERT(VARCHAR(10),T01.OrderDate,101),101)T01.OrderDate  <= ''' + @ToDateText  + '''' 
								ELSE  '   (CASE WHEN T01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T01.TranMonth)))+''/''+ltrim(Rtrim(str(T01.TranYear))) in ('''+@PeriodList +''')'   end  + ' AND ' + 
								CASE WHEN @IsDate = 1 then  ' CONVERT(DATETIME,CONVERT(VARCHAR(10),A01.VoucherDate,101),101)  <= ''' + @ToDateText  + '''' 
								ELSE  '   (CASE WHEN A01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(A01.TranMonth)))+''/''+ltrim(Rtrim(str(A01.TranYear))) in ('''+@PeriodList +''')'   end  +  '  */
							     And TransactiontypeID<>''T13''))/100),

	Max(A01.VoucherDate) as ActualDate, 
	SUM(' + CASE WHEN @IsDate = 1 then  ' CASE WHEN CONVERT(DATETIME,CONVERT(VARCHAR(10),T01.OrderDate ,101),101) < ''' + @FromDateText  + ''' THEN  ActualQuantity ELSE 0 END ' 
	ELSE '  CASE WHEN (CASE WHEN T01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T01.TranMonth)))+''/''+ltrim(Rtrim(str(T01.TranYear))) in ('''+@PeriodList +''')  THEN ActualQuantity ELSE 0 END'   END + ')
	AS ActualQuantity0
From AT2007 A00 WITH (NOLOCK)
INNER JOIN AT9000 WITH (NOLOCK)  on AT9000.VoucherID = A00.VoucherID and AT9000.DivisionID = A00.DivisionID 
INNER JOIN AT2006 A01 WITH (NOLOCK) on A00.VoucherID = A01.VoucherID  and A01.DivisionID = A00.DivisionID and A01.KindVoucherID  in(1, 5, 7)
INNER JOIN OT3001 T01 WITH (NOLOCK) on T01.POrderID  = A00.OrderID  and T01.DivisionID = A00.DivisionID AND T01.OrderType = 0 and T01.OrderStatus not in ( 9)
	
Where  T01.DivisionID '+@sWhereDivision+' 
/*
AND    ' +
	CASE WHEN @IsDate = 1 then  ' CONVERT(DATETIME,CONVERT(VARCHAR(10),T01.OrderDate ,101),101)  <= ''' + @ToDateText  + '''' 
	ELSE  '   (CASE WHEN T01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T01.TranMonth)))+''/''+ltrim(Rtrim(str(T01.TranYear))) in ('''+@PeriodList +''')'   end  + ' AND ' + 
	CASE WHEN @IsDate = 1 then  ' CONVERT(DATETIME,CONVERT(VARCHAR(10),A01.VoucherDate,101),101) <= ''' + @ToDateText  + '''' 
	ELSE  '   (CASE WHEN A01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(A01.TranMonth)))+''/''+ltrim(Rtrim(str(A01.TranYear))) in ('''+@PeriodList +''')'    end  +  '
*/
GROUP BY A00.DivisionID, A00.OrderID, A00.InventoryID, A01.VoucherNo,  A00.VoucherID,
		A00.Ana01ID, A00.Ana02ID, A00.Ana03ID, A00.Ana04ID, A00.Ana05ID,
		A00.Ana06ID, A00.Ana07ID, A00.Ana08ID, A00.Ana09ID, A00.Ana10ID,
		T01.DivisionID,T01.TranMonth,T01.TranYear,
		A01.TranMonth,A01.TranYear,
		T01.OrderDate,  A01.VoucherDate, A00.OTransactionID'

--print @sSQL
--print @sSQL11

IF EXISTS(SELECT TOP 1 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE XTYPE = 'V' AND NAME = 'OV0309')
	DROP VIEW OV0309
EXEC('CREATE VIEW OV0309 ---tao boi OP0302
		AS ' + @sSQL +@sSQL11)

 	

-----Step2: Lay du lieu nhom (OR0302,OR0321)
		
IF @IsGroup  = 1  ---Co nhom
	BEGIN
	Exec OP4700  	@GroupID,	@GroupField OUTPUT
	Select @sFROM = @sFROM + ' 
			LEFT JOIN OV6666 V1 on V1.SelectionType = ''' + @GroupID + ''' and V1.DivisionID = OV2400.DivisionID and V1.SelectionID = OV2400.' + @GroupField,
		@sSELECT = @sSELECT + ', 
			V1.SelectionID as GroupID, V1.SelectionName as GroupName'
		
	END

ELSE  ---Khong  nhom
	Set @sSELECT = @sSELECT +  ', 
		'''' as GroupID, '''' as GroupName'	

IF ISNULL(@ListInventoryID, '') != ''
	SET @sWhereListInventoryID = ' AND ISNULL(OV2400.InventoryID,'''') IN (SELECT Value FROM [dbo].StringSplit('''+@ListInventoryID+''', '','')) '

------Step3: Lay du lieu in bao cao
	---------Step3.1: Tong hop (OR0302)

If @IsCheck=1 ---co chon nhung phieu chua giao het
BEGIN
Set @sSQL =  N'
SELECT  OV2400.DivisionID as DivisionID,  
		OV2400.OrderID as POrderID,
		OV2400.VoucherNo,           
		OV2400.VoucherDate as OrderDate,
		OV2400.ObjectID,
		OV2400.ObjectName,
		OV2400.OrderStatus,
		OT1101.Description as OrderStatusName,
		OV2400.InventoryID, 
		OV2400.InventoryName, 

		OV2400.UnitName,
		OV2400.Specification,
		OV2400.InventoryTypeID,
		OV2400.OrderQuantity,
		OV2400.PurchasePrice,
		isnull(OV2400.PurchasePrice, 0)* isnull(OV2400.ExchangeRate, 0) as ConvertedPrice,	
		OV2400.OriginalAmount as TOriginalAmount,
		OV2400.ConvertedAmount as TConvertedAmount,
		OV2400.ShipDate,
		OV2400.Notes, OV2400.Notes01, OV2400.Notes02,
		OV0308.ActualQuantity,
		OV0308.ActualDate,
		OV2400.Ana01ID,  OV2400.Ana02ID, 	OV2400.Ana03ID,  OV2400.Ana04ID, OV2400.Ana05ID,
		OV2400.Ana06ID,  OV2400.Ana07ID, 	OV2400.Ana08ID,  OV2400.Ana09ID, OV2400.Ana10ID,
		OV2400.AnaName01 ,OV2400.AnaName02, OV2400.AnaName03 ,OV2400.AnaName04 ,OV2400.AnaName05,
		OV2400.AnaName06 ,OV2400.AnaName07, OV2400.AnaName08 ,OV2400.AnaName09 ,OV2400.AnaName10,OV2400.Finish,

		CASE WHEN isnull(OV2400.ShipDate, '''') = '''' or isnull(OV0308.ActualDate, '''') = '''' then 0 else 
		Datediff(day, OV2400.ShipDate, OV0308.ActualDate) end as AfterDayAmount, 
		(OV2400.OrderQuantity - isnull(OV0308.ActualQuantity, 0) + isnull(OV2400.AdjustQuantity, 0)) as RemainQuantity, OV2400.DateEnd, OV2400.DateBegin, OV0308.ActualDateBegin,
		OV2400.Parameter01,OV2400.Parameter02,OV2400.Parameter03,OV2400.Parameter04,OV2400.Parameter05,
		OV2400.Parameter06,OV2400.Parameter07,OV2400.Parameter08,OV2400.Parameter09,OV2400.Parameter10,
		OV2400.ContractNo,
		OV2400.TDescription,
		OV2400.I02ID,
		OV2400.IsProInventoryID,
		OV2400.CreateUserName
' 
		
Set @sSQL1 =  @sSELECT  + N'
FROM	OV0307  OV2400 
LEFT JOIN OV0308 ON OV0308.OTransactionID = OV2400.TransactionID AND OV0308.DivisionID = OV2400.DivisionID 
LEFT JOIN OT1101 WITH (NOLOCK) on OT1101.OrderStatus = OV2400.OrderStatus and OT1101.DivisionID = OV2400.DivisionID and TypeID =  ''PO''
' + 
	@sFROM + '
WHERE  OV2400.DivisionID '+@sWhereDivision+' and ' +   
		CASE WHEN @IsDate = 1 then  ' ((OV2400.OrderStatus not in (   4, 9)   and 
		CONVERT(DATETIME,CONVERT(VARCHAR(10),OV2400.VoucherDate ,101),101) < ''' + @FromDateText  + ''' AND  
		(OV2400.OrderQuantity - isnull(OV0308.ActualQuantity0, 0) + isnull(OV2400.AdjustQuantity, 0)) > 0) or
		CONVERT(DATETIME,CONVERT(VARCHAR(10),OV2400.VoucherDate ,101),101)  BETWEEN ''' + 					
		 @FromDateText + ''' and ''' +  @ToDateText  + ''') '
		else 	' ((OV2400.OrderStatus not in ( 9, 4)   and  
		(CASE WHEN OV2400.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(OV2400.TranMonth)))+''/''+ltrim(Rtrim(str(OV2400.TranYear))) in ('''+@PeriodList +''')  AND  
		(OV2400.OrderQuantity - isnull(OV0308.ActualQuantity0, 0) + isnull(OV2400.AdjustQuantity, 0)) > 0)) ' end +  
		  ' and  OV2400.InventoryID ' + CASE WHEN @FromInventoryID = '%' then ' like ''%''' 
		else ' between N''' + @FromInventoryID + ''' and N''' + @ToInventoryID + ''''   end +
		  ' and  OV2400.ObjectID ' + CASE WHEN @FromObjectID = '%' then ' like ''%''' 
		else ' between N''' + @FromObjectID + ''' and N''' + @ToObjectID + ''''   end +
		--case when ISNULL(@ListInventoryID,'') <> '' then ' and ISNULL(OV2400.InventoryID,'''') IN (SELECT Value FROM [dbo].StringSplit('''+@ListInventoryID+''', '',''))' else '' end +
		case when ISNULL(@ListObjectID,'') <> '' then ' and ISNULL(OV2400.ObjectID,'''') IN (SELECT Value FROM [dbo].StringSplit('''+@ListObjectID+''', '',''))' else '' end

		
END
Else	--- Khong chon nhung phieu chua giao het
BEGIN
Set @sSQL =  N'
SELECT  OV2400.DivisionID as DivisionID,
		OV2400.OrderID as POrderID,  
		OV2400.VoucherNo,           
		OV2400.VoucherDate as OrderDate,
		OV2400.ObjectID,
		OV2400.ObjectName,
		OV2400.Orders,
		OV2400.OrderStatus,
		OT1101.Description as OrderStatusName,
		OV2400.InventoryID, 
		OV2400.InventoryName, 

		OV2400.UnitName,
		OV2400.Specification,
		OV2400.InventoryTypeID,
		OV2400.OrderQuantity,
		OV2400.PurchasePrice,
		isnull(OV2400.PurchasePrice, 0)* isnull(OV2400.ExchangeRate, 0) as ConvertedPrice,	
		OV2400.OriginalAmount as TOriginalAmount,

		OV2400.ConvertedAmount as TConvertedAmount,
		OV2400.ShipDate,
		OV2400.Notes, OV2400.Notes01, OV2400.Notes02,
		OV0308.ActualQuantity,
		OV0308.ActualDate,
		OV2400.Ana01ID,  OV2400.Ana02ID, 	OV2400.Ana03ID,  OV2400.Ana04ID, OV2400.Ana05ID,
		OV2400.Ana06ID,  OV2400.Ana07ID, 	OV2400.Ana08ID,  OV2400.Ana09ID, OV2400.Ana10ID,
		OV2400.AnaName01 ,OV2400.AnaName02, OV2400.AnaName03 ,OV2400.AnaName04 ,OV2400.AnaName05,
		OV2400.AnaName06 ,OV2400.AnaName07, OV2400.AnaName08 ,OV2400.AnaName09 ,OV2400.AnaName10,OV2400.Finish,

		CASE WHEN isnull(OV2400.ShipDate, '''') = '''' or isnull(OV0308.ActualDate, '''') = '''' then 0 else 
		Datediff(day, OV2400.ShipDate, OV0308.ActualDate) end as AfterDayAmount, 
		(OV2400.OrderQuantity - isnull(OV0308.ActualQuantity, 0) + isnull(OV2400.AdjustQuantity, 0)) as RemainQuantity, OV2400.DateEnd, OV2400.DateBegin, OV0308.ActualDateBegin,
		OV2400.Parameter01,OV2400.Parameter02,OV2400.Parameter03,OV2400.Parameter04,OV2400.Parameter05,
		OV2400.Parameter06,OV2400.Parameter07,OV2400.Parameter08,OV2400.Parameter09,OV2400.Parameter10,
		OV2400.ContractNo,
		OV2400.TDescription,
		OV2400.I02ID,
		OV2400.IsProInventoryID,
		OV2400.CreateUserName' 
		
Set @sSQL1 =  @sSELECT  + N'
FROM OV0307 OV2400
LEFT JOIN OV0308 ON OV0308.OTransactionID = OV2400.TransactionID and OV0308.DivisionID = OV2400.DivisionID 
LEFT JOIN OT1101 WITH (NOLOCK) on OT1101.OrderStatus = OV2400.OrderStatus  and OT1101.DivisionID = OV2400.DivisionID  and TypeID =  ''PO''
' + 
	@sFROM + '
WHERE	OV2400.DivisionID '+@sWhereDivision+' and ' +   
		CASE WHEN @IsDate = 1 then  ' OV2400.OrderStatus not in (  4, 9)   and 
		CONVERT(DATETIME,CONVERT(VARCHAR(10),OV2400.VoucherDate ,101),101)  BETWEEN ''' + @FromDateText + ''' and ''' +  @ToDateText  + ''' '
		else 	' OV2400.OrderStatus not in (9,  4)   and  
		(CASE WHEN OV2400.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(OV2400.TranMonth)))+''/''+ltrim(Rtrim(str(OV2400.TranYear))) in ('''+@PeriodList +''')'   end +  
		  ' and  OV2400.InventoryID ' + CASE WHEN @FromInventoryID = '%' then ' like ''%''' 
		else ' between N''' + @FromInventoryID + ''' and N''' + @ToInventoryID + ''''   end +
		  ' and  OV2400.ObjectID ' + CASE WHEN @FromObjectID = '%' then ' like ''%''' 
		else ' between N''' + @FromObjectID + ''' and N''' + @ToObjectID + ''''   end +
		--case when ISNULL(@ListInventoryID,'') <> '' then ' and ISNULL(OV2400.InventoryID,'''') IN (SELECT Value FROM [dbo].StringSplit('''+@ListInventoryID+''', '',''))' else '' end +
		case when ISNULL(@ListObjectID,'') <> '' then ' and ISNULL(OV2400.ObjectID,'''') IN (SELECT Value FROM [dbo].StringSplit('''+@ListObjectID+''', '',''))' else '' end


		
END
--Print @sSQL

set @Groupby = ' 
GROUP BY OV2400.DivisionID ,
		OV2400.OrderID,  
		OV2400.VoucherNo,           
		OV2400.VoucherDate ,
		OV2400.ObjectID,
		OV2400.ObjectName,
		OV2400.Orders,
		OV2400.OrderStatus,
		OT1101.Description ,
		OV2400.InventoryID, 
		OV2400.InventoryName, 

		OV2400.UnitName,
		OV2400.Specification,
		OV2400.InventoryTypeID,
		OV2400.OrderQuantity,
		OV2400.PurchasePrice,

		OV2400.PurchasePrice,  OV2400.ExchangeRate,	
		OV2400.OriginalAmount ,

		OV2400.ConvertedAmount ,
		OV2400.ShipDate,
		OV2400.Notes, OV2400.Notes01, OV2400.Notes02,
		OV0308.ActualQuantity,
		OV0308.ActualDate,
		Ana01ID,  Ana02ID, 	Ana03ID,  Ana04ID, Ana05ID,
		Ana06ID,  Ana07ID, 	Ana08ID,  Ana09ID, Ana10ID,
		AnaName01 ,AnaName02, AnaName03 ,AnaName04 ,AnaName05,
		AnaName06 ,AnaName07, AnaName08 ,AnaName09 ,AnaName10,OV2400.Finish,
		OV2400.AdjustQuantity, OV2400.DateEnd, OV2400.DateBegin, OV0308.ActualDateBegin,
		OV2400.Parameter01,OV2400.Parameter02,OV2400.Parameter03,OV2400.Parameter04,OV2400.Parameter05,
		OV2400.Parameter06,OV2400.Parameter07,OV2400.Parameter08,OV2400.Parameter09,OV2400.Parameter10,
		OV2400.ContractNo,
		OV2400.TDescription,
		OV2400.I02ID,
		OV2400.IsProInventoryID,
		OV2400.CreateUserName'
		 
IF @IsGroup  = 1  ---Co nhom
	BEGIN
		 set @Groupby  = @Groupby + ',V1.SelectionID,V1.SelectionName'
		 
	END

PRINT (@sSQL+@sSQL1 +@Groupby) 
IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE NAME = 'OV0302' AND XTYPE ='V') 
	DROP VIEW OV0302
EXEC ('CREATE VIEW OV0302  --TAO BOI OP0302
		AS '+@sSQL+@sSQL1 + @sWhere + @sWhereListInventoryID +@Groupby)



----Step 3.2: In bao cao chi tiet (OR0321)

If  @IsCheck =1 ---co chon nhung phieu chua giao het
BEGIN
Set @sSQL =  N'
 SELECT OV2400.DivisionID as DivisionID,
		OV2400.OrderID as POrderID,  
		OV2400.VoucherNo,           
		OV2400.VoucherDate as OrderDate,
		OV2400.ObjectID,
		OV2400.ObjectName,
		OV2400.Orders,
		OV2400.OrderStatus,
		OT1101.Description as OrderStatusName,
		OV2400.InventoryID, 
		OV2400.InventoryName, 
		OV2400.VATPercent,
		OV2400.UnitName,
		OV2400.Specification,
		OV2400.InventoryTypeID,
		OV2400.OrderQuantity,
		OV2400.PurchasePrice,
		isnull(OV2400.PurchasePrice, 0)* isnull(OV2400.ExchangeRate, 0) as ConvertedPrice,	
		OV2400.OriginalAmount as OriginalAmount,
		OV2400.ConvertedAmount as ConvertedAmount,
		OV2400.TotalOriginalAmount as TOriginalAmount,
		OV2400.TotalConvertedAmount as TConvertedAmount,
		OV2400.ShipDate,
		OV2400.Notes, OV2400.Notes01, OV2400.Notes02,
		OV0309.ActualQuantity,
		OV0309.ActualDate,
		OV0309.UnitPrice as InputPrice,
		OV0309.VoucherNo as InputVoucher,
		OV0309.OriginalAmount as InputOriginalAmount,
		OV0309.OriginalAmountVAT,

		CASE WHEN isnull(OV2400.ShipDate, '''') = '''' or isnull(OV0309.ActualDate, '''') = '''' then 0 else 
		Datediff(day, OV2400.ShipDate, OV0309.ActualDate) end as AfterDayAmount, 
		(OV2400.OrderQuantity - isnull(OV0309.ActualQuantity, 0) + isnull(OV2400.AdjustQuantity, 0)) as RemainQuantity, OV2400.DateEnd, 
		OV2400.Parameter01,OV2400.Parameter02,OV2400.Parameter03,OV2400.Parameter04,OV2400.Parameter05,
		OV2400.Parameter06,OV2400.Parameter07,OV2400.Parameter08,OV2400.Parameter09,OV2400.Parameter10,
		OV2400.IsProInventoryID,
		OV2400.CreateUserName' 
		
Set @sSQL1 = 		@sSELECT  + N'
FROM   OV2400
LEFT JOIN  OV0309  on OV0309.OrderID = OV2400.OrderID and OV0309.InventoryID = OV2400.InventoryID and OV0309.DivisionID = OV2400.DivisionID and OV0309.OTransactionID = OV2400.TransactionID    
LEFT JOIN OT1101 WITH (NOLOCK) on OT1101.OrderStatus = OV2400.OrderStatus and OT1101.DivisionID = OV2400.DivisionID and TypeID =  ''PO''

' + @sFROM + '
WHERE	OV2400.DivisionID '+@sWhereDivision+' and ' +   
		CASE WHEN @IsDate = 1 then  ' ((OV2400.OrderStatus not in (   4,9)   and 
		CONVERT(DATETIME,CONVERT(VARCHAR(10),OV2400.VoucherDate ,101),101) < ''' + @FromDateText  + ''' AND  
		(OV2400.OrderQuantity - isnull(OV0309.ActualQuantity0, 0) + isnull(OV2400.AdjustQuantity, 0)) > 0) or
		CONVERT(DATETIME,CONVERT(VARCHAR(10),OV2400.VoucherDate ,101),101) BETWEEN ''' + 					
		 @FromDateText + ''' and ''' +  @ToDateText  + ''') '
		else 	' ((OV2400.OrderStatus not in (9,   4)   and  
		(CASE WHEN OV2400.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(OV2400.TranMonth)))+''/''+ltrim(Rtrim(str(OV2400.TranYear))) in ('''+@PeriodList +''')  AND  
		(OV2400.OrderQuantity - isnull(OV0309.ActualQuantity0, 0) + isnull(OV2400.AdjustQuantity, 0)) > 0)) ' end +  
		  ' and  OV2400.InventoryID ' + CASE WHEN @FromInventoryID = '%' then ' like ''%''' 
		else ' between ''' + @FromInventoryID + ''' and ''' + @ToInventoryID + ''''   end +
		  ' and  OV2400.ObjectID ' + CASE WHEN @FromObjectID = '%' then ' like ''%''' 
		else ' between ''' + @FromObjectID + ''' and ''' + @ToObjectID + ''''   end +
		' and OV2400.Finish = 0' +
		--case when ISNULL(@ListInventoryID,'') <> '' then ' and ISNULL(OV2400.InventoryID,'''') IN (SELECT Value FROM [dbo].StringSplit('''+@ListInventoryID+''', '',''))' else '' end +
		case when ISNULL(@ListObjectID,'') <> '' then ' and ISNULL(OV2400.ObjectID,'''') IN (SELECT Value FROM [dbo].StringSplit('''+@ListObjectID+''', '',''))' else '' end


END
Else ---Khong chon nhung phieu chua giao het
BEGIN
Set @sSQL =  N'
SELECT  OV2400.DivisionID as DivisionID,
		OV2400.OrderID as POrderID,  
		OV2400.VoucherNo,           
		OV2400.VoucherDate as OrderDate,
		OV2400.ObjectID,
		OV2400.ObjectName,
		OV2400.Orders,
		OV2400.OrderStatus,
		OT1101.Description as OrderStatusName,
		OV2400.InventoryID, 
		OV2400.InventoryName, 
		OV2400.VATPercent,
		OV2400.UnitName,
		OV2400.Specification,
		OV2400.InventoryTypeID,
		OV2400.OrderQuantity,
		OV2400.PurchasePrice,
		isnull(OV2400.PurchasePrice, 0)* isnull(OV2400.ExchangeRate, 0) as ConvertedPrice,	
		OV2400.OriginalAmount as OriginalAmount,
		OV2400.ConvertedAmount as ConvertedAmount,
		OV2400.TotalOriginalAmount as TOriginalAmount,
		OV2400.TotalConvertedAmount as TConvertedAmount,
		OV2400.ShipDate,
		OV2400.Notes, OV2400.Notes01, OV2400.Notes02,
		OV0309.ActualQuantity,
		OV0309.ActualDate,
		OV0309.UnitPrice as InputPrice,
		OV0309.VoucherNo as InputVoucher,
		OV0309.OriginalAmount as InputOriginalAmount,
		OV0309.OriginalAmountVAT,

		CASE WHEN isnull(OV2400.ShipDate, '''') = '''' or isnull(OV0309.ActualDate, '''') = '''' then 0 else 
		Datediff(day, OV2400.ShipDate, OV0309.ActualDate) end as AfterDayAmount, 
		(OV2400.OrderQuantity - isnull(OV0309.ActualQuantity, 0) + isnull(OV2400.AdjustQuantity, 0)) as RemainQuantity, OV2400.DateEnd,
		OV2400.Parameter01,OV2400.Parameter02,OV2400.Parameter03,OV2400.Parameter04,OV2400.Parameter05,
		OV2400.Parameter06,OV2400.Parameter07,OV2400.Parameter08,OV2400.Parameter09,OV2400.Parameter10,
		OV2400.IsProInventoryID,
		OV2400.CreateUserName ' 
		
Set @sSQL1 =  		@sSELECT  + N'
From   OV2400  
LEFT JOIN OV0309  on OV0309.OrderID = OV2400.OrderID and OV0309.InventoryID = OV2400.InventoryID	and OV0309.OTransactionID = OV2400.TransactionID  and OV0309.DivisionID = OV2400.DivisionID 
LEFT JOIN OT1101 WITH (NOLOCK) on OT1101.OrderStatus = OV2400.OrderStatus  and OT1101.DivisionID = OV2400.DivisionID and TypeID =  ''PO''	
' +@sFROM + '
WHERE OV2400.DivisionID '+@sWhereDivision+' and ' +   
		CASE WHEN @IsDate = 1 then  ' OV2400.OrderStatus not in (  4,9)   and 
		CONVERT(DATETIME,CONVERT(VARCHAR(10),OV2400.VoucherDate ,101),101)  BETWEEN ''' + @FromDateText + ''' and ''' +  @ToDateText  + ''' '
		else 	' OV2400.OrderStatus not in (9, 4)   and  
		(CASE WHEN OV2400.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(OV2400.TranMonth)))+''/''+ltrim(Rtrim(str(OV2400.TranYear))) in ('''+@PeriodList +''')' end +  
		  ' and  OV2400.InventoryID ' + CASE WHEN @FromInventoryID = '%' then ' like ''%''' 
		else ' between N''' + @FromInventoryID + ''' and N''' + @ToInventoryID + ''''   end +
		  ' and  OV2400.ObjectID ' + CASE WHEN @FromObjectID = '%' then ' like ''%''' 
		else ' between N''' + @FromObjectID + ''' and N''' + @ToObjectID + ''''   end +
		'and OV2400.Finish = 0'+
		--case when ISNULL(@ListInventoryID,'') <> '' then ' and ISNULL(OV2400.InventoryID,'''') IN (SELECT Value FROM [dbo].StringSplit('''+@ListInventoryID+''', '',''))' else '' end +
		case when ISNULL(@ListObjectID,'') <> '' then ' and ISNULL(OV2400.ObjectID,'''') IN (SELECT Value FROM [dbo].StringSplit('''+@ListObjectID+''', '',''))' else '' end

END

set @Groupby = ' 
GROUP BY OV2400.DivisionID ,
		OV2400.OrderID ,  
		OV2400.VoucherNo,           
		OV2400.VoucherDate ,
		OV2400.ObjectID,
		OV2400.ObjectName,
		OV2400.OrderStatus,
		OT1101.Description ,
		OV2400.InventoryID, 
		OV2400.InventoryName, 
		OV2400.VATPercent,
		OV2400.UnitName,
		OV2400.Specification,
		OV2400.InventoryTypeID,
		OV2400.OrderQuantity,
		OV2400.PurchasePrice,
		OV2400.ExchangeRate,	
		OV2400.Orders,
		OV2400.OriginalAmount ,
		OV2400.ConvertedAmount ,
		OV2400.TotalOriginalAmount ,
		OV2400.TotalConvertedAmount ,
		OV2400.ShipDate,
		OV2400.Notes, OV2400.Notes01, OV2400.Notes02,
		OV0309.ActualQuantity,
		OV0309.ActualDate,
		OV0309.UnitPrice ,
		OV0309.VoucherNo,
		OV0309.OriginalAmount ,
		OV0309.OriginalAmountVAT,OV2400.AdjustQuantity,
		OV2400.DateEnd,
		OV2400.Parameter01,OV2400.Parameter02,OV2400.Parameter03,OV2400.Parameter04,OV2400.Parameter05,
		OV2400.Parameter06,OV2400.Parameter07,OV2400.Parameter08,OV2400.Parameter09,OV2400.Parameter10
		, OV2400.IsProInventoryID,
		OV2400.CreateUserName'
		
IF @IsGroup  = 1  ---Co nhom
BEGIN
	 set @Groupby  = @Groupby + ',V1.SelectionID,V1.SelectionName'
	 
END

IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE NAME = 'OV0321' AND XTYPE ='V') 
	DROP VIEW OV0321
EXEC ('CREATE VIEW OV0321  --TAO BOI OP0302
		AS ' + @sSQL + @sSQL1 + @sWhereListInventoryID + @Groupby)
        --PRINT (@sSQL + @sSQL1 + @Groupby)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
