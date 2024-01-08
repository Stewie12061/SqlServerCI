IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP6003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP6003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




---- In bao cao theo ma  phan tich
---- Last Edit : Thuy Tuyen, Date: 23/11/2007, Bo sung loc ma phan tich theo dieu kien rong
---- Edit by Nguyen Quoc Huy, Date: 14/05/2009 (Bo xung rieng cho Donacoop)
---- Edit by: Dang Le Bao Quynh; Date: 30/09/2009
---- Purpose: Bo sung tat ca cac truong ghi chu va so tien cua ma phan tich nghiep vu
---- Edit by B.Anh, date 30/12/2009	Them in theo ngay
---- Modified on 19/01/2012 by Le Thi Thu Hien : Sua dieu kien CONVERT theo ngay
---- Modified by on 11/10/2012 by Lê Thị Thu Hiền : Bổ sung thêm strDivisionID
---- Modified on 05/03/2014 by Le Thi Thu Hien : Bo sung phan quyen xem du lieu cua nguoi khac
---- Modified on 08/04/2014 by Bảo Anh: Bổ sung thêm 5 MPT
---- Modified by Bảo Thy on 19/05/2017: Sửa danh mục dùng chung
---- Modified on 29/09/2017 by Hải Long: Bổ sung 10 mã phân tích đối tượng
---- Modified on 16/01/2018 by Bảo Anh: Bổ sung WITH (NOLOCK) và trả ra dữ liệu, không tạo AV6003
---- Modified on 07/06/2018 by Bảo Anh: Bổ sung DParameter01 -> DParameter10
---- Modified on 10/07/2019 by Kim Thư: Bổ sung sắp xếp theo AnaID, VoucherDate
---- Modified on 27/05/2020 by Nhựt Trường: Lấy thêm trường ReAnaID từ AT1011
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Trọng Kiên on 24/11/2020: Bổ sung load thêm cột CreditObjectID & CreditObjectName
---- Modified by Huỳnh Thử on 05/07/2021: Bổ sung lọc @AnaTypeID (O01 -> O05)
---- Modified by Nhật Thanh on 16/03/2022: Bổ sung điều kiện divisionID khi join bảng AT1202
---- Modified by Nhựt Trường on 08/08/2022: [2022/08/IS/0033] - Bổ sung điều kiện divisionID khi join bảng AT1202 cho tất cả các trường hợp.
-- <Example>
---- 
-- <Summary>
CREATE PROCEDURE [dbo].[AP6003]  
				@DivisionID nvarchar(50), 
				@FromMonth AS int, 
				@FromYear AS int,
				@ToMonth AS int,
				@ToYear AS int,
				@FromDate AS Datetime, @ToDate AS Datetime,
				@IsDate AS tinyint,
				@IsDebit AS int,
				@FromDebitAccountID AS nvarchar(50),
				@ToDebitAccountID AS nvarchar(50),
				@IsCredit AS int,
				@FromCreditAccountID AS nvarchar(50),
				@ToCreditAccountID AS nvarchar(50),
				@AnaTypeID AS nvarchar(50),
				@FromAnaID AS nvarchar(50),
				@ToAnaID AS nvarchar(50),
				@StrDivisionID AS NVARCHAR(4000) = '',
				@UserID AS VARCHAR(50) = ''
			
AS
Declare @FieldName AS  nvarchar(MAX),
		@sqlSelect AS nvarchar(max),
		@sqlSelect1 AS nvarchar(max),
		@sqlFrom AS nvarchar(max),
   		@sqlWhere AS nvarchar(max),
		@sql1Select AS nvarchar(max),
		@sql1Select1 AS nvarchar(max),
		@sql1From AS nvarchar(max),
		@sql1Where AS nvarchar(max),
		@StrDivisionID_New AS NVARCHAR(max),
		@FieldName1 AS nvarchar(max)

----------------->>>>>> Phân quyền xem chứng từ của người dùng khác		
DECLARE @sSQLPer AS NVARCHAR(MAX),
		@sWHEREPer AS NVARCHAR(MAX)
SET @sSQLPer = ''
SET @sWHEREPer = ''	

---Lấy thêm trường ReAnaID từ AT1011
If @AnaTypeID = 'A01' 
	Set @FieldName1 = 'AT01.ReAnaID'
else If @AnaTypeID = 'A02' 
	Set @FieldName1 = 'AT02.ReAnaID'
else If @AnaTypeID = 'A03' 
	Set @FieldName1 = 'AT03.ReAnaID'
else If @AnaTypeID = 'A04' 
	Set @FieldName1 = 'AT04.ReAnaID'
else If @AnaTypeID = 'A04' 
	Set @FieldName1 = 'AT04.ReAnaID'
else If @AnaTypeID = 'A05' 
	Set @FieldName1 = 'AT05.ReAnaID'
else If @AnaTypeID = 'A06' 
	Set @FieldName1 = 'AT06.ReAnaID'
else If @AnaTypeID = 'A07' 
	Set @FieldName1 = 'AT07.ReAnaID'
else If @AnaTypeID = 'A08' 
	Set @FieldName1 = 'AT08.ReAnaID'
else If @AnaTypeID = 'A09' 
	Set @FieldName1 = 'AT09.ReAnaID'
else If @AnaTypeID = 'A10' 
	Set @FieldName1 = 'AT10.ReAnaID'
else If @AnaTypeID = 'O01' 
	SET @FieldName1 = 'A01.AnaID'
else If @AnaTypeID = 'O02' 
	SET @FieldName1 = 'A02.AnaID'
else If @AnaTypeID = 'O03' 
	SET @FieldName1 = 'A03.AnaID'
else If @AnaTypeID = 'O04' 
	SET @FieldName1 = 'A04.AnaID'
else If @AnaTypeID = 'O05' 
	SET @FieldName1 = 'A05.AnaID'
else 
	Set @FieldName1=''	

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsPermissionView = 1 ) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
	BEGIN
		SET @sSQLPer = ' LEFT JOIN AT0010 WITH (NOLOCK) ON AT0010.DivisionID = AT9000.DivisionID 
											AND AT0010.AdminUserID = '''+@UserID+''' 
											AND AT0010.UserID = AT9000.CreateUserID '
		SET @sWHEREPer = ' AND (AT9000.CreateUserID = AT0010.UserID
								OR  AT9000.CreateUserID = '''+@UserID+''') '		
	END

