IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP9010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP9010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO















----- Created by Nguyen Quoc Huy
---- Date 23/02/2009.
----  Purpose: Tao Debit Note (Song Binh).
--- Edit: Thuy Tuyen, date: 16/03/2006, 20/04/2009 - XU LY SO DU, 07/05/2007,11/05,2009, 
---03/06/2006: Them nhom thue 10%, 12/06/2009  Sua lai cach tinh thue VAT,
--09/07/2009: Thuy Tuyen sua lai cach tinh thue 5%
---Last Edit : Thuy Tuyen, sua lai cah sinh VoucherNO = 'OT2001'
---Last Edit : Trung Dung, 12/08/2011 - Lay them @ConvertDecimal theo Loai tien de tinh toan tien VAT.
---Last Edit: Kim Thư on 13/05/2019: Bổ sung insert APK và DivisionID cho bản 837STD
---Last Edit: Kim Thư on 26/06/2019: Thay đổi kích thước biến
---Last Edit: Huỳnh Thử on 17/10/2019: tắt sinh số hóa đơn tự động
---Last Edit: Văn Minh on 28/10/2019 : kiểm tra null inv_no
---Last Edit: Văn Minh on 21/01/2020 : Thêm loại InventoryID theo VourcherTypeID
---Last Edit: Mỹ Tuyền on 26/12/2019 : Điều chỉnh set giá trị.
---Last Edit: Trung Đông on 29/04/2020 : Bổ sung loại mặt hàng load InventoryName
---Last Edit: Nhựt Trường on 12/03/2021 : Bổ sung set @TypeInventoryID = '03DV005' khi @VoucherTypeID IN ('3FM','3PK','3P1', '3P2').
---Last Edit: Nhựt Trường on 23/05/2022 : Điều chỉnh T10 thành T08 (theo thông tư 78).
---Last Edit: Xuân Nguyên on 19/12/2022 : Điều chỉnh TNT thành KKKNT và KHAC
---Last Edit: Xuân Nguyên on 17/01/2023 : Điều chỉnh T08 thành T10 do đã hết thời gian áp dụng thuế 8%
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---Last Edit: Xuân Nguyên on 17/07/2023 : Điều chỉnh lấy lại thuế T08
---Last Edit: Thành Sang on 17/07/2023 : Lấy thêm Inventory cho các mã khác
---Last Edit: Thành Sang on 20/09/2023 : Gán tiền thuế = 0 với loại debitnote = 3I1 và 3I2
---Last Edit: Thành Sang on 25/09/2023 : Gán VatGrouID = KKKNT với loại debitnote = 3I1 và 3I2

CREATE PROCEDURE OP9010 	@DivisionID as varchar(50), @TranMonth as int, @TranYear as int,
							@TemplateVoucherID as varchar(50), @VoucherTypeID as varchar(50),@UserID as varchar(50), @OrderDate as datetime,
							@ObjectID00 as varchar(50), @in_out_bound as varchar(50), @settlemt_option as varchar(50),@OrderID AS VARCHAR(50)=''

 AS

Declare @CurrencyID varchar(50),
		@ExchangRate as money,
		@CurrencyID1 varchar(50),
		@OrigianalAmount as money,
		@ConvertedAmount as money,
		@VoucherID as varchar(50),
		@TemplateVoucherID1 as varchar(50),
		@TransactionID varchar(50),
		@ObjectID as varchar(50),
		@ObjectName as varchar(250),
		@ObjectName1 as varchar(250),
		@VDescription 	as varchar(250),
		@BDescription 	as varchar(250),
		@BDescription1   as varchar(250),
		@TDescription 	as varchar(250),
		@Quantity as int,
		@VATGroupID as varchar(250),
		@VATTypeID as varchar(50),
		@VATNo as varchar(50),
		@VATPercent as money,
		@Serial as varchar(50),
		@VoucherNo as varchar(50),
		@InvoiceNo varchar(50),
		@InvoiceDate Datetime,
		@VoucherDate as  Datetime,
		@Tran_cur as cursor,
		@RefNo01 as varchar(50),
		@RefNo02 as varchar(50),
		@Ana01ID as varchar(50),
		@Ana02ID as varchar(50),
		@Ana03ID as varchar(50),
		@Ana04ID as varchar(50),
		@Ana05ID as varchar(50),		
		@Auto as tinyint,
		@S1 varchar(50),
		@S2  varchar(50),
		@S3 varchar(50),
		@S1Type as int,
		@S2Type as int,
		@S3Type as int,
		@OutputOrder as int,
		@OutputLen as int,
		@Separated as tinyint,
		@separator as varchar(1),
		@CYear as varchar(50),
		@PayableAccountID as varchar(50),

		@VATAmount as money,
		@Orders as int,
		@TypeInventoryID AS NVARCHAR(MAX),

