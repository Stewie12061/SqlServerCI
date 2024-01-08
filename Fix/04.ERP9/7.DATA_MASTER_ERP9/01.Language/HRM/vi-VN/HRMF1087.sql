-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1087- HRM
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
SET @FormID = 'HRMF1087'

SET @LanguageValue  = N'Cập nhật định nghĩa loại hợp đồng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại hợp đồng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.ContractTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại hợp đồng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.ContractTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chỉnh sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người chỉnh sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tháng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.Months',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cảnh báo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.IsWarning',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cảnh báo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1087.WarningDays',  @FormID, @LanguageValue, @Language;
