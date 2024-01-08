-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1088- HRM
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


SET @Language = 'vi-VN ';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1088'

SET @LanguageValue  = N'Cập nhật định nghĩa lý do nghỉ việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã lý do'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.QuitJobID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lý do nghỉ việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.QuitJobName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chỉnh sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người chỉnh sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1088.TypeID',  @FormID, @LanguageValue, @Language;
