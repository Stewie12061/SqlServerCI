IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1054]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1054]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
----Insert loại hình thu vào danh mục mặt hàng 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT - EDM \ Danh mục \ Danh mục loại hình thu \ Cập nhật khoản thu
-- <History>
----Created by: Hồng Thảo, Date: 16/4/2019
-- <Example>
---- 
/*-- <Example>
	EDMP1054 @DivisionID = 'BE', @UserID = 'ASOFTADMIN', @Mode = '1',@ReceiptTypeID = '9999999999999',@ReceiptTypeName = '',@Disabled = '0',@IsCommon = '0'

	EDMP1054 @DivisionID, @UserID, @Mode,@ReceiptTypeID,@ReceiptTypeName,@Disabled,@IsCommon
----*/

CREATE PROCEDURE EDMP1054
( 
	 @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50), 
	 @Mode VARCHAR(50),
	 @ReceiptTypeID VARCHAR(50),
	 @ReceiptTypeName NVARCHAR(50),
	 @Disabled TINYINT,
	 @IsCommon TINYINT
)
AS 

DECLARE @sSQL NVARCHAR (MAX) = N''

IF @Mode = 1  
BEGIN

----Thêm mới vào danh mục mặt hàng 
IF NOT EXISTS (SELECT TOP 1 1 FROM AT1302 WITH (NOLOCK) WHERE InventoryID = @ReceiptTypeID  AND DivisionID IN (@DivisionID,'@@@'))
BEGIN
	INSERT INTO AT1302 (DivisionID,InventoryID,InventoryName,UnitID,ProductTypeID,InventoryNameNoUnicode,IsStocked,SalesAccountID,PurchaseAccountID,PrimeCostAccountID,IsCommon,Disabled,CreateDate,CreateUserID,LastModifyDate,LastModifyUserID)
	VALUES (CASE WHEN @IsCommon = 1 THEN '@@@' ELSE @DivisionID END,@ReceiptTypeID,@ReceiptTypeName,'LA',1,dbo.RemoveUnicode(@ReceiptTypeName),0,NULL,NULL,NULL,@IsCommon,0,GETDATE(),@UserID, GETDATE(),@UserID)
END

END
ELSE
IF @Mode = 2 
BEGIN

----Update vào mã phân tích mặt hàng 
	UPDATE AT1302  
	SET 
	DivisionID = CASE WHEN @IsCommon = 1 THEN '@@@' ELSE @DivisionID END
	,InventoryName = @ReceiptTypeName
	,Disabled = @Disabled
	,LastModifyDate = GETDATE()
	,LastModifyUserID = @UserID
	WHERE DivisionID IN (@DivisionID,'@@@') AND InventoryID = @ReceiptTypeID
	

END
ELSE
IF @Mode = 3 
BEGIN
SET @sSQL =  N'
---Delete mã phân tích mặt hàng 
	DELETE FROM AT1302 
	WHERE DivisionID IN ('''+@DivisionID+''',''@@@'') AND InventoryID IN ('''+@ReceiptTypeID+''')
'
END

--PRINT(@sSQL)
EXEC (@sSQL)

   
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
