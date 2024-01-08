------------------------------------------------------------------------------------------------------
-- Fix Bổ sung phân quyền màn hình -- Module CRM
-- ScreenID: 1-Báo cáo; 2-Danh mục; 3-Nhập liệu; 4-Khác; 5-Chi tiết
------------------------------------------------------------------------------------------------------
-- Store Insert dữ liệu vào Table chuẩn
------------------------------------------------------------------------------------------------------
-- create by Toàn Thiện  Date 23/12/2015 
--# Update: Phương Thảo [30/03/2023] update  chỉnh vị trí phân quyền, 
--                                   bổ sung bảng tạm để đánh vị trí của màn hình theo file quản lí sản phẩm
--# Update: Thu Hà [14/11/2023] update  chỉnh vị trí phân quyền, bổ sung bảng tạm #CRM_ERP9_PERMISSIONS_1 để đánh vị trí thứ tự

-- Thêm dữ liệu vào bảng Master

DECLARE @ModuleID AS NVARCHAR(50) = 'ASOFTCRM'

DECLARE
	@ScreenID VARCHAR(50),
	@ScreenName NVARCHAR(MAX),
	@ScreenNameE NVARCHAR(MAX),
	@ScreenType TINYINT


DECLARE	@OrderNo INT;

--- Tạo bảng thứ tự
CREATE TABLE #CRM_ERP9_PERMISSIONS
--Drop TABLE #CRM_ERP9_PERMISSIONS
(
	ScreenID VARCHAR(50),
	OrderNo INT DEFAULT(0)
)
INSERT INTO #CRM_ERP9_PERMISSIONS
(ScreenID, OrderNo)
VALUES 
(N'CRMF3000', 1),
(N'CRMR3019', 2),
(N'CRMR3018', 3),
(N'CRMR3021', 4),
(N'CRMR3017', 5),
(N'CRMR3012', 6),
(N'CRMR3013', 7),
(N'CRMR3001', 8),
(N'CRMR3016', 9),
(N'CRMR3002', 10),
(N'CRMR3004', 11),
(N'CRMR3003', 12),
(N'CRMR3006', 13),
(N'CRMR3007', 14),
(N'CRMR3014', 15),
(N'CRMR3015', 16),
(N'CRMF3080', 17),
(N'CRMR3005', 18),
(N'CRMR3009', 19),
(N'CRMR3008', 20),
(N'CRMR3010', 21),
(N'CRMR3011', 22),
(N'CRMF3060', 23),
(N'CRMF3010', 24),
(N'CRMF3020', 25),
(N'CRMF3030', 26),
(N'CRMF3040', 27),
(N'CRMF3050', 28),
(N'CRMF3001', 29),
(N'CRMF3002', 30),
(N'CRMF3070', 31),
(N'CRMR3022', 32),
(N'CRMF2210', 1),
(N'CRMF2040', 2),
(N'CRMF2140', 3),
(N'CRMF2190', 4),
(N'CRMF2030', 5),
(N'CRMF2050', 6),
(N'CRMF2080', 7),
(N'CRMF1010', 8),
(N'CRMF1000', 9),
(N'CIF1360', 10),
(N'CRMF2150', 11),
(N'CRMF2160', 12),
(N'CRMF2170', 13),
(N'CRMF2120', 14),
(N'CRMF2220', 15),
(N'CRMF2230', 16),
(N'CRMF2240', 17),
(N'CRMF2130', 18),
(N'CRMF2010', 19),
(N'CRMF2020', 20),
(N'CRMF2090', 21),
(N'CRMF2100', 22),
(N'CRMF2110', 23),
(N'CRMF1030', 24),
(N'CRMF1020', 25),
(N'CRMF1040', 26),
(N'CRMF1080', 27),
(N'CRMF1050', 28),
(N'CRMF1060', 29),
(N'CRMF1070', 30),
(N'CRMF1090', 31),
(N'CRMF2211', 1),
(N'CRMF2041', 2),
(N'CRMF2141', 3),
(N'CRMF2191', 4),
(N'CRMF2031', 5),
(N'CRMF2051', 6),
(N'CRMF2081', 7),
(N'CRMF1011', 8),
(N'CRMF1001', 9),
(N'CIF1361', 10),
(N'CRMF2161', 11),
(N'CRMF2171', 12),
(N'CRMF1031', 13),
(N'CRMF1021', 14),
(N'CRMF1041', 15),
(N'CRMF1081', 16),
(N'CRMF1051', 17),
(N'CRMF1061', 18),
(N'CRMF1071', 19),
(N'CRMF1091', 20),
(N'CRMF2000', 21),
(N'CRMF2001', 22),
(N'CRMF2002', 23),
(N'CRMF2003', 24),
(N'CRMF2004', 25),
(N'CRMF2005', 26),
(N'CRMF2006', 27),
(N'CRMF2007', 28),
(N'CRMF90031', 29),
(N'CRMF2201', 30),
(N'CRMF2213', 31),
(N'CRMF2215', 32),
(N'CRMF2033', 33),
(N'CRMF2181', 34),
(N'CRMF2121', 35),
(N'CRMF0003', 36),
(N'CRMF0002', 37),
(N'CRMF2171', 38),
(N'CRMF2174', 39),
(N'CRMF2011', 40),
(N'CRMF2021', 41),
(N'CRMF2023', 42),
(N'CRMF2231', 43),
(N'CRMF2241', 44),
(N'CRMF2131', 45),
(N'CRMF9005', 46),
(N'CRMF9026', 47),
(N'CRMF2221', 48),
(N'CRMF2091', 49),
(N'CRMF2101', 50),
(N'CRMF2111', 51),
(N'CRMF0000', 52),
(N'CRMF2212', 1),
(N'CRMF2042', 2),
(N'CRMF2142', 3),
(N'CRMF2192', 4),
(N'CRMF2032', 5),
(N'CRMF2052', 6),
(N'CRMF2082', 7),
(N'CRMF1012', 8),
(N'CRMF1002', 9),
(N'CIF1362', 10),
(N'CRMF2162', 11),
(N'CRMF2172', 12),
(N'CRMF2122', 13),
(N'CRMF2222', 14),
(N'CRMF2232', 15),
(N'CRMF2242', 16),
(N'CRMF2132', 17),
(N'CRMF2022', 18),
(N'CRMF2092', 19),
(N'CRMF2102', 20),
(N'CRMF2112', 21),
(N'CRMF1032', 22),
(N'CRMF1022', 23),
(N'CRMF1042', 24),
(N'CRMF1082', 25),
(N'CRMF1052', 26),
(N'CRMF1062', 27),
(N'CRMF1072', 28),
(N'CRMF1092', 29),
(N'CRMF0020', 1),
(N'CRMD0023', 2),
(N'CRMD0024', 3),
(N'CRMD0025', 4),
(N'CRMD0026', 5),
(N'CRMD0027', 6),
(N'CRMD0028', 7),
(N'CRMF0030', 8),
(N'CRMD0031', 9),
(N'CRMD0032', 10),
(N'CRMD0033', 11),
(N'CRMD0034', 12),
(N'CRMD0035', 13),
(N'CRMD0001', 14),
(N'CRMD0003', 15),
(N'CRMD0004', 16),
(N'CRMD0021', 17),
(N'CRMD0022', 18),
(N'CRMD0029', 19),
(N'CRMD0030', 20),
-- Màn hình khác
(N'CMNF90081', 1),
(N'CRMF9016', 2),
(N'CRMF9017', 3),
(N'CRMF1023', 4),
(N'CRMF9018', 5),
(N'CRMF2214', 6),
(N'CRMF9008', 7),
(N'CRMF9014', 8),
(N'CRMF9021', 9),
(N'CRMF9013', 10),
(N'CRMF9015', 11),
(N'CRMF9001', 12),
(N'CRMF2244', 13),
(N'CRMF9004', 14),
(N'CRMF9024', 15),
(N'CRMF9025', 16),
(N'CIF1363', 17),
(N'CRMF2153', 18),
(N'CRMF2163', 19),
(N'CRMF2173', 20),
(N'CRMF0001', 21),
(N'CRMF9002', 22),
(N'CRMF9003', 23),
(N'CRMF9010', 24),
(N'CRMF9011', 25),
(N'CRMF9020', 26),
(N'CRMF2243', 27),
(N'CRMF2093', 28),
(N'CRMF2103', 29),
(N'CRMF2113', 30)


