

------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0000 - POS
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
SET @ModuleID = 'POS';
SET @FormID = 'POSF0121';


SET @LanguageValue = N'Cập nhật mức hoa hồng theo doanh thu lũy kế';
EXEC ERP9AddLanguage @ModuleID, 'POSF0121.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF0121.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0121.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ doanh thu';
EXEC ERP9AddLanguage @ModuleID, 'POSF0121.FromIncome' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến doanh thu';
EXEC ERP9AddLanguage @ModuleID, 'POSF0121.ToIncome' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức hoa hồng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0121.CommissionRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'POSF0121.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'POSF0121.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'POSF0121.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'POSF0121.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'POSF0121.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POSF0121.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POSF0121.LastModifyUserID' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;