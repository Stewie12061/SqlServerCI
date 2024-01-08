IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP2020]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP2020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid danh sách xử lý lỗi thành phẩm
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tan Tai , Date: 12/11/2020
-- <Example>

/*
--Lọc nâng cao


--Lọc thường
EXEC	[QCP2020]
		@DivisionID = N'VNP',
		@UserID = N'ASOFTADMIN',
		@DivisionList = N'',
		@VoucherType = N'',
		@VoucherNo = N'',
		@VoucherDate = N'',
		@ShiftVoucherDate = N'',
		@TranMonth = N'',
		@TranYear = N'',
		@ShiftID = N'',
		@ShiftName = N'',
		@MachineID = N'',
		@MachineName = N'',
		@Notes = N'',
		@PageNumber = 1,
		@PageSize = 25,
		@SearchWhere = N''
*/

CREATE PROCEDURE [dbo].[QCP2020] ( 
        @DivisionID VARCHAR(50), 
		@UserID VARCHAR(50), 
		@DivisionList VARCHAR(MAX), 
		@FromDate VARCHAR(MAX),
		@ToDate VARCHAR(MAX),
		@VoucherNo NVARCHAR(MAX),
		@ShiftVoucherDate NVARCHAR(MAX),
		@ShiftID VARCHAR(50), 
		@DepartmentID VARCHAR(50),
		@MachineID VARCHAR(50), 
		@Notes NVARCHAR(MAX),
		@PageNumber INT,
		@PageSize INT,
		@SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX),
			@sWhere NVARCHAR(MAX) = N'',
			@OrderBy NVARCHAR(500) = N'', 
			@TotalRow NVARCHAR(50) = N''

		IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
		SET @OrderBy = ' DivisionID, VoucherDate, VoucherNo'
		SET @sWhere = ' 1 = 1 '
		
		If Isnull(@SearchWhere, '') = '' --Lọc thường
		Begin
				IF ISNULL(@DivisionList, '') != ''
					SET @sWhere = @sWhere + N' AND QCT2020.DivisionID IN ('''+@DivisionList+''')'
				ELSE 
					SET @sWhere = @sWhere + N' AND QCT2020.DivisionID = '''+@DivisionID+''''

				IF ISNULL(@VoucherNo, '') != '' 
					SET @sWhere = @sWhere + N' AND QCT2020.VoucherNo LIKE N''%'+@VoucherNo+'%'''

				IF ISNULL(@FromDate, '') != '' 
					SET @sWhere = @sWhere + N' AND CONVERT(VARCHAR(8), QCT2020.VoucherDate, 112) >= '''+@FromDate+''''

				IF ISNULL(@ToDate, '') != '' 
					SET @sWhere = @sWhere + N' AND CONVERT(VARCHAR(8), QCT2020.VoucherDate, 112) <= '''+@ToDate+''''

				IF ISNULL(@ShiftID, '') != '' 
					SET @sWhere = @sWhere + N' AND HT1020.ShiftID LIKE N''%'+@ShiftID+'%'''

				IF ISNULL(@DepartmentID, '') != '' 
					SET @sWhere = @sWhere + N' AND QCT2000.DepartmentID LIKE N''%'+@DepartmentID+'%'''

				IF ISNULL(@MachineID, '') != '' 
					SET @sWhere = @sWhere + N' AND CIT1150.MachineID LIKE N''%'+@MachineID+'%'''

				IF ISNULL(@Notes, '') != '' 
					SET @sWhere = @sWhere + N' AND QCT2020.Notes LIKE N''%'+@Notes+'%'''


				--nếu giá trị NULL thì set về rổng 
				SET @SearchWhere = Isnull(@SearchWhere, '')
		End

		SET @sSQL = N'SELECT DISTINCT  QCT2020.APK, QCT2020.DivisionID, QCT2020.VoucherNo, QCT2020.VoucherDate, QCT2020.TranMonth, QCT2020.TranYear,  QCT2020.Notes,
					QCT2020.CreateDate, QCT2020.CreateUserID, QCT2020.LastModifyDate, QCT2020.LastModifyUserID
				INTO #QCP2020
				FROM QCT2020 QCT2020
					JOIN QCT2021 QCT2021 ON QCT2021.APKMaster = QCT2020.APK
					JOIN QCT2000 QCT2000 ON QCT2000.APK = QCT2021.RefAPKMaster
					JOIN QCT2001 QCT2001 ON QCT2001.APK = QCT2021.RefAPKDetail
					LEFT JOIN HT1020 HT1020 ON QCT2000.ShiftID = HT1020.ShiftID
					LEFT JOIN CIT1150 CIT1150 ON QCT2000.MachineID = CIT1150.MachineID
				WHERE '+@sWhere+' and QCT2020.DeleteFlg = 0

				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, 
						APK, DivisionID, VoucherNo, VoucherDate, TranMonth, TranYear,  Notes,
						CreateDate, CreateUserID, LastModifyDate, LastModifyUserID
				FROM #QCP2020
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
		EXEC (@sSQL)
		PRINT (@sSQL)
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
