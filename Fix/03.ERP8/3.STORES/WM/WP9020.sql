IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP9020]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP9020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
--- Customize BBA: Sinh phiếu nhập kho sell Out tự động khi tạo phiếu xuất kho Sell In
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Phương Thảo on 16/12/2022
--- Modified on 21/12/2022 by Phương Thảo: Bổ sung Delete phiếu nhập kho SellOut nếu tồn tại phiếu nhập kho SellOut, khi sửa Phiếu xuất kho SellIn
--- Modified on 17/01/2022 [2023/01/IS/0099] by Phương Thảo: Fix khi kế thừa phiếu yêu cầu xuất kho, Phiếu yêu cầu xuất kho có kế thừa đơn hàng bù thì không cho nhập kho SellOut

-- <Example>
/*
    exec WP9020 @DivisionID=N'BBA-SI',@UserID=N'ASOFTADMIN',@_VoucherID=N'ADf5f9d969-e542-45f0-86dc-befcb87f0e0d',@TranMonth=12,@TranYear=2022
*/

 CREATE PROCEDURE WP9020
(
     @DivisionID NVARCHAR(50),
	 @UserID NVARCHAR(50),
	 @_VoucherID NVARCHAR(250),
	 @TranYear INT,
	 @TranMonth INT,
	 @Mode INT
)
AS

DECLARE @sSQL NVARCHAR(MAX) = '',
        @sSQL1 NVARCHAR(MAX) = '',
		@sSQL2 NVARCHAR(MAX) = '',
		@sSQL3 NVARCHAR(MAX) = '',
		@DealerDivisionID VARCHAR(50),
		@DealerData NVARCHAR(50),
		@VoucherNo VARCHAR(50),
		@VoucherID VARCHAR(50),
		@ObjectID VARCHAR(50) = '',
		@DealerID VARCHAR(50), 
		@IsDealer TINYINT, 
		@VoucherTypeIDT06 varchar(50) = 'NK0', -- Nhập kho khác
		@StringKey1T06 varchar(50), 
		@StringKey2T06 varchar(50),
		@StringKey3T06 varchar(50), 
		@OutputLenT06 int, 
		@OutputOrderT06 int,
		@SeparatedT06 int, 
		@SeparatorT06 char(1),
		@Enabled1 tinyint, 
		@Enabled2 tinyint,
		@Enabled3 tinyint,
		@S1 varchar(50), 
		@S2 varchar(50),
		@S3 varchar(50),
		@S1Type tinyint, 
		@S2Type tinyint,
		@S3Type tinyint,
		@TranYearText NVARCHAR(10),
		@TranMonthText NVARCHAR(5), 
		@DealerDivisionID1 VARCHAR(50),
		@IsProInventoryID  NVARCHAR(5),
		@VoucherTypeIDW VARCHAR(50) = 'SO',
	    @OrderID VARCHAR(50),
		@TableID VARCHAR(10)


SET @TranYearText = CONVERT(NVARCHAR(10),@TranYear)
SET @TranMonthText = CONVERT(NVARCHAR(5),@TranMonth)