------------------------------------------------------------------------------------------------------
--- Danh mục
------------------------------------------------------------------------------------------------------
SET @ScreenType = 2

------Modified by Tấn Thành on 04/09/2020 - Chuyển ScreenType thành 3---------------------------------
SET @ScreenID = N'CRMF0000'
SET @ScreenName = N'Thiết lập hệ thống'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'CRMF1000'
SET @ScreenName = N'Danh mục liên hệ'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1010'
SET @ScreenName = N'Danh sách khách hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1020'
SET @ScreenName = N'Danh mục nguồn đầu mối'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1030'
SET @ScreenName = N'Danh mục nhóm người nhận'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1040'
SET @ScreenName = N'Danh mục giai đoạn bán hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1050'
SET @ScreenName = N'Danh mục lý do thất bại/thành công'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1060'
SET @ScreenName = N'Danh mục từ khóa'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1070'
SET @ScreenName = N'Danh mục lĩnh vực kinh doanh'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1080'
SET @ScreenName = N'Danh mục hành động (next actions)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1090'
SET @ScreenName = N'Danh mục từ điển hỗ trợ'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2010'
SET @ScreenName = N'Danh sách phiếu chưa điều phối'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 51, NULL, @OrderNo

SET @ScreenID = N'CRMF2020'
SET @ScreenName = N'Danh sách phiếu đã điều phối'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 51, NULL, @OrderNo

SET @ScreenID = N'CRMF2030'
SET @ScreenName = N'Danh mục đầu mối'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2040'
SET @ScreenName = N'Danh mục chiến dịch marketing'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2050'
SET @ScreenName = N'Danh mục cơ hội'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2080'
SET @ScreenName = N'Danh mục yêu cầu'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2090'
SET @ScreenName = N'Bảo hành'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 87, NULL, @OrderNo

