IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[CRMP90000]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CRMP90000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
----<Summary>
----Kiểm tra @ID (Dùng cho danh mục) hoặc @APK (Dùng cho nghiệp vụ)đã sử dụng trước khi xóa
---- 
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Phan thanh hoang vu, Date: 20/11/2015
----<Modify by>: 
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Thị Phượng on 29/06/2016: Bổ sung trường hợp xóa phiếu điều phối
---- Modified by Thị Phượng on 21/02/2017: Bổ sung trường hợp xóa KH dữ liệu đồng bộ, không kiểm tra theo DivisionID
----<Modify by>: Nguyễn Thị Lệ Huyền, Date: 21/03/2017 Bổ sung check xoá giai đoạn thực hiện
----<Modify by>: Nguyễn Thị Lệ Huyền, Date: 22/03/2017 Bổ sung check xoá lý do và loại hình bán hàng
----<Modify by>: Nguyễn Thị Lệ Huyền, Date: 24/03/2017 Bổ sung check xoá hành động
---- Modified by Thị Phượng on 07/04/2017: Bổ sung TableID trường hợp xóa truyền bảng vào để kiểm tra
---- Modified by Thị Phượng on 08/04/2017: Kiểm tra xóa Đầu mối, Xóa chiến dịch, Yêu cầu, Phân loại đầu mối
---- Modified by Thị Phượng on 03/05/2017: Comment out Danh mục yêu cầu
---- Modified by Hoàng Vũ on 23/06/2017: bổ sung check xóa
---- Modified by Thị Phượng on 26/06/2017: Bổ sung check xóa lĩnh vực kinh doanh
---- Modify by Hoàng vũ, Date 25/09/2018: Convert chuyển lấy dữ liệu khách hàng CRM (CRMT10101)-> Khách hàng POS (POST0011)
---- Modify by ĐÌnh Hoà, Date 24/09/2020: Kiểm tra đối tượng,khách hàng(CF0033,CRMF1010) liên quan các ngiệp vụ Phiếu yêu cầu khách hàng, dự toán khách hàng, 
----									  Kế hoạch bán hàng, Thông tin sản xuất, Tiến độ nhận hàng, Tiến độ giao hàng, đơn hàng điều chỉnh,  Book Cont đơn hàng xuất khẩu 
---- Modify by Ngọc Long, Date 02/07/2021: Thêm điều kiện cho table CRMT10401 cột SystemStatus, nếu là trạng thái hệ thống thì không được phép xóa
----<Example>
/*
	Declare @Status TINYINT
	Exec CRMP90000 'HT','CRMF2020', 'CRMT10101', '65043073-43f1-4233-a2f7-b742d4370eaa' ,'65043073-43f1-4233-a2f7-b742d4370eaa', 6, 2016, @Status output
	Select @Status
*/
CREATE PROCEDURE [dbo].[CRMP90000] 	
			(
				@DivisionID varchar(50),
				@FormID  nvarchar(50),
				@TableID nvarchar(50) = null,
				@APK uniqueidentifier = null, 
				@ID varchar(Max) = null, 
				@TranMonth int = null, 
				@TranYear int = null, 
				@Status  TINYINT OUTPUT
			)
