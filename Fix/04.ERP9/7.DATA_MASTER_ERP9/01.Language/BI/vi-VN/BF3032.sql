-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ
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
SET @ModuleID = 'BI';
SET @FormID = 'BF3032'


SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'BF3032.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khoản chi phí'
EXEC ERP9AddLanguage @ModuleID, 'BF3032.FromObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Báo cáo chi phí'
EXEC ERP9AddLanguage @ModuleID, 'BF3032.Title',  @FormID, @LanguageValue, @Language;