SET @ScreenID = N'CRMF2100'
SET @ScreenName = N'Phiếu yêu cầu khách hàng'
SET @ScreenNameE = N'Customer requests'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 117, NULL, @OrderNo

SET @ScreenID = N'CRMF2110'
SET @ScreenName = N'Dự toán'
SET @ScreenNameE = N'Dự toán'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 117, NULL, @OrderNo

SET @ScreenID = N'CRMF2120'
SET @ScreenName = N'Danh mục yêu cầu cấp license'
SET @ScreenNameE = N'Danh mục yêu cầu cấp license'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 92, NULL, @OrderNo

SET @ScreenID = N'CRMF2130'
SET @ScreenName = N'Danh mục thông tin profile'
SET @ScreenNameE = N'Danh mục thông tin profile'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 92, NULL, @OrderNo

SET @ScreenID = N'CIF1360'  --- Phân quyền CRM
SET @ScreenName = N'Danh mục hợp đồng'
SET @ScreenNameE = N'Danh mục hợp đồng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Danh mục chiến dịch email
SET @ScreenID = N'CRMF2140'
SET @ScreenName = N'Danh mục chiến dịch email'
SET @ScreenNameE = N'Danh mục chiến dịch email'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Danh mục lịch sử cuộc gọi
SET @ScreenID = N'CRMF2150'
SET @ScreenName = N'Danh mục lịch sử cuộc gọi'
SET @ScreenNameE = N'Danh mục lịch sử cuộc gọi'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Danh mục lịch Yêu cầu hỗ trợ
SET @ScreenID = N'CRMF2160'
SET @ScreenName = N'Danh mục yêu cầu hỗ trợ'
SET @ScreenNameE = N'Danh mục yêu cầu hỗ trợ'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Danh mục Yêu cầu dịch vụ
SET @ScreenID = N'CRMF2170'
SET @ScreenName = N'Danh mục yêu cầu dịch vụ'
SET @ScreenNameE = N'Danh mục yêu cầu dịch vụ'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Danh mục chiến dịch Sms
SET @ScreenID = N'CRMF2190'
SET @ScreenName = N'Danh mục chiến dịch SMS'
SET @ScreenNameE = N'Danh mục chiến dịch SMS'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Danh mục Dữ liệu nguồn online
SET @ScreenID = N'CRMF2210'
SET @ScreenName = N'Danh sách dữ liệu nguồn online'
SET @ScreenNameE = N'Danh sách dữ liệu nguồn online'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Danh mục Quản lý Server
SET @ScreenID = N'CRMF2220'
SET @ScreenName = N'Danh sách Server'
SET @ScreenNameE = N'Danh sách Server'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -3, NULL, @OrderNo

--- Danh mục Quản lý gói sản phẩm
SET @ScreenID = N'CRMF2230'
SET @ScreenName = N'Danh sách gói sản phẩm'
SET @ScreenNameE = N'Danh sách gói sản phẩm'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -3, NULL, @OrderNo

--- Danh mục Quản lý thuê bao
SET @ScreenID = N'CRMF2240'
SET @ScreenName = N'Danh sách thuê bao'
SET @ScreenNameE = N'Danh sách thuê bao'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -3, NULL, @OrderNo

------------------------------------------------------------------------------------------------------
--- Nhập liệu
------------------------------------------------------------------------------------------------------
SET @ScreenType = 3

-- Thiết lập hệ thống
SET @ScreenID = N'CRMF0000'
SET @ScreenName = N'Thiết lập hệ thống'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'CRMF0002'
SET @ScreenName = N'Thiết lập tính hao hụt'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 117, NULL, @OrderNo

SET @ScreenID = N'CRMF1001'
SET @ScreenName = N'Cập nhật liên hệ'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1011'
SET @ScreenName = N'Cập nhật thông tin khách hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1021'
SET @ScreenName = N'Cập nhật nguồn đầu mối'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1031'
SET @ScreenName = N'Cập nhật nhóm người nhận người nhận Email'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1041'
SET @ScreenName = N'Cập nhật giai đoạn bán hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1051'
SET @ScreenName = N'Cập nhật lý do thất bại/thành công'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1061'
SET @ScreenName = N'Cập nhật từ khóa'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1071'
SET @ScreenName = N'Cập nhật lĩnh vực kinh doanh'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1081'
SET @ScreenName = N'Cập nhật hành động (next actions)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1091'
SET @ScreenName = N'Cập nhật từ điển hỗ trợ'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- 12/10/2021 - [Hoài Bảo] - Begin update - Cập nhật CustomerIndex = -1 cho màn hình Hỗ trợ online dùng chung cho hệ thống
SET @ScreenID = N'CRMF2000'
SET @ScreenName = N'Hỗ trợ online'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2000'
SET @ScreenName = N'Hỗ trợ online'
SET @ScreenNameE = N'Hỗ trợ online'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

 --12/10/2021 - [Hoài Bảo] - End update

