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
SET @FormID = 'HRMF1083'

SET @LanguageValue  = N'Cập nhật định nghĩa hệ số sử dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'CID hệ số'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.CoefficientID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên trường'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.FieldName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hệ số'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.CoefficientName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên gọi'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.Caption',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sử dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.IsUsed',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hằng số'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.IsConstant',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1083.ValueOfConstant',  @FormID, @LanguageValue, @Language;
