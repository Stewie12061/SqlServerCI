IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP90000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP90000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





----- Created by: Phan thanh hoàng Vũ, date: 05/01/2016
----- Modify by Thị Phượng Date 22/03/2016 Bổ sung kiểm tra xóa phiếu báo giá
----- Modify by Thị Phượng Date 19/05/2017 Thay đổi mã message cảnh báo khi xóa sửa báo giá
----- Modify by Thị Phượng Date 31/05/2017 Thay đổi mã message cảnh báo khi sửa đơn hàng
----- Modify by Tra Giang Date 06/12/2018: Bổ sung  kiểm tra đã kế thừa phiếu trên 9.0 thì không cho sửa xóa
----- Modify by Đình Hòa Date 02/16/2021: Bổ sung  kiểm tra đã kế thừa phiếu báo giá thì không cho sửa xóa(MECI)
----- Modify by Đình Hòa Date 30/16/2021: Bổ sung  kiểm tra duyệt phiếu bảng tính giá thì không cho sửa xóa(MECI)
----- Modify by Văn Tài	 Date 23/03/2022: Loại bỏ kiểm tra khóa xổ dành cho nghiệp vụ SO, PO tại ERP 9.9
----- Modify by Văn Tài	 Date 13/06/2023: Xử lý show message.
---- Purpose: Kiem tra rang buoc du lieu cho phep Sua, Xoa
--------------@Status loại Message nếu 0: Message Info; 1: Message Error; 2: Message Warning; 3: Message Confirm (Yes/no)
--------------@IsEdit trạng thái màn hình nếu 0: Xoa,1: Sua

--Declare @Status tinyint,
--		@Message nvarchar(250)
--EXEC SOP90000 'AS', null, null, N'SO/12/2015/00029', 'OT2001', 0, @Status output, @Message output
--Select @Status, @Message

CREATE PROCEDURE SOP90000 
	(	@DivisionID Nvarchar(50),
		@TranMonth int = null,
		@TranYear int = null,
		@OrderID varchar(Max) = null,
		@TableName  nvarchar(50),
		@IsEdit tinyint, --0: Xoa,1: Sua
		@Status  TINYINT OUTPUT, --0: Message Info; 1: Message Error; 2: Message Warning; 3: Message Confirm (Yes/no)
		@Message nvarchar(250) OUTPUT
	)
AS
	Set @Status =0
	Set	@Message =null

	DECLARE @CustomerName INT
	CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
	INSERT #CustomerName EXEC AP4444
	SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName) 

If @TableName =  'OT2001'  and @IsEdit = 0

BEGIN
	If not exists (Select top 1 1 From OT2001 WITH (NOLOCK) Where SOrderID = @OrderID and DivisionID = @DivisionID ) --Check khác DivisionID
	Begin
			Set @Status =2
			Set @Message ='00ML000050'
			Goto EndMess
	End 
	DECLARE @DelAPK Varchar(50)= (Select APK from OT2001 WITH (NOLOCK) where OT2001.SOrderID=@OrderID)
		If  exists (Select top 1 1 From POT2018 Where InheritVoucherID = @DelAPK ) --Check đã ke thua

	Begin
			Set @Status =2
			Set @Message ='00ML000052'
			Goto EndMess
	End
	--If not exists (Select top 1 1 From OT2001 WITH (NOLOCK)  inner join OT9999 WITH (NOLOCK) on OT2001.DivisionID = OT9999.DivisionID 
	--				and OT2001.TranMonth = OT9999.TranMonth and OT2001.TranYear = OT9999.TranYear
	--				Where OT2001.SOrderID = @OrderID and OT2001.DivisionID = @DivisionID and OT9999.Closing = 1) --Check Đã khóa sổ
	--Begin
	--		Set @Status =2
	--		Set @Message ='00ML000051'
	--		Goto EndMess
	--End 
 
	If exists ( select top 1 1 from OT2001 WITH (NOLOCK) Where (isnull(IsConfirm,0) = 1 or isnull(IsConfirm01,0) = 1 or isnull(IsConfirm02,0) = 1 or isnull(Status,0) = 1)  
				and isnull (Orderstatus,0) = 1 and  SOrderID =  @OrderID ) --Check đã duyệt
	Begin
			Set @Status =2
			Set @Message ='OFML000067'
			Goto EndMess
	End 	

	If exists (Select top 1 1 From AT9000 WITH (NOLOCK)  Where OrderID = @OrderID ) --Check đã sử dụng
	Begin
			Set @Status =2
			Set @Message ='00ML000052'
			Goto EndMess
	End 
	If exists (Select top 1 1 From OT2202 WITH (NOLOCK) Where MOrderID = @OrderID ) --Check đã sử dụng
	Begin
			Set @Status =2
			Set @Message ='00ML000052'
			Goto EndMess
	End 
	If exists (Select top 1 1 From OT2001 WITH (NOLOCK)  Where InheritSOrderID = @OrderID ) --Check đã sử dụng
	Begin
			Set @Status =2
			Set @Message ='00ML000052'
			Goto EndMess
	End 

	
	
	If exists (Select 1 From OT2003 WITH (NOLOCK) Where SOrderID = @OrderID) --Check đã sử dụng
	Begin
			Set @Status = 3 
			Set @Message ='OFML000068'
			Goto EndMess
	End
	
	If exists (Select 1 From AT1020 WITH (NOLOCK) Where DivisionID = @DivisionID And Isnull(SOrderID,'') = @OrderID) --Check đã sử dụng
	Begin
			Set @Status = 2 
			Set @Message ='OFML000214'
			Goto EndMess
	END
END

