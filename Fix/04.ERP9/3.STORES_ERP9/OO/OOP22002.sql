IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP22002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP22002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---		Load danh sách thông báo cảnh báo (OOP22002)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Hoài Bảo, Date: 15/02/2022
----Modified by: Hoài Bảo, Date: 23/02/2022 - Cập nhật điều kiện kiểm tra người tạo thông báo
----Modified by: Hoài Bảo, Date: 08/06/2022 - Cập nhật điều kiện search theo ngày, theo kỳ, theo DivisionID
----Modified by: Văn Tài,  Date: 19/12/2022 - Xử lý trường hợp từ ngày đến ngày bị chậm vì mang vào điều kiện Where để convert khi so sánh từng dòng.
----Modified by: Hoài Thanh,  Date: 09/02/2023 - Bổ sung lọc division '@@@' để lấy thông báo từ Ao đầu mối.
----Modified by: Hoài Thanh,  Date: 08/08/2023 - Điều chỉnh điều kiện lấy đúng thông báo của UserID.
----Modified by: Hoàng Long,  Date: 16/11/2023 - Cập nhật - [2023/09/TA/0074] - PAN GLOBE_Bổ sung thiết lập trên hệ thống thông báo trước 2 ngày so với hạn giao hàng ở tiến đồ nhận hàng 
/* <Example>
EXEC OOP22002 @UserID=N'ASOFTADMIN', @LanguageID=N'vi-VN', @ScreenID=N'', @CreateUserName=N'',
	@Description=N'', @MessageType=N'0', @IsRead=N'0', @RecordNumber=N'', @IsPeriod=0
	@FromDate='2022-02-01 00:00:00', @ToDate='2022-02-15 00:00:00', @PeriodIDList=NULL
*/
 CREATE PROCEDURE OOP22002
(
	@DivisionID VARCHAR(50),
 	@UserID VARCHAR(50),
    @LanguageID VARCHAR(50),
	@ScreenID VARCHAR(50),
	@CreateUserName NVARCHAR(500),
	@Description NVARCHAR(MAX),
	@MessageType NVARCHAR(50),
	@IsRead NVARCHAR(50),
    @RecordNumber VARCHAR(50),
	@IsPeriod INT, -- 1:Theo kỳ; 0:Theo ngày
    @FromDate DATETIME,
    @ToDate DATETIME,
	@PeriodIDList NVARCHAR(MAX)
)
AS
DECLARE @sSQL01 NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@TopSelect NVARCHAR(500),
		@sSQLjoin NVARCHAR (MAX),
        @sDeclare NVARCHAR(MAX) = '',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20),
		@CustomerName INT

      	SET @sWhere = ''
	    SET @OrderBy = 'M.CreateDate DESC'
		SET @TopSelect = ''
		SET @sSQLjoin = ''
		SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
		SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

	SET @sWhere = @sWhere + ' N.DivisionID IN (''@@@'', '''  + @DivisionID + ''') '

SELECT @CustomerName = CustomerName FROM dbo.CustomerIndex WITH (NOLOCK)
-- Check Para FromDate và ToDate
-- Trường hợp search theo từ ngày đến ngày
IF @IsPeriod = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sDeclare = 'DECLARE @fromDate DATETIME = CONVERT(DATETIME, ''' + @FromDateText + ''')
							 	'
			SET @sWhere = @sWhere + ' AND (M.CreateDate >= @fromDate)'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sDeclare = 'DECLARE @toDate DATETIME = CONVERT(DATETIME, ''' + @ToDateText + ''')
							 	'

			SET @sWhere = @sWhere + ' AND (M.CreateDate <= @toDate)'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sDeclare = ' DECLARE @fromDate DATETIME = CONVERT(DATETIME, ''' + @FromDateText + ''')
							  DECLARE @toDate DATETIME = CONVERT(DATETIME, ''' + @ToDateText + ''')
							 	'

			SET @sWhere = @sWhere + ' AND (M.CreateDate BETWEEN @fromDate AND @toDate) '
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodIDList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(M.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodIDList + ''') '
	END

		
