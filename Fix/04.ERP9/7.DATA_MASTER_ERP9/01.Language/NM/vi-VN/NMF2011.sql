-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ NMF2011- NM
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
SET @ModuleID = 'NM';
SET @FormID = 'NMF2011';

SET @LanguageValue = N'Cập nhật thực đơn ngày';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày thực đơn';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.MenuVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số thực đơn';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.MenuVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm thực đơn';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.MenuTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm thực đơn';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.MenuTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thực đơn tổng';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành phần dinh dưỡng';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.Nutrition', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin bữa ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.Meal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.SystemName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành phần';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.Ingredient', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định mức';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.QuotaStandard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ lệ đạt(%)';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.Ratio', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.MaterialsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.ConvetedQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.ServiceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá/người';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhóm thực đơn';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.MenuTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhóm thực đơn';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.MenuTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thực phẩm';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.TabNMT2013', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'NMF2011.TabNMT2014', @FormID, @LanguageValue, @Language;