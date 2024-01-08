IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2142]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2142]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Load Detail cho màn hình Xem chi tiết - OOF2142 (Định mức dự án)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
---- Create on 23/10/2019 by Đình Ly
---- Modified on 04/05/2020 by Vĩnh Tâm: Điều chỉnh ORDER BY của kết quả đầu ra
-- <Example> EXEC OOP2142 @DivisionID = 'DTI', @UserID = 'ASOFTADMIN', @APK = 'EE9A0266-B073-498F-9313-20D8F7B803FD',@PageNumber='1',@PageSize='25'

CREATE PROCEDURE [dbo].[OOP2142]
( 
	 @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50), 
	 @APK VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)
AS 
	DECLARE @sSQL NVARCHAR (MAX) = N'',
     		@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N''

	SET @OrderBy = N'O.AnaDepartmentID'
	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'
	SET @sSQL = @sSQL + N'
		SELECT O1.CostGroup,A1.AnaName AS CostGroupName
			  , O1.CostGroupDetail, A2.AnaName AS CostGroupDetailName
			  , O1.AnaDepartmentID, A3.AnaName AS AnaDepartmentName
			  , O1.Money
			  , O1.ActualMoney
		INTO #TempOOT2140
		FROM OOT2140 O WITH (NOLOCK)
				LEFT JOIN OOT2141 O1 ON O.APK = O1.APKMaster AND ISNULL(O1.Disabled, 0) = 0
				LEFT JOIN AT0000 A0 ON A0.DefDivisionID = O.DivisionID
				LEFT JOIN AT1011 A1 ON O1.CostGroup = A1.AnaID AND A1.AnaTypeID = A0.CostAnaTypeID
				LEFT JOIN AT1011 A2 ON O1.CostGroupDetail = A2.AnaID AND A2.AnaTypeID = A0.CostDetailAnaTypeID
				LEFT JOIN AT1011 A3 ON O1.AnaDepartmentID = A3.AnaID AND A3.AnaTypeID = A0.DepartmentAnaTypeID

		WHERE O.APK = ''' + @APK + ''' OR O.APKMaster_9000 = ''' + @APK + '''
			AND ISNULL(O.Disabled, 0) = 0
		
		DECLARE @Count INT
		SELECT @Count = COUNT(CostGroup) FROM #TempOOT2140

		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
			  , O.CostGroup
			  , O.CostGroupName
			  , O.CostGroupDetail
			  , O.CostGroupDetailName
			  , O.AnaDepartmentID
			  , O.AnaDepartmentName
			  , O.Money
			  , O.ActualMoney
		FROM #TempOOT2140 O
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	EXEC (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
