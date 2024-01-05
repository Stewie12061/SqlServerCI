-- <Summary>
---- Insert dữ liệu ngầm thiết lập key hệ thống vào bảng ST2101
---- Phần 1: ADD NEW DỮ Liệu
---- Phần 2: UPDATE DỮ LIỆU BỊ SAI
-- <History>
---- Create on 22/01/2021 Created by Tấn Thành
---- Update on 29/06/2022 Update by Đức Tuyên: UseAPIEnterpriseInformation: Bật/tắt hỗ trợ lấy thông tin doanh nghiệp từ MST


DECLARE 
	@APK UNIQUEIDENTIFIER,
	@DivisionID VARCHAR(50), -- DivisionID, Dùng chung: @@@.
	@TypeID TINYINT, -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
	@GroupID TINYINT, -- Xem AT0099 CodeMaster = 'GroupConfig'.
	@KeyName VARCHAR(250), -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
	@KeyValue VARCHAR(MAX), 
	@ValueDataType TINYINT, -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
	@DefaultValue TINYINT, -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
	@ModuleID VARCHAR(50),
	@IsEnvironment TINYINT, -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
	@Description NVARCHAR(MAX),
	@DescriptionE VARCHAR(MAX),
	@OrderNo INT,
	@TimeNow DATETIME = GETDATE(),
	@DateRunFix DATETIME,
	@CheckTime DATETIME,
	@APKUpdate UNIQUEIDENTIFIER

---- PHẦN 1
---------------------------------------- BEGIN *Lưu trữ & API - Hostting & API* ----------------------------------------
SET @GroupID = 1  -- Xem AT0099 CodeMaster = 'GroupConfig'.
--- MainURL
SET @OrderNo = 1

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'MainURL' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '192.168.1.205'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 4 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Domain ERP9'
SET @DescriptionE = 'Domain ERP9'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- MainPort
SET @OrderNo = 2

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'MainPort' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '1102'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 5 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Port ERP 9'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- MainAPIURL
SET @OrderNo = 3

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'MainAPIURL' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '192.168.1.205'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 4 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Domain API'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- MainAPIPort
SET @OrderNo = 4

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'MainAPIPort' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '1102'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 5 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Port API'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- WebPhysicalPath
SET @OrderNo = 5

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'WebPhysicalPath' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '192.168.0.200\sof\02. TEST\02.wwwroot\8922_ASOFT-Mobile'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 12 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Đường dẫn thư mục Web ERP9'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- APIPhysicalPath
SET @OrderNo = 6

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'APIPhysicalPath' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '192.168.0.200\sof\02. TEST\02.wwwroot\8922_ASOFT-Mobile'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 12 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Đường dẫn thư mục API'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- DevMode
SET @OrderNo = 7

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'DevMode' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '0'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 2 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Bật/tắt thanh tiện ích DevMode'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- Capacity: Dung lượng
SET @OrderNo = 8

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'Capacity' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '3000'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 7 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Dung lượng cột mốc (MB) để vẽ chart'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- NumberOfDayNoInteraction: Thiết lập số ngày đầu mối/Cơ hội đã lâu không tương tác 
SET @OrderNo = 9

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'NumberOfDayNoInteraction' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '20'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 7 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Thiết lập số ngày không tương tác'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- NumberOfDayNoInteraction: API thông tin doanh nghiệp
SET @OrderNo = 10

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'APIEnterpriseInformation' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = 'https://thongtindoanhnghiep.co/api/company/'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 3 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'API thông tin doanh nghiệp'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- UseAPIEnterpriseInformation: Bật/tắt hỗ trợ lấy thông tin doanh nghiệp từ MST
SET @OrderNo = 10

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'UseAPIEnterpriseInformation' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '1' -- 0: Tắt, 1: Bật
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 2 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Bật/tắt hỗ trợ lấy thông tin doanh nghiệp từ MST'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- UseCallScreen: Bật/tắt màn hình hỗ trợ gọi online
SET @OrderNo = 11

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'UseCallScreen' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '1' -- 0: Tắt, 1: Bật
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 7 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Bật/tắt màn hình hỗ trợ gọi online'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- LanguagePair: Chọn cặp ngôn ngữ cho hệ thống
SET @OrderNo = 12

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = N'LanguagePair' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = N'vi-VN|en-US'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Chọn cặp ngôn ngữ cho hệ thống'
SET @DescriptionE = N'Select a language pair for the system'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- DealerDivisionID: Division giả để phục vụ tách dữ liệu để bán hàng Sale out - bán lẻ
SET @OrderNo = 13

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = N'DealerDivisionID' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = N'...'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Division giả để phục vụ tách dữ liệu để bán hàng Sale out - bán lẻ'
SET @DescriptionE = N'Fake division to serve to separate data for sales Sale out - retail'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- DealerDivisionID: Division giả để phục vụ tách dữ liệu để bán hàng Sale out - bán lẻ
SET @OrderNo = 14

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = N'DealerData' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = N'...'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Database Sellout'
SET @DescriptionE = N'Database Sellout'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- AppActive - Đánh dấu app nào đang được hoạt động để get title
SET @OrderNo = 15

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'AppActive' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '1'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 7 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'1 - ASOFT Super App đang được dùng, 2 - 1BOSS Super App đang được dùng'
SET @DescriptionE = N'1 - ASOFT Super App đang được dùng, 2 - 1BOSS Super App đang được dùng'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END
---------------------------------------- END *Lưu trữ & API - Hostting & API* ----------------------------------------

