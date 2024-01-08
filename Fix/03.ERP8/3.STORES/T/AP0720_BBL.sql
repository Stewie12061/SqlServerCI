IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0720_BBL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0720_BBL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--Edited by Nguyen Quoc Huy, Date 06/11/2006
--Edited by B.Anh, Date 10/12/2007 -> Lay them truong VoucherTypeID
--Edit by: Dang Le Bao Quynh; 09/06/2008
--Purpose: Them truong he so quy doi
--Edit by: Dang Le Bao Quynh; 04/07/2008
--Purpose: Bo sung them ma phan tich 1 cua doi tuong
--Edited by Dang le Bao Quynh; Date 13/08/2008
--Purpose: Them ma cac ma phan tich cua doi tuong, ma phan loai doi tuong, ma phan tich mat hang, ma phan loai mat hang
--Edited by Dang le Bao Quynh; Date 17/09/2009
--Purpose: Them truong nhom thue VAT va thue suat vào View AV0720
---- Modified on 24/10/2012 by Lê Thị Thu Hiền : Bổ sung 1 số trường (0019183 )
---- Modified on 26/07/2013 by Lê Thị Thu Hiền : Chỉnh sửa không lấy dữ liệu theo AV7000 mà lấy bằng store , Bổ sung WHERE IsTempt = 0 (0020249) Kho Tạm không lấy
---- Modify on 06/01/2014 by My Tuyen: customize bao cao cho VIMEC : bo sung them truong AV7008.LimitDate, AV7008.RevoucherDate, AV7008.WareHouseID, AV7008.WarehouseName, AT9000.VoucherNo  as BHVoucherNo, AT9000.VoucherDate as BHVoucherDate, AT9000.TDescription
---- Modify on 27/06/2014 by My Tuyen: customize bao cao cho VIMEC : bo sung them truong AT9000.InvoiceNo, ten Ana01 trong AT9000
---- Modified on 15/07/2014 by Thanh Sơn: Lấy dữ liệu trực tiếp từ store (không sinh ra view AV0720)
---- Modified on 12/10/2015 by Tieu Mai: fix lỗi đúp dòng.
---- Modified on 30/11/2015 by Bảo Anh: Dùng lại view AV7000 để lấy số dư đầu (Không dùng AV7008 vì chỉ lấy được dữ liệu phát sinh)
---- Modified by Bảo Thy on 26/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Hoàng vũ on 30/05/2016: Sửa báo cáo có group nhưng không sum số lượng nợ/có và thành tiền nợ/có.
---- Modified by Bảo Anh on 14/04/2017: Cải tiến tốc độ (dùng bảng tạm thay view)
---- Modified by Bảo Thy on 26/04/2017: Bổ sung in báo cáo khi quản lý theo quy cách
---- Modified by Bảo Thy on 08/05/2017: Sửa danh mục dùng chung
---- Modified by Tiểu Mai on 29/05/2017: Bổ sung điều kiện join với AT9000
---- Modified by Bảo Thy on 06/09/2017: cho hiển thị thêm những mặt hàng có tồn đầu kỳ nhưng ko phát sinh nhập xuất trong kỳ (EIMSKIP)
---- Modified by Bảo Anh on 04/01/2018: Bổ sung Ana04ID, Ana04Name (Ba Son)
---- Modified by Bảo Thy on 08/03/2018: Fix lỗi "correlation name 'A04' is specified multiple times"
---- Modified by Bảo Anh on 05/04/2018: Bổ sung RDAddress
---- Modified by Kim Thư on 30/11/2018: Bổ sung case when @CustomerName = 84 - bason để tránh cho Ana04ID và  Ana04Name làm double dòng dữ liệu của KH khác,
----									Bỏ group by AV7008.ActualQuantity,AV7008.ConvertedAmount, ở @sqlGroupBy3
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Nhựt Trường on 05/04/2022: Điều chỉnh lại cách lấy dữ liệu:
--																			_ Store cũ đang sai do lấy dữ liệu tồn kho theo điều kiện thời gian được truyền vào (Store AP7000).
--																			_ Điều chỉnh lấy số dư theo điều kiện từ thời điểm hiện tại trở về trước.
---- Modified by Nhật Thanh on 22/02/2023: Bổ sung lấy mã tham chiếu từ bảng mặt hàng
---- Modified by Đức Duy on 21/03/2023: Cải tiến tốc độ (không lấy dữ liệu theo AV7000 mà lấy bằng store AP9024)
---- Modified by Đình Định on 26/04/2023: THIENNAM - Lấy lên các cột AnaID khi in báo cáo nhập xuất tồn theo đối tượng AR0720.
---- Modified by Đình Định on 01/06/2023: THIENNAM - Bổ sung VoucherDate vào bảng tạm khi in theo ngày.
---- Modified by Đình Định on 11/08/2023: BBL - Mẫu AR0720: Lấy lên thẻ BeginConvertedQuantity, DebitConvertedQuantity, CreditConvertedQuantity, EndConvertedQuantity, ConvertedUnitID.
---- Modified by Nhựt Trường on 16/08/2023: Fix lỗi thiếu Group By trường VoucherDate.
---- Modified by Thành Sang on 22/08/2023: Bổ sung điều kiện từ kho đến kho.
---- Modified by Xuân Nguyên on 24/08/2023:BBL - Bổ sung điều kiện SourceNo khi join AV0729
---- Modified by Xuân Nguyên on 29/08/2023: Bổ sung cột SParameter01,SParameter02,SParameter03
---- Modified by Xuân Nguyên on 26/09/2023: Bổ sung sum cột BeginQuantity, BeginConvertedQuantity,BeginAmount
---- Modified by Xuân Nguyên on 09/10/2023: Bổ sung Ana01ID -> Ana10ID và sum các cột ConvertedQuantity,DebitConvertedQuantity,CreditConvertedQuantity
---- Modified on 23/10/2023 by Thanh Sang : Lấy lên thẻ MarkQuantity
---- Modified on 22/12/2023 by Kiều Nga : [2023/12/IS/0259] Fix lỗi In báo cáo bị double dòng
-- <Example>
---- EXEC AP0720_BBL 'AS', '','','','','', 1,2011,1,2012, '','', 1

CREATE PROCEDURE [dbo].[AP0720_BBL] 		
			@DivisionID as nvarchar(50),					
			@FromWareHouseID  as nvarchar(50),	
			@ToWareHouseID  as nvarchar(50),					
			@FromObjectID  as nvarchar(50),
			@ToObjectID as nvarchar(50),
			@FromInventoryID as nvarchar(50),
			@ToInventoryID as nvarchar(50),
			@FromMonth as int,
			@FromYear as int,
			@ToMonth as int,
			@ToYear as int,
			@FromDate as Datetime,
			@ToDate as Datetime,
			@IsDate as tinyint,
			@FromAna01ID nvarchar(50) = Null, @ToAna01ID nvarchar(50) = Null,
			@FromAna02ID nvarchar(50) = Null, @ToAna02ID nvarchar(50) = Null,
			@FromAna03ID nvarchar(50) = Null, @ToAna03ID nvarchar(50) = Null,
			@FromAna04ID nvarchar(50) = Null, @ToAna04ID nvarchar(50) = Null,
			@FromAna05ID nvarchar(50) = Null, @ToAna05ID nvarchar(50) = Null,
			@FromAna06ID nvarchar(50) = Null, @ToAna06ID nvarchar(50) = Null,
			@FromAna07ID nvarchar(50) = Null, @ToAna07ID nvarchar(50) = Null,
			@FromAna08ID nvarchar(50) = Null, @ToAna08ID nvarchar(50) = Null,
			@FromAna09ID nvarchar(50) = Null, @ToAna09ID nvarchar(50) = Null,
			@FromAna10ID nvarchar(50) = Null, @ToAna10ID nvarchar(50) = Null
AS
DECLARE 
--@sSQL as nvarchar(4000),
	@sqlSelect1 as varchar(MAX),
    @sqlFrom1 as varchar(MAX),
    @sqlWhere1 as varchar(MAX),
    @sqlGroupBy1 as varchar(MAX),
	@sqlSelect2 as varchar(MAX),
    @sqlFrom2 as varchar(MAX),
    @sqlWhere2 as varchar(MAX),
    @sqlGroupBy2 as varchar(MAX),
	@sqlSelect3 as varchar(MAX),
    @sqlFrom3 as varchar(MAX),
    @sqlWhere3 as varchar(MAX),
    @sqlGroupBy3 as varchar(MAX),
	@strTimePS as nvarchar(4000),
	@strTimeSD as nvarchar(4000),
	@AnaWhere as nvarchar(MAX), 
    @FromMonthYearText NVARCHAR(20), 
    @ToMonthYearText NVARCHAR(20), 
    @FromDateText NVARCHAR(20), 
    @ToDateText NVARCHAR(20),
    @WareHouseWhere NVARCHAR(250),
	@sqlSelectUnion as nvarchar(MAX)='',
	@sqlWhereUnion as nvarchar(MAX)='',
	@CustomerName INT,
	@sqlSelect3a VARCHAR(MAX) = '',
	@sqlGroupBy3a VARCHAR(MAX) = '',
	@sqlFrom3a VARCHAR(MAX) = '',
	@sqlSelect2a as varchar(MAX),
    @sqlFrom2a as varchar(MAX),
    @sqlWhere2a as varchar(MAX),
    @sqlGroupBy2a as varchar(MAX)
  
