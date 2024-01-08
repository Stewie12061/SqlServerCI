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
SET @FormID = 'HRMF1012'

SET @LanguageValue  = N'Mã hình thức PV'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.InterviewTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hình thức chi tiết'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.DetailTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định dạng kết quả'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.ResultFormat',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến giá trị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.ToValue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ giá trị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.FromValue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết hình thức phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.TabInfo1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hình thức phòng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.InterviewTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin hình thức phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.TabInfo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xem chi tiết hình thức phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1012.Title',  @FormID, @LanguageValue, @Language;