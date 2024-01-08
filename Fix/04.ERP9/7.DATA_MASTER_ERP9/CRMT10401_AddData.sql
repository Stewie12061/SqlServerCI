--Insert Dữ liệu hệ thống của trang thái cố định
IF NOT EXISTS (SELECT TOP 1 1  FROM CRMT10401 where StageID ='LOST') 
INSERT [dbo].[CRMT10401] ([APK], [DivisionID], [StageID], [StageName], [Disabled], [IsCommon], [CreateUserID], [CreateDate], [LastModifyUserID], [LastModifyDate], [Description], [OrderNo], [StageType], [IsSystem], [Rate]) 
VALUES (N'c16ed7b1-9018-4a0c-99cf-6d40778444af', N'@@@', N'LOST', N'Thua', 0, 1, N'VU', CAST(N'2017-05-08 15:44:42.867' AS DateTime), N'LUAN', CAST(N'2017-05-25 14:18:51.677' AS DateTime), N'', 100000, 1, 1, CAST(20.00000000 AS Decimal(28, 8)))
IF NOT EXISTS (SELECT TOP 1 1  FROM CRMT10401 where StageID ='WIN') 
INSERT [dbo].[CRMT10401] ([APK], [DivisionID], [StageID], [StageName], [Disabled], [IsCommon], [CreateUserID], [CreateDate], [LastModifyUserID], [LastModifyDate], [Description], [OrderNo], [StageType], [IsSystem], [Rate]) 
VALUES (N'4a7dfab3-e437-468f-9bb0-a90b54adba35', N'@@@', N'WIN', N'Thắng', 0, 1, N'VU', CAST(N'2017-05-08 15:44:42.867' AS DateTime), N'VU', CAST(N'2017-05-25 14:49:53.487' AS DateTime), N'Diễn giải', 99999, 1, 1, CAST(100.00000000 AS Decimal(28, 8)))

-- Trạng thái chiến dịch Marketing
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT10401 WHERE StageID = 'TTCM00001')
	INSERT INTO CRMT10401(DivisionID, StageID, StageName, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Description, OrderNo, StageType, IsSystem, Rate, Color, StageNameE, SystemStatus, DataFilter)
	VALUES ('@@@', N'TTCM00001', N'Nháp', 0, 1, N'ASOFTADMIN', N'2019-04-25 06:10:37.100', N'ASOFTADMIN', N'2019-04-25 06:10:37.100', NULL, 1, 2, 0, 0, N'#feecb6', N'Draft', NULL, NULL)

IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT10401 WHERE StageID = 'TTCM00002')
	INSERT INTO CRMT10401(DivisionID, StageID, StageName, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Description, OrderNo, StageType, IsSystem, Rate, Color, StageNameE, SystemStatus, DataFilter)
	VALUES ('@@@', N'TTCM00002', N'Đang lên kế hoạch', 0, 1, N'ASOFTADMIN', N'2019-04-25 06:10:37.100', N'ASOFTADMIN', N'2019-04-25 06:10:37.100', NULL, 11, 2, 0, 0, N'#d9f0f8', N'Planning', NULL, NULL)

IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT10401 WHERE StageID = 'TTCM00003')
	INSERT INTO CRMT10401(DivisionID, StageID, StageName, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Description, OrderNo, StageType, IsSystem, Rate, Color, StageNameE, SystemStatus, DataFilter)
	VALUES ('@@@', N'TTCM00003', N'Chờ duyệt', 0, 1, N'ASOFTADMIN', N'2019-04-25 06:10:37.100', N'ASOFTADMIN', N'2019-04-25 06:10:37.100', NULL, 21, 2, 0, 0, N'#dba9a9', N'WaitApproval', NULL, NULL)

IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT10401 WHERE StageID = 'TTCM00004')
	INSERT INTO CRMT10401(DivisionID, StageID, StageName, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Description, OrderNo, StageType, IsSystem, Rate, Color, StageNameE, SystemStatus, DataFilter)
	VALUES ('@@@', N'TTCM00004', N'Đang hoạt động', 0, 1, N'ASOFTADMIN', N'2019-04-25 06:10:37.100', N'ASOFTADMIN', N'2019-04-25 06:10:37.100', NULL, 31, 2, 0, 0, N'#c1f49d', N'Active', NULL, NULL)

IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT10401 WHERE StageID = 'TTCM00005')
	INSERT INTO CRMT10401(DivisionID, StageID, StageName, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Description, OrderNo, StageType, IsSystem, Rate, Color, StageNameE, SystemStatus, DataFilter)
	VALUES ('@@@', N'TTCM00005', N'Hoàn tất', 0, 1, N'ASOFTADMIN', N'2019-04-25 06:10:37.100', N'ASOFTADMIN', N'2019-04-25 06:10:37.100', NULL, 41, 2, 0, 0, N'#e4f5d8', N'Completed', NULL, NULL)

IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT10401 WHERE StageID = 'TTCM00006')
	INSERT INTO CRMT10401(DivisionID, StageID, StageName, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Description, OrderNo, StageType, IsSystem, Rate, Color, StageNameE, SystemStatus, DataFilter)
	VALUES ('@@@', N'TTCM00006', N'Hủy', 0, 1, N'ASOFTADMIN', N'2019-04-25 06:10:37.100', N'ASOFTADMIN', N'2019-04-25 06:10:37.100', NULL, 51, 2, 0, 0, N'#d3b0e8', N'Cancelled', NULL, NULL)

IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT10401 WHERE StageID = 'TTCM00007')
	INSERT INTO CRMT10401(DivisionID, StageID, StageName, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Description, OrderNo, StageType, IsSystem, Rate, Color, StageNameE, SystemStatus, DataFilter)
	VALUES ('@@@', N'TTCM00007', N'Tạm ngưng', 0, 1, N'ASOFTADMIN', N'2019-04-25 06:10:37.100', N'ASOFTADMIN', N'2019-04-25 06:10:37.100', NULL, 61, 2, 0, 0, N'#f0a2c2', N'Pending', NULL, NULL)

-- Trạng thái dữ liệu nguồn online

IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT10401 WHERE StageID = 'TTSR00001')
	INSERT INTO CRMT10401(DivisionID, StageID, StageName, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Description, OrderNo, StageType, IsSystem, Rate, Color, StageNameE, SystemStatus, DataFilter)
	VALUES ('@@@', N'TTSR00001', N'Chưa chuyển', 0, 1, N'ASOFTADMIN', N'2019-04-25 06:10:37.100', N'ASOFTADMIN', N'2019-04-25 06:10:37.100', NULL, 1, 3, 0, 0, N'#f0a2c2', N'Chưa chuyển', 1, NULL)
	
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT10401 WHERE StageID = 'TTSR00002')
	INSERT INTO CRMT10401(DivisionID, StageID, StageName, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Description, OrderNo, StageType, IsSystem, Rate, Color, StageNameE, SystemStatus, DataFilter)
	VALUES ('@@@', N'TTSR00002', N'Đã chuyển thành đầu mối', 0, 1, N'ASOFTADMIN', N'2019-04-25 06:10:37.100', N'ASOFTADMIN', N'2019-04-25 06:10:37.100', NULL, 11, 3, 0, 0, N'#d9f0f8', N'Đã chuyển thành đầu mối', 2, NULL)

IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT10401 WHERE StageID = 'TTSR00003')
	INSERT INTO CRMT10401(DivisionID, StageID, StageName, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Description, OrderNo, StageType, IsSystem, Rate, Color, StageNameE, SystemStatus, DataFilter)
	VALUES ('@@@', N'TTSR00003', N'Rác', 0, 1, N'ASOFTADMIN', N'2019-04-25 06:10:37.100', N'ASOFTADMIN', N'2019-04-25 06:10:37.100', NULL, 21, 3, 0, 0, N'#dba9a9', N'Rác', 3, NULL)
	
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT10401 WHERE StageID = 'TTSR00004')
	INSERT INTO CRMT10401(DivisionID, StageID, StageName, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Description, OrderNo, StageType, IsSystem, Rate, Color, StageNameE, SystemStatus, DataFilter)
	VALUES ('@@@', N'TTSR00004', N'	Đã chuyển Saleadmin', 0, 1, N'ASOFTADMIN', N'2019-04-25 06:10:37.100', N'ASOFTADMIN', N'2019-04-25 06:10:37.100', NULL, 2, 3, 0, 0, N'#c3baba', N'Rác', 4, NULL)

