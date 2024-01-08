IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP1001_DUCPHAT]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)     
DROP PROCEDURE [DBO].[MP1001_DUCPHAT]
GO  
SET QUOTED_IDENTIFIER ON  
GO  
SET ANSI_NULLS ON  
GO  
  
-- Create By: Dang Le Bao Quynh; Date 07/07/2010
-- Purpose: Tao phieu xuat kho tu dong cho Viet Linh
-- Last Edit: Thuy Tuyen..Date:03/2010,14/09/2010
-- Edit : Thuy Tuyen. date 16/09/2010, bo sung them loai chung tu cho XKTBTP
-- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
-- Modified by Văn Tài	   on 01/02/2021: Tách store cho khách hàng ĐỨC PHÁT.
-- Modified by Văn Tài	   on 02/02/2021: Bổ sung truyền @VoucherTypeID, xử lý Gen VoucherNo 2 lần để tăng số.
-- Modified by Văn Tài	   on 05/02/2021: Chuyển sang gọi store MP1002_DUCPHAT.
-- Modified by Văn Tài	   on 04/03/2021: Fix cách load dữ liệu. Loại bỏ check AT1302 cho ProductID.

CREATE PROCEDURE MP1001_DUCPHAT
	@DivisionID varchar(50), 
	@TranMonth int, 
	@TranYear int,
	@VoucherID as varchar(50), 
	@VoucherNo as varchar(50), 
	@VoucherDate as datetime, 
	@PeriodID varchar(50), 
	@ApportionID as varchar(50), 
	@Type as tinyint, --1: Addnew, 2: Edit,
	@VoucherTypeID AS VARCHAR(20) =''
	
AS

DECLARE
	@VoucherTypeIDT06 varchar(50), --But toan xuat kho NVL
	---@VoucherTypeIDT06BP varchar(20),-- --But toan xuat kho BP
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
	@QuantityDecimals  as tinyint,
	@exVoucherID as varchar(50),
	@VoucherID_0810 as varchar(50),
	@VoucherNoT06 as varchar(50),

	@WareHouseID as varchar(50),
	@ObjectID as varchar(50),
	@EmployeeID as varchar(50),
	@DebitAccountID as varchar(50),
	@curWH as cursor,

@VoucherTypeIDT06B varchar(50), --But toan xuat kho NVL
	---@VoucherTypeIDT06BP varchar(20),-- --But toan xuat kho BP
	@StringKey1T06B varchar(50), 
	@StringKey2T06B varchar(50),
	@StringKey3T06B varchar(50), 
	@OutputLenT06B int, 
	@OutputOrderT06B int,
	@SeparatedT06B int, 
	@SeparatorT06B char(1),
	@Enabled1B tinyint, 
	@Enabled2B tinyint,
	@Enabled3B tinyint,
	@S1B varchar(50), 
	@S2B varchar(50),
	@S3B varchar(50),
	@S1TypeB tinyint, 
	@S2TypeB tinyint,
	@S3TypeB tinyint

-- Print  @VoucherNo

Set @VoucherTypeIDT06  = case when @VoucherTypeID='' then 'TCSX' else @VoucherTypeID end
Set @VoucherTypeIDT06B  = 'TCSX'
Set @DebitAccountID = '621'

 
Select TOP 1 @QuantityDecimals = QuantityDecimals
FROM AT0001 WITH (NOLOCK)
WHERE DivisionID = @DivisionID

Set @QuantityDecimals =isnull( @QuantityDecimals,0)

-- khai bao lai chung tu xuat NVL
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



---Print @StringKey2T06

--Khai bao loai chung tu XBTP

Select @Enabled1B = Enabled1
		, @Enabled2B = Enabled2
		, @Enabled3B = Enabled3
		, @S1B = S1
		, @S2B = S2
		, @S3B = S3
		, @S1TypeB = S1Type
		, @S2TypeB = S2Type
		, @S3TypeB = S3Type
		, @OutputLenT06B = OutputLength
		, @OutputOrderT06B = OutputOrder
		, @SeparatedT06B = Separated
		, @SeparatorT06B = Separator
From AT1007 WITH (NOLOCK) Where DivisionID = @DivisionID And VoucherTypeID = @VoucherTypeIDT06B
If @Enabled1B = 1
	Set @StringKey1T06B = 
	Case @S1TypeB 
	When 1 Then Case When @TranMonth < 10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
	When 2 Then ltrim(@TranYear)
	When 3 Then @VoucherTypeIDT06B
	When 4 Then @DivisionID
	When 5 Then @S1B
	When 6 Then right(ltrim(@TranYear),2)
	Else '' End
Else
	Set @StringKey1T06B = ''

If @Enabled2B = 1
	Set @StringKey2T06B = 
	Case @S2TypeB 
	When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
	When 2 Then ltrim(@TranYear)
	When 3 Then @VoucherTypeIDT06B
	When 4 Then @DivisionID
	When 5 Then @S1B
	When 6 Then right(ltrim(@TranYear),2)
	Else '' End
Else
	Set @StringKey2T06B = ''

