
------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0000 - POS
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
SET @ModuleID = 'POS';
SET @FormID = 'POSF0091';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------


SET @LanguageValue = N'Duyệt hàng khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.DivisionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.ShopName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.MemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.MemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.StatusName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.ConfirmUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.ConfirmUserName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.ConfirmDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.CreateUserName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.LastModifyUserName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.IsConfirm' , @FormID, @LanguageValue, @Language;

----------------------- Grid ---------------------------------------------------

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.ActualQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CA';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.CA' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hàng khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.PromoteInventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng đề xuất';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.SuggestInventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá đề xuất';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.SuggestUnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CA đề xuất';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.SuggestCA' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.NotesConfirm' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.IsConfirm' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.SalesManName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên thu ngân';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duyệt';
EXEC ERP9AddLanguage @ModuleID, 'POSF0091.IsConfirmDetail' , @FormID, @LanguageValue, @Language;



------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;