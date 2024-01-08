------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MTF0070 - MT
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
SET @FormID = 'POSF2040';

SET @LanguageValue = N'Danh mục chốt ca bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2040.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'POSF2040.FromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'POSF2040.ToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kỳ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2040.Period' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2040.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ca bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2040.ShipID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên  bàn giao';
EXEC ERP9AddLanguage @ModuleID, 'POSF2040.EmployeeID1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh thu tiền mặt';
EXEC ERP9AddLanguage @ModuleID, 'POSF2040.SysAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chốt ca';
EXEC ERP9AddLanguage @ModuleID, 'POSF2040.ShipDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chốt ca';
EXEC ERP9AddLanguage @ModuleID, 'POSF2040.ShiftDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'POSF2040.UserID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2040.UserName.CB' , @FormID, @LanguageValue, @Language;