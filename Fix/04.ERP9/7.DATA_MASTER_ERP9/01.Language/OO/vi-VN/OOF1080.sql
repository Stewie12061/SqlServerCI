-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1080- OO
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
SET @FormID = 'OOF1080';

SET @LanguageValue = N'Danh mục quy định giờ công vi phạm';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bảng';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.TableName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phạt cố tình vi phạm';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.PunishViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bảng';
EXEC ERP9AddLanguage @ModuleID, 'OOF1080.TableViolatedID', @FormID, @LanguageValue, @Language;
