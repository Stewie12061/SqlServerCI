
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
SET @FormID = 'HRMF2001';

SET @LanguageValue = N'Kế hoạch tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế hoạch tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.RecruitPlanID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vị trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.DutyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vị trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.DutyName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.FromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.ToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.StatusName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi làm việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.WorkPlace' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức làm việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.WorkType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức làm việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.WorkTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian cần nhân sự';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.RequireDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi phí dự kiến';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.RecruitCost' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.Note' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.DepartmentName.CB' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã vị trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.DutyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên vị trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.DutyName.CB' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.Quantity' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã hình thức làm việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.ID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hình thức làm việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.WorkType.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí dự kiến';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.TotalCost' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tập tin đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.Attach' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi phí hiện có';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.ActualCost' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi phí định biên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.CostBoundary' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng hiện có';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.ActualQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng định biên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.QuantityBoundary' , @FormID, @LanguageValue, @Language;