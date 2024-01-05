-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1032- OO
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
SET @FormID = 'HRMF1010'

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hình thức phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.InterviewTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hình thức phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.InterviewTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Danh mục hình thức phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1010.DutyName.CB',  @FormID, @LanguageValue, @Language;