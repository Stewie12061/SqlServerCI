-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2024- OO
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


SET @Language = 'vi-VN';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2024'


SET @LanguageValue  = N'Chọn yêu cầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chọn yêu cầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMFT2024.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'APK'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.APK',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.RecruitRequireID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.RecruitRequireName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'RowNum'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.RowNum',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'TotalRow'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.TotalRow',  @FormID, @LanguageValue, @Language;

