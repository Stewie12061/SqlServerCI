IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP2043]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP2043]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Detail chia cổ tức (Xem chi tiết)
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
-- <Example> EXEC SHMP2043 @DivisionID = 'BS', @UserID = '', @APK = '214A4078-CD03-48A4-81D5-A35CC0F5C575',@PageNumber='1',@PageSize='25'

CREATE PROCEDURE SHMP2043
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
				SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
					, T1.APK, T1.APKMaster, T1.DivisionID, T1.ObjectID, T2.ObjectName, T1.HoldQuantity, 
					T1.AmountPayable, 
					ISNULL(Sum(A90.ConvertedAmount),0) as AmountPaid, 
					T1.AmountPayable - ISNULL(Sum(A90.ConvertedAmount),0) as AmountRemainning, 
					T1.OrderNo, T1.DeleteFlg, T1.APKMInherited, T1.APKDInherited
					, T1.CreateDate, T1.LastModifyDate, T1.CreateUserID, T1.LastModifyUserID
				FROM SHMT2041 T1 WITH (NOLOCK) 
				LEFT JOIN AT1202 T2 WITH (NOLOCK) ON T1.ObjectID = T2.ObjectID
				LEFT JOIN AT9000 A90 WITH (NOLOCK) ON T1.DivisionID = A90.DivisionID AND CONVERT(VARCHAR(50), T1.APK) = CONVERT(VARCHAR(50), A90.InheritTransactionID) 
						AND CONVERT(VARCHAR(50), T1.APKMaster ) = CONVERT(VARCHAR(50), A90.InheritVoucherID )
				WHERE T1.APKMaster = '''+@APK+''' and T1.DeleteFlg = 0
				Group by T1.APK, T1.APKMaster, T1.DivisionID, T1.ObjectID, T2.ObjectName, T1.HoldQuantity, T1.AmountPayable
					, T1.OrderNo, T1.DeleteFlg, T1.APKMInherited, T1.APKDInherited
					, T1.CreateDate, T1.LastModifyDate, T1.CreateUserID, T1.LastModifyUserID
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
 	 EXEC (@sSQL)
 

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
