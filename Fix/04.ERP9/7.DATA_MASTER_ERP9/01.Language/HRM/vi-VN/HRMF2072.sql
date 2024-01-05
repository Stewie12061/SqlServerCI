
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
SET @FormID = 'HRMF2072';

SET @LanguageValue = N'Xem chi tiết kế hoạch đào tạo định kỳ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kế hoạch ĐT định kỳ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.TrainingPlanID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.AssignedToUserName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Toàn bộ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.IsAll' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lĩnh vực đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.TrainingFieldName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.StartDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian khóa đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.DurationPlan' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lần lặp lại';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.RepeatTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiệu lực';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.RepeatTimeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin kế hoạch đào tạo định kỳ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.TabThongKeHoachDaoTaoDinhKy' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết kế hoạch đào tạo định kỳ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.TabChiTietKeHoachDaoTaoDinhKy' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.TabCRMT00003' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.TabGhiChu' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.TabDinhKem' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2072.StatusID' , @FormID, @LanguageValue, @Language;