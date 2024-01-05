-- Created by Khả Vi on 05/03/2018
-- Add dữ liệu vào bảng thiết lập cấp quản lý kho Module ASOFT - WM
-- Modified by on
DECLARE @DivisionID VARCHAR(50)
DECLARE @LevelID VARCHAR(50)
--DELETE WMT0001 Toàn Thiện chỉnh sửa, không delete để tránh mất thiết lập người dùng đã cài đặt

SELECT TOP 1 @DivisionID = DivisionID FROM AT1101 WITH (NOLOCK)

-----------------------------------------Loại API (APITypeID)-------------------------------------
SET @LevelID = 'Level1'
IF NOT EXISTS (SELECT TOP 1 1 FROM [dbo].[WMT0001] WHERE [DivisionID] = @DivisionID AND [LevelID] = @LevelID)
BEGIN
INSERT [dbo].[WMT0001] ([APK], [DivisionID], [LevelID], [SystemName], [UserName], [UserNameE]) VALUES (NEWID(), @DivisionID, 'Level1', N'Level1-Cấp 1', N'Cấp 1', N'Level 1')
END

SET @LevelID = 'Level2'
IF NOT EXISTS (SELECT TOP 1 1 FROM [dbo].[WMT0001] WHERE [DivisionID] = @DivisionID AND [LevelID] = @LevelID)
BEGIN
INSERT [dbo].[WMT0001] ([APK], [DivisionID], [LevelID], [SystemName], [UserName], [UserNameE]) VALUES (NEWID(), @DivisionID, 'Level2', N'Level2-Cấp 2', N'Cấp 2', N'Level 2')
END

SET @LevelID = 'Level3'
IF NOT EXISTS (SELECT TOP 1 1 FROM [dbo].[WMT0001] WHERE [DivisionID] = @DivisionID AND [LevelID] = @LevelID)
BEGIN
INSERT [dbo].[WMT0001] ([APK], [DivisionID], [LevelID], [SystemName], [UserName], [UserNameE]) VALUES (NEWID(), @DivisionID, 'Level3', N'Level3-Cấp 3', N'Cấp 3', N'Level 3')
END

SET @LevelID = 'Level4'
IF NOT EXISTS (SELECT TOP 1 1 FROM [dbo].[WMT0001] WHERE [DivisionID] = @DivisionID AND [LevelID] = @LevelID)
BEGIN
INSERT [dbo].[WMT0001] ([APK], [DivisionID], [LevelID], [SystemName], [UserName], [UserNameE]) VALUES (NEWID(), @DivisionID, 'Level4', N'Level4-Cấp 4', N'Cấp 4', N'Level 4')
END