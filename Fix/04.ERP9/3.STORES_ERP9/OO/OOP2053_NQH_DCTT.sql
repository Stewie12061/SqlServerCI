IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2053_NQH_DCTT]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2053_NQH_DCTT]
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
--- Modified on .. by ...:
/*-- <Example>
exec OOP2053_NQH @APKMaster='5A3CE2DD-D286-4F5E-BF5F-058EDB714DB6',
@TranMonth=2,@TranYear=2016,@Type=N'DXRN',@APK='2E728BDC-E154-4CF5-ADF3-44A890E07910',@DivisionID=N'MK',@UserID=N'000004'
----*/

CREATE PROCEDURE OOP2053_NQH_DCTT
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

print ('OOP2053_NQH_DCTT EXEC')
--print ('@Table ' + @Type)
--print ('@APKMaster ' + ISNULL(@APKMaster, ''))
--print ('@APK_OOT9001 ' + ISNULL(@APK, ''))
--print ('@APKDetails ' + ISNULL(@APKDetail, ''))
--print ('@Status ' + STR(@Status))
--print ('@Type ' + @Type)

IF ISNULL(@Type,'') IN ('DCTT')
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
				WHERE APK =''' + LTRIM(@APKMaster) + '''
				AND DivisionID =''' + @DivisionID + '''
				AND ' + LTRIM(@Status) + ' = 1'
	
				EXEC(@SQL)

				FETCH NEXT FROM @Cur INTO @APKAT9001,@Level
			END
			CLOSE @Cur
		END

		--- Cập nhật tình trạng nếu là người duyệt cuối cùng
		SET @SQL = '
		IF EXISTS (SELECT TOP 1 1 FROM ' + @Table + ' WITH (NOLOCK) 
								  WHERE ApproveLevel=' + LTRIM(@ApprovingLevel) + ' AND APKMaster =''' + @APKMaster + ''')
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

--tăng tốc độ
SET NOCOUNT OFF


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
