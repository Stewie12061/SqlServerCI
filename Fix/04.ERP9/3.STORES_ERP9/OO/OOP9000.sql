IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP9000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP9000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
-- Kiểm tra @ID (Dùng cho danh mục) hoặc @APK (Dùng cho nghiệp vụ) đã sử dụng trước khi xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- <Created by>: Thị Phượng, Date: 20/11/2015
-- <Modify by>: Khâu Vĩnh Tâm, Date: 18/02/2018 - Thay đổi xử lý kiểm tra dữ liệu của các màn hình:
--				+ Danh mục Mẫu công việc: Thêm kiểm tra check tồn tại dữ liệu tại table OOT1030
--				+ Danh mục Bước quy trình: Bỏ xử lý check tồn tại dữ liệu
--				+ Danh mục Quy trình làm việc: Bỏ xử lý check tồn tại dữ liệu
--				+ Danh mục Mẫu dự án/Nhóm công việc: Bỏ xử lý check tồn tại dữ liệu
-- <Modify by>: Lê Hoàng, Date: 15/10/2020 - Kiểm tra sửa xóa Danh mục thiết bị
-- <Modify by>: Tấn Lộc, Date: 28/01/2021 - Kiểm tra thư mục còn tồn tại file hay không, còn thì không cho xóa
-- <Example>
/*
	DECLARE @Status TINYINT
	EXEC OOP9000 'HT','', 'OOT1020', '65043073-43f1-4233-a2f7-b742d4370eaa' ,'65043073-43f1-4233-a2f7-b742d4370eaa', 6, 2016, @Status OUTPUT
	SELECT @Status
*/
CREATE PROCEDURE [dbo].[OOP9000] 	
			(
				@DivisionID VARCHAR(50),
				@FormID NVARCHAR(50),
				@TableID NVARCHAR(50) = NULL,
				@APK UNIQUEIDENTIFIER = NULL, 
				@ID VARCHAR(MAX) = NULL, 
				@TranMonth INT = NULL, 
				@TranYear INT = NULL, 
				@Status TINYINT OUTPUT
			)
