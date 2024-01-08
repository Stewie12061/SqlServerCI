-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2250- OO
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'vi-VN' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF2341';

SET @LanguageValue = N'Cập nhật Văn bản';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Văn bản số';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.DocumentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đến';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.DocumentNumberInto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giả';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.DocumentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công văn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.DocumentMode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công văn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.DocumentMode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại văn bản';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.UseDocumentTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại văn bản';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.DocumentTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại văn bản';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.DocumentTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.SignedStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.SignedStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nhận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.ReceivedDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi nhận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.ReceivedPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày gửi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.SentDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi gửi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.SentPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.DocumentSignDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên người ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.UseSignerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ người ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.UseSignerDutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thẩm quyền ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.UseSignerAuthority', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời hạn xử lý';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.OutOfDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trích yếu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.Summary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người có thẩm quyền chỉ đạo giải quyết';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.DecidedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người có thẩm quyền chỉ đạo giải quyết';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.DecidedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi lưu bản cứng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.HardStoreDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi lưu bản cứng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.HardStoreDepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị soạn thảo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.ComposePlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị phát hành';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.PublishPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.DocumentModeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.DocumentModeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.DocumentTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.DocumentTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Văn bản nội bộ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.IsInternal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn người duyệt/ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.AddFollowerList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cấp duyệt/ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.Steps', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người dùng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.FollowerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người dùng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.FollowerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sử dụng ký số';
EXEC ERP9AddLanguage @ModuleID, 'OOF2341.UseESign', @FormID, @LanguageValue, @Language;