--Tao bang tam kiem tra khach hang SaigonPetro (CustomerName = 36)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName) 

SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

SET @AnaWhere = ''
SET @WareHouseWhere = ''

--------->>>> Lấy dữ liệu Hàng tồn kho
DECLARE @IsTime AS TINYINT
IF @IsDate = 0 SET @IsTime = 1
IF @IsDate = 1	SET @IsTime = 2

-- Tao bang tam 
CREATE TABLE #Tempt 
			(	DivisionID NVARCHAR(50), TranMonth INT, TranYear INT, 
				WareHouseID NVARCHAR(50), InventoryID NVARCHAR(50), D_C NVARCHAR(50),
				ObjectID NVARCHAR(50),  InventoryName NVARCHAR(MAX),
				RefInventoryID NVARCHAR(50), UnitID NVARCHAR(50), UnitName NVARCHAR(50), 
				WareHouseName NVARCHAR(250), SignQuantity DECIMAL(28, 8), SignAmount DECIMAL(28, 8),
				S1 NVARCHAR(50), S2 NVARCHAR(50), S3 NVARCHAR(50), 
				I01ID NVARCHAR(50), I02ID NVARCHAR(50), I03ID NVARCHAR(50), 
				I04ID NVARCHAR(50), I05ID NVARCHAR(50), Specification NVARCHAR(max) ,
				Notes01 NVARCHAR(250),  Notes02 NVARCHAR(250), 
				Notes03 NVARCHAR(250),  IsTemp TINYINT,
				Ana01ID NVARCHAR(50), Ana02ID NVARCHAR(50), Ana03ID NVARCHAR(50), Ana04ID NVARCHAR(50), Ana05ID NVARCHAR(50),
				Ana06ID NVARCHAR(50), Ana07ID NVARCHAR(50), Ana08ID NVARCHAR(50), Ana09ID NVARCHAR(50), Ana10ID NVARCHAR(50),
				VoucherDate DATETIME, ConvertedQuantity  DECIMAL(28,8), MarkQuantity DECIMAL(28,8), DebitConvertedQuantity  DECIMAL(28,8), CreditConvertedQuantity  DECIMAL(28,8)
				,SourceNo NVARCHAR(MAX),SParameter01 NVARCHAR(250),SParameter02 NVARCHAR(250),SParameter03 NVARCHAR(250)
			)

INSERT INTO #Tempt

EXEC AP9024_BBL @DivisionID, 'ASOFTADMIN', @FromWareHouseID, @ToWareHouseID, @FromInventoryID, @ToInventoryID, @FromObjectID, @ToObjectID, @IsTime, '', '', '', '', '', ''

EXEC AP7000 @DivisionID , 'ASOFTADMIN', @FromWareHouseID, @ToWareHouseID, @FromInventoryID, @ToInventoryID, @FromObjectID, @ToObjectID,
			@IsTime, '', '', '', '', '', ''


