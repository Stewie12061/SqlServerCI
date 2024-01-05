IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2016]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2016]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Lưu thông tin xác nhận tình trạng tiến độ nhận hàng đơn đặt hàng của khách hàng sỉ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tiểu Mai on 07/07/2018
-- <Example>
---- exec POP2022 'AT', 'ASOFTADMIN', 'FE3A7C3C-0FCC-4231-AD6D-004805B2F2EB', 1, N'Đồng ý tiến độ giao hàng', '2018-06-27 00:00:00.000'
CREATE PROCEDURE SOP2016
( 
		@DivisionID VARCHAR(50),
		@UserID VARCHAR(50),
		@APK VARCHAR(50),
		@IsObjectConfirm TINYINT,
		@NoteConfirm	NVARCHAR(250),
		@DateConfirm	DATETIME
) 
AS 

	UPDATE OT2001 
	SET IsObjectConfirm = @IsObjectConfirm,
		NoteConfirm = @NoteConfirm,
		DateConfirm = @DateConfirm,
		LastmodifyUserID = @UserID,
		LastmodifyDate = GETDATE()
	WHERE DivisionID = @DivisionID AND APK = @APK

	IF @IsObjectConfirm = 1 -- Chấp nhận
	BEGIN
		UPDATE OT2001
		SET OrderStatus = 1
		WHERE DivisionID = @DivisionID AND APK = @APK
	END
	ELSE IF @IsObjectConfirm = 2 -- Từ chối
	BEGIN
		UPDATE OT2001
		SET OrderStatus = 9
		WHERE DivisionID = @DivisionID AND APK = @APK
	END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
