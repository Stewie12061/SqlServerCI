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
SET @FormID = 'MTF2000';

SET @LanguageValue = N'Address';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Address' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Birthday';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.BirthDay' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Branch';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.BranchID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Class Date';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.ClassDate' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Class ID';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.ClassID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Email 1';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.ContactEmail1' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Email 2';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.ContactEmail2' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Contact person 1';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.ContactPerson1' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Contact person 2';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.ContactPerson2' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Telephone 1';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.ContactTel1' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Telephone 2';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.ContactTel2' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Course';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.CourseName' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'District';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.District' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Division';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.DivisionID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Email';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Email' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Father''s job';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.FatherJob' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Female';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.FeMale' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Name';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.FirstName' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'From Date';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.FromDate' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'From Period';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.FromPeriod' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Department';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Grade' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Improvement';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Improvement' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Interviewer';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Interviewer' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Sex';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.IsMale' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'According to Examination part';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.IsNotSkill' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'According to Skill';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.IsSkill' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Others';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.IsTAOthers' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.IsTASimple' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.IsTATC' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Last Name';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.LastName' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Education Program Name';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.LevelName' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Listen';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Listen' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Male';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Male' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Mother''s job';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.MotherJob' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Địa chỉ';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.MTF2000Address' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Tình trạng';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.MTF2000Status' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Mã học viên';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.MTF2000StudentID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Manage Student';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.MTF2000Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Update student Information';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.MTF2001Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Show Student Information';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.MTF2002Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Notes';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Notes' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Other Notes';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.OtherNotes' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Part 1';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Part1' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Part 2';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Part2' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Part 3';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Part3' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Part 4';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Part4' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Total';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.PartTotal' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Arrange to level';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.PlacementLevel' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Read';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Read' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Reception';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Reception' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Classify';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.S' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'School';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.School' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Source 1';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Source1' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Source 2';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Source2' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Source 3';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Source3' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Speak';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Speak' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Start date Note';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.SpecNotes' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Start date';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.StartDate' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Status';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Status' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Status ID';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.StatusID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Strengths';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Strenghts' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Number';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.STT' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Student ID';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.StudentID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Student Name';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.StudentName' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'English Name';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.StudentNameE' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Input Result';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.TabInfoExams' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Added Information';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.TabInfoExtension' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Education Program';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.TabInfoProcess' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Individual Information';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.TabInfoStudent' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Program';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.TATC' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Teacher''s Comment';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.TeacherCommentEK' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Telephone 1';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Tel1' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Tele phone 2';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Tel2' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Telephone number';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.TelFilter' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'To date';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.ToDate' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'To Period';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.ToPeriod' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Total';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Total' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Ward';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Ward' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Write';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2000.Write' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;