---------------------------------------- BEGIN *Bảo mật - Sercurity* ----------------------------------------
SET @GroupID = 2  -- Xem AT0099 CodeMaster = 'GroupConfig'.
--- UseFingerprint
SET @OrderNo = 1

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'UseFingerprint' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '0'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 2 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Bật tắt ghi lịch sử đăng nhập'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- ManualTokenERP9
SET @OrderNo = 2

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'ManualTokenERP9' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = 'hkv156jcbhkjvcbKJlkjbvSAHG8D4521VX12C234AG4574JSVB456bhdgfs78214OFidugjvmkjbvcbcvhjdfgjkbcnmhg7675JHBJHBVBSV6JHJHj7sdfj32156465431ksf'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Token bảo mật ERP9'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- UserTokenLength
SET @OrderNo = 3

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'UserTokenLength' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '24'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 8 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Độ dài TokenUser'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- GoogleCaptchaKey: Thiết lập SiteKey|SecretKey để sử dụng google captcha
SET @OrderNo = 4

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'GoogleCaptchaKey' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = N'6LdSMgkdAAAAAET3v40qMXK4U5vZPVCjazxwKXAX|6LdSMgkdAAAAAMERO_YHt9gAQzN2EyWf0uZBM_Tf'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Thiết lập SiteKey|SecretKey để sử dụng google captcha'
SET @DescriptionE = N'Setup SiteKey|SecretKey'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END
---------------------------------------- END *Bảo mật - Sercurity* ----------------------------------------

---------------------------------------- BEGIN *Thông báo - Notification* ----------------------------------------
SET @GroupID = 3  -- Xem AT0099 CodeMaster = 'GroupConfig'.
--- UseNotificationBell
SET @OrderNo = 1

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'UseNotificationBell' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '1'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 2 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Bật/tắt chuông thông báo'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- BellNotificationDelayTime
SET @OrderNo = 2

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'BellNotificationDelayTime' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '1'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 7 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Thời gian chờ lấy dữ liệu thông báo để gửi(tính bằng giây), càng lớn càng gửi nhiều thông báo cùng lúc, thiết lập phải lớn hơn thời gian quét của Automation'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- UseNotificationApp
SET @OrderNo = 3

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'UseNotificationApp' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '1'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 2 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Bật/tắt Gửi thông báo từ ERP9 sang SupperApps'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- UseNotificationSMS
SET @OrderNo = 4

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'UseNotificationSMS' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '0'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 2 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Bật/tắt Gửi SMS thông báo'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- UseNotificationEmail
SET @OrderNo = 5

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'UseNotificationEmail' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '0'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 2 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Bật/tắt Gửi Mail thông báo'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

---------------------------------------- END *Thông báo - Notification* ----------------------------------------

