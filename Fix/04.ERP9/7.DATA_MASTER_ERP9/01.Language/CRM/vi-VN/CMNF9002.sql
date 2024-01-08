------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CMNF9002 - CRM 
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CMNF9002';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Chọn sơ đồ tuyến';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9002.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tuyến';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9002.RouteID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tuyến';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9002.RouteName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Mã nhân viên';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9002.EmployeeID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Tên nhân viên';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9002.EmployeeName' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Diễn giải';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9002.Description' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Thứ tự hiển thị';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9002.StationOrder' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Mã địa điểm';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9002.StationID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tên địa điểm';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9002.StationName' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Địa chỉ';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9002.Address' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Đường';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9002.Street' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Phường/Xã';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9002.Ward' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Quận/Huyện';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9002.District' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Ghi chú';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9002.Notes' , @FormID, @LanguageValue, @Language;