If @TableName =  'OT2001'  and @IsEdit = 1
BEGIN
	If exists (Select top 1 1 From AT9000 WITH (NOLOCK) Where OrderID = @OrderID )
	Begin
			Set @Status =3
			Set @Message ='SOFML000018'
			Goto EndMess
	End 	

	If exists ( select top 1 1 from OT2001 WITH (NOLOCK) Where isnull(IsConfirm,0) = 1  and isnull (Orderstatus,0) = 1 and  SOrderID =  @OrderID  )
	Begin
			Set @Status =3
			Set @Message ='SOFML000019'
			Goto EndMess
	End
	If  exists(Select Top 1 1 From OT2003 WITH (NOLOCK) Where SOrderID = @OrderID) 
		AND @CustomerName <> 117
		Begin
			Set @Status = 2
			Set @Message ='SOFML000052'
			Goto EndMess
		End
		
	If exists (Select 1 From AT1020 WITH (NOLOCK)  Where DivisionID = @DivisionID And Isnull(SOrderID,'') = @OrderID)
	Begin
			Set @Status = 2 
			Set @Message ='OFML000215'
			Goto EndMess
	END
END
---Xóa Phiếu báo giá
If @TableName =  'OT2101'  and @IsEdit = 0
BEGIN
	If not exists (Select top 1 1 From OT2101 WITH (NOLOCK)  Where QuotationID = @OrderID and DivisionID = @DivisionID ) --Check khác DivisionID
	Begin
			Set @Status =2
			Set @Message ='00ML000050'
			Goto EndMess
	End 
	--If exists (Select top 1 1 From OT2101 WITH (NOLOCK)  inner join OT9999 WITH (NOLOCK)  on OT2101.DivisionID = OT9999.DivisionID 
	--				and OT2101.TranMonth = OT9999.TranMonth and OT2101.TranYear = OT9999.TranYear
	--				Where OT2101.QuotationID = @OrderID and OT2101.DivisionID = @DivisionID and OT9999.Closing = 1) --Check Đã khóa sổ
	--Begin
	--		Set @Status =2
	--		Set @Message ='00ML000051'
	--		Goto EndMess
	--End 

	If exists ( select top 1 1 from OT2101 WITH (NOLOCK) Where (isnull(Status,0) = 1)
				and isnull (Orderstatus,0) = 1 and  QuotationID =  @OrderID ) --Check đã duyệt
	Begin
			Set @Status =2
			Set @Message ='SOFML000015'
			Goto EndMess
	End 	
	
	If exists (Select top 1 1 From OT2001 WITH (NOLOCK) Where QuotationID = @OrderID ) --Check đã sử dụng
	Begin
			Set @Status =2
			Set @Message ='00ML000052'

			Goto EndMess
	End 


	If exists (Select Top 1 1 From OT2002 WITH (NOLOCK)  Inner Join  OT2001 WITH (NOLOCK) on OT2001.SOrderID = OT2002.SOrderID Where OT2002.DivisionID = @DivisionID and OT2002.QuotationID = @OrderID ) --Check đã sử dụng
	Begin
			Set @Status =2
			Set @Message ='00ML000052'
			Goto EndMess
	End 
END
---Sửa phiếu báo giá
If @TableName =  'OT2101'  and @IsEdit = 1
BEGIN
	If exists (Select Top 1 1 From OT2002 WITH (NOLOCK)  Inner Join  OT2001 WITH (NOLOCK) on OT2001.SOrderID = OT2002.SOrderID Where OT2002.DivisionID = @DivisionID and OT2002.QuotationID = @OrderID )
	Begin
			Set @Status =3
			Set @Message ='SOFML000016'
			Goto EndMess
	End 	

	If exists ( Select top 1 1 from OT2101 WITH (NOLOCK) Where isnull(IsConfirm,0) = 1  and isnull (Orderstatus,0) = 1 and  QuotationID =  @OrderID)
	Begin
			Set @Status =3
			Set @Message ='SOFML000017'
			Goto EndMess
	End 	

END

--ĐÌnh Hòa [02/06/2021] - Xóa phiếu bảng tính giá
If @TableName =  'SOT2110'  and @IsEdit = 0
BEGIN
	-- Kiểm tra phiếu duyệt
	If exists (SELECT Top 1 1 FROM SOT2110 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND APK = @OrderID AND StatusSS = 1)
	Begin
			Set @Status =2
			Set @Message =''
			Goto EndMess
	End 	
	-- Kiểm tra kế thừa
	If exists (Select Top 1 1 From OT2101 WITH (NOLOCK)  Inner Join  OT2102 WITH (NOLOCK) on OT2101.QuotationID = OT2102.QuotationID Where OT2102.DivisionID = @DivisionID and OT2102.InheritVoucherID = @OrderID and OT2102.InheritTableID = 'SOT2110')
	Begin
			Set @Status =1
			Set @Message =''
			Goto EndMess
	End 	
END

--Đình Hòa [03/08/2021] - Xóa phiếu báo giá Sale
If @TableName =  'SOT2120'  and @IsEdit = 0
BEGIN
	-- Kiểm tra phiếu duyệt
	If exists (SELECT Top 1 1 FROM SOT2120 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND APK = @OrderID AND IsConfirm = 1)
	Begin
			Set @Status =2
			Set @Message =''
			Goto EndMess
	End 	

	-- Kiểm tra kế thừa
	If exists (Select Top 1 1 From OT2101 WITH (NOLOCK)  Inner Join  OT2102 WITH (NOLOCK) on OT2101.QuotationID = OT2102.QuotationID Where OT2102.DivisionID = @DivisionID and OT2102.InheritVoucherID = @OrderID and OT2102.InheritTableID = 'SOT2120')
	Begin
			Set @Status =1
			Set @Message =''
			Goto EndMess
	End 	
END

EndMess:


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
