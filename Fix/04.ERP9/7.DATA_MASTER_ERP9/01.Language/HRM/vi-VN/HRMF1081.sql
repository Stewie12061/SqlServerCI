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
SET @FormID = 'HRMF1081'

SET @LanguageValue  = N'Cập nhật định nghĩa các chi tiêu quản lý'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chỉ tiêu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.TargetTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chỉ tiêu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.TargetName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên gọi'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.Caption',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sử dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.IsUsed',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.IsAmount',  @FormID, @LanguageValue, @Language;
