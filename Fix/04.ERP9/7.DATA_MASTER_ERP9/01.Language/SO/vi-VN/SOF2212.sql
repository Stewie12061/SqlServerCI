-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2212- SO
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF2212';

SET @LanguageValue = N'Xem chi tiết kích hoạt bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.ThongTinChung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.TabCRMT00002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số seri';
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.SeriNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản T-Card';
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.TAccount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kích hoạt bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.TAccountNumber' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kích hoạt bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.TAccountDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ và tên khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.Enduser' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số nhà'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.Apartment' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đường'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.Road' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phường/Xã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.Ward' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quận huyện';
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.District' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/Thành phố';
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.Province' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản D-Card';
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.DAccount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kích hoạt D-card';
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.DAccountNumber' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kích hoạt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.DAccountDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2212.Description',  @FormID, @LanguageValue, @Language;