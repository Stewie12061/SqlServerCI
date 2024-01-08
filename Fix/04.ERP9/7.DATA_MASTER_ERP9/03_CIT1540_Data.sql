IF(SELECT COUNT(*) FROM CIT1540) < 1
BEGIN
-- Khởi tạo insert dữ liệu CIT1540 ban đầu
	DECLARE @cnt INT = 0,
			@cos varchar(50) = '',
			@mcp varchar(50) = ''
	WHILE @cnt < 30 -- Nhập số COS muốn sinh ra
	BEGIN 
		IF @cnt<9 
		BEGIN
			SET @cos = CONCAT(N'COS0', @cnt+1)
			INSERT INTO CIT1540(APK, DivisionID, TypeID, UserName, Recipe, IsUsed,CreateUserID, CreateDate, LastModifyDate, LastModifyUserID) 
			SELECT NEWID(),DivisionID, @cos , N'', N'', 0, null, GETDATE(), GETDATE(), null
			FROM AT0001
		END
		ELSE
		BEGIN
			SET @cos = CONCAT(N'COS', @cnt+1)
			INSERT INTO CIT1540(APK, DivisionID, TypeID, UserName, Recipe, IsUsed,CreateUserID, CreateDate, LastModifyDate, LastModifyUserID) 
			SELECT NEWID(),DivisionID, @cos , N'', N'', 0, null, GETDATE(), GETDATE(), null
			FROM AT0001
		END
		IF @cnt < 7 -- Nhập số MCP muốn sinh ra
		BEGIN
			SET @mcp = CONCAT(N'MCP0', @cnt+1)
			INSERT INTO CIT1540( APK, DivisionID, TypeID, UserName, Recipe, IsUsed,CreateUserID, CreateDate, LastModifyDate, LastModifyUserID) 
			SELECT NEWID(),DivisionID, @mcp , N'', N'', 0, null, GETDATE(), GETDATE(), null
			FROM AT0001
		END 
		 SET @cnt = @cnt + 1;
	END
-- Mặc định dữ liệu
Update CIT1540 SET UserName = N'Giá mua', IsUsed = 1 where	TypeID = 'MCP01'
--Update CIT1540 SET UserName = N'Giá vốn dự kiến USD' where	TypeID = 'MCP02'
--Update CIT1540 SET UserName = N'Giá vốn dự kiến VND' where	TypeID = 'MCP03'
--Update CIT1540 SET UserName = N'Giá nội bộ' where	TypeID = 'MCP04'
Update CIT1540 SET UserName = N'Giá bán', IsUsed = 1 where	TypeID = 'MCP05'
Update CIT1540 SET UserName = N'Giá Min', IsUsed = 1 where	TypeID = 'MCP06'
Update CIT1540 SET UserName = N'Giá Max', IsUsed = 1 where	TypeID = 'MCP07'
END;