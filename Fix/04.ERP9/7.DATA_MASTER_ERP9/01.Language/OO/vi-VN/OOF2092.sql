-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2092- OO
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
SET @FormID = 'OOF2092';

SET @LanguageValue = N'Xem chi tiết nội dung thông báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.InformName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hiệu lực';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại thông báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.InformType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.InformDivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập  nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.NoiDung', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết thông báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.XemChiTietThongBao', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung thông báo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.NoiDungThongBao', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.StatusID', @FormID, @LanguageValue, @Language;

