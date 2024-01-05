IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3029_DTI]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3029_DTI]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Báo cáo công việc theo nhân viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Đức Nhân, Date: 14/05/2019
----Modified by: Đình Ly, Date: 02/03/2020: Bổ sung các cột điểm đánh giá KHHL, QTCM, VHPT, Ghi chú
-- <Example>
----
/*-- <Example>
	OOP3029_DTI @DivisionID = 'KY', @PlanStartDate = '2019-05-14', @PlanEndDate = '2019-05-14', @AssignedToUserID = 'DANH', @StatusID = ''
 */

CREATE PROCEDURE [dbo].[OOP3029_DTI]
(
		@DivisionID VARCHAR(250),
		@PlanStartDate NVARCHAR(3000),
		@PlanEndDate NVARCHAR(3000),
		@AssignedToUserID NVARCHAR(MAX),
		@StatusID NVARCHAR(500)
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@PlanStartDateText NVARCHAR(20),
		@PlanEndDateText NVARCHAR(20),
		@Language NVARCHAR(250),
		@TargetsGroupID VARCHAR(50),
		@Mark DECIMAL(28,8),
		@Cur CURSOR,
		@ListGroup NVARCHAR(MAX) = ''

		SET @Cur = CURSOR SCROLL KEYSET FOR
		SELECT REPLACE(O1.TargetsGroupID, '.', '') AS TargetsGroupID
		FROM OOT0050 O1 WITH (NOLOCK)
			INNER JOIN OOT0051 O2 WITH (NOLOCK) ON O1.APKMaster = O2.APK
		WHERE ISNULL(O1.NoDisplay, 0) = 0 AND O2.ObjectID = 'CV' 

		OPEN @Cur
		FETCH NEXT FROM @Cur INTO @TargetsGroupID
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @ListGroup = @ListGroup + ',' + REPLACE(@TargetsGroupID, '.', '')
			FETCH NEXT FROM @Cur INTO @TargetsGroupID
		END
		CLOSE @Cur

		SET @ListGroup = SUBSTRING(@ListGroup, 2, LEN(@ListGroup))

		SET @sWhere = '1 = 1'
		SET @PlanStartDateText = CONVERT(NVARCHAR(20), @PlanStartDate, 111)
		SET @PlanEndDateText = CONVERT(NVARCHAR(10), @PlanEndDate, 111) + ' 23:59:59'
		SET @sWhere = '(M.PlanStartDate BETWEEN ''' + @PlanStartDateText + ''' AND ''' + @PlanEndDateText + ''''
						+ ' OR M.PlanEndDate BETWEEN ''' + @PlanStartDateText + ''' AND ''' + @PlanEndDateText + ''' '
						+ ' OR M.ActualStartDate BETWEEN ''' + @PlanStartDateText + ''' AND ''' + @PlanEndDateText + ''''
						+ ' OR M.ActualEndDate BETWEEN ''' + @PlanStartDateText + ''' AND ''' + @PlanEndDateText + ''') '
				
		IF ISNULL(@DivisionID, '') != ''
			SET @sWhere = @sWhere + ' AND M.DivisionID IN (''' + @DivisionID + ''') '

		IF ISNULL(@StatusID,'') != ''
			SET @sWhere = @sWhere + ' AND M.StatusID IN (''' + @StatusID + ''') '

		IF ISNULL(@AssignedToUserID,'') != ''
			SET @sWhere = @sWhere + ' AND M.AssignedToUserID IN (''' + REPLACE(@AssignedToUserID, ',', ''',''') + ''') '

		SET @sSQL =  N'SELECT * INTO #TempOOT2100
					   FROM (
						   SELECT T2.APK
								, T2.AssignedToUserID
								, T2.AssignedToUserName
								, T2.ProjectID
								, T2.DivisionID
								, T2.TaskID
								, T2.TaskName
								, T2.PercentProgress
								, T2.ActualStartDate
								, T2.ActualEndDate
								, T2.PlanStartDate, T2.PlanEndDate
								, T2.StatusID, T2.StatusName
								, T2.PlanTime, T2.ActualTime, T2.Note
								,' + @ListGroup + '
							FROM (
								SELECT M.APK
									, M.DivisionID
									, CASE
										WHEN ISNULL(N.ProjectName, '''') != '''' AND ISNULL(M.ProjectID, '''') != ''''
											THEN CONCAT(N.ProjectID, '' - '', N.ProjectName)
										ELSE M.ProjectID
										END AS ProjectID
									, M.TaskID
									, M.TaskName
									, M.PlanStartDate
									, M.PercentProgress
									, M.ActualStartDate
									, M.ActualEndDate
									, M.PlanEndDate		
									, M.AssignedToUserID
									, CONCAT(A2.Name, '' '', A1.FullName) AS AssignedToUserName
									, ISNULL(M.StatusID, 0) AS StatusID, TM13.StatusName, M.IsViolated
									, M.PlanTime, M.ActualTime, REPLACE(O1.TargetsGroupID, ''.'', '''') AS TargetsGroupID, O1.Mark
									, CASE
										WHEN M.IsViolated = 1 
											THEN ''OOR3029.IsViolated''
										WHEN M.ActualEndDate > M.PlanEndDate
											THEN ''OOR3029.LateProgress''
										WHEN M.IsViolated = 0
											THEN ''''
										END AS Note 
								FROM OOT2110 M WITH (NOLOCK)
									LEFT JOIN OOT2100 N WITH (NOLOCK) ON N.ProjectID = M.ProjectID AND ISNULL(N.DeleteFlg, 0) = 0
									LEFT JOIN AT1103 A1 WITH (NOLOCK) ON M.AssignedToUserID = A1.EmployeeID
									LEFT JOIN OOT1040 TM13 WITH (NOLOCK) ON M.StatusID = TM13.StatusID
									INNER JOIN OOT2130 O1 WITH (NOLOCK) ON O1.APKMaster = M.APK
									INNER JOIN KPIT10501 K1 WITH (NOLOCK) ON K1.TargetsID = M.TargetTypeID
									INNER JOIN KPIT10502 K2 WITH (NOLOCK) ON K2.APKMaster = K1.APK AND K2.DepartmentID = A1.DepartmentID
									INNER JOIN KPIT10101 K3 WITH (NOLOCK) ON K3.TargetsGroupID = K2.TargetsGroupID
									INNER JOIN A00001 A2 ON A2.ID = ''OOR3029.FullName''
								 WHERE ' + @sWhere + ' AND ISNULL(M.DeleteFlg,0) = 0 ) AS T1
							PIVOT 
							(
								SUM(Mark)
								FOR TargetsGroupID IN (' + @ListGroup + ')
							) AS T2 ) AS T3

					DECLARE @count INT
					SELECT @count = COUNT(TaskID) FROM #TempOOT2100
			
					SELECT ROW_NUMBER() OVER (ORDER BY M.AssignedToUserID) AS RowNum, @count AS TotalRow
						, M.APK
						, M.AssignedToUserID
						, M.AssignedToUserName
						, M.ProjectID
						, M.DivisionID
						, M.TaskID
						, M.TaskName
						, M.PercentProgress
						, M.ActualStartDate
						, M.ActualEndDate
						, M.PlanStartDate, M.PlanEndDate
						, M.StatusID, M.StatusName
						, M.PlanTime, M.ActualTime
						,' + @ListGroup + '
						, A1.Name AS Note
					FROM #TempOOT2100 M 
						LEFT JOIN A00001 A1 WITH (NOLOCK) ON A1.ID = M.Note
					ORDER BY M.AssignedToUserID ASC, M.PlanStartDate ASC'
--PRINT(@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