SET @ScreenID = N'CRMF2001'
SET @ScreenName = N'Cuộc gọi đến'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2002'
SET @ScreenName = N'Chuyển cuộc gọi'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2003'
SET @ScreenName = N'Xem lịch sử cuộc gọi'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2004'
SET @ScreenName = N'Xem nhanh công nợ'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2005'
SET @ScreenName = N'Thêm nhanh khách hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2006'
SET @ScreenName = N'Thêm nhanh đơn hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2007'
SET @ScreenName = N'Thêm nhanh liên hệ'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2011'
SET @ScreenName = N'Thêm điều phối'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 51, NULL, @OrderNo

SET @ScreenID = N'CRMF2021'
SET @ScreenName = N'Cập nhật phiếu điều phối Master'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 51, NULL, @OrderNo

SET @ScreenID = N'CRMF2023'
SET @ScreenName = N'Cập nhật phiếu điều phối Details'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 51, NULL, @OrderNo

SET @ScreenID = N'CRMF2031'
SET @ScreenName = N'Cập nhật đầu mối'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2041'
SET @ScreenName = N'Cập nhật chiến dịch marketing'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2051'
SET @ScreenName = N'Cập nhật cơ hội'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2081'
SET @ScreenName = N'Cập nhật yêu cầu khách hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2091'
SET @ScreenName = N'Cập nhật bảo hành'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 87, NULL, @OrderNo

SET @ScreenID = N'CRMF2101'
SET @ScreenName = N'Cập nhật phiếu yêu cầu khách hàng'
SET @ScreenNameE = N'Update customer requests'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 117, NULL, @OrderNo

SET @ScreenID = N'CRMF2111'
SET @ScreenName = N'Dự toán yêu cầu khách hàng'
SET @ScreenNameE = N'Dự toán yêu cầu khách hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 117, NULL, @OrderNo

SET @ScreenID = N'CRMF2121'
SET @ScreenName = N'Cập nhật yêu cầu cấp license'
SET @ScreenNameE = N'Cập nhật yêu cầu cấp license'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 92, NULL, @OrderNo

SET @ScreenID = N'CRMF2131'
SET @ScreenName = N'Cập nhật thông tin profile'
SET @ScreenNameE = N'Cập nhật thông tin profile'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 92, NULL, @OrderNo

SET @ScreenID = N'CRMF9026'
SET @ScreenName = N'Cập nhật nhiệm vụ'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 114, NULL, @OrderNo

SET @ScreenID = N'CRMF9005'
SET @ScreenName = N'Cập nhật sự kiện'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CIF1361' --- phân quyền CRM
SET @ScreenName = N'Cập nhật hợp đồng'
SET @ScreenNameE = N'Cập nhật hợp đồng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Cập nhật chiến dịch email
SET @ScreenID = N'CRMF2141'
SET @ScreenName = N'Cập nhật chiến dịch email'
SET @ScreenNameE = N'Cập nhật chiến dịch email'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF0003'
SET @ScreenName = N'Công thức hao hụt'
SET @ScreenNameE = N'Công thức hao hụt'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 117, NULL, @OrderNo

--- Cập nhật hàng loạt người phụ trách [ĐÌnh Hòa] - [29/01/2021]
SET @ScreenID = N'CRMF2033'
SET @ScreenName = N'Cập nhật người phụ trách'
SET @ScreenNameE = N'Cập nhật người phụ trách'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2161'
SET @ScreenName = N'Cập nhật yêu cầu hỗ trợ'
SET @ScreenNameE = N'Cập nhật yêu cầu hỗ trợ'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF90031'
SET @ScreenName = N'Cập nhật ghi chú'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Cập nhật Yêu cầu dịch vụ
SET @ScreenID = N'CRMF2171'
SET @ScreenName = N'Cập nhật yêu cầu dịch vụ'
SET @ScreenNameE = N'Cập nhật yêu cầu dịch vụ'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Điều phối nhân viên
SET @ScreenID = N'CRMF2174'
SET @ScreenName = N'Điều phối nhân viên'
SET @ScreenNameE = N'Điều phối nhân viên'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 117, NULL, @OrderNo

--- Cập nhật mặt hàng
SET @ScreenID = N'CRMF2181'
SET @ScreenName = N'Cập nhật mặt hàng'
SET @ScreenNameE = N'Cập nhật mặt hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Cập nhật chiến dịch Sms
SET @ScreenID = N'CRMF2191'
SET @ScreenName = N'Cập nhật chiến dịch SMS'
SET @ScreenNameE = N'Cập nhật chiến dịch SMS'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Thiết lập Dữ liệu cuộc gọi hàng loạt
SET @ScreenID = N'CRMF2201'
SET @ScreenName = N'Thiết lập danh sách cuộc gọi'
SET @ScreenNameE = N'Thiết lập danh sách cuộc gọi'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Cập nhật Nguồn dữ liệu online
SET @ScreenID = N'CRMF2211'
SET @ScreenName = N'Cập nhật dữ liệu nguồn online'
SET @ScreenNameE = N'Cập nhật dữ liệu nguồn online'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Màn hình chọn Người phụ trách khi chuyển dữ liệu Từ ao đầu mối -> Đầu mối
SET @ScreenID = N'CRMF2213'
SET @ScreenName = N'Chọn telesales phụ trách'
SET @ScreenNameE = N'Chọn telesales phụ trách'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Màn hình chọn chiến dịch khi gán chiến dịch và ao đầu mối
SET @ScreenID = N'CRMF2215'
SET @ScreenName = N'Chọn chiến dịch'
SET @ScreenNameE = N'Chọn chiến dịch'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Cập nhật Server
SET @ScreenID = N'CRMF2221'
SET @ScreenName = N'Cập nhật thông tin Server'
SET @ScreenNameE = N'Cập nhật thông tin Server'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -3, NULL, @OrderNo

