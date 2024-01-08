IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP9020]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP9020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
--- Customize ANGEL: Sinh phiếu nhập tự động theo đối tượng Dealer trong đơn hàng bán khi duyệt đơn hàng cấp 2.
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Nhựt Trường on 22/07/2022
----Modified by Nhựt Trường on 26/07/2022: Điều chỉnh lại KindVoucherID = 1 (phiếu nhập).
----Modified by Nhựt Trường on 26/07/2022: Điều chỉnh lại VoucherTypeID = 'NK0' (nhập kho khác).
----Modified by Phương Thảo on 18/11/2022: Khi duyệt đơn hàng bán SellIn phát sinh ,1 Phiếu Nhập kho Sellout dành cho mặt hàng bán đổ vào kho Sellout ,1 Phiếu Nhập kho Sellout nếu có mặt hàng khuyến mãi đổ vào kho Sellout hàng khuyến mãi 

-- <Example>
/*
    exec OP9017 @DivisionID=N'ANG',@UserID=N'ASOFTADMIN',@IsConfirm=1,@SOrderID=N'SO1/07/2022/0638',@TranMonth=7,@TranYear=2022
*/

 CREATE PROCEDURE OP9020
(
     @DivisionID NVARCHAR(50),
	 @UserID NVARCHAR(50),
	 @IsConfirm TINYINT, -- 0: Chưa chấp nhận, 1: Xác nhận, 2: Từ chối
	 @SOrderID NVARCHAR(50),
	 @TranYear INT,
	 @TranMonth INT
)
AS

DECLARE @sSQL NVARCHAR(MAX) = '',
        @sSQL1 NVARCHAR(MAX) = '',
		@sSQL2 NVARCHAR(MAX) = '',
		@sSQL3 NVARCHAR(MAX) = '',
		@sSQL4 NVARCHAR(MAX) = '',
		@DealerDivisionID VARCHAR(50),
		@DealerData NVARCHAR(50),
		@VoucherNo VARCHAR(50),
		@VoucherID VARCHAR(50),
		@ObjectID VARCHAR(50),
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
		@IsConfirmText NVARCHAR(5),
		@TranYearText NVARCHAR(10),
		@TranMonthText NVARCHAR(5),
		@DealerDivisionID1 VARCHAR(50),
		@IsProInventoryID  NVARCHAR(5)

SET @IsConfirmText = CONVERT(NVARCHAR(5),@IsConfirm)
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
		
	
	EXEC AP0000 @DivisionID, @VoucherNo Output, 'OT2001', @StringKey1T06, @StringKey2T06, @StringKey3T06, @OutputLenT06, @OutputOrderT06, @SeparatedT06, @SeparatorT06
END

---- Get ObjectID1AE546C7-0955-47A3-A48D-418BBECAE0BE
SELECT TOP 1 @ObjectID = ObjectID FROM OT2001 WITH(NOLOCK) WHERE DivisionID = @DivisionID AND SOrderID = @SOrderID
---- Get Dealer DivisionID
SELECT TOP 1 @DealerDivisionID = KeyValue FROM ST2101 WITH(NOLOCK) WHERE DivisionID IN (@DivisionID,'@@@') AND KeyName = 'DealerDivisionID'
SELECT TOP 1 @DealerDivisionID1 = CONCAT(@DealerDivisionID,'-','KM')
---- Get Dealer Data Name
SELECT TOP 1 @DealerData = KeyValue FROM ST2101 WITH(NOLOCK) WHERE DivisionID IN (@DivisionID,'@@@') AND KeyName = 'DealerData'
-----get @IsProInventoryID
 SET @IsProInventoryID = ISNULL((SELECT TOP 1 IsProInventoryID FROM OT2002 WITH(NOLOCK) WHERE DivisionID IN (@DivisionID,'@@@') 
AND SOrderID = @SOrderID AND IsProInventoryID ='1'),0)

print (@ObjectID);
print (@DealerDivisionID);
print (@DealerData);
print (@StringKey1T06);
print (@IsProInventoryID);
print (@DealerDivisionID1);

---- Get VoucherID
SET @VoucherID = NEWID()

SET @sSQL = N'
DECLARE 
		@VoucherID VARCHAR(50)

