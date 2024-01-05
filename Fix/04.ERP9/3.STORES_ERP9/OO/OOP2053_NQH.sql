IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2053_NQH]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2053_NQH]
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
--- Modified on 26/10/2020 by Hoài Phong: Tách SP cho NQH
--- Modified on 17/05/2021 by Văn Tài: Tách store để tính cho loại đơn Điều chuyển tạm thời.
--- Modified on 14/01/2022 by Kiều Nga: Fix lỗi hiển thị sai tình trạng phiếu khi đã duyệt phiếu Yêu cầu mua hàng
--- Modified on .. by ...:
/*-- <Example>
exec OOP2053_NQH @APKMaster='5A3CE2DD-D286-4F5E-BF5F-058EDB714DB6',
@TranMonth=2,@TranYear=2016,@Type=N'DXRN',@APK='2E728BDC-E154-4CF5-ADF3-44A890E07910',@DivisionID=N'MK',@UserID=N'000004'
----*/

CREATE PROCEDURE OOP2053_NQH
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

--tăng tốc độ
SET NOCOUNT ON;

SELECT @ApprovingLevel = LEVEL
		, @Status = STATUS
		, @ApprovePresonID = ApprovePersonID
FROM OOT9001 WITH (NOLOCK)
WHERE DivisionID = @DivisionID
AND APK = @APK

IF(@Type = 'DCTT')
BEGIN
	EXEC OOP2053_NQH_DCTT
		@DivisionID = @DivisionID,
		@UserID = @UserID,
		@TranMonth = @TranMonth,
		@TranYear = @TranYear,
		@APKMaster = @APKMaster,
		@APK = @APK,
		@Type = @Type,
		@APKDetail = @APKDetail,
		@Table = @Table,
		@TableMaster = @TableMaster,
		@IsApproved = @IsApproved
END 

IF ISNULL(@Type,'') IN ('DXP', 'DXDC', 'DXLTG', 'DXBSQT', 'DXRN', 'KHTD', 'QDTD')
	BEGIN
		-- Nếu là trường hợp duyệt hàng loạt thì không xử lý
		IF @IsApproved <> 1
		BEGIN
			print ('APKMaster: ' + @APKMaster)

			--cập nhật đệ quy
			SET @Cur = CURSOR SCROLL KEYSET FOR
					   SELECT APK,[Level]
					   FROM OOT9001 WITH (NOLOCK)
					   WHERE DivisionID= @DivisionID
					   AND APKMaster= @APKMaster
					   AND ISNULL(APKDetail, '00000000-0000-0000-0000-000000000000') = ISNULL(@APKDetail, '00000000-0000-0000-0000-000000000000')
					   AND ApprovePersonID=@ApprovePresonID
					   AND ( ([Level]> @ApprovingLevel AND @Status = 1) 
								OR ([Level]< @ApprovingLevel AND @Status = 2)  
						   )
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
				[Status] = @Status
				WHERE APK = @APKAT9001
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

			IF ''' + @Type + ''' <> ''DXLTG''
			BEGIN
			UPDATE ' + @Table + ' SET [Status] = ' + LTRIM(@Status) + '
			WHERE APKMaster=''' + @APKMaster + '''' + (CASE WHEN @Type <> 'BPC' THEN ' AND Convert(Varchar(50),APK) = ''' + @APKDetail + '''' ELSE '' END) + '
			AND DivisionID =''' + @DivisionID + '''
			END
			-- cap nhat xuong HRM neu duyet thanh cong
			IF ''' + @Type + ''' <> ''QDTD''
			BEGIN
				print (''Cap nhat ca tu OOP2053.'')

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
			IF ''' + @Type + ''' <> ''DXLTG''
			BEGIN
			--Cap nhat bang nghiep vu
			UPDATE ' + @Table + ' SET [Status] = ' + LTRIM(@Status) + '
			WHERE APKMaster=''' + @APKMaster + '''' + (CASE WHEN @Type <> 'BPC' THEN ' AND Convert(Varchar(50),APK) = ''' + @APKDetail + '''' ELSE '' END) + '
			AND DivisionID =''' + @DivisionID + '''
			END
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

				IF ''' + @Type + ''' <> ''DXLTG''
			BEGIN
				--Cap nhat bang nghiep vu
				UPDATE ' + @Table + ' SET [Status] = 0 WHERE APKMaster=''' + @APKMaster + '''' + (CASE WHEN @Type <> 'BPC' THEN ' AND Convert(Varchar(50),APK) = ''' + @APKDetail + '''' ELSE '' END) + '
				END
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
			ELSE IF ISNULL(@Type,'') IN ('DHB','PBG','YCMH','DHM','PBGNC','PBGKHCU','PBGSALE') AND @Status = 1
				SET @SQL = @SQL +'
				UPDATE ' + @TableMaster + ' SET [OrderStatus] = 1
				,IsConfirm = ' + LTRIM(@Status) + '
				WHERE APKMaster_9000=''' + @APKMaster + '''
				AND DivisionID =''' + @DivisionID + ''''
			ELSE IF ISNULL(@Type,'') IN ('DHB','PBG','YCMH','DHM','PBGNC','PBGKHCU','PBGSALE') AND @Status != 1
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

EXEC(@SQL)
--PRINT @SQL

END

--tăng tốc độ
SET NOCOUNT OFF





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
