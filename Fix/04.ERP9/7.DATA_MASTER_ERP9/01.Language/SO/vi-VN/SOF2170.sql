-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2170- SO
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
SET @FormID = 'SOF2170';

SET @LanguageValue = N'Điều phối giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2170.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2170.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã điều phối';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2170.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xe'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2170.Car' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên/Tài xế'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2170.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tuyến'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2170.Route' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2170.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2170.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2170.OrderNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2170.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2170.DeliveryDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày điều phối'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2170.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2170.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2170.Notes' , @FormID, @LanguageValue, @Language;

