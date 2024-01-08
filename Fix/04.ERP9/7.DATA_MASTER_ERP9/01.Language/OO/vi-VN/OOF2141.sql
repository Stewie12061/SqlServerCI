-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2141- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF2141';

SET @LanguageValue = N'Cập nhật định mức chi phí dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm chi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.CostGroup', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết nhóm chi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.CostGroupDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.Money', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.AnaDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm chi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.CostGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết nhóm chi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.CostGroupDetailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhóm chi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.CostGroupID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhóm chi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.CostGroupName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chi tiết nhóm chi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.CostGroupDetailID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chi tiết nhóm chi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.CostGroupDetailName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.AnaDepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.AnaDepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.AnaDepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu báo giá';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.QuotationID ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phiếu báo giá';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.QuotationNo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phiếu báo giá';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền thực tế';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.ActualMoney', @FormID, @LanguageValue, @Language;
