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
SET @FormID = 'HRMF1002'

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1002.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1002.ResourceID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nguồn tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1002.ResourceName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1002.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1002.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1002.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1002.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1002.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1002.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1002.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin nguồn tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1002.TabInfo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1002.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xem chi tiết nguồn tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1002.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1002.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1002.TabCRMT00001',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1002.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1002.TabCRMT00002',  @FormID, @LanguageValue, @Language;