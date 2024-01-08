IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0045]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0045]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- AP0045
-- <Summary>
---- Stored update trạng thái phân bổ (PACIFIC)
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
---- EXEC AP0045 @DivisionID = 'ANG', @UserID = 'ASOFTADMIN', @OriginalInheritVoucherID_Old = 'ABC', @OriginalInheritVoucherID_New = 'ABC'

CREATE PROCEDURE [DBO].[AP0045]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@OriginalInheritVoucherID_Old AS NVARCHAR(50),
	@InheritVoucherID_Old AS NVARCHAR(50),
	@AllocationLevelID_Old AS TINYINT,
	@OriginalInheritVoucherID_New AS NVARCHAR(50),
	@InheritVoucherID_New AS NVARCHAR(50),	
	@AllocationLevelID_New AS TINYINT,
	@Mode AS TINYINT -- 0: Thêm mới, -- 1: Sửa
) 
AS
			
-- Hủy trạng thái đã phân bổ của phiếu cũ
IF @AllocationLevelID_Old = 1
BEGIN
	UPDATE AT9000
	SET IsAudit = 0
	WHERE 
	DivisionID = @DivisionID
	AND VoucherID = @OriginalInheritVoucherID_Old
END
ELSE
BEGIN
	UPDATE AT9005
	SET IsAudit = 0
	WHERE 
	DivisionID = @DivisionID
	AND VoucherID = @InheritVoucherID_Old
END	

-- Cập nhật trạng thái đã phân bổ của những phiếu mới
IF @AllocationLevelID_New = 1
BEGIN
	UPDATE AT9000
	SET IsAudit = 1
	WHERE 
	DivisionID = @DivisionID
	AND VoucherID = @OriginalInheritVoucherID_New
END
ELSE
BEGIN
	UPDATE AT9005
	SET IsAudit = 1
	WHERE 
	DivisionID = @DivisionID
	AND VoucherID = @InheritVoucherID_New
END	


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
