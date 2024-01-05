IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[GetVoucherNo]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[GetVoucherNo]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Sinh mã tự động theo các dữ liệu thuyết lập truyền vào Store
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
---- Created by Vĩnh Tâm on 08/06/2020
/* Example
	DECLARE @VoucherNo VARCHAR(50),
			@KeyString VARCHAR(50),
			@LastKey INT
	EXEC GetVoucherNo 'MK', 'BEM', 'BEMT0000', 'ProposalVoucher', 'BEMT2000', @VoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
	SELECT @VoucherNo AS VoucherNo, @KeyString AS KeyString, @LastKey AS LastKey
 */

CREATE PROCEDURE [dbo].[GetVoucherNo]
( 
	@DivisionID VARCHAR(50),
	@ModuleID VARCHAR(50),
	@VoucherSettingTable VARCHAR(50),
	@VoucherSettingColumn VARCHAR(50),
	@VoucherDataTable VARCHAR(50),
	@VoucherNo VARCHAR(50) OUTPUT,
	@KeyString VARCHAR(50) OUTPUT,
	@LastKey INT OUTPUT
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR (MAX) = N'',
			@ParamDefinition NVARCHAR(500),
			@VoucherTypeID VARCHAR(50)

	-- Trường hợp không truyền đủ param thì kết thúc store
	IF ISNULL(@VoucherSettingTable, '') = '' OR ISNULL(@VoucherSettingTable, '') = '' OR ISNULL(@VoucherSettingTable, '') = ''
		GOTO Result
			
	SET @ParamDefinition = N'@DivisionID VARCHAR(50), @VoucherTypeID VARCHAR(50) OUTPUT'
	SET @sSQL = 'SELECT @VoucherTypeID = ' + @VoucherSettingColumn + '
				FROM ' + @VoucherSettingTable + ' WITH (NOLOCK)
				WHERE DivisionID = @DivisionID'
	EXEC SP_EXECUTESQL @sSQL, @ParamDefinition, @DivisionID = @DivisionID, @VoucherTypeID = @VoucherTypeID OUTPUT
	
	-- Lấy dữ liệu thiết lập theo Mã loại chứng từ được thiết lập
	SELECT * INTO #ConfigVoucherNo
	FROM AT1007 WITH (NOLOCK)
	WHERE VoucherTypeID = @VoucherTypeID

	-- Trường hợp không lấy được dữ liệu thiết lập thì kết thúc store
	IF (SELECT COUNT(*) FROM #ConfigVoucherNo) = 0
		GOTO Result

	-- Các biến chứa dữ liệu Thiết lập sinh số chứng từ tự động
	DECLARE @S1 VARCHAR(50) = '',
			@S2 VARCHAR(50) = '',
			@S3 VARCHAR(50) = '',
			@Enabled1 VARCHAR(50) = '',
			@Enabled2 VARCHAR(50) = '',
			@Enabled3 VARCHAR(50) = '',
			@S1Type VARCHAR(50) = '',
			@S2Type VARCHAR(50) = '',
			@S3Type VARCHAR(50) = '',
			@Separated INT = 0,
			@Separator VARCHAR(10),
			@FormatNumber VARCHAR(10),
			@Length INT,
			@OutputOrder INT

	SELECT @Enabled1 = Enabled1, @Enabled2 = Enabled2, @Enabled3 = Enabled3,
			@S1Type = S1Type, @S2Type = S2Type, @S3Type = S3Type,
			@S1 = S1, @S2 = S2, @S3 = S3,
			@Separated = Separated, @Separator = Separator,
			@Length = OutputLength, @OutputOrder = OutputOrder
	FROM #ConfigVoucherNo

	-- Kiểm tra các nhóm (s1, s2, s3) bị disable, nhóm nào bị disable thì thay bằng chuỗi empty
	IF ISNULL(@Enabled1, 0) = 1
		SELECT @S1 = dbo.GetPartVoucherNo(@DivisionID, @ModuleID, @VoucherTypeID, @S1, @S1Type)
	IF ISNULL(@Enabled2, 0) = 1
		SELECT @S2 = dbo.GetPartVoucherNo(@DivisionID, @ModuleID, @VoucherTypeID, @S2, @S2Type)
	IF ISNULL(@Enabled3, 0) = 1
		SELECT @S3 = dbo.GetPartVoucherNo(@DivisionID, @ModuleID, @VoucherTypeID, @S3, @S3Type)

	SET @KeyString = CONCAT(@S1, @S2, @S3)

	-- Nếu không có sử dụng dấu phân cách thì set rỗng cho dấu phân cách
	IF ISNULL(@Separated, 0) = 0
		SET @Separator = ''

	-- Lấy số tăng tự động lớn nhất trong hệ thống
	SELECT TOP 1 @LastKey = LastKey
    FROM AT4444 WITH (NOLOCK)
    WHERE ISNULL(TableName,'') = @VoucherDataTable AND ISNULL(KeyString,'') = @KeyString

	-- Tạo VoucherNo template để tính độ dài phần còn lại của dãy số tăng tự động
	SET @VoucherNo = FORMATMESSAGE('%s%s%s%s%s%s', @Separator, @S1, @Separator, @S2, @Separator, @S3)
	SET @Length = @Length - LEN(@VoucherNo)
	SET @FormatNumber = '%0' + CONVERT(VARCHAR(2), @Length) +'i'

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

	Result:

END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
