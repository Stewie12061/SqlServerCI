-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2030- S
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
SET @ModuleID = 'S';
SET @FormID = 'SF2030';

SET @LanguageValue = N'Dung lượng';
EXEC ERP9AddLanguage @ModuleID, 'SF2030.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ dung lượng';
EXEC ERP9AddLanguage @ModuleID, 'SF2030.CapacityChartName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dung lượng đã dùng';
EXEC ERP9AddLanguage @ModuleID, 'SF2030.CapacityUsed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dữ liệu (Database)';
EXEC ERP9AddLanguage @ModuleID, 'SF2030.CapacityDatabase', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thư mục Avatar';
EXEC ERP9AddLanguage @ModuleID, 'SF2030.CapacityFolderAvatar', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thư mục Email';
EXEC ERP9AddLanguage @ModuleID, 'SF2030.CapacityFolderEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thư mục file đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'SF2030.CapacityFolderAttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ổ đĩa (Drive)';
EXEC ERP9AddLanguage @ModuleID, 'SF2030.Drive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dung lượng đang hiển thị được tính theo MegaByte (MB)';
EXEC ERP9AddLanguage @ModuleID, 'SF2030.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng dung lượng:';
EXEC ERP9AddLanguage @ModuleID, 'SF2030.TotalCapacity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đã sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'SF2030.Used', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Còn lại:';
EXEC ERP9AddLanguage @ModuleID, 'SF2030.RemainingCapacity', @FormID, @LanguageValue, @Language;

-- 11/11/20212 - [Hoài Bảo] - Bổ sung ngôn ngữ đính kèm dòng dữ liệu đính kèm chat
SET @LanguageValue = N'Dữ liệu đính kèm chat';
EXEC ERP9AddLanguage @ModuleID, 'SF2030.DataAttachChat', @FormID, @LanguageValue, @Language;