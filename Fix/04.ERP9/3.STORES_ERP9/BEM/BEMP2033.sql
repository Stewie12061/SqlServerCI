IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2033]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2033]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Truy vấn load dữ liệu cho lưới details từ màn hình xem chi tiết BEMF2032
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Trọng Kiên, Date: 03/07/2020
----Modified by: Vĩnh Tâm,	Date: 04/11/2020: Thay đổi điều kiện Order By theo cột OrderNo của Detail
-- <Example>
---- 
/*-- <Example>
	BEMP2033 @DivisionID = 'MK', @APK = 'ABCA3441-E076-4D28-88E5-04BF4480B9CB', @PageNumber = 1, @PageSize = 20
----*/

CREATE PROCEDURE [dbo].[BEMP2033]
(
	@DivisionID VARCHAR(50),
    @APK VARCHAR(50),
	@PageNumber INT,
	@Pagesize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500) = N''

SET @OrderBy = 'B2.OrderNo'
SET @sWhere = N''

IF ISNULL(@DivisionID, '') != ''
	SET @sWhere = @sWhere + ' B1.DivisionID IN (''' + @DivisionID + ''') '

IF ISNULL(@APK, '') != ''
    SET @sWhere = @sWhere + ' AND B1.APK = ''' + ISNULL(@APK, '') + ''' OR B1.APKMaster_9000 = ''' + ISNULL(@APK, '') + ''' '

SET @sSQL = N'SELECT  ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, COUNT(*) OVER () AS TotalRow,
                B2.APK, B2.StartDate, B2.EndDate, B2.WorkContent, B2.Destination, B2.CompanyName

			FROM BEMT2030 B1 WITH (NOLOCK) 
                LEFT JOIN BEMT2031 B2 WITH (NOLOCK) ON B2.APKMaster = B1.APK
			WHERE ' + @sWhere + '
		    ORDER BY ' + @OrderBy + '
		    OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		    FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
EXEC (@sSQL)
--PRINT (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