-----------------------------Cac bien lan tron so le----------------------
		@QuantityDecimals as int,
		@UnitCostDecimals as int,
		@ConvertedDecimals as int,
		@ConvertDecimal as int,
-----------------------------OT2001----------------------------------------------
		@curr_code  as varchar(50),  @exchange_rate as money, @bill_to_flag as varchar(50),  ---(Ana02ID)
		@RePaymentTermID as varchar(50), @Duedays as int ,

-----------------------------OT2002----------------------------------------------
		@awb_nbr  as varchar(100),  --(InventoryCommonName)
		@Dimension as varchar(100),  --(LinkNo)

		@Col01 as money,
		@Col02 as money,
		@Col03 as money,

		@no_pieces as money,  --(Quantity01)
		@Aut as varchar(50), --(UnitID)
		@ActualWgtV as money, --(Quantity02)
		@CUt as varchar(50), --(UnitID)
		@ChrgbleWgtV as money, --(OrderQuantiry)
		@inv_amt as money, --(Tong so tien tren hoa don)
		@awb_amt as money, --(Thanh tien cua tung lo hang [@awb_nbr] da bao gom thue VAT 5%)
		@ship_date as datetime,  --(Date02)
		@orig_locn as varchar(50), --(Ana01ID)
		@dest_locn as varchar(50), --(Ana02ID)
		@service_type as varchar(50), --(Ana03ID)

		@shpr_cust_no as varchar(250),  --(ObjectID01)
		@shpr_name as varchar(250), --(RefName01)
		@shpr_company as varchar(250), --(ObjectName01)
		@ObjectAddress01 as varchar(250), --(shpr_addr1 + shpr_addr2)
		@shpr_city as varchar(250), --(ObjectCity01)
		@shpr_state as varchar(250), --(ObjectState01)
		@shpr_zip as varchar(250), --(ObjectZip01)
		@shpr_cntry as varchar(250), --(ObjectCntry01)

		@cnsgn_cust_no as varchar(250), --(ObjectID02)
		@cnsgn_name as varchar(250), --(RefName02)
		@cnsgn_company as varchar(250), --(ObjectName02)
		@ObjectAddress02 as varchar(250), --(cnsgn_addr1 + cnsgn_addr2)
		@cnsgn_city as varchar(250), --(ObjectCity02)
		@cnsgn_state as varchar(250), --(ObjectState02)
		@cnsgn_zip as varchar(250), --(ObjectZip02)
		@cnsgn_cntry as varchar(250), --(ObjectCntry02)

		@billto_freight as money,
		@Discount_amt as money,
		@Freight_After_Discount as money,
		@Total_Non_Fuel_Surchrg as money,
		@TemplateTransactionID as varchar(50),
		@SvAbbrew as varchar(50),
		@FuelSur as money,
		@SurDesc1 as varchar(50),
		@SurAmount1 as money,

		@SurDesc2  as varchar(50),
		@SurAmount2 as  money,
		@SurDesc3 as varchar(50),
		@SurAmount3 as money,
		@SurDesc4 as varchar(50),
		@SurAmount4 as money,
		@SurDesc5 as varchar(50),
		@SurAmount5 as money,
		@SurDesc6 as varchar(50),
		@SurAmount6 as money,
		@SurDesc7 as varchar(50),
		@SurAmount7 as money,
		@SurDesc8 as varchar(250),
		@SurAmount8 as money,
		@SD as money , -- So du khi lam  tron
	

