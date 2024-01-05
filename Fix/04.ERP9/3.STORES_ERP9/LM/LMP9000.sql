IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP9000]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP9000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----- Created on 25/06/2017 by Bảo Anh
---- Kiểm tra khi Sửa/Xóa nghiệp vụ
---- LMP9000 'AS','f76b8cc0-398c-4b47-b8a9-ed160050ed71','LMT2001',0

CREATE PROCEDURE [dbo].[LMP9000]
				@DivisionID nvarchar(50),
				@VoucherID nvarchar(50),
				@TableName  nvarchar(50),
				@IsEdit tinyint   ----  =0  la Xoa,  = 1 la Sua

AS

Declare @Status as tinyint, --- 1: Khong cho xoa, sua:    2--- co canh bao nhung  cho xoa cho sua; --3: Cho sua mot phan thoi
	@Message as nvarchar(250)

Select @Status =0, 	@Message =''

If @TableName =  'LMT1010' --- kiểm tra sửa/xóa hợp đồng hạn mức
BEGIN
	If exists (Select 1 From LMT2001 WITH (NOLOCK) Where DivisionID = @DivisionID And LimitVoucherID = @VoucherID)
	Begin
			Set @Status =1
			Set @Message ='LMFML000015'
			Goto EndMess
	End 	
END

If @TableName = 'LMT2001' and @IsEdit = 0 --- kiểm tra xóa hợp đồng vay
BEGIN
	If exists (Select 1 From LMT2021 WITH (NOLOCK) Where DivisionID = @DivisionID And CreditVoucherID = @VoucherID)
	Or exists (Select 1 From LMT2011 WITH (NOLOCK) Where DivisionID = @DivisionID And CreditVoucherID = @VoucherID)
	Or exists (Select 1 From LMT2031 WITH (NOLOCK) Where DivisionID = @DivisionID And CreditVoucherID = @VoucherID)
	Or exists (Select 1 From LMT2041 WITH (NOLOCK) Where DivisionID = @DivisionID And CreditVoucherID = @VoucherID)
	Or Exists (Select 1 From AT9000 WITH (NOLOCK) Where DivisionID = @DivisionID And InheritVoucherID = @VoucherID)
	Begin
			Set @Status =1
			Set @Message ='LMFML000016'
			Goto EndMess
	End
END

If @TableName = 'LMT2001' and @IsEdit = 1 --- kiểm tra sửa hợp đồng vay
BEGIN
	If exists (Select 1 From LMT2021 WITH (NOLOCK) Where DivisionID = @DivisionID And CreditVoucherID = @VoucherID)
	Or exists (Select 1 From LMT2011 WITH (NOLOCK) Where DivisionID = @DivisionID And CreditVoucherID = @VoucherID)
	Or exists (Select 1 From LMT2031 WITH (NOLOCK) Where DivisionID = @DivisionID And CreditVoucherID = @VoucherID)
	Or exists (Select 1 From LMT2041 WITH (NOLOCK) Where DivisionID = @DivisionID And CreditVoucherID = @VoucherID)
	Or Exists (Select 1 From AT9000 WITH (NOLOCK) Where DivisionID = @DivisionID And InheritVoucherID = @VoucherID)
	Begin
			Set @Status = 3
			Set @Message ='LMFML000017'
			Goto EndMess
	End
END


If @TableName = 'LMT2051' --- kiểm tra sửa/ xóa hợp đồng bảo lãnh
BEGIN
	If exists (Select 1 From LMT2011 WITH (NOLOCK) Where DivisionID = @DivisionID And CreditVoucherID = @VoucherID)	
	Or Exists (Select 1 From AT9000 WITH (NOLOCK) Where DivisionID = @DivisionID And InheritVoucherID = @VoucherID)
	Begin
			Set @Status =1
			Set @Message ='LMFML000032'
			Goto EndMess
	End
END

If @TableName = 'LMT2021' --- kiểm tra sửa/xóa chứng từ giải ngân
BEGIN
	If exists (Select 1 From LMT2022 WITH (NOLOCK) Where DivisionID = @DivisionID And DisburseVoucherID = @VoucherID)
	Or exists (Select 1 From LMT2041 WITH (NOLOCK) Where DivisionID = @DivisionID And DisburseVoucherID = @VoucherID)
	Or exists (Select 1 From LMT2031 WITH (NOLOCK) Where DivisionID = @DivisionID And DisburseVoucherID = @VoucherID)
	Begin
			Set @Status =1
			Set @Message ='LMFML000018'
			Goto EndMess
	End
END

If @TableName = 'LMT2022' --- kiểm tra sửa/xóa lịch trả nợ
BEGIN
	If exists (Select 1 From LMT2031 WITH (NOLOCK) Where DivisionID = @DivisionID And PaymentPlanTransactionID = @VoucherID)
	Begin
			Set @Status =1
			Set @Message ='LMFML000019'
			Goto EndMess
	End
END

If @TableName = 'LMT2011' --- kiểm tra sửa/xóa phong tỏa, giải tỏa
BEGIN
	If Exists (Select 1 From AT9000 WITH (NOLOCK) Where DivisionID = @DivisionID And InheritVoucherID = @VoucherID)
	Begin
			Set @Status =1
			Set @Message ='LMFML000020'
			Goto EndMess
	End
END

If @TableName = 'LMT2031' --- kiểm tra sửa/xóa chứng từ thanh toán
BEGIN
	If Exists (Select 1 From AT9000 WITH (NOLOCK) Where DivisionID = @DivisionID And InheritVoucherID = @VoucherID)
	Begin
			Set @Status =1
			Set @Message ='LMFML000020'
			Goto EndMess
	End
END

If @TableName = 'LMT2041' --- kiểm tra sửa/xóa chứng từ điều chỉnh
BEGIN
	Declare @LastVoucherID VARCHAR(50)

	SELECT @LastVoucherID = @VoucherID
	FROM LMT2041 WITH (NOLOCK) Where DivisionID = @DivisionID
	AND DisburseVoucherID = (Select DisburseVoucherID From LMT2041 WITH (NOLOCK) Where DivisionID = @DivisionID And VoucherID = @VoucherID)
	ORDER BY AdjustFromDate

	IF @VoucherID <> @LastVoucherID
	Begin
			Set @Status =1
			Set @Message ='LMFML000021'
			Goto EndMess
	End
END

-------------------------------------------------------------------

EndMess:
	Select @Status as Status, @Message as Message


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

