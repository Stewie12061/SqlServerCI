---- Create by Thái Đình Ly on 26/11/2020 3:26:26 PM
---  Modified by Tấn Lộc ON 29/07/2021 : Bổ sung dữ liệu cho cột CodeMasterName
---- Bảng dữ liệu ngầm module M

DECLARE @CodeMaster NVARCHAR(50)
DECLARE @TableID VARCHAR(50) = 'MT0099'

-- Trạng thái
SET @CodeMaster = 'OrderStatus'
EXEC AddDataMasterERP9 @TableID, N'OrderStatus', 1, 1,0, N'0-Chưa hoàn tất', N'0-Chưa hoàn tất', 0, NULL, N'Tình trạng'
EXEC AddDataMasterERP9 @TableID, N'OrderStatus', 2, 2,1, N'1-Hoàn tất', N'1-Hoàn tất', 0, NULL, N'Tình trạng'

-- Định lượng
SET @CodeMaster = 'QuantitativeType'
EXEC AddDataMasterERP9 @TableID, N'QuantitativeType', 1, 1, 1, N'Hằng số', N'Constant', 0, NULL, N'Loại định lượng (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'QuantitativeType', 2, 2, 2, N'Công thức', N'Recipe', 0, NULL, N'Loại định lượng (Màn hình Cập nhật định mức sản phẩm - MF2121)'

-- Loại nguồn lực
SET @CodeMaster = 'ResourcesType'
EXEC AddDataMasterERP9 @TableID, N'ResourcesType', 0, 0, 0, N'Máy móc', N'Machine', 0, NULL, N'Loại nguồn lực (Màn hình Danh mục nguồn lực sản xuất - MF1820)'
EXEC AddDataMasterERP9 @TableID, N'ResourcesType', 1, 1, 1, N'Con người', N'Person', 0, NULL, N'Loại nguồn lực (Màn hình Danh mục nguồn lực sản xuất - MF1820)'
EXEC AddDataMasterERP9 @TableID, N'ResourcesType', 2, 2, 2, N'Khác', N'Other', 0, NULL, N'Loại nguồn lực (Màn hình Danh mục nguồn lực sản xuất - MF1820)'

-- ĐVT Quy trình
SET @CodeMaster = 'RoutingUnit'
EXEC AddDataMasterERP9 @TableID, N'RoutingUnit', 0, 0, 0, N'Phút', N'Minutes', 0, NULL, N'ĐVT Quy trình (Màn hình Danh mục nguồn lực sản xuất - MF1820)'
EXEC AddDataMasterERP9 @TableID, N'RoutingUnit', 1, 1, 1, N'Giờ', N'Hours', 0, NULL, N'ĐVT Quy trình (Màn hình Danh mục nguồn lực sản xuất - MF1820)'

