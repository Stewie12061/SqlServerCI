IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'KPIP10501') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE KPIP10501
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form KPIP10501 Danh muc chỉ tiêu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: hoàng vũ, Date: 11/08/2017
----Edited by: Minh Trí, Date: 25/12/2023: chỉnh sửa Lấy dữ liệu search theo ngày , kỳ
-- <Example> EXEC KPIP10501 'AS', '', '', '', '', '', 'aa', '', '', '', '', '', '', '', 1, 20

CREATE PROCEDURE KPIP10501 ( 
          @DivisionID VARCHAR(50),  
		  @DivisionIDList NVARCHAR(2000), 
		  @DepartmentID nvarchar(50),
		  @TargetsID nvarchar(50),
		  @TargetsName nvarchar(50),
		  @EvaluationPhaseID nvarchar(50),
		  @TargetsGroupID nvarchar(50),
		  @UnitKpiID nvarchar(50),
		  @FrequencyID nvarchar(50),
		  @SourceID nvarchar(50),
		  @Categorize nvarchar(50),
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
			SET @OrderBy = ' M.CreateDate DESC, M.TargetsID '

		IF @IsSearch = 1
		BEGIN
				--Check Para DivisionIDList null then get DivisionID 
			IF Isnull(@DivisionIDList, '') != ''
				SET @sWhere = @sWhere + ' AND D.DivisionID IN ('''+@DivisionIDList+''', ''@@@'') '
	
			IF Isnull(@DepartmentID, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(D.DepartmentID, '''') LIKE N''%'+@DepartmentID+'%'' '

			IF Isnull(@TargetsID, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(M.TargetsID, '''') LIKE N''%'+@TargetsID+'%'' '
	
			IF Isnull(@TargetsName, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(M.TargetsName, '''') LIKE N''%'+@TargetsName+'%'' '
	
			IF Isnull(@EvaluationPhaseID, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(D.EvaluationPhaseID, '''') LIKE N''%'+@EvaluationPhaseID+'%'' '

			IF Isnull(@TargetsGroupID, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(D.TargetsGroupID, '''') LIKE N''%'+@TargetsGroupID+'%'' '
	
			IF Isnull(@UnitKpiID, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(M.UnitKpiID, '''') LIKE N''%'+@UnitKpiID+'%'' '
	
			IF Isnull(@FrequencyID, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(M.FrequencyID, '''') LIKE N''%'+@FrequencyID+'%'' '
	
			IF Isnull(@SourceID, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(M.SourceID, '''') LIKE N''%'+@SourceID+'%'' '
	
			IF Isnull(@Categorize, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(M.Categorize, '''') LIKE N''%'+@Categorize+'%'' '
	
			IF Isnull(@IsCommon, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(M.IsCommon,'''') LIKE N''%'+@IsCommon+'%'' '
	
			IF Isnull(@Disabled, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') LIKE N''%'+@Disabled+'%'' '
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
				--SET @sWhere = @sWhere + ' AND (SELECT FORMAT(ISNULL(HRMT2120.CreateDate,HRMT2120.CreateDate), ''MM/yyyy'')) IN (' + @PeriodList + ') '
				--SET @DatePeriod =N'Theo kỳ: '+ REPLACE(@PeriodList,'''','')
				SET @sWhere = @sWhere + ' AND (SELECT FORMAT(M.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
			END
		END
		SET @sSQL = ' 
					SELECT Distinct M.APK, M.TargetsID, M.TargetsName
								, M.UnitKpiID, K3.UnitKpiName
								, M.FrequencyID, K2.Description as FrequencyName
								, M.SourceID, K4.SourceName, M.OrderNo
								, M.Categorize, K1.Description as CategorizeName
								, M.FormulaName, M.Note, M.IsCommon, M.Disabled
								, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
									into #TempKPIT10501
							FROM KPIT10501 M With (NOLOCK) Inner join KPIT10502 D With (NOLOCK) on M.APK = D.APKMaster
												  Left join AT0099 K1 With (NoLock) on M.Categorize = K1.ID and K1.CodeMaster =''AT00000041''
												  Left join AT0099 K2 With (NoLock) on M.FrequencyID = K2.ID and K2.CodeMaster =''AT00000042''
												  Left join KPIT10401 K3 With (NoLock) on M.UnitKpiID = K3.UnitKpiID 
												  Left join KPIT10301 K4 With (NoLock) on M.SourceID = K4.SourceID 
							WHERE ISNULL(M.DeleteFlg,0) = 0 '+@sWhere +'

							DECLARE @count int
							Select @count = Count(TargetsID) From #TempKPIT10501 With (NOLOCK) 

							SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
									, M.APK, M.TargetsID, M.TargetsName
									, M.UnitKpiID, M.UnitKpiName
									, M.FrequencyID, M.FrequencyName
									, M.SourceID, M.SourceName, M.OrderNo
									, M.Categorize, M.CategorizeName
									, M.FormulaName, M.Note, M.IsCommon, M.Disabled
									, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
							FROM #TempKPIT10501 M With (NOLOCK) 
							ORDER BY '+@OrderBy+'
							OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
							FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
		EXEC (@sSQL)
	
		
END