------ Khai báo chứng từ nhập kho
BEGIN
	Select @Enabled1 = Enabled1
			, @Enabled2 = Enabled2
			, @Enabled3 = Enabled3
			, @S1 = S1
			, @S2 = S2
			, @S3 = S3
			, @S1Type = S1Type
			, @S2Type = S2Type
			, @S3Type = S3Type
			, @OutputLenT06 = OutputLength
			, @OutputOrderT06 = OutputOrder
			, @SeparatedT06 = Separated
			, @SeparatorT06 = Separator
	From AT1007 WITH (NOLOCK) 
	Where DivisionID = @DivisionID 
			And VoucherTypeID = @VoucherTypeIDT06

	If @Enabled1 = 1
		Set @StringKey1T06 = 
		Case @S1Type
		When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
		When 2 Then ltrim(@TranYear)
		When 3 Then @VoucherTypeIDT06
		When 4 Then @DivisionID
		When 5 Then @S1
		When 6 Then right(ltrim(@TranYear),2)
		Else '' End
	Else
		Set @StringKey1T06 = ''

	If @Enabled2 = 1
		Set @StringKey2T06 = 
		Case @S2Type 
		When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
		When 2 Then ltrim(@TranYear)
		When 3 Then @VoucherTypeIDT06
		When 4 Then @DivisionID
		When 5 Then @S1
		When 6 Then right(ltrim(@TranYear),2)
		Else '' End
	Else
		Set @StringKey2T06 = ''

	If @Enabled3 = 1
		Set @StringKey3T06 = 
		Case @S3Type 
		When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
		When 2 Then ltrim(@TranYear)
		When 3 Then @VoucherTypeIDT06
		When 4 Then @DivisionID
		When 5 Then @S1
		When 6 Then right(ltrim(@TranYear),2)
		Else '' End
	Else
		Set @StringKey3T06 = ''
		
	
	EXEC AP0000 @DivisionID, @VoucherNo Output, 'AT2006', @StringKey1T06, @StringKey2T06, @StringKey3T06, @OutputLenT06, @OutputOrderT06, @SeparatedT06, @SeparatorT06
END

---- Get ObjectID
SELECT TOP 1 @ObjectID = ISNULL(ObjectID,'BB') FROM AT2006 WITH(NOLOCK) WHERE DivisionID = @DivisionID  AND VoucherID = @_VoucherID
---- Get DealerDivisionID
SELECT TOP 1 @DealerDivisionID = ISNULL(KeyValue,'') FROM ST2101 WITH(NOLOCK) WHERE DivisionID IN (@DivisionID,'@@@') AND KeyName = 'DealerDivisionID'
---- Get DealerDivisionID1
SELECT TOP 1 @DealerDivisionID1 = CONCAT(@DealerDivisionID,'-','KM')
---- Get DealerData Name
SELECT TOP 1 @DealerData = ISNULL(KeyValue,'') FROM ST2101 WITH(NOLOCK) WHERE DivisionID IN (@DivisionID,'@@@') AND KeyName = 'DealerData'
-----get IsProInventoryID
 SET @IsProInventoryID = ISNULL((SELECT TOP 1 IsProInventoryID FROM AT2007 WITH(NOLOCK) WHERE DivisionID IN (@DivisionID,'@@@')AND VoucherID = @_VoucherID AND IsProInventoryID ='1'),0)
---- get VoucherTypeIDW
IF @Mode = 0 -- Kế thừa đơn hàng bán
BEGIN
    SELECT TOP 1 @VoucherTypeIDW = VoucherTypeID FROM OT2001 WITH(NOLOCK) WHERE DivisionID = @DivisionID AND SOrderID = (select OrderID from AT2006 where VoucherID = @_VoucherID)
END
IF @Mode = 1 -- Kế thừa yêu cầu xuất kho
BEGIN
-----get OrderID
    IF EXISTS (
			  SELECT  WT0096.OrderID FROM AT2006 WITH (NOLOCK) --kiểm tra phiếu yêu cầu xuất kho có chứa đơn hàng bù không(SO99)
			  INNER JOIN AT2007 WITH (NOLOCK) on AT2006.VOUCHERID = AT2007.VOUCHERID	
			  LEFT JOIN WT0096 WITH (NOLOCK) ON AT2007.InheritVoucherID =  WT0096.VoucherID
			  WHERE AT2006.VOUCHERID = @_VoucherID AND WT0096.OrderID LIKE 'SO99%' AND AT2006.DivisionID = @DivisionID )
	BEGIN
			  SELECT TOP 1 @OrderID=WT0096.OrderID FROM AT2006 WITH (NOLOCK) --Phiếu yêu cầu xuất kho có kế thừa đơn hàng bù(SO99)
			  INNER JOIN AT2007 WITH (NOLOCK) on AT2006.VOUCHERID = AT2007.VOUCHERID	
		 	  LEFT JOIN WT0096 WITH (NOLOCK) ON AT2007.InheritVoucherID =  WT0096.VoucherID
			  WHERE AT2006.VOUCHERID = @_VoucherID AND WT0096.OrderID LIKE 'SO99%' AND AT2006.DivisionID = @DivisionID
	END
	ELSE
	BEGIN
		      SELECT TOP 1  @OrderID=WT0096.OrderID FROM AT2006 WITH (NOLOCK) --Phiếu yêu cầu xuất kho không kế thừa đơn hàng bù(SO99)
			  inner join AT2007 WITH (NOLOCK) on AT2006.VOUCHERID = AT2007.VOUCHERID	
			  LEFT JOIN WT0096 WITH (NOLOCK) ON AT2007.InheritVoucherID =  WT0096.VoucherID
			  WHERE AT2006.VOUCHERID = @_VoucherID AND AT2006.DivisionID = @DivisionID
	END

    SELECT TOP 1 @VoucherTypeIDW = VoucherTypeID FROM OT2001 WITH(NOLOCK) WHERE DivisionID = @DivisionID AND SOrderID = @OrderID

