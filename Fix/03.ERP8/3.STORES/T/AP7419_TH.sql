IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7419_TH]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7419_TH]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


------ Created by Nguyen Van Nhan, Date 29/08/2003
------ In bang ke dau vao, ra
------ Last Edit ThuyTuyen  Them VATTypeID4, VATGroupID4, Date 26/10/2007
------ Edeit theo thong tu 13/2009, Thuy tuyen
------ Edit by: Dang Le Bao Quynh; Date: 14/10/2009
------ Purpose: Bo sung truong ngay dao han, xu ly hoa don hang mua tra lai, but toan chiet khau
--------- Last edit by B.Anh, date 08/12/2009	Sua cho truong hop co' nhieu nhom thue
--------- Last edit by B.Anh, date 11/01/2010	Sua loi doanh so len sai khi hang mua tra lai
--- Edit by To Oanh, date 08/08/2013: Hieu chinh data null

/********************************************
'* Edited by: [GS] [Ngọc Nhựt] [29/07/2010]
'********************************************/
---- Modified on 30/07/2013 by Le Thi Thu Hien : Cai thien toc do Không sử dụng View AV4300
---- Modified on 20/09/2013 by Thien Huynh : 2  loại hóa đơn VHDSD  và VGTGT1 cùng 1 group
---- Modified on 11/02/2014 by Thanh Sơn: Lấy thêm 2 cột InvID và InvSign
	--Để bảng kê đầu vào (bao gồm Xuất Excel)thể hiện 2 loại hóa đơn VHDSD  và VGTGT1  trên nhóm 1
---- Modified on 21/09/2015 by Tiểu Mai: Bổ sung thông tin tài khoản Nợ, tài khoản Có
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Hải Long on 26/12/2016: Lấy thêm InventoryID (ANGEL)
---- Modified by Kim Thư on 09/01/2019: Lấy hóa đơn hủy, hóa đơn thay thế và hóa đơn bị thay thế
---- Modified by Kim Thư on 12/02/2019: Bổ sung Ana06ID và Ana06Name (Bason - 84)
---- Modified by Nhựt Trường on 28/09/2020: Bổ sung chuỗi @SQL4 và cắt bớt độ dài của của chuỗi @SQL2.
---- Modified by Nhựt Trường on 17/06/2021: Bổ sung TypeOfAdjust.
---- Modified by Nhựt Trường on 05/07/2021: Bổ sung Ana02ID và Ana02Name (Phúc Long - 32).
---- Modified by Nhựt Trường on 05/07/2021: Mở Ana02ID và Ana02Name ra chuẩn.
---- Modified by Nhựt Trường on 26/07/2021: Bổ sung check thêm điều kiện AnaTypeID = ''A02'' khi join bảng AT1011 A2.
---- Modified by Huỳnh Thử on 10/08/2021: Tách Store Phúc Long
---- Modified by Xuân Nguyên on 10/08/2021: Tách Store SAVI
---- Modified by Nhựt Trường on 10/01/2022: [2022/01/IS/0061] - Bổ sung VATGroupID6, VATGroupID7.
---- Modified by Nhựt Trường on 23/03/2022: Bổ sung VATTypeID6, VATTypeID7.
---- Modified by Nhựt Trường on 13/04/2022: Bổ sung InventoryID, InventoryName, UnitID, Quantity, UnitPrice.
---- Modified by Nhựt Trường on 08/06/2022: [2021/06/IS/0174] - Bỏ Ana02ID và Ana02Name ra khỏi chuẩn.
---- Modified by Thanh Lượng on 30/11/2022: [2022/11/IS/0252] - Bổ sung thêm điều kiện Case When để lấy đúng đối tượng "VATObjectID".
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE [dbo].[AP7419_TH]
			@DivisionID AS NVARCHAR(50),
			@TranMonthFrom AS INT,
			@TranYearFrom AS INT,
			@TranMonthTo AS INT,
			@TranYearTo AS INT,
			@ReportCode AS NVARCHAR(50)
AS

SET NOCOUNT ON

DECLARE @strSQL NVARCHAR(MAX)='',
		@PeriodFrom INT,
		@PeriodTo INT,
		@TableSQL NVARCHAR(MAX),
		@CustomerName INT


