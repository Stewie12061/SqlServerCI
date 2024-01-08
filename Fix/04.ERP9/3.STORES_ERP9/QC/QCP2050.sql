IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP2050]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP2050]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid danh sách phiếu nguyên vật liệu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: TanTai , Date: 11/11/2020
-- <Example>

/*
--Lọc nâng cao
EXEC	@return_value = [dbo].[QCP2050]	@DivisionID = N'VNP', @UserID = N'ASOFTADMIN',@DivisionList = N' ',	@VoucherTypeID = N' ',@VoucherNo = N' ',@VoucherDate = N' ',@TranMonth = N'11',@TranYear = N'2020',	@ShiftID = N' ',@ShiftName = N' ',@MachineID = N' ',@MachineName = N' ',@Notes = N' ',@PageNumber = 0,@PageSize = 25,@SearchWhere = N' '

*/

CREATE PROCEDURE [dbo].[QCP2050] ( 
        @DivisionID VARCHAR(50),
		@UserID VARCHAR(50),
		@VoucherNo NVARCHAR(MAX),
		@FromDate NVARCHAR(MAX),
		@ToDate NVARCHAR(MAX),
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
				
				IF ISNULL(@DivisionID, '') != '' 
					SET @sWhere = @sWhere + N' AND T1.DivisionID = '''+@DivisionID+''''

				IF ISNULL(@VoucherNo, '') != '' 
					SET @sWhere = @sWhere + N' AND T1.VoucherNo LIKE N''%'+@VoucherNo+'%'''

				IF ISNULL(@FromDate, '') != '' 
					SET @sWhere = @sWhere + N' AND CONVERT(VARCHAR(8), T1.VoucherDate, 112) >= '''+@FromDate+''''

				IF ISNULL(@ToDate, '') != '' 
					SET @sWhere = @sWhere + N' AND CONVERT(VARCHAR(8), T1.VoucherDate, 112) <= '''+@ToDate+''''

				IF ISNULL(@ShiftID, '') != '' 
					SET @sWhere = @sWhere + N' AND T4.ShiftID LIKE N''%'+@ShiftID+'%'''

				IF ISNULL(@DepartmentID, '') != '' 
					SET @sWhere = @sWhere + N' AND T4.DepartmentID LIKE N''%'+@DepartmentID+'%'''

				IF ISNULL(@MachineID, '') != '' 
					SET @sWhere = @sWhere + N' AND T4.MachineID LIKE N''%'+@MachineID+'%'''

				IF ISNULL(@Notes, '') != '' 
					SET @sWhere = @sWhere + N' AND T1.Notes LIKE N''%'+@Notes+'%'''

				--nếu giá trị NULL thì set về rổng 
				SET @SearchWhere = Isnull(@SearchWhere, '')
		End

		SET @sSQL = N'
				SELECT DISTINCT T1.APK, T1.DivisionID, T1.VoucherNo, T1.VoucherDate, T1.TranMonth, T1.TranYear, 
					 T1.APKMaster, T1.Notes,
					T1.CreateDate, T1.CreateUserID, T1.LastModifyDate, T1.LastModifyUserID
				INTO #QCP2050
				FROM QCT2010 T1	WITH(NOLOCK)
				LEFT JOIN QCT2011 T2 WITH(NOLOCK) ON T2.DivisionID = T1.DivisionID AND T2.APKMaster = T1.APK
				LEFT JOIN QCT2000 T4 WITH(NOLOCK) ON T4.APK = T2.RefAPKMaster
				WHERE '+@sWhere+' AND T1.VoucherType = ''2'' AND T1.DeleteFlg=0 

				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, 
						APK, DivisionID, VoucherNo, VoucherDate, TranMonth, TranYear, 
						 APKMaster, Notes,
						CreateDate, CreateUserID, LastModifyDate, LastModifyUserID
				FROM #QCP2050
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
		
		EXEC (@sSQL)
		PRINT (@sSQL)
END
