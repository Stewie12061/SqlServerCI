IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP10101]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP10101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form KPIP10101 Danh muc nhóm chỉ tiêu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: hoàng vũ, Date: 11/08/2017
----Edited by: hoàng vũ, Date: 03/10/2017: chỉnh sửa Lấy dữ liệu search theo yêu cầu từ [phòng ban], [Đợt đánh giá]
----Edited by: Minh Trí, Date: 25/12/2023: chỉnh sửa Lấy dữ liệu search theo ngày , kỳ
----Edited by: Minh Trí, Date: 25/12/2023: Bổ sung cờ xóa DeleteFlg
-- <Example> EXEC KPIP10101 'AS', '', '', '', '', '', '', '', '', '', 1, 20

CREATE PROCEDURE KPIP10101 ( 
          @DivisionID VARCHAR(50),  
		  @DivisionIDList NVARCHAR(2000), 
		  @TargetsGroupID nvarchar(50),
		  @TargetsGroupName nvarchar(50),
		  @TargetsTypeID nvarchar(50),
		  @DepartmentID nvarchar(250),
		  @EvaluationPhaseID nvarchar(250),
		  @IsCommon nvarchar(100),
		  @Disabled nvarchar(100),
		  @UserID  VARCHAR(50),
		  @PageNumber INT,		  
		  @PageSize INT,
		  @IsSearch TINYINT,		  
		  @FromDate DATETIME,
		  @ToDate DATETIME,
		  @IsPeriod INT = 0,
		  @PeriodList VARCHAR(MAX) = ''
) 
AS 
BEGIN
		DECLARE @sSQL NVARCHAR (MAX),
				@sWhere NVARCHAR(MAX),
				@OrderBy NVARCHAR(500),
				@FromDateText NVARCHAR(20),
				@ToDateText NVARCHAR(20)
			SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111) + ' 00:00:00'
			SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'
			SET @sWhere = N''
			SET @OrderBy = ' M.CreateDate DESC, M.TargetsTypeID '
		IF @IsSearch = 1
		BEGIN
			--Check Para DivisionIDList null then get DivisionID 			
			IF ISNULL(@DivisionIDList, '') <> ''
				SET @sWhere = @sWhere + ' AND D.DivisionID IN ('''+@DivisionIDList+''', ''@@@'') '	
			IF Isnull(@TargetsGroupID, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(M.TargetsGroupID, '''') LIKE N''%'+@TargetsGroupID+'%'' '
			IF Isnull(@TargetsGroupName, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(M.TargetsGroupName, '''') LIKE N''%'+@TargetsGroupName+'%'' '
			IF Isnull(@TargetsTypeID, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(M.TargetsTypeID, '''') LIKE N''%'+@TargetsTypeID+'%'' '
			IF Isnull(@DepartmentID, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(D.DepartmentID,'''') LIKE N''%'+@DepartmentID+'%''  '
			IF Isnull(@EvaluationPhaseID, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(D.EvaluationPhaseID,'''') LIKE N''%'+@EvaluationPhaseID+'%''  '
			IF Isnull(@IsCommon, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
			IF Isnull(@Disabled, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '
			-- Trường hợp search theo từ ngày đến ngày
			IF @IsPeriod = 0
			BEGIN
				IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
				BEGIN
					SET @sWhere = @sWhere + ' AND (M.CreateDate >= ''' + @FromDateText + '''
													OR M.CreateDate >= ''' + @FromDateText + ''')'
				END
			ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
				BEGIN
					SET @sWhere = @sWhere + ' AND (M.CreateDate <= ''' + @ToDateText + ''' 
													OR M.CreateDate <= ''' + @ToDateText + ''')'
				END
			ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
				BEGIN
					SET @sWhere = @sWhere + ' AND (M.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
				END
			END	
			-- Lọc theo kỳ
			ELSE
			BEGIN
				SET @sWhere = @sWhere + ' AND (SELECT FORMAT(M.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
			END
		END
		SET @sSQL = ' 
					SELECT Distinct M.APK, M.TargetsGroupID, M.TargetsGroupName, M.TargetsTypeID, M.OrderNo
							, M.Note, M.IsCommon, M.Disabled, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
							 into #TempKPIT10101
					FROM KPIT10101 M With (NOLOCK) Inner join KPIT10102 D With (NOLOCK) on M.APK = D.APKmaster
					WHERE ISNULL(M.DeleteFlg,0) = 0 '+@sWhere +'

					DECLARE @count int
					Select @count = Count(TargetsGroupID) From #TempKPIT10101

					SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
							, M.APK
							, M.TargetsGroupID, M.TargetsGroupName
							, M.TargetsTypeID, A99.Description as TargetsTypeName, M.OrderNo
							, M.Note, M.IsCommon, M.Disabled
							, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
					FROM #TempKPIT10101 M With (NOLOCK) Left join AT0099 A99 With (NoLock) on M.TargetsTypeID = A99.ID and A99.CodeMaster =''AT00000040''					
					ORDER BY '+@OrderBy+'
					OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
					FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
		PRINT(@sSQL)
		EXEC (@sSQL)
		
END