---------------------------------------- BEGIN *Tự động hóa - Automation* ----------------------------------------
SET @GroupID = 4  -- Xem AT0099 CodeMaster = 'GroupConfig'.
--- Status
SET @OrderNo = 1

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'Status' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '1'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 2 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Bật/tắt Tự động hóa'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- TimeScan
SET @OrderNo = 2

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'TimeScan' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '1'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 7 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Thời gian quét tự động định kỳ'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- TypeOfTime
SET @OrderNo = 3

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'TypeOfTime' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '1'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 7 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Đơn vị thời gian quét định kỳ: 0 - phút, 1 - Giờ '
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

---------------------------------------- END *Tự động hóa - Automation* ----------------------------------------

---------------------------------------- BEGIN *Ứng dụng di động - SuperApps* ----------------------------------------
SET @GroupID = 5  -- Xem AT0099 CodeMaster = 'GroupConfig'.
--- HideEmptyField
SET @OrderNo = 1

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'HideEmptyField' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '1'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 2 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Ẩn cái field trống'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- EnableTrackingLocation
SET @OrderNo = 2

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'EnableTrackingLocation' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '1'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 2 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Bật tính năng lịch sử nhân viên'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- Khoảng cách checkin
SET @OrderNo = 3

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'CheckinDistance' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '50'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 8 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Khoảng cách checkin'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- yêu cầu hình ảnh checkin
SET @OrderNo = 4

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'IsCheckinImage' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '0'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 2 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Bắt buộc chụp hình checkin'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- Số ảnh tối đa khi check in
SET @OrderNo = 5

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'MaxImageQuantity' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '5'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 8 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Số ảnh tối đa khi checkin'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- sử dụng custom googlemap key
SET @OrderNo = 6

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'isGoogleKey' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '1'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 2 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Sử dụng custom googlemap key'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END
--- Custom Google Map Key
SET @OrderNo = 1

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'googleKey' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = ''
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 4 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Custom googlemap key'
SET @DescriptionE = 'Custom googlemap key'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END
---------------------------------------- END *Ứng dụng di động - SuperApps* ----------------------------------------

---------------------------------------- BEGIN *Trung tâm cuộc gọi - Call Center* ----------------------------------------
SET @GroupID = 6  -- Xem AT0099 CodeMaster = 'GroupConfig'.
--- SipServer
SET @OrderNo = 1

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'SipServer' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '192.168.0.205'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 4 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'SipServer'
SET @DescriptionE = 'SipServer'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- cdrsSipServer
SET @OrderNo = 2

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'cdrsSipServer' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = 'https://dial.voip24h.vn/dial/history'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 3 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'cdrsSipServer'
SET @DescriptionE = 'cdrsSipServer'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- registrationsSipServer
SET @OrderNo = 3

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'registrationsSipServer' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = 'https://api.ccall.vn/ext_reg/json'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 3 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'registrationsSipServer'
SET @DescriptionE = 'registrationsSipServer'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- api_key
SET @OrderNo = 4

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'api_key' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '0e9718c31342106e1a659fa91636980f44d76930'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'api_key'
SET @DescriptionE = 'api_key'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- api_secret
SET @OrderNo = 5

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'api_secret' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '16b5842a449f33bd8747e1fd9b9499dd'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'api_secret'
SET @DescriptionE = 'api_secret'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- DID_Number
SET @OrderNo = 6

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'DID_Number' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '19006123'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'DID_Number'
SET @DescriptionE = 'DID_Number'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- WebsocketSipServer: Wss URL  dùng để kết từ website đến tổng đài.
SET @OrderNo = 7

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'WebsocketSipServer' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = 'wss://webrtc.voip24h.vn:8089/ws'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 4 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Wss URL dùng để kết từ website đến tổng đài'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END
---------------------------------------- END *Trung tâm cuộc gọi - Call Center* ----------------------------------------

