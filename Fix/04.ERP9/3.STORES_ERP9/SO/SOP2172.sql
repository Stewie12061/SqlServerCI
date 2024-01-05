IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2172]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2172]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load màn hình chọn xe
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created  by: Kiều Nga	14/09/2022
----Modified by: Văn Tài	15/05/2023 - Xử lý luồng Điều phối.
----Modified by: Văn Tài	30/05/2023 - Xử lý luồng Điều phối - Load thông tin tuyến phụ và Ngày giao hàng mới nhất.
----Modified by: Viết Toàn	26/12/2023 - Xử lý luồng Điều phối - bổ sung điều kiện deleteFlg <> 1.
/*
	exec SOP2172 @DivisionID=N'VNP',  @TxtSearch=N'',@UserID=N'',@PageNumber=N'1',@PageSize=N'25', @TypeID = N'BOM'
*/

 CREATE PROCEDURE [dbo].[SOP2172] (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)

	
		SET @sSQL = N'
		SELECT ROW_NUMBER() OVER (ORDER BY P.AssetID) AS RowNum
		,  COUNT(*) OVER () AS TotalRow
		, P.DivisionID
		, P.AssetID
		, P.MainRouteID as MainRoute
		, (
			SELECT STUFF((
				SELECT SubRouteID + '',''
				FROM CIT1301 P01 WITH (NOLOCK)
				WHERE P01.AssetID = P.AssetID 
				ORDER BY P01.Orders
				FOR XML PATH('''')
			 ), 1, 1, '''') 
			) AS SubRoute
		, P.EmployeeID
		, AT03.FullName AS EmployeeName
		, p.Weight AS [Weight]
		, p.Height AS Height
		, p.Length AS Length
		, p.Width AS Width
		, ST71.BeginDate AS DeliveryStart
        , ST71.EndDate AS DeliveryEnd
		FROM CIT1300 P WITH (NOLOCK)		
		INNER JOIN AT1103 AT03 WITH (NOLOCK) ON AT03.DivisionID IN (P.DivisionID, ''@@@'') AND AT03.EmployeeID = P.EmployeeID
		OUTER APPLY
        (
            -- Lấy thông tin chuyến gần nhất mà xe sẽ kết thúc giao hàng.
            SELECT TOP 1 ST70.*
            FROM SOT2170 ST70 WITH (NOLOCK)
            WHERE P.DivisionID IN (ST70.DivisionID, ''@@@'')
                AND ST70.Car = P.AssetID
                AND ISNULL(ST70.[Status], 0) != 1 -- Khác Hoàn thành.
            ORDER BY ST70.EndDate DESC
        ) ST71
		WHERE P.DeleteFlg <> 1
		ORDER BY P.AssetID
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

PRINT (@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
