-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2080- SO
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF2084';

SET @LanguageValue = N'Xét duyệt file thiết kế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2084.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2084.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2084.ApprovedPerson01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File thiết kế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2084.AttachName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2084.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2084.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2084.OffSetStatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2084.OffSetStatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm dán công đoạn Dán/ĐK';
EXEC ERP9AddLanguage @ModuleID, 'SOF2084.GluingTypeName', @FormID, @LanguageValue, @Language;
