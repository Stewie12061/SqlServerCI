-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2083- EDM
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
SET @FormID = 'EDMF2083';


SET @LanguageValue = N'Quyết toán';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2083.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2083.VoucherLeaveSchool', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2083.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2083.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nghỉ học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2083.LeaveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày quyết toán';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2083.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tính tiền';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2083.DatePayment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng cộng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2083.Total', @FormID, @LanguageValue, @Language;

