------------------------------------------------------------------------------------------------------
-- Fix Bổ sung phân quyền màn hình -- Module POS
-- ScreenID: 1-Báo cáo; 2-Danh mục; 3-Nhập liệu; 4-Khác
------------------------------------------------------------------------------------------------------
-- Store Insert dữ liệu vào Table chuẩn
------------------------------------------------------------------------------------------------------
-- create by Thị Phượng  Date 09/08/2016
-- Thêm dữ liệu vào bảng Master

DECLARE @ModuleID AS NVARCHAR(50) = 'ASOFTPOS'


DECLARE
	@ScreenID VARCHAR(50),
	@ScreenName NVARCHAR(MAX),
	@ScreenNameE NVARCHAR(MAX),
	@ScreenType TINYINT

------------------------------------------------------------------------------------------------------
------------------------------------------------ Báo cáo ---------------------------------------------
------------------------------------------------------------------------------------------------------
SET @ScreenType = 1
SET @ScreenID = N'POSF0046'
SET @ScreenName = N'Báo cáo chi tiết bán hàng theo cửa hàng và nhân viên'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenType = 1
SET @ScreenID = N'POSF0037'
SET @ScreenName = N'Tổng hợp bán hàng theo nhân viên'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenType = 1
SET @ScreenID = N'POSF0071'
SET @ScreenName = N'Bảng cân đối xuất nhập tồn'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenType = 1
SET @ScreenID = N'POSF3009'
SET @ScreenName = N'Báo cáo tổng hợp bán hàng theo mặt hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenType = 1
SET @ScreenID = N'POSR3010'
SET @ScreenName = N'BẢNG ĐỐI CHIẾU DOANH THU BÁN VỚI THU TIỀN VÀ CÔNG NỢ'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSR3011'
SET @ScreenName = N'Báo cáo bán hàng theo khu vực'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSR3012'
SET @ScreenName = N'Bảng đối chiếu số lượng hàng xuất kho so với hàng bán ra'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSR3013'
SET @ScreenName = N'Báo cáo tổng hợp lương'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenID = N'POSR0046_OK'
SET @ScreenName = N'SALE REPORT BY STAFF'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenType = 1
SET @ScreenID = N'POSF3014'
SET @ScreenName = N'Daily Sales Report'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE
SET @ScreenType = 1
SET @ScreenID = N'POSF3015'
SET @ScreenName = N'Báo cáo Total Sales Report'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF3016'
SET @ScreenName = N'Detail Of ReConcile Daily Report (Metro)'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenType = 1
SET @ScreenID = N'POSF3018'
SET @ScreenName = N'AGING METRO'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenType = 1
SET @ScreenID = N'POSF3017'
SET @ScreenName = N'TOTAL SHOWROOM PRODUCT MOVEMENT'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenType = 1
SET @ScreenID = N'POSF3021'
SET @ScreenName = N'BẢNG KÊ BÁN KẺ HÀNG HÓA DỊCH VỤ'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenType = 1
SET @ScreenID = N'POSF3022'
SET @ScreenName = N'Theo dõi nộp tiền TTTM'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenType = 1
SET @ScreenID = N'POSF3023'
SET @ScreenName = N'DAILY DEPOSIT REPORT'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE


SET @ScreenType = 1
SET @ScreenID = N'POSF3024'
SET @ScreenName = N'SALES REPORT'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE


SET @ScreenType = 1
SET @ScreenID = N'POSF3020'
SET @ScreenName = N'Detail of Reconcile daily report'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF3019'
SET @ScreenName = N'Báo cáo tồn kho theo cửa hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF3027'
SET @ScreenName = N'Báo cáo lịch trình giao hàng và thu tiền'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF3028'
SET @ScreenName = N'Báo cáo bảng kê phiếu nhập'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF3029'
SET @ScreenName = N'Báo cáo bảng kê phiếu xuất'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName


SET @ScreenType = 1
SET @ScreenID = N'POSF3030'
SET @ScreenName = N'Báo cá bill đặt cọc'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF3077'
SET @ScreenName = N'Báo cáo TH công nợ bán lẻ theo KH'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF3078'
SET @ScreenName = N'Báo cáo hoa hồng nhân viên'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF3078NN'
SET @ScreenName = N'Báo cáo hoa hồng nhân viên'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName
	
