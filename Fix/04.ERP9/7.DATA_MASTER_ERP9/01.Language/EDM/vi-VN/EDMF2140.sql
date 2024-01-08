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
SET @ModuleID = 'EDM';
SET @FormID = 'EDMF2140';

SET @LanguageValue = N'Điều chuyển học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.DivisionID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Số điều chuyển';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.TranferStudentNo', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ngày điều chuyển';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.FromDateTranfer', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.ToDateTranfer', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.ProponentID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.StudentID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Trường chuyển đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.SchoolIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.ProponentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường chuyển đi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường chuyển đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.SchoolNameTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiệu lực từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.FromEffectiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiệu lực đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.ToEffectiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lý do';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.Reason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.CreateUserID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.CreateUserName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày điều chuyển';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.DateTranfer', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Phiếu thông tin chuyển cơ sở';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2140.Report', @FormID, @LanguageValue, @Language;