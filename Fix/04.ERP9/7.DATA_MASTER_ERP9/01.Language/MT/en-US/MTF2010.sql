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
SET @FormID = 'MTF2010';

SET @LanguageValue = N'Total amount';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Amount' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Description';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.BDescription' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Begin Date';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.BeginDate' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Class Date';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.ClassDate' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Class ID';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.ClassID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Class Name';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.ClassName' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Amount';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.ConvertedAmount' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Course UD';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.CourseID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Course Name';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.CourseName' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Division ID';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.DivisionID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Education Process ID';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EduVoucherNo' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'End Date';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndDate' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Listen';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndListening' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Comment';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndOverallAssess' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Class Activity';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndPerformance01' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Concentrate on lesson';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndPerformance02' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Team work/group';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndPerformance03' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Acquire lesson';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndPerformance04' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Homework';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndPerformance05' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Work in Class';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndPerformance06' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Read';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndReading' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Learn new words';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndResult01' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Vocabulary';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndResult02' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Acquire grammar';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndResult03' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Speaking skill';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndResult04' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Pronunciation Skill';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndResult05' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Fluent Speaking skill';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndResult06' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Confident speaking in public ';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndResult07' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Teacher''s question reflex';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndResult08' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Writing Skill';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndResult09' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Reading Skill';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndResult10' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Listening Skill';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndResult11' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Speak';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndSpeaking' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Total mark';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndTotal' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Write';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.EndWriting' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'From date';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.FromDate' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'From Period';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.FromPeriod' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Group';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.GroupFee' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Change Class';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.IsChangeClass' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Free';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.IsFree' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'un-passed';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.IsInPass' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Pay fees';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.IsNotFree' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Passed';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.IsPass' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Education Program ID';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.LevelID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Education Program Name';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.LevelName' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Listen';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Listening' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Mark total';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.MiddleTotal' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Course report';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.MTF2010ReportViewerTitle' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Education process';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.MTF2010Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Common Information';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.MTF2011Tab01Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Result in middle course';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.MTF2011Tab02Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Result in end course';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.MTF2011Tab03Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Update education process';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.MTF2011Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Common Information';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.MTF2012Group01Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'School fees';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.MTF2012Group02Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'School fees details';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.MTF2012Group03Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Result of middle course';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.MTF2012Group04Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Result of end course';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.MTF2012Group05Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Show Education Program Detail';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.MTF2012Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Next class';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.NextClassID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Next Course';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.NextCourseID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Note';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Notes' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Comment';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.OverallAssess' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Received';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Paid' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Class Activity';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Performance01' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Concentrate on lesson';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Performance02' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Team work/group';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Performance03' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Acquire lesson';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Performance04' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Homework';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Performance05' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Work in Class';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Performance06' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Read';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Reading' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Special school fees';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.ReduceAmount' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Note';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.ReduceNotes' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Reduce reason';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.ReduceReasonID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Reduce Time (month)';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.ReduceTime' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Remaining';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Remaining' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Learn new words';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Result01' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Vocabulary';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Result02' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Acquire grammar';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Result03' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Speaking skill';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Result04' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Pronunciation Skill';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Result05' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Fluent expression skill';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Result06' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Confident speaking in public';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Result07' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Teacher''s question reflex';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Result08' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Writing Skill';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Result09' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Reading Skill';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Result10' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Listening Skill';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Result11' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Day';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.ReturnDate' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Return school fees';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.ReturnMoney' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Employee';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.ReturnPersonID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Return Reason';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.ReturnReason' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'School time';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.SchoolTimeID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'School time Name';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.SchoolTimeName' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Amount';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.SendMoney' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Transfer School fees to next course';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.SendMoneyView' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Note';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.SendNotes' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Note of transfer';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.SendNotesView' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Speak';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Speaking' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Status';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Status' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Status';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.StatusID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Dismiss';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.StopReason' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Number';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.STT' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Student ID';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.StudentID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Student Name';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.StudentName' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Arrange to class';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Tab01Fieldset01Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Special school fees';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Tab01Fieldset02Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Return fee';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Tab01Fieldset03Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Transfer School fees to next course';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Tab01Fieldset04Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Performance in class';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Tab02Fieldset01Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Examination Mark';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Tab02Fieldset02Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Course result';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Tab02Fieldset03Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Performance in class';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Tab03Fieldset01Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Examination mark';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Tab03Fieldset02Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Course result';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Tab03Fieldset03Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Examination result';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Tab03Fieldset04Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Teacher 1';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.TeacherName1' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Teacher 2';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.TeacherName2' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'To date';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.ToDate' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'To Period';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.ToPeriod' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Day';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.VoucherDate' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Voucher No';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.VoucherNo' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Week quantity';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.WeekQuantity' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Write';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF2010.Writing' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;
