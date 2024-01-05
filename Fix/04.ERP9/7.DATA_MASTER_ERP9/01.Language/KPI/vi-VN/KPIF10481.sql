-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF10481- KPI
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
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF10481';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tham số';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.ParameterID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tham số';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.ParameterName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn tham số cho công thức tính chỉ tiêu KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF10481.Title', @FormID, @LanguageValue, @Language;