AS

	DECLARE @Message AS NVARCHAR(250)

	-- Danh mục thiết lập thời gian làm việc
	IF @TableID = 'OOT0030'
	BEGIN
		DECLARE @FromDate DATETIME,
				@ToDate DATETIME

		SELECT TOP 1 @FromDate = FromDate, @ToDate = ToDate FROM OOT0030 WHERE YearID = @ID

		IF EXISTS(SELECT TOP 1 1 FROM OOT2100 WITH (NOLOCK) 
					WHERE (StartDate BETWEEN @FromDate AND @ToDate)
					OR (EndDate BETWEEN @FromDate AND @ToDate))
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END
		
		IF EXISTS(SELECT TOP 1 1 FROM OOT2110 WITH (NOLOCK) 
					WHERE (PlanStartDate BETWEEN @FromDate AND @ToDate)
					OR (PlanEndDate BETWEEN @FromDate AND @ToDate))
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END
	END

	-- Danh mục Mẫu công việc
	IF @TableID = 'OOT1060'
	BEGIN
		IF EXISTS(SELECT TOP 1 1 FROM OOT1031 WITH (NOLOCK) WHERE TaskSampleID = @ID)
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END
	END

	-- Danh mục Quy trình làm việc
	IF @TableID = 'OOT1020'
	BEGIN
		-- 18/02/219 - [Vĩnh Tâm] - Begin delete
		--IF EXISTS(SELECT TOP 1 1 FROM OOT2110 WITH (NOLOCK) WHERE ProcessID = @ID)
		--BEGIN
		--	SET @Status = 1
		--	SET @Message = N'00ML000052'
		--	GOTO Mess
		--END

		--IF EXISTS(SELECT TOP 1 1 FROM OOT1051 WITH (NOLOCK) WHERE ProcessID = @ID)
		--BEGIN
		--	SET @Status = 1
		--	SET @Message = N'00ML000052'
		--	GOTO Mess
		--END

		-- Bỏ xử lý kiểm tra tồn tại cho Quy trình làm việc vì không còn ràng buộc dữ liệu với Mẫu dự án và Dự án
		GOTO Mess
		-- 18/02/219 - [Vĩnh Tâm] - End delete
	END

	IF @TableID = 'OOT1030' -- Danh mục bước quy trình
	BEGIN
		-- 18/02/219 - [Vĩnh Tâm] - Begin delete
		--IF EXISTS(SELECT TOP 1 1 FROM OOT1051 WITH (NOLOCK) WHERE StepID = @ID)
		--BEGIN
		--	SET @Status = 1
		--	SET @Message = N'00ML000052'
		--	GOTO Mess
		--END

		--IF EXISTS(SELECT TOP 1 1 FROM OOT2110 WITH (NOLOCK) WHERE StepID = @ID)
		--BEGIN
		--	SET @Status = 1
		--	SET @Message = N'00ML000052'
		--	GOTO Mess
		--END

		-- Bỏ xử lý kiểm tra tồn tại cho Bước quy trình vì không còn ràng buộc dữ liệu với Mẫu dự án và Dự án
		GOTO Mess
		-- 18/02/219 - [Vĩnh Tâm] - End delete
	END

	IF @TableID = 'OOT1040' -- Danh mục Trạng thái
	BEGIN
		IF EXISTS(SELECT TOP 1 1 FROM OOT1040 WITH (NOLOCK) WHERE StatusID = @ID AND ISNULL(SystemStatus, 0) != 0)
		BEGIN
			SET @Status = 2
			-- {0} là Trạng thái của hệ thống, bạn không thể Sửa/Xóa!
			SET @Message = N'OOFML000208'
			GOTO Mess
		END
		ELSE IF EXISTS(SELECT TOP 1 1 FROM OOT2100 WITH (NOLOCK) WHERE StatusID = @ID)
				OR EXISTS(SELECT TOP 1 1 FROM OOT2110 WITH (NOLOCK) WHERE StatusID = @ID)
				OR EXISTS(SELECT TOP 1 1 FROM OOT2160 WITH (NOLOCK) WHERE StatusID = @ID)
				OR EXISTS(SELECT TOP 1 1 FROM OOT2170 WITH (NOLOCK) WHERE StatusID = @ID)
				OR EXISTS(SELECT TOP 1 1 FROM OOT2190 WITH (NOLOCK) WHERE StatusID = @ID)
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END

		GOTO Mess
	END

	-- Danh mục Mẫu dự án/Nhóm công việc
	IF @TableID = 'OOT1050'
	BEGIN
		-- 18/02/219 - [Vĩnh Tâm] - Begin delete
		--IF EXISTS(SELECT TOP 1 1 FROM OOT2100 WITH (NOLOCK) WHERE TaskSampleID = @ID)
		--BEGIN
		--	SET @Status = 1
		--	SET @Message = N'00ML000052'
		--	GOTO Mess
		--END

		-- Bỏ xử lý kiểm tra tồn tại cho Mẫu dự án vì không còn ràng buộc dữ liệu với Dự án
		GOTO Mess
		-- 18/02/219 - [Vĩnh Tâm] - End delete
	END

	-- Danh sách dự án/nhóm công việc
	IF @TableID = 'OOT2100'
	BEGIN
		IF EXISTS(SELECT TOP 1 1 FROM OOT2110 WITH (NOLOCK) WHERE ProjectID = @ID AND ISNULL(StatusID, 'TTCV0001') != 'TTCV0001')
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END
	END

	-- Danh sách đặt phòng họp đã sử dụng thiết bị thì không cho xóa thông tin thiết bị
	IF @TableID = 'OOT1090'
	BEGIN
		IF EXISTS(SELECT TOP 1 1 FROM OOT2240 WITH (NOLOCK) WHERE EquipmentNameID = @ID)
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END
	END

	--Danh sách Quản lý thiết bị: thời gian sử dụng nhỏ hơn ngày hiện tại thì không cho xóa
	IF @TableID = 'OOT2240'
	BEGIN
		IF EXISTS(SELECT TOP 1 1 FROM OOT2240 WITH (NOLOCK) WHERE APK = @APK AND GETDATE() > PlanStartDate)
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000052'
			GOTO Mess
		END
	END

	--Danh sách thư mục nếu thư mục còn tồn tại file thì không cho xóa
	IF @TableID = 'OOT2250'
	BEGIN
		IF EXISTS(SELECT TOP 1 1 FROM OOT2260 WITH (NOLOCK) WHERE APKMaster_OOT2250 = @APK AND ISNULL(DeleteFlg, 0) = 0)
		BEGIN
			SET @Status = 1
			SET @Message = N'00ML000305'
			GOTO Mess
		END
	END
Mess:




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
