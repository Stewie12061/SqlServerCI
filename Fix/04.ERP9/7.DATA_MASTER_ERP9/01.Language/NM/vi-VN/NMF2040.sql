-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ NMF2040- NM
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
SET @FormID = 'NMF2040';

SET @LanguageValue = N'Sổ tính tiền chợ';
EXEC ERP9AddLanguage @ModuleID, 'NMF2040.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2040.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'NMF2040.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sô phiếu tiền chợ';
EXEC ERP9AddLanguage @ModuleID, 'NMF2040.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'NMF2040.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu điều tra';
EXEC ERP9AddLanguage @ModuleID, 'NMF2040.InvestigateVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số dư đầu tháng';
EXEC ERP9AddLanguage @ModuleID, 'NMF2040.SurplusMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số dư đầu ngày';
EXEC ERP9AddLanguage @ModuleID, 'NMF2040.SurplusDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2040.QuotaUnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số học sinh';
EXEC ERP9AddLanguage @ModuleID, 'NMF2040.TotalStudent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'NMF2040.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2040.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2040.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2040.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2040.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2040.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2040.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2040.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'NMF2040.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'NMF2040.ToDate', @FormID, @LanguageValue, @Language;
