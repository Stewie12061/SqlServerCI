-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1012- CRM
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------
------
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1012';

SET @LanguageValue = N'Xem chi tiết khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Là tổ chức';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.IsOrganize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.IsVATAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.IsInvoice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.IsCommonName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngưng sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.IsUsingName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.DisabledName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạn mức nợ cho phép';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.ReCreditLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 01';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.O01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tuyến giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.RouteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngưng sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.IsUsing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.LastModifyUserID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Thông tin khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'GR.ThongTinKhachHang' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.IsCustomer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xưng hô';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Prefix' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.ContactID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.ContactName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Field0187' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.HomeEmail' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Di động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.HomeMobile' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.HomeTel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú đường đi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Description01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhãn hiệu 01';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Description02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhãn hiệu 02';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Description03' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhãn hiệu 03';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Description04' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhãn hiệu 04';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Description05' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chứng từ đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.VoucherAttach' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạn mức vỏ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.BottleLimit' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chu kỳ đặt nước';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.PeriodWater' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Fax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng VAT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.VATAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.Website' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 02';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.O02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 03';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.O03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.TabCRMT00002' , @FormID, @LanguageValue, @Language;	

SET @LanguageValue = N'Mã phân tích 04';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.O04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.TabCRMT90031' , @FormID, @LanguageValue, @Language;	

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.TabCRMT00003' , @FormID, @LanguageValue, @Language;	

SET @LanguageValue = N'Mã phân tích 05';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.O05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sự kiện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.TabCRMT90051' , @FormID, @LanguageValue, @Language;	

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.TabCMNT90051' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.TabOT2101' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.TabCRMT20501' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hành động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.NextActionName',  @FormID, @LanguageValue, @Language;

-- [Bảo Toàn] [Ngày cập nhật: 17/07/2019] [Thêm ngôn ngữ group Công việc]
SET @LanguageValue  = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.TabOOT2110',  @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Liên hệ';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.TabCRMT10102' , @FormID, @LanguageValue, @Language;

-- [Học Huy] [Ngày cập nhật: 22/10/2019] [Thêm ngôn ngữ group Thông tin địa chỉ giao hàng] - Custom MAITHU (MTH)
BEGIN
	SET @LanguageValue  = N'Thông tin địa chỉ giao hàng';
	EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.TabCRMT101011',  @FormID, @LanguageValue, @Language;

	SET @LanguageValue  = N'Địa chỉ';
	EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.DeliveryAddress',  @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Yêu cầu';
	EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.TabCRMT20801' , @FormID, @LanguageValue, @Language;

	SET @LanguageValue  = N'Quốc gia';
	EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.CountryName',  @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Người phụ trách';
	EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.AssignedToUserName' , @FormID, @LanguageValue, @Language;

	SET @LanguageValue  = N'Mã vùng';
	EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.AreaName',  @FormID, @LanguageValue, @Language;

	SET @LanguageValue  = N'Ngành nghề kinh doanh';
	EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.BusinessLinesID',  @FormID, @LanguageValue, @Language;

	SET @LanguageValue  = N'Tỉnh/Thành';
	EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.CityName',  @FormID, @LanguageValue, @Language;

	SET @LanguageValue  = N'Quận/Huyện';
	EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.DistrictName',  @FormID, @LanguageValue, @Language;

	SET @LanguageValue  = N'Phường/xã';
	EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.DeliveryWard',  @FormID, @LanguageValue, @Language;
END

-- [Bảo Toàn] [Ngày cập nhật: 19/11/2019] [Bổ sung ngôn ngữ]
SET @LanguageValue = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.TaskID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên công việc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.TaskName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.StatusName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.PlanStartDate' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.PlanEndDate' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Quy trình';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.ProcessName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Bước';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.StepName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.BankName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tài khoản ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.BankAccountNo' , @FormID, @LanguageValue, @Language;

-- [Học Huy] [Ngày cập nhật: 08/01/2020] [Thêm ngôn ngữ group Cơ hội]
BEGIN
	SET @LanguageValue  = N'Mã cơ hội';
	EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.OpportunityID',  @FormID, @LanguageValue, @Language;

	SET @LanguageValue  = N'Tên cơ hội';
	EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.OpportunityName',  @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Giai đoạn bán hàng';
	EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.StageID' , @FormID, @LanguageValue, @Language;

	SET @LanguageValue  = N'Hành động';
	EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.NextActionID',  @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Độ ưu tiên';
	EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.PriorityID' , @FormID, @LanguageValue, @Language;

	SET @LanguageValue  = N'Người phụ trách';
	EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.AssignedToUserID',  @FormID, @LanguageValue, @Language;
END

-- [Đình Hoà] [Ngày cập nhật: 08/01/2020] [Thêm ngôn ngữ]

 SET @LanguageValue = N'Đơn đặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.TabOT2001' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.TabCRMT20401', @FormID, @LanguageValue, @Language;

--- Modified by Trọng Kiên on 06/11/2020: Bổ sung ngôn ngữ cột IsWholeSale
SET @LanguageValue = N'Bán sỉ/lẻ';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.IsWholeSale', @FormID, @LanguageValue, @Language;

-- [Đình Hoà] [Ngày cập nhật: 22/02/2021] [Thêm ngôn ngữ cho Tab đầu mối]
SET @LanguageValue  = N'Đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.TabCRMT20301',  @FormID, @LanguageValue, @Language;

-- [Đình Hoà] [Ngày cập nhật: 26/05/2021] [Thêm ngôn ngữ cho Tab công ciệc]
SET @LanguageValue  = N'Người hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.SupportUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người giám sát';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.ReviewerUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.ProjectName',  @FormID, @LanguageValue, @Language;

-- [Hoài Bảo] [Ngày cập nhật: 30/08/2021] [Thêm ngôn ngữ cho Tab lịch sử cuộc gọi]
SET @LanguageValue  = N'Lịch sử cuộc gọi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.TabOOT2180',  @FormID, @LanguageValue, @Language;
SET @LanguageValue  = N'Phường/Xã';
EXEC ERP9AddLanguage @ModuleID, 'FieldDeliveryWardCRMT101011',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quận/Huyện';
EXEC ERP9AddLanguage @ModuleID, 'FieldDistrictNameCRMT101011',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành phố/Tỉnh';
EXEC ERP9AddLanguage @ModuleID, 'FieldCityNameCRMT101011',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vùng';
EXEC ERP9AddLanguage @ModuleID, 'FieldAreaNameCRMT101011',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'FieldCountryNameCRMT101011',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'FieldDeliveryAddressCRMT101011',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.SalesManName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xuất hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.IsExportOrder' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1012.IsWholeSale' , @FormID, @LanguageValue, @Language;