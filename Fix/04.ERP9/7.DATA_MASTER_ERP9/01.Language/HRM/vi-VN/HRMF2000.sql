
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
SET @FormID = 'HRMF2000';

SET @LanguageValue = N'Kế hoạch tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế hoạch tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.RecruitPlanID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vị trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.DutyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên vị trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.DutyName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.FromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.ToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.StatusName' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã vị trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.DutyID.CB' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên vị trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.DutyName.CB' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.DepartmentName.CB' , @FormID, @LanguageValue, @Language;