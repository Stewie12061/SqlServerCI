-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1032- OO
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


SET @Language = 'vi-VN';
SET @ModuleID = 'LM';
SET @FormID = 'LMF1022'

SET @LanguageValue  = N'Xem chi tiết tài sản thế chấp'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chi tiết'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.SubTitle1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tài sản'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.AssetID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn tài sản'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.SourceID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn tài sản'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.SourceName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tài sản'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.AssetName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hiệu lực'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.ValidDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị sổ sách'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.AccountingValue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hạn mức vay(%)'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.LoanLimitRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị hạn mức vay'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.LoanLimitAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị thẩm định'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.EvaluationValue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.StatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử'
EXEC ERP9AddLanguage @ModuleID, 'LMF1022.TabCRMT00003',  @FormID, @LanguageValue, @Language;
