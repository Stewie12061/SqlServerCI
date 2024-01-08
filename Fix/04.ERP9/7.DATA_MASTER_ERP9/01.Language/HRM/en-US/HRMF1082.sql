-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1082- HRM
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


SET @Language = 'en-US';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1082'

SET @LanguageValue  = N'Update definition of income and deductions'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.Title',  @FormID, @LanguageValue, @Language;
--tab
SET @LanguageValue  = N'Income accounts'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.CacKhoanThuNhap',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Deduction accounts'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.CacKhoanGiamTru',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Caption'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.Caption',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'CaptionE'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.CaptionE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsUsed'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.IsUsed',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Istax'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.Istax',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsTranfer'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.IsTranfer',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsCalculateNetIncome'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.IsCalculateNetIncome',  @FormID, @LanguageValue, @Language;
