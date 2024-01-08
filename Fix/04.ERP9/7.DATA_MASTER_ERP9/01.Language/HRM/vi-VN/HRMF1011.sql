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
SET @FormID = 'HRMF1011'

SET @LanguageValue  = N'Mã hình thức PV'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.InterviewTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hình thức chi tiết'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.DetailTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định dạng kết quả'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.ResultFormatName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định dạng kết quả'
EXEC ERP9AddLanguage @ModuleID, 'HRMT1011.ResultFormatName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến giá trị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.ToValue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ giá trị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.FromValue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hình thức phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.InterviewTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cập nhật hình thức phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.Title',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Mã phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1011.DutyName.CB',  @FormID, @LanguageValue, @Language;
