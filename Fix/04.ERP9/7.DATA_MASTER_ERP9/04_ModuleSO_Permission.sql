------------------------------------------------------------------------------------------------------
-- Fix Bổ sung phân quyền màn hình -- Module CRM
-- ScreenID: 1-Báo cáo; 2-Danh mục; 3-Nhập liệu; 4-Khác; 5-Chi tiết
------------------------------------------------------------------------------------------------------
-- Store Insert dữ liệu vào Table chuẩn
------------------------------------------------------------------------------------------------------
-- create by Toàn Thiện  Date 23/12/2015 
--# Update: Phương Thảo [30/03/2023] update  chỉnh vị trí phân quyền, 
--                                   bổ sung bảng tạm để đánh vị trí của màn hình theo file quản lí sản phẩm
--# Update: Thu Hà [20/11/2023] update  chỉnh vị trí phân quyền.                           
-- Thêm dữ liệu vào bảng Master

DECLARE @ModuleID AS NVARCHAR(50) = 'ASOFTSO'


DECLARE
	@ScreenID VARCHAR(50),
	@ScreenName NVARCHAR(MAX),
	@ScreenNameE NVARCHAR(MAX),
	@ScreenType TINYINT

DECLARE	@OrderNo INT;
DECLARE @CustomerIndex INT = (SELECT TOP 1 CustomerName FROM CustomerIndex WITH (NOLOCK));
-- Tạo bảng thứ tự
CREATE TABLE #SO_ERP9_PERMISSIONS
---DROP TABLE #SO_ERP9_PERMISSIONS
(
	ScreenID VARCHAR(50),
	OrderNo INT DEFAULT(0)
)
--- Đổ dữ liệu
INSERT INTO #SO_ERP9_PERMISSIONS
(ScreenID, OrderNo)
VALUES 
(N'SOF3000', 0),
(N'SOR30011', 1),
(N'SOR3000', 2),
(N'SOR3011', 3),
(N'SOR30020', 4),
(N'SOR30023', 5),
(N'SOR3003', 6),
(N'SOR30021', 7),
(N'SOR30018', 8),
(N'SOF3017', 21),
(N'SOF3014', 20),
(N'SOR30019', 23),
(N'SOR3012', 24),
(N'SOF3013', 19),
(N'SOF3015', 15),
(N'SOR3020', 9),
(N'SOR3019', 10),
(N'SOR3009', 11),
(N'SOR3018', 12),
(N'SOR3010', 13),
(N'SOR3005', 16),
(N'SOR3008', 14),
(N'SOR3004', 15),
(N'SOR3007', 17),
(N'SOR3006', 18),
(N'SOF3024', 26),
(N'SOF3025', 27),
(N'SOR3021', 28),
(N'SOR3022', 22),
(N'SOR3023', 23),
(N'SOF2110', 5),
(N'SOF2020', 6),
(N'SOF2000', 7),
(N'SOF2150', 8),
(N'SOF2170', 10),
(N'SOF2100', 9),
(N'SOF2120', 7),
(N'SOF2040', 8),
(N'CRMF2110A', 9),
(N'SOF2070', 10),
(N'SOF2160', 11),
(N'SOF2080', 12),
(N'SOF2090', 13),
(N'SOF2050', 14),
(N'SOF2130', 15),
(N'SOF2140', 16),
(N'SOF1080', 1),
(N'SOF1090', 3),
(N'SOF1060', 2),
(N'SOF1070', 4),
(N'SOF1040', 21),
(N'SOF2010', 11),
(N'SOF2060A', 12),
(N'SOF2060B', 13),
(N'SOF2060C', 14),
(N'SOF2190', 15),
(N'SOF2200', 16),
(N'SOF2210', 17),
(N'SOF2111', 16),
(N'SOF2021', 17),
(N'SOF2001', 18),
(N'SOF2151', 19),
(N'SOF2171', 21),
(N'SOF2101', 20),
(N'SOF2121', 7),
(N'CRMF2111B', 8),
(N'SOF2071', 9),
(N'SOF2161', 10),
(N'SOF2081', 11),
(N'SOF2091', 12),
(N'SOF2051', 13),
(N'SOF2131', 14),
(N'SOF2141', 15),
(N'SOF1061', 13),
(N'SOF1071', 15),
(N'SOF1041', 18),
(N'SOF2011', 22),
(N'SOF2061A', 23),
(N'SOF2061B', 24),
(N'SOF2061C', 25),
(N'SOF2036', 31),
(N'SOF2007', 28),
(N'SOF2035', 30),
(N'SOF30171', 32),
(N'SOF0002', 27),
(N'CMNF9009', 1),
(N'CMNF9011', 5),
(N'CMNF9012', 4),
(N'CMNF9010', 2),
(N'CMNF9013', 6),
(N'CMNF9014', 7),
(N'CMNF9015', 8),
(N'CMNF9016', 9),
(N'CMNF9017', 10),
(N'SOF1081', 11),
(N'SOF1084', 12),
(N'SOF1091', 14),
(N'SOF1082', 1),
(N'SOF1092', 3),
(N'SOF2005', 37),
(N'SOF2026', 38),
(N'SOF2027', 39),
(N'SOF2025', 40),
(N'SOF2063', 41),
(N'SOF2031', 42),
(N'SOF2033', 43),
(N'SOF2029', 29),
(N'SOF2034', 45),
(N'SOF20291', 46),
(N'SOF2084', 47),
(N'SOF2191', 26),
(N'SOF2201', 27),
(N'SOF2112', 5),
(N'SOF2022', 6),
(N'SOF2002', 8),
(N'SOF2152', 9),
(N'SOF2102', 7),
(N'SOF2122', 6),
(N'CRMF2112C', 7),
(N'SOF2072', 8),
(N'SOF2082', 9),
(N'SOF2092', 10),
(N'SOF2052', 11),
(N'SOF2132', 12),
(N'SOF2142', 13),
(N'SOF1062', 2),
(N'SOF1072', 4),
(N'SOF1042', 16),
(N'SOF2062', 17),
(N'SOF2062A', 18),
(N'SOF2062B', 19),
(N'SOF2062C', 20),
(N'SOF2172', 21),
(N'SOF2012', 22),
(N'SOF2032', 23),
(N'SOF1012', 24),
(N'SOF2192', 10),
(N'SOF2202', 11),
(N'SOF2212', 12),
(N'SOF0010', 1),
(N'SOD0000', 2),
(N'SOD0002', 3),
(N'SOD0001', 4),
(N'SOD0006', 5),
(N'SOD0003', 6),
(N'SOD0004', 7),
(N'SOD0005', 8),
(N'SOD0007', 9),
(N'CRMF9001', 1),
(N'CRMF9004', 2),
(N'SOF1063', 3),
(N'SOF0000', 4),
(N'SOF0005', 5),
(N'SOF0006', 6),
(N'SOF00021', 7),
(N'SOF0138', 8),
(N'SOF2006', 9),
(N'SOF2008', 10),
(N'SOF2014', 11),
(N'SOF2023', 12),
(N'SOF2023A', 13),
(N'SOF2024', 14),
(N'SOF2028', 15),
(N'SOF2053', 16),
(N'SOF2054', 17),
(N'SOF20541', 18),
(N'SOF2113', 19),
(N'SOF2114', 20),
(N'SOF2115', 21),
(N'SOF2172', 22),
(N'SOF2173', 23),
(N'SOF30161',24),
(N'SOF9001', 25),
(N'SOF9002', 26),
(N'SOF9003', 27),
(N'SOF9004', 28),
(N'SOF9010', 29),
(N'SOF9013', 30),
(N'SOF9024', 31),
(N'SOF2083', 32)