---------------------------------------- BEGIN *Google Firebase - Google Firebase* ----------------------------------------
SET @GroupID = 7  -- Xem AT0099 CodeMaster = 'GroupConfig'.
--- FB_apiKey
SET @OrderNo = 1

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'FB_apiKey' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = 'AIzaSyCnNSNVn0lzR5B5cjBgYHgcOzvzQCcPO0I'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'FB_apiKey'
SET @DescriptionE = 'FB_apiKey'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- FB_authDomain
SET @OrderNo = 2

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'FB_authDomain' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = 'asoft-erp.firebaseapp.com'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'FB_authDomain'
SET @DescriptionE = 'FB_authDomain'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- FB_databaseURL
SET @OrderNo = 3

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'FB_databaseURL' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = 'https://asoft-erp.firebaseio.com'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'FB_databaseURL'
SET @DescriptionE = 'FB_databaseURL'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- FB_projectId
SET @OrderNo = 4

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'FB_projectId' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = 'asoft-erp'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'FB_projectId'
SET @DescriptionE = 'FB_projectId'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- FB_storageBucket
SET @OrderNo = 5

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'FB_storageBucket' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = 'asoft-erp.appspot.com'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'FB_storageBucket'
SET @DescriptionE = 'FB_storageBucket'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- FB_messagingSenderId
SET @OrderNo = 6

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'FB_messagingSenderId' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '606315253866'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'FB_messagingSenderId'
SET @DescriptionE = 'FB_messagingSenderId'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- FB_appId
SET @OrderNo = 7

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'FB_appId' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '1:606315253866:web:517ab49006002c2a7bba13'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'FB_appId'
SET @DescriptionE = 'FB_appId'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- FB_measurementId
SET @OrderNo = 8

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'FB_measurementId' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = 'G-W01218ZJ3Q'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'FB_measurementId'
SET @DescriptionE = 'FB_measurementId'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

---------------------------------------- END *Google Firebase - Google Firebase* ----------------------------------------

---------------------------------------- BEGIN *SMS API* ----------------------------------------
SET @GroupID = 8  -- Xem AT0099 CodeMaster = 'GroupConfig'.
--- api_key
SET @OrderNo = 1

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'api_key' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = 'DEDE6C186036E314A9DB63B6C40' --''
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'api_key'
SET @DescriptionE = 'api_key'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- api_secret
SET @OrderNo = 2

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'api_secret' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = 'E8E40B3DD6A2484C35AE54300B3EDA' --''
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'api_secret'
SET @DescriptionE = 'api_secret'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- brandname 
SET @OrderNo = 3

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'brandname' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = 'BrandName'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'brandname'
SET @DescriptionE = 'brandname'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- Provider: Tên nhà cung cấp
SET @OrderNo = 4

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'provider' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = 'motiplus'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Nhà cung cấp'
SET @DescriptionE = 'Provider'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- API_Domain: domain của API
SET @OrderNo = 5

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'api_domain' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = 'http://motiplus.vn'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'API Domain'
SET @DescriptionE = 'API Domain'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END
---------------------------------------- END *SMS API * ----------------------------------------

---------------------------------------- BEGIN *Logo và màu sắc* ----------------------------------------
SET @GroupID = 9  -- Xem AT0099 CodeMaster = 'GroupConfig'.
--- useCustomTheme
SET @OrderNo = 1

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'useCustomTheme' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '0' --''
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue =  2 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Sử dụng custom theme'
SET @DescriptionE = 'Use custom theme'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- primaryColor
SET @OrderNo = 2

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'primaryColor' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '#FFFFFF' --''
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Màu chính'
SET @DescriptionE = 'Primary Color'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

---  secondaryColor
SET @OrderNo = 3

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'secondaryColor' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '#ffffff'
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Màu phụ, màu background cho màn hình login trên app'
SET @DescriptionE = 'Secondary Color, Background color for the mobile app login screen'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

---------------------------------------- END *Logo và màu sắc* ----------------------------------------

---------------------------------------- BEGIN *Cloud* -----------------------------------
SET @GroupID = 10  -- Xem AT0099 CodeMaster = 'GroupConfig'.
--- domain cloud
SET @OrderNo = 2

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'CloudDomain' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '1boss.vn' --''
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Cloud Domain'
SET @DescriptionE = 'Cloud Domain'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

