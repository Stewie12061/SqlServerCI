                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ A00 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 2:57:53 PM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'A00' and Module = N'00'
-- SELECT * FROM A00001 WHERE FormID = 'A00' and Module = N'00' and LanguageID = N'vi-VN'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: vi-VN 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/

EXEC ERP9AddLanguage N'00', N'A00.POST00801', N'A00', N'Phiếu thu', N'vi-VN', NULL

EXEC ERP9AddLanguage N'00', N'A00.POST00802', N'A00', N'Chi tiết phiếu thu', N'vi-VN', NULL

EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_Business_DepositVoucher', N'A00', N'Phiếu đặt cọc', N'vi-VN', NULL

EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_Business_Receipt', N'A00', N'Phiếu thu', N'vi-VN', NULL

EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_List_CommisionRateList', N'A00', N'Mức hoa hồng theo doanh thu lũy kế', N'vi-VN', NULL

EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_List_Events', N'A00', N'Event', N'vi-VN', NULL

EXEC ERP9AddLanguage N'00', N'A00.POST2010', N'A00', N'phiếu đặt cọc', N'vi-VN', NULL

EXEC ERP9AddLanguage N'00', N'A00.POST2011', N'A00', N'chi tiết phiếu đặt cọc', N'vi-VN', NULL

EXEC ERP9AddLanguage N'00', N'A00.InventoryID.POS', N'A00', N'Mặt hàng', N'vi-VN', NULL

EXEC ERP9AddLanguage N'00', N'A00.APKMaster.POS', N'A00', N'Mặt hàng', N'vi-VN', NULL

EXEC ERP9AddLanguage N'00', N'A00.POST0010', N'A00', N'Event', N'vi-VN', NULL

EXEC ERP9AddLanguage N'00', N'A00.POST0004', N'A00', N'Thông tin phiếu chừng từ', N'vi-VN', NULL

EXEC ERP9AddLanguage N'00', N'A00.POST0026', N'A00', N'Thông tin nhân viên thuộc event', N'vi-VN', NULL

EXEC ERP9AddLanguage N'00', N'A00.POST0010', N'A00', N'Thông tin nhân viên thuộc event', N'vi-VN', NULL

EXEC ERP9AddLanguage N'00', N'A00.ComboVoucherID', N'A00', N'Mã chứng từ', N'vi-VN', NULL

EXEC ERP9AddLanguage N'00', N'A00.ComboVoucherName', N'A00', N'Tên chứng từ', N'vi-VN', NULL

EXEC ERP9AddLanguage N'00', N'A00.OT1301_ID', N'A00', N'Mã hàng đồng giá', N'vi-VN', NULL

EXEC ERP9AddLanguage N'00', N'A00.OT1301_Name', N'A00', N'Tên hàng đồng giá', N'vi-VN', NULL

EXEC ERP9AddLanguage N'00', N'A00.POST2050', N'A00', N'Phiếu yêu cầu dịch vụ', N'vi-VN', NULL

EXEC ERP9AddLanguage N'00', N'A00.POST2051', N'A00', N'Linh kiện thay thế/Dịch vụ', N'vi-VN', NULL



