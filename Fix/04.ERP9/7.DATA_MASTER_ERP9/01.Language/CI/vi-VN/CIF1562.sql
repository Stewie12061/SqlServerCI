-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1562-CI
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
SET @FormID = 'CIF1562';

IF EXISTS (SELECT * FROM CustomerIndex WHERE CustomerName = 166)
BEGIN
	SET @LanguageValue = N'Đơn vị';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.DivisionID', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Mã xe';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.AssetID', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Tên xe';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.AssetName', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Biển số xe';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.CarNumber', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Tuyến chính';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.MainRouteID', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Mã tài xế phụ trách';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.EmployeeID', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Tải trọng';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.Weight', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Kích thước thùng';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.Height', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Chiều dài thùng';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.Length', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Độ rộng thùng';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.Width', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Giờ bắt đầu';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.DeliveryStart', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Giờ kết thúc';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.DeliveryEnd', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Giờ cho hôm sau';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.IsNextDay', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Thể tích';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.Volume', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Diễn giải';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.Notes', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Tài xế phụ trách';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.EmployeeID', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Dùng chung';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.IsCommon', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Người tạo';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.CreateUserID', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Ngày tạo';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.CreateDate', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Người sửa';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.LastModifyUserID', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Ngày sửa';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.LastModifyDate', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Chi tiết thông tin xe vận chuyển';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.Title', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Mã tuyến phụ';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.SubRouteID', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Thông tin chung';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.Info', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Thông tin chi tiết';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.Detail', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Đính kèm';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.Attacth.GR', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Ghi chú';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.Notes.GR', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Lịch sử';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.History.GR', @FormID, @LanguageValue, @Language;

	SET @LanguageValue = N'Tên nhân viên';
	EXEC ERP9AddLanguage @ModuleID, 'CIF1562.EmployeeName', @FormID, @LanguageValue, @Language;
------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
END