------------------------------------------------------------------------------------------------------
--- Báo cáo
------------------------------------------------------------------------------------------------------
SET @ScreenType =1
SET @ScreenID = N'SOF3000'
SET @ScreenName = N'Báo cáo'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOR3000'
SET @ScreenName = N'Chi tiết phiếu báo giá'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--SET @ScreenID = N'SOR3002'
--SET @ScreenName = N'Chi tiết đơn hàng bán'
--SET @ScreenNameE = N''
--SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
--EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOR30011'
SET @ScreenName = N'Tổng hợp tình hình báo giá'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOR3003'
SET @ScreenName = N'Báo cáo tổng hợp đơn hàng bán'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOR3004'
SET @ScreenName = N'Báo cáo tổng doanh số bán hàng theo mặt hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOR3005'
SET @ScreenName = N'Báo cáo doanh số bán hàng theo khu vực'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOR3006'
SET @ScreenName = N'Báo cáo doanh số trung bình theo nhân viên'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOR3007'
SET @ScreenName = N'Báo cáo doanh số  trung bình tháng theo nhân viên và công ty'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOR3008'
SET @ScreenName = N'Báo cáo tổng doanh số bán hàng theo khách hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOR3009'
SET @ScreenName = N'Báo cáo tổng doanh số bán hàng theo nhân viên'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOR3010'
SET @ScreenName = N'Báo cáo tổng doanh số bán hàng của nhân viên theo tháng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOR3011'
SET @ScreenName = N'Giá bán thực tế so với giá bán chuẩn'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOR3012'
SET @ScreenName = N'Báo cáo số lượng đơn hàng bán theo nhân viên'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF3013'
SET @ScreenName = N'Báo cáo so sánh doanh số mặt hàng theo tháng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF3014'
SET @ScreenName = N'Báo cáo thời gian giao hàng theo khách hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF3015'
SET @ScreenName = N'Báo cáo Kế hoạch bán hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'SOF3016'
SET @ScreenName = N'Báo cáo chi tiết tình hình nhận hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo


SET @ScreenID = N'SOF3017'
SET @ScreenName = N'Báo cáo chi tiết tình hình giao hàng theo đơn'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--[Trọng Kiên]  Update [01/12/2020]
SET @ScreenID = N'SOR30018'
SET @ScreenName = N'Tổng hợp tình hình giao hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOR30019'
SET @ScreenName = N'Báo cáo tình hình thanh toán theo đơn hàng bán'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOR30020'
SET @ScreenName = N'Báo cáo tổng hợp bán hàng theo loại sản phẩm'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Hoài Bảo [30/09/2022] - Báo cáo Chi tiết đơn hàng bán - SOR30021
SET @ScreenID = N'SOR30021'
SET @ScreenName = N'Báo cáo chi tiết thống kê mặt hàng theo đơn hàng bán'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOR30023'
SET @ScreenName = N'Báo cáo chi tiết đơn hàng bán theo loại sản phẩm'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Đình Hoà [19/08/2021] - Báo cáo Phương án kinh doanh và thực tế
SET @ScreenID = N'SOF3024'
SET @ScreenName = N'Báo cáo phương án kinh doanh và thực tế'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 141, NULL, @OrderNo


-- Minh Hiếu [23/12/2021] - Báo cáo tổng hợp bán hàng theo nhân viên và thời gian 
SET @ScreenID = N'SOR3018'
SET @ScreenName = N'Báo cáo tổng doanh số bán hàng của nhân viên theo ngày '
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo


---- Văn Tài [20/12/2021] - Báo cáo Phân tích Doanh số bán hàng
--SET @ScreenID = N'SOR30025'
--SET @ScreenName = N'Báo cáo Phân tích Doanh số bán hàng'
--SET @ScreenNameE = N''
--SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
--EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Kiều Nga [21/01/2022] - Báo cáo Phân tích Doanh số bán hàng
SET @ScreenID = N'SOF3025'
SET @ScreenName = N'Báo cáo Phân tích Doanh số bán hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

