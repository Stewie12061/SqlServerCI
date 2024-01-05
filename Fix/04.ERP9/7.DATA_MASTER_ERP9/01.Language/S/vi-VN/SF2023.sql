-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2023- S
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
SET @ModuleID = 'S';
SET @FormID = 'SF2023';

SET @LanguageValue = N'Chọn phiếu nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF2023.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phiếu nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF2023.VoucherBusiness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phiếu nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF2023.VoucherBusinessName', @FormID, @LanguageValue, @Language;

