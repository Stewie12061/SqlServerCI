IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[GETVOUCHERNO_VER2]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[GETVOUCHERNO_VER2]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Sinh mã chứng từ tự động theo các dữ liệu thiết lập truyền vào
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
---- Created by Hoài Bảo on 06/09/2022
---- Modify by Tấn Lộc on 11/11/2022 - Trường hợp AT4444 chưa có dòng dữ liệu nào để get lastkey thì insert trước 1 dòng (Trường hợp import trực tiếp)
/* Example
    DECLARE 
        @NewVoucherNo VARCHAR(50),
        @KeyString VARCHAR(50),
        @LastKey INT
    EXEC GetVoucherNo_Ver2 'DTI', 'CRM', 'CRMF2041', 'CRMT20401', @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
    SELECT @NewVoucherNo AS VoucherNo, @KeyString AS KeyString, @LastKey AS LastKey
 */

CREATE PROCEDURE [dbo].[GetVoucherNo_Ver2]
( 
    @DivisionID VARCHAR(50),
    @ModuleID VARCHAR(50),
    @ScreenID VARCHAR(50),
    @TableID VARCHAR(50),
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
    IF ISNULL(@ScreenID, '') = '' OR ISNULL(@TableID, '') = '' OR ISNULL(@ModuleID, '') = ''
        GOTO Result

    SET @ParamDefinition = N'@DivisionID VARCHAR(50), @VoucherTypeID VARCHAR(50) OUTPUT'
    SET @sSQL = 'SELECT @VoucherTypeID = VoucherTypeID
                FROM AT1007 WITH (NOLOCK)
                WHERE DivisionID = @DivisionID AND ModuleID = ''' + @ModuleID + ''' AND ScreenID = ''' + @ScreenID + '''' 
    EXEC SP_EXECUTESQL @sSQL, @ParamDefinition, @DivisionID = @DivisionID, @VoucherTypeID = @VoucherTypeID OUTPUT

    -- Lấy dữ liệu thiết lập theo Mã loại chứng từ được thiết lập
    SELECT * INTO #ConfigVoucherNo
    FROM AT1007 WITH (NOLOCK)
    WHERE VoucherTypeID = @VoucherTypeID AND DivisionID = @DivisionID

    -- Trường hợp không lấy được dữ liệu thiết lập thì kết thúc store
    --IF (SELECT COUNT(*) FROM #ConfigVoucherNo) = 0
    --    GOTO Result

    -- Các biến chứa dữ liệu Thiết lập sinh số chứng từ tự động
    DECLARE @S1 VARCHAR(50) = '',
            @S2 VARCHAR(50) = '',
            @S3 VARCHAR(50) = '',
			@S1Type INT,
			@S2Type INT,
			@S3Type INT,
            @Enabled1 VARCHAR(50) = '',
            @Enabled2 VARCHAR(50) = '',
            @Enabled3 VARCHAR(50) = '',
            @Separated INT = 0,
            @Separator VARCHAR(10),
            @FormatNumber VARCHAR(10),
            @OutputLength INT,
            @OutputOrder INT

    SELECT @Enabled1 = Enabled1, @Enabled2 = Enabled2, @Enabled3 = Enabled3,
            @S1 = S1, @S2 = S2, @S3 = S3, @S1Type = S1Type, @S2Type = S2Type, @S3Type = S3Type,
            @Separated = Separated, @Separator = separator,
            @OutputLength = OutputLength, @OutputOrder = OutputOrder
    FROM #ConfigVoucherNo

    -- Kiểm tra các nhóm (s1, s2, s3) bị disable, nhóm nào bị disable thì thay bằng chuỗi empty
IF ISNULL(@Enabled1, 0) = 1
        SELECT @S1 = dbo.GetPartVoucherNo(@DivisionID, @ModuleID, @VoucherTypeID, @S1, @S1Type)
    IF ISNULL(@Enabled2, 0) = 1
        SELECT @S2 = dbo.GetPartVoucherNo(@DivisionID, @ModuleID, @VoucherTypeID, @S2, @S2Type)
    IF ISNULL(@Enabled3, 0) = 1
        SELECT @S3 = dbo.GetPartVoucherNo(@DivisionID, @ModuleID, @VoucherTypeID, @S3, @S3Type)

    SET @KeyString = CONCAT(@S1, @S2, @S3)

    -- Nếu các nhóm trả về NULL thì set rỗng 
    SET @S2 = ISNULL(@S2,'')
    SET @S3 = ISNULL(@S3,'')

    -- Nếu không có sử dụng dấu phân cách thì set rỗng cho dấu phân cách
	IF ISNULL(@Separator,'') = ''
		SET @Separated = null

    IF ISNULL(@Separated, 0) = 0
        SET @Separator = ''

    -- Lấy số tăng tự động lớn nhất trong hệ thống
    SELECT TOP 1 @LastKey = LastKey
    FROM AT4444 WITH (NOLOCK)
    WHERE ISNULL(TableName,'') = @TableID AND ISNULL(KeyString,'') = @KeyString

    -- Trường hợp @LastKey chưa được sinh ra trong bảng AT4444
    IF(@LastKey = '') OR (@LastKey IS NULL)
    BEGIN
        -- Insert 1 dòng
        INSERT INTO AT4444 (DivisionID, TABLENAME, KEYSTRING, LASTKEY) 
        VALUES (@DivisionID, @TableID, @KeyString, 1)

        -- Set @LastKey = 1
           SET @LastKey = 0
    END

    -- Tạo VoucherNo template để tính độ dài phần còn lại của dãy số tăng tự động
    SET @VoucherNo = CASE (@S2) 
                    WHEN '' THEN CASE (@S3) 
                                WHEN '' THEN FORMATMESSAGE('%s%s%s%s%s%s',  @Separator, @S1, '', @S2, '', @S3)
                                ELSE FORMATMESSAGE('%s%s%s%s%s%s',  @Separator, @S1, '', @S2, @Separator, @S3)
                                END
                    ELSE CASE (@S3) 
                        WHEN '' THEN FORMATMESSAGE('%s%s%s%s%s%s', @Separator, @S1, @Separator, @S2, '', @S3)
                        ELSE FORMATMESSAGE('%s%s%s%s%s%s', @Separator, @S1, @Separator, @S2, @Separator, @S3)
                        END
                    END

    SET @OutputLength = @OutputLength - LEN(@VoucherNo)
    SET @FormatNumber = '%0' + CONVERT(VARCHAR(2), @OutputLength) +'i'


    -- Kiểm tra OutputOrder để sắp xếp chuỗi kết quả
    SET @VoucherNo = 
        CASE @OutputOrder
            -- NSSS
            WHEN 0
                THEN CASE (@S2) 
                     WHEN '' THEN CASE (@S3) 
                                  WHEN '' THEN FORMATMESSAGE('%s%s%s%s%s%s%s', @FormatNumber, @Separator, @S1, '', @S2, '', @S3)
                                  ELSE FORMATMESSAGE('%s%s%s%s%s%s%s', @FormatNumber, @Separator, @S1, '', @S2, @Separator, @S3)
                                  END
                     ELSE CASE (@S3) 
                          WHEN '' THEN FORMATMESSAGE('%s%s%s%s%s%s%s', @FormatNumber, @Separator, @S1, @Separator, @S2, '', @S3)
                          ELSE FORMATMESSAGE('%s%s%s%s%s%s%s', @FormatNumber, @Separator, @S1, @Separator, @S2, @Separator, @S3)
                          END
                     END

            -- SNSS
            WHEN 1
                THEN CASE (@S2) 
                     WHEN '' THEN CASE (@S3) 
                                  WHEN '' THEN FORMATMESSAGE('%s%s%s%s%s%s%s', @S1, @Separator, @FormatNumber, '', @S2, '', @S3)
                                  ELSE FORMATMESSAGE('%s%s%s%s%s%s%s', @S1, @Separator, @FormatNumber, '', @S2, @Separator, @S3)
                                  END
                     ELSE CASE (@S3) 
                          WHEN '' THEN FORMATMESSAGE('%s%s%s%s%s%s%s', @S1, @Separator, @FormatNumber, @Separator, @S2, '', @S3)
                          ELSE FORMATMESSAGE('%s%s%s%s%s%s%s', @S1, @Separator, @FormatNumber, @Separator, @S2, @Separator, @S3)
                          END
                     END

            -- SSNS
            WHEN 2
                THEN CASE (@S2) 
                     WHEN '' THEN CASE (@S3) 
                                  WHEN '' THEN FORMATMESSAGE('%s%s%s%s%s%s%s', @S1, @Separator, @S2, '', @FormatNumber, '', @S3)
                                  ELSE FORMATMESSAGE('%s%s%s%s%s%s%s', @S1, @Separator, @S2, @Separator, @FormatNumber, @Separator, @S3)
                                  END
                     ELSE CASE (@S3) 
                          WHEN '' THEN FORMATMESSAGE('%s%s%s%s%s%s%s', @S1, @Separator, @S2, @Separator, @FormatNumber, '', @S3)
                          ELSE FORMATMESSAGE('%s%s%s%s%s%s%s',  @S1, @Separator, @S2, @Separator, @FormatNumber, @Separator, @S3)
                          END
                     END

            -- SSSN
            WHEN 3
                THEN CASE (@S2) 
                     WHEN '' THEN CASE (@S3) 
                                  WHEN '' THEN FORMATMESSAGE('%s%s%s%s%s%s%s', @S1, @Separator, @S2, '', @S3, '', @FormatNumber)
                                  ELSE FORMATMESSAGE('%s%s%s%s%s%s%s',@S1, @Separator, @S2, '', @S3, @Separator, @FormatNumber)
                                  END

                ELSE CASE (@S3) 
                     WHEN '' THEN FORMATMESSAGE('%s%s%s%s%s%s%s', @S1, @Separator, @S2, @Separator, @S3, '', @FormatNumber)
                     ELSE FORMATMESSAGE('%s%s%s%s%s%s%s', @S1, @Separator, @S2, @Separator, @S3, @Separator, @FormatNumber)
                     END
                END

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
