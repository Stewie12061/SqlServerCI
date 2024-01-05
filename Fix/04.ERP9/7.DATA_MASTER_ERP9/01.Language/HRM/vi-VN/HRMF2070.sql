
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
SET @FormID = 'HRMF2070';

SET @LanguageValue = N'Danh mục kế hoạch đào tạo định kỳ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2070.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2070.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã KHĐT định kỳ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2070.TrainingPlanID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2070.FromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2070.ToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2070.AssignedToUserName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng duyệt';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2070.IsConfirmName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2070.CreateDate' , @FormID, @LanguageValue, @Language;
