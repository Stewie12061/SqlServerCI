IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2131]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2131]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----<Summary>
----Kiểm tra xóa sửa quy trình sản xuất.
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Create by>: Văn Tài ON 03/07/2023
---- <Example>
---	exec MP2131 @DivisionID=N'MT', @APK=N'', @APKList=N'29cad19c-4b4f-468d-9371-cb38607ccf06', @Mode=1 

CREATE PROCEDURE [dbo].[MP2131] (
	@DivisionID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@APK VARCHAR(50),
	@APKList NVARCHAR(MAX),
	@Mode TINYINT
	)
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)

	IF @Mode = 0 ---Sửa
	BEGIN

		SET @sSQL = '
		CREATE TABLE #MP2131_Errors 
		(
			APK Varchar(50)
			, RoutingID VARCHAR(50)
			, MessageID VARCHAR(50)		
			, Params VARCHAR(MAX)
		)
		SELECT APK
		, DivisionID
		, RoutingID
		INTO #MP2131
		FROM MT2130 MT30 WITH (NOLOCK)
		WHERE 
			MT30.DivisionID = ''' + @DivisionID + '''
			AND MT30.APK IN (''' + @APKList + ''')
	
		IF EXISTS (
					SELECT TOP 1 1
					FROM MT2120 MT20 WITH (NOLOCK)
					INNER JOIN #MP2131 MT30 WITH (NOLOCK) ON MT20.RoutingID = MT30.RoutingID
					WHERE 
						MT20.DivisionID = ''' + @DivisionID + '''
				)
		BEGIN 

			---- {0} này đã được sử dụng. Bạn không thể Sửa / Xóa
			INSERT INTO #MP2131_Errors 
			(
				APK
				, RoutingID
				, MessageID
				, Params
			)
			SELECT 	MT30.APK
					, MT30.RoutingID AS RoutingID
					, ''00ML000052'' AS MessageID
					, MT30.RoutingID AS Params
			FROM MT2120 MT20 WITH (NOLOCK)
			INNER JOIN #MP2131 MT30 WITH (NOLOCK) ON MT20.RoutingID = MT30.RoutingID
			WHERE 
				MT20.DivisionID = ''' + @DivisionID + '''

		END		

		---- Nếu có vấn đề.
		IF EXISTS (SELECT TOP 1 1 FROM #MP2131_Errors)
		BEGIN
			SELECT 2 AS Status
			, MessageID
			, Params AS Params
			FROM #MP2131_Errors T1
		END

		'

		PRINT (@sSQL)
		EXEC (@sSQL)
	END
	ELSE
	IF @Mode = 1 ---Xóa
	BEGIN
		SET @sSQL = '
		CREATE TABLE #MP2131_Errors 
		(
			APK Varchar(50)
			, RoutingID VARCHAR(50)
			, MessageID VARCHAR(50)		
			, Params VARCHAR(MAX)
		)

		SELECT APK
		, DivisionID
		, RoutingID
		INTO #MP2131
		FROM MT2130 MT30 WITH (NOLOCK)
		WHERE 
			MT30.DivisionID = ''' + @DivisionID + '''
			AND MT30.APK IN (''' + @APKList + ''')
	
		IF EXISTS (
					SELECT TOP 1 1
					FROM MT2120 MT20 WITH (NOLOCK)
					INNER JOIN #MP2131 MT30 WITH (NOLOCK) ON MT20.RoutingID = MT30.RoutingID
					WHERE 
						MT20.DivisionID = ''' + @DivisionID + '''
				)
		BEGIN 

			---- {0} này đã được sử dụng. Bạn không thể Sửa / Xóa
			INSERT INTO #MP2131_Errors 
			(
				APK
				, RoutingID
				, MessageID
				, Params
			)
			SELECT 	MT30.APK
					, MT30.RoutingID AS RoutingID
					, ''00ML000052'' AS MessageID
					, MT30.RoutingID AS Params
			FROM MT2120 MT20 WITH (NOLOCK)
			INNER JOIN #MP2131 MT30 WITH (NOLOCK) ON MT20.RoutingID = MT30.RoutingID
			WHERE 
				MT20.DivisionID = ''' + @DivisionID + '''

		END		

		IF NOT EXISTS (SELECT TOP 1 1 FROM #MP2131_Errors)
		BEGIN
			
			DELETE MT30
			FROM MT2130 MT30 WITH (NOLOCK)
			INNER JOIN #MP2131 MT31 ON MT31.DivisionID = MT30.DivisionID
										AND MT31.RoutingID = MT30.RoutingID

		END
		ELSE
		BEGIN
			SELECT 2 AS Status
			, MessageID
			, Params AS Params
			FROM #MP2131_Errors T1
		END

		'
		PRINT (@sSQL)
		EXEC (@sSQL)

	END
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