DECLARE @TaxAccountID1From AS NVARCHAR(50),
		@TaxAccountID1To AS NVARCHAR(50),
		@TaxAccountID2From AS NVARCHAR(50),
		@TaxAccountID2To AS NVARCHAR(50),
		@TaxAccountID3From AS NVARCHAR(50),
		@TaxAccountID3To AS NVARCHAR(50),
		@NetAccountID1From AS NVARCHAR(50),	
		@NetAccountID1To AS NVARCHAR(50),	
		@NetAccountID2From AS NVARCHAR(50),	
		@NetAccountID2To AS NVARCHAR(50),	
		@NetAccountID3From AS NVARCHAR(50),	
		@NetAccountID3To AS NVARCHAR(50),	
		@NetAccountID4From AS NVARCHAR(50),	
		@NetAccountID4To AS NVARCHAR(50),	
		@CreateUserIDFrom AS NVARCHAR(50),
		@NetAccountID5From AS NVARCHAR(50),	
		@NetAccountID5To AS NVARCHAR(50),			
		@CreateUserIDTo AS NVARCHAR(50),
		@VoucherTypeIDFrom AS NVARCHAR(50),
		@VoucherTypeIDTo AS NVARCHAR(50),
		@VATTypeID AS NVARCHAR(50),
		@VATGroupIDFrom AS NVARCHAR(50),
		@VATGroupIDTo AS NVARCHAR(50),
		@VATObjectIDFrom AS NVARCHAR(50),			
		@VATObjectIDTo AS NVARCHAR(50),
		@VATTypeID1  AS NVARCHAR(50),
		@VATTypeID2  AS NVARCHAR(50),
		@VATTypeID3  AS NVARCHAR(50),
		@VATTypeID4  AS NVARCHAR(50),
		@VATTypeID5  AS NVARCHAR(50),
		@VATTypeID6  AS NVARCHAR(50),
		@VATTypeID7  AS NVARCHAR(50),
		@IsVATIn AS tinyint,
		@IsTax AS tinyint,
		@IsVATType AS tinyint,
		@IsVATGroup AS tinyint,
		@VATGroupID1 AS NVARCHAR(50),
		@VATGroupID2 AS NVARCHAR(50),
		@VATGroupID3 AS NVARCHAR(50),
		@VATGroupID4 AS NVARCHAR(50),
		@VATGroupID5 AS NVARCHAR(50),
		@VATGroupID6 AS NVARCHAR(50),
		@VATGroupID7 AS NVARCHAR(50),
		@VoucherTypeID AS NVARCHAR(50),
		@DebitAccountID AS NVARCHAR(50),
		@CreditAccountID AS NVARCHAR(50),
		@SQL1 NVARCHAR(MAX),
		@SQL2 NVARCHAR(MAX),
		@SQL3 NVARCHAR(MAX),
		@SQL4 NVARCHAR(MAX)

	
SET @CustomerName = (SELECT CustomerName FROM CustomerIndex)
IF @CustomerName = 32
BEGIN
	EXEC dbo.AP7419_PL @DivisionID = @DivisionID,  -- nvarchar(50)
	                @TranMonthFrom = @TranMonthFrom, -- int
	                @TranYearFrom = @TranYearFrom,  -- int
	                @TranMonthTo = @TranMonthTo,   -- int
	                @TranYearTo = @TranYearTo,    -- int
	                @ReportCode = @ReportCode   -- nvarchar(50)
	
END
ELSE IF @CustomerName = 44
BEGIN
	EXEC dbo.AP7419_SAVI @DivisionID = @DivisionID,  -- nvarchar(50)
	                @TranMonthFrom = @TranMonthFrom, -- int
	                @TranYearFrom = @TranYearFrom,  -- int
	                @TranMonthTo = @TranMonthTo,   -- int
	                @TranYearTo = @TranYearTo,    -- int
	                @ReportCode = @ReportCode   -- nvarchar(50)
	
