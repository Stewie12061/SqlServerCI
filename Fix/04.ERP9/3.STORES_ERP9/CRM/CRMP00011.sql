if exists (select 1 from sys.objects where [name] = 'CRMP00011' and [type] = 'P')
	drop proc CRMP00011
GO


-- <Summary>
--- Cập nhật dữ liệu phân quyền nghiệp vụ
-- <Param>
----DivisionID : Đơn vị
----VoucherNo : Số phiếu
----VoucherTypeID : Loại phiếu
----StatusID : Chấp nhận hay không?
----OpportunityID : Mã cơ hội
----AssignedToUserID : Người thực hiện
----PermissionUserID : Những User được cấp quyền
----TableContent : Thông tin bảng chứa chứng từ
----UserID : User thao tác
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by:Bảo Toàn Date 01/08/2019
-- <Example>

create proc CRMP00011 
@APK	UNIQUEIDENTIFIER,
@DivisionID	VARCHAR(50),
@VoucherNo	VARCHAR(50),
@VoucherTypeID	VARCHAR(50),
@StatusID	TINYINT,
@OpportunityID	VARCHAR(50),
@AssignedToUserID	VARCHAR(50),
@PermissionUserID	VARCHAR(500),
@TableContent VARCHAR(50),
@UserID	VARCHAR(50)
as
begin
	--convert data '' to null AssignedToUserID
	if @AssignedToUserID = ''
		set @AssignedToUserID = null
	if @PermissionUserID = ''
		begin
			delete from CRMT0001 where APK = @APK
		end 
	else
		if exists(select 1 from CRMT0001 where APK = @APK)
			begin
				--update
				update CRMT0001
				set PermissionUserID = @PermissionUserID, StatusID = @StatusID, LastModifyDate = getdate(), LastModifyUserID = @UserID
				where APK = @APK		
			end
		else
			begin
			--insert
				insert into CRMT0001([DivisionID],[VoucherNo],[VoucherTypeID],[StatusID],[OpportunityID],[AssignedToUserID]
									,[PermissionUserID],[TableContent],[CreateUserID],[CreateDate],[LastModifyUserID],[LastModifyDate])
					values (@DivisionID,@VoucherNo,@VoucherTypeID,@StatusID,@OpportunityID,@AssignedToUserID
									,@PermissionUserID,@TableContent,@UserID,getdate(),@UserID,getdate())
			end
end
