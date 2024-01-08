IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP5558_FU]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP5558_FU]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










--Create By: Dang Le Bao Quynh; Date 31/03/2009
--Purpose: Ke thua ban hang cho Fei Yueh
--Edited By: Dang Le Bao Quynh; Date 06/12/2010
--Purpose: Doi so sanh ma doi tuong giua phan import va AT1202 tu right 3 ky tu thanh Right 5 ky tu
--Edited By: Huynh Trung Dung; Date 22/10/2012
--Purpose: Bo phan doi chieu so sanh 5 ky tu cua ma khach hang
--Edited By: Mai Duyen; Date 08/08/2014: Bo sung order by Serial (Fix truong hop Set lai STT cho co HD =1 trong cung 1 ngay)
-- Modified by Kim Vũ; Date 05/04/2016: Tạo Store riêng cho khách hàng FUYUEH
-- Modified by Kim Vu: Date 14/04/2016: Bo sung 2 Column Die Nuo
-- Modified by Kim Vu: Date 22/04/2016: Bo sung luu VatOriginalAmount, VatConvertedAmount
-- Modified by Kim Thư: Date 26/06/2019: Bổ sung lưu thêm 2 mặt hàng DVBS (phí dịch vụ bổ sung) và QC (Tiền thuê mặt bằng quảng cáo)
-- Modified by Kim Thư: Date 4/7/2019: Bỏ điều kiện IsSupplier=0, miễn IsCustomer=1 thì sẽ vô đc hóa đơn.
-- Modified by Khánh Đoan : Date 17/07/2019: Bổ sung trường InvoiceSign, InvoiceCode.
-- Modified by Khánh Đoan: Date 18/07/2019 : Sửa VATTypeID ='RGTGT1' ,
-- Modified by Khánh Đoan: Date 23/07/2019 : Sửa UnitPrice=0, Quantity = 0, và thêm check tự động HDDT
-- Modified by Huỳnh Thử: Date 14/11/2019 : Insert thêm trường SenderReceiver,VATObjectAddress,VATNo
-- Modified by Huỳnh Thử: Date 14/11/2019 : Diễn giải: Tên hàng - mã đối tượng T(tháng)/ năm đối với những phiếu có Serial : ND....
-- Modified by Huỳnh Thử: Date 22/04/2020 : Đổi: 01GTKT0/003 -> 01GTKT0/003
-- Modified by Đức Thông: Date 30/06/2020 : Thêm cột số lượng ở AT5560
-- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
-- Modified by Đức Thông on 03/11/2020: + Bổ sung thêm PRO và PTQ
--									    + Chỉnh diễn giải (TDescription) theo ngày hóa đơn
-- Modified by Minh Chương on 24/11/2020: + đổi 01GTKT0/004 thành 01GTKT0/003	
--										  + cột DIE và NUO khi import không nhập thành tiền mà nhập đơn giá, đổi cách tính với 2 mặt hàng này

-- Modified by Huỳnh Thử on 02/07/2019: Diễn giải: Tên hàng - mã đối tượng T(tháng)/ năm đối với những phiếu có ObjectID : RT....
-- Modified by Nhựt Trường on 04/11/2021: Đối với serial RC%E :
--                                          1. Điện : lấy diễn giải là tên hàng hóa từ ngày 20/(tháng trước) đến 20/( tháng hiện tại), mã bộ phận mặc định OF.
--                                          2. Nước : lấy diễn giải là tên hàng hóa từ ngày 20/(tháng trước) đến 20/( tháng hiện tại), mã bộ phận mặc định OF.
-- Modified by Nhựt Trường on 24/06/2022: [2022/06/IS/0165] - Điều chỉnh khi import hd điện theo ký hiệu %RC thay cho RC%E.
-- Modified by Nhựt Trường on 04/07/2022: [2022/06/IS/0207] - Lấy tên mặt hàng theo thiết lập như TT32.
--															- Ký hiệu: Đổi từ 01GTKT0/003 -> 1/003.
-- Modified by Nhựt Trường on 07/07/2022: Điều chỉnh điều kiện ObjectID từ %RT -> RT%.
-- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE AP5558_FU  @DivisionID nvarchar(20), @TranMonth int , @TranYear int, @EmployeeID nvarchar(20), 
				@VoucherDate datetime
				
					
AS

Declare 
	@OrderCur cursor,
	@OrderCurDetail cursor,
	@sSQL nvarchar(4000),

	
	@VoucherTypeIDT04 nvarchar(20), --But toan ban hang
	@StringKey1T04 nvarchar(20),
	@StringKey2T04 nvarchar(20),
	@StringKey3T04 nvarchar(20), 
	@OutputLenT04 int, 
	@OutputOrderT04 int,
	@SeparatedT04 int, 
	@SeparatorT04 char(1),

	@Enabled1 tinyint, 
	@Enabled2 tinyint,
	@Enabled3 tinyint,
	@S1 nvarchar(20), 
	@S2 nvarchar(20),
	@S3 nvarchar(20),
	@S1Type tinyint, 
	@S2Type tinyint,
	@S3Type tinyint, 

	@VoucherNoT04 nvarchar(20),
	@VoucherIDCheck nvarchar(20),
	@Serial as nvarchar(20),
	@InvoiceNo nvarchar(20),
	@InvoiceDate as datetime,
	@TMB as money,
	@PQL as money,
	@TKO as money,
	@DIE as decimal (28,8),
	@NUO as decimal (28,8),

	@VoucherTypeID nvarchar(20),
	@VoucherID as nvarchar(20),
	@BatchID as nvarchar(20),
	@TransactionID as nvarchar(20),
	@TransactionTypeID as nvarchar(20),
	@CurrencyID as nvarchar(20),
	@ObjectID as nvarchar(20),
	@VATNo as nvarchar(20),
	@VATObjectID as nvarchar(20),
	@VATObjectName as nvarchar(250),
	@VATObjectAddress as nvarchar(250),
	@DebitAccountID as nvarchar(20),
	@CreditAccountID as nvarchar(20),
	@ExchangeRate as money,
	@UnitPrice as decimal(28,8),
	@OriginalAmount as decimal(28,8),
	@ConvertedAmount as decimal(28,8),
	@VATTypeID as nvarchar(20),
	@VATGroupID as nvarchar(20),
	@Orders int, 
	@SenderReceiver as nvarchar(150),
	@SRDivisionName as nvarchar(150),
	@SRAddress as nvarchar(150),
	@VDescription as nvarchar(250),
	@BDescription as nvarchar(250),
	@TDescription as nvarchar(250) = '',
	@Quantity as decimal(28,8),
	@InventoryID as nvarchar(20),
	@UnitID as nvarchar(20),
	@Ana01ID as nvarchar(20),
	@Ana02ID as nvarchar(20),
	@Ana03ID as nvarchar(20),
	@OriginalAmountCN as money,
	@ExchangeRateCN as money,
	@CurrencyIDCN as nvarchar(20),
	@DiscountRate as money,
	@InventoryName1 as nvarchar(250),
	@Ana04ID as nvarchar(20),
	@Ana05ID as nvarchar(20),
	@DiscountAmount as money,
	@IsMultiTax as bit,  
	@VATOriginalAmount as decimal(28,8), 
	@VATConvertedAmount as decimal(28,8),
	@TaxAmount as decimal(28,8),
	@DVBS as decimal (28,8),
	@QC as decimal (28,8),
	@PRO as decimal (28,8),
	@PTQ as decimal (28,8),
	@SL as int,
	@InvoiceSign NVARCHAR(50),
	@InvoiceCode NVARCHAR(50),
	@InventoryName NVARCHAR(250),
	@DonGia DECIMAL(28, 8)
	
SET NOCOUNT ON 

