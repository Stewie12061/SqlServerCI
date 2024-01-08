------------------------------------------------------------------------------------------------------
-- Fix Bổ sung phân quyền màn hình -- Module HRM
-- @ScreenType: 1-Báo cáo; 2-Danh mục; 3-Nhập liệu; 4-Khác; 5 - Xem chi tiết
------------------------------------------------------------------------------------------------------
-- Store Insert dữ liệu phân quyền màn hình V2 (AT1404 - Danh mục màn hình, AT1403 - Thiết lập phân quyền)
------------------------------------------------------------------------------------------------------
-- Create	By Tấn Thành	- 18/03/2021
-- Modified By Văn Tài		- 21/06/2023 - Bổ sung WITH (NOLOCK)


IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AddScreenERP9_V2]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AddScreenERP9_V2]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE AddScreenERP9_V2
(
    @ModuleID VARCHAR(50),
    @ScreenID NVARCHAR(4000),
    @ScreenType TINYINT,
    @ScreenName NVARCHAR(4000),
    @ScreenNameE NVARCHAR(4000),
	@CustomerIndex INT = -1,
	@CommonID VARCHAR(50) = NULL
)
AS

--DECLARE @ModuleID AS NVARCHAR(50) = 'AsoftS'

--Insert thêm vào bảng STD
IF NOT EXISTS (SELECT TOP 1 1 FROM AT1404STD WITH (NOLOCK) WHERE ModuleID = @ModuleID AND ScreenID = @ScreenID)
INSERT INTO AT1404STD (ModuleID, ScreenID,ScreenName,ScreenNameE, ScreenType, SourceID, CommonID, CustomerIndex) 
			VALUES(@ModuleID, @ScreenID, @ScreenName, @ScreenNameE, @ScreenType, 'ERP9', @CommonID, @CustomerIndex)
ELSE  
	UPDATE AT1404STD  SET 
	ScreenType = @ScreenType,
	ScreenName = @ScreenName,
	ScreenNameE = @ScreenNameE,
	CommonID = @CommonID,
	CustomerIndex = @CustomerIndex
	WHERE ModuleID = @ModuleID 
	AND ScreenID = @ScreenID

-- insert vào bảng thường
IF NOT EXISTS (SELECT TOP 1 1 FROM AT1404 WITH (NOLOCK) WHERE ModuleID = @ModuleID AND ScreenID = @ScreenID)
INSERT INTO AT1404 (DivisionID, ModuleID, ScreenID,ScreenName,ScreenNameE, ScreenType, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate,SourceID, CommonID, CustomerIndex) 
			(SELECT DivisionID, @ModuleID, @ScreenID, @ScreenName, @ScreenNameE, @ScreenType, 'ASOFTADMIN', GETDATE() , 'ASOFTADMIN', GETDATE(),'ERP9', @CommonID, @CustomerIndex
			FROM AT1101)
ELSE
BEGIN
	IF(@CommonID IS NULL)
	BEGIN
		UPDATE AT1404  SET 
		ScreenType = @ScreenType,
		ScreenName = @ScreenName,
		ScreenNameE = @ScreenNameE,
		SourceID = 'ERP9',
		CustomerIndex = @CustomerIndex,
		LastModifyUserID = 'ASOFTADMIN',
		LastModifyDate = GETDATE()
		WHERE ModuleID = @ModuleID 
		AND ScreenID = @ScreenID
		AND EXISTS (SELECT TOP 1 1 FROM AT1101 WITH (NOLOCK) WHERE AT1101.DivisionID=AT1404.DivisionID)

		UPDATE AT1403
		SET SourceID = 'ERP9'
		WHERE ModuleID = @ModuleID
		AND ScreenID = @ScreenID
		AND EXISTS (SELECT TOP 1 1 FROM AT1101 WITH (NOLOCK) WHERE AT1101.DivisionID=AT1403.DivisionID)
	END
	ELSE
	BEGIN
		UPDATE AT1404  SET 
		ScreenType = @ScreenType,
		ScreenName = @ScreenName,
		ScreenNameE = @ScreenNameE,
		SourceID = 'ERP9',
		CustomerIndex = @CustomerIndex,
		LastModifyUserID = 'ASOFTADMIN',
		LastModifyDate = GETDATE(),
		CommonID = @CommonID
		WHERE ModuleID = @ModuleID 
		AND ScreenID = @ScreenID
		AND EXISTS (SELECT TOP 1 1 FROM AT1101 WITH (NOLOCK) WHERE AT1101.DivisionID=AT1404.DivisionID)

		UPDATE AT1403
		SET SourceID = 'ERP9'
		WHERE ModuleID = @ModuleID
		AND ScreenID = @ScreenID
		AND EXISTS (SELECT TOP 1 1 FROM AT1101 WITH (NOLOCK) WHERE AT1101.DivisionID=AT1403.DivisionID)
	END
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO