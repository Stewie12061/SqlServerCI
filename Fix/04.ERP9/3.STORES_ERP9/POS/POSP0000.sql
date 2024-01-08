IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP0000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP0000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Tạo mã tăng tự động
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Thị Phượng on 13/11/2017
---- Modified on 
-- <Example>
/*
  POSP0000 'MSA',11,2017,'POST0038','MS'
*/

CREATE PROCEDURE dbo.POSP0000
(
	@DivisionID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
    @TableName VARCHAR(50),
    @ShopID VARCHAR(50)  
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
        @Seperator3 NVARCHAR(1),
        @VoucherTypeID VARCHAR(50),
        @StringKey1 NVARCHAR(50),
		@StringKey2 NVARCHAR(50),
		@StringKey3 NVARCHAR(50),
        @OutputLen INT = 10,
		@OutputOrder INT = 3,	--- 0 NSSS; 1 SNSS, 2 SSNS, 3 SSSN
		@Seperated INT = 0,
		@Seperator NVARCHAR(1) = '-',
		@NewKey NVARCHAR(500),
		@LastKeyAPK VARCHAR(50)
        
SET @VoucherTypeID=(SELECT TOP 1 VoucherType13 FROM POST0004 WHERE DivisionID=@DivisionID AND ShopID=@ShopID)

-- gán giá trị @StringKey1,@StringKey2,@StringKey3
SELECT @StringKey1 = S1, @StringKey2 = S2, @StringKey3 = S3 FROM dbo.S123 (@DivisionID, @VoucherTypeID, @TranMonth, @TranYear)
--- Gán giá trị
SELECT @OutputLen = OutputLength, @OutputOrder = OutputOrder, @Seperated = Separated, @Seperator = ISNULL(separator,'/')
FROM AT1007 WHERE DivisionID = @DivisionID AND VoucherTypeID = @VoucherTypeID
--
SET @KeyString = @StringKey1 + @StringKey2 + @StringKey3

IF NOT EXISTS (SELECT TOP 1 1 FROM AT4444 WHERE DivisionID = @DivisionID AND TableName = @TableName AND KeyString = @KeyString)
INSERT INTO AT4444 (DivisionID, TableName, KeyString, LastKey) SELECT @DivisionID, @TableName, @KeyString, 0

-- Gán giá trị
SELECT TOP 1  @LastKey=LastKey+1,@LastKeyAPK=APK FROM AT4444 WHERE DivisionID = @DivisionID AND TableName = @TableName AND KeyString = @KeyString

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

SELECT @StringNumber = REPLICATE('0', @OutputLen - @LastKeyLen - @SeperatorCount - LEN(@KeyString)) + @LastKeyChar

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

SELECT @LastKeyAPK LastKeyAPK,@LastKey -1 LastKey,@NewKey VoucherNo

SET NOCOUNT OFF

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
