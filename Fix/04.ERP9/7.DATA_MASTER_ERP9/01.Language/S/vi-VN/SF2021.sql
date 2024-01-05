-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2021- S
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
SET @ModuleID = 'S';
SET @FormID = 'SF2021';

SET @LanguageValue = N'Cập nhật rules';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã rules';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.RuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều kiện lọc';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.FilterCondition', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung lọc';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.FilterContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màn hình nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ScreenID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên rules';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.RuleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều kiện lọc';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.FilterConditionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ModuleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màn hình nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ScreenName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.VoucherBusiness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.VoucherBusinessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.TableName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ModuleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ModuleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã màn hình';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ScreenID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên màn hình';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ScreenName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dữ liệu lọc';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.TabST2021', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dữ liệu đích';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.TabST2022', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.DescriptionDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.AbsentTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Toán tử';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.Operator', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.Vaule', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại Rules';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.TypeRules', @FormID, @LanguageValue, @Language;


