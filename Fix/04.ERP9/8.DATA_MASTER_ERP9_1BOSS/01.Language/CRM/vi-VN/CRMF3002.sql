-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF3002 - CRM
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
SET @Language = 'vi-VN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF3002';

SET @LanguageValue = N'Báo cáo quan hệ khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đầu mối - cơ hội - khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'AsoftCRM.BaoCaoThongKe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ lệ chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'AsoftCRM.TyLeChuyenDoi', @FormID, @LanguageValue, @Language;