END


    



---print
print (@ObjectID);
print (@DealerDivisionID); 
print (@DealerData);
print (@StringKey1T06);
print (@IsProInventoryID);
print (@DealerDivisionID1);
print (@VoucherTypeIDW);
print (@OrderID);





-- VoucherTypeIDW = 'S099': Đơn hàng có sản phẩm bù; VoucherTypeIDW = 'SO': Đơn hàng không có sản phẩm bù;
-- Đơn hàng không có sản phẩm bù thì cho nhập kho sell out
If (@VoucherTypeIDW <>'SO99' )
BEGIN

SET @sSQL = N'
------------------------thực hiện xóa dữ liệu--------------------------------------------------
  	IF EXISTS (SELECT TOP 1 1 FROM AT2006 WITH (NOLOCK) WHERE DivisionID = '''+ @DealerDivisionID+''' AND ReVoucherID ='''+@_VoucherID+''')
	BEGIN
		
		DELETE AT2006 WHERE DivisionID = '''+ @DealerDivisionID+''' AND ReVoucherID =  '''+@_VoucherID+'''
		DELETE AT2007 WHERE DivisionID = '''+ @DealerDivisionID+''' AND ReVoucherID =  '''+@_VoucherID+'''
	END	
----------------------------------------------------------------------------------------

DECLARE 
		@VoucherID_WARE VARCHAR(50)
