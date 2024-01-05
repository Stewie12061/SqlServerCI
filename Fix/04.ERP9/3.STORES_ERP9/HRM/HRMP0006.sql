IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP0006]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP0006]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load thông tin của tab đính kèm
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Hải Long on 08/09/2017
---- <Example>
---- Exec HRMP0006 @DivisionID='AS',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=10,@RelatedToID=N'1a1dc985-2e1d-4885-a622-debbf05c57bd',@RelatedToTypeID_REL=20
---- 

CREATE PROCEDURE [dbo].[HRMP0006]
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@PageNumber INT = 0,
	@PageSize INT = 10,
	@RelatedToID NVARCHAR(50),
	@RelatedToTypeID_REL INT
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @OrderBy NVARCHAR(500) = 'CRMT00002.AttachName,CRMT00002.DivisionID',
        @TotalRow NVARCHAR(50) = ''
        
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL' 	        

SET @sSQL = '
SELECT COUNT(*) OVER() as TotalRow, ROW_NUMBER() OVER (ORDER BY CRMT00002.AttachName) AS RowNum, * 
FROM CRMT00002 WITH (NOLOCK)
INNER JOIN CRMT00002_REL WITH (NOLOCK) ON CRMT00002.AttachID = CRMT00002_REL.AttachID 
WHERE CRMT00002_REL.RelatedToID = ''' + @RelatedToID + '''
AND RelatedToTypeID_REL = ' + CONVERT(NVARCHAR(10), @RelatedToTypeID_REL) + '  
ORDER BY ' + @OrderBy + ' 
OFFSET ' + CONVERT(NVARCHAR(10), (@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'

PRINT @sSQL
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
