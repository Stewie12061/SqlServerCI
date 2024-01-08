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
SET @FormID = 'LMF1020'

SET @LanguageValue  = N'Danh sách tài sản thế chấp'
EXEC ERP9AddLanguage @ModuleID, 'LMF1020.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'LMF1020.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'LMF1020.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tài sản'
EXEC ERP9AddLanguage @ModuleID, 'LMF1020.AssetID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn tài sản'
EXEC ERP9AddLanguage @ModuleID, 'LMF1020.SourceID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn tài sản'
EXEC ERP9AddLanguage @ModuleID, 'LMF1020.SourceName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tài sản'
EXEC ERP9AddLanguage @ModuleID, 'LMF1020.AssetName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hiệu lực'
EXEC ERP9AddLanguage @ModuleID, 'LMF1020.ValidDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'LMF1020.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị sổ sách'
EXEC ERP9AddLanguage @ModuleID, 'LMF1020.AccountingValue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hạn mức vay'
EXEC ERP9AddLanguage @ModuleID, 'LMF1020.LoanLimitRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị hạn mức vay'
EXEC ERP9AddLanguage @ModuleID, 'LMF1020.LoanLimitAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'LMF1020.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị'
EXEC ERP9AddLanguage @ModuleID, 'LMF1020.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'LMF1020.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'LMF1020.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa'
EXEC ERP9AddLanguage @ModuleID, 'LMF1020.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa'
EXEC ERP9AddLanguage @ModuleID, 'LMF1020.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị thẩm định'
EXEC ERP9AddLanguage @ModuleID, 'LMF1020.EvaluationValue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'LMF1020.StatusName',  @FormID, @LanguageValue, @Language;

