IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP3063]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP3063]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






---Created by: Vo Thanh Huong, date:  15/03/2006
---Purpose: In bao cao Tong hop Don hang mua
----Last Update Nguyen Thi ThuyTuyen: 21/11/2006 (Sua lai tu ky den ky)
---- Modified on 31/01/2012 by Le Thi Thu Hien : Sua dieu kien CONVERT theo ngay
---- Modified on 07/02/2013 by Le Thi Thu Hien : WHERE thêm DivisionID khi lấy SUM tiền
---- Modified on 08/09/2015 by Tiểu Mai: bổ sung lấy tên và mã của 10 MPT
---- Modified by Hải Long on 22/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Đình Ly on 17/08/2020: Bổ sung param @ListObjectID 
---- Modified on 29/01/2021 by Kiều Nga : Chuyển đk lọc từ kỳ, đến kỳ sang chọn kỳ
---- Modified on 01/10/2021 by Nhật Thanh : thêm trường điều kiện thanh toán vào báo cáo để kiểm tra thời hạn thanh toán
---- Modified on 16/11/2022 by Anh Đô : Fix lỗi không có dữ liệu khi chọn Tất cả ở ô Nhà cung cấp
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE [dbo].[OP3063] 
				@DivisionID nvarchar(50),
				@DivisionIDList	NVARCHAR(MAX),
				@IsDate INT, ---- 1: là ngày, 0: là kỳ
				@FromDate DATETIME,
				@ToDate DATETIME,
				@PeriodList NVARCHAR(MAX)='',
				@FromObject nvarchar(20),
				@ToObject nvarchar(20),
				@OrderStatus int,
				@ListObjectID as nvarchar(max) =''
AS
DECLARE @sSQL nvarchar(4000),
		@sSQL1 NVARCHAR(4000),
		@sPeriod nvarchar(4000), 
		@FromMonthYearText NVARCHAR(20), 
		@ToMonthYearText NVARCHAR(20), 
		@FromDateText NVARCHAR(20), 
		@ToDateText NVARCHAR(20),
		@sWhereDivision NVARCHAR(max)

Set @sWhereDivision = ''
    
