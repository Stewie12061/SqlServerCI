-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1046- KPI
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
SET @FormID = 'KPIF1046';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tham số';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.ParameterID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tham số';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.ParameterName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết tham số';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin tham số tính chỉ tiêu KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.TabParameterInformation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.TabCRMT00002', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.TabCRMT90031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1046.TabCRMT00003', @FormID, @LanguageValue, @Language;