If @Enabled3B = 1
	Set @StringKey3T06B = 
	Case @S3TypeB 
	When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
	When 2 Then ltrim(@TranYear)
	When 3 Then @VoucherTypeIDT06B
	When 4 Then @DivisionID
	When 5 Then @S1B
	When 6 Then right(ltrim(@TranYear),2)
	Else '' End
Else
	Set @StringKey3T06B = ''

IF isnull(@ApportionID,'')<>'' And isnull(@PeriodID,'')<>'' --- And @Type = 1  - xu ly sua va xoa giong nhau  deu sinh phieu xuat moi, 
Begin

	SET @VoucherID_0810 = 
	(
		SELECT TOP 1 MT10.VoucherID
		From MT1001 MT10 WITH (NOLOCK)
		INNER JOIN MT0810 MT08 WITH (NOLOCK) On MT10.DivisionID = MT08.DivisionID And MT10.VoucherID = MT08.VoucherID
		WHERE MT08.BatchID = @VoucherID
	)

	SET @VoucherID = @VoucherID_0810;

	---Xuat NVL
	Set @curWH = cursor static for
	
	SELECT DISTINCT MT08.ObjectID
					, MT08.EmployeeID
					, MT08.ExWarehouseID 
	From MT1001 MT10 WITH (NOLOCK)
	INNER JOIN MT0810 MT08 WITH (NOLOCK) On MT10.DivisionID = MT08.DivisionID And MT10.VoucherID = MT08.VoucherID
	--INNER JOIN AT1302 AT13 WITH (NOLOCK) On MT10.ProductID = AT13.InventoryID AND AT13.DivisionID IN (MT10.DivisionID,'@@@')
	WHERE	MT10.VoucherID = @VoucherID_0810 
			AND MT10.DivisionID = @DivisionID
	
	print ('MP1001 CHECK: ' + @VoucherID)
	

	Open @curWH
	
	Fetch Next From @curWH Into @ObjectID, @EmployeeID, @WareHouseID
	While @@Fetch_Status = 0
	Begin

	print ('MP1001 EXISTS: ' + @VoucherID)

	  IF  Exists (SELECT  TOP  1 1 From MT1603 MT16 WITH (NOLOCK)
	   			  Inner Join (	Select MT1001.DivisionID, MT1001.VoucherID, MT1001.ProductID, sum(isnull(Quantity,0)) as Quantity
								From MT1001 WITH (NOLOCK)
								Where MT1001.DivisionID = @DivisionID
								Group By MT1001.DivisionID, MT1001.VoucherID, MT1001.ProductID
							) MT10 On MT16.ProductID = MT10.ProductID and MT16.DivisionID = @DivisionID
				     --Inner Join AT1302 AT13 On MT10.ProductID = AT13.InventoryID AND AT13.DivisionID IN (MT10.DivisionID,'@@@')
				     Inner Join AT1302 AT14 On MT16.MaterialID = AT14.InventoryID AND AT14.DivisionID IN (MT16.DivisionID,'@@@')
				    Where MT16.ExpenseID = 'COST001' And MT16.ApportionID = @ApportionID And MT10.VoucherID = @VoucherID And AT14.InventoryTypeID = 'VL')
	BEGIN
			
			EXEC AP0000 @DivisionID, @VoucherNoT06 Output, 'AT9000', @StringKey1T06, @StringKey2T06, @StringKey3T06, @OutputLenT06, @OutputOrderT06, @SeparatedT06, @SeparatorT06
			EXEC AP0000 @DivisionID, @VoucherNoT06 Output, 'AT9000', @StringKey1T06, @StringKey2T06, @StringKey3T06, @OutputLenT06, @OutputOrderT06, @SeparatedT06, @SeparatorT06
			EXEC AP0000 @DivisionID, @exVoucherID Output, 'AT2006', @TranYear, '', '', 16, 3, 0, '-'

			print ('MP1001 EXISTS: MT1603: ' + @VoucherNoT06 + ' VoucherTypeID: ')
	
			--Create Master
			Insert Into AT2006
				(VoucherID,TableID,TranMonth,TranYear,
				DivisionID,VoucherTypeID,VoucherDate,VoucherNo,ObjectID,OrderID,
				WareHouseID,KindVoucherID,EmployeeID,[Description],
				CreateDate,CreateUserID,LastModifyUserID,LastModifyDate, RefNo01,InventoryTypeID)
			Values
				(@exVoucherID,'AT2006',@TranMonth,@TranYear,
				@DivisionID,@VoucherTypeIDT06,@VoucherDate,@VoucherNoT06,@ObjectID,@VoucherID,
				@WareHouseID,2,@EmployeeID,N'Xuất NVL từ phiếu KQSX ' + @VoucherNo,
				getDate(),@EmployeeID,@EmployeeID,getDate(), @VoucherNo,'VL')
		
			---Create Detail
			EXEC MP1002_DUCPHAT @DivisionID, @TranMonth, @TranYear,
					@VoucherID, @exVoucherID , @WareHouseID, 'VL', 
					@PeriodID, @ApportionID, @DebitAccountID, @QuantityDecimals
	END
		
		Fetch Next From @curWH Into @ObjectID, @EmployeeID, @WareHouseID
	End
	
	Close @curWH
	
End
  
GO  
SET QUOTED_IDENTIFIER OFF  
GO  
SET ANSI_NULLS ON  
GO
