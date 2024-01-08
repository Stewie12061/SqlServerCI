IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTCV0001')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTCV0001', N'Chưa xử lý', N'', 1, N'#d6f6e8', 45, 1, 0, N'2018-11-30 09:24:36.857', N'2018-12-03 08:30:25.633', N'ASOFTADMIN', N'AS.0001', 1, 1)
	
IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTCV0002')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTCV0002', N'Đang làm', N'', 2, N'#d2ff9b', 45, 1, 0, N'2018-11-30 09:35:13.077', N'2018-11-30 16:46:15.550', N'ASOFTADMIN', N'AS.0001', 1, 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTCV0003')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTCV0003', N'Hoàn thành', N'', 3, N'#26bce8', 45, 1, 0, N'2018-11-30 13:58:33.323', N'2018-11-30 14:29:47.297', N'ASOFTADMIN', N'AS.0001', 1, 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTCV0004')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTCV0004', N'Hủy', N'', 8, N'#fff700', 45, 1, 0, N'2018-11-30 13:58:51.380', N'2018-11-30 13:59:17.597', N'ASOFTADMIN', N'ASOFTADMIN', 1, 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTCV0005')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTCV0005', N'Từ chối hoàn thành', N'', 6, N'#9c0808', 45, 1, 0, N'2018-11-30 13:58:51.380', N'2018-11-30 13:59:17.597', N'ASOFTADMIN', N'AS.0001', 1, 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTCV0006')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTCV0006', N'Chờ xác nhận', N'', 4, N'#c06ee6', 45, 1, 0, N'2019-02-18 23:38:06.457', N'2019-02-18 23:38:06.457', N'ASOFTADMIN', N'ASOFTADMIN', 1, 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTCV0007')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTCV0007', N'Tạm ngưng', N'', 5, N'#e4d7f8', 45, 1, 0, N'2018-11-30 16:58:45.580', N'2018-11-30 16:58:45.580', N'ASOFTADMIN', N'ASOFTADMIN', 1, 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTCV0008')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTCV0008', N'ReOpen', N'', 7, N'#f6f89f', NULL, 1, 0, N'2018-11-30 16:58:45.580', N'2018-11-30 16:58:45.580', N'ASOFTADMIN', N'AS.0001', 1, 0)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTDA0001')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTDA0001', N'Lên kế hoạch', N'', 1, N'#d6f6e8', 45, 1, 0, N'2019-04-25 06:08:04.227', N'2019-04-25 06:08:04.227', N'ASOFTADMIN', N'AS.0001', 0, 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTDA0002')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTDA0002', N'Đang làm', N'', 3, N'#d2ff9b', 45, 1, 0, N'2019-04-25 06:08:37.697', N'2019-04-25 06:08:37.697', N'ASOFTADMIN', N'AS.0001', 0, 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTDA0003')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTDA0003', N'Hoàn thành', N'', 4, N'#26bce8', 45, 1, 0, N'2019-04-25 06:09:13.720', N'2019-04-25 06:09:13.720', N'ASOFTADMIN', N'AS.0001', 0, 1)

--IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTDA0004')
	--INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	--VALUES ('@@@', N'TTDA0004', N'Thất bại', N'', 4, N'#f44a2f', 45, 1, 0, N'2019-04-25 06:09:53.743', N'2019-04-25 06:13:01.560', N'ASOFTADMIN', N'ASOFTADMIN', 0, 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTDA0005')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTDA0005', N'Phân bổ nhân sự', N'', 2, N'#8cf0f7', 45, 1, 0, N'2019-04-25 06:10:37.100', N'2019-04-25 06:10:37.100', N'ASOFTADMIN', N'AS.0001', 0, 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTDA0006')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTDA0006', N'Tạm ngưng',  N'', 5, N'#e4d7f8', 45, 1, 0, N'2019-04-25 06:10:44.997', N'2019-04-25 06:13:33.980', N'ASOFTADMIN', N'AS.0001', 0, 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTDA0010')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTDA0010', N'Hủy', N'', 7, N'#c7744b', 45, 1, 0, N'2019-07-16 14:02:18.777', N'2019-07-16 14:03:45.700', N'ASOFTADMIN', N'ASOFTADMIN', 0, 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTDA0011')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTDA0011', N'ReOpen', N'', 6, N'#d7b997', 45, 1, 0, N'2019-07-16 14:02:18.777', N'2019-07-16 14:03:45.700', N'ASOFTADMIN', N'ASOFTADMIN', 0, 0)

