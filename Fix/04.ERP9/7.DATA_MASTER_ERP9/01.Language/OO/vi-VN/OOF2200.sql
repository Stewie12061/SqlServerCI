-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2200 - OO
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
SET @FormID = 'OOF2200';

SET @LanguageValue = N'Danh sách thông báo/cảnh báo tổng hợp';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách thông báo cảnh báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.ListNotification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đọc thêm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.ReadMore', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả/trang';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.ItemsPerPage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung cảnh báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cảnh báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.MessageType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.IsRead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.ScreenID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không có dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.NoRecord', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.ScreenID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2200.ScreenName.CB', @FormID, @LanguageValue, @Language;