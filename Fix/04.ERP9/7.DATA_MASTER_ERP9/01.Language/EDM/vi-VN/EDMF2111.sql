-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2111- EDM
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
SET @FormID = 'EDMF2111';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chương trình';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.ProgramID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chương trình';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.TermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.FromVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.ToVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật tổng khung chương trình';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.Title', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.MonthID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủ đề';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.Topic', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hoạt động';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.ActivityTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung hoạt động';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.ActivityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hoạt động';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.TabEDMT2112', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung hoạt động';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.TabEDMT2111', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hoạt động';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.ActivityTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.MonthName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung hoạt động';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.ActivityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.MonthID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.MonthName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.ActivityTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.ActivityTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.ActivityID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.ActivityName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã năm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.SchoolYearID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.DateFrom.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2111.DateTo.CB', @FormID, @LanguageValue, @Language;

