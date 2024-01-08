IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP90001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP90001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----<Summary>
---- Kiểm tra loại chứng từ đã được sử dụng
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Hoài Bảo, Date: 07/12/2021
----<Modify by>: 
----<Example>
/*
	Declare @Status TINYINT, @OldValue VARCHAR(50)
	Exec CIP90001 'DTI', 'OOT2110', 'OOT0060', 'TaskID', 'VoucherTask', 'CV', 'OO', @Status OUTPUT, @OldValue OUTPUT
	SELECT @Status,@OldValue
*/
CREATE PROCEDURE CIP90001 (
				@DivisionID VARCHAR(50),
				@TableID NVARCHAR(50) = null, -- Bảng nghiệp vụ
				@TableVoucherTypeID NVARCHAR(50) = null, -- Bảng lưu thiết lập mã chứng từ theo module
				@Column NVARCHAR(50) = null, -- Cột lấy giá trị mã chứng từ của bảng nghiệp vụ
				@ColumnVoucherTypeID NVARCHAR(50) = null, -- Cột lấy giá trị từ bảng thiết lập mã chứng từ
				@VoucherTypeID  NVARCHAR(50) = null,
				@ModuleID NVARCHAR(50) = null,
				@Status  TINYINT OUTPUT,
				@OldValue VARCHAR(50) OUTPUT, -- VoucherTypeID được thiết lập ở bảng lưu thiết lập mã chứng
				@GroupID NVARCHAR(50) = null
			)
