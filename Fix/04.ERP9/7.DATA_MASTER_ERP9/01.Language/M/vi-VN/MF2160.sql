-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2160- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF2160';

SET @LanguageValue = N'Danh mục lệnh sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành phẩm/bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.ProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng thành phẩm/bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.ProductQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Máy';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thành phẩm/bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.ProductID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kế hoạch sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.MPlanID', @FormID, @LanguageValue, @Language;
