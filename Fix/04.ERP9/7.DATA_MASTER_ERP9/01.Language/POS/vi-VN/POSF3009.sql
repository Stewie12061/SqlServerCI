------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MTF0070 - MT
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
SET @FormID = 'POSF3009';

DECLARE @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang CustomerIndex 
--CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
--INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM dbo.CustomerIndex)
--DROP TABLE #CustomerName


SET @LanguageValue = N'Tổng hợp bán hàng theo mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF3009.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF3009.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF3009.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF3009.EmployeeID' , @FormID, @LanguageValue, @Language;

IF @CustomerName = 87
BEGIN

SET @LanguageValue = N'Từ khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF3009.FromMemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF3009.ToMemberID' , @FormID, @LanguageValue, @Language;

END 
ELSE
BEGIN

SET @LanguageValue = N'Từ hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF3009.FromMemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF3009.ToMemberID' , @FormID, @LanguageValue, @Language;

END

SET @LanguageValue = N'Từ vật tư';
EXEC ERP9AddLanguage @ModuleID, 'POSF3009.FromInventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến vật tư';
EXEC ERP9AddLanguage @ModuleID, 'POSF3009.ToInventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vật tư';
EXEC ERP9AddLanguage @ModuleID, 'POSF3009.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF3009.MemberID' , @FormID, @LanguageValue, @Language;


------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;