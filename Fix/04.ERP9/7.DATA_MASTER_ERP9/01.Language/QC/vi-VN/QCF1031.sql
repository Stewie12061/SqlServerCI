-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF1031- QC
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
SET @ModuleID = 'QC';
SET @FormID = 'QCF1031';

SET @LanguageValue = N'Cập nhật lý do';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.DepartmentName.CB', @FormID, @LanguageValue, @Language

SET @LanguageValue = N'Mã công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.PhaseIDSetting.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.PhaseNameSetting.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên lý do';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.ReasonName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lý do';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.ReasonID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'QCF1031.IsCommon', @FormID, @LanguageValue, @Language;
