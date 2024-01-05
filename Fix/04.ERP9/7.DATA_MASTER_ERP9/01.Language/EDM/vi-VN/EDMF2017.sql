-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2017- EDM
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
SET @FormID = 'EDMF2017';

SET @LanguageValue = N'Cập nhật trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2017.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học chính thức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2017.Online', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghỉ học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2017.Offline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2017.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2017.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2017.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xếp lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2017.ArrangeClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2017.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2017.LastModifyDate', @FormID, @LanguageValue, @Language;




