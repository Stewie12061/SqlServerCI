-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ 
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
SET @FormID = 'EDMF30004';

SET @LanguageValue = N'Báo cáo danh sách hoàn trả tiền ăn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF30004.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF30004.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF30004.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF30004.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF30004.Cbb_Month', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF30004.ReportID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF30004.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF30004.FromDate', @FormID, @LanguageValue, @Language;