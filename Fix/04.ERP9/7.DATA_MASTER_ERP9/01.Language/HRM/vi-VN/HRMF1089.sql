-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1089- HRM
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
SET @FormID = 'HRMF1089'

SET @LanguageValue  = N'Cập nhật định nghĩa hình thức kỷ luật'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.FormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.FormName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.Level',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chỉnh sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người chỉnh sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khen thưởng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.IsReward',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kỉ luật'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1089.IsNotReward',  @FormID, @LanguageValue, @Language;
