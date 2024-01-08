IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0000_SB01]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0000_SB01]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/* 
<Param>
	Tự động tạo số chứng từ cho hóa đơn bán hàng được sinh tự động cho khách hàng Song Bình.
<Return>
	
<Reference> 
<History>
	Create on 19/05/2020 by Huỳnh Thử
<Example>
	AP0000_SB01 'LG', '', 'AT9000','XX', '2015', '10', 14,3,1,'/'
*/ 
CREATE PROCEDURE AP0000_SB01
(
    @DivisionID NVARCHAR(50),
    @NewKey NVARCHAR(50) OUTPUT,
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
        @LastKeyChar NVARCHAR(50) = '',
        @LastKeyLen INT,
        @SeperatorCount INT,
        @KeyStringLen INT,
        @StringNumber NVARCHAR(50),
        @Seperator1 NVARCHAR(1),
        @Seperator2 NVARCHAR(1),
        @Seperator3 NVARCHAR(1)
        
SET NOCOUNT ON
/*
THEM DIVISION VÀO VOUCHERNO
SET @StringKey1 = @StringKey1 + @DivisionID
SET @KeyStringLen = @KeyStringLen + LEN(@DivisionID)
 */
 
SET @StringKey1 = @StringKey1
SET @KeyStringLen = @KeyStringLen
SET @KeyString = @StringKey1 + @StringKey2 + @StringKey3

IF NOT EXISTS (SELECT TOP 1 1 
				FROM AT4444_SB01 WITH (NOLOCK) 
				WHERE DivisionID = @DivisionID 
					AND TableName = @TableName 
					AND KeyString = @KeyString
				)
INSERT INTO AT4444_SB01 (DivisionID, TableName, KeyString, LastKey) 
SELECT @DivisionID, @TableName, @KeyString, 0
	
UPDATE AT4444_SB01 SET @LastKey = LastKey + 1, LastKey = LastKey + 1
WHERE DivisionID = @DivisionID AND TableName = @TableName AND KeyString = @KeyString

SET @LastKeyChar = LTRIM(STR(@LastKey))
SET @LastKeyLen = LEN(@LastKeyChar)

IF @Seperated = 0
BEGIN
	SET @SeperatorCount = 0
	SET @Seperator = SPACE(0)
END
ELSE
BEGIN
	SET @SeperatorCount = 0    
	IF LEN(@StringKey1) > 0
	BEGIN
		SET @SeperatorCount = 1
		SET @Seperator1 = @Seperator
	END
	ELSE
	BEGIN
		SET @Seperator1 = SPACE(0)
	END
    
	IF LEN(@StringKey2) > 0
	BEGIN
		SET @SeperatorCount = @SeperatorCount + 1
		SET @Seperator2 = @Seperator
	END
	ELSE
	BEGIN
		SET @Seperator2 = SPACE(0)
	END
        
	IF LEN(@StringKey3) > 0
	BEGIN
		SET @SeperatorCount = @SeperatorCount + 1
		SET @Seperator3 = @Seperator
	END
	ELSE
	BEGIN
		SET @Seperator3 = SPACE(0)
	END
END

SELECT @StringNumber = REPLICATE('0', CASE WHEN @OutputLen - @LastKeyLen - @SeperatorCount - LEN(@KeyString) <= 0 THEN 0 ELSE @OutputLen - @LastKeyLen - @SeperatorCount - LEN(@KeyString) END) + @LastKeyChar

SET @StringKey1 = LTRIM(UPPER(@StringKey1))
SET @StringKey2 = LTRIM(UPPER(@StringKey2))
SET @StringKey3 = LTRIM(UPPER(@StringKey3))

SET @NewKey = 
(
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

SELECT @NewKey AS NewKey

SET NOCOUNT OFF

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
