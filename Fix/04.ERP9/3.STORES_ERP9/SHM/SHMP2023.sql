IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP2023]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP2023]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Detail Đăng ký mua cổ phần (Xem chi tiết)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Xuân Minh on 01/10/2018
----Edited by Hoàng vũ, on 18/10/2018
-- <Example> EXEC SHMP2023 @DivisionID = 'BS', @UserID = '', @APK = '214A4078-CD03-48A4-81D5-A35CC0F5C575',@PageNumber='1',@PageSize='25'

CREATE PROCEDURE SHMP2023
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

	SET @OrderBy = N'T1.OrderNo'
	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

	SET @sSQL = N'
				SELECT  CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow
						, T1.APK, T1.APKMaster, T1.DivisionID, T1.ShareTypeID, T2.ShareTypeName, T1.UnitPrice, T1.QuantityBuyable
						, T1.QuantityRegistered, T1.QuantityApproved, T1.AmountBought, T1.DeleteFlg
						, T1.APKMInherited, T1.APKDInherited, T1.CreateDate, T1.CreateUserID, T1.LastModifyDate
						, T1.LastModifyUserID
				FROM SHMT2021 T1 WITH (NOLOCK) LEFT JOIN SHMT1010 T2 WITH (NOLOCK) ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T1.ShareTypeID = T2.ShareTypeID
				WHERE T1.APKMaster = '''+@APK+'''
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
 	 EXEC (@sSQL)
 
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