--- Trạng thái vấn đề
IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTIS0001')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTIS0001', N'Chưa xử lý', N'', 1, N'#d6f6e8', 45, 1, 0, N'2018-11-30 09:24:36.857', N'2018-12-03 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 2, 1)
	
IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTIS0002')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTIS0002', N'Đang làm', N'', 2, N'#d2ff9b', 45, 1, 0, N'2018-11-30 09:24:36.857', N'2018-12-03 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 2, 2)
	
IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTIS0003')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTIS0003', N'Tạm ngưng', N'', 3, N'#f1bb0a', 45, 1, 0, N'2018-11-30 09:24:36.857', N'2018-12-03 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 2, 5)
	
IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTIS0004')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTIS0004', N'Hoàn thành', N'', 4, N'#26bce8', 45, 1, 0, N'2018-11-30 09:24:36.857', N'2018-12-03 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 2, 3)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTIS0005')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTIS0005', N'ReOpen', N'', 5, N'#d7b997', NULL, 1, 0, N'2018-11-30 09:24:36.857', N'2018-12-03 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 2, 6)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTIS0006')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTIS0006', N'Hủy', N'', 6, N'#c7744b', NULL, 1, 0, N'2018-11-30 09:24:36.857', N'2018-12-03 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 2, 7)	

--- Trạng thái Yêu cầu hỗ trợ
IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTRQ0001')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTRQ0001', N'Chưa xử lý', N'', 1, N'#d6f6e8', 45, 1, 0, N'2018-11-30 09:24:36.857', N'2018-12-03 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 3, 1)
	
IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTRQ0002')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTRQ0002', N'Đang làm', N'', 2, N'#d2ff9b', 45, 1, 0, N'2018-11-30 09:24:36.857', N'2018-12-03 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 3, 2)
	
IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTRQ0003')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTRQ0003', N'Tạm ngưng', N'', 4, N'#e4d7f8', 45, 1, 0, N'2018-11-30 09:24:36.857', N'2018-12-03 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 3, 5)
	
IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTRQ0004')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTRQ0004', N'Hoàn thành', N'', 3, N'#26bce8', 45, 1, 0, N'2018-11-30 09:24:36.857', N'2018-12-03 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 3, 3)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTRQ0005')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTRQ0005', N'ReOpen', N'', 5, N'#fac4c4', NULL, 1, 0, N'2018-11-30 09:24:36.857', N'2018-12-03 08:30:25.633', N'AS.0001', N'ASOFTADMIN', 3, 6)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTRQ0006')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTRQ0006', N'Hủy', N'', 6, N'#c7744b', NULL, 1, 0, N'2018-11-30 09:24:36.857', N'2018-12-03 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 3, 7)
--- 12/11/2019 - Vĩnh Tâm: Cập nhật các Trại thái cũ thành Trạng thái hệ thống ---
--UPDATE OOT1040 SET SystemStatus = 1 WHERE SystemStatus IS NULL

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTMS0001')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTMS0001', N'Chưa xử lý', N'', 1, N'#d6f6e8', 45, 1, 0, N'2019-12-24 09:24:36.857', N'2019-12-24 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 4, 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTMS0002')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTMS0002', N'Đang làm', N'', 2, N'#d2ff9b', 45, 1, 0, N'2019-12-24 09:24:36.857', N'2019-12-24 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 4, 2)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTMS0003')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTMS0003', N'Tạm ngưng', N'', 3, N'#e4d7f8', 45, 1, 0, N'2019-12-24 09:24:36.857', N'2019-12-24 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 4, 5)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTMS0004')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTMS0004', N'Hủy', N'', 6, N'#fff700', 45, 1, 0, N'2019-12-24 09:24:36.857', N'2019-12-24 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 4, 7)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTMS0005')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTMS0005', N'ReOpen', N'', 5, N'#d7b997', 45, 1, 0, N'2019-12-24 09:24:36.857', N'2019-12-24 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 4, 6)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTMS0006')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTMS0006', N'Hoàn thành', N'', 4, N'#26bce8', 45, 1, 0, N'2019-12-24 09:24:36.857', N'2019-12-24 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 4, 3)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'DTB0001')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'DTB0001', N'Xác định đặt', N'', 1, N'#26bce8', 45, 1, 0, N'2020-10-22 09:24:36.857', N'2020-10-22 09:24:36.857', N'ASOFTADMIN', N'ASOFTADMIN', 6, 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'DTB0002')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'DTB0002', N'Dự định đặt', N'', 2, N'#d2ff9b', 45, 1, 0, N'2020-10-22 09:24:36.857', N'2020-10-22 09:24:36.857', N'ASOFTADMIN', N'ASOFTADMIN', 6, 1)
	
