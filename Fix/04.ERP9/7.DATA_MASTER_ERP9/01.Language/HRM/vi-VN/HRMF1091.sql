-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1091- HRM
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
SET @FormID = 'HRMF1091'

SET @LanguageValue  = N'Cập nhật chấm công ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chấm công'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.AbsentTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hiển thị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.AbsentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chấm công'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.TypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.Caption',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại công thử việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.ProbationaryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thứ tự hiển thị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.Orders',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số công'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.ConvertUnit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức tối đa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.MaxValue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều kiện'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.IsCondition',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ConditionCode'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.ConditionCode',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kết chuyển vào công tháng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.IsTransfer',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ParentID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.ParentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại công'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.IsMonth',  @FormID, @LanguageValue, @Language;
--Ngôn ngữ combobox
SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.UnitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.UnitName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.TypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại chấm công'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.TypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.ProbationaryID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại công thử việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.ProbationaryName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.ParentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại chấm công'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.ParentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại chấm công'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1091.ParentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.IsMonth.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại công'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.IsMonthName.CB',  @FormID, @LanguageValue, @Language;

