-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF1101- EDM
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
SET @ModuleID = 'EDM';
SET @FormID = 'EDMF1101';

SET @LanguageValue = N'Cập nhật khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1101.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1101.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1101.PromotionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1101.PromotionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày áp dụng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1101.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1101.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1101.PromotionType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1101.ReceiptTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1101.Value', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1101.ReceiptTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng còn lại';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1101.RemainQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1101.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1101.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1101.ReceiptTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1101.ReceiptTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hình thức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1101.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1101.Description.CB', @FormID, @LanguageValue, @Language;