IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2053]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2053]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Xét duyệt đơn 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Quốc Tuấn, Date: 09/12/2015
--- Modified on 18/02/2019 by Bảo Anh: Nếu là duyệt quyết định tuyển dụng thì không cập nhật xuống HRM
--- Modified on 22/03/2019 by Như Hàn: Bổ sung các phần duyệt sau lấy APKMaster_9000, Bổ sung update trạng thái cho bảng master nếu là người duyệt cuối cùng
--- Modified on 04/06/2019 by Như Hàn: Insert ngân sách vào mã PT theo thiết lập
--- Modified on 24/09/2020 by Kiều Nga: Nếu là trường hợp duyệt hàng loạt thì không update ApprovingLevel vì phần này đã xử lý bên store OOP2052
--- Modified on 26/10/2020 by Văn Tài: Tách trường hợp duyệt Bảng phân ca.
--- Modified on 05/06/2021 by Kiều Nga: Bổ sung tự sinh YCXK khi duyệt TTSX.
--- Modified on 23/07/2021 by Đình Hoà:Bổ sung duyệt bảng tính giá(BTG)
--- Modified on 03/08/2021 by Đình Hoà:Bổ sung duyệt Phiếu báo giá Sale(PBGKD) - (SGNP)
--- Modified on 11/01/2022 by Kiều Nga:Fix lỗi hiển thị sai tình trạng phiếu khi đã duyệt phiếu chào giá 
--- Modified on 12/01/2022 by Nhật Thanh: Nếu là yêu cầu mua hàng thì lấy apkmaster = @apk
--- Modified on 14/01/2022 by Kiều Nga:Fix lỗi hiển thị sai tình trạng phiếu khi đã duyệt phiếu Yêu cầu mua hàng
--- Modified on 14/05/2022 by Kiều Nga:Bổ sung duyệt Văn bản đi, Văn bản đến (CSG).
--- Modified on 19/05/2022 by Kiều Nga: Fix lỗi bổ sung duyệt Văn bản đi, Văn bản đến (CSG).
--- Modified on 27/05/2022 by Kiều Nga: Fix lỗi nhận thông báo duyệt.
--- Modified on 01/06/2022 by Kiều Nga: Fix lỗi insert thông báo duyệt.
--- Modified on 27/06/2022 by Kiều Nga: Bổ sung lịch sử duyệt cho Văn bản đi, Văn bản đến (CSG).
--- Modified on 07/07/2022 by Văn Tài : Xử lý trường hợp dữ liệu lịch sử đã được Duyệt/Từ chối cho Văn bản.
--- Modified on 24/08/2022 by Đức Tuyên: Bổ sung duyệt Đề nghị thu/chi ('DNT','DNC').
--- Modified on 30/09/2022 by Phương Thảo : Fix lỗi cập nhật trạng thái duyệt 
--- Modified on 03/10/2022 by Phương Thảo : Revert store, không phải cấp duyệt cuối thì update status = 0 cho 2 bảng master. Chỉ update details.
--- Modified on 06/12/2022 by Kiều Nga : Bổ sung xử lý thông báo duyệt yêu cầu mua hàng
--- Modified on 07/12/2022 by Kiều Nga : Bổ sung xử lý thông báo duyệt dự toán
--- Modified on 28/03/2023 by Hoang : Bổ sung screenID vào customURL khi lưu phiếu thu/chi.   
--- Modified on 05/04/2023 by Nhật Thanh : Đưa thông báo duyệt của Mai Thư vào customize Mai Thư  
--- Modified on 13/04/2023 by Hoài Thanh: Bổ sung duyệt đơn hàng bán SELL OUT.
--- Modified on 27/04/2023 by Nhựt Trường: [2023/04/IS/0204] - Fix lỗi truyền rỗng vào trường APKMaster khi insert dữ liệu bảng OOT9002.
--- Modified on 12/09/2023 by Nhật Thanh: Xóa ví chiết khấu khi từ chối duyệt đơn hàng bán
--- Modified on .. by ...:
/*-- <Example>
exec OOP2053 @APKMaster='5A3CE2DD-D286-4F5E-BF5F-058EDB714DB6',
@TranMonth=2,@TranYear=2016,@Type=N'DXRN',@APK='2E728BDC-E154-4CF5-ADF3-44A890E07910',@DivisionID=N'MK',@UserID=N'000004'
----*/

CREATE PROCEDURE OOP2053
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @TranMonth INT,
  @TranYear INT,
  @APKMaster VARCHAR(50),
  @APK VARCHAR(50), ---- APK cua bang OOT9001
  @Type VARCHAR(50),
  @APKDetail VARCHAR(50) = NULL, ---- APK của bảng nghiệp vụ tương ứng
  @Table VARCHAR(50) = '',
  @TableMaster VARCHAR(50) = '',
  @IsApproved INT = 0 -- =1 duyệt hàng loạt
) 
AS 
DECLARE @ApprovingLevel TINYINT,
		@Status TINYINT,
		@Cur CURSOR,
		@APKAT9001 VARCHAR(50),
		@ApprovePresonID VARCHAR(50),
		@Level TINYINT,
		@SQL VARCHAR(MAX),
		@IsLastLevel AS INT

DECLARE @CustomerIndex INT = (SELECT TOP 1 CustomerName FROM CustomerIndex)

if(@CustomerIndex = 131) -- Khách hàng NQH.
BEGIN
	EXEC OOP2053_NQH @DivisionID ,@UserID,@TranMonth,@TranYear,@APKMaster,@APK,@Type,@APKDetail,@Table,@TableMaster,@IsApproved
END
ELSE
BEGIN

--tăng tốc độ
SET NOCOUNT ON;

If @Type = 'YCMH' and @CustomerIndex = 114 -- khang hang dti
	SELECT @ApprovingLevel = LEVEL
			, @Status = STATUS
			, @ApprovePresonID = ApprovePersonID
	FROM OOT9001 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID
	AND APKMaster = @APK
ELSE
	SELECT @ApprovingLevel = LEVEL
			, @Status = STATUS
			, @ApprovePresonID = ApprovePersonID
	FROM OOT9001 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID
	AND APK = @APK

