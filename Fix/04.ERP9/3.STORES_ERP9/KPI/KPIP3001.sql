IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP3001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP3001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










-- <Summary>
---- Báo cáo danh sách ch? tiêu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: T?n L?c, Date: 22/08/2019
-- <Example>


CREATE PROCEDURE [dbo].[KPIP3001]
(
	@DivisionID VARCHAR(50),
	@FromDate datetime,
    @EndDate datetime
)
AS
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX)
		
IF ISNULL(@DivisionID, '') != ''
	SET @sWhere = ' K1.DivisionID IN (''' + @DivisionID + ''') '

SET @sSQL = 'SELECT K.APK
				, K1.DivisionID
				, K.TargetsID
				, K.TargetsName
				INTO #TempKPIT10501
			FROM KPIT10501 K WITH (NOLOCK)
				LEFT JOIN KPIT10502 K1 WITH (NOLOCK) ON K1.APKMaster = K.APK
				LEFT JOIN (
							select RelatedToID,CreateUserID,[Description]
							from CRMT00003 C  WITH (NOLOCK)
							where C.CreateUserID = ''TANLOC'' and C.Description LIKE ''%DepartmentID%''
						  )
							C ON C.RelatedToID = CAST(K.APK AS VARCHAR(50)) 	
			WHERE ' + @sWhere + ' AND C.RelatedToID is null
			Group by  K.APK
				, K1.DivisionID
				, K.TargetsID
				, K.TargetsName

			DECLARE @count INT
			SELECT @count = COUNT(*) FROM #TempKPIT10501

			SELECT ROW_NUMBER() OVER (ORDER BY K.TargetsID) AS RowNum, @count AS TotalRow
				, K.APK, K.DivisionID
				, K.TargetsID
				, K.TargetsName
			FROM #TempKPIT10501 K
			ORDER BY K.TargetsID ASC'
EXEC (@sSQL)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