-- Nhựt Trường [23/02/2022] - Báo cáo doanh số Sale Out
SET @ScreenID = N'SOR3019'
SET @ScreenName = N'Báo cáo doanh số bán lẻ (Sell Out)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Nhựt Trường [02/03/2022] - Báo cáo doanh số Sale In
SET @ScreenID = N'SOR3020'
SET @ScreenName = N'Báo cáo doanh số bán sỉ (Sell In)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Nhựt Trường [06/03/2022] - Báo cáo doanh số nhà phân phối
SET @ScreenID = N'SOR3021'
SET @ScreenName = N'Báo cáo doanh số nhà phân phối'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'SOR3022'
SET @ScreenName = N'Báo cáo chương trình khuyến mãi theo đối tượng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Hoàng Long [22/12/2023] - N'Báo cáo tổng hợp doanh số treo tường kênh phân phối_RAC'
SET @ScreenID = N'SOR3023'
SET @ScreenName = N'Báo cáo tổng hợp doanh số treo tường kênh phân phối_RAC'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo
------------------------------------------------------------------------------------------------------
--- Danh mục
------------------------------------------------------------------------------------------------------
SET @ScreenType =2

SET @ScreenID = N'SOF2000'
SET @ScreenName = N'Danh mục đơn hàng bán sỉ (Sell In)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2150'
SET @ScreenName = N'Danh mục đơn hàng bán lẻ (Sell Out)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2010'
SET @ScreenName = N'Danh mục đơn hàng Nhà Phân Phối'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2040'
SET @ScreenName = N'Bản đồ'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'SOF2020'
SET @ScreenName = N'Danh mục báo giá'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2050' --- Customize DUCTIN
SET @ScreenName = N'Định mức Quota theo nhân viên'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 114, NULL, @OrderNo

SET @ScreenID = N'SOF1040' -------- Customize DUCTIN
SET @ScreenName = N'Danh mục công việc bảo hành bảo trì'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 114, NULL, @OrderNo

SET @ScreenID = N'SOF2060C'
SET @ScreenName = N'Danh sách phiếu báo giá (KHCU)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2060A'
SET @ScreenName = N'Danh sách phiếu báo giá (NC)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2060B'
SET @ScreenName = N'Danh sách phiếu báo giá (Sale)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2070' --- customize MAITHU
SET @ScreenName = N'kế hoạch bán hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 117, NULL, @OrderNo

SET @ScreenID = N'SOF2100'
SET @ScreenName = N'Danh mục tiến độ giao hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2090'--- customize MAITHU
SET @ScreenName = N'Danh mục đơn hàng điều chỉnh'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 117, NULL, @OrderNo

--- Đình Hòa - [28/04/2021] - Danh mục bảng tính giá 
SET @ScreenID = N'SOF2110'
SET @ScreenName = N'Danh mục bảng tính giá'
SET @ScreenNameE = N'Danh mục bảng tính giá'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Đình Hòa - [28/04/2021] - Danh mục bảng tính giá 
SET @ScreenID = N'SOF2120'
SET @ScreenName = N'Danh mục phiếu báo giá (Sale)'
SET @ScreenNameE = N'Danh mục phiếu báo giá (Sale)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 141, NULL, @OrderNo

--- Kiều Nga - [29/07/2021] - Danh mục phiếu báo giá (bộ phận kỹ thuật) 
SET @ScreenID = N'SOF2130' -------- Customize SGNP
SET @ScreenName = N'Danh mục phiếu báo giá (bộ phận kỹ thuật)'
SET @ScreenNameE = N'Danh mục phiếu báo giá (bộ phận kỹ thuật)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 141, NULL, @OrderNo

--- Đình Hòa - [02/08/2021] - Danh mục phiếu báo giá Sale 
SET @ScreenID = N'SOF2120'
SET @ScreenName = N'Danh mục phiếu báo giá (Sale)'
SET @ScreenNameE = N'Danh mục phiếu báo giá (Sale)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
IF(@CustomerIndex = 141)
	BEGIN
		EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 141, NULL, @OrderNo
	END
ELSE IF(@CustomerIndex = 145)
	BEGIN
		EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 145, NULL, @OrderNo
	END
ELSE 
	EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

--- Kiều Nga - [04/08/2021] - Danh mục phương án kinh doanh
SET @ScreenID = N'SOF2140'-------- Customize SGNP
SET @ScreenName = N'Danh mục phương án kinh doanh'
SET @ScreenNameE = N'Danh mục phương án kinh doanh'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 141, NULL, @OrderNo

--SET @ScreenType = 2
SET @ScreenID = N'SOF2160'---customize VNA
SET @ScreenName = N'Danh mục điều phối đơn hàng'
SET @ScreenNameE = N'Danh mục điều phối đơn hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 147, NULL, @OrderNo

--- Hoài Bảo - [11/07/2022] - Danh mục chỉ tiêu doanh số nhân viên bán sỉ (Sale In)
SET @ScreenID = N'SOF1060'
SET @ScreenName = N'Danh mục chỉ tiêu doanh số nhân viên bán sỉ (Sale In)'
SET @ScreenNameE = N'Danh mục chỉ tiêu doanh số nhân viên bán sỉ (Sale In)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Hoài Bảo - [14/07/2022] - Danh mục chỉ tiêu doanh số nhân viên bán lẻ (Sale Out)
SET @ScreenID = N'SOF1070'
SET @ScreenName = N'Danh mục chỉ tiêu doanh số nhân viên bán lẻ (Sale Out)'
SET @ScreenNameE = N'Danh mục chỉ tiêu doanh số nhân viên bán lẻ (Sale Out)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Thanh Lượng - [08/06/2023] - Danh mục kế hoạch doanh số (Sale In)
SET @ScreenID = N'SOF1080'
SET @ScreenName = N'Danh mục kế hoạch doanh số (Sell In)'
SET @ScreenNameE = N'Danh mục kế hoạch doanh số (Sell In)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Thanh Lượng - [25/07/2023] - Danh mục kế hoạch doanh số (Sale Out)
SET @ScreenID = N'SOF1090'
SET @ScreenName = N'Danh mục kế hoạch doanh số (Sell Out)'
SET @ScreenNameE = N'Danh mục kế hoạch doanh số (Sell Out)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Kiều Nga - [05/09/2022] - Điều phối
SET @ScreenID = N'SOF2170'
SET @ScreenName = N'Danh mục điều phối giao hàng'
SET @ScreenNameE = N'Danh mục điều phối giao hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Nhật Quang - [29/12/2022] - Dự toán
SET @ScreenID = N'CRMF2110A'
SET @ScreenName = N'Danh mục dự toán'
SET @ScreenNameE = N'Danh mục dự toán'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 158, NULL, @OrderNo

