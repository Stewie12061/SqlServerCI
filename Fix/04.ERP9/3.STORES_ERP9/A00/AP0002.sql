IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Param>
---- Automatic create New ID keys nhưng không select ra
---- Giống store AP0000
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 20/08/2003 by Nguyen Van Nhan
---- Modified on 28/07/2010 by Tố Oanh
---- Modified on 13/09/2011 by Nguyễn Bình Minh: Bổ sung DivisionID để tránh IGE bị trùng
-- <Example>
---- 

CREATE PROCEDURE AP0002
(
    @DivisionID NVARCHAR(50),
    @NewKey NVARCHAR(200) OUTPUT,
    @TableName NVARCHAR(50),
    @StringKey1 NVARCHAR(50) = '',
    @StringKey2 NVARCHAR(50) = '',
    @StringKey3 NVARCHAR(50) = '',
    @OutputLen INT = 10,
    @OutputOrder INT = 3,	--- 0 NSSS; 1 SNSS, 2 SSNS, 3 SSSN
    @Seperated INT = 0,
    @Seperator NVARCHAR(1) = '-'
)
AS
DECLARE @KeyString NVARCHAR(50),
        @LastKey INT,
        @LastKeyChar NVARCHAR(50),
        @LastKeyLen INT,
        @SeperatorCount INT,
        @KeyStringLen INT,
        @StringNumber NVARCHAR(50),
        @Seperator1 NVARCHAR(1),
        @Seperator2 NVARCHAR(1),
        @Seperator3 NVARCHAR(1)
        
SET NOCOUNT ON
IF( (Select count(1) from AT1101) > 1)
	SET @StringKey1 = @StringKey1 + @DivisionID

SET @KeyStringLen = @KeyStringLen + LEN(@DivisionID)
 
SELECT @KeyString = ISNULL(@StringKey1,'') + ISNULL(@StringKey2,'') + ISNULL(@StringKey3,'')
INSERT INTO AT4444 (DivisionID, TableName, KeyString, LastKey)
SELECT @DivisionID, @TableName, @KeyString, 0
WHERE NOT EXISTS(SELECT TOP 1 1 FROM AT4444 WHERE DivisionID = @DivisionID AND TableName = @TableName AND KeyString = @KeyString)

UPDATE	AT4444
SET		@LastKey = LastKey + 1,
		LastKey = LastKey + 1
WHERE	DivisionID = @DivisionID  AND TableName = @TableName AND KeyString = @KeyString

SELECT @LastKeyChar = LTRIM(STR(@LastKey))
SELECT @LastKeyLen = LEN(@LastKeyChar)

IF @Seperated = 0
BEGIN
    SELECT @SeperatorCount = 0
    SELECT @Seperator = SPACE(0)
END
ELSE
BEGIN
    SELECT @SeperatorCount = 0
    
    IF LEN(@StringKey1) > 0
    BEGIN
        SELECT @SeperatorCount = 1
        SELECT @Seperator1 = @Seperator
    END
    ELSE
    BEGIN
        SELECT @Seperator1 = SPACE(0)
    END
    
    IF LEN(@StringKey2) > 0
    BEGIN
        SELECT @SeperatorCount = @SeperatorCount + 1
        SELECT @Seperator2 = @Seperator
    END
    ELSE
    BEGIN
        SELECT @Seperator2 = SPACE(0)
    END
    
    
    IF LEN(@StringKey3) > 0
    BEGIN
        SELECT @SeperatorCount = @SeperatorCount + 1
        SELECT @Seperator3 = @Seperator
    END
    ELSE
    BEGIN
        SELECT @Seperator3 = SPACE(0)
    END
END

SELECT @StringNumber = REPLICATE('0', @OutputLen - @LastKeyLen - @SeperatorCount - LEN(@KeyString)) + @LastKeyChar

SELECT @StringKey1 = LTRIM(UPPER(@StringKey1))
SELECT @StringKey2 = LTRIM(UPPER(@StringKey2))
SELECT @StringKey3 = LTRIM(UPPER(@StringKey3))

SET @NewKey = (
        CASE @OutputOrder
             WHEN 3 THEN ISNULL(@StringKey1, '') + ISNULL(@Seperator1, '') + 
                  ISNULL(@StringKey2, '') + ISNULL(@Seperator2, '') + ISNULL(@StringKey3, '') 
                  + ISNULL(@Seperator3, '') + ISNULL(@StringNumber, '')
             WHEN 1 THEN ISNULL(@StringKey1, '') + ISNULL(@Seperator1, '') + 
                  ISNULL(@StringNumber, '') + ISNULL(@Seperator2, '') + ISNULL(@StringKey2, '') 
                  + ISNULL(@Seperator3, '') + ISNULL(@StringKey3, '')
             WHEN 2 THEN ISNULL(@StringKey1, '') + ISNULL(@Seperator1, '') + 
                  ISNULL(@StringKey2, '') + ISNULL(@Seperator2, '') + ISNULL(@StringNumber, '') 
                  + ISNULL(@Seperator3, '') + ISNULL(@StringKey3, '')
             WHEN 0 THEN ISNULL(@StringNumber, '') + ISNULL(@Seperator1, '') + 
                  ISNULL(@StringKey1, '') + ISNULL(@Seperator2, '') + ISNULL(@StringKey2, '') 
                  + ISNULL(@Seperator3, '') + ISNULL(@StringKey3, '')
        END
    )

SET NOCOUNT OFF

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