END
ELSE
	BEGIN
	-- Calculate the periods 'from' and 'to'
		SET @PeriodFrom = @TranYearFrom*100+@TranMonthFrom
		SET @PeriodTo = @TranYearTo*100+@TranMonthTo

	SELECT 
			@TaxAccountID1From = isnull(TaxAccountID1From,''),
			@TaxAccountID1To = isnull(TaxAccountID1To,''),
			@TaxAccountID2From = isnull(TaxAccountID2From,''),
			@TaxAccountID2To = isnull(TaxAccountID2To,''),
			@TaxAccountID3From = isnull(TaxAccountID3From,''),
			@TaxAccountID3To = isnull(TaxAccountID3To,''),
			@NetAccountID1From = isnull(NetAccountID1From,''),	
			@NetAccountID1To = isnull(NetAccountID1To,''),	
			@NetAccountID2From = isnull(NetAccountID2From,''),	
			@NetAccountID2To = isnull(NetAccountID2To,''),	
			@NetAccountID3From = isnull(NetAccountID3From,''),	
			@NetAccountID3To = isnull(NetAccountID3To,''),	
			@NetAccountID4From = isnull(NetAccountID4From,''),	
			@NetAccountID4To = isnull(NetAccountID4To,''),	
			@VoucherTypeID = isnull(VoucherTypeID,''), 
			@NetAccountID5From = isnull(NetAccountID5From,''),	
			@NetAccountID5To = isnull(NetAccountID5To,''),	
			@VoucherTypeIDTo = isnull(VoucherTypeIDTo,''),
			@VATTypeID = isnull(VATTypeID,''),
			@VATTypeID1 = isnull(VATTypeID1,''),
			@VATTypeID2 = isnull(VATTypeID2,''),
			@VATTypeID3 = isnull(VATTypeID3,''),
			@VATTypeID4 = isnull(VATTypeID4,''),
			@VATTypeID5 = isnull(VATTypeID5,''),
			@VATTypeID6 = isnull(VATTypeID6,''),
			@VATTypeID7 = isnull(VATTypeID7,''),
			@VATGroupIDFrom = isnull(VATGroupIDFrom,''),
			@VATGroupIDTo = isnull(VATGroupIDTo,''),
			@VATObjectIDFrom = isnull(ObjectIDFrom,''),			
			@VATObjectIDTo = isnull(ObjectIDTo,''),	
			@IsVATIn=IsVATIn,
			@IsVATGroup = IsVATGroup,
			@VATGroupID1 = isnull(VATGroupID1,''),
			@VATGroupID2 = isnull(VATGroupID2,''),
			@VATGroupID3 = isnull(VATGroupID3,''),
			@VATGroupID4 = isnull(VATGroupID4,''),
			@VATGroupID5 = isnull(VATGroupID5,''),
			@VATGroupID6 = isnull(VATGroupID6,''),
			@VATGroupID7 = isnull(VATGroupID7,''),
			@IsTax  = IsTax,
			@IsVATType = IsVATType

	FROM	AT7410 WITH (NOLOCK)
	WHERE	ReportCode = @ReportCode
			and DivisionID = @DivisionID



	IF @TaxAccountID1To is NULL OR @TaxAccountID1To = ''
		SET @TaxAccountID1To = @TaxAccountID1From
	IF @TaxAccountID2To is NULL OR @TaxAccountID2To = ''
		SET @TaxAccountID2To = @TaxAccountID2From
	IF @TaxAccountID3To is NULL OR @TaxAccountID3To = ''
		SET @TaxAccountID3To = @TaxAccountID3From


	IF @NetAccountID1To is NULL OR @NetAccountID1To = ''
		SET @NetAccountID1To = @NetAccountID1From
	IF @NetAccountID2To is NULL OR @NetAccountID2To = ''
		SET @NetAccountID2To = @NetAccountID2From
	IF @NetAccountID3To is NULL OR @NetAccountID3To = ''
		SET @NetAccountID3To = @NetAccountID3From 
	IF @NetAccountID4To is NULL OR @NetAccountID4To = ''
		SET @NetAccountID4To = @NetAccountID4From
	IF @NetAccountID5To is NULL OR @NetAccountID5To = ''
		SET @NetAccountID5To = @NetAccountID5From
	------------->>>


		
	-----------<<<<

	
	Delete  from AT7419

	SET @SQL1='
	 INSERT AT7419 (	DivisionID, VoucherID, BatchID, TransactionID, TransactionTypeID, AccountID, CorAccountID,
						D_C, DebitAccountID, CreditAccountID, VoucherDate, VoucherTypeID, VoucherNo,
						InvoiceDate, InvoiceNo, Serial, ConvertedAmount, OriginalAmount,
						SignAmount, OSignAmount, TranMonth, TranYear,  VDescription ,BDescription, TDescription,
						ObjectID ,VATObjectID, VATNo ,VATObjectName, 
						ObjectAddress, VATTypeID, VATGroupID, ImTaxOriginalAmount, ImTaxConvertedAmount, DueDate, InvoiceCode, InvoiceSign,
						InventoryID, InventoryName, UnitID, Quantity, UnitPrice
						' + CASE WHEN @CustomerName=84 THEN ', Ana06ID, Ana06Name' ELSE '' END +', TypeOfAdjust)
	'

	SET @SQL2='
	SELECT 	A90.DivisionID, A90.VoucherID, A90.BatchID, A90.TransactionID, A90.TransactionTypeID, 
			A90.DebitAccountID AS AccountID, 
			ISNULL(A90.CreditAccountID,'''') AS CorAccountID, 
			CASE WHEN A90.TransactionTypeID in (''T64'',''T65'') Then ''C'' Else ''D'' End AS D_C,  
			A90.DebitAccountID, ISNULL(A90.CreditAccountID,'''') AS CreditAccountID, 
			A90.VoucherDate, A90.VoucherTypeID, A90.VoucherNo,
			A90.InvoiceDate, ISNULL(A90.InvoiceNo,'''') AS InvoiceNo, ISNULL(A90.Serial,'''') AS Serial,  
			CASE WHEN A90.TransactionTypeID in (''T64'',''T65'')   Then -ROUND(A90.ConvertedAmount,2) Else ROUND(A90.ConvertedAmount,2) End + isnull(ROUND(ISNULL(A90.ImTaxOriginalAmount,0),2),0),  
			CASE WHEN A90.TransactionTypeID in (''T64'',''T65'')   Then -ROUND(A90.OriginalAmount,2) Else ROUND(A90.OriginalAmount,2) End +isnull(ROUND(ISNULL(A90.ImTaxConvertedAmount,0),2),0), 
			CASE WHEN A90.TransactionTypeID in (''T64'',''T65'')   Then -ROUND(A90.ConvertedAmount,2) Else ROUND(A90.ConvertedAmount,2) End + isnull(ROUND(ISNULL(A90.ImTaxOriginalAmount,0),2),0),  
			CASE WHEN A90.TransactionTypeID in (''T64'',''T65'')   Then -ROUND(A90.OriginalAmount,2) Else ROUND(A90.OriginalAmount,2) End +isnull(ROUND(ISNULL(A90.ImTaxConvertedAmount,0),2),0),  
			A90.TranMonth, A90.TranYear,  A90.VDescription ,A90.BDescription, A90.TDescription,
			CASE WHEN ISNULL(A90.ObjectID,'''') = '''' and A90.TransactionTypeID =''T99'' then A90.CreditObjectID else A90.ObjectID end AS ObjectID ,
			CASE WHEN EXISTS (SELECT TOP 1 1 FROM AT9000 A900 WITH (NOLOCK) where A900.DivisionID = A90.DivisionID AND A900.TransactionTypeID = ''T99''
								AND A900.VoucherID = A90.VoucherID AND A900.DebitACcountID LIKE ''133%'' or A900.DebitACcountID LIKE ''333%'')
			THEN ObjectID
			ELSE
				CreditObjectID
			END AS VATObjectID
			, A90.VATNo ,A90.VATObjectName, 
			'''' AS ObjectAddress, A90.VATTypeID, A90.VATGroupID , 0,0, A90.DueDate, A90.InvoiceCode, A90.InvoiceSign, A90.InventoryID, A3.InventoryName, A3.UnitID, A90.Quantity, A90.UnitPrice
			'+CASE WHEN @CustomerName=84 THEN ', ISNULL(A90.Ana06ID,'''') AS Ana06ID, ISNULL(A6.AnaName,'''') AS Ana06Name ' ELSE '' END +',
			A90.TypeOfAdjust
	FROM AT9000 A90 WITH (NOLOCK)
	LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A3.InventoryID = A90.InventoryID
	'+CASE WHEN @CustomerName=84 THEN ' LEFT JOIN AT1011 A6 WITH (NOLOCK) ON ISNULL(A90.Ana06ID,'''') = ISNULL(A6.AnaID,'''')' ELSE '' END +'
	WHERE	A90.DivisionID = '''+@DivisionID+'''
			AND A90.TranYear*100+A90.TranMonth >= '+LTRIM(@TranYearFrom*100+@TranMonthFrom)+'
			AND A90.TranYear*100+A90.TranMonth <= '+LTRIM(@TranYearTo*100+@TranMonthTo)+'
			AND A90.DebitAccountID IS NOT NULL AND A90.DebitAccountID <> ''''
			AND ISNULL(A90.VATTypeID,'''')<>''''	
			'
	SET @SQL3 ='
	UNION ALL
	SELECT 	A90.DivisionID, A90.VoucherID, A90.BatchID, A90.TransactionID, A90.TransactionTypeID, 
			A90.CreditAccountID AS AccountID, 
			ISNULL(A90.DebitAccountID,'''') AS CorAccountID, 
			CASE WHEN A90.TransactionTypeID in (''T64'',''T65'') THEN ''D'' ELSE ''C'' END AS D_C, 
			ISNULL(A90.DebitAccountID,'''') AS DebitAccountID, A90.CreditAccountID,
			A90.VoucherDate, A90.VoucherTypeID, A90.VoucherNo,
			A90.InvoiceDate, ISNULL(A90.InvoiceNo,'''') AS InvoiceNo, ISNULL(A90.Serial,'''') AS Serial,  
			CASE WHEN A90.TransactionTypeID in (''T64'',''T65'')   Then -ROUND(A90.ConvertedAmount,2) Else ROUND(A90.ConvertedAmount,2) End + isnull(ROUND(ISNULL(A90.ImTaxOriginalAmount,0),2),0),  
			CASE WHEN A90.TransactionTypeID in (''T64'',''T65'')   Then -ROUND(A90.OriginalAmount,2) Else ROUND(A90.OriginalAmount,2) End +isnull(ROUND(ISNULL(A90.ImTaxConvertedAmount,0),2),0), 
			CASE WHEN A90.TransactionTypeID in (''T64'',''T65'')   Then -ROUND(A90.ConvertedAmount,2) Else ROUND(A90.ConvertedAmount,2) End + isnull(ROUND(ISNULL(A90.ImTaxOriginalAmount,0),2),0),  
			CASE WHEN A90.TransactionTypeID in (''T64'',''T65'')   Then -ROUND(A90.OriginalAmount,2) Else ROUND(A90.OriginalAmount,2) End +isnull(ROUND(ISNULL(A90.ImTaxConvertedAmount,0),2),0),  
			A90.TranMonth, A90.TranYear,  A90.VDescription ,A90.BDescription, A90.TDescription,
			CASE WHEN ISNULL(A90.CreditObjectID,'''') <> '''' and A90.TransactionTypeID = ''T99''  then A90.CreditObjectID else A90.ObjectID end AS ObjectID ,
			CASE WHEN EXISTS (SELECT TOP 1 1 FROM AT9000 A900 WITH (NOLOCK) where A900.DivisionID = A90.DivisionID AND A900.TransactionTypeID = ''T99''
								AND A900.VoucherID = A90.VoucherID AND A900.DebitACcountID LIKE ''133%'' or A900.DebitACcountID LIKE ''333%'')
			THEN ObjectID
			ELSE
				CreditObjectID
			END AS VATObjectID
			, A90.VATNo ,A90.VATObjectName, 
			'''' AS ObjectAddress, A90.VATTypeID, A90.VATGroupID , 0,0, A90.DueDate, A90.InvoiceCode, A90.InvoiceSign, A90.InventoryID, A3.InventoryName, A3.UnitID, A90.Quantity, A90.UnitPrice
			'+CASE WHEN @CustomerName=84 THEN ', ISNULL(A90.Ana06ID,'''') AS Ana06ID, ISNULL(A6.AnaName,'''') AS Ana06Name ' ELSE '' END +',
			A90.TypeOfAdjust
		 
	FROM AT9000 A90 WITH (NOLOCK)
	LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A3.InventoryID = A90.InventoryID
	'+CASE WHEN @CustomerName=84 THEN ' LEFT JOIN AT1011 A6 WITH (NOLOCK) ON ISNULL(A90.Ana06ID,'''') = ISNULL(A6.AnaID,'''') ' ELSE '' END +'
	WHERE	A90.DivisionID = '''+@DivisionID+'''
			AND A90.TranYear*100+A90.TranMonth >= '+LTRIM(@TranYearFrom*100+@TranMonthFrom)+'
			AND A90.TranYear*100+A90.TranMonth <= '+LTRIM(@TranYearTo*100+@TranMonthTo)+'
			AND A90.CreditAccountID IS NOT NULL AND A90.CreditAccountID <> ''''
			AND ISNULL(A90.VATTypeID,'''')<>''''
	'

	SET @SQL4='
	UNION ALL
		-- Hóa đơn hủy
	SELECT AT35A.DivisionID, AT35A.VoucherID, '''' AS BatchID, AT36A.TransactionID, '''' AS TransactionTypeID, '''' AS AccountID, '''' AS CorAccountID, '''' AS D_C,
		AT35A.VATDebitAccountID AS DebitAccountID, AT35A.VATCreditAccountID AS CreditAccountID, AT35A.VoucherDate, AT35A.VoucherTypeID, AT35A.AT9000VoucherNo AS VoucherNo, AT35A.InvoiceDate, AT35A.InvoiceNo, AT35A.Serial,
		0 AS ConvertedAmount, 0 AS OriginalAmount, 0 AS SignAmount, 0 AS OSignAmount, AT35A.TranMonth, AT35A.TranYear, '''' AS VDescription, '''' AS BDescription, '''' AS TDescription,
		AT35A.ObjectID, AT35A.VATObjectID, AT02A.VATNo, AT02A.ObjectName AS VATObjectName, AT02B.Address AS ObjectAddress, 
		AT35A.VATTypeID, AT35A.VATGroupID , 0 as ImTaxOriginalAmount, 0 as ImTaxConvertedAmount, '''' AS DueDate, AT35A.InvoiceCode, AT35A.InvoiceSign, AT36A.InventoryID, A3.InventoryName, A3.UnitID, AT36A.ConvertedQuantity AS Quantity, AT36A.ConvertedPrice AS UnitPrice
		'+CASE WHEN @CustomerName=84 THEN ',ISNULL(A90.Ana06ID,'''') AS Ana06ID, ISNULL(A6.AnaName,'''') AS Ana06Name ' ELSE '' END +',
		A90.TypeOfAdjust

		FROM AT1035 AT35A WITH (NOLOCK) INNER JOIN AT1036 AT36A WITH(NOLOCK) ON AT35A.VoucherID = AT36A.VoucherID
		LEFT JOIN AT1202 AT02A WITH (NOLOCK) ON AT02A.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT02A.ObjectID = AT35A.VATObjectID
		LEFT JOIN AT1202 AT02B WITH (NOLOCK) ON AT02B.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT02B.ObjectID = AT35A.ObjectID
		LEFT JOIN AT9000 A90 WITH (NOLOCK) ON A90.VoucherID = AT36A.VoucherID AND A90.TransactionID = AT36A.TransactionID
		LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A3.InventoryID = AT36A.InventoryID
		'+CASE WHEN @CustomerName=84 THEN 'LEFT JOIN AT1011 A6 WITH (NOLOCK) ON A90.Ana06ID = A6.AnaID' ELSE '' END +'

		WHERE AT35A.DivisionID = '''+@DivisionID+'''
		AND AT35A.TranYear*100+AT35A.TranMonth >= '+LTRIM(@TranYearFrom*100+@TranMonthFrom)+'
		AND AT35A.TranYear*100+AT35A.TranMonth <= '+LTRIM(@TranYearTo*100+@TranMonthTo)+'
		AND AT35A.IsCancel = 1

	UNION ALL -- Hóa bị thay thế

	SELECT AT35A.DivisionID, AT35A.VoucherID, '''' AS BatchID, AT36A.TransactionID, '''' AS TransactionTypeID, '''' AS AccountID, '''' AS CorAccountID, '''' AS D_C,
		AT35A.VATDebitAccountID AS DebitAccountID, AT35A.VATCreditAccountID AS CreditAccountID, AT35A.VoucherDate, AT35A.VoucherTypeID, AT35A.AT9000VoucherNo AS VoucherNo, AT35A.InvoiceDate, AT35A.InvoiceNo, AT35A.Serial,
		0 AS ConvertedAmount, 0 AS OriginalAmount, 0 AS SignAmount, 0 AS OSignAmount, AT35A.TranMonth, AT35A.TranYear, '''' AS VDescription, '''' AS BDescription, '''' AS TDescription,
		AT35A.ObjectID, AT35A.VATObjectID, AT02A.VATNo, AT02A.ObjectName AS VATObjectName, AT02B.Address AS ObjectAddress, 
		AT35A.VATTypeID, AT35A.VATGroupID , 0 as ImTaxOriginalAmount, 0 as ImTaxConvertedAmount, '''' AS DueDate, AT35A.InvoiceCode, AT35A.InvoiceSign, AT36A.InventoryID, A3.InventoryName, A3.UnitID, AT36A.ConvertedQuantity AS Quantity, AT36A.ConvertedPrice AS UnitPrice
		'+CASE WHEN @CustomerName=84 THEN ',ISNULL(A90.Ana06ID,'''') AS Ana06ID, ISNULL(A6.AnaName,'''') AS Ana06Name ' ELSE '' END +',
		A90.TypeOfAdjust

		FROM AT1035 AT35A WITH (NOLOCK) INNER JOIN AT1036 AT36A WITH(NOLOCK) ON AT35A.VoucherID = AT36A.VoucherID
		LEFT JOIN AT1202 AT02A WITH (NOLOCK) ON AT02A.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT02A.ObjectID = AT35A.VATObjectID
		LEFT JOIN AT1202 AT02B WITH (NOLOCK) ON AT02B.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT02B.ObjectID = AT35A.ObjectID
		LEFT JOIN AT9000 A90 WITH (NOLOCK) ON A90.VoucherID = AT36A.VoucherID AND A90.TransactionID = AT36A.TransactionID
		LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A3.InventoryID = AT36A.InventoryID
		'+CASE WHEN @CustomerName=84 THEN 'LEFT JOIN AT1011 A6 WITH (NOLOCK) ON A90.Ana06ID = A6.AnaID' ELSE '' END +'
	
		WHERE AT35A.DivisionID = '''+@DivisionID+'''
		AND AT35A.TranYear*100+AT35A.TranMonth >= '+LTRIM(@TranYearFrom*100+@TranMonthFrom)+'
		AND AT35A.TranYear*100+AT35A.TranMonth <= '+LTRIM(@TranYearTo*100+@TranMonthTo)+'
		AND AT35A.EInvoiceType = 0 AND AT35A.IsLastEInvoice = 0 AND ISNULL(AT35A.IsCancel,0) = 0
		AND AT35A.AT9000VoucherID NOT IN (SELECT DISTINCT VoucherID FROM AT9000 WHERE DivisionID = '''+@DivisionID+''' 
											AND TranYear*100+TranMonth >= '+LTRIM(@TranYearFrom*100+@TranMonthFrom)+'
											AND TranYear*100+TranMonth <= '+LTRIM(@TranYearTo*100+@TranMonthTo)+')
	'       
	--Print @SQL1
	--Print @SQL2
	--Print @SQL3
	--Print @SQL4
	EXEC (@SQL1 + @SQL2 + @SQL3 + @SQL4)

	SELECT * FROM AT7419  
	--PRINT @strSQL

	--EXEC(@strSQL+@strSQL1+@strSQL2)	----- Insert vao bang AT7419





	--Print @strSQL


	--IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE SYSOBJECTS.NAME = 'AV7411' AND SYSOBJECTS.XTYPE = 'V')
	--	EXEC ('CREATE VIEW AV7411 AS -- Tạo bởi store AP7419_TH
	--	' + @strSQL)
	--ELSE
	--	EXEC ('ALTER VIEW AV7411 AS -- Tạo bởi store AP7419_TH
	--	' + @strSQL)

	EXEC AP7411_TH @DivisionID,			
				@TaxAccountID1From,		@TaxAccountID1To,
				@TaxAccountID2From,		@TaxAccountID2To,
				@TaxAccountID3From,		@TaxAccountID3To,
				@NetAccountID1From,		@NetAccountID1To,	
				@NetAccountID2From,		@NetAccountID2To,	
				@NetAccountID3From,		@NetAccountID3To,	
				@NetAccountID4From,		@NetAccountID4To,
				@NetAccountID5From,		@NetAccountID5To,
				@IsVATIn, @IsTax, @IsVATType ,
				@IsVATGroup , @VATGroupID1 ,
				@VATGroupID2 ,	@VATGroupID3,
				@VATGroupID4 ,	@VATGroupID5,				
				@VATGroupID6 ,	@VATGroupID7,
				@PeriodFrom ,
				@PeriodTo , 		@VATTypeID ,
			@VATGroupIDFrom ,	@VATGroupIDTo ,
			@VATObjectIDFrom ,	@VATObjectIDTo ,
			@VATTypeID1  , @VATTypeID2  ,
			@VATTypeID3 ,@VATTypeID4 ,
			@VATTypeID5 ,@VATTypeID6 ,@VATTypeID7 ,	@VoucherTypeID , 		@VoucherTypeIDFrom ,
			@VoucherTypeIDTo , @ReportCode

END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