SET @GroupID = 10  -- Xem AT0099 CodeMaster = 'GroupConfig'.
--- domain cloud
SET @OrderNo = 3

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'GatewayUpdateURL' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = 'https://gateway.1boss.vn/api/actions/update' --''
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Đường dẫn trigger để proxy reload'
SET @DescriptionE = 'Cloud Domain'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

--- Số ngày dùng thử 
SET @OrderNo = 4

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'TrialDay' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '7' --''
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue =  7 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Thời gian dùng thử'
SET @DescriptionE = 'Thời gian dùng thử'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

---------------------------------------- END


---------------------------------------- BEGIN *Cảnh báo - Warning* -----------------------------------
SET @GroupID = 3  -- Xem AT0099 CodeMaster = 'GroupConfig'.
--- UseWarningDebtObject
SET @OrderNo = 1

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 1 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'UseWarningDebtObject' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '0'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 2 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Bật/tắt cảnh báo công nợ quá hạn'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END
--- UseWarningOverBudget
SET @OrderNo = 2

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 1 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'UseWarningOverBudget' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '0'
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 2 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 1 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Bật/tắt cảnh báo chi phí vượt chỉ tiêu ngân sách'
SET @DescriptionE = ''

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END
---------------------------------------- END

--------------------------------------- BEGIN *Facebook API* ----------------------------------------
SET @GroupID = 11  -- Xem AT0099 CodeMaster = 'GroupConfig'.
--- api_key
SET @OrderNo = 1

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'fb_access_token' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = 'EAADBsC2m8moBAEodMfJJEgACCgFJU8cdpnZCCvMRaIdWyPk0J3lLPSbhy0jta4zebO2YzMHGH2RNNOVbZADKZBDZBTLNfaAmjSfeZBZBoowRYvMXbnIeSuvNBMJeybj95CKo6QPuEAV8THoZC3lzNKH6nafZCZAe2M2ShrABgHZBOLjsfwZBzkzyR4j' --''
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'.
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Token kết nối API của FB'
SET @DescriptionE = 'Token connect to FB API'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END


---------------------------------------- END *Facebook API * ----------------------------------------


--------------------------------------- BEGIN *Zalo API* ----------------------------------------
SET @GroupID = 12  -- Xem AT0099 CodeMaster = 'GroupConfig'.
--- api_key
SET @OrderNo = 1

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'zalo_refresh_token' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số. (3 tháng hết hạn *lần đầu sài phải khởi tạo mã mới*)
SET @KeyValue = '85f4ppDetWyW13NgSWo4EWL2D_SeFgmUPqabopLucsqGVXAMDYxkIbOWP8ePKDL3DoD4aG1hyNKcONtK1sJt8IS74xTxCPXpC4GXkHi-jsTCPWY5Idkq1Y9kVhTHGiiEJWuiZ4KMn1PwPbUqJGhWL6a0QV5B1UO4MNyUaXv0ha9c1C4_IYn2vZrfjWTxvmwNQD2L1JxTQfPmiFSoKQvGcMQjsmauk3IRVQR9Bpoq9x9P9eVGINisRFnV' --''
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'.
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Token lấy access token của Zalo'
SET @DescriptionE = 'Token get access token of Zalo'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'zalo_secret_key' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '52U748Wd1U1qM0UWXHlY' --''
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'.
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Secret key của zalo'
SET @DescriptionE = 'Secret key of zalo'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'zalo_app_id' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '408997672465788393' --''
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'.
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'App ID của zalo'
SET @DescriptionE = 'App ID of zalo'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 2 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'zalo_access_token' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = 'fsotLSUvf02fOhnMnxkX3ATaibtHyDfiktg9MOdU-akuHPviql3_RzagXcxPbVnJoosC2VMeqI767S8sg9tU6SaKiI72dFaPspsG7wwrq2o2OQKibENP0w9wcogruD1-ZsUIBh_YrdkmE9jJewRoPyeDbp2gZV8gmJw_VS-8sq370PiH_9lf9ijEkoVqnFinrcgu8kBqmIZBRe0evE_m7EHcbKpvqF4PnWZY8iwzZIlE6SulpApT1z8VlIAveTu8iZgkAwAWyo2P1w4uWxxdBQC8lo6KYA08dmF8CBUer2BS1xalqOxbUFutjKtBb_LrfW7gJxc7yrU50ufnYwp4UvS1s55vMEmgOikkgGS' --''
SET @ValueDataType = 1 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 1 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'.
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Token kết nối API của Zalo'
SET @DescriptionE = 'Token connect to Zalo API'

IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END
---------------------------------------- END *Zalo API * ----------------------------------------

---------------------------------------- BEGIN *SO Setting* -----------------------------------
SET @GroupID = 13  -- Xem AT0099 CodeMaster = 'GroupConfig'.
--- domain cloud
SET @OrderNo = 1

SET @APK = NEWID()
SET @DivisionID = '@@@' -- DivisionID, Dùng chung: @@@.
SET @TypeID = 1 -- 1 - Nghiệp vụ, 2 - Hệ thống. Xem thêm AT0099 - CodeMaster = 'ConfigType'.
SET @KeyName = 'SOSaveOrderMode' -- Key: Viết liền, không dấu, không ký tự đặc biệt, không là số, không bắt đầu từ số.
SET @KeyValue = '3' --''
SET @ValueDataType = 2 -- Kiểu dữ liệu của Key Value. Xem AT0099 CodeMaster = 'DataType'.
SET @DefaultValue = 7 -- Dữ liệu mặc định. Xem AT0099 CodeMaster = 'DataClassification'. 
SET @ModuleID = ''
SET @IsEnvironment = 0 -- Biến môi trường, 0/1 => có tự load khi Start IIS không?
SET @Description = N'Thiết lập luồng lưu đơn hàng trên APP'
SET @DescriptionE = 'Save order flow setting on APP'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName)
	INSERT INTO ST2101(APK, APKMaster, DivisionID, TypeID, GroupID, KeyName, KeyValue, ValueDataType, DefaultValue, ModuleID, Description, DescriptionE, IsEnvironment, OrderNo, CreateDate)
	VALUES (@APK, NEWID(), @DivisionID, @TypeID, @GroupID, @KeyName, @KeyValue, @ValueDataType, @DefaultValue, @ModuleID, @Description, @DescriptionE, @IsEnvironment, @OrderNo, @TimeNow)
ELSE
BEGIN
	SELECT TOP 1 @APKUpdate = APK, @CheckTime = LastModifyDate, @DateRunFix = CreateDate FROM ST2101 WITH (NOLOCK) WHERE GroupID = @GroupID AND KeyName = @KeyName

	IF @CheckTime IS NULL
		UPDATE ST2101 SET DivisionID = @DivisionID, TypeID = @TypeID, GroupID = @GroupID, KeyName = @KeyName, KeyValue = @KeyValue, ValueDataType = @ValueDataType, 
		DefaultValue = @DefaultValue, ModuleID = @ModuleID, Description = @Description, DescriptionE = @DescriptionE, IsEnvironment = @IsEnvironment, OrderNo = @OrderNo, CreateDate = @TimeNow
		WHERE APK = @APKUpdate
END

---------------------------------------- END *SO Setting* ----------------------------------------


---- PHẦN 2

UPDATE ST2101 SET IsEnvironment = 1 WHERE GroupID = 1 AND KeyName IN ('DevMode')

UPDATE ST2101 SET IsEnvironment = 1 WHERE GroupID = 2 AND KeyName IN ('UseFingerprint','ManualTokenERP9')

UPDATE ST2101 SET IsEnvironment = 1 WHERE GroupID = 3 AND KeyName IN ('UseNotificationBell','UseNotificationApp','UseNotificationEmail','UseNotificationSMS','BellNotificationDelayTime')

UPDATE ST2101 SET IsEnvironment = 1 WHERE GroupID = 4 AND KeyName IN ('Status','TimeScan','TypeOfTime')

UPDATE ST2101 SET IsEnvironment = 1 WHERE GroupID = 7 AND KeyName IN ('FB_apiKey','FB_authDomain','FB_databaseURL','FB_projectId','FB_storageBucket','FB_messagingSenderId','FB_appId','FB_measurementId')


