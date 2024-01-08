
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2010- WM
------------------------------------------------------------------------------------------------------
go
delete A00001 where formid = 'wmf2010'
go

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
SET @FormID = 'WMF2010';

SET @LanguageValue = N'Danh mục số dư tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'đến'
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.ToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.WarehouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quản lý theo Serial/IMEI';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.IsSerialized' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'kho nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.WarehouseName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.EmployeeName' , @FormID, @LanguageValue, @Language;


