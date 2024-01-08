IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP3021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP3021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- in bao cao chi tiet don hang mua
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Store sử dụng trên ERP 8, 9.
-- <History>
---- Create on 30/12/2004 by Vo Thanh Huong
---- Modified on 30/01/2012 by Le Thi Thu Hien : Sua dieu kien CONVERT theo ngay
---- Modified on 07/09/2015 by Tiểu Mai: Bổ sung mã và tên 10 mã phân tích, 10 tham số.
---- Modified on 30/12/2015 by Quốc Tuấn: Bổ sung thêm Note03-Note09
---- Modified on 03/05/2017 by Bảo Thy: Bổ sung 20 quy cách
---- Modified on 31/05/2019 by Kim Thư: Bổ sung trường PriceListID - mã bảng giá, ROrderID - mã yêu cầu mua hàng
---- Modified by Khánh Đoan on 09/26/2019 Lây trường ConfirmUserID, ConfirmDate, ConfirmUserName
---- Modified on 20/05/2020 by Tuấn Anh: Bổ sung RequestID(Số phiếu yêu cầu mua hàng), ROrderDate(yêu cầu mua hàng)
---- Modified on 20/01/2021 by Nhựt Trường: Sửa lại cách lấy CustomerIndex.
---- Modified on 29/01/2021 by Kiều Nga : Chuyển đk lọc từ kỳ, đến kỳ sang chọn kỳ
---- Modified on 02/04/2021 by Nhựt Trường: Bổ sung thêm trường ContractNo.
---- Modified on 09/04/2022 by Văn Tài	  : Bổ sung fix lỗi khi truyền @ListObjectID dạng xml
---- Modified on 11/11/2022 by Anh Đô: Bổ sung fix lỗi khi truyền @ListInventoryID dạng xml và không không nhận điều kiện lọc @ListObjectID
---- Modified on 10/02/2023 by Anh Đô: Select thêm cột DiscountOriginalAmount
---- Modified on 10/02/2023 by Anh Đô: Bổ sung lọc theo danh sách Ana01ID
---- Modified on 17/02/2023 by Anh Đô: Tách @ListInventoryID ra khỏi @sSQL1 để fix lỗi tràn chuỗi
-- <Example>
---- 


CREATE PROCEDURE [dbo].[OP3021] 
				@DivisionID as nvarchar(50),
				@DivisionIDList	NVARCHAR(MAX),
				@IsDate INT, ---- 1: là ngày, 0: là kỳ
				@FromDate DATETIME,
				@ToDate DATETIME,
				@PeriodList NVARCHAR(MAX)='',
				@FromObjectID as nvarchar(50),
				@ToObjectID as nvarchar(50),
				@IsGroup as tinyint,
				@GroupID nvarchar(50), -- GroupID: OB, CI1, CI2, CI3, I01, I02, I03, I04, I05		
				@CurrencyID as nvarchar(50),
				@Ana01ID as nvarchar(50) ='',
				@ListInventoryID as nvarchar(max) ='',
				@ObjectID as nvarchar(50) ='',
				@ListObjectID as XML = NULL,
				@ListAna01ID NVARCHAR(MAX) = N''
 AS
DECLARE 	@sSQL nvarchar(4000),
			@sSQL1 nvarchar(4000),
			@GroupField nvarchar(20),
			@sFROM nvarchar(500),
			@sSELECT nvarchar(500), 
			@sListInventoryID NVARCHAR(MAX),
			@FromMonthYearText NVARCHAR(20), 
			@ToMonthYearText NVARCHAR(20), 
			@FromDateText NVARCHAR(20), 
			@ToDateText NVARCHAR(20),
			@sWhere nvarchar(max) ='',
			@sWhereDivision NVARCHAR(max),
			@sWhereListInventoryID NVARCHAR(MAX) = ''

Set @sWhereDivision = ''
    
