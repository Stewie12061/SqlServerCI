-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2022- S
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
SET @FormID = 'SF2022';

SET @LanguageValue = N'Xem chi tiết rules';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã rules';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.RuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều kiện lọc';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.FilterCondition', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung lọc';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.FilterContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màn hình nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ScreenID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên rules';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.RuleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều kiện lọc';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.FilterConditionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ModuleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màn hình nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ScreenName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.VoucherBusiness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.VoucherBusinessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.TableName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin điều kiện rules';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ThongTinDieuKienRules', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin dữ liệu đích';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ThongTinDuLieuDich', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin rules';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ThongTinRules', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại Rule';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.TypeRulesName', @FormID, @LanguageValue, @Language;
