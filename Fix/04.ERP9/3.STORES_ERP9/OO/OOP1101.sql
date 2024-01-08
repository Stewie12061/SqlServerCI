IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1101]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load dữ liệu Quản lý văn bản - xem chi tiết.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
--
-- <History>
---- Created on 05/08/2022 by Đức Tuyên
-- <Example> 

CREATE PROCEDURE [dbo].[OOP1101]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50), 
	 @APK VARCHAR(50),
	 @Mode INT,
	 @PageNumber INT = 1,
	 @PageSize INT = 100,
	 @TableID VARCHAR(50) = N'CIT1210',
	 @APKList VARCHAR(MAX) = NULL,
	 @IsDisable INT = 0
)
AS 
	DECLARE @sSQL NVARCHAR (MAX) = N'',
     		@OrderBy NVARCHAR(MAX) = N'', 
			@sWhere NVARCHAR(MAX),
			@TotalRow NVARCHAR(50) = N'',
			@sSQLPermission NVARCHAR(MAX) = '',
			@GroupID NVARCHAR(250),
			@CreateUserID VARCHAR(50)

	IF @Mode = 1 -- Kiểm tra và xóa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelAPKID VARCHAR(50),
						@DelGroupID NVARCHAR(250),
						@DelCreateUserID VARCHAR(50) 
				DECLARE @OOT1101Temp TABLE (
						Status TINYINT,
						MessageID VARCHAR(100),
						Params NVARCHAR(4000)) 
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @OOT1101Temp (	Status, MessageID, Params) 
											SELECT NULL AS Status, ''00ML000055'' AS MessageID, NULL AS Params 
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, GroupID, CreateUserID FROM CIT1210 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelGroupID, @DelCreateUserID 
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@DelDivisionID NOT IN (''@@@'', ''' + @DivisionID + ''') OR @DelDivisionID IS NULL)
						UPDATE @OOT1101Temp SET Status = 2  WHERE MessageID = ''00ML000055''
					ELSE 
						BEGIN
							DELETE FROM CIT1210 WHERE GroupID = @DelGroupID AND CreateUserID = @DelCreateUserID 
							SET @Status = 0 
						END					
					FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelGroupID, @DelCreateUserID
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params FROM @OOT1101Temp WHERE Status IS NOT NULL'
	END

	IF @Mode = 3 -- Load Master
	BEGIN
		SET @sSQL = N' SELECT TOP 1		M.*
									  , A1.FullName AS CreateUserName
			FROM CIT1210 M WITH (NOLOCK)
				LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID
			WHERE M.DivisionID = ''' + @DivisionID + ''' 
			AND CONVERT(NVARCHAR(50), M.APK) = ''' + @APK + ''' 
		'

	END

	IF @Mode = 4 -- Load Grid Details
	BEGIN

		SET @OrderBy = N'M.CreateDate'
		SET @TotalRow = 'COUNT(*) OVER ()'

		SELECT TOP 1 @GroupID = ISNULL(GroupID, ''), @CreateUserID = ISNULL(CreateUserID, '') FROM CIT1210 WHERE CONVERT(NVARCHAR(50),APK) = @APK 

		SET @sSQL = @sSQL + N'
			SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum
				  , ' + @TotalRow + ' AS TotalRow
				  , A1.EmployeeID
				  , A1.FullName AS EmployeeName
				  , A2.DepartmentName
				  , A1.Address
				  , A1.Tel
				  , A1.Email
			FROM CIT1210 M WITH (NOLOCK)
				LEFT JOIN AT1103 A1		WITH (NOLOCK) ON A1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') 
														AND A1.EmployeeID = M.UserMarkedID 
				LEFT JOIN AT1102 A2		WITH (NOLOCK) ON A2.DivisionID IN (A1.DivisionID,''@@@'') 
														AND A1.DepartmentID = A2.DepartmentID AND A2.Disabled = 0
			WHERE	M.GROUPID = ''' + @GroupID + ''' 
					AND M.CREATEUSERID = ''' + @CreateUserID + ''' 
			ORDER BY ' + @OrderBy + ''
			IF @PageSize != -1
			BEGIN
				SET @sSQL = @sSQL + N' OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
				FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
			END

	END

	--PRINT(@sSQL)
	EXEC (@sSQLPermission + @sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
