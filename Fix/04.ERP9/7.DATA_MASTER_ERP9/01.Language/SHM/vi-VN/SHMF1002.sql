-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SHMF1002- SHM
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
SET @ModuleID = 'SHM';
SET @FormID = 'SHMF1002';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhóm';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1002.ShareHolderCategoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhóm';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1002.ShareHolderCategoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1002.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1002.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1002.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết nhóm cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin nhóm cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1002.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1002.History', @FormID, @LanguageValue, @Language;