--- Cập nhật Gói sản phẩm
SET @ScreenID = N'CRMF2231'
SET @ScreenName = N'Cập nhật thông tin gói sản phẩm'
SET @ScreenNameE = N'Cập nhật thông tin gói sản phẩm'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -3, NULL, @OrderNo

--- Cập nhật Thuê bao
SET @ScreenID = N'CRMF2241'
SET @ScreenName = N'Cập nhật thông tin thuê bao'
SET @ScreenNameE = N'Cập nhật thông tin thuê bao'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -3, NULL, @OrderNo

------------------------------------------------------------------------------------------------------
--- Khác (Thiết lập)
------------------------------------------------------------------------------------------------------
SET @ScreenType = 4

--  Modified by Tấn Thành on 18/09/2020---------------------------------------------------------------
SET @ScreenID = N'CMNF0000'
SET @ScreenName = N'Thiết lập hệ thống'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF9001'
SET @ScreenName = N'Chọn mặt hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF9002'
SET @ScreenName = N'Chọn sơ đồ tuyến'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF9003'
SET @ScreenName = N'Chọn nhân viên'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo


SET @ScreenID = N'CRMF9008'
SET @ScreenName = N'Chọn chiến dịch'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CMNF90081'
SET @ScreenName = N'Chọn mã tích'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF9010'
SET @ScreenName = N'Chọn sự kiện'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF9011'
SET @ScreenName = N'Chọn nhiệm vụ'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF9013'
SET @ScreenName = N'Chọn cơ hội'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF9014'
SET @ScreenName = N'Chọn đầu mối'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF9015'
SET @ScreenName = N'Chọn yêu cầu'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF9016'
SET @ScreenName = N'Chọn người nhận'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF9017'
SET @ScreenName = N'Chọn nhóm người nhận'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF0001'
SET @ScreenName = N'Định nghĩa tham số'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2093'
SET @ScreenName = N'Kế thừa bảo hành'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2103'
SET @ScreenName = N'Kế thừa mẫu in cũ'
SET @ScreenNameE = N'Inheriting the old printed form'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2113'
SET @ScreenName = N'Kế thừa yêu cầu khách hàng'
SET @ScreenNameE = N'Kế thừa yêu cầu khách hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CIF1363'
SET @ScreenName = N'Chọn hợp đồng'
SET @ScreenNameE = N'Chọn hợp đồng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF9020'
SET @ScreenName = N'Chọn hội thảo - chuyên đề'
SET @ScreenNameE = N'Chọn hội thảo - chuyên đề'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF9004'
SET @ScreenName = N'Chọn đối tượng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF9018'
SET @ScreenName = N'Chọn từ điển hỗ trợ'
SET @ScreenNameE = N'Chọn từ điển hỗ trợ'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2153'
SET @ScreenName = N'Chọn lịch sử cuộc gọi'
SET @ScreenNameE = N'Chọn lịch sử cuộc gọi'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2163'
SET @ScreenName = N'Chọn yêu cầu hỗ trợ'
SET @ScreenNameE = N'Chọn yêu cầu hỗ trợ'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF9024'
SET @ScreenName = N'Chọn khách hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF9025'
SET @ScreenName = N'Chọn liên hệ'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Kế thừa phiếu yêu cầu dịch vụ
SET @ScreenID = N'CRMF2173'
SET @ScreenName = N'Kế thừa phiếu yêu cầu dịch vụ'
SET @ScreenNameE = N'Kế thừa phiếu yêu cầu dịch vụ'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Màn hình chọn dữ liệu cuộc gọi từ các nguồn Đầu mối/liên hệ
SET @ScreenID = N'CRMF9021'
SET @ScreenName = N'Chọn cuộc gọi'
SET @ScreenNameE = N'Chọn cuộc gọi'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Màn hình chọn dữ liệu nguồn online
SET @ScreenID = N'CRMF2214'
SET @ScreenName = N'Chọn dữ liệu nguồn online'
SET @ScreenNameE = N'Chọn dữ liệu nguồn online'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Màn hình chọn gói sản phẩm
SET @ScreenID = N'CRMF2243'
SET @ScreenName = N'Chọn gói sản phẩm'
SET @ScreenNameE = N'Chọn gói sản phẩm'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Màn hình chọn khách hàng
SET @ScreenID = N'CRMF2244'
SET @ScreenName = N'Chọn khách hàng'
SET @ScreenNameE = N'Chọn khách hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Chọn nguồn đầu mối
SET @ScreenID = N'CRMF1023'
SET @ScreenName = N'Chọn nguồn đầu mối'
SET @ScreenNameE = N'Chọn nguồn đầu mối'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

