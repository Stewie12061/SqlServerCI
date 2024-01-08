IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0308]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0308]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Nguyen Van Nhan.
---- Date 12/02/2004.
---- purpose: In bao cao chi tiet doi chieu cong no
---- Edited by Nguyen Quoc Huy.
---- Edit by: Dang Le Bao Quynh; Date 05/10/2009
---- Purpose: Bo sung 5 truong ten ma phan tich doi tuong,PhoneNumber, Contactor, DueDate
---- Edit by B.Anh, date 27/12/2009	Lay ten MPT va VATNo
--- Edit by B.Anh, date 26/04/2010	Bo sung MPT mat hang
---- Modify on 25/04/2013 by bao Anh: Sua loi khong len du lieu khi 1 doi tuong chi co so du,kg co phat sinh (Sieu Thanh - 0020460)
---- Modified on 27/05/2013 by Lê Thị Thu Hiền : Bổ sung Ana06ID --> Ana10ID
---- Modified on 06/06/2013 by Lê Thị Thu Hiền : Thêm @sSQL1, LEFT JOIN chứ không NOT IN
---- Modified on 09/09/2013 by Lê Thị Thu Hiền : Join them dieu kien AccountID
---- Modified by Hải Long on 17/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Phương Thảo on 06/10/2017: Cải tiến tốc độ
---- Modified by Bảo Anh on 12/04/2018: Bổ sung GiveUpDate
---- Modified by Đức Thông on 16/12/2020: Thêm biến @SqlFilter: Câu where lấy từ mh AF0013 khi bấm nút lọc
---- Modified by Đức Thông on 15/01/2021: [KHV] 2021/01/IS/0175: Kéo thêm trường thông tin kinh doanh lên báo cáo đối chiếu công nợ phải thu
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE [dbo].[AP0308] 
		@DivisionID AS nvarchar(50), 
		@FromObjectID  AS nvarchar(50),  
		@ToObjectID  AS nvarchar(50),  
		@FromAccountID  AS nvarchar(50),  
		@ToAccountID  AS nvarchar(50),  
		@CurrencyID  AS nvarchar(50),  
		@FromInventoryID AS nvarchar(50),
		@ToInventoryID AS nvarchar(50),
		@IsDate AS tinyint, 
		@FromMonth AS int, 
		@FromYear  AS int,  
		@ToMonth AS int,
		@ToYear AS int,
		@FromDate AS Datetime, 
		@ToDate AS Datetime,
		@ReportID AS Nvarchar(50) = 'AR0310',
		@SqlFilter AS Nvarchar(250) = ''

AS

DECLARE @sSQL AS NVARCHAR(MAX),
		@sSQL1 AS NVARCHAR(MAX),
		@sSQL2 AS NVARCHAR(MAX),
		@sSQL3 AS NVARCHAR(MAX),
		@CurrencyName AS NVARCHAR(MAX),
		@SQLString AS NVARCHAR(250),
		@SQLOrderby AS NVARCHAR(250),
		@CustomerName INT

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

Set @CurrencyName = (CASE WHEN  ISNULL(@CurrencyID,'') ='%' then N'Tất cả' else ISNULL(@CurrencyID,'') End) 

----- Xac dinh so du.

	Exec AP0328 @DivisionID, @FromObjectID, @ToObjectID, @FromAccountID, @ToAccountID, @CurrencyID, @FromInventoryID, 
			@ToInventoryID, @IsDate, @FromMonth, @FromYear, @FromDate

----- Xac dinh so phat sinh 
	Exec AP0318 @DivisionID, @FromObjectID, @ToObjectID, @FromAccountID, @ToAccountID, @CurrencyID,  @FromInventoryID, 
			@ToInventoryID, @IsDate, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate


Set @sSQL= N'
SELECT 	AV0318.Orders,
		AV0318.TransactionTypeID,
		ISNULL(AV0318.ObjectID, AV0328.ObjectID) AS GroupID,
		ISNULL(AV0318.ObjectName, AV0328.ObjectName) AS GroupName,
		AV0318.PhoneNumber,
		AV0318.Contactor,
		N'''+@CurrencyName+''' AS CurrencyID,
		DebitAccountID, CreditAccountID,
		VoucherDate,
		DueDate,
		VoucherNo,
		VoucherTypeID,
		AV0318.Ana01ID, AV0318.Ana02ID, AV0318.Ana03ID, AV0318.Ana04ID, AV0318.Ana05ID,
		AV0318.Ana06ID, AV0318.Ana07ID, AV0318.Ana08ID, AV0318.Ana09ID, AV0318.Ana10ID,
		AV0318.O01ID, AV0318.O02ID, AV0318.O03ID, AV0318.O04ID, AV0318.O05ID, 
		AV0318.O01Name, AV0318.O02Name, AV0318.O03Name, AV0318.O04Name, AV0318.O05Name, 
		AV0318.I01ID, AV0318.I02ID, AV0318.I03ID, AV0318.I04ID, AV0318.I05ID, 
		AV0318.I01Name, AV0318.I02Name, AV0318.I03Name, AV0318.I04Name, AV0318.I05Name,
		AV0318.VATRate,
		InvoiceDate,
		InvoiceNo,
		Serial,
		AV0318.InventoryID,
		AV0318.UnitID,
		AV0318.InventoryName,VDescription, TDescription,
		DebitQuantity,
		DebitUnitPrice,
		ISNULL(DebitOriginalAmount,0) AS DebitOriginalAmount,
		ISNULL(DebitConvertedAmount,0) AS DebitConvertedAmount,
		ISNULL(CreditOriginalAmount,0) AS CreditOriginalAmount,
		ISNULL(CreditConvertedAmount,0) AS CreditConvertedAmount,
		ISNULL(OpeningConvertedAmount,0) AS OpeningConvertedAmount,
		ISNULL(OpeningOriginalAmount,0) AS OpeningOriginalAmount,
		ISNULL(CreditQuantity,0) AS CreditQuantity,
		ISNULL(AV0318.DivisionID,AV0328.DivisionID) AS DivisionID,
		AV0318.RefInfor	-- thông tin kinh doanh
		'

IF @CustomerName = 45 --- Karaben
	Set @sSQL= @sSQL + ', AV0318.GiveUpDate'

Set @sSQL= @sSQL + '
INTO #AP0308_AV0314
FROM	AV0318
FULL JOIN AV0328 on AV0318.ObjectID = AV0328.ObjectID 
		and AV0318.DivisionID = AV0328.DivisionID
		AND (AV0318.DebitAccountID = AV0328.AccountID OR AV0318.CreditAccountID = AV0328.AccountID)'

-- Thêm đk lọc ở nút lọc trên mh in
SET @sSQL = @sSQL + @SqlFilter

--IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV0314]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
--	EXEC ('  CREATE VIEW AV0314 --AP0308
--		AS ' + @sSQL)
--ELSE
--	EXEC ('  ALTER VIEW AV0314 --AP0308
--		AS ' + @sSQL)

Set @sSQL1 = N' 
SELECT *
INTO #AP0308_Result
FROM
(
	SELECT 	AV0314.Orders,
			AV0314.TransactionTypeID,
			GroupID, GroupName, AT1202.Address, AT1202.Tel, AT1202.Fax, AT1202.VATNo,
			AV0314.PhoneNumber,
			AV0314.Contactor,
			AV0314.CurrencyID, 
			DebitAccountID, CreditAccountID,
			VoucherDate, DueDate, VoucherNo, VoucherTypeID, 
			AV0314.Ana01ID, AV0314.Ana02ID, AV0314.Ana03ID, AV0314.Ana04ID, AV0314.Ana05ID,
			AV0314.Ana06ID, AV0314.Ana07ID, AV0314.Ana08ID, AV0314.Ana09ID, AV0314.Ana10ID,
			A1.AnaName AS Ana01Name, A2.AnaName AS Ana02Name, A3.AnaName AS Ana03Name, A4.AnaName AS Ana04Name, A5.AnaName AS Ana05Name,
			A6.AnaName AS Ana06Name, A7.AnaName AS Ana07Name, A8.AnaName AS Ana08Name, A9.AnaName AS Ana09Name, A10.AnaName AS Ana10Name,
			AV0314.O01ID, AV0314.O02ID, AV0314.O03ID, AV0314.O04ID, AV0314.O05ID, 
			AV0314.O01Name, AV0314.O02Name, AV0314.O03Name, AV0314.O04Name, AV0314.O05Name, 
			AV0314.I01ID, AV0314.I02ID, AV0314.I03ID, AV0314.I04ID, AV0314.I05ID, 
			AV0314.I01Name, AV0314.I02Name, AV0314.I03Name, AV0314.I04Name, AV0314.I05Name,
			AV0314.VATRate,
			InvoiceDate,InvoiceNo, Serial, AV0314.InventoryID, AV0314.UnitID, AV0314.InventoryName,VDescription, TDescription,
			DebitQuantity, DebitUnitPrice, DebitOriginalAmount, DebitConvertedAmount,
			CreditOriginalAmount, CreditConvertedAmount,
			OpeningConvertedAmount, OpeningOriginalAmount, CreditQuantity, AV0314.DivisionID,
			AV0314.RefInfor -- thông tin kinh doanh
			'

IF @CustomerName = 45 --- Karaben
	Set @sSQL1= @sSQL1 + ', AV0314.GiveUpDate'
	
Set @sSQL1= @sSQL1 + '
	FROM	#AP0308_AV0314 AV0314 
	LEFT JOIN AT1202 on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV0314.GroupID
	LEFT JOIN AT1011 A1 on AV0314.Ana01ID = A1.AnaID and A1.AnaTypeID = ''A01'' 
	LEFT JOIN AT1011 A2 on AV0314.Ana02ID = A2.AnaID and A2.AnaTypeID = ''A02'' 
	LEFT JOIN AT1011 A3 on AV0314.Ana03ID = A3.AnaID and A3.AnaTypeID = ''A03'' 
	LEFT JOIN AT1011 A4 on AV0314.Ana04ID = A4.AnaID and A4.AnaTypeID = ''A04'' 
	LEFT JOIN AT1011 A5 on AV0314.Ana05ID = A5.AnaID and A5.AnaTypeID = ''A05'' 
	LEFT JOIN AT1011 A6 on AV0314.Ana06ID = A6.AnaID and A6.AnaTypeID = ''A06'' 
	LEFT JOIN AT1011 A7 on AV0314.Ana07ID = A7.AnaID and A7.AnaTypeID = ''A07'' 
	LEFT JOIN AT1011 A8 on AV0314.Ana08ID = A8.AnaID and A8.AnaTypeID = ''A08'' 
	LEFT JOIN AT1011 A9 on AV0314.Ana09ID = A9.AnaID and A9.AnaTypeID = ''A09''
	LEFT JOIN AT1011 A10 on AV0314.Ana10ID = A10.AnaID and A10.AnaTypeID = ''A10''
'
SET @sSQL2 = N'
	UNION ALL
	SELECT  0 AS Orders,
			''''  AS TransactionTypeID, 
			AV0328.ObjectID AS GroupID,  AV0328.ObjectName AS GroupName,
			AT1202.Address, AT1202.Tel, AT1202.Fax, AT1202.VATNo,
			AT1202.PhoneNumber,
			AT1202.Contactor,
			N'''+@CurrencyName+''' AS CurrencyID,
			NULL AS DebitAccountID, 
			NULL AS CreditAccountID,
			NULL AS VoucherDate, NULL AS DueDate, NULL AS VoucherNo,
			NULL AS VoucherTypeID,
			NULL AS Ana01ID, 
			NULL AS Ana02ID, 
			NULL AS Ana03ID, 
			NULL AS Ana04ID,
			NULL AS Ana05ID,
			NULL AS Ana06ID, 
			NULL AS Ana07ID, 
			NULL AS Ana08ID, 
			NULL AS Ana09ID,
			NULL AS Ana10ID,
			NULL AS Ana01Name,
			NULL AS Ana02Name,
			NULL AS Ana03Name,
			NULL AS Ana04Name,
			NULL AS Ana05Name,
			NULL AS Ana06Name,
			NULL AS Ana07Name,
			NULL AS Ana08Name,
			NULL AS Ana09Name,
			NULL AS Ana10Name,
			NULL AS O01ID, 
			NULL AS O02ID, 
			NULL AS O03ID, 
			NULL AS O04ID, 
			NULL AS O05ID, 
			NULL AS O01Name, 
			NULL AS O02Name, 
			NULL AS O03Name, 
			NULL AS O04Name, 
			NULL AS O05Name, 
			NULL AS I01ID, 
			NULL AS I02ID, 
			NULL AS I03ID, 
			NULL AS I04ID, 
			NULL AS I05ID, 
			NULL AS I01Name, 
			NULL AS I02Name, 
			NULL AS I03Name, 
			NULL AS I04Name, 
			NULL AS I05Name,
			NULL AS VATRate,
			NULL AS InvoiceDate,
			NULL AS InvoiceNo,
			NULL AS Serial,
			NULL AS InventoryID,
			NULL AS UnitID,
			NULL AS InventoryName, '''' AS VDescription, '''' AS TDescription,
			0 AS DebitQuantity,
			0 AS DebitUnitPrice,
			0 AS DebitOriginalAmount,
			0 AS DebitConvertedAmount,
			0 AS CreditOriginalAmount,
			0 AS CreditConvertedAmount,
			ISNULL(AV0328.OpeningConvertedAmount,0) AS OpeningConvertedAmount,
			ISNULL(AV0328.OpeningOriginalAmount,0) AS OpeningOriginalAmount,
			0 AS CreditQuantity, AV0328.DivisionID,
			AV0314.RefInfor -- thông tin kinh doanh
			'

IF @CustomerName = 45 --- Karaben
	Set @sSQL2= @sSQL2 + ', NULL as GiveUpDate'
	
Set @sSQL2= @sSQL2 + '
	FROM	AV0328 
	LEFT JOIN AT1202 on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV0328.ObjectID
	LEFT JOIN #AP0308_AV0314 AV0314 ON AV0314.DivisionID = AV0328.DivisionID AND AV0314.GroupID = AV0328.ObjectID
	WHERE	AV0328.ObjectID <> AV0314.GroupID
			-- AV0328.ObjectID NOT IN (SELECT DISTINCT GroupID FROM AV0314) 
			AND (AV0328.OpeningConvertedAmount >0)
) T			
			
			'
select @SQLString = Replace(Replace(SQLString,'AV0310','#AP0308_Result'),'@DivisionID',''''+@DivisionID+''''),
	   @SQLOrderby = Orderby
from AT8888 
where DivisionID = @DivisionID AND GroupID='G03' And Disabled=0 AND ReportID = @ReportID

--PRINT(@sSQL)
--PRINT(@sSQL1)
--IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV0310]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
--	EXEC ('  CREATE VIEW AV0310 --AP0308
--		AS ' + @sSQL + @sSQL1)
--ELSE
--	EXEC ('  ALTER VIEW AV0310   --AP0308
--		AS ' + @sSQL + @sSQL1)

--print @sSQL
--print @sSQL1
--print @sSQL2
--print @SQLString
--print @SQLOrderby

exec( @sSQL + @sSQL1 + @sSQL2+@SQLString+@SQLOrderby)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