------------------------ Tham chieu den FedEx---------------------------------------------------------	
		@inv_no as varchar(50), --(SourceNo)
		@inv_date  as  Datetime, --(Date01)
		@rebill_reason as varchar(100), --(Notes01)
		@entry_batch_no as varchar(100), --(Notes02)
		@Del_DateTime as varchar(100), --(Notes03)
		@Pod_Signature as varchar(100), --(Notes04)


---------------------Dung Dimension de tinh ra Quantity03----------------------
		@Quantity03 as money

		
		----@icpc_child_acct_nbr as varchar(50),   --(@ObjectID00, ObjectID and VATObjectID)
		----@billto_freight as money, @discount_amt as money, @freight_after_discount as money, @Total_Non_Fuel_Surchrg as money, ---(Tam thoi chua dung den)

		
Select @QuantityDecimals = ISNULL(QuantityDecimal,0), @UnitCostDecimals = ISNULL(UnitPriceDecimal,0) , @ConvertedDecimals = ISNULL(ConvertDecimal,0) From OT0000
SET  @CurrencyID1 = (SELECT TOP 1 ISNULL(curr_code,'VND') FROM ET2002 WHERE TemplateVoucherID =@TemplateVoucherID)
SELECT @ConvertDecimal=ExchangeRateDecimal FROM AT1004 WHERE CurrencyID=@CurrencyID1---'USD'

Set @CYear =ltrim(rtrim(str(@TranYear)))
Select top 1 @CurrencyID =BaseCurrencyID From AT0001
Select @Auto=[Auto],@S1 =S1,@S2=S2,@S3 =S3, @S1Type= S1Type, @S2Type= S2Type, @S3Type= S3Type, @OutputLen= OutputLength, @OutputOrder=OutputOrder, @separator=separator, @Separated = Separated From AT1007 Where VoucherTypeID =@VouchertypeID

PRINT @CurrencyID1 + ':' + LTRIM(RTRIM(STR(@ConvertDecimal)))

