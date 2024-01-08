
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
SET @FormID = 'HRMF2002';

SET @LanguageValue = N'Xem chi tiết kế hoạch tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế hoạch tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.RecruitPlanID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vị trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.DutyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.FromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.ToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.StatusName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi làm việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.WorkPlace' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức làm việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.WorkTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian cần nhân sự';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.RequireDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi phí dự kiến';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.RecruitCost' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin kế hoạch tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.TabThongTinKeHoachTuyenDung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.TabThongTinChiTiet' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.TabCRMT00001' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.TabCRMT00002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.TabCRMT00003' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.Quantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí dự kiến';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.TotalCost' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.DutyName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi phí hiện có';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.ActualCost' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi phí định biên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.CostBoundary' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SLKH theo đợt';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.ActualQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng định biên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.QuantityBoundary' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.StatusID' , @FormID, @LanguageValue, @Language;