IF (@CustomerIndex = 166)
BEGIN
  INSERT INTO #SO_ERP9_PERMISSIONS
  (ScreenID, OrderNo)
  VALUES 
  (N'CRMF2110A', 9)
  SET @ScreenType = 2
  --- [Minh Dũng] [02/11/2023] - Dự toán
  SET @ScreenID = N'CRMF2110A'
  SET @ScreenName = N'Danh mục dự toán'
  SET @ScreenNameE = N'Danh mục dự toán'
  SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
  IF (@CustomerIndex = 166)
  BEGIN
  	EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo
  END
END

--- Hoàng Long - [23/10/2023] - Phiếu bảo hành sửa chữa
SET @ScreenID = N'SOF2190'
SET @ScreenName = N'Danh mục phiếu bảo hành sửa chữa'
SET @ScreenNameE = N'Danh mục phiếu bảo hành sửa chữa'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Hoàng Long - [29/11/2023] - Danh mục tài khoản T-Card/D-Card
SET @ScreenID = N'SOF2200'
SET @ScreenName = N'Danh mục tài khoản kích hoạt'
SET @ScreenNameE = N'Danh mục tài khoản kích hoạt'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Hoàng Long - [29/11/2023] - Danh mục tài khoản đã kích hoạt
SET @ScreenID = N'SOF2210'
SET @ScreenName = N'Danh mục thông tài khoản đã kích hoạt'
SET @ScreenNameE = N'Danh mục thông tài khoản đã kích hoạt'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

------------------------------------------------------------------------------------------------------
--- Nhập liệu
------------------------------------------------------------------------------------------------------
SET @ScreenType = 3

SET @ScreenID = N'SOF20291'
SET @ScreenName = N'Chọn mẫu in phiếu báo giá'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'SOF0002'
SET @ScreenName = N'Thiết lập mặc định loại chứng từ'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2001'
SET @ScreenName = N'Cập nhật đơn hàng bán sỉ (Sell In)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2151'
SET @ScreenName = N'Cập nhật đơn hàng lẻ (Sell Out)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2011'
SET @ScreenName = N'Cập nhật đơn hàng Nhà Phân Phối'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2031'
SET @ScreenName = N'Xác nhận đi'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 51, NULL, @OrderNo

SET @ScreenID = N'SOF2033'
SET @ScreenName = N'Thủ kho xác nhận giao hàng về'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 51, NULL, @OrderNo

SET @ScreenID = N'SOF2021'
SET @ScreenName = N'Cập nhật báo giá'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2034'
SET @ScreenName = N'Xác nhận tiến độ nhận hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 57, NULL, @OrderNo

SET @ScreenID = N'SOF2035'
SET @ScreenName = N'Kế thừa dữ liệu từ App Mobile'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2051'
SET @ScreenName = N'Cập nhật định mức Quota theo nhân viên'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 114, NULL, @OrderNo

SET @ScreenID = N'SOF1041'
SET @ScreenName = N'Cập nhật công việc bảo hành bảo trì'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 114, NULL, @OrderNo

SET @ScreenID = N'SOF2025'
SET @ScreenName = N'Cập nhật thông tin bảo hành'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 114, NULL, @OrderNo

SET @ScreenID = N'SOF2026'
SET @ScreenName = N'Chọn mẫu in'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 114, NULL, @OrderNo

SET @ScreenID = N'SOF2027'
SET @ScreenName = N'Cập nhật thông tin phụ kiện'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 114, NULL, @OrderNo

SET @ScreenID = N'SOF2061C'
SET @ScreenName = N'Cập nhật phiếu báo giá (KHCU)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2061A'
SET @ScreenName = N'Cập nhật phiếu báo giá (NC)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2061B'
SET @ScreenName = N'Cập nhật phiếu báo giá (Sale)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2063'
SET @ScreenName = N'Cập nhật thông tin chi tiết báo giá'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 114, NULL, @OrderNo

SET @ScreenID = N'SOF2071' --- customize MAITHU
SET @ScreenName = N'Cập nhật kế hoạch bán hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 117, NULL, @OrderNo

SET @ScreenID = N'SOF2091' --- customize MAITHU
SET @ScreenName = N'Cập nhật đơn hàng điều chỉnh'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 117, NULL, @OrderNo

--- Đình Hòa - [28/04/2021] - Cập nhật bảng tính giá 
SET @ScreenID = N'SOF2111'
SET @ScreenName = N'Cập nhật bảng tính giá'
SET @ScreenNameE = N'Cập nhật bảng tính giá'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Đình Hòa - [30/06/2021] - Chọn mẫu in đơn hàng bán 
SET @ScreenID = N'SOF2005'  ---- Customize MECI
SET @ScreenName = N'Chọn mẫu in đơn hàng bán'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 137, NULL, @OrderNo

