-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1081- OO
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
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'vi-VN' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF1081';

SET @LanguageValue = N'Cập nhật quy định giờ công vi phạm';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thiết lập quy định giờ công vi phạm';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.Title_DTI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bảng';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.TableViolatedID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bảng';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.TableName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phần trăm số giờ trễ ';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.NumberHourLate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức Phạt (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.PunishRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phạt cố tình vi phạm (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1081.PunishViolated', @FormID, @LanguageValue, @Language;