------------------------------------------------------------------------------------------------------
--- Chi tiết
------------------------------------------------------------------------------------------------------
SET @ScreenType = 5

SET @ScreenID = N'CRMF1002'
SET @ScreenName = N'Xem chi tiết liên hệ'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1012'
SET @ScreenName = N'Xem chi tiết khách hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1022'
SET @ScreenName = N'Xem chi tiết nguồn đầu mối'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1032'
SET @ScreenName = N'Xem chi tiết nhóm người nhận Email'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1042'
SET @ScreenName = N'Xem chi tiết giai đoạn bán hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1052'
SET @ScreenName = N'Xem chi tiết lý do thất bại/thành công'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1062'
SET @ScreenName = N'Xem chi tiết từ khóa'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1072'
SET @ScreenName = N'Xem chi tiết lĩnh vực kinh doanh'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1082'
SET @ScreenName = N'Xem chi tiết hành động (next action)'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF1092'
SET @ScreenName = N'Xem chi tiết từ điển hỗ trợ'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2022'
SET @ScreenName = N'Chi tiết phiếu đã điều phối'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 51, NULL, @OrderNo

SET @ScreenID = N'CRMF2032'
SET @ScreenName = N'Xem chi tiết đầu mối'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2042'
SET @ScreenName = N'Xem chi tiết chiến dịch marketing'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2052'
SET @ScreenName = N'Xem chi tiết cợ hội'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2082'
SET @ScreenName = N'Xem chi tiết yêu cầu'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2092'
SET @ScreenName = N'Xem chi tiết bảo hành'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 87, NULL, @OrderNo

SET @ScreenID = N'CRMF2102'
SET @ScreenName = N'Chi tiết phiếu yêu cầu khách hàng'
SET @ScreenNameE = N'Customer request details'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 117, NULL, @OrderNo

SET @ScreenID = N'CRMF2112'
SET @ScreenName = N'Chi tiết dự toán'
SET @ScreenNameE = N'Detailed estimates'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 117, NULL, @OrderNo

SET @ScreenID = N'CRMF2122'
SET @ScreenName = N'Xem chi tiết yêu cầu cấp license'
SET @ScreenNameE = N'Xem chi tiết yêu cầu cấp license'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 92, NULL, @OrderNo

SET @ScreenID = N'CRMF2132'
SET @ScreenName = N'Xem chi tiết thông tin profile'
SET @ScreenNameE = N'Xem chi tiết thông tin profile'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 92, NULL, @OrderNo

SET @ScreenID = N'CIF1362' --- Phân quyền bên CRM
SET @ScreenName = N'Xem chi tiết hợp đồng'
SET @ScreenNameE = N'Xem chi tiết hợp đồng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Xem chi tiết chiến dịch email
SET @ScreenID = N'CRMF2142'
SET @ScreenName = N'Xem chi tiết chiến dịch email'
SET @ScreenNameE = N'Xem chi tiết chiến dịch email'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF2162'
SET @ScreenName = N'Xem chi tiết yêu cầu hỗ trợ'
SET @ScreenNameE = N'Xem chi tiết yêu cầu hỗ trợ'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Xem chi tiết Yêu cầu dịch vụ
SET @ScreenID = N'CRMF2172'
SET @ScreenName = N'Xem chi tiết yêu cầu dịch vụ'
SET @ScreenNameE = N'Xem chi tiết yêu cầu dịch vụ'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Xem chi tiết Chiến dịch Sms
SET @ScreenID = N'CRMF2192'
SET @ScreenName = N'Xem chi tiết chiến dịch SMS'
SET @ScreenNameE = N'Xem chi tiết chiến dịch SMS'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Chi tiết nguồn dữ liệu online
SET @ScreenID = N'CRMF2212'
SET @ScreenName = N'Chi tiết dữ liệu nguồn online'
SET @ScreenNameE = N'Chi tiết dữ liệu nguồn online'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--- Xem chi tiết Server
SET @ScreenID = N'CRMF2222'
SET @ScreenName = N'Xem chi tiết Server'
SET @ScreenNameE = N'Xem chi tiết Server'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -3, NULL, @OrderNo

--- Xem chi tiết gói sản phẩm
SET @ScreenID = N'CRMF2232'
SET @ScreenName = N'Xem chi tiết gói sản phẩm'
SET @ScreenNameE = N'Xem chi tiết gói sản phẩm'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -3, NULL, @OrderNo

--- Xem chi tiết thuê bao
SET @ScreenID = N'CRMF2242'
SET @ScreenName = N'Xem chi tiết thuê bao'
SET @ScreenNameE = N'Xem chi tiết thuê bao'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -3, NULL, @OrderNo

------------------------------------------------------------------------------------------------------
--- Báo cáo
------------------------------------------------------------------------------------------------------
SET @ScreenType = 1

