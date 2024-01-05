IF NOT EXISTS (SELECT TOP 1 1 FROM OOT0042 WITH (NOLOCK) WHERE EventID = 'OOEV001')
	INSERT INTO OOT0042 (DivisionID, ModuleID, EventID, EventName, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, InitID)
	VALUES ('@@@', N'ASOFTOO', N'OOEV001', N'Công việc mới được tạo', GETDATE(), N'ASOFTADMIN', GETDATE(), N'ASOFTADMIN', 1)
	
IF NOT EXISTS (SELECT TOP 1 1 FROM OOT0042 WITH (NOLOCK) WHERE EventID = 'OOEV002')
	INSERT INTO OOT0042 (DivisionID, ModuleID, EventID, EventName, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, InitID)
	VALUES ('@@@', N'ASOFTOO', N'OOEV002', N'Được gán phụ trách công việc', GETDATE(), N'ASOFTADMIN', GETDATE(), N'ASOFTADMIN', 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT0042 WITH (NOLOCK) WHERE EventID = 'OOEV003')
	INSERT INTO OOT0042 (DivisionID, ModuleID, EventID, EventName, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, InitID)
	VALUES ('@@@', N'ASOFTOO', N'OOEV003', N'Được gán đánh giá công việc', GETDATE(), N'ASOFTADMIN', GETDATE(), N'ASOFTADMIN', 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT0042 WITH (NOLOCK) WHERE EventID = 'OOEV004')
	INSERT INTO OOT0042 (DivisionID, ModuleID, EventID, EventName, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, InitID)
	VALUES ('@@@', N'ASOFTOO', N'OOEV004', N'Được gán hỗ trợ công việc', GETDATE(), N'ASOFTADMIN', GETDATE(), N'ASOFTADMIN', 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT0042 WITH (NOLOCK) WHERE EventID = 'OOEV005')
	INSERT INTO OOT0042 (DivisionID, ModuleID, EventID, EventName, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, InitID)
	VALUES ('@@@', N'ASOFTOO', N'OOEV005', N'Dự án mới được tạo', GETDATE(), N'ASOFTADMIN', GETDATE(), N'ASOFTADMIN', 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT0042 WITH (NOLOCK) WHERE EventID = 'OOEV006')
	INSERT INTO OOT0042 (DivisionID, ModuleID, EventID, EventName, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, InitID)
	VALUES ('@@@', N'ASOFTOO', N'OOEV006', N'Được gán phụ trách dự án', GETDATE(), N'ASOFTADMIN', GETDATE(), N'ASOFTADMIN', 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT0042 WITH (NOLOCK) WHERE EventID = 'OOEV007')
	INSERT INTO OOT0042 (DivisionID, ModuleID, EventID, EventName, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, InitID)
	VALUES ('@@@', N'ASOFTOO', N'OOEV007', N'Được gán hỗ hợ dự án', GETDATE(), N'ASOFTADMIN', GETDATE(), N'ASOFTADMIN', 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT0042 WITH (NOLOCK) WHERE EventID = 'OOEV008')
	INSERT INTO OOT0042 (DivisionID, ModuleID, EventID, EventName, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, InitID)
	VALUES ('@@@', N'ASOFTOO', N'OOEV008', N'Được gán đánh giá công việc dự án', GETDATE(), N'ASOFTADMIN', GETDATE(), N'ASOFTADMIN', 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT0042 WITH (NOLOCK) WHERE EventID = 'OOEV009')
	INSERT INTO OOT0042 (DivisionID, ModuleID, EventID, EventName, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, InitID)
	VALUES ('@@@', N'ASOFTOO', N'OOEV009', N'Công việc bị trễ', GETDATE(), N'ASOFTADMIN', GETDATE(), N'ASOFTADMIN', 1)

IF NOT EXISTS (SELECT TOP 1 1 FROM OOT0042 WITH (NOLOCK) WHERE EventID = 'OOEV010')
	INSERT INTO OOT0042 (DivisionID, ModuleID, EventID, EventName, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, InitID)
	VALUES ('@@@', N'ASOFTOO', N'OOEV010', N'Được gán giám sát công việc', GETDATE(), N'ASOFTADMIN', GETDATE(), N'ASOFTADMIN', 1)

-- [15/01/2020] Trường lãm - Bổ sung người theo dõi
IF NOT EXISTS (SELECT TOP 1 1 FROM OOT0042 WITH (NOLOCK) WHERE EventID = 'OOEV011')
	INSERT INTO OOT0042 (DivisionID, ModuleID, EventID, EventName, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, InitID)
	VALUES ('@@@', N'ASOFTOO', N'OOEV011', N'Người theo dõi', GETDATE(), N'ASOFTADMIN', GETDATE(), N'ASOFTADMIN', 1)

-- Insert giá trị Init cho bảng OOT0043

BEGIN
	DECLARE
			@Cur CURSOR,
			@Cur1 CURSOR

	DECLARE @DivisionID VARCHAR(50),
			@GroupID VARCHAR(50),
			@EventID VARCHAR(50),
			@ModuleID VARCHAR(50)

	SET @Cur = CURSOR SCROLL KEYSET FOR
	-- Bảng dữ liệu Nhóm người dùng
	SELECT DivisionID, GroupID
	FROM AT1401 WITH (NOLOCK) WHERE ISNULL(Disabled, 0) = 0
	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @DivisionID, @GroupID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Cur1 = CURSOR SCROLL KEYSET FOR
		SELECT EventID, ModuleID
		FROM OOT0042 WITH (NOLOCK)
		OPEN @Cur1
		FETCH NEXT FROM @Cur1 INTO @EventID, @ModuleID
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF NOT EXISTS (SELECT TOP 1 1 FROM OOT0043 WITH (NOLOCK) WHERE EventID = @EventID AND ModuleID = @ModuleID AND GroupID = @GroupID)
			BEGIN
				INSERT INTO OOT0043 (DivisionID, APKMaster, UserID, EventID, SendNotification, CreateDate, CreateUserID
						, LastModifyDate, LastModifyUserID, ModuleID, GroupID)
				SELECT DivisionID, APK, CreateUserID, EventID, 1, GETDATE(), CreateUserID, GETDATE(), LastModifyUserID, ModuleID, @GroupID
				FROM OOT0042 WITH (NOLOCK) WHERE EventID = @EventID
			END
			FETCH NEXT FROM @Cur1 INTO @EventID, @ModuleID
		END
		CLOSE @Cur1
		FETCH NEXT FROM @Cur INTO @DivisionID, @GroupID
	END
	CLOSE @Cur
END