Set @VoucherTypeID = 'BH'
Set @VoucherTypeIDT04 = @VoucherTypeID


--Lay chi so tang so chung tu ban hang
Select @Enabled1=Enabled1,@Enabled2=Enabled2,@Enabled3=Enabled3,@S1=S1,@S2=S2,@S3=S3,@S1Type=S1Type,@S2Type=S2Type,@S3Type=S3Type,
	@OutputLenT04 = OutputLength, @OutputOrderT04=OutputOrder,@SeparatedT04=Separated,@SeparatorT04=Separator
From AT1007 Where VoucherTypeID = @VoucherTypeIDT04
If @Enabled1 = 1
	Set @StringKey1T04 = 
	Case @S1Type 
	When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
	When 2 Then ltrim(@TranYear)
	When 3 Then @VoucherTypeIDT04
	When 4 Then @DivisionID
	When 5 Then @S1
	Else '' End
Else
	Set @StringKey1T04 = ''

If @Enabled2 = 1
	Set @StringKey2T04 = 
	Case @S2Type 
	When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
	When 2 Then ltrim(@TranYear)
	When 3 Then @VoucherTypeIDT04
	When 4 Then @DivisionID
	When 5 Then @S2
	Else '' End
Else
	Set @StringKey2T04 = ''

If @Enabled3 = 1
	Set @StringKey3T04 = 
	Case @S3Type 
	When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
	When 2 Then ltrim(@TranYear)
	When 3 Then @VoucherTypeIDT04
	When 4 Then @DivisionID
	When 5 Then @S3
	Else '' End
Else
	Set @StringKey3T04 = ''


Set @OrderCur = cursor static for 
--Edit Tiền điện, nước import là thông tin đơn giá; các chi phí khác là thành tiền
Select AT1202.ObjectID, Serial, Replicate('0',7-len(InvoiceNo)) + InvoiceNo,InvoiceDate,round(sum(TMB),0),round(sum(PQL),0),round(sum(TKO),0),
round(sum(DIE*SL),0), round(sum(NUO*SL),0), round(sum(DVBS),0), round(sum(PRO),0),round(sum(PTQ),0),round(sum(QC),0), round(sum(SL),0), AT1202.ObjectName, AT1202.Address, AT1202.VATNo
From AT5560
---inner Join AT1202 On Right(AT5560.ObjectID,5) = Right(AT1202.ObjectID,5) ---Rem by Trung Dung
inner Join AT1202 On AT1202.DivisionID IN (@DivisionID, '@@@') AND AT5560.ObjectID = AT1202.ObjectID
Where 
InvoiceDate = @VoucherDate And 
Serial + '_' + Replicate('0',7-len(InvoiceNo)) +  + InvoiceNo Not in (Select Isnull(Serial + '_' + InvoiceNo,'') From AT9000 Where TransactionTypeID='T04') And
AT1202.IsCustomer=1 And
AT1202.IsUpdateName=0 And
--AT1202.IsSupplier=0 And
AT1202.Disabled = 0 And
AT5560.DivisionID = @DivisionID
Group by AT1202.ObjectID, Serial, Replicate('0',7-len(InvoiceNo))  + InvoiceNo ,InvoiceDate, AT1202.ObjectName, AT1202.Address, AT1202.VATNo
Order by InvoiceDate,Serial, Replicate('0',7-len(InvoiceNo)) + InvoiceNo


Open @OrderCur