IF ISNULL(@Type,'') IN ('DXP', 'DXDC', 'DXLTG', 'DXBSQT', 'DXRN', 'KHTD', 'QDTD')
	BEGIN
		-- Nếu là trường hợp duyệt hàng loạt thì không xử lý
		IF @IsApproved <> 1
		BEGIN
			--cập nhật đệ quy
			SET @Cur = CURSOR SCROLL KEYSET FOR
					   SELECT APK,[Level]
					   FROM OOT9001 WITH (NOLOCK)
					   WHERE DivisionID=@DivisionID
					   AND APKMaster=@APKMaster
					   AND ISNULL(APKDetail, '00000000-0000-0000-0000-000000000000') = ISNULL(@APKDetail, '00000000-0000-0000-0000-000000000000')
					   AND ApprovePersonID=@ApprovePresonID
					   AND ( ([Level]> @ApprovingLevel AND @Status = 1) 
							OR ([Level]< @ApprovingLevel AND @Status = 2)  )
					   ORDER BY Level
			OPEN @Cur
			FETCH NEXT FROM @Cur INTO @APKAT9001,@Level
			WHILE @@FETCH_STATUS = 0
			BEGIN
				IF (@Level <> @ApprovingLevel+1 AND @Status = 1) OR (@Level <> @ApprovingLevel-1 AND @Status = 2)
				BEGIN
					BREAK
				END

				UPDATE OOT9001 SET @ApprovingLevel=CASE WHEN @Status = 1 THEN [Level] ELSE @ApprovingLevel END,
				[Status]=@Status
				WHERE APK=@APKAT9001
				AND DivisionID=@DivisionID

				SET @SQL = 'UPDATE ' + @Table + ' SET ApprovingLevel = ' + LTRIM(@ApprovingLevel) + '
				WHERE APKMaster=''' + LTRIM(@APKMaster) + '''' + (CASE WHEN @Type <> 'BPC' THEN ' AND Convert(Varchar(50),APK) = ''' + @APKDetail + '''' ELSE '' END) + '
				AND DivisionID =''' + @DivisionID + '''
				AND ' + LTRIM(@Status) + ' = 1'
	
				EXEC(@SQL)

				FETCH NEXT FROM @Cur INTO @APKAT9001,@Level
			END
			CLOSE @Cur
		END

		--- Cập nhật tình trạng nếu là người duyệt cuối cùng
		SET @SQL = '
		IF EXISTS (SELECT TOP 1 1 FROM ' + @Table + ' WITH (NOLOCK) WHERE ApproveLevel=' + LTRIM(@ApprovingLevel) + ' AND APKMaster =''' + @APKMaster + '''' + (CASE WHEN @Type <> 'BPC' THEN ' AND Convert(Varchar(50),APK) = ''' + @APKDetail + '''' ELSE '' END) + ')
		BEGIN
			UPDATE OOT9000 SET [Status] = ' + LTRIM(@Status) + '
			WHERE APK=''' + @APKMaster + '''
			AND DivisionID =''' + @DivisionID + '''

			UPDATE ' + @Table + ' SET [Status] = ' + LTRIM(@Status) + '
			WHERE APKMaster=''' + @APKMaster + '''' + (CASE WHEN @Type <> 'BPC' THEN ' AND Convert(Varchar(50),APK) = ''' + @APKDetail + '''' ELSE '' END) + '
			AND DivisionID =''' + @DivisionID + '''
	
			-- cap nhat xuong HRM neu duyet thanh cong
			IF ''' + @Type + ''' <> ''QDTD''
			BEGIN
				IF ' + LTRIM(@Status) + '=1 
					EXEC OOP2054 ''' + @DivisionID + ''',''' + @UserID + ''',' + LTRIM(@TranMonth) + ',' + LTRIM(@TranYear) + ',''' + @APKMaster + ''',''' + @Type + ''',1,''' + @APKDetail + '''
				ELSE IF ' + LTRIM(@Status) + '=2 -- xoa nhung dong da import xuong HRM neu nguoi duyet cuoi cung bo duyet
					EXEC OOP2054 ''' + @DivisionID + ''',''' + @UserID + ''',' + LTRIM(@TranMonth) + ',' + LTRIM(@TranYear) + ',''' + @APKMaster + ''',''' + @Type + ''',0,''' + @APKDetail + '''
			END
		END
		ELSE IF ' + LTRIM(@Status) + ' =2
		BEGIN
			
			UPDATE OOT9000 SET [Status] = ' + LTRIM(@Status) + '
			WHERE APK=''' + @APKMaster + '''
			AND DivisionID =''' + @DivisionID + '''

			--Cap nhat bang nghiep vu
			UPDATE ' + @Table + ' SET [Status] = ' + LTRIM(@Status) + '
			WHERE APKMaster=''' + @APKMaster + '''' + (CASE WHEN @Type <> 'BPC' THEN ' AND Convert(Varchar(50),APK) = ''' + @APKDetail + '''' ELSE '' END) + '
			AND DivisionID =''' + @DivisionID + '''
	
			--Kiem tra la phieu ra ngoai thi tru chuyen can
			IF ''' + @Type + ''' =''DXRN''
			BEGIN
				EXEC OOP2059 ''' + @DivisionID + ''',''' + @UserID + ''',' + LTRIM(@TranMonth) + ',' + LTRIM(@TranYear) + ',''' + @APKMaster + ''',' + LTRIM(@Status) + '
			END
		END
		ELSE IF ' + LTRIM(@Status) + ' =1
			BEGIN
				--Cap nhat duyệt
				UPDATE OOT9000 SET [Status] = 0
				WHERE APK=''' + @APKMaster + '''
				AND DivisionID =''' + @DivisionID + '''

				--Cap nhat bang nghiep vu
				UPDATE ' + @Table + ' SET [Status] = 0 WHERE APKMaster=''' + @APKMaster + '''' + (CASE WHEN @Type <> 'BPC' THEN ' AND Convert(Varchar(50),APK) = ''' + @APKDetail + '''' ELSE '' END) + '
			END
		'
		--PRINT @SQL
		EXEC(@SQL)
	END
ELSE IF ISNULL(@Type,'') IN ('CH')
	BEGIN
	--cập nhật đệ quy
		SET @Cur = CURSOR SCROLL KEYSET FOR
				   SELECT APK,[Level]
				   FROM OOT9001 WITH (NOLOCK)
				   WHERE DivisionID=@DivisionID
				   AND APKMaster=@APKMaster
				   AND ISNULL(APKDetail, '00000000-0000-0000-0000-000000000000') = ISNULL(@APKDetail, '00000000-0000-0000-0000-000000000000')
				   AND ApprovePersonID=@ApprovePresonID
				   AND ( ([Level]> @ApprovingLevel AND @Status = 1) 
						OR ([Level]< @ApprovingLevel AND @Status = 2)  )
				   ORDER BY Level
		OPEN @Cur
		FETCH NEXT FROM @Cur INTO @APKAT9001,@Level
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF (@Level <> @ApprovingLevel+1 AND @Status = 1) OR (@Level <> @ApprovingLevel-1 AND @Status = 2)
			BEGIN
				BREAK
			END
			UPDATE OOT9001 SET @ApprovingLevel=CASE WHEN @Status = 1 THEN [Level] ELSE @ApprovingLevel END,
			[Status]=@Status
			WHERE APK=@APKAT9001
			AND DivisionID=@DivisionID
	
			EXEC(@SQL)

			FETCH NEXT FROM @Cur INTO @APKAT9001,@Level
		END
		CLOSE @Cur

		DECLARE @ApproveLevel TINYINT 
		SET @ApproveLevel = (SELECT MAX(Level) FROM OOT9001 WITH (NOLOCK) where APKMaster=@APKMaster)
		--- Cập nhật tình trạng nếu là người duyệt cuối cùng
		SET @SQL = '
		IF EXISTS (SELECT TOP 1 1 FROM ' + @TableMaster + ' WITH (NOLOCK) WHERE ApproveLevel=' + LTRIM(@ApprovingLevel) + ' AND APKMaster_9000 =''' + @APKMaster + ''' )
		BEGIN
		'
			IF ISNULL(@TableMaster,'') <> ''
			SET @SQL = @SQL +'
			UPDATE ' + @TableMaster + ' SET [Status] = ' + LTRIM(@Status) + '
			WHERE APKMaster_9000=''' + @APKMaster + '''
			AND DivisionID =''' + @DivisionID + ''''

			---- Update tình trạng đơn hàng cho YCMH, DHM
			IF @Status = 1
			SET @SQL = @SQL +'
				UPDATE ' + @TableMaster + ' SET [OrderStatus] = ' + LTRIM(@Status) + '
				WHERE APKMaster_9000=''' + @APKMaster + '''
				AND DivisionID =''' + @DivisionID + ''''
			ELSE IF @Status != 1
			SET @SQL = @SQL +'
				UPDATE ' + @TableMaster + ' SET [OrderStatus] = 0
				WHERE APKMaster_9000=''' + @APKMaster + '''
				AND DivisionID =''' + @DivisionID + '''
		
		END
		ELSE IF ' + LTRIM(@Status) + ' =2
		BEGIN
			--Cap nhat bang nghiep vu
			'
			IF ISNULL(@TableMaster,'') <> ''
			SET @SQL = @SQL +'
			UPDATE ' + @TableMaster + ' SET [Status] = ' + LTRIM(@Status) + '
			WHERE APKMaster_9000=''' + @APKMaster + '''
			AND DivisionID =''' + @DivisionID + ''''

			SET @SQL = @SQL +'
		END
		ELSE IF ' + LTRIM(@Status) + ' =1
				BEGIN
				'
				IF ISNULL(@TableMaster,'') <> ''
				SET @SQL = @SQL +'
				UPDATE ' + @TableMaster + ' SET [Status] = 0
				WHERE APKMaster_9000=''' + @APKMaster + '''AND DivisionID =''' + @DivisionID + '''
				END
			'
		EXEC(@SQL)
	END