--- Kiều Nga - [30/07/2021] - Cập nhật phiếu báo giá (bộ phận kỹ thuật) 
SET @ScreenID = N'SOF2131'
SET @ScreenName = N'Cập nhật phiếu báo giá (bộ phận kỹ thuật)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 141, NULL, @OrderNo

--- Đình Hòa - [02/08/2021] - Cập nhật bảng phiếu báo giá Sale
SET @ScreenID = N'SOF2121' -------- Customize SGNP
SET @ScreenName = N'Cập nhật bảng phiếu báo giá Sale'
SET @ScreenNameE = N'Cập nhật bảng phiếu báo giá Sale'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
IF(@customerIndex = 141)
	BEGIN
		EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 141, NULL, @OrderNo
	END
ELSE IF(@customerIndex = 145)
	BEGIN
		EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 145, NULL, @OrderNo
	END
ELSE
	EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

--- Kiều Nga - [04/08/2021] - Cập nhật phương án kinh doanh 
SET @ScreenID = N'SOF2141'
SET @ScreenName = N'Cập nhật phương án kinh doanh'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 141, NULL, @OrderNo

--- Minh Hiếu - [12/04/2022] - Cập nhật điều phối
SET @ScreenID = N'SOF2161' --VNA
SET @ScreenName = N'Cập nhật điều phối'
SET @ScreenNameE = N'Cập nhật điều phối'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 147, NULL, @OrderNo

--- Hoài Bảo - [11/07/2022] - Cập nhật chỉ tiêu doanh số nhân viên bán sỉ (Sale In)
SET @ScreenID = N'SOF1061'
SET @ScreenName = N'Cập nhật chỉ tiêu doanh số nhân viên bán sỉ (Sale In)'
SET @ScreenNameE = N'Cập nhật chỉ tiêu doanh số nhân viên bán sỉ (Sale In)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Hoài Bảo - [14/07/2022] - Cập nhật chỉ tiêu doanh số nhân viên bán lẻ (Sale Out)
SET @ScreenID = N'SOF1071'
SET @ScreenName = N'Cập nhật chỉ tiêu doanh số nhân viên bán lẻ (Sale Out)'
SET @ScreenNameE = N'Cập nhật chỉ tiêu doanh số nhân viên bán lẻ (Sale Out)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Thanh Lượng - [08/06/2023] - Cập nhật kế hoạch doanh số (Sale In)
SET @ScreenID = N'SOF1081'
SET @ScreenName = N'Cập nhật kế hoạch doanh số theo năm (Sell In)'
SET @ScreenNameE = N'Cập nhật kế hoạch doanh số theo năm (Sell In)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID, @ScreenType, @ScreenName, @ScreenNameE, -1, NULL, @OrderNo

--- Thanh Lượng - [25/07/2023] - Cập nhật kế hoạch doanh số (Sell Out)
SET @ScreenID = N'SOF1091'
SET @ScreenName = N'Cập nhật kế hoạch doanh số theo năm (Sell Out)'
SET @ScreenNameE = N'Cập nhật kế hoạch doanh số theo năm (Sell Out)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID, @ScreenType, @ScreenName, @ScreenNameE, -1, NULL, @OrderNo

--- Thanh Lượng - [08/06/2023] - Cập nhật kế hoạch doanh số (Sale In)
SET @ScreenID = N'SOF1084'
SET @ScreenName = N'Cập nhật kế hoạch doanh số theo tháng (Sell-In)'
SET @ScreenNameE = N'Cập nhật kế hoạch doanh số theo tháng (Sell-In)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID, @ScreenType, @ScreenName, @ScreenNameE, -1, NULL, @OrderNo

--- Kiều Nga - [07/09/2022] - Cập nhật điều phối
SET @ScreenID = N'SOF2171'
SET @ScreenName = N'Cập nhật điều phối giao hàng'
SET @ScreenNameE = N'Cập nhật điều phối giao hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--[Đức Tuyên] Update [05/01/2023]
SET @ScreenID = N'SOF2007'
SET @ScreenName = N'Chọn mẫu in đơn hàng bán'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Nhật Quang - [29/12/2022] - Cập nhật dự toán
SET @ScreenID = N'CRMF2111B'----------- Customize HIPC
SET @ScreenName = N'Cập nhật dự toán'
SET @ScreenNameE = N'Cập nhật dự toán'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 158, NULL, @OrderNo

--- [Minh Dũng] [02/11/2023] - Dự toán
IF (@CustomerIndex = 166)
BEGIN
  SET @ScreenType = 3
  
  SET @ScreenID = N'CRMF2111B'
  SET @ScreenName = N'Cập nhật dự toán'
  SET @ScreenNameE = N'Cập nhật dự toán'
  SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
  IF (@CustomerIndex = 166)
  BEGIN
  	EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo
  END
END

--- Hoàng Long - [23/10/2023] - Cập nhật phiếu bảo hành sửa chữa
SET @ScreenID = N'SOF2191'
SET @ScreenName = N'Cập nhật phiếu bảo hành sửa chữa'
SET @ScreenNameE = N'Cập nhật phiếu bảo hành sửa chữa'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2201'
SET @ScreenName = N'Cập nhật tài khoản kích hoạt'
SET @ScreenNameE = N'Cập nhật tài khoản kích hoạt'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

