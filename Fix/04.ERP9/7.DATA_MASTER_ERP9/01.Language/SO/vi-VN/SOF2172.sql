-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2172- SO
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
SET @FormID = 'SOF2172';

SET @LanguageValue = N'Chọn xe';
EXEC ERP9AddLanguage @ModuleID, 'SOF2172.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã xe'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2172.AssetID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tuyến chính'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2172.MainRoute' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tuyến phụ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2172.SubRoute' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên/Tài xế'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2172.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian bắt đầu lượt giao hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2172.DeliveryStart' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian kết thúc lượt giao hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2172.DeliveryEnd' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trọng tải'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2172.Weight' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiều cao'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2172.Height' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiều dài'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2172.Length' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiều rộng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2172.Width' , @FormID, @LanguageValue, @Language;


