IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0044]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0044]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- AP0044
-- <Summary>
---- Stored xử lý xóa những bút toán phân bổ nhiều cấp (PACIFIC)
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
---- EXEC AP0044 @DivisionID = 'ANG', @UserID = 'ASOFTADMIN', @VoucherID = 'ABC'

CREATE PROCEDURE [DBO].[AP0044]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@VoucherID AS NVARCHAR(50)
) 
AS

-- Cập nhật trạng thái phân bổ
DECLARE @OriginalInheritVoucherID AS NVARCHAR(50),
		@InheritVoucherID AS NVARCHAR(50),
		@AllocationLevelID AS TINYINT
			
SELECT @OriginalInheritVoucherID = OriginalInheritVoucherID, @InheritVoucherID = InheritVoucherID, @AllocationLevelID = AllocationLevelID
FROM AT9005 WITH (NOLOCK)	
WHERE DivisionID = @DivisionID
AND VoucherID = @VoucherID	
	
IF @AllocationLevelID = 1
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM AT9005 WITH (NOLOCK)	WHERE DivisionID = @DivisionID AND OriginalInheritVoucherID = @OriginalInheritVoucherID AND VoucherID <> @VoucherID)
	BEGIN
		UPDATE AT9000
		SET IsAudit = 0
		WHERE VoucherID = @OriginalInheritVoucherID		
	END 	
END
ELSE
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM AT9005 WITH (NOLOCK)	WHERE DivisionID = @DivisionID AND InheritVoucherID = @InheritVoucherID AND VoucherID <> @VoucherID)
	BEGIN
		UPDATE AT9005
		SET IsAudit = 0
		WHERE VoucherID = @InheritVoucherID		
	END 	 
END	

-- Xóa Master
DELETE AT9005
WHERE DivisionID = @DivisionID
AND VoucherID = @VoucherID

-- Xóa Detail
DELETE AT9001
WHERE DivisionID = @DivisionID
AND VoucherID = @VoucherID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
