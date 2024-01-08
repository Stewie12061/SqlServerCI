IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0303]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0303]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






---Created by : Thuy Tuyen
---purpose: In bao cao Tong hop tinh hinh dat hang( So sanh giu Yeu cau- don hang mua- nhap kho )
-- date: 11/05/2009,26/05/2009
-- Last edit: Thuy Tuyen 05/06/2009 ,17/06/2009, 18/06/2009,26/10/2009,30/11/2009
--- Edit by B.Anh, date 11/12/2009	Sua loi khong len du lieu phan so luong giao thuc te va ngay giao tu nhap kho Asoft-T
--Edit Thuy Tuyen: Lay them truong don gia  khi lap don hang mua, date: 15/01/2009
---- Modified on 31/01/2012 by Le Thi Thu Hien : Sua dieu kien CONVERT theo ngay
---- Modified on 31/05/2016 by Bảo Thy: Bổ sung WITH (NOLOCK)
---- Modified on 20/07/2018 by Bảo Anh: Bổ sung FollowerID1, FollowerName1, FollowerID2, FollowerName2, PVoucherNo
---- Modified on 02/08/2018 by Bảo Anh: Bổ sung store customize VPS
---- Modified by Khánh Đoan on 09/26/2019 Lây trường ConfirmUserID, ConfirmDate, ConfirmUserName
---- Modified by Văn Minh on 29/11/2019 : Thêm trường AnaName vào báo cáo
---- Modified by Huỳnh Thử on 15/04/2020 : Customer Phúc Long: Hiển thị những phiếu có mã cung cấp là null
---- Modified by Hoài Phong on 15/10/2020 : Bổ sung cột để like , hiện tại like không có cột để báo lỗi
---- Modified on 02/11/2020 by Trọng Kiên : Bổ sung Param (@Ana01ID, @ListInventoryID) cho Store
---- Modified on 29/01/2021 by Kiều Nga : Chuyển đk lọc từ kỳ, đến kỳ sang chọn kỳ
---- Modified on 11/03/2021 by Đức Thông : [Phúc Long] 2021/03/IS/0086 Fix bug in báo cáo
---- Modified on 10/05/2022 by Phương Thảo : Sửa điều kiện lọc trong store
---- Modified on 25/11/2022 by Anh Đô : Fix lỗi khi in báo cáo do không có cột Ana01ID và Ana01Name
---- Modified on 30/11/2022 by Anh Đô : Fix lỗi không có dữ liệu Đặt hàng ở báo cáo POR3004
---- Modified on 07/02/2023	by Anh Đô : Tách @ListInventoryID ra khỏi @sSql1 để fix lỗi tràn chuỗi
---- Modified on 16/02/2023 by Anh Đô: Bổ sung lọc theo ListAna01ID; Select thêm cột Thành tiền của mặt hàng trong đơn hàng mua (OV0331.SOriginalAmount)
---- Modified on 08/03/2023 by Thành Sang: Select thêm cột Notes, SuplierID, SuplierName
---- Modified on 30/03/2023 by Kiều Nga: Lấy thêm cột Notes01 OV0315
---- Modified on 17/04/2023 by Đình Định: Load cột số lượng, ngày của thông tin Đặt hàng & Đáp ứng.
---- Modified on 31/05/2023 by Đình Định: Bổ sung tách chuỗi khi chọn in theo kỳ tất cả.
---- Modified on 13/07/2023 by Thành Sang: Lấy thêm cột Notes02 OV0315
/*******************************************************************************************************************************************************
'* Edited by: [GS] [Mỹ Tuyền] [16/12/2010]
'********************************************/

CREATE PROCEDURE [dbo].[OP0303]  
				@DivisionID nvarchar(50),
				@DivisionIDList	NVARCHAR(MAX),
				@IsDate INT, ---- 1: là ngày, 0: là kỳ
				@FromDate DATETIME,
				@ToDate DATETIME,
				@PeriodList NVARCHAR(MAX)='',
				@FromInventoryID NVARCHAR(50),
				@ToInventoryID NVARCHAR(50),
				@IsGroup AS TINYINT,
				@GroupID NVARCHAR(50), -- GroupID: OB, CI1, CI2, CI3, I01, I02, I03, I04, I05	
				@IsCheck INT,---- 0: co len du lieu cua thang truoc chua nhan,1: khong len du lieu cua thang truoc
				@FromObjectID NVARCHAR(50),
				@ToObjectID NVARCHAR(50),
				@Ana01ID nvarchar(50) = '',
				@ListInventoryID nvarchar(max) = '',
				@ListObjectID nvarchar(max) = '',
				@ListAna01ID NVARCHAR(MAX) = ''