IF EXISTS (SELECT TOP 1 1 FROM AT1202 WITH(NOLOCK) WHERE DivisionID IN ('''+@DivisionID+''', ''@@@'') AND ObjectID = '''+@ObjectID+''' AND IsDealer = 1) AND '''+@IsConfirmText+''' = ''1'' AND '''+@IsProInventoryID+''' = ''1''
BEGIN
    IF EXISTS(SELECT   * FROM OT2002 WITH(NOLOCK) WHERE DivisionID IN ('''+@DivisionID+''', ''@@@'') AND SOrderID = '''+@SOrderID+'''  AND IsProInventoryID =''1'')
	BEGIN
	SET @VoucherID = NEWID()
	---- Insert AT2006
	INSERT INTO ['+@DealerData+'].dbo.[AT2006] (DivisionID, VoucherID, TableID, TranMonth, TranYear, VoucherTypeID, VoucherDate, VoucherNo, ObjectID, OrderID, WareHouseID, KindVoucherID,
						   [Status], EmployeeID, [Description], CreateDate, CreateUserID, LastModifyUserID, LastModifyDate, InventoryTypeID, ImVoucherID, RefNo01)
	SELECT '''+@DealerDivisionID+''', @VoucherID, ''OT2001'', '''+@TranMonthText+''', '''+@TranYearText+''', '''+@VoucherTypeIDT06+''', OrderDate, '''+@VoucherNo+''', '''+@ObjectID+''', '''+@SOrderID+''', '''+@DealerDivisionID1+''', 1,
		   OrderStatus, EmployeeID, Notes, GETDATE(), '''+@UserID+''', '''+@UserID+''', GETDATE(), InventoryTypeID, SOrderID, VoucherNo
	FROM OT2001
	WHERE SOrderID = '''+@SOrderID+''' 

	---- Insert AT2007
	INSERT INTO ['+@DealerData+'].dbo.[AT2007] (DivisionID, TransactionID, VoucherID, InventoryID, UnitID, ActualQuantity, UnitPrice,
					   OriginalAmount, ConvertedAmount, Notes, TranMonth, TranYear, SourceNo,
					   DebitAccountID, CreditAccountID,
					   Orders, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
					   Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, ReTransactionID, ReVoucherID, SOrderID,
					   ConvertedQuantity, ConvertedPrice, StandardPrice, StandardAmount, InheritTableID, InheritVoucherID, InheritTransactionID)
	
	SELECT '''+@DealerDivisionID+''', NEWID(),  @VoucherID, InventoryID, UnitID, OrderQuantity, SalePrice,
		   OriginalAmount, ConvertedAmount, Description, '''+@TranMonthText+''', '''+@TranYearText+''', SourceNo,
		   (SELECT TOP 1 AccountID FROM AT1302 WITH (NOLOCK) WHERE DivisionID IN ('''+@DivisionID+''',''@@@'') AND InventoryID = OT2002.InventoryID), ''3311'',
		   Orders, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
	       Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, TransactionID, '''+@SOrderID+''', '''+@SOrderID+''',
	       ConvertedQuantity, ConvertedSalePrice, StandardPrice, StandardAmount, InheritTableID, InheritVoucherID, InheritTransactionID
	FROM OT2002
	WHERE SOrderID = '''+@SOrderID+''' AND IsProInventoryID =''1''
	END'
	EXEC AP0000 @DivisionID, @VoucherNo Output, 'OT2001', @StringKey1T06, @StringKey2T06, @StringKey3T06, @OutputLenT06, @OutputOrderT06, @SeparatedT06, @SeparatorT06
	SET @sSQL1 = N'
	
	IF EXISTS(SELECT   * FROM OT2002 WITH(NOLOCK) WHERE DivisionID IN ('''+@DivisionID+''', ''@@@'') AND SOrderID = '''+@SOrderID+'''  AND IsProInventoryID =''0'')
	
	BEGIN
	SET @VoucherID = NEWID()
	---- Insert AT2006
	INSERT INTO ['+@DealerData+'].dbo.[AT2006] (DivisionID, VoucherID, TableID, TranMonth, TranYear, VoucherTypeID, VoucherDate, VoucherNo, ObjectID, OrderID, WareHouseID, KindVoucherID,
						   [Status], EmployeeID, [Description], CreateDate, CreateUserID, LastModifyUserID, LastModifyDate, InventoryTypeID, ImVoucherID, RefNo01)
	SELECT '''+@DealerDivisionID+''', @VoucherID, ''OT2001'', '''+@TranMonthText+''', '''+@TranYearText+''', '''+@VoucherTypeIDT06+''', OrderDate, '''+@VoucherNo+''', '''+@ObjectID+''', '''+@SOrderID+''', '''+@DealerDivisionID+''', 1,
		   OrderStatus, EmployeeID, Notes, GETDATE(), '''+@UserID+''', '''+@UserID+''', GETDATE(), InventoryTypeID, SOrderID, VoucherNo
	FROM OT2001
	WHERE SOrderID = '''+@SOrderID+''' 
		
	---- Insert AT2007
	INSERT INTO ['+@DealerData+'].dbo.[AT2007] (DivisionID, TransactionID, VoucherID, InventoryID, UnitID, ActualQuantity, UnitPrice,
					   OriginalAmount, ConvertedAmount, Notes, TranMonth, TranYear, SourceNo,
					   DebitAccountID, CreditAccountID,
					   Orders, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
					   Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, ReTransactionID, ReVoucherID, SOrderID,
					   ConvertedQuantity, ConvertedPrice, StandardPrice, StandardAmount, InheritTableID, InheritVoucherID, InheritTransactionID)
	
	SELECT '''+@DealerDivisionID+''', NEWID(),  @VoucherID, InventoryID, UnitID, OrderQuantity, SalePrice,
		   OriginalAmount, ConvertedAmount, Description, '''+@TranMonthText+''', '''+@TranYearText+''', SourceNo,
		   (SELECT TOP 1 AccountID FROM AT1302 WITH (NOLOCK) WHERE DivisionID IN ('''+@DivisionID+''',''@@@'') AND InventoryID = OT2002.InventoryID), ''3311'',
		   Orders, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
	       Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, TransactionID, '''+@SOrderID+''', '''+@SOrderID+''',
	       ConvertedQuantity, ConvertedSalePrice, StandardPrice, StandardAmount, InheritTableID, InheritVoucherID, InheritTransactionID
	FROM OT2002
	WHERE SOrderID = '''+@SOrderID+''' AND IsProInventoryID =''0''
	END
