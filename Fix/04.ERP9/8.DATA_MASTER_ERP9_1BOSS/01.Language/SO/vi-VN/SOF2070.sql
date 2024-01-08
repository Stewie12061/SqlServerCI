-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2070- SO
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF2070';

SET @LanguageValue = N'Danh mục kế hoạch bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2070.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2070.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2070.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2070.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2070.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật'; 

EXEC ERP9AddLanguage @ModuleID, 'SOF2070.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2070.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2070.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2070.Type' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2070.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2070.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế hoạch năm'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2070.YearPlan' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2070.TypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2070.Type.CB' , @FormID, @LanguageValue, @Language;