Fetch Next From @OrderCur Into @ObjectID, @Serial, @InvoiceNo, @InvoiceDate, @TMB,@PQL,@TKO, @DIE, @NUO, @DVBS, @PRO, @PTQ, @QC, @SL, @SenderReceiver,@VATObjectAddress,@VATNo
While @@Fetch_Status = 0
Begin
	
		--Import Hoa don ban hang
		EXEC AP0000 @DivisionID , @VoucherNoT04 Output, 'AT9000', @StringKey1T04, @StringKey2T04, @StringKey3T04, @OutputLenT04, @OutputOrderT04, @SeparatedT04, @SeparatorT04
		EXEC AP0000 @DivisionID, @VoucherID Output, 'AT9000', 'AV', @TranYear, '', 16, 3, 0, '-'
		EXEC AP0000 @DivisionID, @BatchID Output, 'AT9000', 'AB', @TranYear, '', 16, 3, 0, '-'
		
		BEGIN TRAN
			IF(@NUO > 0)
				SET @IsMultiTax =1
			ELSE 
				SET @IsMultiTax =0
			--Tien thue mat bang
			If @TMB>0
			Begin
				IF @Serial LIKE 'RC%P' OR @Serial LIKE '%ND'
				BEGIN
					SELECT @InventoryName = InventoryName
                    FROM AT1302
                    WHERE DivisionID IN (@DivisionID, '@@@')
                                  AND InventoryID = 'TMB'

					SET @TDescription = @InventoryName +' '+ @ObjectID
					IF @TranMonth = 10 AND @TranYear = 2020 AND (@ObjectID LIKE 'TO%' OR  @ObjectID LIKE 'EV%')
						SET @TDescription = @TDescription + N' từ 01/10/2020 - 25/10/2020'
					ELSE
					BEGIN
						IF @ObjectID LIKE 'RT%'
						BEGIN
						    SET @TDescription = @TDescription +  ' T' + LTRIM(STR(@TranMonth )) + '/' + LTRIM(STR(@TranYear))
						END
						ELSE --IF (@ObjectID LIKE 'TO%' OR  @ObjectID LIKE 'EV%')
						BEGIN
						    SET @TDescription = @TDescription + N' từ 26/'
							IF @TranMonth = 1
								SET @TDescription = @TDescription + '12/' + LTRIM(STR(@TranYear - 1))
							ELSE
							SET @TDescription = @TDescription + LTRIM(STR(@TranMonth - 1)) + '/' + LTRIM(STR(@TranYear))
						SET @TDescription = @TDescription + ' - 25/' + LTRIM(STR(@TranMonth)) + '/' + LTRIM(STR(@TranYear))
						END
					END
				END
				set @InventoryName1 = @TDescription
				Set @UnitID = (Select Top 1 UnitID From AT1302 Where DivisionID IN (@DivisionID,'@@@') AND InventoryID = 'TMB')
	
				EXEC AP0000 @DivisionID, @TransactionID Output, 'AT9000', 'AT', @TranYear, '', 16, 3, 0, '-'
				
				SET @DonGia = CASE ISNULL(@SL, 0) WHEN 0 THEN @TMB ELSE ROUND(@TMB / @SL, 0) END

				Insert Into AT9000
				(
					VoucherID, BatchID, TransactionID, TableID, DivisionID, TranMonth, TranYear, 
					VoucherDate, InvoiceDate, VoucherTypeID, VoucherNo, Serial, InvoiceNo, TDescription, BDescription, 
					EmployeeID, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, 
					TransactionTypeID, CurrencyID, ObjectID, VATObjectID, DebitAccountID, CreditAccountID, ExchangeRate, UnitPrice,
					OriginalAmount, ConvertedAmount, VATTypeID, VATGroupID, Quantity, Orders, 
					InventoryID, UnitID, Ana01ID, Ana02ID, Ana03ID, OriginalAmountCN, ExchangeRateCN, CurrencyIDCN, DiscountRate, 
					InventoryName1, Ana04ID, Ana05ID, IsMultiTax, VATOriginalAmount, VATConvertedAmount,
					InvoiceSign,InvoiceCode,IsEInvoice,SenderReceiver,VATObjectAddress,VATNo
	
				)
				Values
				(
					@VoucherID, @BatchID, @TransactionID, 'AT9000', @DivisionID, @TranMonth, @TranYear, 
					@VoucherDate, @InvoiceDate, @VoucherTypeID, @VoucherNoT04, @Serial, @InvoiceNo, @TDescription, N'Dịch vụ cho thuê mặt bằng, phí quản lý', 
					@EmployeeID, getDate(), @EmployeeID, getDate(), @EmployeeID, 
					'T04', 'VND', @ObjectID, @ObjectID, '1311', '5113', 1, @DonGia,
					@TMB, @TMB, 'RGTGT1', 'T10', @SL,1,
					'TMB', @UnitID, 'TMB', @Ana02ID, 'RE', @TMB, 1, 'VND', @DiscountRate, @InventoryName1, @Ana04ID, @Ana05ID, @IsMultiTax,
					ROUND(@TMB * 10 / 100,0), ROUND(@TMB * 10 / 100,0),
					'1/003','01GTKT',1,@SenderReceiver,@VATObjectAddress,@VATNo
	
				)
			End
			--Phi quan ly
			If @PQL>0
			Begin
				IF @Serial LIKE 'RC%P' OR @Serial LIKE '%ND'
				BEGIN
					SELECT @InventoryName = InventoryName
                    FROM AT1302
                    WHERE DivisionID IN (@DivisionID, '@@@')
                                  AND InventoryID = 'PQL'

					SET @TDescription = @InventoryName +' '+ @ObjectID
					IF @TranMonth = 10 AND @TranYear = 2020 AND (@ObjectID LIKE 'TO%' OR  @ObjectID LIKE 'EV%')
						SET @TDescription = @TDescription + N' từ 01/10/2020 - 25/10/2020'
					ELSE
					BEGIN
						IF @ObjectID LIKE 'RT%'
						BEGIN
						    SET @TDescription = @TDescription +  ' T' + LTRIM(STR(@TranMonth )) + '/' + LTRIM(STR(@TranYear))
						END
						ELSE --IF (@ObjectID LIKE 'TO%' OR  @ObjectID LIKE 'EV%')
						BEGIN
						    SET @TDescription = @TDescription + N' từ 26/'
							IF @TranMonth = 1
								SET @TDescription = @TDescription + '12/' + LTRIM(STR(@TranYear - 1))
							ELSE
							SET @TDescription = @TDescription + LTRIM(STR(@TranMonth - 1)) + '/' + LTRIM(STR(@TranYear))
						SET @TDescription = @TDescription + ' - 25/' + LTRIM(STR(@TranMonth)) + '/' + LTRIM(STR(@TranYear))
						END
					END
					set @InventoryName1 = @TDescription
				END
	
				EXEC AP0000 @DivisionID, @TransactionID Output, 'AT9000', 'AT', @TranYear, '', 16, 3, 0, '-'
				
				SET @DonGia = CASE ISNULL(@SL, 0) WHEN 0 THEN @PQL ELSE ROUND(@PQL / @SL, 0) END

				Insert Into AT9000
				(
					VoucherID, BatchID, TransactionID, TableID, DivisionID, TranMonth, TranYear, 
					VoucherDate, InvoiceDate, VoucherTypeID, VoucherNo, Serial, InvoiceNo, TDescription, BDescription, 
					EmployeeID, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, 
					TransactionTypeID, CurrencyID, ObjectID, VATObjectID, DebitAccountID, CreditAccountID, ExchangeRate, UnitPrice,
					OriginalAmount, ConvertedAmount, VATTypeID, VATGroupID, Quantity,Orders, 
					InventoryID, UnitID, Ana01ID, Ana02ID, Ana03ID, OriginalAmountCN, ExchangeRateCN, CurrencyIDCN, 
					DiscountRate, InventoryName1, Ana04ID, Ana05ID, IsMultiTax,
					VATOriginalAmount, VATConvertedAmount,InvoiceSign ,InvoiceCode,IsEInvoice,SenderReceiver,VATObjectAddress,VATNo
	
	
				)
				Values
				(
					@VoucherID, @BatchID, @TransactionID, 'AT9000', @DivisionID, @TranMonth, @TranYear, 
					@VoucherDate, @InvoiceDate, @VoucherTypeID, @VoucherNoT04, @Serial, @InvoiceNo, @TDescription, N'Dịch vụ cho thuê mặt bằng, phí quản lý', 
					@EmployeeID, getDate(), @EmployeeID, getDate(), @EmployeeID, 
					'T04', 'VND', @ObjectID, @ObjectID, '1311', '5113', 1, @DonGia,
					@PQL, @PQL, 'RGTGT1', 'T10', @SL,2,
					'PQL', @UnitID, 'PQL', @Ana02ID, 'RE', @PQL, 1, 'VND', @DiscountRate, @InventoryName1, @Ana04ID, @Ana05ID , @IsMultiTax,
					ROUND(@PQL * 10 / 100,0), ROUND(@PQL * 10 / 100,0),'1/003','01GTKT',1,@SenderReceiver,@VATObjectAddress,@VATNo
	

				)
			End
			--Tien thue kho	
			If @TKO>0
			Begin
				IF @Serial LIKE 'RC%P' OR @Serial LIKE '%ND'
				BEGIN
					SELECT @InventoryName = InventoryName
                    FROM AT1302
                    WHERE DivisionID IN (@DivisionID, '@@@')
                                  AND InventoryID = 'TKO'

					SET @TDescription = @InventoryName +' '+ @ObjectID
					IF @TranMonth = 10 AND @TranYear = 2020 AND (@ObjectID LIKE 'TO%' OR  @ObjectID LIKE 'EV%')
						SET @TDescription = @TDescription + N' từ 01/10/2020 - 25/10/2020'
					ELSE
					BEGIN
						IF @ObjectID LIKE 'RT%'
						BEGIN
						    SET @TDescription = @TDescription +  ' T' + LTRIM(STR(@TranMonth )) + '/' + LTRIM(STR(@TranYear))
						END
						ELSE --IF (@ObjectID LIKE 'TO%' OR  @ObjectID LIKE 'EV%')
						BEGIN
						    SET @TDescription = @TDescription + N' từ 26/'
							IF @TranMonth = 1
								SET @TDescription = @TDescription + '12/' + LTRIM(STR(@TranYear - 1))
							ELSE
							SET @TDescription = @TDescription + LTRIM(STR(@TranMonth - 1)) + '/' + LTRIM(STR(@TranYear))
						SET @TDescription = @TDescription + ' - 25/' + LTRIM(STR(@TranMonth)) + '/' + LTRIM(STR(@TranYear))
						END
					END
					set @InventoryName1 = @TDescription
				END
	

				EXEC AP0000 @DivisionID, @TransactionID Output, 'AT9000', 'AT', @TranYear, '', 16, 3, 0, '-'
				
				SET @DonGia = CASE ISNULL(@SL, 0) WHEN 0 THEN @TKO ELSE ROUND(@TKO / @SL, 0) END

				Insert Into AT9000
				(
					VoucherID, BatchID, TransactionID, TableID, DivisionID, TranMonth, TranYear, 
					VoucherDate, InvoiceDate, VoucherTypeID, VoucherNo, Serial, InvoiceNo, TDescription, BDescription, 
					EmployeeID, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, 
					TransactionTypeID, CurrencyID, ObjectID, VATObjectID, DebitAccountID, CreditAccountID, ExchangeRate, UnitPrice,
					OriginalAmount, ConvertedAmount, VATTypeID, VATGroupID, Quantity,Orders, 
					InventoryID, UnitID, Ana01ID, Ana02ID, Ana03ID, OriginalAmountCN, ExchangeRateCN, CurrencyIDCN, 
					DiscountRate, InventoryName1, Ana04ID, Ana05ID, IsMultiTax, VATOriginalAmount, VATConvertedAmount,
					InvoiceSign ,InvoiceCode,IsEInvoice,SenderReceiver,VATObjectAddress,VATNo
	
	
				)
				Values
				(
					@VoucherID, @BatchID, @TransactionID, 'AT9000', @DivisionID, @TranMonth, @TranYear, 
					@VoucherDate, @InvoiceDate, @VoucherTypeID, @VoucherNoT04, @Serial, @InvoiceNo, @TDescription, N'Dịch vụ cho thuê mặt bằng, phí quản lý', 
					@EmployeeID, getDate(), @EmployeeID, getDate(), @EmployeeID, 
					'T04', 'VND', @ObjectID, @ObjectID, '1311', '5113', 1, @DonGia,
					@TKO, @TKO, 'RGTGT1', 'T10', @SL, 3,
					'TKO', @UnitID, 'TKO', @Ana02ID, 'RE', @TKO, 1, 'VND', @DiscountRate, @InventoryName1, @Ana04ID, @Ana05ID, @IsMultiTax,
					ROUND(@TKO * 10 / 100,0), ROUND(@TKO * 10 / 100,0)
					,'1/003','01GTKT',1,@SenderReceiver,@VATObjectAddress,@VATNo
	
				)
				
			End
			--But toan thue NUO
			If(@NUO >0)
			begin
				Set @TaxAmount = Round((@NUO)*5/100,0)
					Set @TDescription = N'Thuế GTGT'
					Set @UnitID = (Select Top 1 UnitID From AT1302 Where DivisionID IN (@DivisionID,'@@@') AND InventoryID = 'NUO')
	
					EXEC AP0000 @DivisionID, @TransactionID Output, 'AT9000', 'AT', @TranYear, '', 16, 3, 0, '-'
					
					SET @DonGia = CASE ISNULL(@SL, 0) WHEN 0 THEN 0 ELSE ROUND(@NUO / @SL, 0) END
					
					Insert Into AT9000
					(
						VoucherID, BatchID, TransactionID, TableID, DivisionID, TranMonth, TranYear, 
						VoucherDate, InvoiceDate, VoucherTypeID, VoucherNo, Serial, InvoiceNo, TDescription, BDescription, 
						EmployeeID, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, 
						TransactionTypeID, CurrencyID, ObjectID, VatObjectID, DebitAccountID, CreditAccountID, ExchangeRate, UnitPrice,
						OriginalAmount, ConvertedAmount, VATTypeID, VATGroupID, Quantity,
						InventoryID, UnitID, Ana01ID, Ana02ID, Ana03ID, OriginalAmountCN, ExchangeRateCN, CurrencyIDCN, DiscountRate, InventoryName1, Ana04ID, Ana05ID,
						InvoiceSign ,InvoiceCode,IsEInvoice,SenderReceiver,VATObjectAddress,VATNo
	
	
					)
					Values
					(
						@VoucherID, @BatchID, @TransactionID, 'AT9000', @DivisionID, @TranMonth, @TranYear, 
						@VoucherDate, @InvoiceDate, @VoucherTypeID, @VoucherNoT04, @Serial, @InvoiceNo, @TDescription, N'Dịch vụ cho thuê mặt bằng, phí quản lý', 
						@EmployeeID, getDate(), @EmployeeID, getDate(), @EmployeeID, 
						'T14', 'VND', @ObjectID, @ObjectID, '1311', '33311', 1, @DonGia,
						@TaxAmount, @TaxAmount, 'RGTGT1', 'T05',@SL,
						Null, Null, 'TMB', @Ana02ID, 'RE', @TaxAmount, 1, 'VND', @DiscountRate, @InventoryName1, @Ana04ID, @Ana05ID	,
						'1/003','01GTKT',1,@SenderReceiver,@VATObjectAddress,@VATNo
	
					)
			end
			--But toan thue cac mat hang 10%
			If @TMB + @PQL + @TKO + @DIE + @DVBS + @QC + @PRO + @PTQ > 0
				Begin
					Set @TaxAmount = Round((@TMB + @PQL + @TKO + @DVBS + @QC + @PRO + @PTQ)*10/100,0) + Round(@DIE * 8/100,0)
					Set @TDescription = N'Thuế GTGT'
					Set @UnitID = (Select Top 1 UnitID From AT1302 Where DivisionID IN (@DivisionID,'@@@') AND InventoryID = 'TKO')
	
					EXEC AP0000 @DivisionID, @TransactionID Output, 'AT9000', 'AT', @TranYear, '', 16, 3, 0, '-'
					
					SET @DonGia = CASE ISNULL(@SL, 0) WHEN 0 THEN 0 ELSE ROUND((@TMB + @PQL + @TKO + @DIE + @DVBS + @QC  + @PRO + @PTQ) / @SL, 0) END

					Insert Into AT9000
					(
						VoucherID, BatchID, TransactionID, TableID, DivisionID, TranMonth, TranYear, 
						VoucherDate, InvoiceDate, VoucherTypeID, VoucherNo, Serial, InvoiceNo, TDescription, BDescription, 
						EmployeeID, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, 
						TransactionTypeID, CurrencyID, ObjectID, VatObjectID, DebitAccountID, CreditAccountID, ExchangeRate, UnitPrice,
						OriginalAmount, ConvertedAmount, VATTypeID, VATGroupID, Quantity,
						InventoryID, UnitID, Ana01ID, Ana02ID, Ana03ID, OriginalAmountCN, ExchangeRateCN, CurrencyIDCN, DiscountRate, InventoryName1, Ana04ID, Ana05ID,
						InvoiceSign ,InvoiceCode,IsEInvoice,SenderReceiver,VATObjectAddress,VATNo
	
	
					)
					Values
					(
						@VoucherID, @BatchID, @TransactionID, 'AT9000', @DivisionID, @TranMonth, @TranYear, 
						@VoucherDate, @InvoiceDate, @VoucherTypeID, @VoucherNoT04, @Serial, @InvoiceNo, @TDescription, N'Dịch vụ cho thuê mặt bằng, phí quản lý', 
						@EmployeeID, getDate(), @EmployeeID, getDate(), @EmployeeID, 
						'T14', 'VND', @ObjectID, @ObjectID, '1311', '33311', 1, @DonGia,
						@TaxAmount, @TaxAmount, 'RGTGT1', CASE WHEN @DIE > 0 THEN 'T08' ELSE 'T10' END,@SL,
						Null, Null, 'TMB', @Ana02ID, 'RE', @TaxAmount, 1, 'VND', @DiscountRate, @InventoryName1, @Ana04ID, @Ana05ID,
						'1/003','01GTKT',1,@SenderReceiver,@VATObjectAddress,@VATNo
	
	
					)
				End

			-- Ban hang DIE
			If @DIE>0
			Begin
				IF @Serial LIKE 'RC%P' OR @Serial LIKE '%ND'
				BEGIN
					SELECT @InventoryName = InventoryName
                    FROM AT1302
                    WHERE DivisionID IN (@DivisionID, '@@@')
                                  AND InventoryID = 'DIE'

					SET @TDescription = @InventoryName +' '+ @ObjectID
					IF @TranMonth = 10 AND @TranYear = 2020 AND (@ObjectID LIKE 'TO%' OR  @ObjectID LIKE 'EV%')
						SET @TDescription = @TDescription + N' từ 01/10/2020 - 25/10/2020'
					ELSE
					BEGIN
						IF @ObjectID LIKE 'RT%'
						BEGIN
						    SET @TDescription = @TDescription +  ' T' + LTRIM(STR(@TranMonth )) + '/' + LTRIM(STR(@TranYear))
						END
						ELSE --IF (@ObjectID LIKE 'TO%' OR  @ObjectID LIKE 'EV%')
						BEGIN
						    SET @TDescription = @TDescription + N' từ 26/'
							IF @TranMonth = 1
								SET @TDescription = @TDescription + '12/' + LTRIM(STR(@TranYear - 1))
							ELSE
							SET @TDescription = @TDescription + LTRIM(STR(@TranMonth - 1)) + '/' + LTRIM(STR(@TranYear))
						SET @TDescription = @TDescription + ' - 25/' + LTRIM(STR(@TranMonth)) + '/' + LTRIM(STR(@TranYear))
						END
					END
				END

				IF @Serial LIKE '%RC'
				BEGIN
					SELECT @InventoryName = InventoryName
                    FROM AT1302
                    WHERE DivisionID IN (@DivisionID, '@@@')
                                  AND InventoryID = 'DIE'

					SET @TDescription = @InventoryName
					IF @TranMonth = 10 AND @TranYear = 2020 AND (@ObjectID LIKE 'TO%' OR  @ObjectID LIKE 'EV%')
						SET @TDescription = @TDescription + N' từ 01/10/2020 - 25/10/2020'
					ELSE
					BEGIN
						SET @TDescription = @TDescription + N' từ 20/'
						IF @TranMonth = 1
							SET @TDescription = @TDescription + '12/' + LTRIM(STR(@TranYear - 1))
						ELSE
							SET @TDescription = @TDescription + LTRIM(STR(@TranMonth - 1)) + '/' + LTRIM(STR(@TranYear))
						SET @TDescription = @TDescription + ' - 20/' + LTRIM(STR(@TranMonth)) + '/' + LTRIM(STR(@TranYear))
					END
				END

				set @InventoryName1 = @TDescription
				Set @UnitID = (Select Top 1 UnitID From AT1302 Where DivisionID IN (@DivisionID,'@@@') AND InventoryID = 'DIE')
	
				EXEC AP0000 @DivisionID, @TransactionID Output, 'AT9000', 'AT', @TranYear, '', 16, 3, 0, '-'
				
				SET @DonGia = CASE ISNULL(@SL, 0) WHEN 0 THEN 0 ELSE ROUND(@DIE / @SL, 0) END
				
				IF @Serial LIKE '%RC'
				BEGIN
					Insert Into AT9000
					(
						VoucherID, BatchID, TransactionID, TableID, DivisionID, TranMonth, TranYear, 
						VoucherDate, InvoiceDate, VoucherTypeID, VoucherNo, Serial, InvoiceNo, TDescription, BDescription, 
						EmployeeID, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, 
						TransactionTypeID, CurrencyID, ObjectID, VATObjectID, DebitAccountID, CreditAccountID, ExchangeRate, UnitPrice,
						OriginalAmount, ConvertedAmount, VATTypeID, VATGroupID, Quantity, Orders, 
						InventoryID, UnitID, Ana01ID, Ana02ID, Ana03ID, OriginalAmountCN, ExchangeRateCN, CurrencyIDCN, 
						DiscountRate, InventoryName1, Ana04ID, Ana05ID, IsMultiTax, VATOriginalAmount, VATConvertedAmount,
						InvoiceSign ,InvoiceCode,IsEInvoice,SenderReceiver,VATObjectAddress,VATNo
	
					)
					Values
					(
						@VoucherID, @BatchID, @TransactionID, 'AT9000', @DivisionID, @TranMonth, @TranYear, 
						@VoucherDate, @InvoiceDate, @VoucherTypeID, @VoucherNoT04, @Serial, @InvoiceNo, @TDescription, N'Dịch vụ cho thuê mặt bằng, phí quản lý', 
						@EmployeeID, getDate(), @EmployeeID, getDate(), @EmployeeID, 
						'T04', 'VND', @ObjectID, @ObjectID, '1311', '5113', 1, @DonGia,
						@DIE, @DIE, 'RGTGT1', 'T08', @SL,4,
						'DIE', @UnitID, 'DIE', @Ana02ID, 'OF', @DIE, 1, 'VND', @DiscountRate, @InventoryName1, @Ana04ID, @Ana05ID, @IsMultiTax,
						Round((@DIE)*10/100,0), Round((@DIE)*10/100,0),
						'1/003','01GTKT',1,@SenderReceiver,@VATObjectAddress,@VATNo
	
	
					)
				END
				ELSE
				BEGIN
					Insert Into AT9000
					(
						VoucherID, BatchID, TransactionID, TableID, DivisionID, TranMonth, TranYear, 
						VoucherDate, InvoiceDate, VoucherTypeID, VoucherNo, Serial, InvoiceNo, TDescription, BDescription, 
						EmployeeID, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, 
						TransactionTypeID, CurrencyID, ObjectID, VATObjectID, DebitAccountID, CreditAccountID, ExchangeRate, UnitPrice,
						OriginalAmount, ConvertedAmount, VATTypeID, VATGroupID, Quantity, Orders, 
						InventoryID, UnitID, Ana01ID, Ana02ID, Ana03ID, OriginalAmountCN, ExchangeRateCN, CurrencyIDCN, 
						DiscountRate, InventoryName1, Ana04ID, Ana05ID, IsMultiTax, VATOriginalAmount, VATConvertedAmount,
						InvoiceSign ,InvoiceCode,IsEInvoice,SenderReceiver,VATObjectAddress,VATNo
	
					)
					Values
					(
						@VoucherID, @BatchID, @TransactionID, 'AT9000', @DivisionID, @TranMonth, @TranYear, 
						@VoucherDate, @InvoiceDate, @VoucherTypeID, @VoucherNoT04, @Serial, @InvoiceNo, @TDescription, N'Dịch vụ cho thuê mặt bằng, phí quản lý', 
						@EmployeeID, getDate(), @EmployeeID, getDate(), @EmployeeID, 
						'T04', 'VND', @ObjectID, @ObjectID, '1311', '5113', 1, @DonGia,
						@DIE, @DIE, 'RGTGT1', 'T08', @SL,4,
						'DIE', @UnitID, 'DIE', @Ana02ID, 'RE', @DIE, 1, 'VND', @DiscountRate, @InventoryName1, @Ana04ID, @Ana05ID, @IsMultiTax,
						Round((@DIE)*10/100,0), Round((@DIE)*10/100,0),
						'1/003','01GTKT',1,@SenderReceiver,@VATObjectAddress,@VATNo
	
	
					)
				END
			End

			-- Ban hang NUO
			If @NUO>0
			Begin
				IF @Serial LIKE 'RC%P' OR @Serial LIKE '%ND'
				BEGIN
					SELECT @InventoryName = InventoryName
                    FROM AT1302
                    WHERE DivisionID IN (@DivisionID, '@@@')
                                  AND InventoryID = 'NUO'

					SET @TDescription = @InventoryName +' '+ @ObjectID
					IF @TranMonth = 10 AND @TranYear = 2020 AND (@ObjectID LIKE 'TO%' OR  @ObjectID LIKE 'EV%')
						SET @TDescription = @TDescription + N' từ 01/10/2020 - 25/10/2020'
					ELSE
					BEGIN
						IF @ObjectID LIKE 'RT%'
						BEGIN
						    SET @TDescription = @TDescription +  ' T' + LTRIM(STR(@TranMonth )) + '/' + LTRIM(STR(@TranYear))
						END
						ELSE --IF (@ObjectID LIKE 'TO%' OR  @ObjectID LIKE 'EV%')
						BEGIN
						    SET @TDescription = @TDescription + N' từ 26/'
							IF @TranMonth = 1
								SET @TDescription = @TDescription + '12/' + LTRIM(STR(@TranYear - 1))
							ELSE
							SET @TDescription = @TDescription + LTRIM(STR(@TranMonth - 1)) + '/' + LTRIM(STR(@TranYear))
						SET @TDescription = @TDescription + ' - 25/' + LTRIM(STR(@TranMonth)) + '/' + LTRIM(STR(@TranYear))
						END
					END
				END

				IF @Serial LIKE '%RC'
				BEGIN
					SELECT @InventoryName = InventoryName
                    FROM AT1302
                    WHERE DivisionID IN (@DivisionID, '@@@')
                                  AND InventoryID = 'NUO'

					SET @TDescription = @InventoryName
					IF @TranMonth = 10 AND @TranYear = 2020 AND (@ObjectID LIKE 'TO%' OR  @ObjectID LIKE 'EV%')
						SET @TDescription = @TDescription + N' từ 01/10/2020 - 25/10/2020'
					ELSE
					BEGIN
						SET @TDescription = @TDescription + N' từ 20/'
						IF @TranMonth = 1
							SET @TDescription = @TDescription + '12/' + LTRIM(STR(@TranYear - 1))
						ELSE
							SET @TDescription = @TDescription + LTRIM(STR(@TranMonth - 1)) + '/' + LTRIM(STR(@TranYear))
						SET @TDescription = @TDescription + ' - 20/' + LTRIM(STR(@TranMonth)) + '/' + LTRIM(STR(@TranYear))
					END
				END

				set @InventoryName1 = @TDescription
				Set @UnitID = (Select Top 1 UnitID From AT1302 Where DivisionID IN (@DivisionID,'@@@') AND InventoryID = 'NUO')
	
				EXEC AP0000 @DivisionID, @TransactionID Output, 'AT9000', 'AT', @TranYear, '', 16, 3, 0, '-'
				
				SET @DonGia = CASE ISNULL(@SL, 0) WHEN 0 THEN 0 ELSE ROUND(@NUO / @SL, 0) END

				IF @Serial LIKE '%RC'
				BEGIN
					Insert Into AT9000
					(
						VoucherID, BatchID, TransactionID, TableID, DivisionID, TranMonth, TranYear, 
						VoucherDate, InvoiceDate, VoucherTypeID, VoucherNo, Serial, InvoiceNo, TDescription, BDescription, 
						EmployeeID, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, 
						TransactionTypeID, CurrencyID, ObjectID, VATObjectID, DebitAccountID, CreditAccountID, ExchangeRate, UnitPrice,
						OriginalAmount, ConvertedAmount, VATTypeID, VATGroupID, Quantity, Orders, 
						InventoryID, UnitID, Ana01ID, Ana02ID, Ana03ID, OriginalAmountCN, ExchangeRateCN, CurrencyIDCN, 
						DiscountRate, InventoryName1, Ana04ID, Ana05ID, IsMultiTax, VATOriginalAmount, VATConvertedAmount,
						InvoiceSign ,InvoiceCode,IsEInvoice,SenderReceiver,VATObjectAddress,VATNo
	
					)
					Values
					(
						@VoucherID, @BatchID, @TransactionID, 'AT9000', @DivisionID, @TranMonth, @TranYear, 
						@VoucherDate, @InvoiceDate, @VoucherTypeID, @VoucherNoT04, @Serial, @InvoiceNo, @TDescription, N'Dịch vụ cho thuê mặt bằng, phí quản lý', 
						@EmployeeID, getDate(), @EmployeeID, getDate(), @EmployeeID, 
						'T04', 'VND', @ObjectID, @ObjectID, '1311', '5113', 1, @DonGia,
						@NUO, @NUO, 'RGTGT1', 'T05', @SL,5,
						'NUO', @UnitID, 'NUO', @Ana02ID, 'OF', @NUO, 1, 'VND', @DiscountRate, @InventoryName1, @Ana04ID, @Ana05ID, @IsMultiTax,
						Round((@NUO)*5/100,0), Round((@NUO)*5/100,0),
						'1/003','01GTKT',1,@SenderReceiver,@VATObjectAddress,@VATNo
	

	
					)
				END
				ELSE
				BEGIN
					Insert Into AT9000
					(
						VoucherID, BatchID, TransactionID, TableID, DivisionID, TranMonth, TranYear, 
						VoucherDate, InvoiceDate, VoucherTypeID, VoucherNo, Serial, InvoiceNo, TDescription, BDescription, 
						EmployeeID, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, 
						TransactionTypeID, CurrencyID, ObjectID, VATObjectID, DebitAccountID, CreditAccountID, ExchangeRate, UnitPrice,
						OriginalAmount, ConvertedAmount, VATTypeID, VATGroupID, Quantity, Orders, 
						InventoryID, UnitID, Ana01ID, Ana02ID, Ana03ID, OriginalAmountCN, ExchangeRateCN, CurrencyIDCN, 
						DiscountRate, InventoryName1, Ana04ID, Ana05ID, IsMultiTax, VATOriginalAmount, VATConvertedAmount,
						InvoiceSign ,InvoiceCode,IsEInvoice,SenderReceiver,VATObjectAddress,VATNo
	
					)
					Values
					(
						@VoucherID, @BatchID, @TransactionID, 'AT9000', @DivisionID, @TranMonth, @TranYear, 
						@VoucherDate, @InvoiceDate, @VoucherTypeID, @VoucherNoT04, @Serial, @InvoiceNo, @TDescription, N'Dịch vụ cho thuê mặt bằng, phí quản lý', 
						@EmployeeID, getDate(), @EmployeeID, getDate(), @EmployeeID, 
						'T04', 'VND', @ObjectID, @ObjectID, '1311', '5113', 1, @DonGia,
						@NUO, @NUO, 'RGTGT1', 'T05', @SL,5,
						'NUO', @UnitID, 'NUO', @Ana02ID, 'RE', @NUO, 1, 'VND', @DiscountRate, @InventoryName1, @Ana04ID, @Ana05ID, @IsMultiTax,
						Round((@NUO)*5/100,0), Round((@NUO)*5/100,0),
						'1/003','01GTKT',1,@SenderReceiver,@VATObjectAddress,@VATNo
	

	
					)
				END
			End

			-- Ban hang DVBS
			If @DVBS>0
			Begin
				IF @Serial LIKE 'RC%P' OR @Serial LIKE '%ND'
				BEGIN
					SELECT @InventoryName = InventoryName
                    FROM AT1302
                    WHERE DivisionID IN (@DivisionID, '@@@')
                                  AND InventoryID = 'DVBS'

					SET @TDescription = @InventoryName +' '+ @ObjectID
					IF @TranMonth = 10 AND @TranYear = 2020 AND (@ObjectID LIKE 'TO%' OR  @ObjectID LIKE 'EV%')
						SET @TDescription = @TDescription + N' từ 01/10/2020 - 25/10/2020'
					ELSE
					BEGIN
						IF @ObjectID LIKE 'RT%'
						BEGIN
						    SET @TDescription = @TDescription +  ' T' + LTRIM(STR(@TranMonth )) + '/' + LTRIM(STR(@TranYear))
						END
						ELSE --IF (@ObjectID LIKE 'TO%' OR  @ObjectID LIKE 'EV%')
						BEGIN
						    SET @TDescription = @TDescription + N' từ 26/'
							IF @TranMonth = 1
								SET @TDescription = @TDescription + '12/' + LTRIM(STR(@TranYear - 1))
							ELSE
							SET @TDescription = @TDescription + LTRIM(STR(@TranMonth - 1)) + '/' + LTRIM(STR(@TranYear))
						SET @TDescription = @TDescription + ' - 25/' + LTRIM(STR(@TranMonth)) + '/' + LTRIM(STR(@TranYear))
						END
					END
				END
				set @InventoryName1 = @TDescription
				Set @UnitID = (Select Top 1 UnitID From AT1302 Where DivisionID IN (@DivisionID,'@@@') AND InventoryID = 'DVBS')
	
				EXEC AP0000 @DivisionID, @TransactionID Output, 'AT9000', 'AT', @TranYear, '', 16, 3, 0, '-'
				
				SET @DonGia = CASE ISNULL(@SL, 0) WHEN 0 THEN 0 ELSE ROUND(@DVBS / @SL, 0) END

				Insert Into AT9000
				(
					VoucherID, BatchID, TransactionID, TableID, DivisionID, TranMonth, TranYear, 
					VoucherDate, InvoiceDate, VoucherTypeID, VoucherNo, Serial, InvoiceNo, TDescription, BDescription, 
					EmployeeID, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, 
					TransactionTypeID, CurrencyID, ObjectID, VATObjectID, DebitAccountID, CreditAccountID, ExchangeRate, UnitPrice,
					OriginalAmount, ConvertedAmount, VATTypeID, VATGroupID, Quantity, Orders, 
					InventoryID, UnitID, Ana01ID, Ana02ID, Ana03ID, OriginalAmountCN, ExchangeRateCN, CurrencyIDCN, 
					DiscountRate, InventoryName1, Ana04ID, Ana05ID, IsMultiTax, VATOriginalAmount, VATConvertedAmount,
					InvoiceSign ,InvoiceCode,IsEInvoice,SenderReceiver,VATObjectAddress,VATNo
	
				)
				Values
				(
					@VoucherID, @BatchID, @TransactionID, 'AT9000', @DivisionID, @TranMonth, @TranYear, 
					@VoucherDate, @InvoiceDate, @VoucherTypeID, @VoucherNoT04, @Serial, @InvoiceNo, @TDescription, N'Dịch vụ cho thuê mặt bằng, phí quản lý', 
					@EmployeeID, getDate(), @EmployeeID, getDate(), @EmployeeID, 
					'T04', 'VND', @ObjectID, @ObjectID, '1311', '5113', 1, @DonGia,
					@DVBS, @DVBS, 'RGTGT1', 'T10', @SL,6,
					'DVBS', @UnitID, 'PQL', @Ana02ID, 'RE', @DVBS, 1, 'VND', @DiscountRate, @InventoryName1, @Ana04ID, @Ana05ID, @IsMultiTax,
					Round((@DVBS)*10/100,0), Round((@DVBS)*10/100,0),
					'1/003','01GTKT',1,@SenderReceiver,@VATObjectAddress,@VATNo
	
	
				)
			End

			-- Ban hang QC
			If @QC>0
			Begin
				IF @Serial LIKE 'RC%P' OR @Serial LIKE '%ND'
				BEGIN
					SELECT @InventoryName = InventoryName
                    FROM AT1302
                    WHERE DivisionID IN (@DivisionID, '@@@')
                                  AND InventoryID = 'QC'

					SET @TDescription = @InventoryName +' '+ @ObjectID
					IF @TranMonth = 10 AND @TranYear = 2020 AND (@ObjectID LIKE 'TO%' OR  @ObjectID LIKE 'EV%')
						SET @TDescription = @TDescription + N' từ 01/10/2020 - 25/10/2020'
					ELSE
					BEGIN
						IF @ObjectID LIKE 'RT%'
						BEGIN
						    SET @TDescription = @TDescription +  ' T' + LTRIM(STR(@TranMonth )) + '/' + LTRIM(STR(@TranYear))
						END
						ELSE --IF (@ObjectID LIKE 'TO%' OR  @ObjectID LIKE 'EV%')
						BEGIN
						    SET @TDescription = @TDescription + N' từ 26/'
							IF @TranMonth = 1
								SET @TDescription = @TDescription + '12/' + LTRIM(STR(@TranYear - 1))
							ELSE
							SET @TDescription = @TDescription + LTRIM(STR(@TranMonth - 1)) + '/' + LTRIM(STR(@TranYear))
						SET @TDescription = @TDescription + ' - 25/' + LTRIM(STR(@TranMonth)) + '/' + LTRIM(STR(@TranYear))
						END
					END
				END
				set @InventoryName1 = @TDescription
				Set @UnitID = (Select Top 1 UnitID From AT1302 Where DivisionID IN (@DivisionID,'@@@') AND InventoryID = 'QC')
	
				EXEC AP0000 @DivisionID, @TransactionID Output, 'AT9000', 'AT', @TranYear, '', 16, 3, 0, '-'
				
				SET @DonGia = CASE ISNULL(@SL, 0) WHEN 0 THEN 0 ELSE ROUND(@QC / @SL, 0) END

				Insert Into AT9000
				(
					VoucherID, BatchID, TransactionID, TableID, DivisionID, TranMonth, TranYear, 
					VoucherDate, InvoiceDate, VoucherTypeID, VoucherNo, Serial, InvoiceNo, TDescription, BDescription, 
					EmployeeID, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, 
					TransactionTypeID, CurrencyID, ObjectID, VATObjectID, DebitAccountID, CreditAccountID, ExchangeRate, UnitPrice,
					OriginalAmount, ConvertedAmount, VATTypeID, VATGroupID, Quantity, Orders, 
					InventoryID, UnitID, Ana01ID, Ana02ID, Ana03ID, OriginalAmountCN, ExchangeRateCN, CurrencyIDCN, 
					DiscountRate, InventoryName1, Ana04ID, Ana05ID, IsMultiTax, VATOriginalAmount, VATConvertedAmount,
					InvoiceSign ,InvoiceCode,IsEInvoice,SenderReceiver,VATObjectAddress,VATNo
	
	
				)
				Values
				(
					@VoucherID, @BatchID, @TransactionID, 'AT9000', @DivisionID, @TranMonth, @TranYear, 
					@VoucherDate, @InvoiceDate, @VoucherTypeID, @VoucherNoT04, @Serial, @InvoiceNo, @TDescription, N'Dịch vụ cho thuê mặt bằng, phí quản lý', 
					@EmployeeID, getDate(), @EmployeeID, getDate(), @EmployeeID, 
					'T04', 'VND', @ObjectID, @ObjectID, '1311', '5113', 1, @DonGia,
					@QC, @QC, 'RGTGT1', 'T10', @SL,7,
					'QC', @UnitID, 'TMB', @Ana02ID, 'RE', @QC, 1, 'VND', @DiscountRate, @InventoryName1, @Ana04ID, @Ana05ID, @IsMultiTax,
					Round((@QC)*10/100,0), Round((@QC)*10/100,0),
					'1/003','01GTKT',1,@SenderReceiver,@VATObjectAddress,@VATNo
	

	
				)
			End

			-- PRO
			If @PRO>0
			Begin
				IF @Serial LIKE 'RC%P' OR @Serial LIKE '%ND'
				BEGIN
					SELECT @InventoryName = InventoryName
                    FROM AT1302
                    WHERE DivisionID IN (@DivisionID, '@@@')
                                  AND InventoryID = 'PRO'

					SET @TDescription = @InventoryName +' '+ @ObjectID
					IF @TranMonth = 10 AND @TranYear = 2020 AND (@ObjectID LIKE 'TO%' OR  @ObjectID LIKE 'EV%')
						SET @TDescription = @TDescription + N' từ 01/10/2020 - 25/10/2020'
					ELSE
					BEGIN
						IF @ObjectID LIKE 'RT%'
						BEGIN
						    SET @TDescription = @TDescription +  ' T' + LTRIM(STR(@TranMonth )) + '/' + LTRIM(STR(@TranYear))
						END
						ELSE --IF (@ObjectID LIKE 'TO%' OR  @ObjectID LIKE 'EV%')
						BEGIN
						    SET @TDescription = @TDescription + N' từ 26/'
							IF @TranMonth = 1
								SET @TDescription = @TDescription + '12/' + LTRIM(STR(@TranYear - 1))
							ELSE
							SET @TDescription = @TDescription + LTRIM(STR(@TranMonth - 1)) + '/' + LTRIM(STR(@TranYear))
						SET @TDescription = @TDescription + ' - 25/' + LTRIM(STR(@TranMonth)) + '/' + LTRIM(STR(@TranYear))
						END
					END
				END
				set @InventoryName1 = @TDescription
				Set @UnitID = (Select Top 1 UnitID From AT1302 Where DivisionID IN (@DivisionID,'@@@') AND InventoryID = 'PRO')
	
				EXEC AP0000 @DivisionID, @TransactionID Output, 'AT9000', 'AT', @TranYear, '', 16, 3, 0, '-'
				
				SET @DonGia = CASE ISNULL(@SL, 0) WHEN 0 THEN 0 ELSE ROUND(@PRO / @SL, 0) END

				Insert Into AT9000
				(
					VoucherID, BatchID, TransactionID, TableID, DivisionID, TranMonth, TranYear, 
					VoucherDate, InvoiceDate, VoucherTypeID, VoucherNo, Serial, InvoiceNo, TDescription, BDescription, 
					EmployeeID, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, 
					TransactionTypeID, CurrencyID, ObjectID, VATObjectID, DebitAccountID, CreditAccountID, ExchangeRate, UnitPrice,
					OriginalAmount, ConvertedAmount, VATTypeID, VATGroupID, Quantity, Orders, 
					InventoryID, UnitID, Ana01ID, Ana02ID, Ana03ID, OriginalAmountCN, ExchangeRateCN, CurrencyIDCN, 
					DiscountRate, InventoryName1, Ana04ID, Ana05ID, IsMultiTax, VATOriginalAmount, VATConvertedAmount,
					InvoiceSign ,InvoiceCode,IsEInvoice,SenderReceiver,VATObjectAddress,VATNo
	
	
				)
				Values
				(
					@VoucherID, @BatchID, @TransactionID, 'AT9000', @DivisionID, @TranMonth, @TranYear, 
					@VoucherDate, @InvoiceDate, @VoucherTypeID, @VoucherNoT04, @Serial, @InvoiceNo, @TDescription, N'Dịch vụ cho thuê mặt bằng, phí quản lý', 
					@EmployeeID, getDate(), @EmployeeID, getDate(), @EmployeeID, 
					'T04', 'VND', @ObjectID, @ObjectID, '1311', '5113', 1, @DonGia,
					@PRO, @PRO, 'RGTGT1', 'T10', @SL,7,
					'PRO', @UnitID, 'PRO', @Ana02ID, 'RE', @PRO, 1, 'VND', @DiscountRate, @InventoryName1, @Ana04ID, @Ana05ID, @IsMultiTax,
					Round((@PRO)*10/100,0), Round((@PRO)*10/100,0),
					'1/003','01GTKT',1,@SenderReceiver,@VATObjectAddress,@VATNo
	

	
				)
			End

			-- PTQ
			If @PTQ>0
			Begin
				IF @Serial LIKE 'RC%P' OR @Serial LIKE '%ND'
				BEGIN
					SELECT @InventoryName = InventoryName
                    FROM AT1302
                    WHERE DivisionID IN (@DivisionID, '@@@')
                                  AND InventoryID = 'PTQ'

					SET @TDescription = @InventoryName +' '+ @ObjectID
					IF @TranMonth = 10 AND @TranYear = 2020 AND (@ObjectID LIKE 'TO%' OR  @ObjectID LIKE 'EV%')
						SET @TDescription = @TDescription + N' từ 01/10/2020 - 25/10/2020'
					ELSE
					BEGIN
						IF @ObjectID LIKE 'RT%'
						BEGIN
						    SET @TDescription = @TDescription +  ' T' + LTRIM(STR(@TranMonth )) + '/' + LTRIM(STR(@TranYear))
						END
						ELSE --IF (@ObjectID LIKE 'TO%' OR  @ObjectID LIKE 'EV%')
						BEGIN
						    SET @TDescription = @TDescription + N' từ 26/'
							IF @TranMonth = 1
								SET @TDescription = @TDescription + '12/' + LTRIM(STR(@TranYear - 1))
							ELSE
							SET @TDescription = @TDescription + LTRIM(STR(@TranMonth - 1)) + '/' + LTRIM(STR(@TranYear))
						SET @TDescription = @TDescription + ' - 25/' + LTRIM(STR(@TranMonth)) + '/' + LTRIM(STR(@TranYear))
						END
					END
				END
				set @InventoryName1 = @TDescription
				Set @UnitID = (Select Top 1 UnitID From AT1302 Where DivisionID IN (@DivisionID,'@@@') AND InventoryID = 'PTQ')
	
				EXEC AP0000 @DivisionID, @TransactionID Output, 'AT9000', 'AT', @TranYear, '', 16, 3, 0, '-'
				
				SET @DonGia = CASE ISNULL(@SL, 0) WHEN 0 THEN 0 ELSE ROUND(@PTQ / @SL, 0) END

				Insert Into AT9000
				(
					VoucherID, BatchID, TransactionID, TableID, DivisionID, TranMonth, TranYear, 
					VoucherDate, InvoiceDate, VoucherTypeID, VoucherNo, Serial, InvoiceNo, TDescription, BDescription, 
					EmployeeID, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, 
					TransactionTypeID, CurrencyID, ObjectID, VATObjectID, DebitAccountID, CreditAccountID, ExchangeRate, UnitPrice,
					OriginalAmount, ConvertedAmount, VATTypeID, VATGroupID, Quantity, Orders, 
					InventoryID, UnitID, Ana01ID, Ana02ID, Ana03ID, OriginalAmountCN, ExchangeRateCN, CurrencyIDCN, 
					DiscountRate, InventoryName1, Ana04ID, Ana05ID, IsMultiTax, VATOriginalAmount, VATConvertedAmount,
					InvoiceSign ,InvoiceCode,IsEInvoice,SenderReceiver,VATObjectAddress,VATNo
	
	
				)
				Values
				(
					@VoucherID, @BatchID, @TransactionID, 'AT9000', @DivisionID, @TranMonth, @TranYear, 
					@VoucherDate, @InvoiceDate, @VoucherTypeID, @VoucherNoT04, @Serial, @InvoiceNo, @TDescription, N'Dịch vụ cho thuê mặt bằng, phí quản lý', 
					@EmployeeID, getDate(), @EmployeeID, getDate(), @EmployeeID, 
					'T04', 'VND', @ObjectID, @ObjectID, '1311', '5113', 1, @DonGia,
					@PTQ, @PTQ, 'RGTGT1', 'T10', @SL,7,
					'PTQ', @UnitID, 'PTQ', @Ana02ID, 'RE', @PTQ, 1, 'VND', @DiscountRate, @InventoryName1, @Ana04ID, @Ana05ID, @IsMultiTax,
					Round((@PTQ)*10/100,0), Round((@PTQ)*10/100,0),
					'1/003','01GTKT',1,@SenderReceiver,@VATObjectAddress,@VATNo
	

	
				)
			End


		IF @@ERROR = 0
			Begin
				COMMIT TRAN
			End
		ELSE
			ROLLBACK TRAN

	Fetch Next From @OrderCur Into @ObjectID, @Serial, @InvoiceNo, @InvoiceDate, @TMB,@PQL,@TKO, @DIE, @NUO, @DVBS, @PRO, @PTQ, @QC, @SL, @SenderReceiver,@VATObjectAddress,@VATNo
	
End

SET NOCOUNT OFF



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
