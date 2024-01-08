declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)

SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'
SET @FormID = 'CRMF0000'

SET @LanguageValue = N'Thiết lập hệ thống';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.ConfgCommon' , @FormID, @LanguageValue, @Language; 
SET @LanguageValue = N'Thông tin khác';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.ConfgOrther' , @FormID, @LanguageValue, @Language; 
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.DivisionID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.DivisionID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.DivisionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phiếu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên phiếu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kỳ kế toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.MonthYear' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Phiếu đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherType01' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Phiếu điều phối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherType02' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Phiếu xuất kho';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherType04' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Phiếu chênh lệch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherType05' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Phiếu nhập kho';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherType03' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Kho chính';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.WareHouseID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.WareHouseID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên kho';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.WareHouseName.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Kho tạm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.WareHouseTempID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tài khoản xuất kho';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.ExportAccountID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tài khoản nhập kho';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.ImportAccountID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Định mức bộ KIT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.ApportionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.DivisionID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.DivisionName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã phiếu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherTypeID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên phiếu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherTypeName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.WareHouseID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên kho';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.WareHouseName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.AccountID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.AccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.AccountID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.AccountName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bộ KIT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.KITID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bộ KIT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.KITName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bộ KIT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.KITID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên bộ KIT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.KITName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho cho mượn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.WareHouseBorrowID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherType06' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT yêu cầu hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherSupportRequired' , @FormID, @LanguageValue, @Language;

-- [Học Huy] Update [27/11/2019]: Custom MAITHU
SET @LanguageValue = N'Thiết lập loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.GroupVoucherType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thiết lập chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.GroupSetting' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherType02MTH' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu dự toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherType03MTH' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.ClassifyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Zensuppo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.ZensuppoID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.ZensuppoID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.ZensuppoName.CB' , @FormID, @LanguageValue, @Language;
-- [Học Huy] Update [27/11/2019]: Custom MAITHU

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherRequestCustomer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT đề nghị cấp license';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherRequestLicense', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherCampaign', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT chiến dịch email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherCampaignEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn cắt cuộn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.CutPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn sóng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.WavePhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.PrintPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.PhaseIDSetting.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.PhaseNameSetting.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT yêu cầu dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherRequestService', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT chiến dịch sms';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherCampaignSMS', @FormID, @LanguageValue, @Language;

-- [Lê Hoàng] Update [04/06/2021]: MAITHU
SET @LanguageValue = N'Công đoạn Bế/Chạp';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.DieCuttingPhase', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủng loại Kẽm in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.ZincID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CT dữ liệu nguồn online';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherSourceDataOnline', @FormID, @LanguageValue, @Language;

