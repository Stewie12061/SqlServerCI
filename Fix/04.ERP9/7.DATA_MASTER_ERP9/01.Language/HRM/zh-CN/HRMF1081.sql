-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1081- HRM
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
SET @FormID = 'HRMF1081'
SET @LanguageValue  = N'更新管理支出的定義'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'分配'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'目標類型'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.TargetTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'目標類型名稱'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.TargetName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'標題'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.Caption',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'用來'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.IsUsed',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'金額'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1081.IsAmount',  @FormID, @LanguageValue, @Language;