AS
DECLARE @CustomerName INT 

CREATE TABLE #CustomerName (CustomerName INT, ImportExcel INT)
INSERT #CustomerName EXEC AP4444
SET @CustomerName =  (SELECT TOP 1 CustomerName FROM #CustomerName) 

IF (SELECT CustomerName FROM CustomerIndex) = 63	--- VPS
	EXEC OP0303_VPS @DivisionID, @DivisionIDList, @IsDate, @FromDate, @ToDate, @PeriodList,@FromInventoryID, @ToInventoryID, @IsGroup, @GroupID, @IsCheck, @FromObjectID, @ToObjectID
ELSE
BEGIN
	DECLARE @sSQL NVARCHAR(4000),
			@sSQL1 NVARCHAR(4000),
			@GroupField NVARCHAR(20),
			@sFROM NVARCHAR(500),
			@sSELECT NVARCHAR(500),
			@sWHERE NVARCHAR(500), 
		@FromMonthYearText NVARCHAR(20), 
		@ToMonthYearText NVARCHAR(20), 
		@FromDateText NVARCHAR(20), 
		@ToDateText NVARCHAR(20),
		@sWhereDivision NVARCHAR(max),
		@sWhereInventoryIDList NVARCHAR(MAX) = N''

	Set @sWhereDivision = ''

	IF ISNULL(@ListInventoryID, '') NOT IN ('', '%')
		SET @sWhereInventoryIDList = N' AND ISNULL(OV2400.InventoryID, '''') IN ('''+ @ListInventoryID +''') '

	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhereDivision = ' IN ('''+@DivisionIDList+''')'
	ELSE 
		SET @sWhereDivision = ' = N'''+@DivisionID+''''	
    
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
	SET @PeriodList = REPLACE(@PeriodList, ',',''',''')

	SELECT @sFROM = '',  @sSELECT = ''

	---Step 1: Lay  so luong  giao thu te 
		--------Step 1.1: Lay  Tong so luong   giao thuc te (nhap kho).

	SET @sSQL = N'
	Select	A00.DivisionID , 
			A00.OrderID , 
			A00.InventoryID,  
			A00.OTransactionID,
			sum(ActualQuantity) as ActualQuantity, 
			Max(A01.VoucherDate) as ActualDate, 
			SUM(' + CASE WHEN @IsDate = 1 THEN  ' CASE WHEN CONVERT(DATETIME,CONVERT(VARCHAR(10),T01.OrderDate ,101),101)  < ''' + @FromDateText  + ''' THEN  ActualQuantity ELSE 0 END ' 
			ELSE '  CASE WHEN (CASE WHEN T01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T01.TranMonth)))+''/''+ltrim(Rtrim(str(T01.TranYear))) IN ('''+@PeriodList +''')  THEN ActualQuantity ELSE 0 END'   END + ')
			AS ActualQuantity0
	From AT2007 A00  WITH (NOLOCK)
	inner join AT2006 A01 WITH (NOLOCK) on A00.VoucherID = A01.VoucherID and A01.KindVoucherID  in(1, 5, 7) And A00.DivisionID = A01.DivisionID
	Inner join OT3002 T02 WITH (NOLOCK) on T02.TransactionID = A00.OTransactionID And A00.DivisionID = T02.DivisionID
	inner join OT3001 T01 WITH (NOLOCK) on T01.POrderID  = T02.POrderID  and T01.OrderStatus not in ( 9)  And A00.DivisionID = T01.DivisionID

	Where  T01.DivisionID '+@sWhereDivision +' /*AND    ' +
		CASE WHEN @IsDate = 1 THEN  ' CONVERT(DATETIME,CONVERT(VARCHAR(10),T01.OrderDate,101),101)  <= ''' + @ToDateText  + '''' 
		ELSE  '   (CASE WHEN T01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T01.TranMonth)))+''/''+ltrim(Rtrim(str(T01.TranYear))) in ('''+@PeriodList +''')'  END  + ' AND ' + 
		CASE WHEN @IsDate = 1 THEN  ' CONVERT(DATETIME,CONVERT(VARCHAR(10),A01.VoucherDate,101),101)  <= ''' + @ToDateText  + '''' 
		ELSE  '   (CASE WHEN A01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(A01.TranMonth)))+''/''+ltrim(Rtrim(str(A01.TranYear))) in ('''+@PeriodList +''')'  END  +  ' */
		GROUP BY A00.DivisionID, A00.OrderID, A00.InventoryID, A00.OTransactionID'

	IF EXISTS(SELECT TOP 1 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE XTYPE = 'V' AND NAME = 'OV0313')
		DROP VIEW OV0313
	EXEC('CREATE VIEW OV0313 ---tao boi OP0303
			as ' + @sSQL)



	--------Step 1.2: Lay  Tong so luong  dat hang thuc te(don  hang mua ) .
	SET @sSQL =  -- chi tiet
	N' SELECT A00.DivisionID AS DivisionID, 
			  A00.ROrderID AS OrderID , 
			  A00.POrderID , 	
			  A00.InventoryID,  
			  A00.RefTransactionID,
			  A00.TransactionID,
			  A00.InheritTransactionID,
			  A01.VoucherNo,
			  SUM(A00.OrderQuantity) AS ActualQuantity, 
			  AVG(PurchasePrice) AS PurchasePrice,
			  MAX(A01.OrderDate) AS ActualDate, 
			  A01.ShipDate AS POShipdate,
			  SUM(' + CASE WHEN @IsDate = 1 THEN  ' CASE WHEN CONVERT(DATETIME,CONVERT(VARCHAR(10),T01.OrderDate ,101),101)  < ''' + @FromDateText  + ''' THEN  A00.OrderQuantity ELSE 0 END ' 
			  ELSE '  CASE WHEN (CASE WHEN T01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T01.TranMonth)))+''/''+ltrim(Rtrim(str(T01.TranYear))) IN ('''+@PeriodList +''')  THEN A00.OrderQuantity ELSE 0 END'   END + ') AS ActualQuantity0,
			  SUM(ISNULL(A00.OriginalAmount, 0)) - SUM(ISNULL(A00.DiscountOriginalAmount, 0)) + SUM(ISNULL(A00.VATOriginalAmount, 0)) AS SOriginalAmount
	FROM OT3002 A00 WITH (NOLOCK) 
	LEFT JOIN OT3001 A01 WITH (NOLOCK) ON A00.POrderID = A01.POrderID AND A00.DivisionID = A01.DivisionID
	LEFT JOIN OT3102 T02 WITH (NOLOCK) ON T02.TransactionID = ISNULL(A00.InheritTransactionID, '''') AND A00.DivisionID = T02.DivisionID
	LEFT JOIN OT3101 T01 WITH (NOLOCK) ON T01.ROrderID = T02.ROrderID AND T01.OrderStatus NOT IN (9) AND A00.DivisionID = T01.DivisionID
	WHERE A00.DivisionID  '+@sWhereDivision +' /* AND    ' +
		CASE WHEN @IsDate = 1 THEN  ' CONVERT(DATETIME,CONVERT(VARCHAR(10),T01.OrderDate,101),101)  <= ''' + @ToDateText  + '''' 
		ELSE  '   (CASE WHEN T01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T01.TranMonth)))+''/''+ltrim(Rtrim(str(T01.TranYear))) in ('''+@PeriodList +''')'   END  + ' AND ' + 

		CASE WHEN @IsDate = 1 THEN  ' CONVERT(DATETIME,CONVERT(VARCHAR(10),A01.OrderDate,101),101)  <= ''' + @ToDateText  + '''' 
		ELSE  '   (CASE WHEN A01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(A01.TranMonth)))+''/''+ltrim(Rtrim(str(A01.TranYear))) in ('''+@PeriodList +''')'   END  +  '*/
		Group by A00.DivisionID, A00.ROrderID, A00.InventoryID,A00.POrderID, A00.RefTransactionID, A00.TransactionID,A01.ShipDate,A01.VoucherNo,A00.InheritTransactionID'

	---print @sSQL
	IF EXISTS(SELECT TOP 1 1 FROM sysObjects WITH (NOLOCK) WHERE XType = 'V' AND Name = 'OV0331')
		DROP VIEW OV0331
	EXEC('Create view OV0331 ---tao boi OP0303
			as ' + @sSQL)

	 --------Step 1.2: Lay  Tong so luong  dat hang thuc te(don  hang mua ) .
	SET @sSQL =  -- tong hop
	N'Select A00.DivisionID as DivisionID, 
		A00.ROrderID as OrderID , 
		A00.InventoryID,  
		A00.RefTransactionID,
		T03.AnaName as Ana04Name,
		Avg(PurchasePrice) as PurchasePrice,
		sum(A00.OrderQuantity) as ActualQuantity, 
		Max(A01.OrderDate) as ActualDate, 
		'''' as  POShipdate,
		SUM(' + CASE WHEN @IsDate = 1 THEN  ' CASE WHEN CONVERT(DATETIME,CONVERT(VARCHAR(10),T01.OrderDate ,101),101) < ''' + @FromDateText  + ''' THEN  A00.OrderQuantity ELSE 0 END ' 
		ELSE '  CASE WHEN (CASE WHEN T01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T01.TranMonth)))+''/''+ltrim(Rtrim(str(T01.TranYear))) IN ('''+@PeriodList +''')  THEN A00.OrderQuantity ELSE 0 END'   END + ')
		AS ActualQuantity0,
		MAX(A01.CreateUserID) AS FollowerID2, MAX(AT1103.FullName) AS FollowerName2, A01.VoucherNo AS PVoucherNo
	From OT3002 A00 WITH (NOLOCK) inner join OT3001 A01 WITH (NOLOCK) on A00.POrderID = A01.POrderID  And A00.DivisionID = A01.DivisionID
	Inner join OT3102 T02 WITH (NOLOCK) on T02.TransactionID = isnull(A00.RefTransactionID,'''') And A00.DivisionID = T02.DivisionID
	inner join OT3101 T01 WITH (NOLOCK) on T01.ROrderID  = T02.ROrderID  and T01.OrderStatus not in ( 9) And A00.DivisionID = T01.DivisionID
	LEFT JOIN AT1103 WITH (NOLOCK) ON A01.DivisionID = AT1103.DivisionID AND A01.CreateUserID = AT1103.EmployeeID
	LEFT JOIN AT1011 T03 ON T03.AnaID = A00.Ana04ID AND T03.AnaTypeID = ''A04''
	Where  T01.DivisionID '+@sWhereDivision +' /* AND    ' +
		CASE WHEN @IsDate = 1 THEN  ' CONVERT(DATETIME,CONVERT(VARCHAR(10),T01.OrderDate ,101),101)  <= ''' + @ToDateText  + '''' 
		ELSE  '   (CASE WHEN T01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T01.TranMonth)))+''/''+ltrim(Rtrim(str(T01.TranYear))) in ('''+@PeriodList +''')'  END  + ' AND ' + 
		CASE WHEN @IsDate = 1 THEN  ' CONVERT(DATETIME,CONVERT(VARCHAR(10),A01.OrderDate ,101),101)  <= ''' + @ToDateText  + '''' 
		ELSE  '   (CASE WHEN A01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(A01.TranMonth)))+''/''+ltrim(Rtrim(str(A01.TranYear))) in ('''+@PeriodList +''')'   END  +  '*/
		Group by A00.DivisionID ,A00.ROrderID, A00.InventoryID, A00.RefTransactionID, A01.VoucherNo,T03.AnaName'
	IF EXISTS(SELECT TOP 1 1 FROM sysObjects WITH (NOLOCK) WHERE XType = 'V' AND Name = 'OV0314')
		DROP VIEW OV0314
	EXEC('Create view OV0314 ---tao boi OP0303
			as ' + @sSQL)

	---Step2: Lay du lieu nhom (OR0302,OR0321)
		
	IF @IsGroup  = 1  ---Co nhom
		BEGIN
		EXEC OP4700  	@GroupID,	@GroupField OUTPUT
		SELECT @sFROM = @sFROM + ' left join OV6666 V1 on V1.SelectionType = ''' + @GroupID + ''' and V1.SelectionID = OV2400.' + @GroupField + ' And V1.DivisionID = OV2400.DivisionID ',
			@sSELECT = @sSELECT + ', 
			V1.SelectionID as GroupID, V1.SelectionName as GroupName'
		
		END

	ELSE  ---Khong  nhom
		SET @sSELECT = @sSELECT +  ', 
			'''' as GroupID, '''' as GroupName'	


	---------Step3.1: Tong hop (OR6012)
	IF @IsCheck=1 ---co chon nhung phieu chua giao het
	BEGIN
	SET @sSQL =  N'
	Select  OV2400.DivisionID as DivisionID, 
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
			OV2400.RequestPrice,
			isnull(OV2400.RequestPrice, 0)* isnull(OV2400.ExchangeRate, 0) as ConvertedPrice,	
			OV2400.OriginalAmount as TOriginalAmount,
			OV2400.ConvertedAmount as TConvertedAmount,
			OV2400.ShipDate,
			OV2400.Ana01ID,
			OV2400.Ana01Name,
			OV0314.ActualQuantity,
			OV0314.ActualDate,
			OV0314.PurchasePrice,
			OV0314.Ana04Name,
		
			case when isnull(OV2400.ShipDate, '''') = '''' or isnull(OV0314.ActualDate, '''') = '''' then 0 else 
			Datediff(day, OV2400.ShipDate, OV0314.ActualDate) end as AfterDayAmount, 
			(OV2400.OrderQuantity - isnull(OV0314.ActualQuantity, 0) + isnull(OV2400.AdjustQuantity, 0)) as RemainQuantity,
			OV2400.EmployeeID as FollowerID1, AT1103.FullName AS FollowerName1,
			OV0314.FollowerID2, OV0314.FollowerName2, OV0314.PVoucherNo
			 ' 
	SET @sSQL1 = @sSELECT  + N'
	From OV2700  OV2400
	 left join OV0314 on OV2400.TransactionID =isnull( OV0314.RefTransactionID,'''') And OV2400.DivisionID = OV0314.DivisionID
	left join OT1101 WITH (NOLOCK) on OT1101.OrderStatus = OV2400.OrderStatus and TypeID =  ''RO'' And OV2400.DivisionID = OT1101.DivisionID
	LEFT JOIN AT1103 WITH (NOLOCK) ON OV2400.DivisionID = AT1103.DivisionID AND OV2400.EmployeeID = AT1103.EmployeeID 
				   ' + @sFROM + ' 
	Where  OV2400.DivisionID '+@sWhereDivision +' and ' +   
			CASE WHEN @IsDate = 1 THEN  ' ((OV2400.OrderStatus not in (   4, 9)   and 
			CONVERT(DATETIME,CONVERT(VARCHAR(10),OV2400.VoucherDate ,101),101)  < ''' + @FromDateText  + ''' AND  
			(OV2400.OrderQuantity - isnull(OV0314.ActualQuantity0, 0) + isnull(OV2400.AdjustQuantity, 0)) > 0) or
			CONVERT(DATETIME,CONVERT(VARCHAR(10),OV2400.VoucherDate ,101),101)  BETWEEN ''' + 					
			 @FromDateText + ''' and ''' +  @ToDateText  + ''') '
			ELSE 	' ((OV2400.OrderStatus not in ( 9, 4)   and  
			(CASE WHEN OV2400.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(OV2400.TranMonth)))+''/''+ltrim(Rtrim(str(OV2400.TranYear))) IN ('''+@PeriodList +''')  AND  
			(OV2400.OrderQuantity - isnull(OV0314.ActualQuantity0, 0) + isnull(OV2400.AdjustQuantity, 0)) > 0))' END +  
			  ' and  OV2400.InventoryID ' + CASE WHEN @FromInventoryID = '%' THEN ' like ''%''' 
			ELSE ' between ''' + @FromInventoryID + ''' and ''' + @ToInventoryID + ''''   END +
			  ' and  OV2400.ObjectID '+ CASE WHEN @CustomerName = 32  THEN ''''+@FromObjectID+'''' ELSE '' END +'
			  ' + CASE WHEN @FromObjectID = '%' THEN ' like ''%''' 
			ELSE ' between ''' + @FromObjectID + ''' and ''' + @ToObjectID + ''''   END +
			case when ISNULL(@Ana01ID,'') <> '' then ' and ISNULL(OV2400.Ana01ID,'''') = '''+@Ana01ID+'''' else '' end +
			--case when (ISNULL(@ListInventoryID,'') NOT IN ('%', '')) then ' and ISNULL(OV2400.InventoryID,'''') IN('''+@ListInventoryID+''')' else '' end +
			case when (ISNULL(@ListObjectID, '') NOT IN ('%', '')) then ' and ISNULL(OV2400.ObjectID,'''') IN('''+@ListObjectID+''')' else '' end +
			CASE WHEN ISNULL(@ListAna01ID, '') NOT IN ('%', '') THEN ' AND ISNULL(OV2400.Ana01ID, '''') IN (SELECT Value FROM [dbo].StringSplit('''+ @ListAna01ID +''', '','')) ' ELSE '' END

	END
	Else	--- Khong chon nhung phieu chua giao het
	BEGIN
	Set @sSQL =  N'
	Select  OV2400.DivisionID as DivisionID,
			OV2400.OrderID as POrderID,  
			OV2400.VoucherNo,           
			OV2400.VoucherDate as OrderDate,
			OV2400.ObjectID,
			OV2400.ObjectName,
			----OV2400.Orders,
			OV2400.OrderStatus,
			OT1101.Description as OrderStatusName,
			OV2400.InventoryID, 
			OV2400.InventoryName, 
			OV2400.UnitName,
			OV2400.Specification,
			OV2400.InventoryTypeID,
			OV2400.OrderQuantity,
			OV2400.RequestPrice,
			isnull(OV2400.RequestPrice, 0)* isnull(OV2400.ExchangeRate, 0) as ConvertedPrice,	
			OV2400.OriginalAmount as TOriginalAmount,
			OV2400.ConvertedAmount as TConvertedAmount,
			OV2400.ShipDate,
			OV2400.Ana01ID,
			OV2400.Ana01Name,
			OV0314.ActualQuantity,
			OV0314.ActualDate,
			OV0314.PurchasePrice,
			OV0314.Ana04Name,
			case when isnull(OV2400.ShipDate, '''') = '''' or isnull(OV0314.ActualDate, '''') = '''' then 0 else 
			Datediff(day, OV2400.ShipDate, OV0314.ActualDate) end as AfterDayAmount, 
			(OV2400.OrderQuantity - isnull(OV0314.ActualQuantity, 0) + isnull(OV2400.AdjustQuantity, 0)) as RemainQuantity,
			OV2400.EmployeeID as FollowerID1, AT1103.FullName AS FollowerName1,
			OV0314.FollowerID2, OV0314.FollowerName2, OV0314.PVoucherNo
			'
	Set @sSQL1 = @sSELECT  + N'
	From OV2700  OV2400
	 left join OV0314 on OV2400.TransactionID =isnull( OV0314.RefTransactionID,'''') And OV2400.DivisionID = OV0314.DivisionID
	left join OT1101 WITH (NOLOCK) on OT1101.OrderStatus = OV2400.OrderStatus and TypeID =  ''RO'' And OV2400.DivisionID = OT1101.DivisionID
	LEFT JOIN AT1103 WITH (NOLOCK) ON OV2400.DivisionID = AT1103.DivisionID AND OV2400.EmployeeID = AT1103.EmployeeID
					 ' + @sFROM + ' 
	Where OV2400.DivisionID '+@sWhereDivision +' and ' +   
			case when @IsDate = 1 
					then  ' OV2400.OrderStatus not in (  4, 9)   and 
			CONVERT(DATETIME,CONVERT(VARCHAR(10),OV2400.VoucherDate ,101),101)  BETWEEN ''' + 					
			 @FromDateText + ''' and ''' +  @ToDateText  + ''' '
					else 	' OV2400.OrderStatus not in (9,  4)   and  
			(CASE WHEN OV2400.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(OV2400.TranMonth)))+''/''+ltrim(Rtrim(str(OV2400.TranYear))) IN ('''+@PeriodList +''')'   
				end +  
			  ' and ISNULL(OV2400.InventoryID, '''') ' 
			+ case when @FromInventoryID = '%' 
					then ' like ''%''' 
					else ' between ''' + @FromInventoryID + ''' and ''' + @ToInventoryID + ''''   
				end +
			 ' and ISNULL(OV2400.ObjectID, '''') ' 
			+ case when @FromObjectID = '%' 
					then ' like ''%''' 
					else ' between ''' + @FromObjectID + ''' and ''' + @ToObjectID + ''''   
				end +
			case when ISNULL(@Ana01ID,'') <> '' then ' and ISNULL(OV2400.Ana01ID,'''') = '''+@Ana01ID+'''' else '' end +
			--case when (ISNULL(@ListInventoryID,'') NOT IN ('%', '')) then ' and ISNULL(OV2400.InventoryID,'''') IN('''+@ListInventoryID+''')' else '' end +
			case when (ISNULL(@ListObjectID, '') NOT IN ('%', '')) then ' and ISNULL(OV2400.ObjectID,'''') IN('''+@ListObjectID+''')' else '' end +
			CASE WHEN ISNULL(@ListAna01ID, '') NOT IN ('%', '') THEN ' AND ISNULL(OV2400.Ana01ID, '''') IN (SELECT Value FROM [dbo].StringSplit('''+ @ListAna01ID +''', '','')) ' ELSE '' END
	END
	--print @sSQL
	If exists (Select top 1 1 From SysObjects WITH (NOLOCK) Where name = 'OV0316' and Xtype ='V') 
		Drop view OV0316
	Exec ('Create view OV0316  --tao boi OP0303
			as '+@sSQL+@sSQL1 + @sWhereInventoryIDList )



	------Step3: Lay du lieu in bao cao
		---------Step3.1: Chi tiet  (OR6014, OR6015)
	If @IsCheck=1 ---co chon nhung phieu chua giao het
	BEGIN
	Set @sSQL =  N'
	Select  OV2400.DivisionID as DivisionID,
			OV2400.OrderID as POrderID,  
			OV2400.TransactionID,
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
			OV2400.RequestPrice,
			isnull(OV2400.RequestPrice, 0)* isnull(OV2400.ExchangeRate, 0) as ConvertedPrice,	
			OV2400.OriginalAmount as TOriginalAmount,
			OV2400.ConvertedAmount as TConvertedAmount,
			OV2400.ShipDate,
			OV2400.Ana01ID,
			OV2400.Ana01Name,
			OV0331.ActualQuantity,
			OV0331.ActualDate,
			OV0331.PurchasePrice,
			OV2400.SuplierID,
			OV2400.SuplierName ,
			OV0331.POrderID as  ActualOrderID,
			case when isnull(OV2400.ShipDate, '''') = '''' or isnull(OV0331.ActualDate, '''') = '''' then 0 else 
			Datediff(day, OV2400.ShipDate, OV0331.ActualDate) end as AfterDayAmount, 
			(OV2400.OrderQuantity - isnull(OV0331.ActualQuantity, 0) + isnull(OV2400.AdjustQuantity, 0)) as RemainQuantity,
			OV0313.ActualQuantity as TActualQuantity,
			OV0313.ActualDate as TActualDate ,
			OV0331.POShipdate,OV2400.ConfirmUserID,OV2400.ConfirmDate ,OV2400.ConfirmUserName,
			OV2400.Notes, OV2400.Notes01, OV2400.Notes02
			' 
	Set @sSQL1 = @sSELECT + N'
	From OV2700  OV2400
	 left join OV0331  on  OV2400.TransactionID = OV0331.RefTransactionID And OV2400.DivisionID = OV0331.DivisionID
	 left join OV0313  on OV0331.InventoryID = OV0313.InventoryID  and OV0313.OTransactionID = OV0331.TransactionID And OV2400.DivisionID = OV0313.DivisionID
	left join OT1101 WITH (NOLOCK) on OT1101.OrderStatus = OV2400.OrderStatus and TypeID =  ''RO'' And OV2400.DivisionID = OT1101.DivisionID
				   ' + @sFROM + ' 
	Where  OV2400.DivisionID '+@sWhereDivision +' and ' +   
			case when @IsDate = 1 then  ' ((OV2400.OrderStatus not in (   4, 9)   and 
			CONVERT(DATETIME,CONVERT(VARCHAR(10),OV2400.VoucherDate ,101),101)  < ''' + @FromDateText  + ''' AND  
			(OV2400.OrderQuantity - isnull(OV0331.ActualQuantity0, 0) + isnull(OV2400.AdjustQuantity, 0)) > 0) or
			CONVERT(DATETIME,CONVERT(VARCHAR(10),OV2400.VoucherDate ,101),101)  BETWEEN ''' + 					
			 @FromDateText + ''' and ''' +  @ToDateText  + ''') '
			else 	' ((OV2400.OrderStatus not in ( 9, 4)   and 
			(CASE WHEN OV2400.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(OV2400.TranMonth)))+''/''+ltrim(Rtrim(str(OV2400.TranYear))) IN ('''+@PeriodList +''')  AND  
			(OV2400.OrderQuantity - isnull(OV0331.ActualQuantity0, 0) + isnull(OV2400.AdjustQuantity, 0)) > 0)) ' end +  
			  ' and  OV2400.InventoryID ' + case when @FromInventoryID = '%' then ' like ''%''' 
			else ' between ''' + @FromInventoryID + ''' and ''' + @ToInventoryID + ''''   end +
			 ' and  OV2400.ObjectID '+ CASE WHEN @CustomerName = 32  THEN ''''+@FromObjectID+'''' ELSE '' END +'
			  ' + case when @FromObjectID = '%' then ' like ''%''' 
			else ' between ''' + @FromObjectID + ''' and ''' + @ToObjectID + ''''   end +
			case when ISNULL(@Ana01ID,'') <> '' then ' and ISNULL(OV2400.Ana01ID,'''') = '''+@Ana01ID+'''' else '' end +
			--case when ISNULL(@ListInventoryID,'') <> '' then ' and ISNULL(OV2400.InventoryID,'''') IN('''+@ListInventoryID+''')' else '' end +
			case when ISNULL(@ListObjectID,'') <> '' then ' and ISNULL(OV2400.ObjectID,'''') IN('''+@ListObjectID+''')' else '' end +
			CASE WHEN ISNULL(@ListAna01ID, '') NOT IN ('%', '') THEN ' AND ISNULL(OV2400.Ana01ID, '''') IN (SELECT Value FROM [dbo].StringSplit('''+ @ListAna01ID +''', '','')) ' ELSE '' END
	END
	Else	--- Khong chon nhung phieu chua giao het
	BEGIN
	Set @sSQL =  N'
	Select  OV2400.DivisionID as DivisionID,
			OV2400.OrderID as POrderID,  
			OV2400.TransactionID,
			OV2400.VoucherNo,           
			OV2400.VoucherDate as OrderDate,
			OV2400.ObjectID,
			OV2400.ObjectName,
			----OV2400.Orders,
			OV2400.OrderStatus,
			OT1101.Description as OrderStatusName,
			OV2400.InventoryID, 
			OV2400.InventoryName, 
			OV2400.UnitName,
			OV2400.Specification,
			OV2400.InventoryTypeID,
			OV2400.OrderQuantity,
			OV2400.RequestPrice,
			isnull(OV2400.RequestPrice, 0)* isnull(OV2400.ExchangeRate, 0) as ConvertedPrice,	
			OV2400.OriginalAmount as TOriginalAmount,
			OV2400.ConvertedAmount as TConvertedAmount,
			OV2400.ShipDate,
			OV2400.Ana01ID,
			OV2400.Ana01Name,
			OV0331.ActualQuantity,
			OV0331.ActualDate,
			OV0331.PurchasePrice,
			OV0331.POrderID as  ActualOrderID,
			OV0331.VoucherNo AS ActualVoucherNo,
			case when isnull(OV2400.ShipDate, '''') = '''' or isnull(OV0313.ActualDate, '''') = '''' then 0 else 
			---Datediff(day, OV2400.ShipDate, OV0331.ActualDate) end as AfterDayAmount, 
			Datediff(day, OV2400.ShipDate, OV0313.ActualDate) end as AfterDayAmount, 
			(OV2400.OrderQuantity - isnull(OV0331.ActualQuantity, 0) + isnull(OV2400.AdjustQuantity, 0)) as RemainQuantity ,
			OV0313.ActualQuantity as TActualQuantity,
			OV0313.ActualDate as TActualDate ,
			OV0331.POShipdate,OV2400.ConfirmUserID,OV2400.ConfirmDate ,OV2400.ConfirmUserName,
			OV0331.SOriginalAmount AS InventorySOriginalAmount,
			OV2400.Notes, OV2400.Notes01, OV2400.Notes02'
			
	Set @sSQL1 = @sSELECT  + N'
	From OV2700  OV2400
	left join OV0331 WITH (NOLOCK) on OV2400.TransactionID = OV0331.InheritTransactionID and OV2400.DivisionID = OV0331.DivisionID
	left join OV0313 WITH (NOLOCK) on OV0331.InventoryID = OV0313.InventoryID and OV0313.OTransactionID = OV0331.TransactionID and OV2400.DivisionID = OV0313.DivisionID
	left join OT1101 WITH (NOLOCK) on OT1101.OrderStatus = OV2400.OrderStatus and TypeID =  ''RO'' and OV2400.DivisionID = OT1101.DivisionID
					 ' + @sFROM + ' 
	Where OV2400.DivisionID '+@sWhereDivision +' and ' +   
			case when @IsDate = 1 then  ' OV2400.OrderStatus not in (  4, 9)   and 
			CONVERT(DATETIME,CONVERT(VARCHAR(10),OV2400.VoucherDate ,101),101)  BETWEEN ''' + 					
			 @FromDateText + ''' and ''' +  @ToDateText  + ''' '
			else 	' OV2400.OrderStatus not in (9,  4)   and  
			(CASE WHEN OV2400.TranMonth < 10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(OV2400.TranMonth)))+''/''+ltrim(Rtrim(str(OV2400.TranYear))) IN ('''+@PeriodList +''')' end +  
			  ' and  ISNULL(OV2400.InventoryID, '''') ' + case when @FromInventoryID = '%' then ' like ''%''	' 
			else ' between ''' + @FromInventoryID + ''' and ''' + @ToInventoryID + ''''   end +
			 ' and  ISNULL(OV2400.ObjectID, '''') '+ case when @FromObjectID = '%' then ' like ''%''' 
			else ' between ''' + @FromObjectID + ''' and ''' + @ToObjectID + ''''   end +
			case when ISNULL(@Ana01ID,'') <> '' then ' and ISNULL(OV2400.Ana01ID,'''') = '''+@Ana01ID+'''' else '' end +
			--case when (ISNULL(@ListInventoryID,'') NOT IN ('%', '')) then ' and ISNULL(OV2400.InventoryID,'''') IN('''+@ListInventoryID+''')' else '' end +
			case when (ISNULL(@ListObjectID, '') NOT IN ('%', '')) then ' and ISNULL(OV2400.ObjectID,'''') IN('''+@ListObjectID+''')' else '' end +
			CASE WHEN ISNULL(@ListAna01ID, '') NOT IN ('%', '') THEN ' AND ISNULL(OV2400.Ana01ID, '''') IN (SELECT Value FROM [dbo].StringSplit('''+ @ListAna01ID +''', '','')) ' ELSE '' END

	END
PRINT (@sSQL + @sSQL1)
	If exists (Select top 1 1 From SysObjects WITH (NOLOCK) Where name = 'OV0315' and Xtype ='V') 
		Drop view OV0315
	Exec ('Create view OV0315  --tao boi OP0303
			as '+@sSQL+@sSQL1 + @sWhereInventoryIDList)
END






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO