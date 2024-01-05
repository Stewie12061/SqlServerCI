-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2060- CSM
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
SET @ModuleID = 'CSM';
SET @FormID = 'CSMF2060';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2060.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Claim';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2060.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại Claim';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2060.ClaimTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số P/O';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2060.POVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chu kỳ Claim';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2060.ClaimPeriod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái Claim';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2060.StatusClaim', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày Submit';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2060.SubmitDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2060.PaidDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2060.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2060.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2060.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2060.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2060.DispatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2060.SerialNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2060.IMEINumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2060.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại Claim';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2060.ClaimTypename', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2060.MaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description Material';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2060.DescriptionMaterial', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái Claim';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2060.StatusName', @FormID, @LanguageValue, @Language;

