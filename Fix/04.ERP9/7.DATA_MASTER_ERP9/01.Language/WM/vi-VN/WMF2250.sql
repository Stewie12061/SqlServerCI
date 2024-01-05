
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2250 - WM
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
SET @ModuleID = 'WM';
SET @FormID = 'WMF2250';

SET @LanguageValue = N'Điều chỉnh kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2250.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'WMF2250.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2250.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2250.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho kiểm kê';
EXEC ERP9AddLanguage @ModuleID, 'WMF2250.WareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại kiểm kê';
EXEC ERP9AddLanguage @ModuleID, 'WMF2250.KindVoucherID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'WMF2250.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hạch toán';
EXEC ERP9AddLanguage @ModuleID, 'WMF2250.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'WMF2250.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người lập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2250.EmployeeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người lập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2250.EmployeeName.CB' , @FormID, @LanguageValue, @Language;