-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2004- EDM
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
SET @ModuleID = 'EDM';
SET @FormID = 'EDMF2004';

SET @LanguageValue = N'Chọn khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2004.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2004.ReceiptTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2004.PromotionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2004.PromotionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2004.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2004.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức KM';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2004.PromotionTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị KM';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2004.Value', @FormID, @LanguageValue, @Language;