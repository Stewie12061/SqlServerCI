-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ NMF2041- NM
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
SET @FormID = 'NMF2041';

SET @LanguageValue = N'Cập nhật sổ tính tiền chợ';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sô phiếu tiền chợ';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu điều tra';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.InvestigateVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số dư đầu tháng';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.SurplusMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số dư đầu ngày';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.SurplusDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá định mức';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.QuotaUnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số học sinh';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.TotalStudent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.MaterialsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.WarehouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.SupplierID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu điều tra';
EXEC ERP9AddLanguage @ModuleID, 'NMF2041.InvestigateVoucherNoName', @FormID, @LanguageValue, @Language;

