IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP2033]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP2033]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Detail chuyển nhượng cổ phần (Xem chi tiết)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hoàng vũ on 26/10/2018
----Edited by 
-- <Example> EXEC SHMP2033 @DivisionID = 'BS', @UserID = '', @APK = '214A4078-CD03-48A4-81D5-A35CC0F5C575',@PageNumber='1',@PageSize='25'

CREATE PROCEDURE SHMP2033
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)

AS 

	DECLARE @sSQL NVARCHAR(MAX) = N'',
			@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX) = N''

	SET @OrderBy = N' S31.OrderNo'
	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

	SET @sSQL = N'
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
					, S31.APK, S31.APKMaster, S31.DivisionID
					, S31.ShareTypeID, S10.ShareTypeName, S31.QuantityTransfered, S31.UnitPrice, S31.AmountTransfered, S31.OrderNo
					, S31.DeleteFlg, S31.APKMInherited, S31.APKDInherited
					, S31.CreateDate, S31.LastModifyDate, S31.CreateUserID, S31.LastModifyUserID
				FROM SHMT2031 S31 WITH (NOLOCK) LEFT JOIN SHMT1010 S10 WITH (NOLOCK) ON S31.ShareTypeID = S10.ShareTypeID
				WHERE S31.APKMaster = '''+@APK+'''
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
 	 EXEC (@sSQL)
 
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