BEGIN


		---- Sinh so phieu moi --------------
		--If @Auto <>0
		--	Exec AP9100  @VoucherNo OUTPUT, 'OT2001',@S1,@S2,@S3, @S1Type, @S2Type, @S3Type, @OutputLen, @OutputOrder, @Separated, @separator, @TranMonth, @TranYear,@DivisionID
		--Else
			Set @VoucherNo =@OrderID
		---PRINT @VoucherNo
		--------- Sinh ma ngam -----------------------
		--Exec AP0000  @VoucherID OUTPUT, 'AT9000','AV',@CYear,'',16, 3, ''
		--Print '@VoucherNo:' + @VoucherNo
		
		-------- Kiem tra xem neu chua ton tai doi tuong thi them vao---------------------
		if not Exists (Select ObjectID From AT1202   Where ObjectID = isnull(@ObjectID00,''))
		Begin
			Insert AT1202 (DivisionID, ObjectID, ObjectName,IsCustomer,Disabled,CreateDate,CreateUserID,LastModifyDate,LastModifyUserID)
			Values (@DivisionID, @ObjectID00, @ObjectID00,1,0,getdate(),@UserID,getdate(),@UserID)
		End
		--------------------------End--------------------------------------------------------------------------			
		Select  @CurrencyID = curr_code, @ExchangRate= exchange_rate, @bill_to_flag = bill_to_flag
				From ET2002 
				Where 	TemplateVoucherID =@TemplateVoucherID and icpc_child_acct_nbr=@ObjectID00 
					and in_out_bound = @in_out_bound and settlemt_option = @settlemt_option 
		Select @RePaymentTermID =  RePaymentTermID, @Duedays =  isnull(Duedays,0)   
				From AT1202  left Join At1208 on AT1208.PaymentTermID = AT1202.RePaymentTermID
				Where AT1202.DivisionID IN (@DivisionID, '@@@') AND AT1202.ObjectID = @ObjectID00
		Insert OT2001 (APK, DivisionID, SOrderID, VoucherTypeID, VoucherNo, OrderDate, ContractNo, ContractDate, ClassifyID, 
							OrderType, ObjectID ,VATObjectID, DeliveryAddress, Notes, Disabled, OrderStatus, QuotationID, 
							CreateDate, CreateUserID, LastModifyUserID, LastModifyDate, 
							Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, CurrencyID, 
							ExchangeRate, InventoryTypeID, TranMonth, TranYear, EmployeeID, 
							Transport, PaymentID, ObjectName, VatNo, Address, IsPeriod, IsPlan, DepartmentID,
							 DueDate ,PaymentTermID
							--SalesManID, ShipDate, InheritSOrderID, DueDate, PaymentTermID, FileType, 
							--Contact, VATObjectName, IsInherit
							 )
					Values (NEWID(), @DivisionID, @VoucherNo, @VoucherTypeID, @VoucherNo, @OrderDate, Null, @OrderDate, @settlemt_option,
						0, @ObjectID00, @ObjectID00,Null, Null, 0, 1, null,
						 getdate(), @UserID,@UserID, getdate(),
						@in_out_bound,@bill_to_flag,null,null,null, @CurrencyID, 
						@ExchangRate, null, @TranMonth, @TranYear, @UserID,
						null, Null, null, null, null,0,0,null, @OrderDate +@Duedays, @RePaymentTermID
						)

		Set @Orders = 0
		
		SET @Tran_cur  = Cursor Scroll KeySet FOR 	

				Select  awb_nbr, Dimension, Col01,Col02,Col03,no_pieces, 
					Aut ,ActualWgtV ,CUt ,ChrgbleWgtV ,
					inv_amt ,ROUND(awb_amt,@ConvertDecimal) AS awb_amt ,isnull(ship_date,'01/01/9999') as ship_date  ,orig_locn ,dest_locn ,service_type ,
					shpr_cust_no ,shpr_name ,shpr_company ,shpr_addr1 + ' ' +shpr_addr2 ,shpr_city ,shpr_state ,shpr_zip ,shpr_cntry ,
					cnsgn_cust_no ,cnsgn_name ,cnsgn_company ,cnsgn_addr1 + ' ' +cnsgn_addr2 ,cnsgn_city ,cnsgn_state ,cnsgn_zip ,cnsgn_cntry ,
					inv_no ,inv_date  ,rebill_reason ,entry_batch_no ,Del_DateTime ,Pod_Signature ,
					Billto_freight,Discount_amt ,Freight_After_Discount ,Total_Non_Fuel_Surchrg,TemplateTransactionID,
					 SvcAbbrev,  FuelSur,  SurDesc1,  SurAmount1,  SurDesc2,  SurAmount2, 
 					SurDesc3,  SurAmount3,  SurDesc4,  SurAmount4,  SurDesc5,  SurAmount5, 
					 SurDesc6,  SurAmount6,  SurDesc7,  SurAmount7,  SurDesc8,  SurAmount8
			
				From ET2002 
				Where 	DivisionID = @DivisionID and TemplateVoucherID =@TemplateVoucherID and icpc_child_acct_nbr=@ObjectID00 and in_out_bound = @in_out_bound and settlemt_option = @settlemt_option
				and TemplateTransactionID not in ( select ISNULL(QuotationID,'') From OT2002)
				Order by TemplateBatchID,icpc_child_acct_nbr,in_out_bound,settlemt_option,ship_date

				--PRINT '@ObjectID00' + @ObjectID00
				--PRINT '@TemplateVoucherID' + @TemplateVoucherID

				Open @Tran_cur
				FETCH NEXT FROM @Tran_cur INTO @awb_nbr, @Dimension, @Col01, @Col02, @Col03, @no_pieces, 
					@Aut ,@ActualWgtV ,@CUt ,@ChrgbleWgtV ,
					@inv_amt ,@awb_amt ,	@ship_date ,@orig_locn ,@dest_locn ,@service_type ,
					@shpr_cust_no ,@shpr_name ,	@shpr_company ,@ObjectAddress01 ,	@shpr_city ,@shpr_state ,@shpr_zip ,@shpr_cntry ,
					@cnsgn_cust_no ,@cnsgn_name ,@cnsgn_company ,@ObjectAddress02 ,@cnsgn_city ,@cnsgn_state ,@cnsgn_zip ,@cnsgn_cntry ,
					@inv_no ,@inv_date  ,@rebill_reason ,@entry_batch_no ,@Del_DateTime ,@Pod_Signature ,
					@billto_freight,@Discount_amt ,@Freight_After_Discount ,@Total_Non_Fuel_Surchrg,@TemplateTransactionID,
					@SvAbbrew, @FuelSur, @SurDesc1, @SurAmount1, @SurDesc2, @SurAmount2, 
					@SurDesc3, @SurAmount3, @SurDesc4, @SurAmount4, @SurDesc5, @SurAmount5, 
					@SurDesc6, @SurAmount6, @SurDesc7, @SurAmount7, @SurDesc8, @SurAmount8
					
				WHILE @@Fetch_Status = 0 
				Begin

					Set @Orders = @Orders + 1
					Exec AP0000 @DivisionID, @TransactionID OUTPUT, 'OT2002','OT',@CYear,'',17, 3, ''
					
					
					Set @Dimension = Ltrim(Rtrim(@Dimension))
					Set @Quantity03 =0
					
					If   @ship_date  < ' 01/18/2010'  --- Thay doi theo yeu cau Chi Phu, dat 03/02/2010
						Begin
							If Right(@Dimension,2) ='cm' 
								Set @Quantity03 = Round((@Col01 * @Col02 * @Col03)/6000,@QuantityDecimals)	--Cong thuc qui doi tu cm sang KG
							else If Right(@Dimension,4) ='inch' 
								Set @Quantity03 = Round((@Col01 * @Col02 * @Col03)/366,@QuantityDecimals)	
						End	--Cong thuc qui doi tu inch sang KG
					else      
						Begin
							
							If Right(@Dimension,2) ='cm' 
								Set @Quantity03 = Round((@Col01 * @Col02 * @Col03)/5000,@QuantityDecimals)	--Cong thuc qui doi tu cm sang KG
							else If Right(@Dimension,4) ='inch' 
								Set @Quantity03 = Round((@Col01 * @Col02 * @Col03)/305,@QuantityDecimals)	
						end	
					------------------ CACH TINH VAT
					---1. AT1202.O01ID ='EPZ'   then VAT = 0% ( Neu doi tuong thuoc cum khu cong nghiep thi VAT =0% )
					---2.AT1202.O01ID <>'EPZ' then
						---2.1IF @settlemt_option <> 'Freight'  and    @settlemt_option <> 'Duty'  thi VAT 10% 
						--else
							   -- 3.1. @settlemt_option ='Freight' va @in_out_bound ='1' (outbound) thi VAT=5%
								--3.3: Cac truong hop con lai: VAT = null ( Freight -InBound, Freigh- 3rd party , Duty :Khong chieu Thue)  
						
					IF  (select O01ID from AT1202 Where DivisionID IN (@DivisionID, '@@@') AND ObjectID =@ObjectID00 ) ='EPZ'
					BEGIN
						Set @VATGroupID = 'T00'
						Set @VATPercent = 0
						Set @VATAmount = 0
					END	
					ELSE
					BEGIN
						IF  @settlemt_option  not like   '%Freight%'    and  @settlemt_option  not like  '%Duty%'

							Begin
								Set @VATGroupID = 'T08'
								Set @VATPercent = 8
								Set @VATAmount =ROUND(@awb_amt -  ROUND(@awb_amt / (1+0.08) , @ConvertDecimal),@ConvertDecimal)
							End
			
						ELSE
						BEGIN
		
								if @settlemt_option  like  '%Freight%'  and  @in_out_bound ='1'
								Begin
									Set @VATGroupID = 'KHAC'
									Set @VATPercent = 0
									Set @VATAmount = ROUND(@awb_amt*5/100,@ConvertDecimal) 
									---Set @VATAmount =@awb_amt -  ROUND(@awb_amt / (1+0.05) , 2)
								End
								else 
								Begin
									Set @VATGroupID = 'KKKNT'
									Set @VATPercent = null
									Set @VATAmount = null
								End
						END
					
					END	
					--- Xu ly so du do lam tron 2 so le , neu  OT2002.OriginalAmount + OT2002.VATOriginalAmount  <> @awb_amt thi so du do cong vo @VATAmount
					 set  @SD =  ROUND(@awb_amt -  (ROUND (@awb_amt - isnull(@VATAmount,0),@ConvertDecimal)  + @VATAmount ),@ConvertDecimal)

					If @SD <> 0
					 Begin
					 set  @VATAmount =  ROUND(@VATAmount + @SD,@ConvertDecimal)
					end

					-- Check inv_no before Insert
					IF(ISNULL(@inv_no,'')='')
					begin
						set @inv_no = 0
					end

					--Customize - Hiển thị InventoryID theo VoucherTypeID
					IF (@VoucherTypeID = '3FM' OR @VoucherTypeID = '3PK' OR @VoucherTypeID = '3P1' OR @VoucherTypeID = '3P2' OR @VoucherTypeID = '3S1' OR @VoucherTypeID = '3S2')
					BEGIN
						SET @TypeInventoryID = '03DV005'
					END
					ELSE IF (@VoucherTypeID = '3H1' OR @VoucherTypeID = '3H2' OR @VoucherTypeID = '3N1' or @VoucherTypeID = '3N2' OR @VoucherTypeID = '3DT' )
					BEGIN
						SET @TypeInventoryID = '03DV011'
					END
					ELSE IF (@VoucherTypeID = '2FM' OR @VoucherTypeID = '2P1' OR @VoucherTypeID = '2P2' or @VoucherTypeID = '2S1' or @VoucherTypeID = '2S2' )
					BEGIN
						SET @TypeInventoryID = '02DV005'
					END
					ELSE IF (@VoucherTypeID = '2H1' OR @VoucherTypeID = '2H2' OR @VoucherTypeID = '2N1' or @VoucherTypeID = '2N2' )
					BEGIN
						SET @TypeInventoryID = '02DV011'
					END
					ELSE
					BEGIN
						SET @TypeInventoryID = 'FedEx'
					END

					--Customize - Hiển thị OrigianalAmount, ConvertedAmount theo VoucherTypeID
					IF (@VoucherTypeID = '3I1' OR @VoucherTypeID = '3I2')
						BEGIN
							SET @VATGroupID = 'KKKNT'
							SET @VATPercent = null
							SET @VATAmount = null
						END
				
					
