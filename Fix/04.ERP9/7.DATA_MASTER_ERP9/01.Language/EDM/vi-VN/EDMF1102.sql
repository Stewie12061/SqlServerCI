-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF1102- EDM
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
SET @FormID = 'EDMF1102';

SET @LanguageValue = N'Chi tiết khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.PromotionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.PromotionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày áp dụng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.PromotionType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.ReceiptTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.Value', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.ReceiptTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng còn lại';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.RemainQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.Value', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.ReceiptTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.ReceiptTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hình thức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.Master.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.Attach.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1102.History.GR', @FormID, @LanguageValue, @Language;