------------------------------------------------------------------------------------------------------
--- Khác (Thiết lập)
------------------------------------------------------------------------------------------------------
SET @ScreenType = 4
SET @ScreenID = N'SOF0000'
SET @ScreenName = N'Thiết lập hệ thống'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'SOF0005'
SET @ScreenName = N'Thiết lập thông tin loại chứng từ'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'SOF0006'
SET @ScreenName = N'Thiết lập thông tin loại mặt hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'SOF2014'
SET @ScreenName = N'Tim kiếm mặt hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'SOF2024'
SET @ScreenName = N'Chọn báo giá'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'SOF2023'
SET @ScreenName = N'Kế thừa phiếu báo giá'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF0138'
SET @ScreenName = N'Kế thừa đơn hàng mua'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'SOF2053'
SET @ScreenName = N'Danh sách các nhân viên sử dụng vượt định mức đối với phòng TCKT, nhà quản lý'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--[Học Huy] Update [19/11/2019]
SET @ScreenType = 4
SET @ScreenID = N'SOF00021'
SET @ScreenName = N'Chọn loại chứng từ đơn hàng gia công'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--[Học Huy] Update [20/11/2019]
SET @ScreenType = 4
SET @ScreenID = N'SOF2006'
SET @ScreenName = N'Kế thừa đơn hàng gia công'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'SOF2054'
SET @ScreenName = N'Danh sách đơn hàng giao trễ theo qui cách sản phẩm'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ModuleID = N'AsoftSO'
SET @ScreenType = 4
SET @ScreenID = N'SOF9001'
SET @ScreenName = N'Chọn mặt hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ModuleID = N'AsoftSO'
SET @ScreenType = 4
SET @ScreenID = N'SOF9002'
SET @ScreenName = N'Chọn sơ đồ tuyến'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ModuleID = N'AsoftSO'
SET @ScreenType = 4
SET @ScreenID = N'SOF9003'
SET @ScreenName = N'Chọn bộ định mức (KIT)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ModuleID = N'AsoftSO'
SET @ScreenType = 4
SET @ScreenID = N'SOF9004'
SET @ScreenName = N'Chọn Target chương trình khuyến mãi'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'SOF2028'
SET @ScreenName = N'Kế thừa dự toán báo giá'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--[Đình Hoà] Update [20/08/2020]
SET @ScreenType = 4
SET @ScreenID = N'SOF30161'
SET @ScreenName = N'Chọn đơn hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--[Đình Hòa] [30/12/2020] Edit ScreenType từ 4 thành 3 mới phân quyền cho màn hình này được
SET @ScreenType = 3
SET @ScreenID = N'SOF30171'
SET @ScreenName = N'Tổng hợp các loại đơn hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, 'ERP9', NULL,@OrderNo


--[Trọng Kiên] Update [11/12/2020]
SET @ScreenType = 4
SET @ScreenID = N'SOF20541'
SET @ScreenName = N'Danh sách đơn hàng giao trễ theo qui cách sản phẩm'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--[Đình Hòa]  [15/03/2021] - Thêm màn hình vào SO
SET @ScreenType = 4
SET @ScreenID = N'CRMF9001'
SET @ScreenName = N'Chọn đối tượng'
SET @ScreenNameE = N'Select Object'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'SOF9024'
SET @ScreenName = N'Chọn khách hàng'
SET @ScreenNameE = N'Chọn khách hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'SOF9010'
SET @ScreenName = N'Chọn sự kiện'
SET @ScreenNameE = N'Chọn sự kiện'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'SOF9013'
SET @ScreenName = N'Chọn cơ hội'
SET @ScreenNameE = N'Chọn cơ hội'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Đình Hòa - [05/05/2021] - Kế thừa BOM
SET @ScreenType = 4
SET @ScreenID = N'SOF2113'
SET @ScreenName = N'Kế thừa BOM'
SET @ScreenNameE = N'Kế thừa BOM'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Đình Hòa - [06/05/2021] - Chọn tiêu chuẩn
SET @ScreenType = 4
SET @ScreenID = N'SOF2114'
SET @ScreenName = N'Kế thừa BOM'
SET @ScreenNameE = N'Kế thừa BOM'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Đình Hòa - [17/05/2021] - Kế thừa bảng tính giá
SET @ScreenType = 4
SET @ScreenID = N'SOF2115'
SET @ScreenName = N'Kế thừa dự bảng tính giá'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Đình Hòa - [03/08/2021] - Kế thừa phiếu báo giá Sale
SET @ScreenType = 4
SET @ScreenID = N'SOF2023A'
SET @ScreenName = N'Kế thừa phiếu báo giá Sale'
SET @ScreenNameE = N'Kế thừa phiếu báo giá Sale'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Hoài Bảo - [15/07/2022] - Kế thừa chỉ tiêu doanh số nhân viên (Sale In)
SET @ScreenType = 4
SET @ScreenID = N'SOF1063'
SET @ScreenName = N'Kế thừa chỉ tiêu doanh số nhân viên (Sale In)'
SET @ScreenNameE = N'Kế thừa chỉ tiêu doanh số nhân viên (Sale In)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Kiều Nga - [14/09/2022] - Chọn xe
SET @ScreenType = 4
SET @ScreenID = N'SOF2172'
SET @ScreenName = N'Chọn xe'
SET @ScreenNameE = N'Chọn xe'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Kiều Nga - [14/09/2022] - Chọn đơn hàng
SET @ScreenType = 4
SET @ScreenID = N'SOF2173'
SET @ScreenName = N'Chọn đơn hàng'
SET @ScreenNameE = N'Chọn đơn hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Hoàng Long - [19/10/2023] - Kế thừa đơn hàng APP
SET @ScreenType = 4
SET @ScreenID = N'SOF2008'
SET @ScreenName = N'Kế thừa đơn hàng APP'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo
------------------------------------------------------------------------------------------------------
--- Chi tiết
------------------------------------------------------------------------------------------------------
SET @ScreenType = 5

SET @ScreenID = N'SOF2002'
SET @ScreenName = N'Chi tiết đơn hàng bán sỉ (Sell In)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2152'
SET @ScreenName = N'Chi tiết đơn hàng bán lẻ (Sell Out)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2012'
SET @ScreenName = N'Chi tiết đơn hàng Nhà Phân Phối'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 57, NULL, @OrderNo

SET @ScreenID = N'SOF2032'
SET @ScreenName = N'Xác nhận về'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 51, NULL, @OrderNo