--Kiểm tra đơn hàng có hàng khuyến mãi ,có thực hiện TH1.1 và TH1.2, không có thực hiện TH2
IF EXISTS (SELECT TOP 1 1 FROM AT1202 WITH(NOLOCK) WHERE DivisionID IN ('''+@DivisionID+''', ''@@@'') AND ObjectID = '''+@ObjectID+''' AND IsDealer = 1)  AND '''+@IsProInventoryID+''' = ''1''
BEGIN
	--TH1.1 Đơn hàng có Hàng khuyến mãi, lưu mặt hàng khuyến mãi vào kho nhập BBA-SO-KM
    IF EXISTS(SELECT   * FROM AT2007 WITH(NOLOCK) WHERE DivisionID IN ('''+@DivisionID+''', ''@@@'') AND VoucherID = '''+@_VoucherID+'''  AND IsProInventoryID =''1'')
	BEGIN
		Print(''TH1.1'')
		SET @VoucherID_WARE = NEWID()
		---- Insert AT2006
		INSERT INTO dbo.[AT2006] (DivisionID, VoucherID, TableID, TranMonth, TranYear, VoucherTypeID, VoucherDate, VoucherNo, ObjectID, OrderID, 
		                         WareHouseID, KindVoucherID,[Status],EmployeeID, [Description], CreateDate, CreateUserID,
								 LastModifyUserID, LastModifyDate, InventoryTypeID, ImVoucherID, RefNo01,ReVoucherID)
		SELECT '''+@DealerDivisionID+''', @VoucherID_WARE, TableID, '''+@TranMonthText+''', '''+@TranYearText+''', '''+@VoucherTypeIDT06+''', VoucherDate, '''+@VoucherNo+''', '''+@ObjectID+''', OrderID,
		       '''+@DealerDivisionID1+''', 1,[Status], EmployeeID, [Description], GETDATE(), '''+@UserID+''',
			   '''+@UserID+''', GETDATE(), InventoryTypeID, ImVoucherID, OrderID,'''+@_VoucherID+'''
		FROM AT2006
		WHERE VoucherID = '''+@_VoucherID+''' 
	
		---- Insert AT2007
		INSERT INTO dbo.[AT2007] (DivisionID, TransactionID, VoucherID, InventoryID, UnitID, ActualQuantity, UnitPrice,
						   OriginalAmount, ConvertedAmount, Notes, TranMonth, TranYear, SourceNo,
						   DebitAccountID, CreditAccountID,
						   Orders, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
						   Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, ReTransactionID, ReVoucherID, OrderID,
						   ConvertedQuantity, ConvertedPrice, StandardPrice, StandardAmount, InheritTableID, InheritVoucherID, InheritTransactionID)
		
		SELECT '''+@DealerDivisionID+''', NEWID(),  @VoucherID_WARE, InventoryID, UnitID, ActualQuantity, UnitPrice,
			   OriginalAmount, ConvertedAmount, Notes, '''+@TranMonthText+''', '''+@TranYearText+''', SourceNo,
			   DebitAccountID, CreditAccountID,
			   Orders, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
		       Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, ReTransactionID, '''+@_VoucherID+''', OrderID,
		       ConvertedQuantity, ConvertedPrice, StandardPrice, StandardAmount, InheritTableID, InheritVoucherID, InheritTransactionID
		FROM AT2007
		WHERE VoucherID = '''+@_VoucherID+''' AND IsProInventoryID =''1'' 
	END'

EXEC AP0000 @DivisionID, @VoucherNo Output, 'AT2006', @StringKey1T06, @StringKey2T06, @StringKey3T06, @OutputLenT06, @OutputOrderT06, @SeparatedT06, @SeparatorT06

SET @sSQL1 = N'
	--TH1.2 Đơn hàng có Hàng khuyến mãi, lưu mặt hàng bán vào kho nhập BBA-SO
	IF EXISTS(SELECT   * FROM AT2007 WITH(NOLOCK) WHERE DivisionID IN ('''+@DivisionID+''', ''@@@'') AND VoucherID = '''+@_VoucherID+'''   AND ISNULL(IsProInventoryID,''0'') =''0'')   
	BEGIN
		Print(''TH1.2'')
		SET @VoucherID_WARE = NEWID()
		---- Insert AT2006
		INSERT INTO dbo.[AT2006] (DivisionID, VoucherID, TableID, TranMonth, TranYear, VoucherTypeID, VoucherDate, VoucherNo, ObjectID, OrderID,
		                          WareHouseID, KindVoucherID,[Status], EmployeeID, [Description], CreateDate, CreateUserID,
								  LastModifyUserID, LastModifyDate, InventoryTypeID, ImVoucherID, RefNo01,ReVoucherID)
		SELECT '''+@DealerDivisionID+''', @VoucherID_WARE, TableID, '''+@TranMonthText+''', '''+@TranYearText+''', '''+@VoucherTypeIDT06+''', VoucherDate, '''+@VoucherNo+''', '''+@ObjectID+''', OrderID,
	           '''+@DealerDivisionID+''', 1,[Status], EmployeeID, [Description], GETDATE(), '''+@UserID+''',
			   '''+@UserID+''', GETDATE(), InventoryTypeID, ImVoucherID, OrderID,'''+@_VoucherID+'''
		FROM AT2006
		WHERE VoucherID = '''+@_VoucherID+''' 
	
		---- Insert AT2007
		INSERT INTO dbo.[AT2007] (DivisionID, TransactionID, VoucherID, InventoryID, UnitID, ActualQuantity, UnitPrice,
						   OriginalAmount, ConvertedAmount, Notes, TranMonth, TranYear, SourceNo,
						   DebitAccountID, CreditAccountID,
						   Orders, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
						   Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, ReTransactionID, ReVoucherID, OrderID,
						   ConvertedQuantity, ConvertedPrice, StandardPrice, StandardAmount, InheritTableID, InheritVoucherID, InheritTransactionID)
		
		SELECT '''+@DealerDivisionID+''', NEWID(),  @VoucherID_WARE, InventoryID, UnitID, ActualQuantity, UnitPrice,
			   OriginalAmount, ConvertedAmount, Notes, '''+@TranMonthText+''', '''+@TranYearText+''', SourceNo,
			   DebitAccountID, CreditAccountID,
			   Orders, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
		       Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, ReTransactionID, '''+@_VoucherID+''', OrderID,
		       ConvertedQuantity, ConvertedPrice, StandardPrice, StandardAmount, InheritTableID, InheritVoucherID, InheritTransactionID
		FROM AT2007
		WHERE VoucherID = '''+@_VoucherID+''' AND ISNULL(IsProInventoryID,''0'') =''0''   
	END
