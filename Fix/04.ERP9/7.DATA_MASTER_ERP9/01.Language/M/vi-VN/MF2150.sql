-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2150- M
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
SET @FormID = 'MF2150';

SET @LanguageValue = N'Danh mục dự trù chi phí sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2150.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2150.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày vật tư';
EXEC ERP9AddLanguage @ModuleID, 'MF2150.SuppliesDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'MF2150.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2150.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2150.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'MF2150.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'MF2150.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2150.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2150.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái phiếu';
EXEC ERP9AddLanguage @ModuleID, 'MF2150.StatusID', @FormID, @LanguageValue, @Language;

