-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ 
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2113';

SET @LanguageValue = N'Kế thừa yêu cầu khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã market';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.MarketID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KT dài';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KT rộng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KT cao';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số màu in mặt 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số màu in mặt 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.SideColor2', @FormID, @LanguageValue, @Language;

-- Đình Hòa [27/04/2021] - Bổ sung ngôn ngữ
SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.PaperTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.KindSupplierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đvt Con bộ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.UnitSizeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cách in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.PrintTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chạy giấy';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.RunPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sóng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.RunWavePaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.MoldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày khuôn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.MoldDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Version';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2113.BOMVersion', @FormID, @LanguageValue, @Language;
