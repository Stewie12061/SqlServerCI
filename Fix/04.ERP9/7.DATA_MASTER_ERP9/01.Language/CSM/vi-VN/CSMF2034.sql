-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2034- CSM
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
SET @ModuleID = 'CSM';
SET @FormID = 'CSMF2034';

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2034.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2034.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng sửa chữa tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2034.QuantityMax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng máy đang chờ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2034.QuantityWaiting', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng máy chưa sửa xong';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2034.QuantityNotFix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số lượng chưa hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2034.QuantityUnfinished', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng máy chưa test xong';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2034.QuantityNotTest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng sẵn sàng nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2034.QuantityReady', @FormID, @LanguageValue, @Language;