AS

	DECLARE @Message AS NVARCHAR(250)

	IF @FormID = 'CRMF1000' --Danh mục liên hệ
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM CRMT10102 WITH (NOLOCK) WHERE  ContactID = @ID)
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess

		END
		IF EXISTS (SELECT TOP 1 1 FROM POST0011 WITH (NOLOCK) WHERE InheritConvertID = (Select APK from CRMT10001 WIth (NOLOCK) Where ContactID = @ID))
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess

		END
	END
	IF @FormID = 'CRMF1002' --Xem chi tiêt liên hệ
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM CRMT10102 WITH (NOLOCK) WHERE  ContactID = @ID)
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END
		IF EXISTS (SELECT TOP 1 1 FROM POST0011 WITH (NOLOCK) WHERE InheritConvertID = @ID)
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess

		END
	END
	IF (@FormID = 'CRMF1010' or @FormID = 'CF0033') --Danh mục khách hàng, đối tượng
	BEGIN
		DECLARE @sWhere nvarchar(MAX),
				@CustomerIndex INT

		SET @sWhere = ''
		SET @CustomerIndex = (Select top 1 CustomerName from CustomerIndex)

		If @CustomerIndex = 117
			BEGIN
				SET @sWhere = 'UNION ALL 
				--Phiếu yêu cầu khách hàng
		            Select top 1 1  From CRMT2100 WITH (NOLOCK)  Where ObjectID = @ID 
					UNION ALL 
					--Dự toán
		            Select top 1 1  From CRMT2110 WITH (NOLOCK)  Where ObjectID = @ID 
					UNION ALL 
					--Kế hoạch bán hàng
		            Select top 1 1  From SOT2070 WITH (NOLOCK)  Where ObjectID = @ID  
					UNION ALL 
					--Điều chỉnh đơn hàng
		            Select top 1 1  From OT2006 WITH (NOLOCK)  Where ObjectID = @ID   
					UNION ALL 
					 --Tiến độ giao hàng
		            Select top 1 1  From OT2003 WITH (NOLOCK)  Where ObjectID = @ID  
					UNION ALL 
					--Thông tin Sản xuất
		            Select top 1 1  From SOT2080 WITH (NOLOCK)  Where ObjectID = @ID  
					UNION ALL 
					-- Tiến độ nhận hàng
		            Select top 1 1  From OT3003 WITH (NOLOCK)  Where ObjectID = @ID'
			END


		IF EXISTS (SELECT TOP 1 1 FROM OT2001 WITH (NOLOCK) WHERE (ObjectID = @ID or VATObjectID = @ID)
				   Union all
				   SELECT TOP 1 1 FROM OT2101 WITH (NOLOCK) WHERE  ObjectID = @ID
				   Union all
				   SELECT TOP 1 1 FROM AT2006 WITH (NOLOCK) WHERE  ObjectID = @ID
				   Union all
				   SELECT TOP 1 1 FROM AT2026 WITH (NOLOCK) WHERE  ObjectID = @ID
				   Union all
				   SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) WHERE (ObjectID = @ID  or VATObjectID = @ID)
				   Union all
				   SELECT TOP 1 1 FROM CRMT20501 WITH (NOLOCK) WHERE  AccountID = @ID
				   Union all --bảng trung gian
				   SELECT TOP 1 1 FROM CRMT20801_CRMT10101_REL WITH (NOLOCK) WHERE  AccountID in (Select Distinct APK From POST0011 Where MemberID = @ID)
				   Union all
				   SELECT TOP 1 1 FROM POST0011 WITH (NOLOCK) WHERE  VATAccountID = @ID
				   Union all
				   SELECT TOP 1 1 FROM AT1202 WITH (NOLOCK) WHERE  VATObjectID = @ID
				   + @sWhere)
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END
	END
	--Danh mục giai đoạn bán hàng
	IF (@TableID = 'CRMT10401' or @FormID = 'CRMF1040' or @FormID = 'CRMF1042') 
	BEGIN
		IF EXISTS(SELECT TOP 1 1 FROM CRMT10401 WITH (NOLOCK) WHERE StageID = @ID AND SystemStatus != 0)
		BEGIN
			SET @Status = 2
			-- {0} thuộc quyền quản trị hệ thống, bạn không được phép xóa.
			SET @Message = N'00ML000091'
			GOTO Mess
		END
		IF EXISTS (SELECT TOP 1 1 FROM CRMT20501 WITH (NOLOCK) WHERE (StageID = @ID ))
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess

		END
		IF EXISTS (SELECT TOP 1 1 FROM CRMT20301 WITH (NOLOCK) WHERE (LeadStatusID = @ID ))
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess

		END
	END
	--Danh mục lý do thất bại/thành công
	IF (@TableID = 'CRMT10501' or @FormID = 'CRMF1050' or @FormID = 'CRMF1052') 
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM CRMT20501 WITH (NOLOCK) WHERE (CauseID = @ID ))
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess

		END
	END
	--Danh mục từ khóa
	IF (@TableID = 'CRMT10601' or @FormID = 'CRMF1060' or @FormID = 'CRMF1062') 
	BEGIN
		IF EXISTS (
				   SELECT TOP 1 1 FROM CRMT20501_CRMT10601_REL WITH (NOLOCK) WHERE (SalesTagID = @ID)--Kiểm tra bảng trung gian
				   )
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess

		END
	END
	--Danh mục hành động
	IF (@TableID = 'CRMT10801' or @FormID = 'CRMF1080' or @FormID = 'CRMF1082') 
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM CRMT20501 WITH (NOLOCK) WHERE (NextActionID = @ID ))
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess

		END
	END
	IF @FormID = 'CRMF2010' --Danh sách chưa phiếu điều phối
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM AT2007  WITH (NOLOCK) WHERE DivisionID = @DivisionID and InheritVoucherID = @ID)
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END
	END
	IF (@FormID = 'CRMF2020' or @FormID = 'CRMF2022' )--Danh sách đã phiếu điều phối (Phiếu vận chuyển nội bộ)
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM AT2006  WITH (NOLOCK)
		           WHERE DivisionID = @DivisionID 
		           AND OrderID = (SELECT OrderID FROM AT2006 WITH (NOLOCK)
									where KindVoucherID =3 AND IsWeb =1  and InTime is not null AND  VoucherID = @ID)
		           AND AT2006.KindVoucherID =2  )--Phiếu điều phối đã Quét barcode về
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END
		IF EXISTS (SELECT TOP 1 1 FROM AT2027  WITH (NOLOCK) WHERE DivisionID = @DivisionID and (InheritVoucherID = @ID or InheritTransactionID = @ID)) --Phiếu xuất kho theo bộ
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END 
		
	END
	---Danh mục đầu mối
	IF (@TableID = 'CRMT20301' )
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM POST0011  WITH (NOLOCK) WHERE InheritConvertID =@ID)
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END
		IF EXISTS (SELECT TOP 1 1 FROM CRMT20501_CRMT20301_REL  WITH (NOLOCK) WHERE LeadID = (select APK FROM CRMT20301 with (NOLOCK) where LeadID =@ID))
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END 

	END
	---Danh mục chiến dịch
	IF (@TableID = 'CRMT20401' )
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM CRMT20501  WITH (NOLOCK) WHERE CampaignID  =@ID)
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END
	END
	---Danh mục yêu cầu
	IF (@TableID = 'CRMT20801' )--Bảng  yêu cầu
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM CRMT90031_REL  WITH (NOLOCK) WHERE RelatedToID = @ID)
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END

	END
	----Danh mục nguồn đầu mối
	IF (@TableID = N'CRMT10201' or @FormID=N'CRMF1020' or @FormID=N'CRMF1022')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM CRMT2210 WHERE  TypeOfSource = @ID )
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END
		IF EXISTS (SELECT TOP 1 1 FROM CRMT20301 WHERE  LeadTypeID = @ID )
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END
		IF EXISTS (SELECT TOP 1 1 FROM CRMT20501 WHERE  SourceID = @ID )
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END
	END
	----Danh mục cơ hội
	IF @TableID = 'CRMT20501' 
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM POST0011  WITH (NOLOCK) WHERE InheritConvertID =@ID )
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END
		IF EXISTS (SELECT TOP 1 1 FROM OT2101  WITH (NOLOCK) WHERE OpportunityID =@ID )
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END
	END
	----Danh mục lĩnh vực linh doanh
	IF @TableID = 'CRMT10701' 
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM POST0011  WITH (NOLOCK) WHERE BusinessLinesID =@ID )
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END
		IF EXISTS (SELECT TOP 1 1 FROM CRMT20501  WITH (NOLOCK) WHERE BusinessLinesID =@ID )
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END
	END
Mess:

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO