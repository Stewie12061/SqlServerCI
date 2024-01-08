------------------------------------------------------------------------------------------------------
-- Fix Bổ sung phân quyền màn hình -- Module POS
-- ScreenID: 1-Báo cáo; 2-Danh mục; 3-Nhập liệu; 4-Khác
------------------------------------------------------------------------------------------------------
-- Store Insert dữ liệu vào Table chuẩn
------------------------------------------------------------------------------------------------------
-- Create by Thị Phượng  Date 09/08/2016
--# Update: Thu Hà [20/11/2023] update  chỉnh vị trí phân quyền.
-- Thêm dữ liệu vào bảng Master

DECLARE @ModuleID AS NVARCHAR(50) = 'ASOFTPO'


DECLARE
	@ScreenID VARCHAR(50),
	@ScreenName NVARCHAR(MAX),
	@ScreenNameE NVARCHAR(MAX),
	@ScreenType TINYINT


DECLARE	@OrderNo INT;
DECLARE @CustomerIndex INT = (SELECT TOP 1 CustomerName FROM CustomerIndex WITH (NOLOCK));
--- Tạo bảng thứ tự
CREATE TABLE #PO_ERP9_PERMISSIONS
--DROP TABLE #PO_ERP9_PERMISSIONS
(
	ScreenID VARCHAR(50),
	OrderNo INT DEFAULT(0)
)
INSERT INTO #PO_ERP9_PERMISSIONS
(ScreenID, OrderNo)
VALUES 
(N'POF3000', 10),
(N'POF3008', 1),
(N'POF3004', 1),
(N'POF3010', 12),
(N'POF3009', 11),
(N'POF3013', 13),
(N'POF3016', 14),
(N'POF3011', 7),
(N'POF3012', 8),
(N'POF3005', 4),
(N'POF3006', 5),
(N'POF3007', 6),
(N'POF3003', 4),
(N'POF3040', 9),
(N'POF3014', 3),
(N'POF3015', 16),
(N'POF3001', 17),
(N'POF3002', 18),
(N'POF2040', 1),
(N'POF2030', 2),
(N'POF2000', 3),
(N'POF2100', 4),
(N'POF2060', 5),
(N'POF2013', 6),
(N'POF2017', 7),
(N'POF2021', 8),
(N'POF1000', 9),
(N'POF1010', 10),
(N'POF2031', 1),
(N'POF2001', 2),
(N'POF2101', 3),
(N'POF2061', 4),
(N'POF2043', 11),
(N'POF0001', 6),
(N'POF2004', 8),
(N'POF2034', 10),
(N'POF2003', 7),
(N'POF2041', 5),
(N'POF2014', 11),
(N'POF2018', 12),
(N'POF2022', 13),
(N'POF1001', 14),
(N'POF1011', 15),
(N'POF2010', 16),
(N'POF2009', 9),
(N'POF0000', 18),
(N'POF2007', 19),
(N'POF2032', 1),
(N'POF2002', 2),
(N'POF2102', 3),
(N'POF2062', 4),
(N'POF2042', 5),
(N'POF2015', 6),
(N'POF2019', 7),
(N'POF2023', 8),
(N'POF1002', 9),
(N'POF1012', 10),
(N'POF0010', 1),
(N'POD0000', 2),
(N'POD0001', 3),
(N'POD0002', 4),
(N'POD0003', 5),
(N'CMNF9008', 1),
(N'SOF2083', 2),
(N'POF2005', 3),
(N'POF2024', 4),
(N'POF2103', 5),
(N'POF2044', 6),
(N'POF2006', 7),
(N'POF2008', 8),
(N'POF2016', 9),
(N'POF2025', 10),
(N'POF2026', 11),
(N'POF2033', 12),
(N'POF2035', 13),
(N'POF2036', 14),
(N'POF2054', 15),
(N'POF20541',16),
(N'POF9001', 17),
(N'POF9002', 18),
(N'POF9003', 19),
(N'POF9005', 20),
(N'POF9008', 21)

------------------------------------------------------------------------------------------------------
------------------------------------------------ Báo cáo ---------------------------------------------
SET @ScreenType =1
SET @ScreenID = N'POF3000'
SET @ScreenName = N'Danh mục đơn hàng mua'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF3040'
SET @ScreenName = N'Danh mục đơn hàng mua'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF3003'
SET @ScreenName = N'Báo cáo lịch sử báo giá nhà cung cấp'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF3004'
SET @ScreenName = N'Báo cáo thống kê yêu cầu mua hàng theo từng dự án'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF3005'
SET @ScreenName = N'Báo cáo xem chi tiết đơn hàng mua theo dự án'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF3006'
SET @ScreenName = N'Báo cáo xem chi tiết đơn hàng mua theo nhà cung cấp'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF3007'
SET @ScreenName = N'Báo cáo mã hàng mua nhiều nhất theo thời gian'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF3008'
SET @ScreenName = N'Báo cáo tổng hợp tình hình đơn đặt hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF3009'
SET @ScreenName = N'Báo cáo chi tiết đơn hàng mua'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF3010'
SET @ScreenName = N'Báo cáo tổng hợp đơn hàng mua'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF3011'
SET @ScreenName = N'Báo cáo tổng hợp giá mua mặt hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF3012'
SET @ScreenName = N'Báo cáo tình hình lập đơn hàng mua'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF3013'
SET @ScreenName = N'Báo cáo tổng hợp tình hình nhận hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF3014'
SET @ScreenName = N'Báo cáo Đặt containter xuất hàng'
SET @ScreenNameE = N'Báo cáo Đặt containter xuất hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF3016'
SET @ScreenName = N'Báo cáo chi tiết tình hình nhận hàng'
SET @ScreenNameE = N'Báo cáo chi tiết tình hình nhận hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo
------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------
--- Danh mục
------------------------------------------------------------------------------------------------------
SET @ScreenType =2

SET @ScreenID = N'POF2000'
SET @ScreenName = N'Danh mục đơn hàng mua'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType =2

IF @CustomerIndex in (98,164,166)
BEGIN
SET @ScreenID = N'POF2013'
SET @ScreenName = N'Danh sách năng lực nhà cung cấp'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo
END 

SET @ScreenType =2

SET @ScreenID = N'POF2017'
SET @ScreenName = N'Đơn đặt hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 98, NULL, @OrderNo

SET @ScreenID = N'POF2021'
SET @ScreenName = N'Kế hoạch mua hàng dự trữ'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'POF2030'
SET @ScreenName = N'Danh sách yêu cầu mua hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF1000'
SET @ScreenName = N'Danh mục bước kế hoạch'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'POF1010'
SET @ScreenName = N'Danh mục mẫu kế hoạch'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

IF @CustomerIndex in (98,164,166,167)
BEGIN
SET @ScreenID = N'POF2040'
SET @ScreenName = N'Danh mục yêu cầu báo giá'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo
END

SET @ScreenID = N'POF2060'
SET @ScreenName = N'Danh mục Đặt containter xuất hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-------------------------------- Danh mục thông tin sản xuất  --------------------------------
SET @ScreenID = N'POF2100'
SET @ScreenName = N'Danh mục tiến độ nhận hàng'
SET @ScreenNameE = N'Danh mục tiến độ nhận hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo
------------------------------------------------------------------------------------------------------
------------------------------------------------ Cập nhật --------------------------------------------
------------------------------------------------------------------------------------------------------
SET @ScreenType =3

SET @ScreenID = N'POF2001'
SET @ScreenName = N'Cập nhật đơn hàng mua'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF2007'
SET @ScreenName = N'Chọn mẫu báo cáo ( Customize MTE )'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 115, NULL, @OrderNo

SET @ScreenID = N'POF0001'
SET @ScreenName = N'Thiết lập đơn hàng mua'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF2009'
SET @ScreenName = N'Cập nhật thông tin vận chuyển'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

IF @CustomerIndex in (98,164,166)
BEGIN
SET @ScreenID = N'POF2014'
SET @ScreenName = N'Cập nhật năng lực nhà cung cấp'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo
END

SET @ScreenID = N'POF2018'
SET @ScreenName = N'Cập nhật đơn đặt hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 98, NULL, @OrderNo

SET @ScreenID = N'POF2022'
SET @ScreenName = N'Cập nhật kế hoạch mua hàng dự trữ'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'POF2031'
SET @ScreenName = N'Cập nhật Yêu cầu mua hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF1001'
SET @ScreenName = N'Cập nhật bước kế hoạch'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'POF1011'
SET @ScreenName = N'Cập nhật mẫu kế hoạch'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'POF2004'
SET @ScreenName = N'Cập nhật tiến độ nhận hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF2034'
SET @ScreenName = N'Chọn mẫu in'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

IF @CustomerIndex in (98,164,166,167)
BEGIN
SET @ScreenID = N'POF2041'
SET @ScreenName = N'Cập nhật yêu cầu báo giá'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo
END

