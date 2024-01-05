-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ NMF2061- NM
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
SET @FormID = 'NMF2061';

SET @LanguageValue = N'Hồ sơ sức khỏe';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hồ sơ sức khỏe';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.GradeLevelID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.ClassName', @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiều cao(cm)';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cân nặng(kg)';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng tiêm chủng';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.Content', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.SchoolYearID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.DateFrom.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.DateTo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khối';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lớp';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.ClassID.CB', @FormID, @LanguageValue, @Language;	

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.ClassName.CB', @FormID, @LanguageValue, @Language;	

SET @LanguageValue = N'Chọn học sinh';
EXEC ERP9AddLanguage @ModuleID, 'NMF2061.ChosseStudent', @FormID, @LanguageValue, @Language;	