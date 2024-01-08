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
SET @FormID = 'SHMF1022';

SET @LanguageValue = N'Xem chi tiết đợt phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin đợt phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết đợt phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.Attacth.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.History.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đợt phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.SHPublishPeriodID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên đợt phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.SHPublishPeriodName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ngày phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.SHPublishPeriodDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.SharedTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.ShareTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.ShareTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.ShareTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.Disabled', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.IsCommon', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Phân loại cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.SharedKindName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Giá phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.Amount', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Số năm hạn chế chuyển nhượng';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.LimitTransferYear', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.CreateDate', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ngày chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'SHMF1022.LastModifyDate', @FormID, @LanguageValue, @Language;