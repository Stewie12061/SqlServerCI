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
SET @FormID = 'SHMF1021';

SET @LanguageValue = N'Cập nhật đợt phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1021.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đợt phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1021.SHPublishPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đợt phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1021.SHPublishPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1021.SHPublishPeriodDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1021.ShareTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1021.ShareTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1021.ShareTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1021.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1021.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1021.SharedKindName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1021.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1021.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1021.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số năm hạn chế chuyển nhượng';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1021.LimitTransferYear', @FormID, @LanguageValue, @Language;
