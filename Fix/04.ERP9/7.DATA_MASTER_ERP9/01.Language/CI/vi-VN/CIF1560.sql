-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1560-CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1560';

IF EXISTS (SELECT * FROM CustomerIndex WHERE CustomerName = 166)
BEGIN
	SET @LanguageValue = N'Đơn vị';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.DivisionID', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Mã xe';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.AssetID', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Tên xe';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.AssetName', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Biển số xe';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.CarNumber', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Tuyến chính';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.MainRouteID', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Mã tài xế phụ trách';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.EmployeeID', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Tải trọng';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.Weight', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Kích thước thùng';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.Height', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Chiều dài thùng';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.Length', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Độ rộng thùng';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.Width', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Giờ bắt đầu';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.DeliveryStart', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Giờ kết thúc';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.DeliveryEnd', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Giờ cho hôm sau';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.IsNextDay', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Thể tích';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.Volume', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Diễn giải';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.Notes', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Dùng chung';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.IsCommon', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Tài xế phụ trách';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.EmployeeID', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Người tạo';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.CreateUserID', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Ngày tạo';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.CreateDate', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Người sửa';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.LastModifyUserID', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Ngày sửa';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.LastModifyDate', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Danh mục thông tin xe vận chuyển';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.Title', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Mã tuyến phụ';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1560.SubRouteID', @FormID, @LanguageValue, @Language;
------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
END