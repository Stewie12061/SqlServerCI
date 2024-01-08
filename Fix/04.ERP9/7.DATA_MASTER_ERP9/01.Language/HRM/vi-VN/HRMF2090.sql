-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2090- OO
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
SET @FormID = 'HRMF2090'

SET @LanguageValue  = N'Danh mục đề xuất đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.AssignedToUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attach'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.Attach',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Date'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.Date',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description1'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.Description1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description2'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.Description2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.Description3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'InheritID1'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.InheritID1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'InhertiID2'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.InheritID2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'InheritName'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.InheritName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsAll'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.IsAll',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'LastModifyDate'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'LastModifyUserID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí đề xuất'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.ProposeAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đề xuất đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.TrainingProposeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.DepartmentName.CB',  @FormID, @LanguageValue, @Language;