SET @ScreenType = 1
SET @ScreenID = N'POSF3079'
SET @ScreenName = N'Báo cáo lịch sử mua hàng của từng khách hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF3031'
SET @ScreenName = N'Báo cáo chấm công nhân viên'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF3083'
SET @ScreenName = N'Báo cáo theo dõi công nợ công ty tài chính'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF3087'
SET @ScreenName = N'Báo cáo doanh số dịch vụ cửa hàng và nhân viên'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF3084'
SET @ScreenName = N'Báo cáo huê hồng nhân viên dịch vụ'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF3085'
SET @ScreenName = N'Báo cáo tồn kho linh kiện vật tư'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF3086'
SET @ScreenName = N'Báo cáo vật tư nhân viên đang giữ'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF0037'
SET @ScreenName = N'Báo cáo tổng hợp doanh số nhân viên'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF0048'
SET @ScreenName = N'Báo cáo chi tiết bán hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF0069'
SET @ScreenName = N'Báo cáo tổng hợp doanh số hội viên'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF0076'
SET @ScreenName = N'Báo cáo chi tiết doanh số hội viên'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF3009'
SET @ScreenName = N'Báo cáo tổng hợp bán hàng theo mặt hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSR3010'
SET @ScreenName = N'Bảng đối chiếu doanh thu bán với thu tiền và công nợ'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF0045'
SET @ScreenName = N'Báo cáo chênh lệch từng cửa hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName

SET @ScreenType = 1
SET @ScreenID = N'POSF0064'
SET @ScreenName = N'Báo cáo sổ chi tiết vật tư'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenName
------------------------------------------------------------------------------------------------------
--- Danh mục
------------------------------------------------------------------------------------------------------
SET @ScreenType = 2

SET @ScreenID = N'POSF0010'
SET @ScreenName = N'Danh mục cửa hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF1000'
SET @ScreenName = N'Danh mục event'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF2010'
SET @ScreenName = N'Danh mục phiếu đặt cọc'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0011'
SET @ScreenName = N'Danh mục hội viên'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0012'
SET @ScreenName = N'Danh mục hàng hóa'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0013'
SET @ScreenName = N'Danh mục hình thức thanh toán'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0014'
SET @ScreenName = N'Danh mục kho'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0015'
SET @ScreenName = N'Danh sách phiếu nhập hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0016'
SET @ScreenName = N'Danh sách phiếu bán hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0017'
SET @ScreenName = N'Danh sách phiếu kiểm kê'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0018'
SET @ScreenName = N'Danh sách phiếu điều chỉnh'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0019'
SET @ScreenName = N'Danh sách phiếu nhật ký hàng hóa'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0020'
SET @ScreenName = N'Danh sách thẻ hội viên'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0034'
SET @ScreenName = N'Danh mục khu vực'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0021'
SET @ScreenName = N'Danh sách phiếu đề nghị xuất/ trả hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0027'
SET @ScreenName = N'Danh sách phiếu xuất hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0024'
SET @ScreenName =  N'Danh sách phiếu chênh lệch'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0043'
SET @ScreenName = N'Danh mục loại thẻ'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0054'
SET @ScreenName = N'Danh mục số dư tồn kho'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0060'
SET @ScreenName = N'Danh mục thời điểm'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0052'
SET @ScreenName = N'Danh mục bàn'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0090'
SET @ScreenName = N'Danh mục duyệt hàng khuyến mãi'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0080'
SET @ScreenName = N'Danh mục phiếu thu'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF2020'
SET @ScreenName = N'Danh mục phiếu đề nghị chi'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF2030'
SET @ScreenName = N'Danh mục phiếu đề nghị xuất hóa đơn'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0125'
SET @ScreenName = N'Danh mục ca bán hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF2040'
SET @ScreenName = N'Danh mục chốt ca bán hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF2050'
SET @ScreenName = N'Phiếu yêu cầu dịch vụ'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0073'
SET @ScreenName = N'Danh mục hệ số theo khu vực'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

------------------------------------------------------------------------------------------------------
------------------------------------------------ Cập nhật --------------------------------------------
------------------------------------------------------------------------------------------------------
SET @ScreenType = 3
SET @ScreenID = N'POSF00101'
SET @ScreenName = N'Cập nhật cửa hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF2053'
SET @ScreenName = N'Điều phối nhân viên'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenType = 3
SET @ScreenID = N'POSF1001'
SET @ScreenName = N'Cập nhật event'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF2011'
SET @ScreenName = N'Cập nhật phiếu đặt cọc'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF00111'
SET @ScreenName = N'Cập nhật hội viên'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF00121'
SET @ScreenName = N'Hàng khuyến mãi'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF00151'
SET @ScreenName = N'Cập nhật phiếu nhập hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF00152'
SET @ScreenName = N'Kế thừa'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF00161'
SET @ScreenName = N'Cập nhật phiếu bán hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0039'
SET @ScreenName = N'Cập nhật phiếu bán hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0040'
SET @ScreenName = N'Cập nhật phiếu bán hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE


