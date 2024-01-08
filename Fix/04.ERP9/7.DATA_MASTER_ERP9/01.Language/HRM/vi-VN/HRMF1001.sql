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
SET @FormID = 'HRMF1001'

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1001.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1001.ResourceID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1001.ResourceName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1001.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1001.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = NULL
EXEC ERP9AddLanguage @ModuleID, 'HRMF1001.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = NULL
EXEC ERP9AddLanguage @ModuleID, 'HRMF1001.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = NULL
EXEC ERP9AddLanguage @ModuleID, 'HRMF1001.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = NULL
EXEC ERP9AddLanguage @ModuleID, 'HRMF1001.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1001.Note',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Cập nhật nguồn tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1001.Title',  @FormID, @LanguageValue, @Language;