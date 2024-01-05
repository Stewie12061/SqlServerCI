DECLARE
	@ModuleID VARCHAR(50), --Tên module ví dụ ASOFTMT
	@ScreenID VARCHAR(50), -- Mã Màn hình ví dụ MTF1000
	@ScreenName NVARCHAR(MAX), -- Tên Màn hình ví dụ Khóa học
	@ScreenNameE NVARCHAR(MAX), -- Tên tiếng Anh Màn hình 
	@ScreenType TINYINT -- Loại Màn hình ví dụ loại 1 - Màn hình truy vấn

SET @ModuleID = 'ASOFTBEM'

------------------------------------------------ Thiết lập - Chọn dữ liệu --------------------------------------------------------
SET @ScreenType = 4

-- Màn hình Thiết lập chung
SET @ScreenID = N'BEMF0000'
SET @ScreenName = N'Thiết lập chung'
SET @ScreenNameE = N'Thiết lập chung'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Thiết lập tài khoản theo mã phân tích
SET @ScreenID = N'BEMF0011'
SET @ScreenName = N'Thiết lập tài khoản theo mã phân tích'
SET @ScreenNameE = N'Thiết lập tài khoản theo mã phân tích'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Kế thừa Phiếu mua hàng, BTTH
SET @ScreenID = N'BEMF2003'
SET @ScreenName = N'Kế thừa Phiếu mua hàng, BTTH'
SET @ScreenNameE = N'Kế thừa Phiếu mua hàng, BTTH'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Kế thừa Phiếu đề nghị công tác
SET @ScreenID = N'BEMF2013'
SET @ScreenName = N'Kế thừa Phiếu đề nghị công tác'
SET @ScreenNameE = N'Kế thừa Phiếu đề nghị công tác'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Kế thừa Phiếu đề nghị thanh toán tạm ứng
SET @ScreenID = N'BEMF2004'
SET @ScreenName = N'Kế thừa Phiếu đề nghị thanh toán tạm ứng'
SET @ScreenNameE = N'Kế thừa Phiếu đề nghị thanh toán tạm ứng'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình chọn nhân viên
SET @ScreenID = N'BEMF9003'
SET @ScreenName = N'Chọn nhân viên'
SET @ScreenNameE = N'Chọn nhân viên'
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, null

-- Màn hình chọn đối tượng
SET @ScreenID = N'BEMF9004'
SET @ScreenName = N'Chọn đối tượng'
SET @ScreenNameE = N'Chọn đối tượng'
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, null

---------------------------------------------- Danh mục ------------------------------------------------------------
SET @ScreenType = 2

-- Màn hình Danh mục Loại phí
SET @ScreenID = N'BEMF1000'
SET @ScreenName = N'Danh mục Loại phí'
SET @ScreenNameE = N'Danh mục Loại phí'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Danh sách phiếu DNTT/DNTTTU/DNTU
SET @ScreenID = N'BEMF2000'
SET @ScreenName = N'Danh sách phiếu DNTT/DNTTTU/DNTU'
SET @ScreenNameE = N'Danh sách phiếu DNTT/DNTTTU/DNTU'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Danh mục Đơn xin duyệt công tác/nghỉ phép về nước
SET @ScreenID = N'BEMF2010'
SET @ScreenName = N'Danh mục Đơn xin duyệt công tác/nghỉ phép về nước'
SET @ScreenNameE = N'Danh mục Đơn xin duyệt công tác/nghỉ phép về nước'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Danh mục Phiếu thanh toán đi lại
SET @ScreenID = N'BEMF2020'
SET @ScreenName = N'Danh mục Phiếu thanh toán đi lại'
SET @ScreenNameE = N'Danh mục Phiếu thanh toán đi lại'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Danh mục Phiếu ghi thời gian công tác
SET @ScreenID = N'BEMF2030'
SET @ScreenName = N'Danh mục Phiếu ghi thời gian công tác'
SET @ScreenNameE = N'Danh mục Phiếu ghi thời gian công tác'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Danh mục Phiếu báo cáo công tác
SET @ScreenID = N'BEMF2040'
SET @ScreenName = N'Danh mục Phiếu báo cáo công tác'
SET @ScreenNameE = N'Danh mục Phiếu báo cáo công tác'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Danh mục Phiếu dịch nội dung chứng từ
SET @ScreenID = N'BEMF2050'
SET @ScreenName = N'Danh mục Phiếu dịch nội dung chứng từ'
SET @ScreenNameE = N'Danh mục Phiếu dịch nội dung chứng từ'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE


---------------------------------------------- Cập nhật ------------------------------------------------------------
SET @ScreenType = 3