SET @ScreenID = N'POF2043'
SET @ScreenName = N'So sánh báo giá nhà cung cấp'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF0000'
SET @ScreenName = N'Thiết lập hệ thống'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'POF2061'
SET @ScreenName = N'Cập nhật Đặt containter xuất hàng'
SET @ScreenNameE = N'Cập nhật Đặt containter xuất hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF2101'
SET @ScreenName = N'Cập nhật tiến độ nhận hàng'
SET @ScreenNameE = N'Cập nhật tiến độ nhận hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo


--SET @ScreenType = 3
--SET @ScreenID = N'POF2009'
--SET @ScreenName = N'Cập nhật phương thức vận chuyển'
--SET @ScreenNameE = N'Cập nhật phương thức vận chuyển'
--SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
--EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 3
SET @ScreenID = N'POF2010'
SET @ScreenName = N'Cập nhật phí đơn hàng'
SET @ScreenNameE = N'Cập nhật phí đơn hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 147, NULL, @OrderNo

SET @ScreenType = 3
SET @ScreenID = N'POF2003'
SET @ScreenName = N'In Đơn Hàng Mua'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo
--------------- Xem chi tiết --------------------------

SET @ScreenType = 5
SET @ScreenID = N'POF2002'
SET @ScreenName = N'Xem chi tiết đơn hàng mua'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

IF @CustomerIndex in (98,164,166)
BEGIN
SET @ScreenType = 5
SET @ScreenID = N'POF2015'
SET @ScreenName = N'Xem thông tin năng lực nhà cung cấp'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo
END
SET @ScreenType = 5
SET @ScreenID = N'POF2023'
SET @ScreenName = N'Xem chi tiết kế hoạch mua hàng dự trữ'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenType = 5
SET @ScreenID = N'POF2019'
SET @ScreenName = N'Xem thông tin đơn đặt hàng sỉ nội bộ'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 98, NULL, @OrderNo

SET @ScreenID = N'POF2032'
SET @ScreenName = N'Xem chi tiết Yêu cầu mua hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF1002'
SET @ScreenName = N'Xem chi tiết bước kế hoạch'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'POF1012'
SET @ScreenName = N'Xem chi tiết mẫu kế hoạch'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

IF @CustomerIndex in (98,164,166,167)
BEGIN
SET @ScreenID = N'POF2042'
SET @ScreenName = N'Xem chi tiết yêu cầu báo giá'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo
END

SET @ScreenID = N'POF2062'
SET @ScreenName = N'Xem chi tiết Đặt containter xuất hàng'
SET @ScreenNameE = N'Xem chi tiết Đặt containter xuất hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POF2102'
SET @ScreenName = N'Xem thông tin tiến độ nhận hàng'
SET @ScreenNameE = N'Xem thông tin tiến độ nhận hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo
------------------- Chọn -----------------------

SET @ScreenType = 4
SET @ScreenID = N'POF2005'
SET @ScreenName = N'Kế thừa yêu cầu mua'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'POF2006'
SET @ScreenName = N'Chọn mẫu kế hoạch'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'POF2016'
SET @ScreenName = N'Chọn mặt hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'POF2024'
SET @ScreenName = N'Kế thừa đơn đặt hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'POF2025'
SET @ScreenName = N'Kế thừa kế hoạch mua hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'POF2026'
SET @ScreenName = N'Chọn nhà cung cấp'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'POF2033'
SET @ScreenName = N'Kế thừa yêu cầu mua từ dự án'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'POF2035'
SET @ScreenName = N'Chọn yêu cầu báo giá'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'POF2044'
SET @ScreenName = N'Kế thừa báo giá nhà cung cấp'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'CMNF9008'
SET @ScreenName = N'Chọn mã phân tích'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE
SET @ScreenType = 4
SET @ScreenID = N'SOF2083'
SET @ScreenName = N'Kế thừa đơn hàng bán'
SET @ScreenNameE = N'Kế thừa đơn hàng bán'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE
SET @ScreenType = 4
SET @ScreenID = N'POF2036'
SET @ScreenName = N'Kế thừa dự trù NVL sản xuất'
SET @ScreenNameE = N'Kế thừa dự trù NVL sản xuất'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--[Trọng Kiên] Update [11/12/2020]
SET @ScreenType = 4
SET @ScreenID = N'POF2054'
SET @ScreenName = N'Danh sách đơn hàng nhận trễ'
SET @ScreenNameE = N'Danh sách đơn hàng nhận trễ'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'POF20541'
SET @ScreenName = N'Danh sách đơn hàng sắp đến ngày nhận'
SET @ScreenNameE = N'Danh sách đơn hàng sắp đến ngày nhận'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'POF9001'
SET @ScreenName = N'Chọn mặt hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo


