IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1150]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP1150]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid danh sách máy( màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Nguyễn Hoàng Tấn Tài , Date: 30/07/2020
-- <Example>

/*
--Lọc 
EXEC CIP1150 @DivisionID='VNP' , @DivisionList='', @MachineID='MAY01',@MachineName ='Máy cuộn 1',@MachineNameE ='',@DepartmentID ='',@Model ='',@Year='',@StartDate ='',@Notes ='',
@PageNumber ='1',@PageSize ='25',@SearchWhere=N' where IsNull(MachineID,'''') = N''MAY01'''
*/

CREATE PROCEDURE CIP1150 ( 
        @DivisionID VARCHAR(50), 
  	    @DivisionList VARCHAR(MAX), 
		@MachineID NVARCHAR(50),
		@MachineName NVARCHAR(250),
		@MachineNameE NVARCHAR(250),
		@DepartmentID NVARCHAR(50),
		@Model NVARCHAR(250),
		@Year INT,
		@Disabled TINYINT,
		@StartDate DATETIME,
		@Notes NVARCHAR(250),
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
		SET @OrderBy = ' MachineID'
		SET @sWhere = ' 1 = 1 '
		
		If Isnull(@SearchWhere, '') = '' --Lọc thường
		Begin
				IF ISNULL(@DivisionID, '') != '' 
					SET @sWhere = @sWhere + N' AND T1.DivisionID = '''+@DivisionID+''''
				IF ISNULL(@MachineID, '') != '' 
					SET @sWhere = @sWhere + N' AND T1.MachineID LIKE N''%'+@MachineID+'%'''
				IF ISNULL(@MachineName, '') != '' 
				 	SET @sWhere = @sWhere + N' AND T1.MachineName LIKE N''%'+@MachineName+'%'''
				IF ISNULL(@MachineNameE, '') != '' 
				 	SET @sWhere = @sWhere + N' AND T1.MachineNameE LIKE N''%'+@MachineNameE+'%'''
				IF ISNULL(@DepartmentID, '') != '' 
					SET @sWhere = @sWhere + N' AND T1.DepartmentID  LIKE N''%'+@DepartmentID +'%'''
				IF ISNULL(@Model, '') != '' 
					SET @sWhere = @sWhere + N' AND T1.Model  LIKE N''%'+@Model +'%'''
				IF ISNULL(@Year, '') != '' 
					SET @sWhere = @sWhere + N' AND T1.Year  LIKE N''%'+@Year +'%'''
				IF ISNULL(@Disabled, '') != '' 
					SET @sWhere = @sWhere + N' AND T1.Disabled  LIKE N''%'+@Disabled +'%'''
				IF ISNULL(@StartDate, '') != '' 
					SET @sWhere = @sWhere + N' AND T1.StartDate  LIKE N''%'+@StartDate +'%'''
				
				--nếu giá trị NULL thì set về rổng 
				SET @SearchWhere = Isnull(@SearchWhere, '')
		End
		SET @sSQL = N'
				SELECT T1.APK, T1.DivisionID, T1.MachineID, T1.MachineName, T1.MachineNameE, T1.DepartmentID, T1.Model, T1.Year
						, CONVERT(NVARCHAR(50), T1.StartDate, 101) StartDate, T1.Notes, T1.Disabled, T1.CreateDate, T1.CreateUserID
						, T1.LastModifyDate, T1.LastModifyUserID
				INTO #CIP1150
				FROM CIT1150 T1 WITH (NOLOCK)
				WHERE '+@sWhere+' 

				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
						, APK, DivisionID, MachineID, Notes, MachineNameE, DepartmentID, Model
						, Year, StartDate, Disabled, CreateDate, CreateUserID
						, LastModifyDate, LastModifyUserID
				FROM #CIP1150
				
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
		EXEC (@sSQL)
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