-- Loại cấu trúc sản phẩm
SET @CodeMaster = 'StuctureType'
EXEC AddDataMasterERP9 @TableID, N'StuctureType', 0, 0, 0, N'Thành phẩm', N'Product', 0, NULL, N'Loại cấu trúc sản phẩm (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'StuctureType', 1, 1, 1, N'Bán thành phẩm', N'Semi-product', 0, NULL, N'Loại cấu trúc sản phẩm (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'StuctureType', 2, 2, 2, N'Nguyên vật liệu', N'Material', 0, NULL, N'Loại cấu trúc sản phẩm (Màn hình Cập nhật định mức sản phẩm - MF2121)'

-- Lựa chọn gia công
SET @CodeMaster = 'Outsource'
EXEC AddDataMasterERP9 @TableID, N'Outsource', 1, 1, 0, N'Có', N'Yes', 0, NULL, N'Gia công (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'Outsource', 0, 0, 1, N'Không', N'No', 0, NULL, N'Gia công (Màn hình Cập nhật định mức sản phẩm - MF2121)'

-- Lập lệnh sản xuất
SET @CodeMaster = 'Dictates'
EXEC AddDataMasterERP9 @TableID, N'Dictates', 0, 0, 0, N'Không', N'No', 0, NULL, N'Lập lệnh sản xuấ (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'Dictates', 1, 1, 1, N'Bắt buộc', N'Required', 0, NULL, N'Lập lệnh sản xuấ (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'Dictates', 2, 2, 2, N'Tùy chọn', N'Options', 0, NULL, N'Lập lệnh sản xuấ (Màn hình Cập nhật định mức sản phẩm - MF2121)'

-- Lựa chọn kế thừa
SET @CodeMaster = 'Inherited'
EXEC AddDataMasterERP9 @TableID, N'Inherited', 0, 0, 0, N'Bom version', N'BOMVersion', 0, NULL, N'Loại kế thừa (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'Inherited', 1, 1, 1, N'Cấu trúc sản phẩm', N'Stucture', 0, NULL, N'Loại kế thừa (Màn hình Cập nhật định mức sản phẩm - MF2121)'

-- Đơn vị tính của kích thước sản phẩm
SET @CodeMaster = 'UnitSize'
EXEC AddDataMasterERP9 @TableID, N'UnitSize', 0, 0, 0, N'Con', N'Child', 0, NULL, N'Đvt con/bộ (Màn hình Phiếu yêu cầu khách hàng - CRMF2101)'
EXEC AddDataMasterERP9 @TableID, N'UnitSize', 1, 1, 1, N'Bộ', N'Compens', 0, NULL, N'Đvt con/bộ (Màn hình Phiếu yêu cầu khách hàng - CRMF2101)'

-- Tên hiển thị cho Nguyên vật liệu
SET @CodeMaster = 'DisplayName'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 0, 0, 0, N'Giấy in', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 1, 1, 1, N'Màu 1', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 2, 2, 2, N'Màu 2', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 3, 3, 3, N'Màu 3', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 4, 4, 4, N'Màu 4', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 5, 5, 5, N'Màu 5', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 6, 6, 6, N'Màu 6', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 7, 7, 7, N'Màu 7', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 8, 8, 8, N'Kẽm/trục in/bản in', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 9, 9, 9, N'Tráng phủ', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 10, 10, 10, N'Bồi', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 11, 11, 11, N'Chống thấm', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 12, 12, 12, N'Lớp giấy mặt', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 13, 13, 13, N'Loại giấy sóng B', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 14, 14, 14, N'Loại giấy sóng C', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 15, 15, 15, N'Loại giấy sóng E', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 16, 16, 16, N'Lót giữa', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 17, 17, 17, N'Mặt lưng', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 18, 18, 18, N'Bế/chạp', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 19, 19, 19, N'Dán', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 20, 20, 20, N'Khuôn dán', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 21, 21, 21, N'Quai', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 22, 22, 22, N'Dán suppo', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 23, 23, 23, N'Bậc 1', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 24, 24, 24, N'Bậc 2', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'
EXEC AddDataMasterERP9 @TableID, N'DisplayName', 25, 25, 25, N'Dán tem', N'', 0, NULL, N'Tên hiển thị cho Nguyên vật liệu (Màn hình Cập nhật định mức sản phẩm - MF2121)'

SET @CodeMaster = 'Specification'
-- Thông số kỹ thuật Master
EXEC AddDataMasterERP9 @TableID, N'Specification', 'PaperTypeID', 0, 0, N'Loại sản phẩm', N'PaperTypeID', 0, NULL, N'Thông số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'ActualQuantity', 1, 1, N'Số lượng đặt hàng', N'ActualQuantity', 0, NULL, N'Thông số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'AmountLoss', 1, 1, N'Số lượng hao hụt', N'AmountLoss', 0, NULL, N'Thông số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'OffsetQuantity', 2, 2, N'Số lượng sản xuất', N'OffsetQuantity', 0, NULL, N'Thông số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'PrintNumber', 3, 3, N'Số mặt in', N'PrintNumber', 0, NULL, N'Thông số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'ColorPrint01', 4, 4, N'Số màu mặt 1', N'ColorPrint01', 0, NULL, N'Thông số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'ColorPrint02', 5, 5, N'Số màu mặt 2', N'ColorPrint02', 0, NULL, N'Thông số kỹ thuật'
-- Thông số kỹ thuật Details
EXEC AddDataMasterERP9 @TableID, N'Specification', 'Size', 6, 6, N'Khổ', N'Size', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'Cut', 7, 7,  N'Cắt', N'Cut', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'Child', 8, 8,  N'Con', N'Child', 0, NULL, N'Thống số kỹ thuật '
EXEC AddDataMasterERP9 @TableID, N'Specification', 'RunPaperID', 9, 9, N'Chạy giấy', N'RunPaperID', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'SplitSheets', 10, 10, N'Chia tờ', N'SplitSheets', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'RunWavePaper', 11, 11,  N'Sóng', N'RunWavePaper', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'QuantityRunWave', 12, 12,  N'SL tờ chạy sóng', N'QuantityRunWave', 0, NULL, N'Thống số kỹ thuật'
-- Thông số kỹ thuật là Đơn vị
EXEC AddDataMasterERP9 @TableID, N'Specification', 'Gsm', 13, 13,  N'Định lượng', N'Gsm', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'Sheets', 14, 14,  N'Tờ', N'Sheets', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'Ram', 15, 15,  N'Ram', N'Ram', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'Kg', 16, 16,  N'Kg', N'Kg', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'M2', 17, 17,  N'M2', N'M2', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'KindSuppliers', 18, 18, N'Chủng loại', N'KindSuppliers', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'UnitID', 19, 19,  N'Đơn vị tính', N'UnitID', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'Size', 20, 20, N'Khổ', N'Size', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'Cut', 21, 21,  N'Cắt', N'Cut', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'Child', 22, 22,  N'Con', N'Child', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'PrintTypeID', 23, 23, N'Cách in', N'PrintTypeID', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'RunPaperID', 24, 24, N'Chạy giấy', N'RunPaperID', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'SplitSheets', 25, 25, N'Chia tờ', N'SplitSheets', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'RunPaperID', 26, 26, N'Chạy giấy', N'RunPaperID', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'RunWavePaper', 27, 27,  N'Sóng', N'RunWavePaper', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'QuantityRunWave', 28, 28,  N'SL tờ chạy sóng', N'QuantityRunWave', 0, NULL, N'Thống số kỹ thuật'
EXEC AddDataMasterERP9 @TableID, N'Specification', 'MoldStatusID', 29, 29,  N'Trạng thái khuôn', N'MoldStatusID', 0, NULL, N'Thống số kỹ thuật'

-- Trạng thái sản xuất
SET @CodeMaster = 'StatusManufacturing'
EXEC AddDataMasterERP9 @TableID, N'StatusManufacturing', 0, 0, 0, N'Chưa sản xuất', N'Not yet manufactured', 0, NULL, N'Tình trạng sản xuất'
EXEC AddDataMasterERP9 @TableID, N'StatusManufacturing', 1, 1, 1,  N'Đang sản xuất', N'Manufacturing', 0, NULL, N'Tình trạng sản xuất'
EXEC AddDataMasterERP9 @TableID, N'StatusManufacturing', 2, 2, 2, N'Đã sản xuất', N'Manufactured', 0, NULL, N'Tình trạng sản xuất'


-- Loại lệnh
SET @CodeMaster = 'CommandType'
EXEC AddDataMasterERP9 @TableID, N'CommandType', 0, 0, 0, N'Lệnh cắt giấy', N'Lệnh cắt giấy', 0, NULL, N'Loại lệnh'
EXEC AddDataMasterERP9 @TableID, N'CommandType', 1, 1, 1,  N'Lệnh cắt giấy cuộn', N'Lệnh cắt giấy cuộn', 0, NULL, N'Loại lệnh'
EXEC AddDataMasterERP9 @TableID, N'CommandType', 2, 2, 2, N'Lệnh chụp kẽm', N'Lệnh chụp kẽm', 0, NULL, N'Loại lệnh'
EXEC AddDataMasterERP9 @TableID, N'CommandType', 3, 3, 3, N'Lệnh in Offset', N'Lệnh in Offset', 0, NULL, N'Loại lệnh'
EXEC AddDataMasterERP9 @TableID, N'CommandType', 4, 4, 4, N'Lệnh chạy sóng', N'Lệnh chạy sóng', 0, NULL, N'Loại lệnh'
EXEC AddDataMasterERP9 @TableID, N'CommandType', 4, 4, 4, N'Lệnh cán màng', N'Lệnh cán màng', 0, NULL, N'Loại lệnh'
EXEC AddDataMasterERP9 @TableID, N'CommandType', 5, 5, 5, N'Lệnh bồi', N'Lệnh bồi', 0, NULL, N'Loại lệnh'
EXEC AddDataMasterERP9 @TableID, N'CommandType', 6, 6, 6, N'Lệnh bế', N'Lệnh bế', 0, NULL, N'Loại lệnh'
EXEC AddDataMasterERP9 @TableID, N'CommandType', 7, 7, 7, N'Lệnh in Flexo', N'Lệnh in Flexo', 0, NULL, N'Loại lệnh'
EXEC AddDataMasterERP9 @TableID, N'CommandType', 8, 8, 8, N'Lệnh bẻ hàng', N'Lệnh bẻ hàng', 0, NULL, N'Loại lệnh'
EXEC AddDataMasterERP9 @TableID, N'CommandType', 9, 9, 9, N'Lệnh dán Supo', N'Lệnh dán Supo', 0, NULL, N'Loại lệnh'
EXEC AddDataMasterERP9 @TableID, N'CommandType', 10, 10, 10, N'Lệnh dán', N'Lệnh dán', 0, NULL, N'Loại lệnh'
EXEC AddDataMasterERP9 @TableID, N'CommandType', 11, 11, 11, N'Lệnh đóng kim', N'Lệnh đóng kim', 0, NULL, N'Loại lệnh'
EXEC AddDataMasterERP9 @TableID, N'CommandType', 12, 12, 12, N'Lệnh kiểm phẩm và đóng gói', N'Lệnh kiểm phẩm và đóng gói', 0, NULL, N'Loại lệnh'
EXEC AddDataMasterERP9 @TableID, N'CommandType', 13, 13, 13, N'Lệnh Chạy Sóng', N'Lệnh Chạy Sóng', 0, NULL, N'Loại lệnh'


--[Phương Thảo][17/06/2023][2023/06/IS/0105] bổ sung Chọn loại in barcode
-- Lựa chọn Loai in Barcode
SET @CodeMaster = 'ChooseTypeID'
EXEC AddDataMasterERP9 @TableID, N'ChooseTypeID', 0, 0, 0, N'In 1 mặt hàng', N'1 InventoryID', 0, NULL, N'Loại in Barcode( Màn hình in đơn hàng mua -POF2003'
EXEC AddDataMasterERP9 @TableID, N'ChooseTypeID', 1, 1, 1, N'In hàng Loạt mặt hàng', N' Many InventoryID', 0, NULL, N'Loại in Barcode( Màn hình in đơn hàng mua -POF2003'
