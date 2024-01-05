IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2039]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2039]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Load màn hình chọn yêu cầu báo giá
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Kiều nga , Date:17/07/2019
-- <Example>
/*
    EXEC POP2039 'DTI', '','NGA',1,25
*/

 CREATE PROCEDURE POP2039 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
 

	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'T1.RequestSubject'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'
	
	IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere +'
									AND (T1.RequestSubject LIKE N''%'+@TxtSearch+'%'' 
									OR T1.RequestDescription LIKE N''%'+@TxtSearch+'%'' 
									OR T1.OpportunityID LIKE N''%'+@TxtSearch+'%'' 
									OR T2.OpportunityName LIKE N''%'+ @TxtSearch+'%'')'
	
	SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
							, T1.APK,T1.RequestCustomerID, T1.RequestSubject, T1.RequestStatus, C01.Description AS RequestStatusName, T1.TimeRequest, T1.DeadlineRequest
							, CASE WHEN LEN(T1.RequestDescription) >30 THEN SUBSTRING(T1.RequestDescription,1,30) +'' ...'' ELSE SUBSTRING(T1.RequestDescription,1,30) END  as RequestDescription, T1.OpportunityID,T2.OpportunityName,T3.ProjectID,T3.ProjectName
				FROM CRMT20801 T1 with (NOLOCK)
				LEFT JOIN CRMT20501 T2 WITH(NOLOCK) ON T1.OpportunityID = T2.OpportunityID AND T1.DivisionID = T2.DivisionID
				LEFT JOIN OOT2100 T3 WITH(NOLOCK) ON T3.OpportunityID = T1.OpportunityID AND T3.DivisionID = T1.DivisionID
				LEFT JOIN CRMT0099 C01 WITH (NOLOCK) ON C01.ID = T1.RequestStatus AND C01.CodeMaster = ''CRMT00000003''
				WHERE T1.OpportunityID IS NOT NULL --AND T1.RequestStatus = 3 '+@sWhere+'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
EXEC (@sSQL)
--PRINT(@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