-- Màn hình Cập nhật Loại phí
SET @ScreenID = N'BEMF1001'
SET @ScreenName = N'Cập nhật Loại phí'
SET @ScreenNameE = N'Cập nhật Loại phí'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Cập nhật phiếu DNTT/DNTTTU/DNTU
SET @ScreenID = N'BEMF2001'
SET @ScreenName = N'Cập nhật phiếu DNTT/DNTTTU/DNTU'
SET @ScreenNameE = N'Cập nhật phiếu DNTT/DNTTTU/DNTU'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Cập nhật Đơn xin duyệt công tác/nghỉ phép về nước
SET @ScreenID = N'BEMF2011'
SET @ScreenName = N'Cập nhật Đơn xin duyệt công tác/nghỉ phép về nước'
SET @ScreenNameE = N'Cập nhật Đơn xin duyệt công tác/nghỉ phép về nước'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Cập nhật Phiếu thanh toán đi lại
SET @ScreenID = N'BEMF2021'
SET @ScreenName = N'Cập nhật Phiếu thanh toán đi lại'
SET @ScreenNameE = N'Cập nhật Phiếu thanh toán đi lại'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Cập nhật Phiếu ghi thời gian công tác
SET @ScreenID = N'BEMF2031'
SET @ScreenName = N'Cập nhật Phiếu ghi thời gian công tác'
SET @ScreenNameE = N'Cập nhật Phiếu ghi thời gian công tác'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Cập nhật Phiếu báo cáo công tác
SET @ScreenID = N'BEMF2041'
SET @ScreenName = N'Cập nhật Phiếu báo cáo công tác'
SET @ScreenNameE = N'Cập nhật Phiếu báo cáo công tác'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Cập nhật Phiếu dịch nội dung chứng từ
SET @ScreenID = N'BEMF2051'
SET @ScreenName = N'Cập nhật Phiếu dịch nội dung chứng từ'
SET @ScreenNameE = N'Cập nhật Phiếu dịch nội dung chứng từ'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE


---------------------------------------------- Xem chi tiết --------------------------------------------------------
SET @ScreenType = 5

-- Màn hình Xem chi tiết Loại phí
SET @ScreenID = N'BEMF1002'
SET @ScreenName = N'Xem chi tiết Loại phí'
SET @ScreenNameE = N'Xem chi tiết Loại phí'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Xem chi tiết phiếu DNTT/DNTTTU/DNTU
SET @ScreenID = N'BEMF2002'
SET @ScreenName = N'Xem chi tiết phiếu DNTT/DNTTTU/DNTU'
SET @ScreenNameE = N'Xem chi tiết phiếu DNTT/DNTTTU/DNTU'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Xem chi tiết Đơn xin duyệt công tác/nghỉ phép về nước
SET @ScreenID = N'BEMF2012'
SET @ScreenName = N'Xem chi tiết Đơn xin duyệt công tác/nghỉ phép về nước'
SET @ScreenNameE = N'Xem chi tiết Đơn xin duyệt công tác/nghỉ phép về nước'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Xem chi tiết Phiếu thanh toán đi lại
SET @ScreenID = N'BEMF2022'
SET @ScreenName = N'Xem chi tiết Phiếu thanh toán đi lại'
SET @ScreenNameE = N'Xem chi tiết Phiếu thanh toán đi lại'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Xem chi tiết Phiếu ghi thời gian công tác
SET @ScreenID = N'BEMF2032'
SET @ScreenName = N'Xem chi tiết Phiếu ghi thời gian công tác'
SET @ScreenNameE = N'Xem chi tiết Phiếu ghi thời gian công tác'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Xem chi tiết Phiếu báo cáo công tác
SET @ScreenID = N'BEMF2042'
SET @ScreenName = N'Xem chi tiết Phiếu báo cáo công tác'
SET @ScreenNameE = N'Xem chi tiết Phiếu báo cáo công tác'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

-- Màn hình Xem chi tiết Phiếu dịch nội dung chứng từ
SET @ScreenID = N'BEMF2052'
SET @ScreenName = N'Xem chi tiết Phiếu dịch nội dung chứng từ'
SET @ScreenNameE = N'Xem chi tiết Phiếu dịch nội dung chứng từ'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

---------------------------------------------- Báo cáo ------------------------------------------------------------
SET @ScreenType = 1

-- Màn hình danh sách báo cáo
SET @ScreenID = N'BEMF3000'
SET @ScreenName = N'Báo cáo'
SET @ScreenNameE = N'Report'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'BEMF3001'
SET @ScreenName = N'Báo cáo DNTU/DNTT/DNTTTU'
SET @ScreenNameE = N'Báo cáo DNTU/DNTT/DNTTTU'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'BEMF3002'
SET @ScreenName = N'Báo cáo công tác'
SET @ScreenNameE = N'Báo cáo công tác'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'BEMF3003'
SET @ScreenName = N'Báo cáo payment list'
SET @ScreenNameE = N'Báo cáo payment list'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE