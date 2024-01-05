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
SET @FormID = 'EDMF2101';

SET @LanguageValue = N'Cập nhật thời khóa biểu năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lịch học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.DailyScheduleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lịch học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.DateSchedule', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.TermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.FromDateSchedule', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.ToDateSchedule', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.FromHour', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.ToHour', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.Monday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ 3';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.Tuesday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ 4';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.Wednesday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ 5';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.Thursday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ 6';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.Friday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ 7';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.Saturday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủ nhật';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.Sunday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.BtnGrid', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.SchoolYearID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.DateFrom.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.DateTo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2101.Inherit', @FormID, @LanguageValue, @Language;