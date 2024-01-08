
-----------------------------------------------------------------------------------------------------
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
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2071';

SET @LanguageValue = N'Cập nhật kế hoạch đào tạo định kỳ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kế hoạch ĐT định kỳ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.TrainingPlanID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.AssignedToUserName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Toàn bộ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.IsAll' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lĩnh vực đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.TrainingFieldName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.StartDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian khóa đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.DurationPlan' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lần lặp lại';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.RepeatTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiệu lực';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.RepeatTimeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.DepartmentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lĩnh vực';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.TrainingFieldID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên lĩnh vực';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.TrainingFieldName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.RepeatTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lần';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.RepeatTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.RepeatTime.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời hạn hiệu lực';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2071.RepeatTimeName.CB' , @FormID, @LanguageValue, @Language;

