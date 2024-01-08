-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF1011- PO
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
SET @ModuleID = 'PO';
SET @FormID = 'POF1011';

SET @LanguageValue = N'Cập nhật mẫu kế hoạch nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF1011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POF1011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mẫu kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'POF1011.FormPlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'POF1011.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'POF1011.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'POF1011.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bước kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'POF1011.PlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bước kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'POF1011.PlanName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số ngày';
EXEC ERP9AddLanguage @ModuleID, 'POF1011.NDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POF1011.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'POF1011.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'POF1011.Description.CB', @FormID, @LanguageValue, @Language;