SET @ScreenID = N'CRMF3000'
SET @ScreenName = N'Báo cáo'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMF3001'
SET @ScreenName = N'Báo cáo chiến dịch Marketing'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'CRMF3002'
SET @ScreenName = N'Báo cáo quan hệ khách hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'CRMF3010'
SET @ScreenName = N'Báo cáo KH mới theo nhân viên'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'CRMF3020'
SET @ScreenName = N'Báo cáo KH ngưng sử dụng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'CRMF3030'
SET @ScreenName = N'Báo cáo thông kê thời gian giao hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'CRMF3040'
SET @ScreenName = N'Báo cáo KH không phát sinh đơn hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'CRMF3050'
SET @ScreenName = N'Báo cáo số lượng đơn hàng theo nhân viên'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'CRMF3060'
SET @ScreenName = N'Báo cáo thống kê chu kỳ đặt nước theo khách hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 51, NULL, @OrderNo

SET @ScreenID = N'CRMF3070'
SET @ScreenName = N'Báo cáo công nợ của khách hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'CRMF3080'
SET @ScreenName = N'Thống kê yêu cầu khách hàng'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMR3001'
SET @ScreenName = N'Tổng hợp đầu mối từ các nguồn'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMR3002'
SET @ScreenName = N'Tổng hợp cơ hội từ các nguồn'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMR3003'
SET @ScreenName = N'Thống kê cơ hội theo giai đoạn'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMR3004'
SET @ScreenName = N'Tổng hợp giá trị cơ hội theo nhân viên'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMR3005'
SET @ScreenName = N'Tổng hợp tỷ lệ chuyển đổi từ cơ hội'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMR3006'
SET @ScreenName = N'Thống kê cơ hội theo khu vực'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMR3007'
SET @ScreenName = N'Thống kê cơ hội theo lĩnh vực'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenType = 1
--CRMR3008 - Phân tích khách hàng từ nguồn cơ hội
SET @ScreenID = N'CRMR3008'
SET @ScreenName = N'Phân tích khách hàng từ nguồn cơ hội'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

--CRMR - Tổng hợp số lượng khách hàng theo nhân viên

--CRMR3010 - Phân tích khách hàng từ nguồn cơ hội

SET @ScreenType = 1
SET @ScreenID = N'CRMR3009'
SET @ScreenName = N'Tổng hợp số lượng khách hàng nhân viên'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMR3010'
SET @ScreenName = N'Phễu bán hàng theo nhân viên'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMR3011'
SET @ScreenName = N'Phễu bán hàng theo công ty'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMR3012'
SET @ScreenName = N'Thực tế so với kỳ vọng của chiến dịch'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMR3013'
SET @ScreenName = N'Warranty daily report'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, 114, NULL, @OrderNo

SET @ScreenID = N'CRMR3014'
SET @ScreenName = N'Thống kê hoạt động khách hàng không phát sinh cơ hội'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMR3015'
SET @ScreenName = N'Thống kê hoạt động khách hàng có phát sinh cơ hội'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMR3016'
SET @ScreenName = N'Tổng hợp nguồn đầu mối chi tiết'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMR3017'
SET @ScreenName = N'Báo cáo chiến dịch'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMR3018'
SET @ScreenName = N'Báo cáo chi tiết Marketing và Sale'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMR3019'
SET @ScreenName = N'Báo cáo tổng Marketing và Sale'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMR3021'
SET @ScreenName = N'Báo cáo Marketing - Sale năm'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

SET @ScreenID = N'CRMR3022'
SET @ScreenName = N'Báo cáo khách hàng không tương tác với dịch vụ'
SET @ScreenNameE = N''
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- End Report =====================================================================

---------------------------------------------- Nội dung hiển thị trên DashBoard ------------------------------------
SET @ScreenType = 6

SET @ScreenID = N'CRMD0001'
SET @ScreenName = N'Phễu bán hàng theo nhân viên'
SET @ScreenNameE = N'Phễu bán hàng theo nhân viên'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'CRMD0003'
SET @ScreenName = N'Danh sách cơ hội lâu không tương tác'
SET @ScreenNameE = N'Danh sách cơ hội lâu không tương tác'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

SET @ScreenID = N'CRMD0004'
SET @ScreenName = N'Danh sách đầu mối lâu không tương tác'
SET @ScreenNameE = N'Danh sách đầu mối lâu không tương tác'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

-- 10/11/2022 - [Hoài Bảo] - Bổ sung phân quyền màn hình Dashboard Quan hệ khách hàng và hiển thị biểu đồ trong Dashboard
-- Dashboard quan hệ khách hàng
SET @ScreenID = N'CRMF0020'
SET @ScreenName = N'Dashboard quan hệ khách hàng (CR)'
SET @ScreenNameE = N'Dashboard quan hệ khách hàng (CR)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Tổng quan Quan hệ khách hàng
 SET @ScreenID = N'CRMD0021'
 SET @ScreenName = N'Tổng Quan Quan hệ khách hàng'
 SET @ScreenNameE = N'Tổng Quan Quan hệ khách hàng'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

-- Chi tiết theo team/cá nhân
 SET @ScreenID = N'CRMD0022'
 SET @ScreenName = N'Chi tiết theo team/cá nhân'
 SET @ScreenNameE = N'Chi tiết theo team/cá nhân'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

