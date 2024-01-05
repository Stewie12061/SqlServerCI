-----------------------------------------------------------------------------------------------------
-- Script tạo message - MT
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(5),
@FormID VARCHAR(50),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),
@LanguageCustomValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT

/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US'; 
SET @ModuleID = 'MT';
SET @FormID = 'MTF1040';

SET @LanguageValue = N'Begin Date';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.BeginDate' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Branch';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.BranchID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Class ID';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.ClassID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Class Name';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.ClassName' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Course ID';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.CourseID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Course Name';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.CourseName' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Disabled';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.Disabled' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Division ID';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.DivisionID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'End Date';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.EndDate' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Education Program ID';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.LevelID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Education Program Name';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.LevelName' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Class Lists';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.MTF1040Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Update Class';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.MTF1041Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Class Detail';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.MTF1042TimeInfo' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Show Class Detail';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.MTF1042Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Update Teacher';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.MTF1043Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Notes';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.Notes' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Classify';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.S' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'School Time ID';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.SchoolTimeID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'School Time Name';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.SchoolTimeName' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Number';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.STT' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Teacher ID';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.TeacherID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Teacher Name';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1040.TeacherName' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;
