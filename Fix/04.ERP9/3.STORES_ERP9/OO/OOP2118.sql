IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2118]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2118]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Kiểm tra Công việc có liên quan đến Phiếu nghiệp vụ khác, trước khi thực hiện chuyển trạng thái.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
-- Created on 04/08/2021 by Văn Tài
/** <Example> EXEC OOP2118 
					@DivisionID = 'DTI', 
					@UserID = 'ASOFTADMIN',
					@TaskID = 'CV/03/2020/0020',
					@FormID = 'CRMF2050',
					@VoucherNo = 'QO/08/2021/0010',
					@VocuherID = '4610f8e2-832e-4b4a-9923-3ca7e258bce7',
					@ChangeStatusID = 'TTCV0001'

**/

CREATE PROCEDURE [dbo].[OOP2118]
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TaskID VARCHAR(50),
	@FormID VARCHAR(50),
	@VoucherNo VARCHAR(50),
	@VoucherID VARCHAR(50),
	@ChangeStatusID VARCHAR(50)
)
AS
BEGIN 
	DECLARE @CustomerIdex INT = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex WITH (NOLOCK))

	DECLARE @Status INT = 0
	DECLARE @MessageID VARCHAR(50) = ''

	-- Trạng thái hoàn thành của Task.
	DECLARE @COMPLETE_STATUS VARCHAR(25) = 'TTCV0003'

	DECLARE @ExistInAnother TINYINT = 0

	DECLARE @CurrentTaskID VARCHAR(50) = ''
	DECLARE @CurrentTaskStatus VARCHAR(25) = ''

	
			

	IF(ISNULL(@ChangeStatusID, '') = '' 
		OR ISNULL(@FormID, '') = ''
		OR ISNULL(@TaskID, '') = ''
		OR ISNULL(@VoucherNo, '') = ''
		OR ISNULL(@VoucherID, '') = ''
	)
	BEGIN
		SET @Status = 1
		GOTO RETURN_MESSAGE;
	END

	-- Lấy trạng thái hiện tại của Task.
	-- Nếu không phải trạng thái: HOÀN THÀNH thì không thực hiện đổi trạng thái khác.
	SET @CurrentTaskStatus = (SELECT TOP 1 StatusID FROM OOT2110 WHERE DivisionID = @DivisionID AND TaskID = @TaskID)
	IF (@CurrentTaskStatus <> @COMPLETE_STATUS)
	BEGIN
		print ('@CurrentTaskStatus: ' + @CurrentTaskStatus)
		SET @Status = 1
		GOTO RETURN_MESSAGE;
	END

	
	-- Cơ hội
	IF(@FormID = 'CRMF2051')
	BEGIN
		SET @CurrentTaskID = (SELECT TOP 1 TaskID 
								FROM CRMT20501 WITH (NOLOCK)
								WHERE DivisionID = @DivisionID
										AND OpportunityID = @VoucherNo)

		-- Nếu task cũ vẫn giống với task mới thì không thực hiện đổi trạng thái.
		IF (@TaskID = @CurrentTaskID)
		BEGIN
			SET @Status = 1
			GOTO RETURN_MESSAGE;
		END

		-- Kiểm tra mã công việc không được sử dụng ở dữ liệu khác.
		-- Cơ hội.
		IF (EXISTS(SELECT TOP 1 1 FROM CRMT20501 WITH (NOLOCK) WHERE DivisionID  = @DivisionID AND TaskID = @TaskID AND OpportunityID <> @VoucherNo))
			SET @ExistInAnother = 1;
		
		-- Báo  giá
		IF (EXISTS(SELECT TOP 1 1 FROM OT2101 WITH (NOLOCK) WHERE DivisionID  = @DivisionID AND TaskID = @TaskID))
			SET @ExistInAnother = 1;

		-- Đơn hàng bán.
		IF (EXISTS(SELECT TOP 1 1 FROM OT2001 WITH (NOLOCK) WHERE DivisionID  = @DivisionID AND TaskID = @TaskID))
			SET @ExistInAnother = 1;

		-- Yêu cầu mua hàng
		IF (EXISTS(SELECT TOP 1 1 FROM OT3101 WITH (NOLOCK) WHERE DivisionID  = @DivisionID AND TaskID = @TaskID))
			SET @ExistInAnother = 1;

			
		print ('TEST')
		
		-- Không được sử dụng.
		IF (@ExistInAnother = 0)
		BEGIN
			UPDATE OOT2110
			SET StatusID = @ChangeStatusID
			WHERE DivisionID = @DivisionID
					AND TaskID = @TaskID

			SET @Status = 0;
			GOTO RETURN_MESSAGE;
		END
	END

	-- 3 màn hình báo giá.
	IF(@FormID = 'SOF2061')
	BEGIN
		SET @CurrentTaskID = (SELECT TOP 1 TaskID 
								FROM OT2101 WITH (NOLOCK)
								WHERE DivisionID = @DivisionID
										AND QuotationNo = @VoucherNo)

		-- Nếu task cũ vẫn giống với task mới thì không thực hiện đổi trạng thái.
		IF (@TaskID = @CurrentTaskID)
		BEGIN
			SET @Status = 1
			GOTO RETURN_MESSAGE;
		END

		-- Kiểm tra mã công việc không được sử dụng ở dữ liệu khác.
		-- Cơ hội.
		IF (EXISTS(SELECT TOP 1 1 FROM CRMT20501 WITH (NOLOCK) WHERE DivisionID  = @DivisionID AND TaskID = @TaskID))
			SET @ExistInAnother = 1;
		
		-- Báo  giá
		IF (EXISTS(SELECT TOP 1 1 FROM OT2101 WITH (NOLOCK) WHERE DivisionID  = @DivisionID AND TaskID = @TaskID AND QuotationNo <> @VoucherNo))
			SET @ExistInAnother = 1;

		-- Đơn hàng bán.
		IF (EXISTS(SELECT TOP 1 1 FROM OT2001 WITH (NOLOCK) WHERE DivisionID  = @DivisionID AND TaskID = @TaskID))
			SET @ExistInAnother = 1;

		-- Yêu cầu mua hàng
		IF (EXISTS(SELECT TOP 1 1 FROM OT3101 WITH (NOLOCK) WHERE DivisionID  = @DivisionID AND TaskID = @TaskID))
			SET @ExistInAnother = 1;
		
		-- Không được sử dụng.
		IF (@ExistInAnother = 0)
		BEGIN
			UPDATE OOT2110
			SET StatusID = @ChangeStatusID
			WHERE DivisionID = @DivisionID
					AND TaskID = @TaskID

			SET @Status = 0;
			GOTO RETURN_MESSAGE;
		END
	END

	-- Đơn hàng bán.
	IF(@FormID = 'SOF2001')
	BEGIN
		SET @CurrentTaskID = (SELECT TOP 1 TaskID 
								FROM OT2001 WITH (NOLOCK)
								WHERE DivisionID = @DivisionID
										AND VoucherNo = @VoucherNo)

		-- Nếu task cũ vẫn giống với task mới thì không thực hiện đổi trạng thái.
		IF (@TaskID = @CurrentTaskID)
		BEGIN
			SET @Status = 1
			GOTO RETURN_MESSAGE;
		END

		-- Kiểm tra mã công việc không được sử dụng ở dữ liệu khác.
		-- Cơ hội.
		IF (EXISTS(SELECT TOP 1 1 FROM CRMT20501 WITH (NOLOCK) WHERE DivisionID  = @DivisionID AND TaskID = @TaskID))
			SET @ExistInAnother = 1;
		
		-- Báo  giá
		IF (EXISTS(SELECT TOP 1 1 FROM OT2101 WITH (NOLOCK) WHERE DivisionID  = @DivisionID AND TaskID = @TaskID))
			SET @ExistInAnother = 1;

		-- Đơn hàng bán.
		IF (EXISTS(SELECT TOP 1 1 FROM OT2001 WITH (NOLOCK) WHERE DivisionID  = @DivisionID AND TaskID = @TaskID AND VoucherNo <> @VoucherNo))
			SET @ExistInAnother = 1;

		-- Yêu cầu mua hàng
		IF (EXISTS(SELECT TOP 1 1 FROM OT3101 WITH (NOLOCK) WHERE DivisionID  = @DivisionID AND TaskID = @TaskID))
			SET @ExistInAnother = 1;
		
		-- Không được sử dụng.
		IF (@ExistInAnother = 0)
		BEGIN
			UPDATE OOT2110
			SET StatusID = @ChangeStatusID
			WHERE DivisionID = @DivisionID
					AND TaskID = @TaskID

			SET @Status = 0;
			GOTO RETURN_MESSAGE;
		END
	END

	-- Yêu cầu mua hàng.
	IF(@FormID = 'POF2031')
	BEGIN
		SET @CurrentTaskID = (SELECT TOP 1 TaskID 
								FROM OT3101 WITH (NOLOCK)
								WHERE DivisionID = @DivisionID
										AND VoucherNo = @VoucherNo)

		-- Nếu task cũ vẫn giống với task mới thì không thực hiện đổi trạng thái.
		IF (@TaskID = @CurrentTaskID)
		BEGIN
			SET @Status = 1
			GOTO RETURN_MESSAGE;
		END

		-- Kiểm tra mã công việc không được sử dụng ở dữ liệu khác.
		-- Cơ hội.
		IF (EXISTS(SELECT TOP 1 1 FROM CRMT20501 WITH (NOLOCK) WHERE DivisionID  = @DivisionID AND TaskID = @TaskID))
			SET @ExistInAnother = 1;
		
		-- Báo  giá
		IF (EXISTS(SELECT TOP 1 1 FROM OT2101 WITH (NOLOCK) WHERE DivisionID  = @DivisionID AND TaskID = @TaskID))
			SET @ExistInAnother = 1;

		-- Đơn hàng bán.
		IF (EXISTS(SELECT TOP 1 1 FROM OT2001 WITH (NOLOCK) WHERE DivisionID  = @DivisionID AND TaskID = @TaskID ))
			SET @ExistInAnother = 1;

		-- Yêu cầu mua hàng
		IF (EXISTS(SELECT TOP 1 1 FROM OT3101 WITH (NOLOCK) WHERE DivisionID  = @DivisionID AND TaskID = @TaskID AND VoucherNo <> @VoucherNo))
			SET @ExistInAnother = 1;
		

		-- Không được sử dụng.
		IF (@ExistInAnother = 0)
		BEGIN
			UPDATE OOT2110
			SET StatusID = @ChangeStatusID
			WHERE DivisionID = @DivisionID
					AND TaskID = @TaskID

			SET @Status = 0;
			GOTO RETURN_MESSAGE;
		END
	END
	
	RETURN_MESSAGE:
	SELECT @Status AS Status, @MessageID AS MessageID

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