SET @ScreenID = N'POSF00171'
SET @ScreenName = N'Cập nhật phiếu kiểm kê'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF00191'
SET @ScreenName = N'Cập nhật phiếu nhật ký hàng hóa'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF00201'
SET @ScreenName = N'Cập nhật thẻ hội viên'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF00202'
SET @ScreenName = N'Tìm kiếm hội viên'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0022'
SET @ScreenName = N'Cập nhật phiếu đề nghị xuất/ trả hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0023'
SET @ScreenName = N'Tìm kiếm người lập phiếu'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0025'
SET @ScreenName = N'Thông tin chi tiết phiếu chênh lệch'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0026'
SET @ScreenName = N'Chi tiết mặt hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0028'
SET @ScreenName = N'Thông tin chi tiết phiếu xuất hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0030'
SET @ScreenName = N'Cập nhật hàng hóa tại cửa hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0062'
SET @ScreenName = N'Thông tin chi tiết thời điểm'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0082'
SET @ScreenName = N'Xem chi tiết phiếu thu'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0044'
SET @ScreenName = N'Cập nhật loại thẻ'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0091'
SET @ScreenName = N'Duyệt hàng khuyến mãi'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0081'
SET @ScreenName = N'Cập nhật phiếu thu'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0035'
SET @ScreenName = N'Cập nhật khu vực'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0053'
SET @ScreenName = N'Cập nhật bàn'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF00281'
SET @ScreenName = N'Cập nhật phiếu xuất hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0029'
SET @ScreenName = N'Cập nhật chi tiết phiếu xuất kho'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0055'
SET @ScreenName = N'Cập nhật phiếu tồn dư'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF2021'
SET @ScreenName = N'Cập nhật phiếu đề nghị chi'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF2031'
SET @ScreenName = N'Cập nhật phiếu đề nghị xuất hóa đơn'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0126'
SET @ScreenName = N'Cập nhật ca bán hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF2034'
SET @ScreenName = N'Đóng ca bán hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF2035'
SET @ScreenName = N'Mở ca bán hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenType = 3
SET @ScreenID = N'POSF2051'
SET @ScreenName = N'Phiếu yêu cầu dịch vụ'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenType = 3
SET @ScreenID = N'CMNF9004'
SET @ScreenName = N'Chọn đối tượng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenType = 3
SET @ScreenID = N'POSF0074'
SET @ScreenName = N'Cập nhật hệ số khu vực'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

------------------------------------------------------------------------------------------------------
------------------------------------------------ Thiết lập -------------------------------------------
------------------------------------------------------------------------------------------------------
SET @ScreenType = 4

SET @ScreenID = N'POSFXXXX'
SET @ScreenName = N'Mở số kỳ kế toán'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF2013'
SET @ScreenName = N'Kế thừa phiếu đặt cọc'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0000'
SET @ScreenName = N'Hệ thống'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0001'
SET @ScreenName = N'Nhóm mã phân tích cửa hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0002'
SET @ScreenName = N'Thông tin phiếu chứng từ'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0003'
SET @ScreenName = N'Thiết lập cách tính điểm'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0006'
SET @ScreenName = N'Thiết lập phương thức thanh toán'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0007'
SET @ScreenName = N'Thiết lập chung'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0008'
SET @ScreenName = N'Khóa sổ kỳ kế toán'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0009'
SET @ScreenName = N'Chọn kỳ kế toán'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0050'
SET @ScreenName = N'Thiết lập liên kết khu vực - bảng giá'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0004'
SET @ScreenName = N'Quản lý mẫu in'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF00162'
SET @ScreenName = N'Kế thừa từ đơn hàng APP'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF00163'
SET @ScreenName = N'Chọn hàng khuyến mãi'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF00164'
SET @ScreenName = N'Đề xuất hàng khuyến mãi'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0083'
SET @ScreenName = N'Kế thừa phiếu bán hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF00221'
SET @ScreenName = N'Kế thừa phiếu nhập hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF00761'
SET @ScreenName = N'Chọn hội viên'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0123'
SET @ScreenName = N'Sơ đồ cây nhân viên hoa hồng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF2023'
SET @ScreenName = N'Kế thừa phiếu thu'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF2033'
SET @ScreenName = N'Kế thừa phiếu bán hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0085'
SET @ScreenName = N'Kế thừa phiếu yêu cầu dịch vụ'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF0084'
SET @ScreenName = N'Kế thừa phiếu yêu cầu dịch vụ'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'CMNF9001'
SET @ScreenName = N'Chọn mặt hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID, @ScreenType, @ScreenName, @ScreenNameE, -1, NULL

SET @ScreenID = N'CMNF9003'
SET @ScreenName = N'Chọn nhân viên'
SET @ScreenNameE = N''
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID, @ScreenType, @ScreenName, @ScreenNameE, -1, NULL

------------------ Xem chi tiết ---------------------
SET @ScreenType = 5
SET @ScreenID = N'POSF2022'
SET @ScreenName = N'Xem chi tiết phiếu đề nghị chi'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenType = 5
SET @ScreenID = N'POSF1002'
SET @ScreenName = N'Xem chi tiết event'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF2012'
SET @ScreenName = N'Xem chi tiết phiếu đặt cọc'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF2032'
SET @ScreenName = N'Xem chi tiết phiếu đề nghị xuất hóa đơn'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF2042'
SET @ScreenName = N'Danh mục chốt ca bán hàng'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'POSF2052'
SET @ScreenName = N'Xem thông tin phiếu yêu cầu dịch vụ'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE


Update AT1403 set SourceID = 'ERP9' where ModuleID = 'ASoftPOS'


