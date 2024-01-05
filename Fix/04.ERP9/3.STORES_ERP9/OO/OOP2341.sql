IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2341]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2341]
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
---- Created  on 14/05/2022 by Văn Tài
---- Modified on 19/05/2022 by Văn Tài - Bổ sung load dữ liệu đính kèm Văn bản ký.
---- Modified on 19/05/2022 by Kiều Nga - Chỉnh sửa load dữ liệu khi mở từ màn hình duyệt
---- Modified on 08/06/2022	by Văn Tài	- Xử lý lấy tên nơi lưu bảng cứng.
---- Modified on 22/06/2022	by Văn Tài	- Xử lý gọi store xóa.
---- Modified on 23/06/2022	by Văn Tài	- Xử lý gọi store xóa và cập nhật cờ Delete qua OOT9000.
---- Modified on 28/06/2022	by Văn Tài	- Store xử lý kiểm tra quyền xóa, sửa.
---- Modified on 13/06/2022	by Đức Tuyên	- Điều chỉnh Check box Văn bản nội bộ: 1=>(Có), 0=>(Không)
-- <Example> EXEC KPIP2030 @DivisionID = 'DTI', @DivisionIDList = '', @UserID = 'TANLOC', @PageNumber='1', @PageSize='25','VANTOAI',0,0

CREATE PROCEDURE [dbo].[OOP2341]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50), 
	 @APK VARCHAR(50),
	 @Mode INT,
	 @PageNumber INT = 1,
	 @PageSize INT = 100,
	 @TableID VARCHAR(50) = N'OOT2340',
	 @APKList VARCHAR(MAX) = NULL,
	 @IsDisable INT = 0
)
AS 
	DECLARE @sSQL NVARCHAR (MAX) = N'',
     		@OrderBy NVARCHAR(MAX) = N'', 
			@sWhere NVARCHAR(MAX),
			@TotalRow NVARCHAR(50) = N'',
			@sSQLPermission NVARCHAR(MAX) = ''

	IF(ISNULL(@APKList, '') <> '' AND @Mode != 4)
		SET @Mode = 3

	IF @Mode = 0 -- Load Master
	BEGIN
		SET @sSQL = N' SELECT TOP 1		M.*
									  , OT90.Description AS DocumentTypeName
									  , OT92.Description AS StatusName
									  , OT91.Description AS SignedStatusName
									  , OT93.Description AS InternalDescription
									  , A1.FullName AS AssignedToUserName
									  , A2.FullName AS DecidedToUserName
									  , A3.DepartmentName AS HardStoreDepartmentName
			FROM OOT2340 M WITH (NOLOCK)
				LEFT JOIN OOT0099 OT90 WITH (NOLOCK) ON OT90.CodeMaster = N''OOF2340.DocumentType'' AND OT90.ID = M.DocumentTypeID
				LEFT JOIN OOT0099 OT91 WITH (NOLOCK) ON OT91.CodeMaster = N''OOF2340.SignedStatus'' AND OT91.ID = M.SignedStatus
				LEFT JOIN OOT0099 OT92 WITH (NOLOCK) ON OT92.CodeMaster = N''Status'' AND OT92.ID = M.Status
				LEFT JOIN OOT0099 OT93 WITH (NOLOCK) ON OT93.CodeMaster = N''OOF2340.IsInternal'' AND OT93.ID = ISNULL(M.IsInternal, 0)
				LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.AssignedToUserID
				LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = M.DecidedToUserID
				LEFT JOIN AT1102 A3	WITH (NOLOCK) ON A3.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND A3.DepartmentID = M.HardStoreDepartmentID
			WHERE M.DivisionID = ''' + @DivisionID + ''' 
			AND CONVERT(NVARCHAR(50), M.APK) = ''' + @APK + ''' OR CONVERT(NVARCHAR(50),M.APKMaster_9000) = ''' + @APK + ''' 
			AND ISNULL(M.DeleteFlg, 0) = 0
		'

	END

	IF @Mode = 1 -- Load Grid Details
	BEGIN

		SET @OrderBy = N'M.Steps'
		IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

		SET @sSQL = @sSQL + N'
			SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum
				  , ' + @TotalRow + ' AS TotalRow
				  , M.*
				  , A1.FullName AS FollowerName
				  , OT92.Description AS StatusName
				  , OT91.Description AS SignedStatusName
				  , H2.DutyName AS DutyName
				  , A1.EContractAccount
			FROM OOT2341 M WITH (NOLOCK)
			LEFT JOIN OOT0099 OT91	WITH (NOLOCK) ON OT91.CodeMaster = N''OOF2340.SignedStatus'' AND OT91.ID = M.SignedStatus
			LEFT JOIN OOT0099 OT92	WITH (NOLOCK) ON OT92.CodeMaster = N''Status'' AND OT92.ID = ISNULL(M.Status, 0)
			LEFT JOIN AT1103 A1		WITH (NOLOCK) ON A1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND A1.EmployeeID = M.FollowerID
			LEFT JOIN HT1102 H2		WITH (NOLOCK) ON H2.DivisionID = M.DivisionID AND H2.DutyID = M.DutyID
			LEFT JOIN OOT2340 M1	WITH (NOLOCK) ON M.DivisionID = M1.DivisionID AND M1.APK = M.APKMaster
			WHERE M.DivisionID = ''' + @DivisionID + ''' 
					AND CONVERT(NVARCHAR(50), M.APKMaster) = ''' + @APK + ''' OR CONVERT(NVARCHAR(50),M1.APKMaster_9000) = ''' + @APK + ''' 
			ORDER BY ' + @OrderBy + '
			OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
			FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

	END

	IF @Mode = 2 -- Load Grid đính kèm văn bản ký.
	BEGIN

		SET @OrderBy = N'M.CreateDate'
		IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

		SET @sSQL = @sSQL + N'
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum
			  , ' + @TotalRow + ' AS TotalRow
			  ,	M.APK
			  , M.DivisionID
			  , M.DocumentID
			  , M.AttachID
			  , M.AttachFile
			  , M.AttachName
			  , M.IsDelete
			  , M.CreateDate
			  , A1.FullName AS CreateUserID 
			  , M.LastModifyDate
			  , M.LastModifyUserID
		  FROM OOT2342 M WITH (NOLOCK)
		  LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND A1.EmployeeID = M.CreateUserID
		  WHERE M.DivisionID = ''' + @DivisionID + ''' 
					AND CONVERT(NVARCHAR(50), M.RelatedToID) = ''' + @APK + ''' 
					AND ISNULL(M.IsDelete, 0) = 0
		  ORDER BY ' + @OrderBy + '
			OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
			FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY 
		'

	END

	-- 3: Xóa, 4: Kiểm tra Xóa/Sửa.
	IF @Mode = 3 OR @Mode = 4
	BEGIN

		SELECT [Value]
		INTO #OOP2341APK
		FROM StringSplit (@APKList, ''',''' )
		WHERE LEN([Value]) > 10

		-- Đơn đã được duyệt không thể sửa xóa.
		SELECT 1 AS Status, '00ML000117' AS MessageID, OT40.DocumentID AS Params
		INTO #OOP2341
		FROM OOT2340 OT40 WITH (NOLOCK)
		INNER JOIN #OOP2341APK OT401 ON OT401.Value = OT40.APK
		WHERE ISNULL(OT40.Status, 0) = 1
			AND EXISTS (SELECT TOP 1 1 FROM OOT2341 WITH (NOLOCK) WHERE OOT2341.APKMaster = OT40.APK)

		IF NOT EXISTS (SELECT TOP 1 1 FROM #OOP2341)
			AND @Mode = 3
		BEGIN
			UPDATE OT40
			SET OT40.DeleteFlg = 1
			FROM OOT2340 OT40
			INNER JOIN #OOP2341APK OT401 ON OT401.Value = OT40.APK

			UPDATE OT90
			SET OT90.DeleteFlag = 1
			FROM OOT9000 OT90 WITH (NOLOCK)
			INNER JOIN OOT2340 OT40 WITH (NOLOCK) ON OT40.DivisionID = OT90.DivisionID AND OT40.DocumentID = OT90.ID
			INNER JOIN #OOP2341APK OT401 ON OT401.Value = OT40.APK
			
			DELETE OT03
			FROM OOT9003 OT03
			INNER JOIN OOT9002 OT02 ON OT02.APK = OT03.APKMaster
			INNER JOIN #OOP2341APK OT401 ON OT401.Value =  CAST(OT02.APKMaster AS VARCHAR(50)) 

			DELETE OT02
			FROM OOT9002 OT02
			INNER JOIN #OOP2341APK OT401 ON OT401.Value =  CAST(OT02.APKMaster AS VARCHAR(50)) 
		END

		SELECT * FROM #OOP2341
	END
		
	PRINT(@sSQLPermission + @sSQL)
	EXEC (@sSQLPermission + @sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