-- Check điều kiện search
IF ISNULL(@ScreenID, '') != '' 
	SET @sWhere = @sWhere + ' AND M.ScreenID LIKE N''%' + @ScreenID + '%'' '

IF ISNULL(@UserID, '') != '' 
	SET @sWhere = @sWhere + ' AND N.UserID = N''' + @UserID + ''' '

IF ISNULL(@CreateUserName, '') != ''
BEGIN
	SET @sWhere = @sWhere + ' AND A1.FullName LIKE N''%' + @CreateUserName + '%'' '
	SET @sSQLjoin = 'LEFT JOIN AT1103 A1 WITH (NOLOCK) ON CONVERT(VARCHAR(50), A1.EmployeeID) = M.CreateUserID'
END

IF ISNULL(@Description, '') != ''
	SET @sWhere = @sWhere + ' AND (M.Description LIKE N''%' + @Description + '%'' OR A.Name LIKE N''%' + @Description + '%'') '

IF ISNULL(@MessageType, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.MessageType,0) = ' + @MessageType + ' '

IF ISNULL(@IsRead, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(N.IsRead,0) = ' + @IsRead + ' '

IF ISNULL(@RecordNumber, '') != ''
	SET @TopSelect = @TopSelect + 'TOP ' + @RecordNumber +' '  

IF @CustomerName = 164 --PANGLOBE
BEGIN
--Lấy theo số lượng @RecordNumber
SET @sSQL01 = N'	
	SELECT ' + @TopSelect + ' M.APK, M.APKMaster, M.[Description], M.ModuleID, M.UrlCustom, M.[Parameters], N.DivisionID
                , N.IsRead, N.DeleteFlg, N.UserID, M.CreateDate, M.Title, M.ShowType, M.ImageName, M.ImageUrl, M.CreateUserID,ISNULL(M.MessageType,0) as MessageType, M.EffectDate
    FROM OOT9002 M WITH (NOLOCK)
    INNER JOIN OOT9003 N WITH (NOLOCK) ON N.APKMaster = M.APK
    LEFT JOIN A00002 A WITH (NOLOCK) ON CONVERT(VARCHAR(50), M.[Description]) = A.ID AND A.LanguageID = ''' + @LanguageID + '''
	' + @sSQLjoin + '
    WHERE ' + @sWhere + ' AND ISNULL(N.DeleteFlg, 0) = 0 AND ISNULL(M.[Disabled], 0) = 0 AND (ISNULL(M.EffectDate, 0) < GETDATE())
    --AND M.DepartmentID IN (''@@@'', @DepartmentID)
	ORDER BY ' + @OrderBy + ' '
END
ELSE
BEGIN
SET @sSQL01 = N'	
	SELECT ' + @TopSelect + ' M.APK, M.APKMaster, M.[Description], M.ModuleID, M.UrlCustom, M.[Parameters], N.DivisionID
                , N.IsRead, N.DeleteFlg, N.UserID, M.CreateDate, M.Title, M.ShowType, M.ImageName, M.ImageUrl, M.CreateUserID,ISNULL(M.MessageType,0) as MessageType
    FROM OOT9002 M WITH (NOLOCK)
    INNER JOIN OOT9003 N WITH (NOLOCK) ON N.APKMaster = M.APK
    LEFT JOIN A00002 A WITH (NOLOCK) ON CONVERT(VARCHAR(50), M.[Description]) = A.ID AND A.LanguageID = ''' + @LanguageID + '''
	' + @sSQLjoin + '
    WHERE ' + @sWhere + ' AND ISNULL(N.DeleteFlg, 0) = 0 AND ISNULL(M.[Disabled], 0) = 0
    --AND M.DepartmentID IN (''@@@'', @DepartmentID)
	ORDER BY ' + @OrderBy + ' '
END

--PRINT @sDeclare
--PRINT @sSQL01
EXEC (@sDeclare + @sSQL01)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
