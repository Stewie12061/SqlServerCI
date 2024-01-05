-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ 
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
SET @FormID = 'SHMF1020';

SET @LanguageValue = N'Danh mục đợt phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1020.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1020.DivisionID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã đợt phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1020.SHPublishPeriodID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên đợt phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1020.SHPublishPeriodName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ngày phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1020.SHPublishPeriodDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1020.ShareTypeIDSearch', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1020.ShareTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1020.ShareTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1020.Disabled', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1020.IsCommon', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Cổ phần ưu đãi';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1020.QuantityPreferredShare', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Cổ phần phổ thông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1020.QuantityCommonShare', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tổng số phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1020.QuantityTotal', @FormID, @LanguageValue, @Language;
