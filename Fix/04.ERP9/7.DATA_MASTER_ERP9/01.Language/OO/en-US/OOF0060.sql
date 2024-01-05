-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF0060 - OO
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10)

/*
 - Tieng Viet: vi-VN
 - Tieng Anh: en-US
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @ModuleID = 'OO';
SET @FormID = 'OOF0060';
SET @Language = 'en-US';


EXEC ERP9AddLanguage @ModuleID, N'OOF0060.Title', @FormID, N'System settings', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0060.VoucherTask', @FormID, N'Type CT task', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0060.TaskHourDecimal', @FormID, N'Odd number of working hours', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0060.VoucherTypeID.CB', @FormID, N'ID', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0060.VoucherTypeName.CB', @FormID, N'Name', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0060.VoucherIssues', @FormID, N'Type CT Issues', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0060.VoucherRequest', @FormID, N'Type CT request support', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0060.VoucherMilestone', @FormID, N'Type CT management milestone', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0060.VoucherRelease', @FormID, N'Type CT management release', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0060.VoucherBooking', @FormID, N'Type CT management đặt thiết bị', @Language;