END
ElSE'
SET @sSQL2 = N'
BEGIN

	SET @VoucherID = NEWID()
	---- Insert AT2006
	INSERT INTO ['+@DealerData+'].dbo.[AT2006] (DivisionID, VoucherID, TableID, TranMonth, TranYear, VoucherTypeID, VoucherDate, VoucherNo, ObjectID, OrderID, WareHouseID, KindVoucherID,
						   [Status], EmployeeID, [Description], CreateDate, CreateUserID, LastModifyUserID, LastModifyDate, InventoryTypeID, ImVoucherID, RefNo01)
	SELECT '''+@DealerDivisionID+''', @VoucherID, ''OT2001'', '''+@TranMonthText+''', '''+@TranYearText+''', '''+@VoucherTypeIDT06+''', OrderDate, '''+@VoucherNo+''', '''+@ObjectID+''', '''+@SOrderID+''', '''+@DealerDivisionID+''', 1,
		   OrderStatus, EmployeeID, Notes, GETDATE(), '''+@UserID+''', '''+@UserID+''', GETDATE(), InventoryTypeID, SOrderID, VoucherNo
	FROM OT2001
	WHERE SOrderID = '''+@SOrderID+'''

	---- Insert AT2007
	INSERT INTO ['+@DealerData+'].dbo.[AT2007] (DivisionID, TransactionID, VoucherID, InventoryID, UnitID, ActualQuantity, UnitPrice,
					   OriginalAmount, ConvertedAmount, Notes, TranMonth, TranYear, SourceNo,
					   DebitAccountID, CreditAccountID,
					   Orders, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
					   Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, ReTransactionID, ReVoucherID, SOrderID,
					   ConvertedQuantity, ConvertedPrice, StandardPrice, StandardAmount, InheritTableID, InheritVoucherID, InheritTransactionID)
	
	SELECT '''+@DealerDivisionID+''', NEWID(), @VoucherID, InventoryID, UnitID, OrderQuantity, SalePrice,
		   OriginalAmount, ConvertedAmount, Description, '''+@TranMonthText+''', '''+@TranYearText+''', SourceNo,
		   (SELECT TOP 1 AccountID FROM AT1302 WITH (NOLOCK) WHERE DivisionID IN ('''+@DivisionID+''',''@@@'') AND InventoryID = OT2002.InventoryID), ''3311'',
		   Orders, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
	       Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, TransactionID, '''+@SOrderID+''', '''+@SOrderID+''',
	       ConvertedQuantity, ConvertedSalePrice, StandardPrice, StandardAmount, InheritTableID, InheritVoucherID, InheritTransactionID
	FROM OT2002
	WHERE SOrderID = '''+@SOrderID+''' 
END'


PRINT @sSQL
PRINT @sSQL1
PRINT @sSQL2
EXEC (@sSQL + @sSQL1+ @sSQL2)








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

