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
SET @FormID = 'OOF2350';

SET @LanguageValue = N'Danh mục Văn bản đi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Văn bản số';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.DocumentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giả';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.DocumentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.DocumentTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.DocumentTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.SignedStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.SignedStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nhận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.ReceivedDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi nhận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.ReceivedPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày gửi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.SentDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi gửi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.SentPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.DocumentSignDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời hạn xử lý';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.OutOfDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trích yếu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.Summary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người có thẩm quyền chỉ đạo giải quyết';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.DecidedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi lưu bản cứng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.HardStoreDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi lưu bản cứng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.HardStoreDepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi phát hành';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.PublishPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Văn bản nội bộ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2350.IsInternal', @FormID, @LanguageValue, @Language;