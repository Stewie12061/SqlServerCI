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
SET @FormID = 'SF3018';

SET @LanguageValue = N'Chi tiết xét duyệt';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Điều kiện áp dụng';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.IsApplyCondition' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Thiết lập theo';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.ApplyBy' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Số cấp';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.Levels' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Điều kiện duyệt';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.ConditionForApplying' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Duyệt từ dưới lên theo SĐTC';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.DirectionTypeFromBottom' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Duyệt từ trên xuống theo SĐTC';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.DirectionTypeFromTop' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'STT';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.RowNum' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Loại phép';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.Name' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Thiết lập theo';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.ConditionTypeID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Trường hợp';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.CaseID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Loại xét duyệt';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.ApproveTypeID1' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Thứ tự cấp';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.LevelNo' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Điều kiện duyệt từ >=';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.ConditionFrom' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Điều kiện duyệt đến <=';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.ConditionTo' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Điều kiện duyệt';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.IsAppCondition' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Điều kiện duyệt';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.DataTypeID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Phòng ban xét duyệt';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.DepartmentID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Mã loại';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.ApproveTypeID.CB' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Tên tên loại';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.ApproveTypeName.CB' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Mã phòng ban';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.DepartmentID.CB' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Tên phòng ban';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.DepartmentName.CB' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Là người kiểm tra';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF3018.IsSameLevels' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;