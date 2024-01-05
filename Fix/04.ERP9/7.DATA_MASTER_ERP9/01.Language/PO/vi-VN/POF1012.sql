-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF1012- PO
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
SET @FormID = 'POF1012';

SET @LanguageValue = N'Xem chi tiết mẫu kế hoạch nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF1012.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POF1012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mẫu kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'POF1012.FormPlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'POF1012.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'POF1012.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'POF1012.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'POF1012.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'POF1012.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'POF1012.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'POF1012.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bước kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'POF1012.PlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bước kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'POF1012.PlanName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số ngày';
EXEC ERP9AddLanguage @ModuleID, 'POF1012.NDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POF1012.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin mẫu kế hoạch nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF1012.Master.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết mẫu kế hoạch nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF1012.Detail.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'POF1012.Attacth.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POF1012.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lich sử';
EXEC ERP9AddLanguage @ModuleID, 'POF1012.History.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu kế hoạch nhận hàng';
EXEC ERP9AddLanguage '00', 'A00.POT1010', 'A00', @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết mẫu kế hoạch nhận hàng';
EXEC ERP9AddLanguage '00', 'A00.POT1011', 'A00', @LanguageValue, @Language;