END'
SET @sSQL2 = N'
--TH2 Đơn hàng không có Hàng khuyến mãi, lưu mặt hàng bán vào kho nhập BBA-SO
ElSE
BEGIN
	Print(''TH2'')
	SET @VoucherID_WARE = NEWID()
	---- Insert AT2006
	INSERT INTO dbo.[AT2006] (DivisionID, VoucherID, TableID, TranMonth, TranYear, VoucherTypeID, VoucherDate, VoucherNo, ObjectID, OrderID,
	                          WareHouseID, KindVoucherID,[Status], EmployeeID, [Description], CreateDate, CreateUserID,
							  LastModifyUserID, LastModifyDate, InventoryTypeID, ImVoucherID, RefNo01,ReVoucherID)
	SELECT '''+@DealerDivisionID+''', @VoucherID_WARE, TableID, '''+@TranMonthText+''', '''+@TranYearText+''', '''+@VoucherTypeIDT06+''', VoucherDate, '''+@VoucherNo+''', '''+@ObjectID+''', OrderID,
           '''+@DealerDivisionID+''', 1,[Status], EmployeeID, [Description], GETDATE(), '''+@UserID+''',
		   '''+@UserID+''', GETDATE(), InventoryTypeID, ImVoucherID, OrderID,'''+@_VoucherID+'''
	FROM AT2006
	WHERE VoucherID = '''+@_VoucherID+''' 

	---- Insert AT2007
	INSERT INTO dbo.[AT2007] (DivisionID, TransactionID, VoucherID, InventoryID, UnitID, ActualQuantity, UnitPrice,
					   OriginalAmount, ConvertedAmount, Notes, TranMonth, TranYear, SourceNo,
					   DebitAccountID, CreditAccountID,
					   Orders, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
					   Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, ReTransactionID, ReVoucherID, OrderID,
					   ConvertedQuantity, ConvertedPrice, StandardPrice, StandardAmount, InheritTableID, InheritVoucherID, InheritTransactionID)
	
	SELECT '''+@DealerDivisionID+''', NEWID(),  @VoucherID_WARE, InventoryID, UnitID, ActualQuantity, UnitPrice,    
		   OriginalAmount, ConvertedAmount, Notes, '''+@TranMonthText+''', '''+@TranYearText+''', SourceNo,
		   DebitAccountID, CreditAccountID,
		   Orders, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
	       Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, ReTransactionID, '''+@_VoucherID+''', OrderID,
	       ConvertedQuantity, ConvertedPrice, StandardPrice, StandardAmount, InheritTableID, InheritVoucherID, InheritTransactionID
	FROM AT2007
	WHERE VoucherID = '''+@_VoucherID+''' 
END'

END   


PRINT @sSQL
PRINT @sSQL1
PRINT @sSQL2
PRINT @sSQL3
EXEC (@sSQL + @sSQL1+ @sSQL2)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