-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác	

SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END

If @AnaTypeID like 'A%'  --- Ma phan tich but toan
	Set @FieldName = 'AT9000.Ana'+right(@AnaTypeID,2)+'ID'
If @AnaTypeID like 'I%'  --- Ma phan tich mat hang
	Set @FieldName = 'T02.I'+right(@AnaTypeID,2)+'ID'
If @AnaTypeID like 'O%'  --- Ma phan tich doi tuong
	Set @FieldName = 'Ob.O'+right(@AnaTypeID,2)+'ID'
If @AnaTypeID like 'CI%'  --- Ma phan loai mat hang
	Set @FieldName = 'T02.S'+right(@AnaTypeID,1)+' '
If @AnaTypeID like 'CO%'  --- Ma phan loai doi tuong
	Set @FieldName = 'Ob.S'+right(@AnaTypeID,1)+' '
If @AnaTypeID = ''
	Set @FieldName = ''''''
	
if @FromAnaID ='[]' 
	 set @FromAnaID =''

if @ToAnaID ='[]' 
	 set @ToAnaID =''


If Upper(Right(@FromDebitAccountID,1)) ='Z' 
	Set @FromDebitAccountID = Left(@FromDebitAccountID,len(@FromDebitAccountID) -1) + '%'

--print  @FieldName
Set @sqlSelect = N'
SELECT * FROM (
	SELECT AT9000.DivisionID, '+@FieldName+N' AS AnaID, '+@FieldName1+N' AS ReAnaID,
	AV6666.SelectionName AS AnaName,
	AT01.Note01 AS Ana01IDNote01, AT01.Note02 AS Ana01IDNote02, AT01.Note03 AS Ana01IDNote03, AT01.Note04 AS Ana01IDNote04, AT01.Note05 AS Ana01IDNote05,
	AT01.Note06 AS Ana01IDNote06, AT01.Note07 AS Ana01IDNote07, AT01.Note08 AS Ana01IDNote08, AT01.Note09 AS Ana01IDNote09, AT01.Note10 AS Ana01IDNote10,
	AT01.AnaTypeID AS AnaTypeID01, AT01.RefDate AS Ana01IDRefDate, 
	AT01.Amount01 AS Ana01IDAmount01, AT01.Amount02 AS Ana01IDAmount02, AT01.Amount03 AS Ana01IDAmount03, AT01.Amount04 AS Ana01IDAmount04, AT01.Amount05 AS Ana01IDAmount05, 
	AT01.Amount06 AS Ana01IDAmount06, AT01.Amount07 AS Ana01IDAmount07, AT01.Amount08 AS Ana01IDAmount08, AT01.Amount09 AS Ana01IDAmount09, AT01.Amount10 AS Ana01IDAmount10, ' + 
	Case when @IsDebit <>0  and isnull(@FromDebitAccountID,'') <> '' and isnull(@ToDebitAccountID,'') =''
		then	+ N'N''' + isnull(@FromDebitAccountID,'')  + N''''
		Else
			N'N'''''
	End 
    set @sqlSelect1= N' AS AccountID, 
	AT9000.CreditBankAccountID, AT9000.DebitBankAccountID,

	AT9000.Ana02ID, AT02.AnaName AS AnaName02,
	AT02.Note01 AS Ana02IDNote01, AT02.Note02 AS Ana02IDNote02, AT02.Note03 AS Ana02IDNote03, AT02.Note04 AS Ana02IDNote04, AT02.Note05 AS Ana02IDNote05,
	AT02.Note06 AS Ana02IDNote06, AT02.Note07 AS Ana02IDNote07, AT02.Note08 AS Ana02IDNote08, AT02.Note09 AS Ana02IDNote09, AT02.Note10 AS Ana02IDNote10,
	AT02.AnaTypeID AS AnaTypeID02, AT02.RefDate AS Ana02IDRefDate, 
	AT02.Amount01 AS Ana02IDAmount01, AT02.Amount02 AS Ana02IDAmount02, AT02.Amount03 AS Ana02IDAmount03, AT02.Amount04 AS Ana02IDAmount04, AT02.Amount05 AS Ana02IDAmount05, 
	AT02.Amount06 AS Ana02IDAmount06, AT02.Amount07 AS Ana02IDAmount07, AT02.Amount08 AS Ana02IDAmount08, AT02.Amount09 AS Ana02IDAmount09, AT02.Amount10 AS Ana02IDAmount10, 

	AT9000.Ana03ID, AT03.AnaName AS AnaName03,
	AT03.Note01 AS Ana03IDNote01, AT03.Note02 AS Ana03IDNote02, AT03.Note03 AS Ana03IDNote03, AT03.Note04 AS Ana03IDNote04, AT03.Note05 AS Ana03IDNote05,
	AT03.Note06 AS Ana03IDNote06, AT03.Note07 AS Ana03IDNote07, AT03.Note08 AS Ana03IDNote08, AT03.Note09 AS Ana03IDNote09, AT03.Note10 AS Ana03IDNote10,
	AT03.AnaTypeID AS AnaTypeID03, AT03.RefDate AS Ana03IDRefDate, 
	AT03.Amount01 AS Ana03IDAmount01, AT03.Amount02 AS Ana03IDAmount02, AT03.Amount03 AS Ana03IDAmount03, AT03.Amount04 AS Ana03IDAmount04, AT03.Amount05 AS Ana03IDAmount05, 
	AT03.Amount06 AS Ana03IDAmount06, AT03.Amount07 AS Ana03IDAmount07, AT03.Amount08 AS Ana03IDAmount08, AT03.Amount09 AS Ana03IDAmount09, AT03.Amount10 AS Ana03IDAmount10, 

	AT9000.Ana04ID, AT04.AnaName AS AnaName04,
	AT04.Note01 AS Ana04IDNote01, AT04.Note02 AS Ana04IDNote02, AT04.Note03 AS Ana04IDNote03, AT04.Note04 AS Ana04IDNote04, AT04.Note05 AS Ana04IDNote05,
	AT04.Note06 AS Ana04IDNote06, AT04.Note07 AS Ana04IDNote07, AT04.Note08 AS Ana04IDNote08, AT04.Note09 AS Ana04IDNote09, AT04.Note10 AS Ana04IDNote10,
	AT04.AnaTypeID AS AnaTypeID04, AT04.RefDate AS Ana04IDRefDate, 
	AT04.Amount01 AS Ana04IDAmount01, AT04.Amount02 AS Ana04IDAmount02, AT04.Amount03 AS Ana04IDAmount03, AT04.Amount04 AS Ana04IDAmount04, AT04.Amount05 AS Ana04IDAmount05, 
	AT04.Amount06 AS Ana04IDAmount06, AT04.Amount07 AS Ana04IDAmount07, AT04.Amount08 AS Ana04IDAmount08, AT04.Amount09 AS Ana04IDAmount09, AT04.Amount10 AS Ana04IDAmount10, 

	AT9000.Ana05ID, AT05.AnaName AS AnaName05,
	AT05.Note01 AS Ana05IDNote01, AT05.Note02 AS Ana05IDNote02, AT05.Note03 AS Ana05IDNote03, AT05.Note04 AS Ana05IDNote04, AT05.Note05 AS Ana05IDNote05,
	AT05.Note06 AS Ana05IDNote06, AT05.Note07 AS Ana05IDNote07, AT05.Note08 AS Ana05IDNote08, AT05.Note09 AS Ana05IDNote09, AT05.Note10 AS Ana05IDNote10,
	AT05.AnaTypeID AS AnaTypeID05, AT05.RefDate AS Ana05IDRefDate, 
	AT05.Amount01 AS Ana05IDAmount01, AT05.Amount02 AS Ana05IDAmount02, AT05.Amount03 AS Ana05IDAmount03, AT05.Amount04 AS Ana05IDAmount04, AT05.Amount05 AS Ana05IDAmount05, 
	AT05.Amount06 AS Ana05IDAmount06, AT05.Amount07 AS Ana05IDAmount07, AT05.Amount08 AS Ana05IDAmount08, AT05.Amount09 AS Ana05IDAmount09, AT05.Amount10 AS Ana05IDAmount10, 

	AT9000.Ana06ID, AT06.AnaName AS AnaName06,
	AT06.Note01 AS Ana06IDNote01, AT06.Note02 AS Ana06IDNote02, AT06.Note03 AS Ana06IDNote03, AT06.Note04 AS Ana06IDNote04, AT06.Note05 AS Ana06IDNote05,
	AT06.Note06 AS Ana06IDNote06, AT06.Note07 AS Ana06IDNote07, AT06.Note08 AS Ana06IDNote08, AT06.Note09 AS Ana06IDNote09, AT06.Note10 AS Ana06IDNote10,
	AT06.AnaTypeID AS AnaTypeID06, AT06.RefDate AS Ana06IDRefDate, 
	AT06.Amount01 AS Ana06IDAmount01, AT06.Amount02 AS Ana06IDAmount02, AT06.Amount03 AS Ana06IDAmount03, AT06.Amount04 AS Ana06IDAmount04, AT06.Amount05 AS Ana06IDAmount05, 
	AT06.Amount06 AS Ana06IDAmount06, AT06.Amount07 AS Ana06IDAmount07, AT06.Amount08 AS Ana06IDAmount08, AT06.Amount09 AS Ana06IDAmount09, AT06.Amount10 AS Ana06IDAmount10,
	
	AT9000.Ana07ID, AT07.AnaName AS AnaName07,
	AT07.Note01 AS Ana07IDNote01, AT07.Note02 AS Ana07IDNote02, AT07.Note03 AS Ana07IDNote03, AT07.Note04 AS Ana07IDNote04, AT07.Note05 AS Ana07IDNote05,
	AT07.Note06 AS Ana07IDNote06, AT07.Note07 AS Ana07IDNote07, AT07.Note08 AS Ana07IDNote08, AT07.Note09 AS Ana07IDNote09, AT07.Note10 AS Ana07IDNote10,
	AT07.AnaTypeID AS AnaTypeID07, AT07.RefDate AS Ana07IDRefDate, 
	AT07.Amount01 AS Ana07IDAmount01, AT07.Amount02 AS Ana07IDAmount02, AT07.Amount03 AS Ana07IDAmount03, AT07.Amount04 AS Ana07IDAmount04, AT07.Amount05 AS Ana07IDAmount05, 
	AT07.Amount06 AS Ana07IDAmount06, AT07.Amount07 AS Ana07IDAmount07, AT07.Amount08 AS Ana07IDAmount08, AT07.Amount09 AS Ana07IDAmount09, AT07.Amount10 AS Ana07IDAmount10,
	
	AT9000.Ana08ID, AT08.AnaName AS AnaName08,
	AT08.Note01 AS Ana08IDNote01, AT08.Note02 AS Ana08IDNote02, AT08.Note03 AS Ana08IDNote03, AT08.Note04 AS Ana08IDNote04, AT08.Note05 AS Ana08IDNote05,
	AT08.Note06 AS Ana08IDNote06, AT08.Note07 AS Ana08IDNote07, AT08.Note08 AS Ana08IDNote08, AT08.Note09 AS Ana08IDNote09, AT08.Note10 AS Ana08IDNote10,
	AT08.AnaTypeID AS AnaTypeID08, AT08.RefDate AS Ana08IDRefDate, 
	AT08.Amount01 AS Ana08IDAmount01, AT08.Amount02 AS Ana08IDAmount02, AT08.Amount03 AS Ana08IDAmount03, AT08.Amount04 AS Ana08IDAmount04, AT08.Amount05 AS Ana08IDAmount05, 
	AT08.Amount06 AS Ana08IDAmount06, AT08.Amount07 AS Ana08IDAmount07, AT08.Amount08 AS Ana08IDAmount08, AT08.Amount09 AS Ana08IDAmount09, AT08.Amount10 AS Ana08IDAmount10,
	
	AT9000.Ana09ID, AT09.AnaName AS AnaName09,
	AT09.Note01 AS Ana09IDNote01, AT09.Note02 AS Ana09IDNote02, AT09.Note03 AS Ana09IDNote03, AT09.Note04 AS Ana09IDNote04, AT09.Note05 AS Ana09IDNote05,
	AT09.Note06 AS Ana09IDNote06, AT09.Note07 AS Ana09IDNote07, AT09.Note08 AS Ana09IDNote08, AT09.Note09 AS Ana09IDNote09, AT09.Note10 AS Ana09IDNote10,
	AT09.AnaTypeID AS AnaTypeID09, AT09.RefDate AS Ana09IDRefDate, 
	AT09.Amount01 AS Ana09IDAmount01, AT09.Amount02 AS Ana09IDAmount02, AT09.Amount03 AS Ana09IDAmount03, AT09.Amount04 AS Ana09IDAmount04, AT09.Amount05 AS Ana09IDAmount05, 
	AT09.Amount06 AS Ana09IDAmount06, AT09.Amount07 AS Ana09IDAmount07, AT09.Amount08 AS Ana09IDAmount08, AT09.Amount09 AS Ana09IDAmount09, AT09.Amount10 AS Ana09IDAmount10,
	
	AT9000.Ana10ID, AT10.AnaName AS AnaName10,
	AT10.Note01 AS Ana10IDNote01, AT10.Note02 AS Ana10IDNote02, AT10.Note03 AS Ana10IDNote03, AT10.Note04 AS Ana10IDNote04, AT10.Note05 AS Ana10IDNote05,
	AT10.Note06 AS Ana10IDNote06, AT10.Note07 AS Ana10IDNote07, AT10.Note08 AS Ana10IDNote08, AT10.Note09 AS Ana10IDNote09, AT10.Note10 AS Ana10IDNote10,
	AT10.AnaTypeID AS AnaTypeID10, AT10.RefDate AS Ana10IDRefDate, 
	AT10.Amount01 AS Ana10IDAmount01, AT10.Amount02 AS Ana10IDAmount02, AT10.Amount03 AS Ana10IDAmount03, AT10.Amount04 AS Ana10IDAmount04, AT10.Amount05 AS Ana10IDAmount05, 
	AT10.Amount06 AS Ana10IDAmount06, AT10.Amount07 AS Ana10IDAmount07, AT10.Amount08 AS Ana10IDAmount08, AT10.Amount09 AS Ana10IDAmount09, AT10.Amount10 AS Ana10IDAmount10,
	
	VoucherDate,
	VoucherTypeID,
	VoucherNo,
	Serial,
	InvoiceNo,
	InvoiceDate,	
	OriginalAmount,
	AT9000.CurrencyID,
	ConvertedAmount,
	DebitAccountID,	
	CreditAccountID,
	T051.AccountName AS DebitAccountName,
	T052.AccountName AS CreditAccountName,
	VDescription,
	BDescription,
	TDescription,
	Quantity,
	AT9000.InventoryID,
	T02.InventoryName,
	AT9000.ObjectID,
	Ob.ObjectName,
	AT9000.CreditObjectID,
	Ob2.ObjectName AS CreditObjectName,
	AT9000.VATObjectID,
	Ob1.ObjectName AS VATObjectName,
	Ob.O01ID, Ob.O02ID, Ob.O03ID, Ob.O04ID, Ob.O05ID,
	A01.AnaName AS O01IDName, A02.AnaName AS O02IDName, A03.AnaName AS O03IDName, A04.AnaName AS O04IDName, A05.AnaName AS O05IDName,
	AT9000.DParameter01, AT9000.DParameter02, AT9000.DParameter03, AT9000.DParameter04, AT9000.DParameter05,
	AT9000.DParameter06, AT9000.DParameter07, AT9000.DParameter08, AT9000.DParameter09, AT9000.DParameter10	
'
set @sqlFrom = N'
FROM	AT9000 WITH (NOLOCK) 
LEFT JOIN AT1005 T051 WITH (NOLOCK) on T051.AccountID = AT9000.DebitAccountID
LEFT JOIN AT1005 T052 WITH (NOLOCK) on T052.AccountID = AT9000.CreditAccountID
Left join AT1302 T02 WITH (NOLOCK) on T02.DivisionID IN (AT9000.DivisionID,''@@@'') AND T02.InventoryID = At9000.InventoryID
Left join AT1202 Ob WITH (NOLOCK)  on  Ob.DivisionID IN (AT9000.DivisionID,''@@@'') AND Ob.ObjectID = At9000.ObjectID
Left join AT1202 Ob1 WITH (NOLOCK) on  Ob1.DivisionID IN (AT9000.DivisionID,''@@@'') AND Ob1.ObjectID = At9000.VATObjectID
Left join AT1202 Ob2 WITH (NOLOCK) on  Ob2.DivisionID IN (AT9000.DivisionID,''@@@'') AND Ob2.ObjectID = AT9000.CreditObjectID
Left join AT1011 AS AT01 WITH (NOLOCK) on AT01.AnaID = AT9000.Ana01ID and AT01.AnaTypeID = ''A01''
Left join AT1011 AS AT02 WITH (NOLOCK) on AT02.AnaID = AT9000.Ana02ID and AT02.AnaTypeID = ''A02''
Left join AT1011 AS AT03 WITH (NOLOCK) on AT03.AnaID = AT9000.Ana03ID and AT03.AnaTypeID = ''A03''
Left join AT1011 AS AT04 WITH (NOLOCK) on AT04.AnaID = AT9000.Ana04ID and AT04.AnaTypeID = ''A04''
Left join AT1011 AS AT05 WITH (NOLOCK) on AT05.AnaID = AT9000.Ana05ID and AT05.AnaTypeID = ''A05''
Left join AT1011 AS AT06 WITH (NOLOCK) on AT06.AnaID = AT9000.Ana06ID and AT06.AnaTypeID = ''A06''
Left join AT1011 AS AT07 WITH (NOLOCK) on AT07.AnaID = AT9000.Ana07ID and AT07.AnaTypeID = ''A07''
Left join AT1011 AS AT08 WITH (NOLOCK) on AT08.AnaID = AT9000.Ana08ID and AT08.AnaTypeID = ''A08''
Left join AT1011 AS AT09 WITH (NOLOCK) on AT09.AnaID = AT9000.Ana09ID and AT09.AnaTypeID = ''A09''
Left join AT1011 AS AT10 WITH (NOLOCK) on AT10.AnaID = AT9000.Ana10ID and AT10.AnaTypeID = ''A10''
Left join AT1015 AS A01 WITH (NOLOCK) on A01.AnaID = Ob.O01ID and A01.AnaTypeID = ''O01''
Left join AT1015 AS A02 WITH (NOLOCK) on A02.AnaID = Ob.O02ID and A02.AnaTypeID = ''O02''
Left join AT1015 AS A03 WITH (NOLOCK) on A03.AnaID = Ob.O03ID and A03.AnaTypeID = ''O03''
Left join AT1015 AS A04 WITH (NOLOCK) on A04.AnaID = Ob.O04ID and A04.AnaTypeID = ''O04''
Left join AT1015 AS A05 WITH (NOLOCK) on A05.AnaID = Ob.O05ID and A05.AnaTypeID = ''O05''
Left join AV6666 on AV6666.DivisionID IN (AT9000.DivisionID,''@@@'') and AV6666.SelectionID = '+@FieldName+'  and AV6666.SelectionType = '''+@AnaTypeID+N'''
'+@sSQLPer +'
WHERE	AT9000.DivisionID '+@StrDivisionID_New+' 
		'+@sWHEREPer+'
		and	( isnull('+@FieldName+N','''')  between N'''+@FromAnaID+N''' and N'''+@ToAnaID+N''' ) and '
set @sqlWhere = ''
If @IsDate =0  --- Theo ky
	Set @sqlWhere = @sqlWhere + '( TranMonth + 100*TranYear between '+str(@FromMonth) +' + 100*'+str(@FromYear)+' and  '+str(@ToMonth) +' + 100*'+str(@ToYear)+')  '
else
	Set @sqlWhere = @sqlWhere + '(CONVERT(DATETIME,CONVERT(VARCHAR(10),AT9000.VoucherDate,101),101)  Between '''+convert(varchar(10), @FromDate,101)+'''  and '''+convert(varchar(10), @ToDate, 101)+''')'
/*
If @IsDebit <>0 
	Set @sSQl = @sSQL + ' and (DebitAccountID between '''+@FromDebitAccountID+''' and '''+@ToDebitAccountID+''' ) '
*/

---Edit by Nguyen Quoc Huy, Donacoop
If @IsDebit <>0  and isnull(@FromDebitAccountID,'') <> '' and isnull(@ToDebitAccountID,'') =''
	Set @sqlWhere = @sqlWhere + N' and (DebitAccountID like  N'''+ @FromDebitAccountID +N''' or  CreditAccountID like N'''+@FromDebitAccountID+N''' ) '
else If @IsDebit <>0  
	Set @sqlWhere = @sqlWhere + N' and (DebitAccountID between N'''+@FromDebitAccountID+N''' and N'''+@ToDebitAccountID+N''' ) '



If @IsCredit <>0 
	Set @sqlWhere = @sqlWhere + N' and (CreditAccountID between N'''+@FromCreditAccountID+N''' and N'''+@ToCreditAccountID+N''' ) '

Set  @sql1Select =   + N' Union ALL
	Select AT9000.DivisionID, Ana01ID AS AnaID, '+@FieldName1+N' AS ReAnaID,
	AV6666.SelectionName AS AnaName,
	AT01.Note01 AS Ana01IDNote01, AT01.Note02 AS Ana01IDNote02, AT01.Note03 AS Ana01IDNote03, AT01.Note04 AS Ana01IDNote04, AT01.Note05 AS Ana01IDNote05,
	AT01.Note06 AS Ana01IDNote06, AT01.Note07 AS Ana01IDNote07, AT01.Note08 AS Ana01IDNote08, AT01.Note09 AS Ana01IDNote09, AT01.Note10 AS Ana01IDNote10,
	AT01.AnaTypeID AS AnaTypeID01, AT01.RefDate AS Ana01IDRefDate, 
	AT01.Amount01 AS Ana01IDAmount01, AT01.Amount02 AS Ana01IDAmount02, AT01.Amount03 AS Ana01IDAmount03, AT01.Amount04 AS Ana01IDAmount04, AT01.Amount05 AS Ana01IDAmount05, 
	AT01.Amount06 AS Ana01IDAmount06, AT01.Amount07 AS Ana01IDAmount07, AT01.Amount08 AS Ana01IDAmount08, AT01.Amount09 AS Ana01IDAmount09, AT01.Amount10 AS Ana01IDAmount10, ' + 
	Case when @IsDebit <>0  and isnull(@FromDebitAccountID,'') <> '' and isnull(@ToDebitAccountID,'') =''
		then	+ N'N''' + isnull(@FromDebitAccountID,'')  + N''''
		Else
			''''''
	End 
    set @sql1Select1 = N' AS AccountID, 
	null AS CreditBankAccountID, null AS DebitBankAccountID,

	AT9000.Ana02ID, AT02.AnaName AS AnaName02,
	AT02.Note01 AS Ana02IDNote01, AT02.Note02 AS Ana02IDNote02, AT02.Note03 AS Ana02IDNote03, AT02.Note04 AS Ana02IDNote04, AT02.Note05 AS Ana02IDNote05,
	AT02.Note06 AS Ana02IDNote06, AT02.Note07 AS Ana02IDNote07, AT02.Note08 AS Ana02IDNote08, AT02.Note09 AS Ana02IDNote09, AT02.Note10 AS Ana02IDNote10,
	AT02.AnaTypeID AS AnaTypeID02, AT02.RefDate AS Ana02IDRefDate, 
	AT02.Amount01 AS Ana02IDAmount01, AT02.Amount02 AS Ana02IDAmount02, AT02.Amount03 AS Ana02IDAmount03, AT02.Amount04 AS Ana02IDAmount04, AT02.Amount05 AS Ana02IDAmount05, 
	AT02.Amount06 AS Ana02IDAmount06, AT02.Amount07 AS Ana02IDAmount07, AT02.Amount08 AS Ana02IDAmount08, AT02.Amount09 AS Ana02IDAmount09, AT02.Amount10 AS Ana02IDAmount10, 

	AT9000.Ana03ID, AT03.AnaName AS AnaName03,
	AT03.Note01 AS Ana03IDNote01, AT03.Note02 AS Ana03IDNote02, AT03.Note03 AS Ana03IDNote03, AT03.Note04 AS Ana03IDNote04, AT03.Note05 AS Ana03IDNote05,
	AT03.Note06 AS Ana03IDNote06, AT03.Note07 AS Ana03IDNote07, AT03.Note08 AS Ana03IDNote08, AT03.Note09 AS Ana03IDNote09, AT03.Note10 AS Ana03IDNote10,
	AT03.AnaTypeID AS AnaTypeID03, AT03.RefDate AS Ana03IDRefDate, 
	AT03.Amount01 AS Ana03IDAmount01, AT03.Amount02 AS Ana03IDAmount02, AT03.Amount03 AS Ana03IDAmount03, AT03.Amount04 AS Ana03IDAmount04, AT03.Amount05 AS Ana03IDAmount05, 
	AT03.Amount06 AS Ana03IDAmount06, AT03.Amount07 AS Ana03IDAmount07, AT03.Amount08 AS Ana03IDAmount08, AT03.Amount09 AS Ana03IDAmount09, AT03.Amount10 AS Ana03IDAmount10, 

	AT9000.Ana04ID, AT04.AnaName AS AnaName04,
	AT04.Note01 AS Ana04IDNote01, AT04.Note02 AS Ana04IDNote02, AT04.Note03 AS Ana04IDNote03, AT04.Note04 AS Ana04IDNote04, AT04.Note05 AS Ana04IDNote05,
	AT04.Note06 AS Ana04IDNote06, AT04.Note07 AS Ana04IDNote07, AT04.Note08 AS Ana04IDNote08, AT04.Note09 AS Ana04IDNote09, AT04.Note10 AS Ana04IDNote10,
	AT04.AnaTypeID AS AnaTypeID04, AT04.RefDate AS Ana04IDRefDate, 
	AT04.Amount01 AS Ana04IDAmount01, AT04.Amount02 AS Ana04IDAmount02, AT04.Amount03 AS Ana04IDAmount03, AT04.Amount04 AS Ana04IDAmount04, AT04.Amount05 AS Ana04IDAmount05, 
	AT04.Amount06 AS Ana04IDAmount06, AT04.Amount07 AS Ana04IDAmount07, AT04.Amount08 AS Ana04IDAmount08, AT04.Amount09 AS Ana04IDAmount09, AT04.Amount10 AS Ana04IDAmount10, 

	AT9000.Ana05ID, AT05.AnaName AS AnaName05,
	AT05.Note01 AS Ana05IDNote01, AT05.Note02 AS Ana05IDNote02, AT05.Note03 AS Ana05IDNote03, AT05.Note04 AS Ana05IDNote04, AT05.Note05 AS Ana05IDNote05,
	AT05.Note06 AS Ana05IDNote06, AT05.Note07 AS Ana05IDNote07, AT05.Note08 AS Ana05IDNote08, AT05.Note09 AS Ana05IDNote09, AT05.Note10 AS Ana05IDNote10,
	AT05.AnaTypeID AS AnaTypeID05, AT05.RefDate AS Ana05IDRefDate, 
	AT05.Amount01 AS Ana05IDAmount01, AT05.Amount02 AS Ana05IDAmount02, AT05.Amount03 AS Ana05IDAmount03, AT05.Amount04 AS Ana05IDAmount04, AT05.Amount05 AS Ana05IDAmount05, 
	AT05.Amount06 AS Ana05IDAmount06, AT05.Amount07 AS Ana05IDAmount07, AT05.Amount08 AS Ana05IDAmount08, AT05.Amount09 AS Ana05IDAmount09, AT05.Amount10 AS Ana05IDAmount10, 

	AT9000.Ana06ID, AT06.AnaName AS AnaName06,
	AT06.Note01 AS Ana06IDNote01, AT06.Note02 AS Ana06IDNote02, AT06.Note03 AS Ana06IDNote03, AT06.Note04 AS Ana06IDNote04, AT06.Note05 AS Ana06IDNote05,
	AT06.Note06 AS Ana06IDNote06, AT06.Note07 AS Ana06IDNote07, AT06.Note08 AS Ana06IDNote08, AT06.Note09 AS Ana06IDNote09, AT06.Note10 AS Ana06IDNote10,
	AT06.AnaTypeID AS AnaTypeID06, AT06.RefDate AS Ana06IDRefDate, 
	AT06.Amount01 AS Ana06IDAmount01, AT06.Amount02 AS Ana06IDAmount02, AT06.Amount03 AS Ana06IDAmount03, AT06.Amount04 AS Ana06IDAmount04, AT06.Amount05 AS Ana06IDAmount05, 
	AT06.Amount06 AS Ana06IDAmount06, AT06.Amount07 AS Ana06IDAmount07, AT06.Amount08 AS Ana06IDAmount08, AT06.Amount09 AS Ana06IDAmount09, AT06.Amount10 AS Ana06IDAmount10,
	
	AT9000.Ana07ID, AT07.AnaName AS AnaName07,
	AT07.Note01 AS Ana07IDNote01, AT07.Note02 AS Ana07IDNote02, AT07.Note03 AS Ana07IDNote03, AT07.Note04 AS Ana07IDNote04, AT07.Note05 AS Ana07IDNote05,
	AT07.Note06 AS Ana07IDNote06, AT07.Note07 AS Ana07IDNote07, AT07.Note08 AS Ana07IDNote08, AT07.Note09 AS Ana07IDNote09, AT07.Note10 AS Ana07IDNote10,
	AT07.AnaTypeID AS AnaTypeID07, AT07.RefDate AS Ana07IDRefDate, 
	AT07.Amount01 AS Ana07IDAmount01, AT07.Amount02 AS Ana07IDAmount02, AT07.Amount03 AS Ana07IDAmount03, AT07.Amount04 AS Ana07IDAmount04, AT07.Amount05 AS Ana07IDAmount05, 
	AT07.Amount06 AS Ana07IDAmount06, AT07.Amount07 AS Ana07IDAmount07, AT07.Amount08 AS Ana07IDAmount08, AT07.Amount09 AS Ana07IDAmount09, AT07.Amount10 AS Ana07IDAmount10,
	
	AT9000.Ana08ID, AT08.AnaName AS AnaName08,
	AT08.Note01 AS Ana08IDNote01, AT08.Note02 AS Ana08IDNote02, AT08.Note03 AS Ana08IDNote03, AT08.Note04 AS Ana08IDNote04, AT08.Note05 AS Ana08IDNote05,
	AT08.Note06 AS Ana08IDNote06, AT08.Note07 AS Ana08IDNote07, AT08.Note08 AS Ana08IDNote08, AT08.Note09 AS Ana08IDNote09, AT08.Note10 AS Ana08IDNote10,
	AT08.AnaTypeID AS AnaTypeID08, AT08.RefDate AS Ana08IDRefDate, 
	AT08.Amount01 AS Ana08IDAmount01, AT08.Amount02 AS Ana08IDAmount02, AT08.Amount03 AS Ana08IDAmount03, AT08.Amount04 AS Ana08IDAmount04, AT08.Amount05 AS Ana08IDAmount05, 
	AT08.Amount06 AS Ana08IDAmount06, AT08.Amount07 AS Ana08IDAmount07, AT08.Amount08 AS Ana08IDAmount08, AT08.Amount09 AS Ana08IDAmount09, AT08.Amount10 AS Ana08IDAmount10,
	
	AT9000.Ana09ID, AT09.AnaName AS AnaName09,
	AT09.Note01 AS Ana09IDNote01, AT09.Note02 AS Ana09IDNote02, AT09.Note03 AS Ana09IDNote03, AT09.Note04 AS Ana09IDNote04, AT09.Note05 AS Ana09IDNote05,
	AT09.Note06 AS Ana09IDNote06, AT09.Note07 AS Ana09IDNote07, AT09.Note08 AS Ana09IDNote08, AT09.Note09 AS Ana09IDNote09, AT09.Note10 AS Ana09IDNote10,
	AT09.AnaTypeID AS AnaTypeID09, AT09.RefDate AS Ana09IDRefDate, 
	AT09.Amount01 AS Ana09IDAmount01, AT09.Amount02 AS Ana09IDAmount02, AT09.Amount03 AS Ana09IDAmount03, AT09.Amount04 AS Ana09IDAmount04, AT09.Amount05 AS Ana09IDAmount05, 
	AT09.Amount06 AS Ana09IDAmount06, AT09.Amount07 AS Ana09IDAmount07, AT09.Amount08 AS Ana09IDAmount08, AT09.Amount09 AS Ana09IDAmount09, AT09.Amount10 AS Ana09IDAmount10,
	
	AT9000.Ana10ID, AT10.AnaName AS AnaName10,
	AT10.Note01 AS Ana10IDNote01, AT10.Note02 AS Ana10IDNote02, AT10.Note03 AS Ana10IDNote03, AT10.Note04 AS Ana10IDNote04, AT10.Note05 AS Ana10IDNote05,
	AT10.Note06 AS Ana10IDNote06, AT10.Note07 AS Ana10IDNote07, AT10.Note08 AS Ana10IDNote08, AT10.Note09 AS Ana10IDNote09, AT10.Note10 AS Ana10IDNote10,
	AT10.AnaTypeID AS AnaTypeID10, AT10.RefDate AS Ana10IDRefDate, 
	AT10.Amount01 AS Ana10IDAmount01, AT10.Amount02 AS Ana10IDAmount02, AT10.Amount03 AS Ana10IDAmount03, AT10.Amount04 AS Ana10IDAmount04, AT10.Amount05 AS Ana10IDAmount05, 
	AT10.Amount06 AS Ana10IDAmount06, AT10.Amount07 AS Ana10IDAmount07, AT10.Amount08 AS Ana10IDAmount08, AT10.Amount09 AS Ana10IDAmount09, AT10.Amount10 AS Ana10IDAmount10,
	
	VoucherDate,
	VoucherTypeID,
	VoucherNo,
	Serial,
	InvoiceNo,
	InvoiceDate,	
	OriginalAmount,
	AT9000.CurrencyID,
	ConvertedAmount,
	DebitAccountID,	
	CreditAccountID,
	T051.AccountName AS DebitAccountName,
	T052.AccountName AS CreditAccountName,
	Description AS VDescription,
	Description AS BDescription,
	Description AS TDescription,
	Quantity,
	AT9000.InventoryID,
	T02.InventoryName,
	AT9000.ObjectID,
	Ob.ObjectName,
	NULL AS CreditObjectID,
	NULL AS CreditObjectName,
	AT9000.ObjectID AS VATObjectID,
	Ob.ObjectName AS VATObjectName,
	Ob.O01ID, Ob.O02ID, Ob.O03ID, Ob.O04ID, Ob.O05ID,
	A01.AnaName AS O01IDName, A02.AnaName AS O02IDName, A03.AnaName AS O03IDName, A04.AnaName AS O04IDName, A05.AnaName AS O05IDName,
	NULL as DParameter01, NULL as DParameter02, NULL as DParameter03, NULL as DParameter04, NULL as DParameter05,
	NULL as DParameter06, NULL as DParameter07, NULL as DParameter08, NULL as DParameter09, NULL as DParameter10			
'
set @sql1From = N'
FROM AT9001 AS AT9000 WITH (NOLOCK) 	
LEFT JOIN AT1005 T051 WITH (NOLOCK) on T051.AccountID = AT9000.DebitAccountID
LEFT JOIN AT1005 T052 WITH (NOLOCK) on T052.AccountID = AT9000.CreditAccountID
Left join AT1302 T02 WITH (NOLOCK) on T02.DivisionID IN (AT9000.DivisionID,''@@@'') AND T02.InventoryID = At9000.InventoryID
Left join AT1202 Ob WITH (NOLOCK) on  Ob.DivisionID IN (AT9000.DivisionID,''@@@'') AND Ob.ObjectID = At9000.ObjectID
Left join AT1011 AS AT01 WITH (NOLOCK) on AT01.AnaID = AT9000.Ana01ID and AT01.AnaTypeID = ''A01''
Left join AT1011 AS AT02 WITH (NOLOCK) on AT02.AnaID = AT9000.Ana02ID and AT02.AnaTypeID = ''A02''
Left join AT1011 AS AT03 WITH (NOLOCK) on AT03.AnaID = AT9000.Ana03ID and AT03.AnaTypeID = ''A03''
Left join AT1011 AS AT04 WITH (NOLOCK) on AT04.AnaID = AT9000.Ana04ID and AT04.AnaTypeID = ''A04''
Left join AT1011 AS AT05 WITH (NOLOCK) on AT05.AnaID = AT9000.Ana05ID and AT05.AnaTypeID = ''A05''
Left join AT1011 AS AT06 WITH (NOLOCK) on AT06.AnaID = AT9000.Ana06ID and AT06.AnaTypeID = ''A06''
Left join AT1011 AS AT07 WITH (NOLOCK) on AT07.AnaID = AT9000.Ana07ID and AT07.AnaTypeID = ''A07''
Left join AT1011 AS AT08 WITH (NOLOCK) on AT08.AnaID = AT9000.Ana08ID and AT08.AnaTypeID = ''A08''
Left join AT1011 AS AT09 WITH (NOLOCK) on AT09.AnaID = AT9000.Ana09ID and AT09.AnaTypeID = ''A09''
Left join AT1011 AS AT10 WITH (NOLOCK) on AT10.AnaID = AT9000.Ana10ID and AT10.AnaTypeID = ''A10''
Left join AT1015 AS A01 WITH (NOLOCK) on A01.AnaID = Ob.O01ID and A01.AnaTypeID = ''O01''
Left join AT1015 AS A02 WITH (NOLOCK) on A02.AnaID = Ob.O02ID and A02.AnaTypeID = ''O02''
Left join AT1015 AS A03 WITH (NOLOCK) on A03.AnaID = Ob.O03ID and A03.AnaTypeID = ''O03''
Left join AT1015 AS A04 WITH (NOLOCK) on A04.AnaID = Ob.O04ID and A04.AnaTypeID = ''O04''
Left join AT1015 AS A05 WITH (NOLOCK) on A05.AnaID = Ob.O05ID and A05.AnaTypeID = ''O05''
Left join AV6666 on AV6666.DivisionID IN (AT9000.DivisionID,''@@@'') and AV6666.SelectionID = '+@FieldName+N'  and AV6666.SelectionType = N'''+@AnaTypeID+N'''
'+@sSQLPer+'
WHERE	AT9000.DivisionID '+@StrDivisionID_New+' 
		'+@sWHEREPer+'
		and	( isnull('+@FieldName+N','''')  between N'''+@FromAnaID+N''' and N'''+@ToAnaID+N''' ) and '

set @sql1Where = ''
If @IsDate =0  --- Theo ky
	Set @sql1Where = @sql1Where + '( TranMonth + 100*TranYear between '+str(@FromMonth) +' + 100*'+str(@FromYear)+' and  '+str(@ToMonth) +' + 100*'+str(@ToYear)+')  '
else
	Set @sql1Where = @sql1Where + '(CONVERT(DATETIME,CONVERT(VARCHAR(10),AT9000.VoucherDate,101),101)  Between '''+convert(varchar(10), @FromDate,101)+'''  and '''+convert(varchar(10), @ToDate, 101)+''')'

/*
If @IsDebit <>0 
	Set @sSQl = @sSQL + ' and (DebitAccountID between '''+@FromDebitAccountID+''' and '''+@ToDebitAccountID+''' ) '
*/

---Edit by Nguyen Quoc Huy, Donacoop
If @IsDebit <>0  and isnull(@FromDebitAccountID,'') <> '' and isnull(@ToDebitAccountID,'') =''
	Set @sql1Where = @sql1Where + N' and (DebitAccountID like  N'''+@FromDebitAccountID+N''' or  CreditAccountID like N'''+@FromDebitAccountID+''' ) '
else If @IsDebit <>0  
	Set @sql1Where = @sql1Where + ' and (DebitAccountID between '''+@FromDebitAccountID+''' and '''+@ToDebitAccountID+''' ) '

If @IsCredit <>0 
	Set @sql1Where = @sql1Where + ' and (CreditAccountID between '''+@FromCreditAccountID+''' and '''+@ToCreditAccountID+''' ) '

Set @sql1Where = @sql1Where + '
	) X
	ORDER BY X.AnaID, X.VoucherDate
	'
/*
print 'CREATE VIEW AV6003 AS ' +  @sqlSelect 
print @sqlSelect1 + isnull(@sqlFrom,'') + isnull(@sqlWhere,'') + @sql1Select + @sql1Select1 + @sql1From + @sql1Where
*/

PRINT(@sqlSelect)
PRINT(@sqlSelect1)
PRINT( @sqlFrom )
PRINT( @sqlWhere )
PRINT( @sql1Select)
PRINT( @sql1Select1)
PRINT( @sql1From )
PRINT( @sql1Where)

--IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE SYSOBJECTS.NAME = 'AV6003' AND SYSOBJECTS.XTYPE = 'V')
--	EXEC ('CREATE VIEW AV6003 AS ' +  @sqlSelect + @sqlSelect1 + @sqlFrom + @sqlWhere + @sql1Select + @sql1Select1 + @sql1From + @sql1Where)
--ELSE
--	EXEC ('ALTER VIEW AV6003 AS ' +  @sqlSelect + @sqlSelect1 + @sqlFrom + @sqlWhere + @sql1Select + @sql1Select1 + @sql1From + @sql1Where)

EXEC (@sqlSelect + @sqlSelect1 + @sqlFrom + @sqlWhere + @sql1Select + @sql1Select1 + @sql1From + @sql1Where)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
