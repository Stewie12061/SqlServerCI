-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2110- EDM
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
SET @FormID = 'EDMF2110';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2110.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2110.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chương trình';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2110.ProgramID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chương trình';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2110.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2110.TermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2110.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2110.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2110.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2110.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2110.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2110.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2110.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2110.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chương trình';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2110.FromVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2110.ToVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng khung chương trình';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2110.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã năm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2110.SchoolYearID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2110.DateFrom.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2110.DateTo.CB', @FormID, @LanguageValue, @Language;

