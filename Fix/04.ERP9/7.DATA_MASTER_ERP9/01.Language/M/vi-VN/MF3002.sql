
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF0203- OO
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
SET @ModuleID = 'M';
SET @FormID = 'MF3002';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF3002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'MF3002.FromDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'MF3002.ToDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF3002.FromInventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF3002.ToInventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả sản xuất trong khoảng thời gian báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'MF3002.IsBetweenReport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả sản xuất đến thời điểm hiện tại';
EXEC ERP9AddLanguage @ModuleID, 'MF3002.IsToNow', @FormID, @LanguageValue, @Language;