SET @ScreenID = N'SOF2022'
SET @ScreenName = N'Xem chi tiết báo giá'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF1012'
SET @ScreenName = N'Xem thông tin bảng giá theo Model'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 88, NULL, @OrderNo

SET @ScreenID = N'SOF2052'
SET @ScreenName = N'Xem chi tiết hạn mức Quota theo nhân viên'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 114, NULL, @OrderNo

SET @ScreenID = N'SOF1042'
SET @ScreenName = N'Xem chi tiết công việc bảo hành bảo trì'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 114, NULL, @OrderNo

SET @ScreenID = N'SOF2062'
SET @ScreenName = N'Xem chi tiết phiếu báo giá'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 114, NULL, @OrderNo

SET @ScreenID = N'SOF2062A'
SET @ScreenName = N'Xem chi tiết phiếu báo giá (NC)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 114, NULL, @OrderNo

SET @ScreenID = N'SOF2062B'
SET @ScreenName = N'Xem chi tiết phiếu báo giá (Sale)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 114, NULL, @OrderNo

SET @ScreenID = N'SOF2062C'
SET @ScreenName = N'Xem chi tiết phiếu báo giá (KHCU)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 114, NULL, @OrderNo

SET @ScreenID = N'SOF2072' --- customize MAITHU
SET @ScreenName = N'Xem chi tiết kế hoạch bán hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 117, NULL, @OrderNo

SET @ScreenID = N'SOF2092' --- customize MAITHU
SET @ScreenName = N'Xem thông tin đơn hàng điều chỉnh'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 117, NULL, @OrderNo

--- Đình Hòa - [28/04/2021] - Xem chi tiết bảng tính giá 
SET @ScreenID = N'SOF2112'
SET @ScreenName = N'Xem chi tiết bảng tính giá'
SET @ScreenNameE = N'Xem chi tiết bảng tính giá'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Đình Hòa - [02/08/2021] - Xem chi tiết phiếu báo giá Sale 
SET @ScreenID = N'SOF2122'
SET @ScreenName = N'Xem chi tiết phiếu báo giá Sale'
SET @ScreenNameE = N'Xem chi tiết phiếu báo giá Sale'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
IF(@customerIndex = 141)
	BEGIN
		EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 141, NULL, @OrderNo
	END
ELSE IF(@customerIndex = 145)
	BEGIN
		EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 145, NULL, @OrderNo
	END
ELSE	
	EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo


--- Kiều Nga - [02/08/2021] - Xem chi tiết phiếu báo giá
SET @ScreenID = N'SOF2132'
SET @ScreenName = N'Xem chi tiết phiếu báo giá'
SET @ScreenNameE = N'Xem chi tiết phiếu báo giá'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 141, NULL, @OrderNo

--- Kiều Nga - [10/08/2021] - Xem chi tiết phương án kinh doanh
SET @ScreenID = N'SOF2142'
SET @ScreenName = N'Xem chi tiết phương án kinh doanh'
SET @ScreenNameE = N'Xem chi tiết phương án kinh doanh'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 141, NULL, @OrderNo

--- Hoài Bảo - [11/07/2022] - Xem chi tiết chi tiêu doanh số nhân viên
SET @ScreenID = N'SOF1062'
SET @ScreenName = N'Xem chi tiết chi tiêu doanh số nhân viên bán sỉ (Sell In)'
SET @ScreenNameE = N'Xem chi tiết chi tiêu doanh số nhân viên bán sỉ (Sell In)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Hoài Bảo - [14/07/2022] - Xem chi tiết chỉ tiêu doanh số nhân viên bán lẻ (Sale Out)
SET @ScreenID = N'SOF1072'
SET @ScreenName = N'Xem chi tiết chỉ tiêu doanh số nhân viên bán lẻ (Sale Out)'
SET @ScreenNameE = N'Xem chi tiết chỉ tiêu doanh số nhân viên bán lẻ (Sale Out)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Thanh Lượng - [08/06/2023] - Xem chi tiết kế hoạch doanh số (Sell In)
SET @ScreenID = N'SOF1082'
SET @ScreenName = N'Xem chi tiết kế hoạch doanh số (Sell In)'
SET @ScreenNameE = N'Xem chi tiết kế hoạch doanh số (Sell In)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID, @ScreenType, @ScreenName, @ScreenNameE, -1, NULL, @OrderNo
------------------------------

--- Thanh Lượng - [25/07/2023] - Xem chi tiết kế hoạch doanh số (Sell Out)
SET @ScreenID = N'SOF1092'
SET @ScreenName = N'Xem chi tiết kế hoạch doanh số (Sell Out)'
SET @ScreenNameE = N'Xem chi tiết kế hoạch doanh số (Sell Out)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID, @ScreenType, @ScreenName, @ScreenNameE, -1, NULL, @OrderNo
------------------------------

SET @ScreenType = 2
SET @ScreenID = N'SOF2080'-- customize MAITHU
SET @ScreenName = N'Danh mục thông tin sản xuất'
SET @ScreenNameE = N'Danh mục thông tin sản xuất'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 117, NULL, @OrderNo

SET @ScreenType = 3
SET @ScreenID = N'SOF2081' ---MAITHU
SET @ScreenName = N'Cập nhật thông tin sản xuất'
SET @ScreenNameE = N'Cập nhật thông tin sản xuất'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 117, NULL, @OrderNo

SET @ScreenType = 5
SET @ScreenID = N'SOF2082'
SET @ScreenName = N'Xem chi tiết thông tin sản xuất'
SET @ScreenNameE = N'Xem chi tiết thông tin sản xuất'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 117, NULL, @OrderNo

