-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1032- OO
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
SET @FormID = 'HRMF1022'

SET @LanguageValue  = N'Thông tin định biên tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.TabInfo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã định biên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.BoundaryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết định biên tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.TabInfo1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí định biên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.CostBoundary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.TabCRMT00001',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng định biên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.QuantityBoundary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xem chi tiết định biên tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin định biên tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.TabInfo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.StatusID',  @FormID, @LanguageValue, @Language;
