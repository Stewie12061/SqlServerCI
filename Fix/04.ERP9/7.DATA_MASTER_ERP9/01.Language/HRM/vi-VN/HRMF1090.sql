-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1090- HRM
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
SET @FormID = 'HRMF1090'

SET @LanguageValue  = N'Danh mục chấm công ngày/tháng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chấm công'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.AbsentTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hiển thị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.AbsentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại công'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.IsMonth',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chấm công'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.IsMonthName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.Edit',  @FormID, @LanguageValue, @Language;
---Ngôn ngữ combobox
SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.UnitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.UnitName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.TypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại chấm công'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.TypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.ProbationaryID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại công thử việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.ProbationaryName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.ParentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại chấm công'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.ParentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại chấm công'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.ParentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.IsMonth.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại công'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.IsMonthName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.DivisionID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1090.DivisionName.CB',  @FormID, @LanguageValue, @Language;