SET @ScreenType = 4
SET @ScreenID = N'SOF2083'
SET @ScreenName = N'Chọn đơn hàng bán'
SET @ScreenNameE = N'Chọn đơn hàng bán'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 3
SET @ScreenID = N'SOF2101'
SET @ScreenName = N'Cập nhật tiến độ giao hàng'
SET @ScreenNameE = N'Cập nhật tiến độ giao hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 5
SET @ScreenID = N'SOF2102'
SET @ScreenName = N'Xem chi tiết tiến độ giao hàng'
SET @ScreenNameE = N'Xem chi tiết tiến độ giao hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 5
SET @ScreenID = N'CRMF2112C'
SET @ScreenName = N'Xem chi tiết dự toán'
SET @ScreenNameE = N'Xem chi tiết dự toán'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 158, NULL, @OrderNo

--- [Minh Dũng] [02/11/2023] - Dự toán
IF (@CustomerIndex = 166)
BEGIN
  ----- Xem chi tiết dự toán
  SET @ScreenType = 5
  
  SET @ScreenID = N'CRMF2112C'
  SET @ScreenName = N'Xem chi tiết dự toán'
  SET @ScreenNameE = N'Xem chi tiết dự toán'
  SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
  IF (@CustomerIndex = 166)
  BEGIN
  	EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo
  END
END

--- Hoàng Long - [23/10/2023] - Xem chi tiết phiếu bảo hành sửa chữa
SET @ScreenID = N'SOF2192'
SET @ScreenName = N'Xem chi tiết phiếu bảo hành sửa chữa'
SET @ScreenNameE = N'Xem chi tiết phiếu bảo hành sửa chữa'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Hoàng Long - [29/12/2023] - Xem chi tiết tài khoản kích hoạt
SET @ScreenID = N'SOF2202'
SET @ScreenName = N'Xem chi tiết tài khoản kích hoạt'
SET @ScreenNameE = N'Xem chi tiết tài khoản kích hoạt'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOF2212'
SET @ScreenName = N'Xem chi tiết kích hoạt tài khoản'
SET @ScreenNameE = N'Xem chi tiết kích hoạt tài khoản'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--------------------------------Chọn khách hàng --------------------------------
SET @ModuleID = 'AsoftSO'
SET @ScreenType = 4
SET @ScreenID = N'CRMF9004'
SET @ScreenName = N'Chọn khách hàng'
SET @ScreenNameE = N'Chọn khách hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-------------------------------MAI THU - Thông tin sản xuất-------------------------
SET @ModuleID = 'AsoftSO'
SET @ScreenType = 2
SET @ScreenID = N'SOF2080'
SET @ScreenName = N'Danh mục thông tin sản xuất'
SET @ScreenNameE = N'Danh mục thông tin sản xuất'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenType = 3
SET @ScreenID = N'SOF2081'
SET @ScreenName = N'Cập nhật thông tin sản xuất'
SET @ScreenNameE = N'Cập nhật thông tin sản xuất'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenType = 5
SET @ScreenID = N'SOF2082'
SET @ScreenName = N'Xem chi tiết thông tin sản xuất'
SET @ScreenNameE = N'Xem chi tiết thông tin sản xuất'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE



SET @ScreenType = 3
SET @ScreenID = N'SOF2084'
SET @ScreenName = N'Cập nhật file thiết kế'
SET @ScreenNameE = N'Cập nhật file thiết kế'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 117, NULL, @OrderNo

SET @ScreenType = 3
SET @ScreenID = N'SOF2029'
SET @ScreenName = N'Chọn mẫu in phiếu thông tin sản xuất'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 3
SET @ScreenID = N'SOF2036'
SET @ScreenName = N'Chọn mẫu in phiếu báo giá'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CMNF9009'
SET @ScreenName = N'Chọn nhân viên Sales (Sale Out)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CMNF9010'
SET @ScreenName = N'Chọn đối tượng nhà cung cấp'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CMNF9011'
SET @ScreenName = N'Chọn nhân viên SUP (Sell Out)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CMNF9012'
SET @ScreenName = N'Chọn nhân viên ASM (Sell Out)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CMNF9013'
SET @ScreenName = N'Chọn khu vực'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CMNF9014'
SET @ScreenName = N'Chọn loại mặt hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CMNF9015'
SET @ScreenName = N'Chọn nhóm mặt hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CMNF9016'
SET @ScreenName = N'Chọn nhân viên cấp ADMIN'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CMNF9017'
SET @ScreenName = N'Chọn nhân viên cấp quản lý ADMIN'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

---------------------------------------------- Phân quyền màn hình DashBoard ------------------------------------
SET @ScreenType = 6

SET @ScreenID = N'SOF0010'
SET @ScreenName = N'Dashboard Bán hàng'
SET @ScreenNameE = N'Dashboard Bán hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOD0000'
SET @ScreenName = N'Số liệu thống kê'
SET @ScreenNameE = N'Statics'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOD0001'
SET @ScreenName = N'Tỉ lệ hoàn thành kế hoạch doanh số'
SET @ScreenNameE = N'Sales plan completion rate'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOD0002'
SET @ScreenName = N'Doanh số thực tế so với kế hoạch'
SET @ScreenNameE = N'Actual sales compared to plan'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOD0003'
SET @ScreenName = N'Doanh số theo nhân viên bán hàng'
SET @ScreenNameE = N'Sales by salesperson'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOD0004'
SET @ScreenName = N'Top 10 sản phẩm bán chạy'
SET @ScreenNameE = N'Top 10 best selling products'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOD0005'
SET @ScreenName = N'Top 10 khách hàng doanh số cao nhất'
SET @ScreenNameE = N'Top 10 highest sales customers'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOD0006'
SET @ScreenName = N'Trạng thái đơn hàng'
SET @ScreenNameE = N'Order status'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'SOD0007'
SET @ScreenName = N'Top 10 sản phẩm bán chạy(theo thành tiền)'
SET @ScreenNameE = N'Top 10 best selling products for money'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #SO_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo