IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0043]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0043]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- AP0043
-- <Summary>
---- Stored kiểm tra trong trường hợp người dùng nhấn vào menu sửa, xóa ở màn hình bút toán phân bổ chi phí theo nhiều cấp (PACIFIC)
---- Created on 13/04/2017 Hải Long
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified on 11/08/2014 by 
-- <Example>
---- EXEC AP0043 @DivisionID = 'ANG', @UserID = 'ASOFTADMIN', @VoucherID = 'ABC'

CREATE PROCEDURE [DBO].[AP0043]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@VoucherID AS NVARCHAR(50)
) 
AS
Declare @Status AS TINYINT,
		@EngMessage AS NVARCHAR(250),
		@VieMessage AS NVARCHAR(250)

SET @Status = 0
SET @EngMessage = ''
SET @VieMessage = ''

-- Kiểm tra nếu đã được sử dụng để phân bổ bởi phiếu khác
IF EXISTS (SELECT TOP 1 1 FROM AT9005 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID AND IsAudit = 1)
BEGIN
	SET @Status = 1
	SET @VieMessage =N'AFML000423'
	SET @EngMessage =N'AFML000423'
	Goto EndMess
END

--================================================
	EndMess:
	Select @Status as Status, @EngMessage as EngMessage, @VieMessage as VieMessage

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
