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
SET @FormID = 'OOF2340';

SET @LanguageValue = N'Danh mục văn bản';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Văn bản số';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.DocumentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đến';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.DocumentNumberInto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giả';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.DocumentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công văn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.DocumentMode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công văn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.DocumentMode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại văn bản';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.UseDocumentTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại văn bản';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.DocumentTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại văn bản';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.DocumentTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.SignedStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.SignedStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nhận/gửi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.ReceivedDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi nhận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.ReceivedPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày gửi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.SentDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi gửi/nhận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.SentPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.DocumentSignDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên người ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.UseSignerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ người ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.UseSignerDutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thẩm quyền ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.UseSignerAuthority', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời hạn xử lý';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.OutOfDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trích yếu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.Summary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người có thẩm quyền chỉ đạo giải quyết';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.DecidedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người có thẩm quyền chỉ đạo giải quyết';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.DecidedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi lưu bản cứng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.HardStoreDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi lưu bản cứng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.HardStoreDepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị soạn thảo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.ComposePlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị phát hành';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.PublishPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Văn bản nội bộ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2340.IsInternal', @FormID, @LanguageValue, @Language;