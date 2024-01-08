-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2023- CSM
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
SET @ModuleID = 'CSM';
SET @FormID = 'CSMF2023';

SET @LanguageValue = N'Cập nhật thông tin sửa chữa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu sửa chữa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.DispatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái phiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.GSXStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên KT';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.TechEmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian KT nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.TechReceiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm lỗi';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.SymptomGroup', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lỗi';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.WHSymptomCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lỗi chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.WHIssueCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng lỗi';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.WHModifierCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú Escalation';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.RequoteNote', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú sửa chữa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.RepairNote', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin sửa chữa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Checklist test kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.Checklist', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung kiểm tra';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.DataName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'COMPTIA';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.CompTIA', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đạt';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.Pass', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không đạt';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.Fail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhóm lỗi';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.SymptomGroupID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhóm lỗi';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.SymptomGroupName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lỗi';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.SymptomCode.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên lỗi';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.SymptomName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.ModifierCode.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.ModifierName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lỗi chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.IssueCode.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mã lỗi chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.IssueName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2023.Description.CB', @FormID, @LanguageValue, @Language;

