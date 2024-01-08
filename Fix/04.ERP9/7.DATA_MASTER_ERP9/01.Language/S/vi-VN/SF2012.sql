-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2012- S
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
SET @ModuleID = 'S';
SET @FormID = 'SF2012';

------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Xem chi tiết PipeLine';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.Title' , @FormID, @LanguageValue, @Language;
------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.ThongTinMaster' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách điều kiện';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.DanhSachDieuKienKichHoat' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách hành động';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.DanhSachHanhDong' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã PipeLine';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.PipeLineID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên PipeLine';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.PipeLineName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng Thái';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.StatusID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sự kiện kích hoạt';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.ConditionTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sự kiện kích hoạt';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.ConditionTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.RefObject' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.RefObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.ConditionObject' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều kiện';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.Operation' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.ConditionValue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hành động';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.ActionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.GhiChu' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.DinhKem' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bắt buộc';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.IsRequired' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hành động kích hoạt';
EXEC ERP9AddLanguage @ModuleID, 'SF2012.ActionActive' , @FormID, @LanguageValue, @Language;