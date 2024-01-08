IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2152]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2152]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
---- Truy vấn load dữ liệu cho lưới details từ màn hình xem chi tiết
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Huỳnh Thử, Date: 03/11/2020
-- <Example>
---- 
/*-- <Example>
    HRMP2152 @DivisionID = 'MK', @APK = 'ABCA3441-E076-4D28-88E5-04BF4480B9CB', @PageNumber = 1, @PageSize = 20
----*/

CREATE PROCEDURE [dbo].[HRMP2152]
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

SET @OrderBy = 'H2.CreateDate'
SET @sWhere = N''

IF ISNULL(@DivisionID, '') != ''
    SET @sWhere = @sWhere + ' H1.DivisionID IN (''' + @DivisionID + ''') '

IF ISNULL(@APK, '') != ''
    SET @sWhere = @sWhere + ' AND H1.APK = ''' + ISNULL(@APK, '') + ''' '

SET @sSQL = N'SELECT ROW_NUMBER() OVER (ORDER BY  H1.APK ) AS RowNum, COUNT(*) OVER () AS TotalRow,
             H2.DivisionID , H2.APKMaster, H2.CreateDate, H2.CreateUserID, H2.LastModifyDate, H2.LastModifyUserID, H2.EmployeeID, HV1400.FullName AS EmployeeName, H2.DescriptionDetail
            FROM HRMT2151 H2 WITH (NOLOCK) 
                LEFT JOIN HRMT2150 H1 WITH (NOLOCK) ON  H1.APK =  H2.APKMaster
				LEFT JOIN HV1400 WITH (NOLOCK) ON H2.EmployeeID = HV1400.EmployeeID
            WHERE ' + @sWhere + '
            ORDER BY ' + @OrderBy + '
            OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
            FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
EXEC (@sSQL)
PRINT (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