-------------------------

					Insert OT2002 (APK, DivisionID, TransactionID, SOrderID, Orders, InventoryID,InventoryCommonName, LinkNo, Quantity01,Quantity02,Quantity03,
							 MethodID, UnitID, OrderQuantity, 
							SalePrice, ConvertedAmount, OriginalAmount, 
							VATOriginalAmount, VATConvertedAmount, VATPercent, VATGroupID, 
							DiscountConvertedAmount, DiscountPercent, WareHouseID, DiscountOriginalAmount, Description, 
							RefInfor, CommissionPercent, CommissionCAmount, CommissionOAmount, 
							Date02, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, 
							Finish, AdjustQuantity, FileID, RefOrderID, 
							SourceNo, Cal01, Cal02, Cal03, Cal04,Cal05,Date01, Notes01, Notes02, Notes03, Notes04,
							ObjectID01, RefName01, ObjectName01, ObjectAddress01, ObjectCity01, ObjectState01, ObjectZip01, ObjectCntry01,
							ObjectID02, RefName02, ObjectName02, ObjectAddress02, ObjectCity02, ObjectState02, ObjectZip02, ObjectCntry02,Aut,Cut,
							QuotationID , OrigLocn ,destLocn ,SvType,
							SvAbbrew,Quantity12,SurDesc1,Quantity04,SurDesc2,Quantity05, 
							SurDesc3,Quantity06,SurDesc4,Quantity07, SurDesc5, Quantity08, 
							SurDesc6, Quantity09,SurDesc7, Quantity10,SurDesc8,Quantity11 )
					Values (NEWID(), @DivisionID, @TransactionID, @VoucherNo, @Orders, @TypeInventoryID, @awb_nbr, @Dimension,@no_pieces,@ActualWgtV, @Quantity03,
						Null, 'KG', @ChrgbleWgtV,---@ChrgbleWgtV=@OrderQuantity, 
						Null, ROUND(ROUND (@awb_amt - isnull(@VATAmount,0),@ConvertDecimal) * @ExchangRate,@ConvertedDecimals),
						 ROUND (@awb_amt - isnull(@VATAmount,0),@ConvertDecimal),
						ROUND(@VATAmount,@ConvertDecimal),ROUND(ROUND(@VATAmount,@ConvertDecimal) * @ExchangRate,@ConvertedDecimals) ,@VATPercent,@VATGroupID,
						Null, Null, Null, Null, Null,
						Null, Null, Null, Null,
						@ship_date, null,null,null, Null, Null,
						Null, Null, Null, Null,
						@inv_no,@inv_amt,@billto_freight,@Discount_amt ,@Freight_After_Discount ,@Total_Non_Fuel_Surchrg, @inv_date, @rebill_reason, @entry_batch_no, @Del_DateTime, @Pod_Signature,
						@shpr_cust_no, @shpr_name, @shpr_company, @ObjectAddress01, @shpr_city, @shpr_state, @shpr_zip, @shpr_cntry,
						@cnsgn_cust_no, @cnsgn_name, @cnsgn_company, @ObjectAddress02, @cnsgn_city, @cnsgn_state, @cnsgn_zip, @cnsgn_cntry,@Aut,@Cut,
						@TemplateTransactionID,@orig_locn ,@dest_locn ,@service_type,
						@SvAbbrew, @FuelSur, @SurDesc1, @SurAmount1, @SurDesc2, @SurAmount2, 
						@SurDesc3, @SurAmount3, @SurDesc4, @SurAmount4, @SurDesc5, @SurAmount5, 
						@SurDesc6, @SurAmount6, @SurDesc7, @SurAmount7, @SurDesc8, @SurAmount8
						)
						
					FETCH NEXT FROM @Tran_cur INTO  
						@awb_nbr, @Dimension, @Col01, @Col02, @Col03, @no_pieces, 
						@Aut ,@ActualWgtV ,@CUt ,@ChrgbleWgtV ,
						@inv_amt ,@awb_amt ,	@ship_date ,@orig_locn ,@dest_locn ,@service_type ,
						@shpr_cust_no ,@shpr_name ,	@shpr_company ,@ObjectAddress01 ,	@shpr_city ,@shpr_state ,@shpr_zip ,@shpr_cntry ,
						@cnsgn_cust_no ,@cnsgn_name ,@cnsgn_company ,@ObjectAddress02 ,@cnsgn_city ,@cnsgn_state ,@cnsgn_zip ,@cnsgn_cntry ,
						@inv_no ,@inv_date  ,@rebill_reason ,@entry_batch_no ,@Del_DateTime ,@Pod_Signature ,@billto_freight,@Discount_amt ,@Freight_After_Discount ,@Total_Non_Fuel_Surchrg,@TemplateTransactionID,
						@SvAbbrew, @FuelSur, @SurDesc1, @SurAmount1, @SurDesc2, @SurAmount2, 
						@SurDesc3, @SurAmount3, @SurDesc4, @SurAmount4, @SurDesc5, @SurAmount5, 
						@SurDesc6, @SurAmount6, @SurDesc7, @SurAmount7, @SurDesc8, @SurAmount8
				End
				
				
				Close @Tran_cur
				DEALLOCATE @Tran_cur
END















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
