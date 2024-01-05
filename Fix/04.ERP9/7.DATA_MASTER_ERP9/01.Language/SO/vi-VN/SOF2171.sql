-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2171- SO
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
SET @FormID = 'SOF2171';

SET @LanguageValue = N'Cập nhật điều phối giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khóa xe';
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.Lock' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã xe'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.Car' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vận chuyển'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.Transport' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bắt đầu giao'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.BeginDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian kết thúc'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.EndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên/Tài xế'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.OrderNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.Quantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tuyến'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.Route' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.DeliveryDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoảng cách (Km)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.Distance' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lưu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.lblBtnSave' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lưu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2171.lblBtnSave' , @FormID, @LanguageValue, @Language;


