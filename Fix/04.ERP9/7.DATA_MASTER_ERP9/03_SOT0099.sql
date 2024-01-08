---- Create by Thái Đình Ly on 26/11/2020 3:26:26 PM
---- Bảng dữ liệu ngầm module M

DECLARE @CodeMaster NVARCHAR(50)
DECLARE @TableID VARCHAR(50) = 'SOT0099'

-- Trạng thái của Phiếu thông tin sản xuất.
SET @CodeMaster = 'SOT2080.StatusID'
EXEC AddDataMasterERP9 @TableID, N'SOT2080.StatusID', 0, 0, 0, N'Chưa sản xuất', N'', 0, NULL
EXEC AddDataMasterERP9 @TableID, N'SOT2080.StatusID', 1, 1, 1, N'Đang sản xuất', N'', 0, NULL
EXEC AddDataMasterERP9 @TableID, N'SOT2080.StatusID', 2, 2, 2, N'Đã hoàn tất', N'', 0, NULL
EXEC AddDataMasterERP9 @TableID, N'SOT2080.StatusID', 3, 3, 3, N'Tạm ngưng', N'', 0, NULL
EXEC AddDataMasterERP9 @TableID, N'SOT2080.StatusID', 4, 4, 4, N'Hủy bỏ', N'', 0, NULL

-- Các loại chi phí của bảng tính giá
SET @CodeMaster = 'SOT2114.Cost'
EXEC AddDataMasterERP9 @TableID, N'SOT2114.Cost', 0, 0, 0, N'Chi phí khấu hao - nhà xưởng', N'', 0, NULL
EXEC AddDataMasterERP9 @TableID, N'SOT2114.Cost', 1, 1, 1, N'Chi phí sản xuất', N'', 0, NULL
EXEC AddDataMasterERP9 @TableID, N'SOT2114.Cost', 2, 2, 2, N'Chi phí bán hàng', N'', 0, NULL
EXEC AddDataMasterERP9 @TableID, N'SOT2114.Cost', 3, 3, 3, N'Chi phí lắp đặt', N'', 0, NULL

-- Loại đơn giá của thành phẩm bảng tính giá
SET @CodeMaster = 'SOT2115.TypePrice'
EXEC AddDataMasterERP9 @TableID, N'SOT2115.TypePrice', 0, 0, 0, N'Đơn giá/bộ giao tại xưởng', N'', 0, NULL
EXEC AddDataMasterERP9 @TableID, N'SOT2115.TypePrice', 1, 1, 1, N'Đơn giá/m2 giao tại xưởng', N'', 0, NULL
EXEC AddDataMasterERP9 @TableID, N'SOT2115.TypePrice', 2, 2, 2, N'Đơn giá/bộ lắp đặt', N'', 0, NULL
EXEC AddDataMasterERP9 @TableID, N'SOT2115.TypePrice', 3, 3, 3, N'Đơn giá/m2 lắp đặt', N'', 0, NULL

----Đình Hòa 26/06/2021 List phiếu in đơn hàng bán
SET @CodeMaster = 'TemplatePrint.SOF2000'
EXEC AddDataMasterERP9 @TableID, @CodeMaster, N'SOF2000.RP1', 0, 0, N'Phiếu đơn đặt hàng', N'', 0, NULL
EXEC AddDataMasterERP9 @TableID, @CodeMaster, N'SOF2000.RP2', 1, 1, N'Phiếu kỹ thuật sản xuất', N'', 0, NULL

----Lê Hoàng 18/10/2021 List phiếu in Báo giá chuẩn 
SET @CodeMaster = 'TemplatePrint.SOF20291'
EXEC AddDataMasterERP9 @TableID, @CodeMaster, N'SOR2020Report_Standard', 0, 0, N'Mẫu 01', N'Form 01', 0, NULL
EXEC AddDataMasterERP9 @TableID, @CodeMaster, N'SOR2020Report_Standard_Image', 1, 1, N'Mẫu 02', N'Form 02', 0, NULL

----Văn Tài 15/05/2023: Trạng thái điều phối của đơn.
SET @CodeMaster = 'SOF2170.Status'
EXEC AddDataMasterERP9 @TableID, @CodeMaster, N'0', 0, 0, N'Chờ nhận hàng', N'Chờ nhận hàng', 0, NULL
EXEC AddDataMasterERP9 @TableID, @CodeMaster, N'1', 1, 1, N'Hoàn tất', N'Hoàn tất', 0, NULL
EXEC AddDataMasterERP9 @TableID, @CodeMaster, N'2', 2, 2, N'Từ chối', N'Từ chối', 0, NULL
EXEC AddDataMasterERP9 @TableID, @CodeMaster, N'3', 3, 3, N'Đang giao hàng', N'Đang giao hàng', 0, NULL
EXEC AddDataMasterERP9 @TableID, @CodeMaster, N'4', 4, 4, N'Hủy đơn', N'Hủy đơn', 0, NULL