-- UPDATE WITHOUT (KeyName, KeyValue, Description)
UPDATE ST2101 SET OrderNo = 1 WHERE KeyName = 'MainURL' AND GroupID = 1
UPDATE ST2101 SET OrderNo = 2 WHERE KeyName = 'MainPort' AND GroupID = 1
UPDATE ST2101 SET OrderNo = 3 WHERE KeyName = 'MainAPIURL' AND GroupID = 1
UPDATE ST2101 SET OrderNo = 4 WHERE KeyName = 'MainAPIPort' AND GroupID = 1
UPDATE ST2101 SET OrderNo = 5 WHERE KeyName = 'WebPhysicalPath' AND GroupID = 1
UPDATE ST2101 SET OrderNo = 6 WHERE KeyName = 'APIPhysicalPath' AND GroupID = 1
UPDATE ST2101 SET OrderNo = 7 WHERE KeyName = 'DevMode' AND GroupID = 1

UPDATE ST2101 SET OrderNo = 1 WHERE KeyName = 'UseFingerprint' AND GroupID = 2
UPDATE ST2101 SET OrderNo = 2 WHERE KeyName = 'ManualTokenERP9' AND GroupID = 2 
UPDATE ST2101 SET OrderNo = 3 WHERE KeyName = 'UserTokenLength' AND GroupID = 2


UPDATE ST2101 SET OrderNo = 1 WHERE KeyName = 'UseNotificationBell' AND GroupID = 3
UPDATE ST2101 SET OrderNo = 2 WHERE KeyName = 'BellNotificationDelayTime' AND GroupID = 3
UPDATE ST2101 SET OrderNo = 3 WHERE KeyName = 'UseNotificationApp' AND GroupID = 3
UPDATE ST2101 SET OrderNo = 4 WHERE KeyName = 'UseNotificationSMS' AND GroupID = 3 
UPDATE ST2101 SET OrderNo = 5 WHERE KeyName = 'UseNotificationEmail' AND GroupID = 3

UPDATE ST2101 SET OrderNo = 1 WHERE KeyName = 'Status' AND GroupID = 4
UPDATE ST2101 SET OrderNo = 2 WHERE KeyName = 'TimeScan' AND GroupID = 4
UPDATE ST2101 SET OrderNo = 3 WHERE KeyName = 'TypeOfTime' AND GroupID = 4

UPDATE ST2101 SET OrderNo = 1 WHERE KeyName = 'HideEmptyField' AND GroupID = 5

UPDATE ST2101 SET OrderNo = 1 WHERE KeyName = 'SipServer' AND GroupID = 6
UPDATE ST2101 SET OrderNo = 2 WHERE KeyName = 'cdrsSipServer' AND GroupID = 6
UPDATE ST2101 SET OrderNo = 3 WHERE KeyName = 'registrationsSipServer' AND GroupID = 6
UPDATE ST2101 SET OrderNo = 4 WHERE KeyName = 'api_key' AND GroupID = 6
UPDATE ST2101 SET OrderNo = 5 WHERE KeyName = 'api_secret' AND GroupID = 6
UPDATE ST2101 SET OrderNo = 6 WHERE KeyName = 'DID_Number' AND GroupID = 6

UPDATE ST2101 SET OrderNo = 1 WHERE KeyName = 'FB_apiKey' AND GroupID = 7
UPDATE ST2101 SET OrderNo = 2 WHERE KeyName = 'FB_authDomain' AND GroupID = 7
UPDATE ST2101 SET OrderNo = 3 WHERE KeyName = 'FB_databaseURL' AND GroupID = 7
UPDATE ST2101 SET OrderNo = 4 WHERE KeyName = 'FB_projectId' AND GroupID = 7
UPDATE ST2101 SET OrderNo = 5 WHERE KeyName = 'FB_storageBucket' AND GroupID = 7
UPDATE ST2101 SET OrderNo = 6 WHERE KeyName = 'FB_messagingSenderId' AND GroupID = 7
UPDATE ST2101 SET OrderNo = 7 WHERE KeyName = 'FB_appId' AND GroupID = 7
UPDATE ST2101 SET OrderNo = 8 WHERE KeyName = 'FB_measurementId' AND GroupID = 7