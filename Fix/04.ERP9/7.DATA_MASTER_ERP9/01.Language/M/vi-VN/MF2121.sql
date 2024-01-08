-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2121- M
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
SET @FormID = 'MF2121';

SET @LanguageValue = N'Cập nhật định mức sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.NodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.NodeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.NodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.NodeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại định lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.QuantitativeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.MaterialGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.MaterialConstant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.NodeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại định lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.QuantitativeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.MaterialConstant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.NodeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.QuantitativeValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên liệu thay thế';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quy trình sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.RoutingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gia công';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.OutsourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Có lập lệnh';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.DictatesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lệnh sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.NodeTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.NodeTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã định lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.QuantitativeTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên định lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.QuantitativeTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhóm';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.MaterialGroupID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhóm';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.MaterialGroupName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.MaterialID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.MaterialName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy trình';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.RoutingID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy trình';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.RoutingName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã gia công';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.OutsourceID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên gia công';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.OutsourceName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lập lệnh';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.DictatesID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên lập lệnh';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.DictatesName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.PhaseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.PhaseName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại kế thừa';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.InheritID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tạo BOM Version';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.CreateBOMVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.InheritID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.InheritName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.InheritName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hao hụt';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.LossValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.DisplayMember', @FormID, @LanguageValue, @Language;

-- Đức Tuyên 22/02/2023: Bổ sung ngôn ngữ Tab
SET @LanguageValue = N'Định mức sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.TabMT2121', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định mức nhân công';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.TabMT2124', @FormID, @LanguageValue, @Language;

--- Đức Tuyên 22/02/2023: Bổ sung ngôn ngữ Tab Định mức nhân công
SET @LanguageValue = N'Mã nhân công';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.LaborID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân công';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.LaborName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.LaborUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định mức thời gian';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.TimeLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Version';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.BomVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Version';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.BomVersion.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đặc tính kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.Specification', @FormID, @LanguageValue, @Language;