----------Tấn Lộc - Bổ sung trạng thái cho Email------------------
IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTEM0001')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTEM0001', N'Chưa xem', N'UnRead', 1, N'#e6f8c6', 45, 1, 0, N'2020-01-11 09:24:36.857', N'2020-01-11 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 5, 8)
	
IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTEM0011')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTEM0011', N'Đã xem', N'Read', 1, N'#b2e2f3', 45, 1, 0, N'2020-01-11 09:24:36.857', N'2020-01-11 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 5, 9)
	
IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTEM0021')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTEM0021', N'Đã gửi thành công', N'Đã gửi thành công', 1, N'#c9f3bf', 45, 1, 0, N'2020-01-11 09:24:36.857', N'2020-01-11 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 5, 10)
	
IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTEM0031')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTEM0031', N'Gửi không thành công', N'Gửi không thành công', 1, N'#f1c68e', 45, 1, 0, N'2020-01-11 09:24:36.857', N'2020-01-11 08:30:25.633', N'ASOFTADMIN', N'ASOFTADMIN', 5, 11)

---------- Anh Đô - Bổ sung trạng thái Chỉ tiêu/Công việc ----------
IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTCTCV0001')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTCTCV0001', N'Chưa thực hiện', N'', 1, N'#d6f6e8', 45, 1, 0, N'2023-07-08 01:28:03.060', N'2023-07-08 01:28:03.060', N'ASOFTADMIN', N'ASOFTADMIN', 8, 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTCTCV0002')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTCTCV0002', N'Đang xử lý', N'', 2, N'#d2ff9b', 45, 1, 0, N'2023-07-08 01:28:03.060', N'2023-07-08 01:28:03.060', N'ASOFTADMIN', N'ASOFTADMIN', 8, 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTCTCV0003')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTCTCV0003', N'Đã xong', N'', 3, N'#26bce8', 45, 1, 0, N'2023-07-08 01:28:03.060', N'2023-07-08 01:28:03.060', N'ASOFTADMIN', N'ASOFTADMIN', 8, 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTCTCV0004')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTCTCV0004', N'Tạm hoãn', N'', 4, N'#e4d7f8', 45, 1, 0, N'2023-07-08 01:28:03.060', N'2023-07-08 01:28:03.060', N'ASOFTADMIN', N'ASOFTADMIN', 8, 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT1040 WHERE StatusID = 'TTCTCV0005')
	INSERT INTO OOT1040 (DivisionID, StatusID, StatusName, StatusNameE, Orders, Color, RelatedToTypeID, IsCommon, Disabled, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, StatusType, SystemStatus)
	VALUES ('@@@', N'TTCTCV0005', N'Hủy', N'', 5, N'#fff700', 45, 1, 0, N'2023-07-08 01:28:03.060', N'2023-07-08 01:28:03.060', N'ASOFTADMIN', N'ASOFTADMIN', 8, 1)
