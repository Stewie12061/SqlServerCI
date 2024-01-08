-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2060- PO
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
SET @ModuleID = 'PO';
SET @FormID = 'POF2060';

SET @LanguageValue = N'Đặt containter xuất hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đi';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.DepartureDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đến';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.ArrivalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cảng';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.PortName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hãng tàu';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.ShipBrand', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.DivisionIDPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hãng tàu';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.ShipBrandPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cảng';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.PortNamePOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.VoucherNoPOF2060', @FormID, @LanguageValue, @Language;

