-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SHMF1011- SHM
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
SET @FormID = 'SHMF1011';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1011.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1011.ShareTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1011.ShareTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1011.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức ưu đãi';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1011.PreferentialDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều kiện chuyển nhượng';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1011.TransferCondition', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số năm hạn chế';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1011.LimitTransferYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1011.SharedKind', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1011.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1011.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1011.SharedKindName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật loại cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cổ phần phổ thông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1011.CommonShare', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cổ phần ưu đãi';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1011.PreferenceShares', @FormID, @LanguageValue, @Language;

