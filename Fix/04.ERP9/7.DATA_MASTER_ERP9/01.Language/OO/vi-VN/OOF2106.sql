-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2106- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF2106';

SET @LanguageValue = N'Cập nhập chi phí dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2106.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh số Net';
EXEC ERP9AddLanguage @ModuleID, 'OOF2106.NetSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền hoa hồng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2106.CommissionCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi phí tiếp khách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2106.GuestCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị cộng thêm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2106.BonusSales', @FormID, @LanguageValue, @Language;