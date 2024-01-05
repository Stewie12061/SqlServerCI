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
SET @ModuleID = 'LM';
SET @FormID = 'LMF3004'

SET @LanguageValue  = N'Báo cáo theo dõi lãi vay'
EXEC ERP9AddLanguage @ModuleID, 'LMF3004.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'LMF3004.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'LMF3004.BankID',  @FormID, @LanguageValue, @Language;

