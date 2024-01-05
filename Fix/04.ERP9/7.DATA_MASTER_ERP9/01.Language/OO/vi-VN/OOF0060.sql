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
SET @Language = 'vi-VN';


EXEC ERP9AddLanguage @ModuleID, N'OOF0060.Title', @FormID, N'Thiết lập hệ thống', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0060.VoucherTask', @FormID, N'Loại CT công việc', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0060.TaskHourDecimal', @FormID, N'Số lẻ giờ công', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0060.VoucherTypeID.CB', @FormID, N'Mã chứng từ', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0060.VoucherTypeName.CB', @FormID, N'Tên chứng từ', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0060.VoucherIssues', @FormID, N'Loại CT vấn đề', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0060.VoucherRequest', @FormID, N'Loại CT yêu cầu hỗ trợ', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0060.VoucherMilestone', @FormID, N'Loại CT quản lý milestone', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0060.VoucherRelease', @FormID, N'Loại CT quản lý release', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0060.VoucherBooking', @FormID, N'Loại CT quản lý đặt thiết bị', @Language;