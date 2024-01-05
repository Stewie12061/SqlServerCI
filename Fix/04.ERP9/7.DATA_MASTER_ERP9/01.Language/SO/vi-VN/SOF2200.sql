-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2200- SO
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
SET @FormID = 'SOF2200';

SET @LanguageValue = N'Danh mục tài khoản kích hoạt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2200.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2200.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản kích hoạt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2200.AccountNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tài khoản kích hoạt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2200.AccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SĐT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2200.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại kích hoạt'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2200.Type' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tài khoản'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2200.AccountType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CCCD/CMND'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2200.CCCD' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2200.BirthDay' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2200.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh thành';
EXEC ERP9AddLanguage @ModuleID, 'SOF2200.Province' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quận huyện';
EXEC ERP9AddLanguage @ModuleID, 'SOF2200.District' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MST cá nhân';
EXEC ERP9AddLanguage @ModuleID, 'SOF2200.MstNumber' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kích hoạt tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'SOF2200.AccountDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'SOF2200.Status' , @FormID, @LanguageValue, @Language;