-- Trạng thái chiến dịch SMS

IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT10401 WHERE StageID = 'TTCSMS00001')
	INSERT INTO CRMT10401(DivisionID, StageID, StageName, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Description, OrderNo, StageType, IsSystem, Rate, Color, StageNameE, SystemStatus, DataFilter)
	VALUES ('@@@', N'TTCSMS00001', N'Đang hoạt động', 0, 1, N'ASOFTADMIN', N'2022-12-19 12:52:30.103', N'ASOFTADMIN', N'2022-12-19 12:52:30.103', NULL, 1, 4, 0, 0, N'#3fb04e', N'Đang hoạt động', 1, NULL)
	
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT10401 WHERE StageID = 'TTCSMS00002')
	INSERT INTO CRMT10401(DivisionID, StageID, StageName, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Description, OrderNo, StageType, IsSystem, Rate, Color, StageNameE, SystemStatus, DataFilter)
	VALUES ('@@@', N'TTCSMS00002', N'Tạm ngưng', 0, 1, N'ASOFTADMIN', N'2022-12-19 12:52:30.103', N'ASOFTADMIN', N'2022-12-19 12:52:30.103', NULL, 2, 4, 0, 0, N'#ffe46b', N'Tạm ngưng', 1, NULL)
	
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT10401 WHERE StageID = 'TTCSMS00003')
	INSERT INTO CRMT10401(DivisionID, StageID, StageName, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Description, OrderNo, StageType, IsSystem, Rate, Color, StageNameE, SystemStatus, DataFilter)
	VALUES ('@@@', N'TTCSMS00003', N'Hoàn tất', 0, 1, N'ASOFTADMIN', N'2022-12-19 12:52:30.103', N'ASOFTADMIN', N'2022-12-19 12:52:30.103', NULL, 3, 4, 0, 0, N'#00a4da', N'Hoàn tất', 1, NULL)

-- Trạng thái chiến dịch email

IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT10401 WHERE StageID = 'TTCE00001')
	INSERT INTO CRMT10401(DivisionID, StageID, StageName, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Description, OrderNo, StageType, IsSystem, Rate, Color, StageNameE, SystemStatus, DataFilter)
	VALUES ('@@@', N'TTCE00001', N'Đang hoạt động', 0, 1, N'ASOFTADMIN', N'2022-12-19 12:52:30.103', N'ASOFTADMIN', N'2022-12-19 12:52:30.103', NULL, 1, 5, 0, 0, N'#3fb04e', N'Đang hoạt động', 1, NULL)
	
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT10401 WHERE StageID = 'TTCE00002')
	INSERT INTO CRMT10401(DivisionID, StageID, StageName, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Description, OrderNo, StageType, IsSystem, Rate, Color, StageNameE, SystemStatus, DataFilter)
	VALUES ('@@@', N'TTCE00002', N'Tạm ngưng', 0, 1, N'ASOFTADMIN', N'2022-12-19 12:52:30.103', N'ASOFTADMIN', N'2022-12-19 12:52:30.103', NULL, 2, 5, 0, 0, N'#ffe46b', N'Tạm ngưng', 1, NULL)
	
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT10401 WHERE StageID = 'TTCE00003')
	INSERT INTO CRMT10401(DivisionID, StageID, StageName, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Description, OrderNo, StageType, IsSystem, Rate, Color, StageNameE, SystemStatus, DataFilter)
	VALUES ('@@@', N'TTCE00003', N'Hoàn tất', 0, 1, N'ASOFTADMIN', N'2022-12-19 12:52:30.103', N'ASOFTADMIN', N'2022-12-19 12:52:30.103', NULL, 3, 5, 0, 0, N'#00a4da', N'Hoàn tất', 1, NULL)