ELSE IF ISNULL(@Type, '') IN ('BPC')
	BEGIN
		-- Nếu là trường hợp duyệt hàng loạt thì không xử lý
	    IF @IsApproved <> 1
		BEGIN

			--cập nhật đệ quy
			SET @Cur = CURSOR SCROLL KEYSET FOR
					   SELECT 
							OOT9001.APK
							, OOT9001.Level
					   FROM OOT9001 WITH (NOLOCK)
					   WHERE 
							DivisionID = @DivisionID
							AND APKMaster = @APKMaster
							AND OOT9001.ApprovePersonID = @ApprovePresonID
							AND (
									-- Duyệt hiện tại < Cấp duyệt phiếu
									(@ApprovingLevel < [Level] AND @Status = 1) 
									OR 
									--- Từ chối hiện tại > Cấp duyệt phiếu
									(@ApprovingLevel > [Level] AND @Status = 2)
								)
					   ORDER BY Level
			OPEN @Cur
			FETCH NEXT FROM @Cur INTO @APKAT9001, @Level
			WHILE @@FETCH_STATUS = 0
			BEGIN
				IF (@Level <> @ApprovingLevel + 1 AND @Status = 1)
					 OR (@Level <> @ApprovingLevel - 1 AND @Status = 2)
				BEGIN
					BREAK
				END

				UPDATE OOT9001
				SET @ApprovingLevel = CASE
										  WHEN @Status = 1 THEN
											  [Level]
										  ELSE
											  @ApprovingLevel
									  END,
					[Status] = @Status
				WHERE APK = @APKAT9001
					  AND DivisionID = @DivisionID;

				SET @SQL = ' UPDATE ' + @Table + ' SET ApprovingLevel = ' + LTRIM(@ApprovingLevel) + '
				WHERE DivisionID = ''' + @DivisionID + '''
						AND APKMaster = ''' + LTRIM(@APKMaster) + '''
						AND ' + LTRIM(@Status) + ' = 1'

				--PRINT(@SQL)
				EXEC(@SQL)

				FETCH NEXT FROM @Cur INTO @APKAT9001,@Level
			END
			CLOSE @Cur
		END

		--- Cập nhật tình trạng nếu là người duyệt cuối cùng
		SET @SQL = '
		IF EXISTS (SELECT TOP 1 1
					FROM ' + @Table + ' WITH (NOLOCK) 
					WHERE ApproveLevel = ' + LTRIM(@ApprovingLevel) + ' AND APKMaster =''' + @APKMaster + '''
				  )
		BEGIN
			UPDATE OOT9000 SET [Status] = ' + LTRIM(@Status) + '
			WHERE APK = ''' + @APKMaster + '''
			AND DivisionID =''' + @DivisionID + '''

			UPDATE ' + @Table + ' SET [Status] = ' + LTRIM(@Status) + '
			WHERE APKMaster = ''' + @APKMaster + '''' + (CASE WHEN @Type <> 'BPC' THEN ' AND Convert(Varchar(50),APK) = ''' + @APKDetail + '''' ELSE '' END) + '
			AND DivisionID = ''' + @DivisionID + '''
	
			-- Cập nhật xuống HRM nếu duyệt thành công
			IF ' + LTRIM(@Status) + '= 1 
				EXEC OOP2054 ''' + @DivisionID + ''',''' + @UserID + ''',' + LTRIM(@TranMonth) + ',' + LTRIM(@TranYear) + ',''' + @APKMaster + ''',''' + @Type + ''',1,''' + @APKDetail + '''
			ELSE IF ' + LTRIM(@Status) + '=2 -- xoa nhung dong da import xuong HRM neu nguoi duyet cuoi cung bo duyet
				EXEC OOP2054 ''' + @DivisionID + ''',''' + @UserID + ''',' + LTRIM(@TranMonth) + ',' + LTRIM(@TranYear) + ',''' + @APKMaster + ''',''' + @Type + ''',0,''' + @APKDetail + '''
		END
		ELSE IF ' + LTRIM(@Status) + ' = 2
		BEGIN

			UPDATE OOT9000 SET [Status] = ' + LTRIM(@Status) + '
			WHERE APK = ''' + @APKMaster + '''
			AND DivisionID = ''' + @DivisionID + '''

			-- Cập nhật bảng nghiệp vụ
			UPDATE ' + @Table + ' SET [Status] = ' + LTRIM(@Status) + '
			WHERE APKMaster = ''' + @APKMaster + ''' 
			AND DivisionID = ''' + @DivisionID + '''

		END
		ELSE IF ' + LTRIM(@Status) + ' =1
			BEGIN
				--Cap nhat duyệt
				UPDATE OOT9000 SET [Status] = 0
				WHERE APK=''' + @APKMaster + '''
				AND DivisionID =''' + @DivisionID + '''

				--Cap nhat bang nghiep vu
				UPDATE ' + @Table + ' SET [Status] = 0 WHERE APKMaster=''' + @APKMaster + '''
			END
		'
		PRINT @SQL
		EXEC(@SQL)
	END
ELSE IF ISNULL(@Type, '') IN ('BTG')
	BEGIN
		--- Cập nhật tình trạng nếu là người duyệt cuối cùng
		SET @SQL = '
		IF EXISTS (SELECT TOP 1 1
					FROM ' + @Table + ' WITH (NOLOCK) 
					WHERE ApproveLevel = ' + LTRIM(@ApprovingLevel) + ' AND APKMaster_9000 =''' + @APKMaster + '''
				  )
		BEGIN
			UPDATE OOT9000 SET [Status] = ' + LTRIM(@Status) + '
			WHERE APK = ''' + @APKMaster + '''
			AND DivisionID =''' + @DivisionID + '''

			UPDATE ' + @Table + ' SET [StatusSS] = ' + LTRIM(@Status) + '
			WHERE APKMaster_9000 = ''' + @APKMaster + '''
			AND DivisionID = ''' + @DivisionID + '''
		END
		'
		PRINT @SQL
		EXEC(@SQL)
	END
