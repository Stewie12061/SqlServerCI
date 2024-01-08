-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ NMF2022- NM
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
SET @ModuleID = 'NM';
SET @FormID = 'NMF2022';

SET @LanguageValue = N'Cập nhật phiếu kê chợ';
EXEC ERP9AddLanguage @ModuleID, 'NMF2022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2022.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'NMF2022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kê chợ';
EXEC ERP9AddLanguage @ModuleID, 'NMF2022.MarketVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kê chợ';
EXEC ERP9AddLanguage @ModuleID, 'NMF2022.MarketVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'NMF2022.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thực đơn';
EXEC ERP9AddLanguage @ModuleID, 'NMF2022.MenuName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng trẻ';
EXEC ERP9AddLanguage @ModuleID, 'NMF2022.ChildActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thực phẩm';
EXEC ERP9AddLanguage @ModuleID, 'NMF2022.MaterialsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'NMF2022.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'NMF2022.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho';
EXEC ERP9AddLanguage @ModuleID, 'NMF2022.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'NMF2022.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'NMF2022.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thực đơn';
EXEC ERP9AddLanguage @ModuleID, 'NMF2022.TabNMT2021', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết thực phẩm';
EXEC ERP9AddLanguage @ModuleID, 'NMF2022.TabNMT2022', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng hợp chi phí';
EXEC ERP9AddLanguage @ModuleID, 'NMF2022.TabNMT2023', @FormID, @LanguageValue, @Language;