-- Số liệu thống kê tổng hợp (CR)
SET @ScreenID = N'CRMD0023'
SET @ScreenName = N'Số liệu thống kê tổng hợp (CR)';
SET @ScreenNameE = N'Số liệu thống kê tổng hợp (CR)';
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Biểu đồ thống kê số lượng theo nghiệp vụ (CR)
SET @ScreenID = N'CRMD0024'
SET @ScreenName = N'Biểu đồ thống kê số lượng theo nghiệp vụ (CR)';
SET @ScreenNameE = N'Biểu đồ thống kê số lượng theo nghiệp vụ (CR)';
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Biểu đồ tỷ trọng số lượng cơ hội theo giai đoạn (CR)
SET @ScreenID = N'CRMD0025'
SET @ScreenName = N'Biểu đồ tỷ trọng số lượng cơ hội theo giai đoạn (CR)';
SET @ScreenNameE = N'Biểu đồ tỷ trọng số lượng cơ hội theo giai đoạn (CR)';
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Số liệu thống kê chi tiết (CR)
SET @ScreenID = N'CRMD0026'
SET @ScreenName = N'Số liệu thống kê chi tiết (CR)';
SET @ScreenNameE = N'Số liệu thống kê chi tiết (CR)';
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Phễu tỷ lệ chuyển đổi giữa các trạng thái của Cơ hội / Đầu mối (CR)
SET @ScreenID = N'CRMD0027'
SET @ScreenName = N'Phễu tỷ lệ chuyển đổi giữa các trạng thái của Cơ hội / Đầu mối (CR)';
SET @ScreenNameE = N'Phễu tỷ lệ chuyển đổi giữa các trạng thái của Cơ hội / Đầu mối (CR)';
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Biểu đồ giá trị cơ hội theo nhân viên (CR)
SET @ScreenID = N'CRMD0028'
SET @ScreenName = N'Biểu đồ giá trị cơ hội theo nhân viên (CR)';
SET @ScreenNameE = N'Biểu đồ giá trị cơ hội theo nhân viên (CR)';
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- 14/11/2022 - [Hoài Bảo] - Bổ sung phân quyền màn hình Dashboard Dịch vụ khách hàng và hiển thị biểu đồ trong Dashboard
-- Dashboard Dịch vụ khách hàng
SET @ScreenID = N'CRMF0030'
SET @ScreenName = N'Dashboard dịch vụ khách hàng (CS)'
SET @ScreenNameE = N'Dashboard dịch vụ khách hàng (CS)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Tổng quan Dịch vụ khách hàng
SET @ScreenID = N'CRMD0029'
SET @ScreenName = N'Tổng quan công ty'
SET @ScreenNameE = N'Tổng quan công ty'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

-- Chi tiết theo team/cá nhân
SET @ScreenID = N'CRMD0030'
SET @ScreenName = N'Chi tiết theo team/cá nhân'
SET @ScreenNameE = N'Chi tiết theo team/cá nhân'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -2, NULL, @OrderNo

-- Số liệu thống kê tổng hợp (CS)
SET @ScreenID = N'CRMD0031'
SET @ScreenName = N'Số liệu thống kê tổng hợp (CS)'
SET @ScreenNameE = N'Số liệu thống kê tổng hợp (CS)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Biểu đồ thống kê số lượng yêu cầu hỗ trợ/yêu cầu dịch vụ theo trạng thái (CS)
SET @ScreenID = N'CRMD0032'
SET @ScreenName = N'Biểu đồ thống kê số lượng yêu cầu hỗ trợ/yêu cầu dịch vụ theo trạng thái (CS)'
SET @ScreenNameE = N'Biểu đồ thống kê số lượng yêu cầu hỗ trợ/yêu cầu dịch vụ theo trạng thái (CS)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Biểu đồ thống kê số lượng yêu cầu hỗ trợ theo khách hàng (CS)
SET @ScreenID = N'CRMD0033'
SET @ScreenName = N'Biểu đồ thống kê số lượng yêu cầu hỗ trợ theo khách hàng (CS)'
SET @ScreenNameE = N'Biểu đồ thống kê số lượng yêu cầu hỗ trợ theo khách hàng (CS)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Số liệu thống kê chi tiết (CS)
SET @ScreenID = N'CRMD0034'
SET @ScreenName = N'Số liệu thống kê chi tiết (CS)'
SET @ScreenNameE = N'Số liệu thống kê chi tiết (CS)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo

-- Tình hình thực hiện Yêu cầu hỗ trợ/Yêu cầu dịch vụ (CS)
SET @ScreenID = N'CRMD0035'
SET @ScreenName = N'Tình hình thực hiện Yêu cầu hỗ trợ/Yêu cầu dịch vụ (CS)'
SET @ScreenNameE = N'Tình hình thực hiện Yêu cầu hỗ trợ/Yêu cầu dịch vụ (CS)'
SET @OrderNo = ISNULL((SELECT TOP 1 ISNULL(OrderNo, 0) FROM #CRM_ERP9_PERMISSIONS WHERE ScreenID = @ScreenID), 0)
EXEC AddScreenERP9_V2 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE, -1, NULL, @OrderNo
