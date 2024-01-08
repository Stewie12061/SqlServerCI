IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2083]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2083]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
























-- <Summary>
--- Load danh sách đơn hàng bán
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Ðình Ly Date 05/12/2019
-- Created by: Kiều Nga Date 19/11/2020 : Bổ sung lấy thêm APK
-- <Example>
/*
	EXEC OOP1063 @DivisionID=N'DTI',@TxtSearch=N'',@UserID=N'DANH',@PageNumber=N'1',@PageSize=N'10'
*/

 CREATE PROCEDURE [dbo].[SOP2083] (
	 @DivisionID NVARCHAR(2000),
	 @TxtSearch NVARCHAR(250),
	 @IsOpportunity TINYINT = 0,
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
	 @sWhere NVARCHAR(MAX),
	 @OrderBy NVARCHAR(500),
	 @TotalRow NVARCHAR(50)

SET @sWhere = '1 = 1'
SET @OrderBy = 'O.CreateDate'

IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + 'AND (M.VoucherNo LIKE N''%' + @TxtSearch + '%'')'
	--SET @sWhere = @sWhere + ' AND M.ShipDate IS NULL'

IF @IsOpportunity = 1
	SET @sWhere = @sWhere + ' AND ISNULL(M.OpportunityID, '''') != '''''

SET @sSQL = '
		SELECT 
			 M.APK
		     ,M.VoucherNo
			 , M.CreateDate
			 , A1.ObjectID
			 , A1.ObjectName INTO #TemSOP2083
		FROM OT2001 M WITH (NOLOCK)
			LEFT JOIN AT1202 A1 ON A1.ObjectID = M.ObjectID
		WHERE ' + @sWhere + ' AND M.DivisionID = ''' + @DivisionID + '''
			
		DECLARE @count INT
		SELECT @count = COUNT(VoucherNo) FROM #TemSOP2083 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum
			 , @count AS TotalRow
			 , O.VoucherNo
			 , O.ObjectID
			 , O.ObjectName
			 , O.APK
		FROM #TemSOP2083 O
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
PRINT(@sSQL)
EXEC (@sSQL)
























GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
