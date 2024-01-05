-----------------------------------------------------------------------------------------------------
-- Script tạo message - S
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(5),
@FormID VARCHAR(50),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),
@LanguageCustomValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT

/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'vi-VN';
SET @ModuleID = 'S';
SET @FormID = 'SF3017';

SET @LanguageValue = N'Thiết lập xét duyệt';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3017.Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Điều kiện áp dụng';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3017.IsApplyCondition' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Chưa thiết lập';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3017.NotYetSetup' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Đã thiết lập';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3017.AlreadySetup' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Thiết lập theo';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3017.ApplyBy' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Số cấp';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3017.Levels' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Điều kiện duyệt';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3017.ConditionForApplying' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Duyệt từ dưới lên theo SĐTC';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3017.DirectionTypeFromBottom' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Duyệt từ trên xuống theo SĐTC';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3017.DirectionTypeFromTop' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'STT';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3017.RowNum' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Loại phép';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3017.Name' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Loại xét duyệt';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3017.ScreenHeader' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Thiết lập theo';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3017.ConditionTypeID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Điều kiện duyệt';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3017.IsAppCondition' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Điều kiện áp dụng';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3017.IsApplyCondition' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Số người kiểm tra';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3017.SameLevels' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;