SET @ScreenType = 4
SET @ScreenID = N'POF9002'
SET @ScreenName = N'Chọn mặt hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo


SET @ScreenType = 4
SET @ScreenID = N'POF9003'
SET @ScreenName = N'Chọn nhân viên'
SET @ScreenNameE = N'Chọn nhân viên'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--Đình Hòa [26/04/2021] - Màn hình kế thừa dự trù chi phí
SET @ScreenType = 4
SET @ScreenID = N'POF2008'
SET @ScreenName = N'Kế thừa dự trù chi phí'
SET @ScreenNameE = N'Kế thừa dự trù chi phí'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--Tấn Lộc [13/05/2021] - Màn hình chọn mã phân tích
SET @ScreenType = 4
SET @ScreenID = N'POF9008'
SET @ScreenName = N'Chọn mã phân tích'
SET @ScreenNameE = N'Chọn mã phân tích'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--Minh Hiếu [20/04/2022] - Màn hình chọn đơn vận
SET @ScreenType = 4
SET @ScreenID = N'POF9005'
SET @ScreenName = N'Chọn đơn vận'
SET @ScreenNameE = N'Chọn đơn vận'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--Thanh Lượng [21/09/2023] - Màn hình kế thừa tiến độ nhận hàng
SET @ScreenType = 4
SET @ScreenID = N'POF2103'
SET @ScreenName = N'Kế thừa tiến độ nhận hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--Thanh Lượng [21/12/2023] - Màn hình kế thừa thông tin vận chuyển
SET @ScreenType = 4
SET @ScreenID = N'POF2104'
SET @ScreenName = N'Kế thừa thông tin vận chuyển'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

---------------------------------------------- Le Thanh Luan ----------------------------------------------------
----------------------------------------------- 23/08/2017 --------------------------------------------------------
------------------------------------------------ ScreenType = 1 ---------------------------------------------------
------------------------------------------------ Report = 1 ---------------------------------------------------

SET @ScreenType = 1
SET @ScreenID = N'POR3001'
SET @ScreenName = N'Xem chi tiết đơn hàng mua'
SET @ScreenNameE = N'Xem chi tiết đơn hàng mua'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo


---------------------------------------------- Le Thanh Luan ----------------------------------------------------
----------------------------------------------- 29/08/2017 --------------------------------------------------------
------------------------------------------------ ScreenType = 1 ---------------------------------------------------
------------------------------------------------ Report = 1 ---------------------------------------------------

SET @ScreenType = 1
SET @ScreenID = N'POR3002'
SET @ScreenName = N'Tổng hợp đơn hàng mua'
SET @ScreenNameE = N'Tổng hợp đơn hàng mua'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

---------------------------------------------- Trọng Kiên ----------------------------------------------------
---------------------------------------------- 24/11/2020 --------------------------------------------------------
---------------------------------------------- ScreenType = 1 ---------------------------------------------------
---------------------------------------------- Report = 1 ---------------------------------------------------
SET @ScreenType = 1
SET @ScreenID = N'POF3015'
SET @ScreenName = N'Báo cáo dự trù chi phí theo dự án'
SET @ScreenNameE = N'Báo cáo dự trù chi phí theo dự án'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

---------------------------------------------- Phân quyền màn hình DashBoard ------------------------------------
SET @ScreenType = 6

SET @ScreenID = N'POF0010'
SET @ScreenName = N'Dashboard Mua hàng'
SET @ScreenNameE = N'Dashboard Mua hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POD0000'
SET @ScreenName = N'Số liệu thống kê'
SET @ScreenNameE = N'Statics'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POD0001'
SET @ScreenName = N'Biểu đồ Top 10 nhóm hàng/mặt hàng/nhà cung cấp mua nhiều nhất'
SET @ScreenNameE = N'Statistics top 10'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POD0002'
SET @ScreenName = N'Biểu đồ biến động giá mua'
SET @ScreenNameE = N'Purchase price movement chart'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'POD0003'
SET @ScreenName = N'Trạng thái đơn hàng'
SET @ScreenNameE = N'Order status'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #PO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Xóa bảng tạm
DROP TABLE #PO_ERP9_PERMISSIONS