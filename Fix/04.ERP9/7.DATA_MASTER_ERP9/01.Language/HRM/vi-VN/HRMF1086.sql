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
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1086'

SET @LanguageValue  = N'Cập nhật định nghĩa phân loại mã quyết định thôi việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.STypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân loại'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.S',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân loại'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.SName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hiển thị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'1. Phân loại'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.PhanLoai1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'2. Phân loại'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.PhanLoai2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'3. Phân loại'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.PhanLoai3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chỉnh sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người chỉnh sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.LastModifyUserID',  @FormID, @LanguageValue, @Language;
