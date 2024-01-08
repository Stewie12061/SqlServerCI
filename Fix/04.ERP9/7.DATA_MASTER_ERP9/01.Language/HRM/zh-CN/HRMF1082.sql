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


SET @Language = 'zh-CN';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1082'

SET @LanguageValue  = N'更新收入和扣除額的定義'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.Title',  @FormID, @LanguageValue, @Language;
--tab
SET @LanguageValue  = N'收入帳戶'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.CacKhoanThuNhap',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'扣除帳戶'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.CacKhoanGiamTru',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'標題'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.Caption',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'英文字幕'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.CaptionE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'用來'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.IsUsed',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'伊斯塔克斯'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.Istax',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'是轉移'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.IsTranfer',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'現實主義'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1082.IsCalculateNetIncome',  @FormID, @LanguageValue, @Language;
