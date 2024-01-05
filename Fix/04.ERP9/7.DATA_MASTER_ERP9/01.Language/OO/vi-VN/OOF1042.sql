-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1042- OO
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
SET @FormID = 'OOF1042';

SET @LanguageValue = N'Xem chi tiết trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ tự hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màu';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.Color', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.StatusType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'Ghi chú', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'Lịch sử', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'Thông tin chung', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên trạng thái English';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.StatusNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái hệ thống';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.SystemStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.XemChiTietTrangThai', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.GhiChu', @FormID, @LanguageValue, @Language;