-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2133- OO
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


SET @Language = 'vi-VN';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2133'

SET @LanguageValue  = N'Chọn lịch đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tác'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.AssignedToUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí dự kiến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.ScheduleAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khóa đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.TrainingCourseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.TrainingFieldName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã lịch đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.TrainingScheduleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.TrainingTypeName',  @FormID, @LanguageValue, @Language;