ELSE IF ISNULL(@Type, '') IN ('PBGKD')
	BEGIN
		--- Cập nhật tình trạng nếu là người duyệt cuối cùng
		SET @SQL = '
		IF EXISTS (SELECT TOP 1 1
					FROM ' + @Table + ' WITH (NOLOCK) 
					WHERE ApproveLevel = ' + LTRIM(@ApprovingLevel) + ' AND APKMaster_9000 =''' + @APKMaster + '''
				  )
		BEGIN
			UPDATE OOT9000 SET [Status] = ' + LTRIM(@Status) + '
			WHERE APK = ''' + @APKMaster + '''
			AND DivisionID =''' + @DivisionID + '''

			UPDATE ' + @Table + ' SET [IsConfirm] = ' + LTRIM(@Status) + '
			WHERE APKMaster_9000 = ''' + @APKMaster + '''
			AND DivisionID = ''' + @DivisionID + '''
		END
		'
		PRINT @SQL
		EXEC(@SQL)
	END
ELSE IF ISNULL(@Type, '') IN ('DNT','DNC')
BEGIN
	--- Cập nhật tình trạng nếu là người duyệt cuối cùng
	SET @SQL = '
	IF EXISTS (SELECT TOP 1 1
				FROM ' + @Table + ' WITH (NOLOCK) 
				WHERE ApproveLevel = ' + LTRIM(@ApprovingLevel) + ' AND APKMaster_9000 =''' + @APKMaster + '''
			  )
	BEGIN
		UPDATE OOT9000 SET [Status] = ' + LTRIM(@Status) + '
		WHERE APK = ''' + @APKMaster + '''
		AND DivisionID =''' + @DivisionID + '''

		UPDATE ' + @Table + ' SET [Status] = ' + LTRIM(@Status) + '
		WHERE APKMaster_9000 = ''' + @APKMaster + '''
		AND DivisionID = ''' + @DivisionID + '''
	END
	'
	PRINT @SQL
	EXEC(@SQL)
	SET @SQL = '
	--- Insert Thông báo duyệt
	IF('+LTRIM(@Status) +'= 1 OR '+ LTRIM(@Status)+' = 2 OR '+ LTRIM(@Status)+' = 0)
	BEGIN
		-- Insert thông báo đã duyệt hoặc từ chối
		DECLARE @APK_OOT9002 VARCHAR(50) = NEWID()
		DECLARE @APKMaster_OOT9002 VARCHAR(50) = (SELECT TOP 1 APK FROM AT9010 WHERE Orders = 0 AND APKMaster_9000 = '''+@APKMaster+''')
		DECLARE @ScreenType VARCHAR(50) = ''2''
		DECLARE @ScreenID VARCHAR(50) = N''AT2010''
		DECLARE @ModuleID VARCHAR(50) = N''T''
		DECLARE @DocumentID VARCHAR(50) =(SELECT TOP 1 VoucherNo FROM AT9010 WHERE APKMaster_9000 = '''+@APKMaster+''')
		DECLARE @Parameters NVARCHAR(MAX) = @DocumentID
		DECLARE @UrlCustom NVARCHAR(250)=''/ViewMasterDetail2/Index/OO/OOF2350?PK={0}&Table=AT9010&key=APK&DivisionID={1}''
		DECLARE @MessageID_OOT9002 NVARCHAR(250)= (CASE WHEN '+LTRIM(@Status)+' = 1 Then ''TFML000273'' ELSE ''TFML000274'' END)
		DECLARE @Message_OOT9002 NVARCHAR(MAX) =(SELECT [Name] FROM [A00002] WHERE [ID] = @MessageID_OOT9002 AND LanguageID = ''vi-VN'')
		DECLARE @Description NVARCHAR(MAX) = REPLACE(REPLACE(@Message_OOT9002,''{0}'',@DocumentID),''{1}'','''+@UserID+''')
		DECLARE @Description_OOT9002 NVARCHAR(MAX) = NULL
		DECLARE @Title NVARCHAR(MAX)= @Description
		DECLARE @EffectDate Datetime = GETDATE()
		DECLARE @ExpiryDate Datetime = DATEADD(MONTH,1,GETDATE())
		DECLARE @ShowType INT = 0
		DECLARE @MessageType INT = 0
		DECLARE @AssignedToUserID VARCHAR(50) = (SELECT TOP 1 EmployeeID FROM AT9010 WHERE Orders = 0 AND APKMaster_9000 = '''+@APKMaster+''')
		DECLARE @Notes NVARCHAR(MAX) = ISNULL((SELECT TOP 1 Note FROM OOT9001 WHERE APK = '''+@APK+'''),'''')
		DECLARE @UserID_OOT9002 VARCHAR(50)  = ''''
		IF ISNULL(@AssignedToUserID,'''') <> '''' AND '+ LTRIM(@Status)+' <> 0
		BEGIN 
				INSERT INTO OOT9002(APK, APKMaster,ScreenType,ScreenID,ModuleID,[Parameters],UrlCustom,[Description],Title,EffectDate,ExpiryDate,CreateDate,ShowType,MessageType)
				VALUES(@APK_OOT9002,@APKMaster_OOT9002,@ScreenType,@ScreenID,@ModuleID,@Parameters,@UrlCustom,@Description,@Title,@EffectDate,@ExpiryDate,GETDATE(),@ShowType,@MessageType)

				INSERT INTO OOT9003(APKMaster,UserID, DivisionID)
				VALUES(@APK_OOT9002,@AssignedToUserID,'''+@DivisionID+''')
		END
			-- Insert thông báo duyệt cho cấp duyệt 1 khi tạo phiếu
			IF NOT EXISTS (SELECT TOP 1 1 FROM OOT9000 WITH (NOLOCK) WHERE AppoveLevel='+LTRIM(@ApprovingLevel)+' AND APK = '''+@APKMaster+''') AND '+LTRIM(@Status)+' = 0
			BEGIN
				SET @APK_OOT9002 = NEWID()
				SET @MessageID_OOT9002 =''TFML000271''
				SET @Message_OOT9002 = (SELECT [Name] FROM [A00002] WHERE [ID] = @MessageID_OOT9002 AND LanguageID = ''vi-VN'')
				SET @Description_OOT9002 = REPLACE(REPLACE(@Message_OOT9002,''{0}'',@DocumentID),''{1}'','''+@UserID+''')
			    SET @Title = @Description_OOT9002
				SET @UserID_OOT9002 = (SELECT TOP 1 ApprovePersonID FROM OOT9001 WHERE APKMaster = '''+@APKMaster+''' AND [Level] = 1)

				IF ISNULL(@UserID_OOT9002,'''') <> ''''
				BEGIN 
					INSERT INTO OOT9002(APK, APKMaster,ScreenType,ScreenID,ModuleID,[Parameters],UrlCustom,[Description],Title,EffectDate,ExpiryDate,CreateDate,ShowType,MessageType)
					VALUES(@APK_OOT9002,@APKMaster_OOT9002,@ScreenType,@ScreenID,@ModuleID,@Parameters,@UrlCustom,@Description_OOT9002,@Title,@EffectDate,@ExpiryDate,GETDATE(),@ShowType,@MessageType)

					INSERT INTO OOT9003(APKMaster,UserID, DivisionID)
					VALUES(@APK_OOT9002,@UserID_OOT9002,'''+@DivisionID+''')
				END
			END

			-- Insert thông báo duyệt cho cấp tiếp theo
			IF NOT EXISTS (SELECT TOP 1 1 FROM OOT9000 WITH (NOLOCK) WHERE AppoveLevel='+LTRIM(@ApprovingLevel)+' AND APK = '''+@APKMaster+''') AND '+LTRIM(@Status)+' = 1
			BEGIN
				SET @APK_OOT9002 = NEWID()
				SET @MessageID_OOT9002 =''TFML000271''
				SET @Message_OOT9002 = (SELECT [Name] FROM [A00002] WHERE [ID] = @MessageID_OOT9002 AND LanguageID = ''vi-VN'')
				SET @Description_OOT9002 = REPLACE(REPLACE(@Message_OOT9002,''{0}'',@DocumentID),''{1}'','''+@UserID+''')
			    SET @Title = @Description_OOT9002
				SET @UserID_OOT9002 = (SELECT TOP 1 ApprovePersonID FROM OOT9001 WHERE APKMaster = '''+@APKMaster+''' AND [Level] ='+LTRIM(@ApprovingLevel)+' +1)

				IF ISNULL(@UserID_OOT9002,'''') <> ''''
				BEGIN 
					INSERT INTO OOT9002(APK, APKMaster,ScreenType,ScreenID,ModuleID,[Parameters],UrlCustom,[Description],Title,EffectDate,ExpiryDate,CreateDate,ShowType,MessageType)
					VALUES(@APK_OOT9002,@APKMaster_OOT9002,@ScreenType,@ScreenID,@ModuleID,@Parameters,@UrlCustom,@Description_OOT9002,@Title,@EffectDate,@ExpiryDate,GETDATE(),@ShowType,@MessageType)

					INSERT INTO OOT9003(APKMaster,UserID, DivisionID)
					VALUES(@APK_OOT9002,@UserID_OOT9002,'''+@DivisionID+''')
				END
			END

			-- Insert lịch sử duyệt văn bản
			IF ISNULL(@Description,'''') <> ''''
			BEGIN 
				
				INSERT INTO OOT00003 (DivisionID,HistoryID,Description,RelatedToID,RelatedToTypeID,CreateDate,CreateUserID,StatusID)
				VALUES 
				(
					'''+@DivisionID+'''
					,''''
					, CASE WHEN ISNULL(@Notes, '''') <> '''' 
						   THEN @Description +'' : ''+ @Notes 
						   ELSE @Description 
						END
					, @APKMaster_OOT9002
					, 47
					, GETDATE()
					, '''+@UserID+'''
					, 2
				)

			END

	END'
	PRINT @SQL
	EXEC(@SQL)
END
ELSE IF ISNULL(@Type, '') IN ('VBDEN','VBDI') 
BEGIN 
	SET @Cur = CURSOR SCROLL KEYSET FOR
			   SELECT APK,[Level]
			   FROM OOT9001 WITH (NOLOCK)
			   WHERE DivisionID=@DivisionID
			   AND APKMaster=@APKMaster
			   AND ApprovePersonID=@ApprovePresonID
			   AND ( ([Level]> @ApprovingLevel AND @Status = 1) 
					OR ([Level]< @ApprovingLevel AND @Status = 2)  )
			   ORDER BY Level
	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @APKAT9001,@Level
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF (@Level <> @ApprovingLevel+1 AND @Status = 1) OR (@Level <> @ApprovingLevel-1 AND @Status = 2)
		BEGIN
			BREAK
		END
		UPDATE OOT9001 SET @ApprovingLevel=CASE WHEN @Status = 1 THEN [Level] ELSE @ApprovingLevel END,
		[Status]=@Status
		WHERE APK=@APKAT9001
		AND DivisionID=@DivisionID

		FETCH NEXT FROM @Cur INTO @APKAT9001,@Level
	END
	CLOSE @Cur
	--- Cập nhật tình trạng nếu là người duyệt cuối cùng
	SET @SQL = '
		IF EXISTS (SELECT TOP 1 1 FROM OOT9000 WITH (NOLOCK) WHERE AppoveLevel=' + LTRIM(@ApprovingLevel) + ' AND APK =''' + @APKMaster + ''' )
		BEGIN
		 	UPDATE ' + @Table + ' SET [Status] = ' + LTRIM(@Status) + '
			FROM ' + @Table + ' T1
			LEFT JOIN ' + @TableMaster + ' T2 ON T1.APKMaster = T2.APK
			WHERE T2.APKMaster_9000=''' + @APKMaster + ''' AND T1.FollowerID = ''' + @UserID + ''' AND T1.UseESign = 0
			AND T1.DivisionID =''' + @DivisionID + ''''

			IF ISNULL(@TableMaster,'') <> ''
			SET @SQL = @SQL +'
			UPDATE ' + @TableMaster + ' SET [Status] = ' + LTRIM(@Status) + '
			WHERE APKMaster_9000=''' + @APKMaster + '''
			AND DivisionID =''' + @DivisionID + ''''
		
			SET @SQL = @SQL +'
		END
		ELSE IF ' + LTRIM(@Status) + ' =2
		BEGIN
			--Cap nhat bang nghiep vu
			UPDATE ' + @Table + ' SET [Status] = ' + LTRIM(@Status) + '
			FROM ' + @Table + ' T1
			LEFT JOIN ' + @TableMaster + ' T2 ON T1.APKMaster = T2.APK
			WHERE T2.APKMaster_9000=''' + @APKMaster + ''' AND T1.FollowerID = ''' + @UserID + ''' AND T1.UseESign = 0
			AND T1.DivisionID =''' + @DivisionID + ''''

			IF ISNULL(@TableMaster,'') <> ''
			SET @SQL = @SQL +'
			UPDATE ' + @TableMaster + ' SET [Status] = ' + LTRIM(@Status) + '
			WHERE APKMaster_9000=''' + @APKMaster + '''
			AND DivisionID =''' + @DivisionID + ''''

			SET @SQL = @SQL +'
		END
		ELSE IF ' + LTRIM(@Status) + ' =1
				BEGIN
				UPDATE ' + @Table + ' SET [Status] = ' + LTRIM(@Status) + '
				FROM ' + @Table + ' T1
				LEFT JOIN ' + @TableMaster + ' T2 ON T1.APKMaster = T2.APK
				WHERE T2.APKMaster_9000=''' + @APKMaster + ''' AND T1.FollowerID = ''' + @UserID + ''' AND T1.UseESign = 0
				AND T1.DivisionID =''' + @DivisionID + ''''

				IF ISNULL(@TableMaster,'') <> ''
				SET @SQL = @SQL +'
				UPDATE ' + @TableMaster + ' SET [Status] = 0
				WHERE APKMaster_9000=''' + @APKMaster + '''AND DivisionID =''' + @DivisionID + '''
				END
			'

			--- Insert Thông báo duyệt
			IF(@Status = 1 OR @Status = 2)
			BEGIN
				-- Insert thông báo đã duyệt hoặc từ chối
				DECLARE @APK_OOT9002 VARCHAR(50) = NEWID()
				DECLARE @APKMaster_OOT9002 VARCHAR(50) = (SELECT TOP 1 APK FROM OOT2340 WHERE APKMaster_9000 = @APKMaster)
				DECLARE @ScreenType VARCHAR(50) = '2'
				DECLARE @ScreenID VARCHAR(50) = N'OOF2340'
				DECLARE @ModuleID VARCHAR(50) = N'OO'
				DECLARE @DocumentID VARCHAR(50) =(SELECT TOP 1 DocumentID FROM OOT2340 WHERE APKMaster_9000 = @APKMaster)
				DECLARE @Parameters NVARCHAR(MAX) = @DocumentID
				DECLARE @UrlCustom NVARCHAR(250)='/ViewMasterDetail2/Index/OO/OOF2342?PK={0}&Table=OOT2340&key=APK&DivisionID={1}'
				DECLARE @MessageID_OOT9002 NVARCHAR(250)= (CASE WHEN @Status = 1 Then 'OOFML000273' ELSE 'OOFML000274' END)
				DECLARE @Message_OOT9002 NVARCHAR(MAX) =(SELECT [Name] FROM [A00002] WHERE [ID] = @MessageID_OOT9002 AND LanguageID = 'vi-VN')
				DECLARE @Description NVARCHAR(MAX) = REPLACE(REPLACE(@Message_OOT9002,'{0}',@DocumentID),'{1}',@UserID)
				DECLARE @Description_OOT9002 NVARCHAR(MAX) = NULL
				DECLARE @Title NVARCHAR(MAX)= @Description
				DECLARE @EffectDate Datetime = GETDATE()
				DECLARE @ExpiryDate Datetime = DATEADD(MONTH,1,GETDATE())
				DECLARE @ShowType INT = 0
				DECLARE @MessageType INT = 0
				DECLARE @AssignedToUserID VARCHAR(50) = (SELECT TOP 1 AssignedToUserID FROM OOT2340 WHERE APKMaster_9000 = @APKMaster)
				DECLARE @Notes NVARCHAR(MAX) = ISNULL((SELECT TOP 1 Note FROM OOT9001 WHERE APK = @APK),'')

				IF ISNULL(@AssignedToUserID,'') <> ''
				BEGIN 
					INSERT INTO OOT9002(APK, APKMaster,ScreenType,ScreenID,ModuleID,[Parameters],UrlCustom,[Description],Title,EffectDate,ExpiryDate,CreateDate,ShowType,MessageType)
					VALUES(@APK_OOT9002,@APKMaster_OOT9002,@ScreenType,@ScreenID,@ModuleID,@Parameters,@UrlCustom,@Description,@Title,@EffectDate,@ExpiryDate,GETDATE(),@ShowType,@MessageType)

					INSERT INTO OOT9003(APKMaster,UserID, DivisionID)
					VALUES(@APK_OOT9002,@AssignedToUserID,@DivisionID)
				END

				-- Insert thông báo duyệt cho cấp tiếp theo
				IF NOT EXISTS (SELECT TOP 1 1 FROM OOT9000 WITH (NOLOCK) WHERE AppoveLevel=@ApprovingLevel AND APK = @APKMaster) AND @Status = 1
				BEGIN
					SET @APK_OOT9002 = NEWID()
					SET @MessageID_OOT9002 ='OOFML000271'
					SET @Message_OOT9002 = (SELECT [Name] FROM [A00002] WHERE [ID] = @MessageID_OOT9002 AND LanguageID = 'vi-VN')
					SET @Description_OOT9002 = REPLACE(REPLACE(@Message_OOT9002,'{0}',@DocumentID),'{1}',@UserID)
				    SET @Title = @Description_OOT9002
					DECLARE @UserID_OOT9002 VARCHAR(50) = (SELECT TOP 1 ApprovePersonID FROM OOT9001 WHERE APKMaster = @APKMaster AND [Level] =@ApprovingLevel +1)

					IF ISNULL(@UserID_OOT9002,'') <> ''
					BEGIN 
						INSERT INTO OOT9002(APK, APKMaster,ScreenType,ScreenID,ModuleID,[Parameters],UrlCustom,[Description],Title,EffectDate,ExpiryDate,CreateDate,ShowType,MessageType)
						VALUES(@APK_OOT9002,@APKMaster_OOT9002,@ScreenType,@ScreenID,@ModuleID,@Parameters,@UrlCustom,@Description_OOT9002,@Title,@EffectDate,@ExpiryDate,GETDATE(),@ShowType,@MessageType)

						INSERT INTO OOT9003(APKMaster,UserID, DivisionID)
						VALUES(@APK_OOT9002,@UserID_OOT9002,@DivisionID)
					END
				END

				-- Insert lịch sử duyệt văn bản
				IF ISNULL(@Description,'') <> ''
				BEGIN 
					
					INSERT INTO OOT00003 (DivisionID,HistoryID,Description,RelatedToID,RelatedToTypeID,CreateDate,CreateUserID,StatusID)
					VALUES 
					(
						@DivisionID
						,''
						, CASE WHEN ISNULL(@Notes, '') <> '' 
							   THEN @Description +' : '+ @Notes 
							   ELSE @Description 
							END
						, @APKMaster_OOT9002
						, 47
						, GETDATE()
						, @UserID
						, 2
					)

				END

			END

		--PRINT @SQL
		EXEC(@SQL)
END
ELSE
---- Đối với KHTC, YCMH, ĐHM, NS
BEGIN
	SET @Cur = CURSOR SCROLL KEYSET FOR
			   SELECT APK,[Level]
			   FROM OOT9001 WITH (NOLOCK)
			   WHERE DivisionID=@DivisionID
			   AND APKMaster=@APKMaster
			   --AND ISNULL(APKDetail, '00000000-0000-0000-0000-000000000000') = ISNULL(@APKDetail, '00000000-0000-0000-0000-000000000000')
			   AND ApprovePersonID=@ApprovePresonID
			   AND ( ([Level]> @ApprovingLevel AND @Status = 1) 
					OR ([Level]< @ApprovingLevel AND @Status = 2)  )
			   ORDER BY Level
	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @APKAT9001,@Level
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF (@Level <> @ApprovingLevel+1 AND @Status = 1) OR (@Level <> @ApprovingLevel-1 AND @Status = 2)
		BEGIN
			BREAK
		END
		UPDATE OOT9001 SET @ApprovingLevel=CASE WHEN @Status = 1 THEN [Level] ELSE @ApprovingLevel END,
		[Status]=@Status
		WHERE APK=@APKAT9001
		AND DivisionID=@DivisionID

			SET @SQL = 'UPDATE ' + @Table + ' SET ApprovingLevel = ' + LTRIM(@ApprovingLevel) + '
			WHERE APKMaster_9000 =''' + LTRIM(@APKMaster) + '''' + (CASE WHEN @Type <> 'BPC' AND @IsApproved = 0  THEN ' AND Convert(Varchar(50),APK) = ''' + @APKDetail + '''' ELSE '' END) + '
			AND DivisionID =''' + @DivisionID + '''
			AND ' + LTRIM(@Status) + ' = 1'

		EXEC(@SQL)

		FETCH NEXT FROM @Cur INTO @APKAT9001,@Level
	END
	CLOSE @Cur
	--- Cập nhật tình trạng nếu là người duyệt cuối cùng
	SET @SQL = '
		IF EXISTS (SELECT TOP 1 1 FROM ' + @Table + ' WITH (NOLOCK) WHERE ApproveLevel=' + LTRIM(@ApprovingLevel) + ' AND APKMaster_9000 =''' + @APKMaster + ''' )
		BEGIN
			UPDATE ' + @Table + ' SET [Status] = ' + LTRIM(@Status) + '
			WHERE APKMaster_9000=''' + @APKMaster + ''''+ (CASE WHEN @IsApproved = 0 THEN 'AND Convert(Varchar(50),APK) = ''' + @APKDetail + '''' ELSE '' END) +'
			AND DivisionID =''' + @DivisionID + ''''

			IF ISNULL(@TableMaster,'') <> ''
			SET @SQL = @SQL +'
			UPDATE ' + @TableMaster + ' SET [Status] = ' + LTRIM(@Status) + '
			WHERE APKMaster_9000=''' + @APKMaster + '''
			AND DivisionID =''' + @DivisionID + ''''
			
			---- Update tình trạng đơn hàng cho YCMH, DHM
			IF ISNULL(@Type,'') IN ('DHDC') AND @Status = 1
				SET @SQL = @SQL +'
				UPDATE ' + @TableMaster + ' SET [OrderStatus] = ' + LTRIM(@Status) + '
				WHERE APKMaster_9000=''' + @APKMaster + '''
				AND DivisionID =''' + @DivisionID + ''''
			ELSE IF ISNULL(@Type,'') IN ('DHDC') AND @Status != 1
				SET @SQL = @SQL +'
				UPDATE ' + @TableMaster + ' SET [OrderStatus] = 0
				WHERE APKMaster_9000=''' + @APKMaster + '''
				AND DivisionID =''' + @DivisionID + ''''
			ELSE IF ISNULL(@Type,'') IN ('DHB','PBG','YCMH','DHM','PBGNC','PBGKHCU','PBGSALE', 'DHB-SELLOUT') AND @Status = 1
				SET @SQL = @SQL +'
				UPDATE ' + @TableMaster + ' SET [OrderStatus] = 1
				,IsConfirm = ' + LTRIM(@Status) + '
				WHERE APKMaster_9000=''' + @APKMaster + '''
				AND DivisionID =''' + @DivisionID + ''''
			ELSE IF ISNULL(@Type,'') IN ('DHB','PBG','YCMH','DHM','PBGNC','PBGKHCU','PBGSALE', 'DHB-SELLOUT') AND @Status != 1
				SET @SQL = @SQL +'
				UPDATE ' + @TableMaster + ' SET [OrderStatus] = 0
				,IsConfirm = ' + LTRIM(@Status) + '
				WHERE APKMaster_9000=''' + @APKMaster + '''
				AND DivisionID =''' + @DivisionID + ''''

			---- Update IsSelectPrice cho báo giá nhà cung cấp
			IF ISNULL(@Type,'') = 'BGNCC'
			SET @SQL = @SQL +'
			Update ' + @Table + ' 
			Set IsSelectPrice = 0
			where '+LTRIM(@Status)+' = 1 AND InheritAPKDetail = (select top 1 InheritAPKDetail from POT2022 WITH (NOLOCK)
																where  APKMaster_9000=''' + @APKMaster + ''''+ (CASE WHEN @IsApproved = 0 THEN 'AND Convert(Varchar(50),APK) = ''' + @APKDetail + '''' ELSE '' END) +') 
			Update ' + @Table + ' 
			Set IsSelectPrice = '+LTRIM(@Status)+'
			where APKMaster_9000=''' + @APKMaster + ''''+ (CASE WHEN @IsApproved = 0 THEN 'AND Convert(Varchar(50),APK) = ''' + @APKDetail + '''' ELSE '' END) +''

			---- UPDATE số tiền duyệt vào bảng nghiệp vụ
			IF ISNULL(@Type,'')IN ('KHTC','NS')
			SET @SQL = @SQL +'
				UPDATE T1
				SET T1.ApprovalOAmount = T94.ApprovalOAmount,
				T1.ApprovalCAmount = T94.ApprovalCAmount
				FROM ' + @Table + ' T1 WITH (NOLOCK)
				INNER JOIN OOT9004 T94 WITH (NOLOCK) ON T94.APKDetail = T1.APK
				INNER JOIN OOT9001 T91 WITH (NOLOCK) ON T91.APK = T94.APK9001 AND T94.Level = T1.ApproveLevel
				WHERE Convert(Varchar(50),T1.APK) = ''' + @APKDetail + '''
			'

			IF ISNULL(@Type,'')IN ('TTSX') AND @Status = 1
			BEGIN
			     EXEC SOP2087 @DivisionID = @DivisionID, @UserID=@UserID,@TranMonth=@TranMonth,@TranYear=@TranYear,@InsVoucherTypeID='PXK',@APKMaster_9000=@APKMaster
			END

			

			DECLARE @BudgetAnaTypeID VARCHAR(50) 
			SELECT @BudgetAnaTypeID = BudgetAnaTypeID FROM AT0000 WHERE DefDivisionID = @DivisionID
			IF ISNULL(@Type,'') = 'NS' AND ISNULL(@BudgetAnaTypeID,'') <> '' AND ISNULL(@TableMaster,'') <> ''
				BEGIN 
					SET @SQL = @SQL +'
					DECLARE @VoucherNo VARCHAR(50)
					SET @VoucherNo = (SELECT TOP 1 T1.VoucherNo
					FROM ' + @TableMaster + ' T1 WITH (NOLOCK)
					WHERE T1.APKMaster_9000=''' + @APKMaster + '''
					AND T1.DivisionID =''' + @DivisionID + ''')

					IF NOT EXISTS (SELECT TOP 1 1 FROM AT1011 WITH (NOLOCK) WHERE DivisionID = ''' + @DivisionID + ''' AND AnaID = @VoucherNo AND AnaTypeID = '''+@BudgetAnaTypeID+''')
					INSERT INTO AT1011 (DivisionID,AnaID,AnaTypeID,AnaName,Notes,CreateDate,CreateUserID,LastModifyDate,LastModifyUserID,Disabled)
					SELECT ''' + @DivisionID + ''',T1.VoucherNo, '''+@BudgetAnaTypeID+''', T2.AnaName, T1.Description, GETDATE(), '''+@UserID+''', GETDATE(), '''+@UserID+''', 0 
					FROM ' + @TableMaster + ' T1
					LEFT JOIN AT1011 T2 WITH (NOLOCK) ON T1.DepartmentID = T2.AnaID AND T2.AnaTypeID = (SELECT DepartmentAnaTypeID FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = ''' + @DivisionID + ''')
					WHERE T1.APKMaster_9000=''' + @APKMaster + '''
					AND T1.DivisionID =''' + @DivisionID + '''
					'
					
				END
			IF ISNULL(@Type,'')IN ('DHB','DHB-SELLOUT') AND @Status = 2
			SET @SQL = @SQL +'
				DELETE CIT1530 
				FROM CIT1530
				LEFT JOIN OT2001 ON CIT1530.SOrderID = OT2001.VoucherNo
				WHERE OT2001.APKMaster_9000 = ''' + @APKMaster +'''
			'


			SET @SQL = @SQL +'
		END
		ELSE IF ' + LTRIM(@Status) + ' =2
		BEGIN
			--Cap nhat bang nghiep vu
			UPDATE ' + @Table + ' SET [Status] = ' + LTRIM(@Status) + '
			WHERE APKMaster_9000=''' + @APKMaster + '''' + (CASE WHEN @Type <> 'BPC' AND @IsApproved = 0 THEN ' AND Convert(Varchar(50),APK) = ''' + @APKDetail + '''' ELSE '' END) + '
			AND DivisionID =''' + @DivisionID + ''''

			IF ISNULL(@TableMaster,'') <> ''
			SET @SQL = @SQL +'
			UPDATE ' + @TableMaster + ' SET [Status] = ' + LTRIM(@Status) + '
			WHERE APKMaster_9000=''' + @APKMaster + '''
			AND DivisionID =''' + @DivisionID + ''''

			SET @SQL = @SQL +'
		END
		ELSE IF ' + LTRIM(@Status) + ' =1
				BEGIN
				UPDATE ' + @Table + ' SET [Status] = 0 WHERE APKMaster_9000=''' + @APKMaster + '''' + (CASE WHEN @Type <> 'BPC' AND @IsApproved = 0 THEN ' AND Convert(Varchar(50),APK) = ''' + @APKDetail + '''' ELSE '' END) + '
				'
				IF ISNULL(@TableMaster,'') <> ''
				SET @SQL = @SQL +'
				UPDATE ' + @TableMaster + ' SET [Status] = 0
				WHERE APKMaster_9000=''' + @APKMaster + '''AND DivisionID =''' + @DivisionID + '''
				END
			'
			If (@Type in ('YCMH', 'DHB', 'DT') and @CustomerIndex = 117)-- MaiThu 
				-- Insert thông báo duyệt cho cấp tiếp theo
				IF NOT EXISTS (SELECT TOP 1 1 FROM OOT9000 WITH (NOLOCK) WHERE AppoveLevel=@ApprovingLevel AND APK = @APKMaster) AND @Status = 1
				BEGIN
					DECLARE @APK_OOT9002N VARCHAR(50) = NEWID()
					DECLARE @EffectDateN Datetime = GETDATE()
					DECLARE @ExpiryDateN Datetime = DATEADD(MONTH,1,GETDATE())
					DECLARE @ShowTypeN INT = 0
					DECLARE @MessageTypeN INT = 0

					DECLARE @APKMaster_OOT9002N VARCHAR(50) = NEWID(),
							@ScreenTypeN VARCHAR(50) = '',
							@ScreenIDN VARCHAR(50) = '',
							@ModuleIDN VARCHAR(50) = '',
							@VoucherNoN VARCHAR(50) ='',
							@ParametersN NVARCHAR(MAX) = '',
							@UrlCustomN NVARCHAR(250)='',
							@MessageID_OOT9002N NVARCHAR(250)= '',
							@Message_OOT9002N NVARCHAR(MAX) ='',
							@Description_OOT9002N NVARCHAR(MAX) = '',
							@TitleN NVARCHAR(MAX)= '',
							@pkN VARCHAR(50)= '',
							@UserID_OOT9002N NVARCHAR(MAX) = ''

					IF ISNULL(@Type,'') IN ('YCMH')
					BEGIN
					    SET @APKMaster_OOT9002N = (SELECT TOP 1 APK FROM OT3101 WHERE APKMaster_9000 = @APKMaster)
						SET @ScreenTypeN = '2'
						SET @ScreenIDN = N'POF2030'
						SET @ModuleIDN = N'PO'
						SET @VoucherNoN =(SELECT TOP 1 VoucherNo FROM OT3101 WHERE APKMaster_9000 = @APKMaster)
						SET @ParametersN = @VoucherNoN
						SET @pkN = (SELECT TOP 1 ROrderID FROM OT3101 WHERE APKMaster_9000 = @APKMaster)
						SET @UrlCustomN ='/ViewMasterDetail2/Index/PO/POF2032?PK='+@pkN+'&Table=OT3101&key=ROrderID&DivisionID='+@DivisionID
						SET @MessageID_OOT9002N = N'POFML000012'
					END
					ELSE IF ISNULL(@Type,'') IN ('DHB')
					BEGIN
						SET @APKMaster_OOT9002N = (SELECT TOP 1 APK FROM OT2001 WHERE APKMaster_9000 = @APKMaster)
						SET @ScreenTypeN = '2'
						SET @ScreenIDN = N'SOF2000'
						SET @ModuleIDN = N'SO'
						SET @VoucherNoN =(SELECT TOP 1 VoucherNo FROM OT2001 WHERE APKMaster_9000 = @APKMaster)
						SET @ParametersN = @VoucherNoN
						SET @pkN = (SELECT TOP 1 SOrderID FROM OT2001 WHERE APKMaster_9000 = @APKMaster)
						SET @UrlCustomN ='/ViewMasterDetail2/Index/SO/SOF2002?PK='+@pkN+'&Table=OT2001&key=SOrderID&DivisionID='+@DivisionID
						SET @MessageID_OOT9002N = N'SOFML000036'
					END
					ELSE IF ISNULL(@Type,'') IN ('DT')
					BEGIN
						SET @APKMaster_OOT9002N = (SELECT TOP 1 APK FROM CRMT2110 WHERE APKMaster_9000 = @APKMaster)
						SET @ScreenTypeN = '2'
						SET @ScreenIDN = N'CRMF2110'
						SET @ModuleIDN = N'CRM'
						SET @VoucherNoN =(SELECT TOP 1 VoucherNo FROM CRMT2110 WHERE APKMaster_9000 = @APKMaster)
						SET @ParametersN = @VoucherNoN
						SET @UrlCustomN ='/ViewMasterDetail2/Index/CRM/CRMF2112?PK={0}&Table=CRMT2110&key=APK&DivisionID={1}'
						SET @MessageID_OOT9002N = N'CRMFML000066'
					END
					
					SET @Message_OOT9002N =(SELECT [Name] FROM [A00002] WHERE [ID] = @MessageID_OOT9002N AND LanguageID = 'vi-VN')
					SET @Description_OOT9002N = REPLACE(@Message_OOT9002N,'{0}',@VoucherNoN)
					SET @TitleN = @Description_OOT9002N
					SET @UserID_OOT9002 = (SELECT TOP 1 ApprovePersonID FROM OOT9001 WHERE APKMaster = @APKMaster AND [Level] =@ApprovingLevel +1)

					IF ISNULL(@UserID_OOT9002,'') <> '' and ISNULL(@APK_OOT9002N,'') <> '' and ISNULL(@APKMaster_OOT9002N,'') <> ''
					BEGIN 
						INSERT INTO OOT9002(APK, APKMaster,ScreenType,ScreenID,ModuleID,[Parameters],UrlCustom,[Description],Title,EffectDate,ExpiryDate,CreateDate,ShowType,MessageType)
						VALUES(@APK_OOT9002N,@APKMaster_OOT9002N,@ScreenTypeN,@ScreenIDN,@ModuleIDN,@ParametersN,@UrlCustomN,@Description_OOT9002N,@TitleN,@EffectDateN,@ExpiryDateN,GETDATE(),@ShowTypeN,@MessageTypeN)

						INSERT INTO OOT9003(APKMaster,UserID, DivisionID)
						VALUES(@APK_OOT9002N,@UserID_OOT9002,@DivisionID)
					END
				END
EXEC(@SQL)
--PRINT @SQL

END
END
--tăng tốc độ
SET NOCOUNT OFF





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
