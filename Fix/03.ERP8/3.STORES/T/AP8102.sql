IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP8102]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP8102]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Xử lý kiểm tra và cập nhật số tăng tự động sau khi import nghiệp vụ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 13/07/2020 by Phạm Lê Hoàng
---- Modified on ... by ...:
-- <Example>  
---- 
CREATE PROCEDURE [DBO].[AP8102]
(	
	@DivisionID AS NVARCHAR(50),
	@VoucherTypeID AS NVARCHAR(50),
	@VoucherNo AS NVARCHAR(50),
	@TableName AS NVARCHAR(50),
	@TranMonth AS INT,
	@TranYear AS INT
) 
AS
DECLARE @Auto AS TINYINT,
		@S1 AS NVARCHAR(50),
		@S2 AS NVARCHAR(50),
		@S3 AS NVARCHAR(50),
		@OutputOrder AS TINYINT,
		@OutputLength AS TINYINT,
		@Separated AS TINYINT,
		@Separator AS NVARCHAR(5),
		@S1Type AS TINYINT,
		@S2Type AS TINYINT,
		@S3Type AS TINYINT,
		@Enabled1 AS TINYINT,
		@Enabled2 AS TINYINT,
		@Enabled3 AS TINYINT
--Lấy Loại chứng từ trong Excel import
SELECT
@Auto = Auto,
@S1 = S1,
@S2 = S2,
@S3 = S3,
@OutputOrder = OutputOrder,--0:lmNSSS; 1:lmSNSS; 2:lmSSNS; 3:lmSSSN
@OutputLength = OutputLength,
@Separated = Separated,
@Separator = Separator,
@S1Type = S1Type,
@S2Type = S2Type,
@S3Type = S3Type,
@Enabled1 = Enabled1,
@Enabled2 = Enabled2,
@Enabled3 = Enabled3
FROM AT1007 WHERE VoucherTypeID = @VoucherTypeID AND DivisionID = @DivisionID

--Kiểm tra Loại chứng từ đó có thiết lập Tạo mã tăng tự động hay không AT1007.Auto
IF (@Auto = 1 OR ISNULL(@Auto,0) <> 0)
BEGIN
--Nếu có thiết lập Tạo mã tăng tự động thì thực hiện
DECLARE @Key1 AS NVARCHAR(50) = '',
		@Key2 AS NVARCHAR(50) = '',
		@Key3 AS NVARCHAR(50) = ''
DECLARE @SeparatorCount INT = 0

IF @Enabled1 = 1 --có dùng Phân Loại 1
BEGIN
	SET @Key1 = dbo.GetKeyID(@S1Type, @TranMonth, @TranYear, @VoucherTypeID, @DivisionID, @S1)
END
IF @Enabled2 = 1 --có dùng Phân Loại 2
BEGIN
	SET @Key2 = dbo.GetKeyID(@S2Type, @TranMonth, @TranYear, @VoucherTypeID, @DivisionID, @S2)
END
IF @Enabled3 = 1 --có dùng Phân Loại 3
BEGIN
	SET @Key3 = dbo.GetKeyID(@S3Type, @TranMonth, @TranYear, @VoucherTypeID, @DivisionID, @S3)
END
PRINT @Key1
PRINT @Key2
PRINT @Key3
PRINT @Separator
--Lấy thông tin thiết lập mã tăng tự động để kiểm tra số chứng từ của nghiệp vụ đang import khớp mẫu thì sẽ cho tăng tự động AT4444
DECLARE @NewKeyForm VARCHAR(50)
SET @NewKeyForm = (
        CASE @OutputOrder
             WHEN 3 THEN ISNULL(@Key1, '') + ISNULL(@Separator, '') + 
                         ISNULL(@Key2, '') + ISNULL(@Separator, '') + 
						 ISNULL(@Key3, '') + ISNULL(@Separator, '') + 
						 '%'
             WHEN 2 THEN ISNULL(@Key1, '') + ISNULL(@Separator, '') + 
                         ISNULL(@Key2, '') + ISNULL(@Separator, '') + 
						 '%' + ISNULL(@Separator, '') + 
						 ISNULL(@Key3, '')
			 WHEN 1 THEN ISNULL(@Key1, '') + ISNULL(@Separator, '') + 
						 '%' + ISNULL(@Separator, '') + 
						 ISNULL(@Key2, '') + ISNULL(@Separator, '') + 
						 ISNULL(@Key3, '')
             WHEN 0 THEN '%' + ISNULL(@Separator, '') + 
						 ISNULL(@Key1, '') + ISNULL(@Separator, '') + 
						 ISNULL(@Key2, '') + ISNULL(@Separator, '') + 
						 ISNULL(@Key3, '')
        END
    )
PRINT @NewKeyForm

---string_split có thứ tự cột
DECLARE @RESULTSPLIT TABLE(Value VARCHAR(MAX), Orders INT)
DECLARE @String VARCHAR(MAX) = @VoucherNo
DECLARE @SeparatorPosition INT = CHARINDEX(@Separator, @String),
        @Value VARCHAR(MAX), @StartPosition INT = 1
DECLARE @Order INT = 0;
IF @SeparatorPosition = 0  
BEGIN
   INSERT INTO @RESULTSPLIT VALUES(@String, @Order)
END
ELSE
BEGIN   
 SET @String = @String + @Separator
 WHILE @SeparatorPosition > 0
  BEGIN
   SET @Value = SUBSTRING(@String , @StartPosition, @SeparatorPosition- @StartPosition)
 
   IF(@Value <> '') 
   BEGIN
		INSERT INTO @RESULTSPLIT VALUES(@Value, @Order)
		SET @Order = @Order + 1
   END
   SET @StartPosition = @SeparatorPosition + 1
   SET @SeparatorPosition = CHARINDEX(@Separator, @String , @StartPosition)
  END 
END   
---string_split có thứ tự cột

IF @VoucherNo LIKE @NewKeyForm AND LEN(@VoucherNo) = @OutputLength
BEGIN
	DECLARE @LastKey INT
	DECLARE @Keystring NVARCHAR(50)

	SET @Keystring = CONCAT(@Key1, @Key2, @Key3)
	PRINT @Keystring
	SELECT @LastKey = Value FROM @RESULTSPLIT WHERE Orders = @OutputOrder
	PRINT @LastKey

	IF @LastKey > (SELECT TOP 1 LASTKEY FROM AT4444 WHERE ISNULL(TABLENAME,'') = @TableName AND ISNULL(KEYSTRING,'') = @Keystring AND DivisionID = @DivisionID)
	BEGIN
		UPDATE AT4444 SET LASTKEY = @LastKey WHERE ISNULL(TABLENAME,'') = @TableName AND ISNULL(KEYSTRING,'') = @Keystring AND DivisionID = @DivisionID
	END
END

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

