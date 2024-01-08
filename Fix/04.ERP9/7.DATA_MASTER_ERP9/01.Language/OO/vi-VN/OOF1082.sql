-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1082- OO
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
SET @FormID = 'OOF1082';

SET @LanguageValue = N'Xem chi tiết quy định giờ công vi phạm';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số giờ công trễ';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.NumberHourLate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức phạt (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.PunishRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin quy định mức phạt';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.ThongTinQuyDinhMucPhat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết quy định mức phạt';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.ThongTinChiTietQuyDinhMucPhat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch Sử';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính Kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phạt cố tình vi phạm (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.PunishViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bảng';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.TableName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bảng';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.TableViolatedID', @FormID, @LanguageValue, @Language;

--- Modified by Trọng Kiên on 06/11/2020: Bổ sung ngôn ngữ cột StatusID, Description
SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.Description', @FormID, @LanguageValue, @Language;