--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
IF Isnull(@DivisionIDList, '') != ''
	SET @sWhereDivision = ' IN ('''+@DivisionIDList+''')'
ELSE 
	SET @sWhereDivision = ' = N'''+@DivisionID+''''	

DECLARE @ObjectIds VARCHAR(8000) 
CREATE TABLE #OP3021 (ObjectID VARCHAR(50))

IF @ListObjectID IS NOT NULL
BEGIN

	INSERT INTO #OP3021 (ObjectID)
	SELECT X.Data.query('D').value('.', 'NVARCHAR(50)') AS ObjectID
	FROM @ListObjectID.nodes('//Data') AS X (Data)

	
SELECT @ObjectIds = COALESCE(@ObjectIds + ''',''', '') + ObjectID 
FROM #OP3021

END


IF @ListInventoryID IS NOT NULL
BEGIN
	-- Param truyền vào dạng XML
	IF CHARINDEX('<DATA>', @ListInventoryID) > 0
	BEGIN
		DECLARE @InventoryIDTmpTable TABLE (InventoryID NVARCHAR(50))
		DECLARE @ListInventoryIDXML XML = @ListInventoryID
		INSERT INTO @InventoryIDTmpTable
		SELECT REPLACE(REPLACE(CONVERT(NVARCHAR(50), x.items.query('.')), '<D>', ''), '</D>', '') FROM @ListInventoryIDXML.nodes('/Data/*') AS x(items)
		SELECT @ListInventoryID = STUFF((SELECT ',' + o.InventoryID FROM @InventoryIDTmpTable o FOR XML PATH('')), 1, 1, '')

		SET @sWhereListInventoryID = CASE WHEN ISNULL(@ListInventoryID, '') NOT IN ('', '%') THEN ' AND OV2400.InventoryID IN (SELECT Value FROM [dbo].StringSplit(''' + @ListInventoryID + ''', '',''))' ELSE '' END
	END
	ELSE
	BEGIN
		SET @sWhereListInventoryID = CASE WHEN ISNULL(@ListInventoryID, '') NOT IN ('', '%') THEN ' AND OV2400.InventoryID IN ('''+ @ListInventoryID +''')' ELSE '' END
	END
END

DECLARE @CustomerName INT
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)	
    
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

Select @sFROM = '',  @sSELECT = ''
IF @IsGroup  = 1 
	BEGIN
	Exec AP4700  	@GroupID,	@GroupField OUTPUT
	Select @sFROM = @sFROM + ' left join AV6666 V1 on V1.SelectionType = ''' + @GroupID + ''' and V1.DivisionID = OV2400.DivisionID and V1.SelectionID = OV2400.' + @GroupField,
		@sSELECT = @sSELECT + ', 
		V1.SelectionID as GroupID, V1.SelectionName as GroupName'
				
	END
ELSE
	Set @sSELECT = @sSELECT +  ', 
		'''' as GroupID, '''' as GroupName'	

IF @CustomerName = 114  AND IsNULL(@Ana01ID,'') <> ''
BEGIN
	SET  @sFROM = @sFROM + ' Left join OOT2100 WITH(NOLOCK) on OV2400.Ana01ID = OOT2100.ProjectID'
	SET  @sWhere = @sWhere + '  and OOT2100.StatusID not in (''TTDA0003'', ''TTDA0010'',''TTDA0004'')'
END

Set @sSQL =  '
Select  OV2400.DivisionID,
		OV2400.OrderID as POrderID,  
		OV2400.VoucherNo,           
		OV2400.VoucherDate as OrderDate,
		OV2400.CurrencyID,
		OV2400.ObjectID,
		OV2400.ObjectName,
		OV2400.Orders,
		OV2400.OrderStatus,
		OV2400.Ana01ID, OV2400.Ana02ID, OV2400.Ana03ID, OV2400.Ana04ID, OV2400.Ana05ID,
		OV2400.Ana06ID, OV2400.Ana07ID, OV2400.Ana08ID, OV2400.Ana09ID, OV2400.Ana10ID,
		OV2400.AnaName01,OV2400.AnaName02,OV2400.AnaName03,OV2400.AnaName04,OV2400.AnaName05,
		OV2400.AnaName06,OV2400.AnaName07,OV2400.AnaName08,OV2400.AnaName09,OV2400.AnaName10,
		OV2400.Parameter01,OV2400.Parameter02,OV2400.Parameter03,OV2400.Parameter04,OV2400.Parameter05,
		OV2400.Parameter06,OV2400.Parameter07,OV2400.Parameter08,OV2400.Parameter09,OV2400.Parameter10, OV2400.Notes, OV2400.Notes01, OV2400.Notes02,OV2400.Notes03,
		OV2400.Notes04, OV2400.Notes05, OV2400.Notes06,OV2400.Notes07, OV2400.Notes08,	OV2400.Notes09,
		OV2400.InventoryID, 
		OV2400.InventoryName, 
		OV2400.UnitName,
		OV2400.Specification,
		OV2400.InventoryTypeID,
		OV2400.OrderQuantity,
		OV2400.PurchasePrice,
		OV2400.VATPercent,
		OV2400.VATConvertedAmount,
		OV2400.VATOriginalAmount,
		OV2400.DiscountPercent,
		isnull(OV2400.PurchasePrice, 0)* isnull(OV2400.ExchangeRate, 0) as ConvertedPrice,	
		OV2400.TotalOriginalAmount as TOriginalAmount,
		OV2400.TotalConvertedAmount as TConvertedAmount,
		ISNULL(OV2400.S01ID,'''') AS S01ID, ISNULL(OV2400.S02ID,'''') AS S02ID, ISNULL(OV2400.S03ID,'''') AS S03ID, ISNULL(OV2400.S04ID,'''') AS S04ID, 
		ISNULL(OV2400.S05ID,'''') AS S05ID, ISNULL(OV2400.S06ID,'''') AS S06ID, ISNULL(OV2400.S07ID,'''') AS S07ID, ISNULL(OV2400.S08ID,'''') AS S08ID, 
		ISNULL(OV2400.S09ID,'''') AS S09ID, ISNULL(OV2400.S10ID,'''') AS S10ID, ISNULL(OV2400.S11ID,'''') AS S11ID, ISNULL(OV2400.S12ID,'''') AS S12ID, 
		ISNULL(OV2400.S13ID,'''') AS S13ID, ISNULL(OV2400.S14ID,'''') AS S14ID, ISNULL(OV2400.S15ID,'''') AS S15ID, ISNULL(OV2400.S16ID,'''') AS S16ID, 
		ISNULL(OV2400.S17ID,'''') AS S17ID, ISNULL(OV2400.S18ID,'''') AS S18ID, ISNULL(OV2400.S19ID,'''') AS S19ID, ISNULL(OV2400.S20ID,'''') AS S20ID,
		A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
		A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
		A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
		A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
		A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20,
		OV2400.ContractNo
		' + @sSELECT  + '
		, OT3101.ROrderID, OV2400.PriceListID, OV2400.ConfirmUserID,OV2400.ConfirmDate ,OV2400.ConfirmUserName, OV2400.RequestID,OT31.OrderDate as ROrderDate
		, OV2400.DiscountOriginalAmount
From OV2400 '
SET @sSQL1 = '
LEFT JOIN AT0128 A01 WITH (NOLOCK) ON A01.DivisionID = OV2400.DivisionID AND OV2400.S01ID = A01.StandardID AND A01.StandardTypeID = ''S01''
LEFT JOIN AT0128 A02 WITH (NOLOCK) ON A02.DivisionID = OV2400.DivisionID AND OV2400.S02ID = A02.StandardID AND A02.StandardTypeID = ''S02''
LEFT JOIN AT0128 A03 WITH (NOLOCK) ON A03.DivisionID = OV2400.DivisionID AND OV2400.S03ID = A03.StandardID AND A03.StandardTypeID = ''S03''
LEFT JOIN AT0128 A04 WITH (NOLOCK) ON A04.DivisionID = OV2400.DivisionID AND OV2400.S04ID = A04.StandardID AND A04.StandardTypeID = ''S04''
LEFT JOIN AT0128 A05 WITH (NOLOCK) ON A05.DivisionID = OV2400.DivisionID AND OV2400.S05ID = A05.StandardID AND A05.StandardTypeID = ''S05''
LEFT JOIN AT0128 A06 WITH (NOLOCK) ON A06.DivisionID = OV2400.DivisionID AND OV2400.S06ID = A06.StandardID AND A06.StandardTypeID = ''S06''
LEFT JOIN AT0128 A07 WITH (NOLOCK) ON A07.DivisionID = OV2400.DivisionID AND OV2400.S07ID = A07.StandardID AND A07.StandardTypeID = ''S07''
LEFT JOIN AT0128 A08 WITH (NOLOCK) ON A08.DivisionID = OV2400.DivisionID AND OV2400.S08ID = A08.StandardID AND A08.StandardTypeID = ''S08''
LEFT JOIN AT0128 A09 WITH (NOLOCK) ON A09.DivisionID = OV2400.DivisionID AND OV2400.S09ID = A09.StandardID AND A09.StandardTypeID = ''S09''
LEFT JOIN AT0128 A10 WITH (NOLOCK) ON A10.DivisionID = OV2400.DivisionID AND OV2400.S10ID = A10.StandardID AND A10.StandardTypeID = ''S10''
LEFT JOIN AT0128 A11 WITH (NOLOCK) ON A11.DivisionID = OV2400.DivisionID AND OV2400.S11ID = A11.StandardID AND A11.StandardTypeID = ''S11''
LEFT JOIN AT0128 A12 WITH (NOLOCK) ON A12.DivisionID = OV2400.DivisionID AND OV2400.S12ID = A12.StandardID AND A12.StandardTypeID = ''S12''
LEFT JOIN AT0128 A13 WITH (NOLOCK) ON A13.DivisionID = OV2400.DivisionID AND OV2400.S13ID = A13.StandardID AND A13.StandardTypeID = ''S13''
LEFT JOIN AT0128 A14 WITH (NOLOCK) ON A14.DivisionID = OV2400.DivisionID AND OV2400.S14ID = A14.StandardID AND A14.StandardTypeID = ''S14''
LEFT JOIN AT0128 A15 WITH (NOLOCK) ON A15.DivisionID = OV2400.DivisionID AND OV2400.S15ID = A15.StandardID AND A15.StandardTypeID = ''S15''
LEFT JOIN AT0128 A16 WITH (NOLOCK) ON A16.DivisionID = OV2400.DivisionID AND OV2400.S16ID = A16.StandardID AND A16.StandardTypeID = ''S16''
LEFT JOIN AT0128 A17 WITH (NOLOCK) ON A17.DivisionID = OV2400.DivisionID AND OV2400.S17ID = A17.StandardID AND A17.StandardTypeID = ''S17''
LEFT JOIN AT0128 A18 WITH (NOLOCK) ON A18.DivisionID = OV2400.DivisionID AND OV2400.S18ID = A18.StandardID AND A18.StandardTypeID = ''S18''
LEFT JOIN AT0128 A19 WITH (NOLOCK) ON A19.DivisionID = OV2400.DivisionID AND OV2400.S19ID = A19.StandardID AND A19.StandardTypeID = ''S19''
LEFT JOIN AT0128 A20 WITH (NOLOCK) ON A20.DivisionID = OV2400.DivisionID AND OV2400.S20ID = A20.StandardID AND A20.StandardTypeID = ''S20''
LEFT JOIN OT3102 WITH (NOLOCK) ON OT3102.TransactionID = OV2400.RefTransactionID
LEFT JOIN OT3101 WITH (NOLOCK) ON OT3101.ROrderID = OT3102.ROrderID
LEFT JOIN OT3101 OT31 WITH(NOLOCK) ON OT31.DivisionID = OV2400.DivisionID AND OT31.ROrderID = OV2400.RequestID
' + @sFROM + '
Where OV2400.DivisionID '+@sWhereDivision +
		 case when IsNULL(@FromObjectID,'') <> '' OR IsNULL(@ToObjectID,'') <> '' then ' AND OV2400.ObjectID between N''' + @FromObjectID + ''' and N''' + @ToObjectID + '''' else '' end + 
		 case when @IsDate = 1 then ' AND CONVERT(DATETIME,CONVERT(VARCHAR(10),VoucherDate,101),101) between ''' +  @FromDateText + ''' and ''' +  @ToDateText  + ''''
		 else ' AND (CASE WHEN OV2400.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(OV2400.TranMonth)))+''/''+ltrim(Rtrim(str(OV2400.TranYear))) in ('''+@PeriodList +''')'  end  + 
		 case when IsNULL(@CurrencyID,'') <> '' then ' AND OV2400.CurrencyID like ''' + @CurrencyID + '''' else '' end +
	     case when IsNULL(@Ana01ID,'') <> '' AND IsNULL(@Ana01ID,'') <> '%' then ' AND OV2400.Ana01ID =''' + @Ana01ID + '''' else '' end +
		 --case when IsNULL(@ListInventoryID,'') <> '' then @sListInventoryID else '' end +
		 case when IsNULL(@ObjectID,'') <> '' then ' AND OV2400.ObjectID  IN (SELECT Value FROM [dbo].StringSplit(''' + @ObjectID + ''', '',''))' else '' end +
		 case when ISNULL(@ObjectIds, '') <> '' then ' AND OV2400.ObjectID IN (''' + @ObjectIds + ''') ' else '' end +
	     CASE WHEN ISNULL(@ListAna01ID, '') NOT IN ('', '%') THEN ' AND OV2400.Ana01ID IN (SELECT Value FROM [dbo].StringSplit('''+ @ListAna01ID +''', '','')) ' ELSE '' END 
		 + @sWhere

PRINT(@sSQL)
PRINT(@sSQL1)
	
If exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name = 'OV3021')
	Drop view OV3021
EXEC('Create view OV3021---tao boi OP3021
		as ' + @sSQL +@sSQL1 + @sWhereListInventoryID)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