--SELECT * FROM #Tempt
-------- Trả ra AV7008
-------- Thay thế cho AV7000
---------<<<< Lấy dữ liệu Hàng tồn kho

	If Patindex('[%]',@FromAna01ID) > 0
		Begin
			Set @AnaWhere = @AnaWhere + N' And AV7008.Ana01ID Like N''' + @FromAna01ID + ''''
		End
	Else
		If @FromAna01ID is not null  And  @FromAna01ID <>''
			Begin
				Set @AnaWhere = @AnaWhere + N' And Isnull(AV7008.Ana01ID,'''') >= N''' + Replace(@FromAna01ID,'[]','') + ''' And Isnull(AV7008.Ana01ID,'''') <= N''' + Replace(@ToAna01ID,'[]','') + ''''
			End	

	If Patindex('[%]',@FromAna02ID) > 0
		Begin
			Set @AnaWhere = @AnaWhere + N' And AV7008.Ana02ID Like N''' + @FromAna02ID + ''''
		End
	Else
		If @FromAna02ID is not null  And @FromAna02ID <>''
			Begin
				Set @AnaWhere = @AnaWhere + N' And Isnull(AV7008.Ana02ID,'''') >= N''' + Replace(@FromAna02ID,'[]','') + ''' And Isnull(AV7008.Ana02ID,'''') <= N''' + Replace(@ToAna02ID,'[]','') + ''''
			End	

	If Patindex('[%]',@FromAna03ID) > 0
		Begin
			Set @AnaWhere = @AnaWhere + N' And AV7008.Ana03ID Like N''' + @FromAna03ID + ''''
		End
	Else
		If @FromAna03ID is not null  And @FromAna03ID <>''
			Begin
				Set @AnaWhere = @AnaWhere + N' And Isnull(AV7008.Ana03ID,'''') >= N''' + Replace(@FromAna03ID,'[]','') + ''' And Isnull(AV7008.Ana03ID,'''') <= N''' + Replace(@ToAna03ID,'[]','') + ''''
			End	

	If Patindex('[%]',@FromAna04ID) > 0
		Begin
			Set @AnaWhere = @AnaWhere + N' And AV7008.Ana04ID Like N''' + @FromAna04ID + ''''
		End
	Else 
		If @FromAna04ID is not null  And @FromAna04ID <>''
			Begin
				Set @AnaWhere = @AnaWhere + N' And Isnull(AV7008.Ana04ID,'''') >= N''' + Replace(@FromAna04ID,'[]','') + ''' And Isnull(AV7008.Ana04ID,'''') <= N''' + Replace(@ToAna04ID,'[]','') + ''''
			End	

	If Patindex('[%]',@FromAna05ID) > 0
		Begin
			Set @AnaWhere = @AnaWhere + N' And AV7008.Ana05ID Like N''' + @FromAna05ID + ''''
		End
	Else
		If @FromAna05ID is not null  And @FromAna05ID <>''
			Begin
				Set @AnaWhere = @AnaWhere + N' And Isnull(AV7008.Ana05ID,'''') >= N''' + Replace(@FromAna05ID,'[]','') + ''' And Isnull(AV7008.Ana05ID,'''') <= N''' + Replace(@ToAna05ID,'[]','') + ''''
			End
			
	If Patindex('[%]',@FromAna06ID) > 0
		Begin
			Set @AnaWhere = @AnaWhere + N' And AV7008.Ana06ID Like N''' + @FromAna06ID + ''''
		End
	Else
		If @FromAna06ID is not null  And  @FromAna06ID <>''
			Begin
				Set @AnaWhere = @AnaWhere + N' And Isnull(AV7008.Ana06ID,'''') >= N''' + Replace(@FromAna06ID,'[]','') + ''' And Isnull(AV7008.Ana06ID,'''') <= N''' + Replace(@ToAna06ID,'[]','') + ''''
			End	

	If Patindex('[%]',@FromAna07ID) > 0
		Begin
			Set @AnaWhere = @AnaWhere + N' And AV7008.Ana07ID Like N''' + @FromAna07ID + ''''
		End
	Else
		If @FromAna07ID is not null  And @FromAna07ID <>''
			Begin
				Set @AnaWhere = @AnaWhere + N' And Isnull(AV7008.Ana07ID,'''') >= N''' + Replace(@FromAna07ID,'[]','') + ''' And Isnull(AV7008.Ana07ID,'''') <= N''' + Replace(@ToAna07ID,'[]','') + ''''
			End	

	If Patindex('[%]',@FromAna08ID) > 0
		Begin
			Set @AnaWhere = @AnaWhere + N' And AV7008.Ana08ID Like N''' + @FromAna08ID + ''''
		End
	Else
		If @FromAna08ID is not null  And @FromAna08ID <>''
			Begin
				Set @AnaWhere = @AnaWhere + N' And Isnull(AV7008.Ana08ID,'''') >= N''' + Replace(@FromAna08ID,'[]','') + ''' And Isnull(AV7008.Ana08ID,'''') <= N''' + Replace(@ToAna08ID,'[]','') + ''''
			End	

	If Patindex('[%]',@FromAna09ID) > 0
		Begin
			Set @AnaWhere = @AnaWhere + N' And AV7008.Ana09ID Like N''' + @FromAna09ID + ''''
		End
	Else 
		If @FromAna09ID is not null  And @FromAna09ID <>''
			Begin
				Set @AnaWhere = @AnaWhere + N' And Isnull(AV7008.Ana09ID,'''') >= N''' + Replace(@FromAna09ID,'[]','') + ''' And Isnull(AV7008.Ana09ID,'''') <= N''' + Replace(@ToAna09ID,'[]','') + ''''
			End	

	If Patindex('[%]',@FromAna10ID) > 0
		Begin
			Set @AnaWhere = @AnaWhere + N' And AV7008.Ana10ID Like N''' + @FromAna10ID + ''''
		End
	Else
		If @FromAna10ID is not null  And @FromAna10ID <>''
			Begin
				Set @AnaWhere = @AnaWhere + N' And Isnull(AV7008.Ana10ID,'''') >= N''' + Replace(@FromAna10ID,'[]','') + ''' And Isnull(AV7008.Ana10ID,'''') <= N''' + Replace(@ToAna10ID,'[]','') + ''''
			End

IF @IsDate = 1    ---- xac dinh so lieu theo ngay
	SET @strTimeSD = N' AND ( D_C = ''BD'' OR AV7008.VoucherDate < ''' + @FromDateText + N''') ' 
ELSE 				 	
	SET @strTimeSD = N' AND ( D_C = ''BD'' OR AV7008.TranMonth + 100 * TranYear < ' + @FromMonthYearText + N' ) ' 

SET @sqlSelect1 = N'
---- Lấy số dư
SELECT 	AV7008.DivisionID, AV7008.WareHouseID, AV7008.WareHouseName ,AV7008.ObjectID, AV7008.InventoryID, AV7008.InventoryName, AV7008.RefInventoryID,
        AV7008.UnitID, AV7008.S1, AV7008.S2, AV7008.S3, AV7008.I01ID, AV7008.I02ID, AV7008.I03ID, AV7008.I04ID, AV7008.I05ID, AV7008.UnitName,
        AV7008.Specification ,	max(AV7008.Notes01) as Notes01, max(AV7008.Notes02) as Notes02, max(AV7008.Notes03) as Notes03,
        sum(isnull(SignQuantity,0)) AS BeginQuantity, 
		sum(isnull(SignAmount,0)) AS BeginAmount, 
		 AV7008.VoucherDate,
		AV7008.ConvertedQuantity,
		AV7008.MarkQuantity,
		ISNULL(AV7008.DebitConvertedQuantity, 0) AS DebitConvertedQuantity,
		ISNULL(AV7008.CreditConvertedQuantity, 0) AS CreditConvertedQuantity,AV7008.SourceNo,AV7008.SParameter01,AV7008.SParameter02,AV7008.SParameter03
		,AV7008.Ana01ID,AV7008.Ana02ID,AV7008.Ana03ID,AV7008.Ana04ID,AV7008.Ana05ID,AV7008.Ana06ID,AV7008.Ana07ID,AV7008.Ana08ID,AV7008.Ana09ID,AV7008.Ana10ID' 

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
SET @sqlSelect1 = @sqlSelect1 + ',
	ISNULL(AV7008.S01ID,'''') AS S01ID, ISNULL(AV7008.S02ID,'''') AS S02ID, ISNULL(AV7008.S03ID,'''') AS S03ID, ISNULL(AV7008.S04ID,'''') AS S04ID, 
	ISNULL(AV7008.S05ID,'''') AS S05ID, ISNULL(AV7008.S06ID,'''') AS S06ID, ISNULL(AV7008.S07ID,'''') AS S07ID, ISNULL(AV7008.S08ID,'''') AS S08ID, 
	ISNULL(AV7008.S09ID,'''') AS S09ID, ISNULL(AV7008.S10ID,'''') AS S10ID, ISNULL(AV7008.S11ID,'''') AS S11ID, ISNULL(AV7008.S12ID,'''') AS S12ID, 
	ISNULL(AV7008.S13ID,'''') AS S13ID, ISNULL(AV7008.S14ID,'''') AS S14ID, ISNULL(AV7008.S15ID,'''') AS S15ID, ISNULL(AV7008.S16ID,'''') AS S16ID, 
	ISNULL(AV7008.S17ID,'''') AS S17ID, ISNULL(AV7008.S18ID,'''') AS S18ID, ISNULL(AV7008.S19ID,'''') AS S19ID, ISNULL(AV7008.S20ID,'''') AS S20ID
'

SET @sqlFrom1 = N'
	INTO #AV0728
	FROM #Tempt AV7008  '

SET @sqlWhere1 = N'
WHERE 	'+@WareHouseWhere+'
		AV7008.DivisionID like N'''+@DivisionID+N''' and
		D_C IN (''D'',''C'', ''BD'' ) and
		(AV7008.InventoryID between N'''+@FromInventoryID+N''' and N'''+@ToInventoryID+N''') and
		(AV7008.WareHouseID between N'''+@FromWareHouseID+N''' and N'''+@ToWareHouseID+N''') and
		(AV7008.ObjectID between  N'''+@FromObjectID+N''' and  N'''+@ToObjectID+N''')  ' + @AnaWhere + N' ' 

SET @sqlWhere1 = @sqlWhere1 + @strTimeSD+' '

SET @sqlGroupBy1 = N' 
GROUP BY AV7008.DivisionID, AV7008.WareHouseID, AV7008.WareHouseName,AV7008.SourceNo,AV7008.SParameter01,AV7008.SParameter02,AV7008.SParameter03,
		 AV7008.ObjectID, AV7008.InventoryID, AV7008.InventoryName,AV7008.RefInventoryID, AV7008.UnitID,
		 AV7008.S1, AV7008.S2, AV7008.S3, 	 
		 AV7008.I01ID, AV7008.I02ID, AV7008.I03ID, AV7008.I04ID, AV7008.I05ID, 
		 AV7008.UnitName, AV7008.Specification, AV7008.VoucherDate,
		 AV7008.ConvertedQuantity,
		 AV7008.MarkQuantity,
		 AV7008.DebitConvertedQuantity,
		 AV7008.CreditConvertedQuantity,AV7008.Ana01ID,AV7008.Ana02ID,AV7008.Ana03ID,AV7008.Ana04ID,AV7008.Ana05ID,AV7008.Ana06ID,AV7008.Ana07ID,AV7008.Ana08ID,AV7008.Ana09ID,AV7008.Ana10ID' 

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
SET @sqlGroupBy1 = @sqlGroupBy1 + ',
		ISNULL(AV7008.S01ID,''''), ISNULL(AV7008.S02ID,''''), ISNULL(AV7008.S03ID,''''), ISNULL(AV7008.S04ID,''''), ISNULL(AV7008.S05ID,''''), 
		ISNULL(AV7008.S06ID,''''), ISNULL(AV7008.S07ID,''''), ISNULL(AV7008.S08ID,''''), ISNULL(AV7008.S09ID,''''), ISNULL(AV7008.S10ID,''''),
		ISNULL(AV7008.S11ID,''''), ISNULL(AV7008.S12ID,''''), ISNULL(AV7008.S13ID,''''), ISNULL(AV7008.S14ID,''''), ISNULL(AV7008.S15ID,''''), 
		ISNULL(AV7008.S16ID,''''), ISNULL(AV7008.S17ID,''''), ISNULL(AV7008.S18ID,''''), ISNULL(AV7008.S19ID,''''), ISNULL(AV7008.S20ID,'''')	'

	-------- Lay tong so du 
	SET @sqlSelect2=N'
	SELECT AV0728.ObjectID, AT1202.ObjectName, AT1202.O01ID,AT1202.O02ID,AT1202.O03ID,AT1202.O04ID,AT1202.O05ID,AT1202.Address, 
		   WareHouseID ,WareHouseName,InventoryID,	InventoryName, RefInventoryID, UnitID,		 
		   AV0728.S1, AV0728.S2, AV0728.S3 ,  I01ID, I02ID, I03ID, I04ID, I05ID, UnitName,
		   AV0728.Specification ,	AV0728.Notes01 , AV0728.Notes02 , AV0728.Notes03 ,
		   sum(isnull(BeginQuantity,0)) as BeginQuantity, sum(isnull( BeginAmount ,0)) as BeginAmount, AV0728.DivisionID,
		   SUM(AV0728.ConvertedQuantity) as ConvertedQuantity, 
		   SUM(AV0728.MarkQuantity) as MarkQuantity,
		   SUM(AV0728.DebitConvertedQuantity) as DebitConvertedQuantity , 
		   SUM(AV0728.CreditConvertedQuantity) as CreditConvertedQuantity ,AV0728.sourceno,AV0728.SParameter01,AV0728.SParameter02,AV0728.SParameter03	
		   ,AV0728.Ana01ID,AV0728.Ana02ID,AV0728.Ana03ID,AV0728.Ana04ID,AV0728.Ana05ID,AV0728.Ana06ID,AV0728.Ana07ID,AV0728.Ana08ID,AV0728.Ana09ID,AV0728.Ana10ID'

	SET @sqlFrom2 = N'
	INTO	#AV0729
	FROM #AV0728 AV0728
	LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.ObjectID = AV0728.ObjectID '

	SET @sqlWhere2 = N''

	SET @sqlGroupBy2 = N'
	GROUP BY AV0728.ObjectID, AT1202.ObjectName, AT1202.O01ID, AT1202.O02ID,AT1202.O03ID,AT1202.O04ID,AT1202.O05ID,AT1202.Address, InventoryID,	InventoryName, RefInventoryID,
			 UnitID, AV0728.S1, AV0728.S2, AV0728.S3 , I01ID,I02ID,I03ID, I04ID, I05ID, UnitName , AV0728.Specification ,AV0728.sourceno,
			 AV0728.Notes01, AV0728.Notes02, AV0728.Notes03, WareHouseID, WareHouseName, AV0728.DivisionID,
			 --AV0728.ConvertedQuantity, 
			 AV0728.MarkQuantity,
			 --AV0728.DebitConvertedQuantity, 
			 --AV0728.CreditConvertedQuantity	,
			 AV0728.SParameter01,AV0728.SParameter02,AV0728.SParameter03,
			 AV0728.Ana01ID,AV0728.Ana02ID,AV0728.Ana03ID,AV0728.Ana04ID,AV0728.Ana05ID,AV0728.Ana06ID,AV0728.Ana07ID,AV0728.Ana08ID,AV0728.Ana09ID,AV0728.Ana10ID	'


IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	SET @sqlSelect2 = @sqlSelect2 + ',
ISNULL(AV0728.S01ID,'''') AS S01ID, ISNULL(AV0728.S02ID,'''') AS S02ID, ISNULL(AV0728.S03ID,'''') AS S03ID, ISNULL(AV0728.S04ID,'''') AS S04ID, 
ISNULL(AV0728.S05ID,'''') AS S05ID, ISNULL(AV0728.S06ID,'''') AS S06ID, ISNULL(AV0728.S07ID,'''') AS S07ID, ISNULL(AV0728.S08ID,'''') AS S08ID, 
ISNULL(AV0728.S09ID,'''') AS S09ID, ISNULL(AV0728.S10ID,'''') AS S10ID, ISNULL(AV0728.S11ID,'''') AS S11ID, ISNULL(AV0728.S12ID,'''') AS S12ID, 
ISNULL(AV0728.S13ID,'''') AS S13ID, ISNULL(AV0728.S14ID,'''') AS S14ID, ISNULL(AV0728.S15ID,'''') AS S15ID, ISNULL(AV0728.S16ID,'''') AS S16ID, 
ISNULL(AV0728.S17ID,'''') AS S17ID, ISNULL(AV0728.S18ID,'''') AS S18ID, ISNULL(AV0728.S19ID,'''') AS S19ID, ISNULL(AV0728.S20ID,'''') AS S20ID
'

	SET @sqlGroupBy2 = @sqlGroupBy2 + ',
ISNULL(AV0728.S01ID,''''), ISNULL(AV0728.S02ID,''''), ISNULL(AV0728.S03ID,''''), ISNULL(AV0728.S04ID,''''), ISNULL(AV0728.S05ID,''''), 
ISNULL(AV0728.S06ID,''''), ISNULL(AV0728.S07ID,''''), ISNULL(AV0728.S08ID,''''), ISNULL(AV0728.S09ID,''''), ISNULL(AV0728.S10ID,''''),
ISNULL(AV0728.S11ID,''''), ISNULL(AV0728.S12ID,''''), ISNULL(AV0728.S13ID,''''), ISNULL(AV0728.S14ID,''''), ISNULL(AV0728.S15ID,''''), 
ISNULL(AV0728.S16ID,''''), ISNULL(AV0728.S17ID,''''), ISNULL(AV0728.S18ID,''''), ISNULL(AV0728.S19ID,''''), ISNULL(AV0728.S20ID,'''')'

END

IF @IsDate = 1    ---- xac dinh so lieu theo ngay//06/01/2014
	SET @strTimePS =N' And (AV7008.VoucherDate  >=  CASE WHEN AV7008.D_C in (''D'', ''C'') Then ''' + @FromDateText +N''' Else AV7008.VoucherDate End)  And (AV7008.VoucherDate  <=  CASE WHEN AV7008.D_C in (''D'', ''C'') Then ''' + Convert(varchar(10),@TODate,101) +N'''  Else AV7008.VoucherDate End) ' --- MTuyen edit
ELSE 
	SET @strTimePS =N' And (AV7008.TranMonth+ 100*AV7008.TranYear >= CASE WHEN AV7008.D_C in (''D'', ''C'') Then  '+@FromMonthYearText+N' Else AV7008.TranMonth+ 100*AV7008.TranYear End) And  (AV7008.TranMonth+ 100*AV7008.TranYear <= CASE WHEN AV7008.D_C in (''D'', ''C'') Then '+@ToMonthYearText+N' Else AV7008.TranMonth+ 100*AV7008.TranYear End) ' --- My Tuyen edit

	SET @sqlSelect2a=N'
	SELECT 	AV7008.VoucherID,AV7008.TransactionID, AV7008.ObjectID,AV7008.ObjectName,
			AV7008.O01ID, AV7008.O02ID, AV7008.O03ID, AV7008.O04ID, AV7008.O05ID, AV7008.Address,
			AV7008.InventoryID, AV7008.InventoryName, AV7008.RefInventoryID, AV7008.UnitID,
			AV7008.DebitAccountID, AV7008.CreditAccountID,
			AV7008.VoucherDate, AV7008.VoucherNo, AV7008.VoucherTypeID,
			AV7008.RefNo01, AV7008.RefNo02, AV7008.Notes, AV7008.S1, AV7008.S2, AV7008.S3, 
			AV7008.S1Name, AV7008.S2Name, AV7008.S3Name, 
			AV7008.I01ID, AV7008.I02ID, AV7008.I03ID, AV7008.I04ID, AV7008.I05ID, 
			AV7008.InAnaName1, AV7008.InAnaName2, AV7008.InAnaName3, AV7008.InAnaName4, AV7008.InAnaName5, 
			AV7008.UnitName, AV7008.Specification , AV7008.Notes01 , AV7008.Notes02 , AV7008.Notes03 ,
			AV7008.SourceNo,
			SUM(AV7008.ActualQuantity) AS ActualQuantity,
			SUM(AV7008.ConvertedAmount) AS ConvertedAmount,
			AV7008.DivisionID, AV7008.ProductID, AV7008.MOrderID, AV7008.ProductName,
			AV7008.VoucherDesc,AV7008.D_C,
			AV7008.Ana01ID,AV7008.Ana02ID,AV7008.Ana03ID,AV7008.Ana04ID,AV7008.Ana05ID,
			AV7008.Ana06ID,AV7008.Ana07ID,AV7008.Ana08ID,AV7008.Ana09ID,AV7008.Ana10ID,
			AV7008.Ana01Name,AV7008.Ana02Name,AV7008.Ana03Name,AV7008.Ana04Name,AV7008.Ana05Name,
			AV7008.Ana06Name,AV7008.Ana07Name,AV7008.Ana08Name,AV7008.Ana09Name,AV7008.Ana10Name,
			AV7008.LimitDate, AV7008.RevoucherDate, AV7008.WareHouseID, AV7008.WarehouseName,
			AV7008.RDAddress, AV7008.TranMonth, AV7008.TranYear,
			AV7008.ConvertedQuantity,
			AV7008.MarkQuantity,
			AV7008.DebitConvertedQuantity,
			AV7008.CreditConvertedQuantity,
			AV7008.ConvertedUnitID,AV7008.SParameter01,AV7008.SParameter02,AV7008.SParameter03	'

	SET @sqlFrom2a = N'
	INTO #AV7008
	FROM AV7008 '

	SET @sqlWhere2a = N'
	WHERE 	'+@WareHouseWhere+'
			AV7008.DivisionID =N'''+@DivisionID+N''' and
			(AV7008.InventoryID between N''' + @FromInventoryID + N''' and N''' + @ToInventoryID + N''') and
			(AV7008.ObjectID between  N'''+@FromObjectID+N''' and  N'''+@ToObjectID+N''') AND 
			(AV7008.WareHouseID between N'''+@FromWareHouseID+N''' and N'''+@ToWareHouseID+N''') and
			AV7008.D_C in (''D'',''BD'',''C'') ' + @AnaWhere + ' ' 

	SET @sqlWhere2a = @sqlWhere2a + @strTimePS + N' '

	SET @sqlGroupBy2a = N'
	GROUP BY AV7008.VoucherID, AV7008.TransactionID, AV7008.ObjectID,AV7008.ObjectName,
	         AV7008.O01ID, AV7008.O02ID,	AV7008.O03ID, AV7008.O04ID, AV7008.O05ID, AV7008.Address,
	         AV7008.InventoryID,	AV7008.InventoryName, AV7008.RefInventoryID, AV7008.UnitID,
	         AV7008.DebitAccountID, AV7008.CreditAccountID,
	         AV7008.VoucherDate, AV7008.VoucherNo, AV7008.VoucherTypeID,
	         AV7008.RefNo01, AV7008.RefNo02, AV7008.Notes,
	         AV7008.S1, AV7008.S2, AV7008.S3, 
	         AV7008.S1Name, AV7008.S2Name, AV7008.S3Name, 
	         AV7008.I01ID, AV7008.I02ID, AV7008.I03ID, AV7008.I04ID, AV7008.I05ID, 
	         AV7008.InAnaName1, AV7008.InAnaName2, AV7008.InAnaName3, AV7008.InAnaName4, AV7008.InAnaName5, 
	         AV7008.UnitName, AV7008.Specification , AV7008.Notes01 , AV7008.Notes02 , AV7008.Notes03 ,
	         AV7008.SourceNo,
	         AV7008.DivisionID, AV7008.ProductID, AV7008.MOrderID, AV7008.ProductName,
	         AV7008.VoucherDesc,AV7008.D_C,
	         AV7008.Ana01ID,AV7008.Ana02ID,AV7008.Ana03ID,AV7008.Ana04ID,AV7008.Ana05ID,
	         AV7008.Ana06ID,AV7008.Ana07ID,AV7008.Ana08ID,AV7008.Ana09ID,AV7008.Ana10ID,
	         AV7008.Ana01Name,AV7008.Ana02Name,AV7008.Ana03Name,AV7008.Ana04Name,AV7008.Ana05Name,
	         AV7008.Ana06Name,AV7008.Ana07Name,AV7008.Ana08Name,AV7008.Ana09Name,AV7008.Ana10Name,
	         AV7008.LimitDate, AV7008.RevoucherDate, AV7008.WareHouseID, AV7008.WarehouseName,
	         AV7008.RDAddress, AV7008.TranMonth, AV7008.TranYear, AV7008.ConvertedQuantity,AV7008.MarkQuantity,
	         AV7008.DebitConvertedQuantity,
	         AV7008.CreditConvertedQuantity,
		     AV7008.ConvertedUnitID,AV7008.SParameter01,AV7008.SParameter02,AV7008.SParameter03	'

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	SET @sqlSelect2a = @sqlSelect2a + ',
ISNULL(AV7008.S01ID,'''') AS S01ID, ISNULL(AV7008.S02ID,'''') AS S02ID, ISNULL(AV7008.S03ID,'''') AS S03ID, ISNULL(AV7008.S04ID,'''') AS S04ID, 
ISNULL(AV7008.S05ID,'''') AS S05ID, ISNULL(AV7008.S06ID,'''') AS S06ID, ISNULL(AV7008.S07ID,'''') AS S07ID, ISNULL(AV7008.S08ID,'''') AS S08ID, 
ISNULL(AV7008.S09ID,'''') AS S09ID, ISNULL(AV7008.S10ID,'''') AS S10ID, ISNULL(AV7008.S11ID,'''') AS S11ID, ISNULL(AV7008.S12ID,'''') AS S12ID, 
ISNULL(AV7008.S13ID,'''') AS S13ID, ISNULL(AV7008.S14ID,'''') AS S14ID, ISNULL(AV7008.S15ID,'''') AS S15ID, ISNULL(AV7008.S16ID,'''') AS S16ID, 
ISNULL(AV7008.S17ID,'''') AS S17ID, ISNULL(AV7008.S18ID,'''') AS S18ID, ISNULL(AV7008.S19ID,'''') AS S19ID, ISNULL(AV7008.S20ID,'''') AS S20ID
'

	SET @sqlGroupBy2a = @sqlGroupBy2a + ',
	ISNULL(AV7008.S01ID,''''), ISNULL(AV7008.S02ID,''''), ISNULL(AV7008.S03ID,''''), ISNULL(AV7008.S04ID,''''), ISNULL(AV7008.S05ID,''''), 
	ISNULL(AV7008.S06ID,''''), ISNULL(AV7008.S07ID,''''), ISNULL(AV7008.S08ID,''''), ISNULL(AV7008.S09ID,''''), ISNULL(AV7008.S10ID,''''),
	ISNULL(AV7008.S11ID,''''), ISNULL(AV7008.S12ID,''''), ISNULL(AV7008.S13ID,''''), ISNULL(AV7008.S14ID,''''), ISNULL(AV7008.S15ID,''''), 
	ISNULL(AV7008.S16ID,''''), ISNULL(AV7008.S17ID,''''), ISNULL(AV7008.S18ID,''''), ISNULL(AV7008.S19ID,''''), ISNULL(AV7008.S20ID,'''')'

END

	SET @sqlSelect3 = N'
	SELECT AV7008.VoucherID,
		   isnull( AV0729.ObjectID,	AV7008.ObjectID) as ObjectID, 
		   AT1202.S1 As OS1, AT1202.S2 As OS2, AT1202.S3 As OS3, 
		   O1.SName As OS1Name, O2.SName As OS2Name, O3.SName As OS3Name, 
		   isnull(AV0729.ObjectName,AV7008.ObjectName) as ObjectName, 
		   isnull( AV0729.O01ID, AV7008.O01ID) as O01ID,isnull( AV0729.O02ID, AV7008.O02ID) as O02ID,
		   isnull( AV0729.O03ID, AV7008.O03ID) as O03ID,isnull( AV0729.O04ID, AV7008.O04ID) as O04ID,isnull( AV0729.O05ID, AV7008.O05ID) as O05ID,
		   A1.AnaName as O01Name, A2.AnaName as O02Name, A3.AnaName as O03Name, A4.AnaName as O04Name, A5.AnaName as O05Name, 
		   isnull(AV0729.Address, AV7008.Address) as Address, 
		   isnull(AV7008.InventoryID, AV0729.InventoryID) AS InventoryID,
		   ISNULL(AV7008.InventoryName,AV0729.InventoryName) AS InventoryName,
		   ISNULL(AV7008.RefInventoryID,AV0729.RefInventoryID) AS RefInventoryID,
		   AT1302.VATGroupID, 
		   AT1302.VATPercent, 
		   AV7008.UnitID,
		   AT1309.UnitID As ConversionUnitID,
		   AT1309.ConversionFactor As ConversionFactor,
		   AT1309.Operator,
		   AV7008.DebitAccountID, AV7008.CreditAccountID,
		   AV7008.VoucherDate, AV7008.VoucherNo, AV7008.VoucherTypeID,
		   AV7008.RefNo01, AV7008.RefNo02, AV7008.Notes,
		   AV7008.S1, AV7008.S2, AV7008.S3, 
		   AV7008.S1Name, AV7008.S2Name, AV7008.S3Name, 
		   AV7008.I01ID, AV7008.I02ID, AV7008.I03ID, AV7008.I04ID, AV7008.I05ID, 
		   AV7008.InAnaName1, AV7008.InAnaName2, AV7008.InAnaName3, AV7008.InAnaName4, AV7008.InAnaName5, 
		   AV7008.UnitName, AV7008.Specification , AV7008.Notes01 , AV7008.Notes02 , AV7008.Notes03 ,
		   ISNULL(AV0729.SourceNo,AV7008.SourceNo) as SourceNo,
		   Sum(isnull(AV0729.BeginQuantity,0)) as BeginQuantity,
		   Sum(isnull(AV0729.ConvertedQuantity,0)) as BeginConvertedQuantity,
		   Sum(isnull(AV0729.BeginAmount,0)) as BeginAmount,
		   Sum(CASE WHEN D_C = ''D'' then isnull(AV7008.ActualQuantity,0) else 0 end) as DebitQuantity,
		   Sum(CASE WHEN D_C = ''D'' then isnull(AV7008.ConvertedQuantity,0) else 0 end) as DebitConvertedQuantity,
		   Sum(CASE WHEN D_C = ''D'' then isnull(AV7008.MarkQuantity,0) else 0 end) as DebitMarkQuantity,
		   Sum(CASE WHEN D_C = ''C'' then isnull(AV7008.ActualQuantity,0) else 0 end) as CreditQuantity,
		   Sum(CASE WHEN D_C = ''C'' then isnull(AV7008.ConvertedQuantity,0) else 0 end) as CreditConvertedQuantity,
		   Sum(CASE WHEN D_C = ''C'' then isnull(AV7008.MarkQuantity,0) else 0 end) as CreditMarkQuantity,
		   Sum(CASE WHEN D_C = ''C'' and AV7008.Ana04ID=''CXH'' then isnull(AV7008.ActualQuantity,0) else 0 end) as CreditQuantityNo, 
		   Sum(CASE WHEN D_C = ''D'' then isnull(AV7008.ConvertedAmount,0) else 0 end) as DebitAmount,
		   Sum(CASE WHEN D_C = ''C'' then isnull(AV7008.ConvertedAmount,0) else 0 end) as CreditAmount,
		   (SUM(isnull(AV0729.BeginQuantity,0)) + Sum(CASE WHEN D_C = ''D'' then isnull(AV7008.ActualQuantity,0) else 0 end) -   Sum(CASE WHEN D_C = ''C'' then isnull(AV7008.ActualQuantity,0) else 0 end)  ) as  EndQuantity,
		   (SUM(isnull(AV0729.ConvertedQuantity,0)) + Sum(CASE WHEN D_C = ''D'' then isnull(AV7008.ConvertedQuantity,0) else 0 end) -   Sum(CASE WHEN D_C = ''C'' then isnull(AV7008.ConvertedQuantity,0) else 0 end)  ) as  EndConvertedQuantity,
		   (SUM(isnull(AV0729.BeginAmount,0))+Sum(CASE WHEN D_C = ''D'' then isnull(AV7008.ConvertedAmount,0) else 0 end)  -  Sum(CASE WHEN D_C = ''C'' then isnull(AV7008.ConvertedAmount,0) else 0 end)  ) as EndAmount,
		   AV7008.DivisionID, AV7008.ProductID, AV7008.MOrderID, AV7008.ProductName,
		   AV7008.VoucherDesc, 
		   AV7008.Ana01ID,AV7008.Ana02ID,AV7008.Ana03ID,AV7008.Ana04ID,AV7008.Ana05ID,
		   AV7008.Ana06ID,AV7008.Ana07ID,AV7008.Ana08ID,AV7008.Ana09ID,AV7008.Ana10ID,
		   AV7008.Ana01Name,AV7008.Ana02Name,AV7008.Ana03Name,AV7008.Ana04Name,AV7008.Ana05Name,
		   AV7008.Ana06Name,AV7008.Ana07Name,AV7008.Ana08Name,AV7008.Ana09Name,AV7008.Ana10Name,
		   AV7008.LimitDate, AV7008.RevoucherDate, AV7008.WareHouseID, AV7008.WarehouseName, AT9000.VoucherNo  as BHVoucherNo, AT9000.VoucherDate as BHVoucherDate, AT9000.TDescription,  ---  06/01/2014MTuyen add new
		   AT9000.InvoiceNo, AT1011.AnaName as Sale-- 27/06/2014 MTuyen add new
		   ,AV7008.ConvertedUnitID,AV7008.SParameter01 as WNotes01,AV7008.SParameter02 as WNotes02,AV7008.SParameter03 as WNotes03	'

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	SET @sqlSelect3a = '
	,ISNULL(AV7008.S01ID,'''') AS S01ID, ISNULL(AV7008.S02ID,'''') AS S02ID, ISNULL(AV7008.S03ID,'''') AS S03ID, ISNULL(AV7008.S04ID,'''') AS S04ID, 
	ISNULL(AV7008.S05ID,'''') AS S05ID, ISNULL(AV7008.S06ID,'''') AS S06ID, ISNULL(AV7008.S07ID,'''') AS S07ID, ISNULL(AV7008.S08ID,'''') AS S08ID, 
	ISNULL(AV7008.S09ID,'''') AS S09ID, ISNULL(AV7008.S10ID,'''') AS S10ID, ISNULL(AV7008.S11ID,'''') AS S11ID, ISNULL(AV7008.S12ID,'''') AS S12ID, 
	ISNULL(AV7008.S13ID,'''') AS S13ID, ISNULL(AV7008.S14ID,'''') AS S14ID, ISNULL(AV7008.S15ID,'''') AS S15ID, ISNULL(AV7008.S16ID,'''') AS S16ID, 
	ISNULL(AV7008.S17ID,'''') AS S17ID, ISNULL(AV7008.S18ID,'''') AS S18ID, ISNULL(AV7008.S19ID,'''') AS S19ID, ISNULL(AV7008.S20ID,'''') AS S20ID,
	A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
	A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
	A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
	A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
	A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20
	'

	SET @sqlFrom3 = '
	FROM #AV7008 AV7008
	FULL JOIN #AV0729 AV0729 on ( AV0729.InventoryID = AV7008.InventoryID) AND (AV0729.ObjectID = AV7008.ObjectID)  
	AND (AV0729.DivisionID = AV7008.DivisionID) AND (AV0729.SourceNo = AV7008.SourceNo) 
	AND (ISNULL(AV0729.Notes02,'''') = ISNULL(AV7008.Notes02,'''')) AND (ISNULL(AV0729.Notes03,'''') = ISNULL(AV7008.Notes03,''''))
	AND ISNULL(AV7008.Ana01ID,'''') = Isnull(AV0729.Ana01ID,'''') AND ISNULL(AV7008.Ana02ID,'''') = isnull(AV0729.Ana02ID,'''')
	AND ISNULL(AV7008.Ana03ID,'''') = isnull(AV0729.Ana03ID,'''') AND ISNULL(AV7008.Ana04ID,'''') = isnull(AV0729.Ana04ID,'''')
	AND ISNULL(AV7008.Ana05ID,'''') = isnull(AV0729.Ana05ID,'''') AND ISNULL(AV7008.Ana06ID,'''') = isnull(AV0729.Ana06ID,'''')
	AND ISNULL(AV7008.Ana07ID,'''') = isnull(AV0729.Ana07ID,'''') AND ISNULL(AV7008.Ana08ID,'''') = isnull(AV0729.Ana08ID,'''') 
	AND ISNULL(AV7008.Ana09ID,'''') = isnull(AV0729.Ana09ID,'''')
	AND ISNULL(AV7008.S01ID,'''') = Isnull(AV0729.S01ID,'''') AND ISNULL(AV7008.S02ID,'''') = isnull(AV0729.S02ID,'''')
	AND ISNULL(AV7008.S03ID,'''') = isnull(AV0729.S03ID,'''') AND ISNULL(AV7008.S04ID,'''') = isnull(AV0729.S04ID,'''')
	AND ISNULL(AV7008.S05ID,'''') = isnull(AV0729.S05ID,'''') AND ISNULL(AV7008.S06ID,'''') = isnull(AV0729.S06ID,'''')
	AND ISNULL(AV7008.S07ID,'''') = isnull(AV0729.S07ID,'''') AND ISNULL(AV7008.S08ID,'''') = isnull(AV0729.S08ID,'''') 
	AND ISNULL(AV7008.S09ID,'''') = isnull(AV0729.S09ID,'''') AND ISNULL(AV7008.S10ID,'''') = isnull(AV0729.S10ID,'''') 
	AND ISNULL(AV7008.S11ID,'''') = isnull(AV0729.S11ID,'''') AND ISNULL(AV7008.S12ID,'''') = isnull(AV0729.S12ID,'''') 
	AND ISNULL(AV7008.S13ID,'''') = isnull(AV0729.S13ID,'''') AND ISNULL(AV7008.S14ID,'''') = isnull(AV0729.S14ID,'''') 
	AND ISNULL(AV7008.S15ID,'''') = isnull(AV0729.S15ID,'''') AND ISNULL(AV7008.S16ID,'''') = isnull(AV0729.S16ID,'''') 
	AND ISNULL(AV7008.S17ID,'''') = isnull(AV0729.S17ID,'''') AND ISNULL(AV7008.S18ID,'''') = isnull(AV0729.S18ID,'''') 
	AND ISNULL(AV7008.S19ID,'''') = isnull(AV0729.S19ID,'''') AND ISNULL(AV7008.S20ID,'''') = isnull(AV0729.S20ID,'''')  
	LEFT JOIN (Select InventoryID,Min(UnitID) As UnitID, Min(ConversionFactor) As ConversionFactor, Min(Operator) As Operator, DivisionID,
			  S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
			  From AT1309 WITH (NOLOCK) Group By InventoryID, DivisionID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, 
			  S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID) AT1309
	On AV7008.InventoryID = AT1309.InventoryID
	AND ISNULL(AV7008.S01ID,'''') = Isnull(AT1309.S01ID,'''') AND ISNULL(AV7008.S02ID,'''') = isnull(AT1309.S02ID,'''')
	AND ISNULL(AV7008.S03ID,'''') = isnull(AT1309.S03ID,'''') AND ISNULL(AV7008.S04ID,'''') = isnull(AT1309.S04ID,'''')
	AND ISNULL(AV7008.S05ID,'''') = isnull(AT1309.S05ID,'''') AND ISNULL(AV7008.S06ID,'''') = isnull(AT1309.S06ID,'''')
	AND ISNULL(AV7008.S07ID,'''') = isnull(AT1309.S07ID,'''') AND ISNULL(AV7008.S08ID,'''') = isnull(AT1309.S08ID,'''') 
	AND ISNULL(AV7008.S09ID,'''') = isnull(AT1309.S09ID,'''') AND ISNULL(AV7008.S10ID,'''') = isnull(AT1309.S10ID,'''') 
	AND ISNULL(AV7008.S11ID,'''') = isnull(AT1309.S11ID,'''') AND ISNULL(AV7008.S12ID,'''') = isnull(AT1309.S12ID,'''') 
	AND ISNULL(AV7008.S13ID,'''') = isnull(AT1309.S13ID,'''') AND ISNULL(AV7008.S14ID,'''') = isnull(AT1309.S14ID,'''') 
	AND ISNULL(AV7008.S15ID,'''') = isnull(AT1309.S15ID,'''') AND ISNULL(AV7008.S16ID,'''') = isnull(AT1309.S16ID,'''') 
	AND ISNULL(AV7008.S17ID,'''') = isnull(AT1309.S17ID,'''') AND ISNULL(AV7008.S18ID,'''') = isnull(AT1309.S18ID,'''') 
	AND ISNULL(AV7008.S19ID,'''') = isnull(AT1309.S19ID,'''') AND ISNULL(AV7008.S20ID,'''') = isnull(AT1309.S20ID,'''')  
	LEFT JOIN AT0128 A01 WITH (NOLOCK) ON AV7008.S01ID = A01.StandardID AND A01.StandardTypeID = ''S01''
	LEFT JOIN AT0128 A02 WITH (NOLOCK) ON AV7008.S02ID = A02.StandardID AND A02.StandardTypeID = ''S02''
	LEFT JOIN AT0128 A03 WITH (NOLOCK) ON AV7008.S03ID = A03.StandardID AND A03.StandardTypeID = ''S03''
	LEFT JOIN AT0128 A04 WITH (NOLOCK) ON AV7008.S04ID = A04.StandardID AND A04.StandardTypeID = ''S04''
	LEFT JOIN AT0128 A05 WITH (NOLOCK) ON AV7008.S05ID = A05.StandardID AND A05.StandardTypeID = ''S05''
	LEFT JOIN AT0128 A06 WITH (NOLOCK) ON AV7008.S06ID = A06.StandardID AND A06.StandardTypeID = ''S06''
	LEFT JOIN AT0128 A07 WITH (NOLOCK) ON AV7008.S07ID = A07.StandardID AND A07.StandardTypeID = ''S07''
	LEFT JOIN AT0128 A08 WITH (NOLOCK) ON AV7008.S08ID = A08.StandardID AND A08.StandardTypeID = ''S08''
	LEFT JOIN AT0128 A09 WITH (NOLOCK) ON AV7008.S09ID = A09.StandardID AND A09.StandardTypeID = ''S09''
	LEFT JOIN AT0128 A10 WITH (NOLOCK) ON AV7008.S10ID = A10.StandardID AND A10.StandardTypeID = ''S10''
	LEFT JOIN AT0128 A11 WITH (NOLOCK) ON AV7008.S11ID = A11.StandardID AND A11.StandardTypeID = ''S11''
	LEFT JOIN AT0128 A12 WITH (NOLOCK) ON AV7008.S12ID = A12.StandardID AND A12.StandardTypeID = ''S12''
	LEFT JOIN AT0128 A13 WITH (NOLOCK) ON AV7008.S13ID = A13.StandardID AND A13.StandardTypeID = ''S13''
	LEFT JOIN AT0128 A14 WITH (NOLOCK) ON AV7008.S14ID = A14.StandardID AND A14.StandardTypeID = ''S14''
	LEFT JOIN AT0128 A15 WITH (NOLOCK) ON AV7008.S15ID = A15.StandardID AND A15.StandardTypeID = ''S15''
	LEFT JOIN AT0128 A16 WITH (NOLOCK) ON AV7008.S16ID = A16.StandardID AND A16.StandardTypeID = ''S16''
	LEFT JOIN AT0128 A17 WITH (NOLOCK) ON AV7008.S17ID = A17.StandardID AND A17.StandardTypeID = ''S17''
	LEFT JOIN AT0128 A18 WITH (NOLOCK) ON AV7008.S18ID = A18.StandardID AND A18.StandardTypeID = ''S18''
	LEFT JOIN AT0128 A19 WITH (NOLOCK) ON AV7008.S19ID = A19.StandardID AND A19.StandardTypeID = ''S19''
	LEFT JOIN AT0128 A20 WITH (NOLOCK) ON AV7008.S20ID = A20.StandardID AND A20.StandardTypeID = ''S20''
	'
	SET @sqlGroupBy3a = '
	,ISNULL(AV7008.S01ID,''''), ISNULL(AV7008.S02ID,''''), ISNULL(AV7008.S03ID,''''), ISNULL(AV7008.S04ID,''''), 
	ISNULL(AV7008.S05ID,''''), ISNULL(AV7008.S06ID,''''), ISNULL(AV7008.S07ID,''''), ISNULL(AV7008.S08ID,''''), 
	ISNULL(AV7008.S09ID,''''), ISNULL(AV7008.S10ID,''''), ISNULL(AV7008.S11ID,''''), ISNULL(AV7008.S12ID,''''), 
	ISNULL(AV7008.S13ID,''''), ISNULL(AV7008.S14ID,''''), ISNULL(AV7008.S15ID,''''), ISNULL(AV7008.S16ID,''''), 
	ISNULL(AV7008.S17ID,''''), ISNULL(AV7008.S18ID,''''), ISNULL(AV7008.S19ID,''''), ISNULL(AV7008.S20ID,''''),
	A01.StandardName, A02.StandardName, A03.StandardName, A04.StandardName, 
	A05.StandardName, A06.StandardName, A07.StandardName, A08.StandardName, 
	A09.StandardName, A10.StandardName, A11.StandardName, A12.StandardName,
	A13.StandardName, A14.StandardName, A15.StandardName, A16.StandardName,
	A17.StandardName, A18.StandardName, A19.StandardName, A20.StandardName
	'
END
ELSE 
	SET @sqlFrom3 = '
	FROM #AV7008 AV7008
	FULL JOIN #AV0729 AV0729 on ( AV0729.InventoryID = AV7008.InventoryID) and (AV0729.ObjectID = AV7008.ObjectID) and (AV0729.DivisionID = AV7008.DivisionID)  
	AND (AV0729.SourceNo = AV7008.SourceNo) AND (ISNULL(AV0729.Notes02,'''') = ISNULL(AV7008.Notes02,'''')) AND (ISNULL(AV0729.Notes03,'''') = ISNULL(AV7008.Notes03,''''))
	AND ISNULL(AV7008.Ana01ID,'''') = Isnull(AV0729.Ana01ID,'''') AND ISNULL(AV7008.Ana02ID,'''') = isnull(AV0729.Ana02ID,'''')
	AND ISNULL(AV7008.Ana03ID,'''') = isnull(AV0729.Ana03ID,'''') AND ISNULL(AV7008.Ana04ID,'''') = isnull(AV0729.Ana04ID,'''')
	AND ISNULL(AV7008.Ana05ID,'''') = isnull(AV0729.Ana05ID,'''') AND ISNULL(AV7008.Ana06ID,'''') = isnull(AV0729.Ana06ID,'''')
	AND ISNULL(AV7008.Ana07ID,'''') = isnull(AV0729.Ana07ID,'''') AND ISNULL(AV7008.Ana08ID,'''') = isnull(AV0729.Ana08ID,'''') 
	AND ISNULL(AV7008.Ana09ID,'''') = isnull(AV0729.Ana09ID,'''')
	LEFT JOIN (Select InventoryID,Min(UnitID) As UnitID, Min(ConversionFactor) As ConversionFactor, Min(Operator) As Operator, DivisionID 
			  From AT1309 WITH (NOLOCK) Group By InventoryID, DivisionID) AT1309 On AV7008.InventoryID = AT1309.InventoryID '

	SET @sqlFrom3a = N'
	LEFT JOIN AT1015 A1 WITH (NOLOCK) On isnull( AV0729.O01ID, AV7008.O01ID) =  A1.AnaID And A1.AnaTypeID = ''O01''
	LEFT JOIN AT1015 A2 WITH (NOLOCK) On isnull( AV0729.O02ID, AV7008.O02ID) =  A2.AnaID And A2.AnaTypeID = ''O02''
	LEFT JOIN AT1015 A3 WITH (NOLOCK) On isnull( AV0729.O03ID, AV7008.O03ID) =  A3.AnaID And A3.AnaTypeID = ''O03''
	LEFT JOIN AT1015 A4 WITH (NOLOCK) On isnull( AV0729.O04ID, AV7008.O04ID) =  A4.AnaID And A4.AnaTypeID = ''O04''
	LEFT JOIN AT1015 A5 WITH (NOLOCK) On isnull( AV0729.O05ID, AV7008.O05ID) =  A5.AnaID And A5.AnaTypeID = ''O05''
	LEFT JOIN AT1202 WITH (NOLOCK) On  isnull( AV0729.ObjectID,	AV7008.ObjectID) = AT1202.ObjectID
	LEFT JOIN AT1207 O1 WITH (NOLOCK) On AT1202.S1 = O1.S And O1.STypeID = ''O01''
	LEFT JOIN AT1207 O2 WITH (NOLOCK) On AT1202.S2 = O2.S And O2.STypeID = ''O02''
	LEFT JOIN AT1207 O3 WITH (NOLOCK) On AT1202.S3 = O3.S And O1.STypeID = ''O03''
	LEFT JOIN AT1302 WITH (NOLOCK) On AT1302.DivisionID IN (AV7008.DivisionID,''@@@'') AND AV7008.InventoryID = AT1302.InventoryID
	LEFT JOIN AT9000 WITH (NOLOCK) ON AT9000.WOrderID=AV7008.VoucherID and AT9000.TransactionTypeID=''T04'' and AT9000.InventoryID = AV7008.InventoryID --- 27/06/2014 MTuyen edit
										AND AV7008.TransactionID  = AT9000.WTransactionID
	LEFT JOIN AT1011 WITH (NOLOCK) ON AT9000.Ana01ID=AT1011.AnaID and AT1011.AnaTypeID=''A01'' -- 27/06/2014 MTuyen add new
'

	SET @sqlWhere3 = N'
	WHERE 	'+@WareHouseWhere+'
			AV7008.DivisionID =N'''+@DivisionID+N''' and
			(AV7008.InventoryID between N''' + @FromInventoryID + N''' and N''' + @ToInventoryID + N''') and
			(AV7008.ObjectID between  N'''+@FromObjectID+N''' and  N'''+@ToObjectID+N''') AND 
			(AV7008.WareHouseID between N'''+@FromWareHouseID+N''' and N'''+@ToWareHouseID+N''') and
			AV7008.D_C in (''D'',''BD'',''C'') ' + @AnaWhere + ' ' 

	SET @sqlWhere3 = @sqlWhere3 + @strTimePS +N' '

	SET @sqlGroupBy3 = N'
	GROUP BY AV7008.DivisionID, AV7008.VoucherID, AV0729.ObjectID,AV7008.ObjectID, AV0729.ObjectName, AV7008.ObjectName, 
		     AT1202.S1, AT1202.S2, AT1202.S3, 
		     O1.SName, O2.SName, O3.SName, 
		     isnull( AV0729.O01ID, AV7008.O01ID), isnull( AV0729.O02ID, AV7008.O02ID), isnull( AV0729.O03ID, AV7008.O03ID), isnull( AV0729.O04ID, AV7008.O04ID), isnull( AV0729.O05ID, AV7008.O05ID),
		     A1.AnaName, A2.AnaName, A3.AnaName, A4.AnaName, A5.AnaName, 
		     AV0729.Address, AV7008.Address, isnull(AV7008.InventoryID, AV0729.InventoryID), ISNULL(AV7008.InventoryName,AV0729.InventoryName),
		     ISNULL(AV7008.RefInventoryID,AV0729.RefInventoryID), AT1302.VATGroupID, AT1302.VATPercent, 
		     AV7008.UnitID, AV7008.UnitName, 
		     AT1309.UnitID,
		     AT1309.ConversionFactor,
		     AT1309.Operator,
		     AV7008.Specification , AV7008.Notes01 , AV7008.Notes02 , AV7008.Notes03 ,
		     AV7008.DebitAccountID, AV7008.CreditAccountID,
		     AV7008.VoucherDate, AV7008.VoucherNo,  AV7008.VoucherTypeID,
		     AV7008.RefNo01, AV7008.RefNo02, AV7008.Notes,
		     --AV0729.BeginQuantity,
		     --AV0729.ConvertedQuantity,
			 --AV0729.MarkQuantity,
		     --AV0729.BeginAmount,
		     AV7008.D_C,
		     --AV7008.ActualQuantity,AV7008.ConvertedAmount,
		     AV7008.S1, AV7008.S2, AV7008.S3, 
		     AV7008.S1Name, AV7008.S2Name, AV7008.S3Name, 
		     AV7008.I01ID, AV7008.I02ID, AV7008.I03ID, AV7008.I04ID, AV7008.I05ID,
		     AV7008.InAnaName1, AV7008.InAnaName2, AV7008.InAnaName3, AV7008.InAnaName4, AV7008.InAnaName5, AV7008.SourceNo, AV0729.SourceNo,
		     AV7008.ProductID, AV7008.MOrderID, AV7008.ProductName,
		     AV7008.VoucherDesc, 
		     AV7008.Ana01ID,AV7008.Ana02ID,AV7008.Ana03ID,AV7008.Ana04ID,AV7008.Ana05ID,
		     AV7008.Ana06ID,AV7008.Ana07ID,AV7008.Ana08ID,AV7008.Ana09ID,AV7008.Ana10ID,
		     AV7008.Ana01Name,AV7008.Ana02Name,AV7008.Ana03Name,AV7008.Ana04Name,AV7008.Ana05Name,
		     AV7008.Ana06Name,AV7008.Ana07Name,AV7008.Ana08Name,AV7008.Ana09Name,AV7008.Ana10Name,
		     AV7008.LimitDate, AV7008.RevoucherDate,AV7008.WareHouseID,AV7008.WarehouseName,AT9000.VoucherNo, AT9000.VoucherDate,AT9000.TDescription,  ---06/01/2014 MTuyen add new
		     AT9000.InvoiceNo, AT1011.AnaName ---27/06/2014 MTuyen add new
			 ,AV7008.ConvertedUnitID,AV7008.SParameter01,AV7008.SParameter02,AV7008.SParameter03'  

	PRINT @sqlSelect1 
	PRINT @sqlFrom1 
	PRINT @sqlWhere1 
	PRINT @sqlGroupBy1 
	PRINT @sqlSelect2 
	PRINT @sqlFrom2 
	PRINT @sqlWhere2 
	PRINT @sqlGroupBy2 
	PRINT @sqlSelect2a
	PRINT @sqlFrom2a 
	PRINT @sqlWhere2a 
	PRINT @sqlGroupBy2a 
	PRINT @sqlSelect3 
	PRINT @sqlSelect3a 
	PRINT @sqlFrom3 
	PRINT @sqlFrom3a 
	PRINT @sqlWhere3 
	PRINT @sqlGroupBy3 
	PRINT @sqlGroupBy3a 
	PRINT @sqlSelectunion 
	PRINT @sqlWhereUnion
	
EXEC (@sqlSelect1 + @sqlFrom1 + @sqlWhere1 + @sqlGroupBy1 + @sqlSelect2 + @sqlFrom2 + @sqlWhere2 + @sqlGroupBy2 + @sqlSelect2a + @sqlFrom2a + @sqlWhere2a + @sqlGroupBy2a + @sqlSelect3 + @sqlSelect3a + @sqlFrom3 + @sqlFrom3a + @sqlWhere3 + @sqlGroupBy3 + @sqlGroupBy3a + @sqlSelectunion + @sqlWhereUnion)

DROP TABLE #Tempt

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
