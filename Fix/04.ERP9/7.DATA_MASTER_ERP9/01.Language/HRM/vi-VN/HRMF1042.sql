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
SET @FormID = 'HRMF1042'

SET @LanguageValue  = N'Xem chi tiết lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.Title ',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã Lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.TrainingFieldID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.TrainingFieldName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.SubTitle1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1042.TabCRMT00003',  @FormID, @LanguageValue, @Language;