--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
IF Isnull(@DivisionIDList, '') != ''
	SET @sWhereDivision = ' IN ('''+@DivisionIDList+''')'
ELSE 
	SET @sWhereDivision = ' = N'''+@DivisionID+''''	
    
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

Set @sPeriod = case when @IsDate = 1 then ' and CONVERT(DATETIME,CONVERT(VARCHAR(10),OT3001.OrderDate,101),101) BETWEEN ''' + @FromDateText + '''  and  ''' + 
		@ToDateText + ''''   else 
		' AND (CASE WHEN OT3001.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(OT3001.TranMonth)))+''/''+ltrim(Rtrim(str(OT3001.TranYear))) in ('''+@PeriodList +''')'  end

IF @ListObjectID = N'%'
	SET @ListObjectID = N''

Set @sSQL = '
Select 	OT3001.DivisionID, 	
		OT3001.POrderID, 
		OT3001.VoucherTypeID, 
		OT3001.VoucherNo, 
		OT3001.ClassifyID, 
		OT3001.InventoryTypeID, 
		OT3001.CurrencyID, 
		AT1004.CurrencyName,
		OT3001.ExchangeRate, 
		OT3001.OrderType, 
		OT3001.ObjectID, 
		case when isnull(OT3001.ObjectName, '''') <> '''' then OT3001.ObjectName else AT1202.ObjectName end as ObjectName,
		case when isnull(OT3001.VatNo, '''') <> '''' then OT3001.VATNo else  AT1202.VATNo end as VATNo,
		case when isnull(OT3001.Address, '''') <> '''' then OT3001.Address else AT1202.Address end as Address,
		OT3001.ReceivedAddress, 
		OT3001.Notes, 
		OT3001.Description, 
		OT3001.Disabled, 
		OT3001.OrderStatus, 
		OV1001.Description as OrderStatusName,
		OV1001.EDescription as EOrderStatusName,
		AT0099.Description as OrderStatusName99,
		OT3002.Ana01ID, 
		OT3002.Ana02ID, 
		OT3002.Ana03ID, 
		OT3002.Ana04ID, 
		OT3002.Ana05ID, 
		OT3002.Ana06ID,
		OT3002.Ana07ID, 
		OT3002.Ana08ID, 
		OT3002.Ana09ID,
		OT3002.Ana10ID,
		A01.AnaName as Ana01Name,
		A02.AnaName as Ana02Name,
		A03.AnaName as Ana03Name,
		A04.AnaName as Ana04Name,
		A05.AnaName as Ana05Name,
		A06.AnaName as Ana06Name,
		A07.AnaName as Ana07Name,
		A08.AnaName as Ana08Name,
		A09.AnaName as Ana09Name,
		A10.AnaName as Ana10Name,
		OT3001.TranMonth, 
		OT3001.TranYear, 		
		OT3001.EmployeeID, 
		AT1103.FullName,
		OT3001.OrderDate, 
		OT3001.Transport, 
		OT3001.PaymentID, 
		OT3001.ShipDate, 
		OT3001.ContractNo, 
		OT3001.ContractDate, 
		OT3001.PaymentTermID,
		OT3001.CreateUserID, 
		OT3001.Createdate, 
		OT3001.LastModifyUserID, 
		OT3001.LastModifyDate, 
		OT3001.DueDate,
		OriginalAmount = (Select sum(isnull(OriginalAmount, 0)) From OT3002 Where OT3002.POrderID = OT3001.POrderID AND OT3002.DivisionID '+@sWhereDivision+'),
		ConvertedAmount = (Select sum(isnull(ConvertedAmount, 0)) From OT3002 Where OT3002.POrderID = OT3001.POrderID AND OT3002.DivisionID '+@sWhereDivision+'),
		VATOriginalAmount = (Select sum(isnull(VATOriginalAmount, 0)) From OT3002 Where OT3002.POrderID = OT3001.POrderID AND OT3002.DivisionID '+@sWhereDivision+'),
		VATConvertedAmount = (Select sum(isnull(VATConvertedAmount, 0)) From OT3002 Where OT3002.POrderID = OT3001.POrderID AND OT3002.DivisionID '+@sWhereDivision+'),
		DiscountOriginalAmount = (Select sum(isnull(DiscountOriginalAmount, 0)) From OT3002 Where OT3002.POrderID = OT3001.POrderID AND OT3002.DivisionID '+@sWhereDivision+'),
		DiscountConvertedAmount = (Select sum(isnull(DiscountConvertedAmount, 0)) From OT3002 Where OT3002.POrderID = OT3001.POrderID AND OT3002.DivisionID '+@sWhereDivision+')'
		
 

SET @sSQL1 = 'FROM OT3001 
LEFT JOIN (select OT3002.Ana01ID, OT3002.Ana02ID, OT3002.Ana03ID, OT3002.Ana04ID, OT3002.Ana05ID, OT3002.Ana06ID, OT3002.Ana07ID, OT3002.Ana08ID, OT3002.Ana09ID, OT3002.Ana10ID, OT3002.POrderID, OT3002.DivisionID 
           FROM OT3002 where OT3002.DivisionID '+@sWhereDivision+' and OT3002.Orders = 1 ) OT3002 on OT3002.POrderID = OT3001.POrderID and OT3002.DivisionID = OT3001.DivisionID
left join AT1011 A01 on A01.AnaTypeID = ''A01'' and A01.AnaID = OT3002.Ana01ID
left join AT1011 A02 on A02.AnaTypeID = ''A02'' and A02.AnaID = OT3002.Ana02ID
left join AT1011 A03 on A03.AnaTypeID = ''A03'' and A03.AnaID = OT3002.Ana03ID
left join AT1011 A04 on A04.AnaTypeID = ''A04'' and A04.AnaID = OT3002.Ana04ID
left join AT1011 A05 on A05.AnaTypeID = ''A05'' and A05.AnaID = OT3002.Ana05ID
left join AT1011 A06 on A06.AnaTypeID = ''A06'' and A06.AnaID = OT3002.Ana06ID
left join AT1011 A07 on A07.AnaTypeID = ''A07'' and A07.AnaID = OT3002.Ana07ID
left join AT1011 A08 on A08.AnaTypeID = ''A08'' and A08.AnaID = OT3002.Ana08ID
left join AT1011 A09 on A09.AnaTypeID = ''A09'' and A09.AnaID = OT3002.Ana09ID
left join AT1011 A10 on A10.AnaTypeID = ''A10'' and A10.AnaID = OT3002.Ana10ID
LEFT JOIN OV1001            on OV1001.DivisionID    = OT3001.DivisionID and OV1001.OrderStatus = OT3001.OrderStatus and OV1001.TypeID =''PO''
LEFT JOIN AT1202            on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT3001.ObjectID
LEFT JOIN AT1103            on AT1103.FullName = OT3001.EmployeeID 
LEFT JOIN AT1004            on AT1004.CurrencyID = OT3001.CurrencyID 
Left join AT0099 With (NOLOCK) on Convert(varchar, OT3001.OrderStatus) = AT0099.ID and AT0099.CodeMaster = ''AT00000003''
Where	OT3001.DivisionID '+@sWhereDivision+' and' +
		case when IsNULL(@FromObject,'') <> '' and IsNULL(@ToObject,'') <> '' then ' OT3001.ObjectID between ''' + @FromObject + ''' and ''' + @ToObject + ''' and ' else '' end +
		' OT3001.OrderStatus like ' + case when @OrderStatus = - 1 then '''%''' else cast(@OrderStatus as nvarchar(1))  end + 
		case when IsNULL(@ListObjectID,'') <> '' then ' AND OT3001.ObjectID IN (''' + @ListObjectID + ''')' else '' end + @sPeriod 

		print @sSQL 
		print @sSQL1

IF EXISTS(SELECT TOP 1 1 FROM SYSOBJECTS WHERE XType = 'V' and Name = 'OV3063')
	DROP VIEW OV3063

EXEC('CREATE VIEW OV3063 --tao boi OP3063
		as ' + @sSQL + @sSQL1)
--PRINT  (@sSQL + @sSQL1)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