AS
		DECLARE @sSQL NVARCHAR(MAX) = '', @ParamDefinition NVARCHAR(500)
		-- Check trường hợp hệ thống đang sử dụng thiết lập chứng từ ở màn hình Hệ thống, thì trả về mã chứng từ hệ thống đang sử dụng cho nghiệp vụ đó
		SET @ParamDefinition = N'@OldValue NVARCHAR(50) OUTPUT'
		IF (ISNULL(@TableVoucherTypeID, '') = 'HRMT0010')
			SET @sSQL = '
			SELECT @OldValue = ' +@ColumnVoucherTypeID+ ' FROM HRMT0010 WITH (NOLOCK) WHERE DivisionID = ''' +@DivisionID+ ''' AND GroupID = ''' +@GroupID+ ''''
		ELSE
			SET @sSQL = '
			SELECT @OldValue = ' +@ColumnVoucherTypeID+ ' FROM ' +@TableVoucherTypeID+ ' WHERE DivisionID = ''' +@DivisionID+ ''''

		EXEC SP_EXECUTESQL @sSQL, @ParamDefinition, @OldValue = @OldValue OUTPUT
		-- Nếu có giá trị từ bảng thiết lập thì dừng lại và trả về @OldValue
		IF ISNULL(@OldValue,'') != '' 
			RETURN

		DECLARE @at1007_Temp TABLE(
			Auto VARCHAR(50),
			S1 VARCHAR(50),
			S2 VARCHAR(50),
			S3 VARCHAR(50),
			OutputOrder INT,
			OutputLength INT,
			Separated INT,
			separator VARCHAR(10),
			S1Type VARCHAR(50),
			S2Type VARCHAR(50), 
			S3Type VARCHAR(50), 
			Enabled VARCHAR(50),
			Enabled1 VARCHAR(50), 
			Enabled2 VARCHAR(50), 
			Enabled3 VARCHAR(50)
		)
		INSERT INTO @at1007_Temp(Auto, S1, S2, S3, OutputOrder, OutputLength, Separated, separator, S1Type, S2Type, S3Type, Enabled,Enabled1, Enabled2, Enabled3)
		SELECT TOP 1 [Auto], S1, S2, S3, OutputOrder, OutputLength, Separated, separator, S1Type, S2Type, S3Type, [Enabled], Enabled1, Enabled2, Enabled3
		FROM AT1007
		WHERE DivisionID = @DivisionID AND VoucherTypeID = @VoucherTypeID

		DECLARE @S1 VARCHAR(50),@S2 VARCHAR(50),@S3 VARCHAR(50), @Separated INT = 0, @Separator VARCHAR(10), @LastKey INT = 0,
				@VoucherNo VARCHAR(MAX), @OutputLength INT, @FormatNumber VARCHAR(10), @OutputOrder INT, @KeyCompare VARCHAR(50)

		SELECT @S1 = CASE WHEN Enabled1 = 1 THEN dbo.GetPartVoucherNo(@DivisionID, @ModuleID, @VoucherTypeID, S1, S1Type) ELSE '' END,
			   @S2 = CASE WHEN Enabled2 = 1 THEN dbo.GetPartVoucherNo(@DivisionID, @ModuleID, @VoucherTypeID, S2, S2Type) ELSE '' END,
			   @S3 = CASE WHEN Enabled3 = 1 THEN dbo.GetPartVoucherNo(@DivisionID, @ModuleID, @VoucherTypeID, S3, S3Type) ELSE '' END,
			   @OutputLength = OutputLength, @OutputOrder = OutputOrder, @Separated = Separated, @Separator = separator
		FROM @at1007_Temp

		-- Tạo chuỗi keystring
		DECLARE @Keystring VARCHAR(50) = CONCAT(@S1, @S2, @S3)

		-- Nếu không có sử dụng dấu phân cách thì set rỗng cho dấu phân cách
		IF ISNULL(@Separated, 0) = 0
			SET @Separator = ''

		-- Lấy số tăng tự động lớn nhất trong hệ thống
		SELECT TOP 1 @LastKey = LastKey
		FROM AT4444 WITH (NOLOCK)
		WHERE ISNULL(TableName,'') = @TableID AND ISNULL(KeyString,'') = @KeyString

		-- Tạo VoucherNo template để tính độ dài phần còn lại của dãy số tăng tự động
		SET @VoucherNo = FORMATMESSAGE('%s%s%s%s%s%s', @Separator, @S1, @Separator, @S2, @Separator, @S3)
		SET @OutputLength = @OutputLength - LEN(@VoucherNo)
		SET @FormatNumber = '%0' + CONVERT(VARCHAR(2), @OutputLength) +'i'

		-- Kiểm tra OutputOrder để sắp xếp chuỗi kết quả
		SET @VoucherNo = 
			CASE @OutputOrder
				-- NSSS
				WHEN 0
					THEN FORMATMESSAGE('%s%s%s%s%s%s%s', @FormatNumber, @Separator, @S1, @Separator, @S2, @Separator, @S3)

				-- SNSS
				WHEN 1
					THEN FORMATMESSAGE('%s%s%s%s%s%s%s', @S1, @Separator, @FormatNumber, @Separator, @S2, @Separator, @S3)

				-- SSNS
				WHEN 2
					THEN FORMATMESSAGE('%s%s%s%s%s%s%s', @S1, @Separator, @S2, @Separator, @FormatNumber, @Separator, @S3)

				-- SSSN
				WHEN 3
					THEN FORMATMESSAGE('%s%s%s%s%s%s%s', @S1, @Separator, @S2, @Separator, @S3, @Separator, @FormatNumber)
			END
		
		SET @LastKey = @LastKey + 1
		SET @VoucherNo = FORMATMESSAGE(@VoucherNo, @LastKey)

		-- Loại bỏ ký tự số trong @VoucherNo
		SET @KeyCompare = [dbo].RemoveNumber(@VoucherNo)

		SET @ParamDefinition = N'@KeyCompare VARCHAR(50), @Status TINYINT OUTPUT'
		SET @sSQL = '
		DECLARE @cursorName VARCHAR(50)
		DECLARE cursorVoucherNo CURSOR FOR
		SELECT ' +@Column+ ' AS cursorName  FROM ' +@TableID+ ' WITH (NOLOCK) WHERE DivisionID = ''' +@DivisionID+ '''
		OPEN cursorVoucherNo	
		FETCH NEXT FROM cursorVoucherNo INTO @cursorName
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF (@KeyCompare = [dbo].RemoveNumber(@cursorName))
			BEGIN
				SET @Status = 1
				BREAK
			END
			FETCH NEXT FROM cursorVoucherNo INTO @cursorName
		END
		CLOSE cursorVoucherNo
		DEALLOCATE cursorVoucherNo'
		--Print @sSQL
		EXEC SP_EXECUTESQL @sSQL, @ParamDefinition, @KeyCompare = @KeyCompare, @Status = @Status OUTPUT

		Result:
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO