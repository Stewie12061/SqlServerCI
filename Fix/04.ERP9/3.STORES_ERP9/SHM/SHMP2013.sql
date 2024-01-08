IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP2013]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP2013]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Detail Xem chi tiết sổ cổ đông
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Xuân Minh on 27/09/2018
----Edited by: Hoàng vũ on 23/10/2018
-- <Example> EXEC SHMP2013 @DivisionID = 'BS', @UserID = '', @APK = '214A4078-CD03-48A4-81D5-A35CC0F5C575',@PageNumber='1',@PageSize='25'

CREATE PROCEDURE SHMP2013
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX) = N'', 
			@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX) = N''

	SET @OrderBy = N' T11.TransactionDate Desc, T11.OrderNo'
	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

	SET @sSQL = N'
		SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
			, T11.APK,T11.DivisionID,T11.APKMaster,T11.ShareTypeID,T10.ShareTypeName,T10.PreferentialDescription
			, T10.TransferCondition
			, Isnull(T11.UnitPrice, 0) as UnitPrice
			, ISNULL(T11.IncrementQuantity,0) - ISNULL(T11.DecrementQuantity,0) as IncrementQuantity
			, ISNULL(T11.UnitPrice,0)* (ISNULL(T11.IncrementQuantity,0) - ISNULL(T11.DecrementQuantity,0)) AS ShareAmount
			, T11.Description
			, T11.TransactionDate
			, Case when Isnull(T11.TransactionTypeID, 0) = 1 then T20.VoucherNo
				   when Isnull(T11.TransactionTypeID, 0) = 2 then T30.VoucherNo
				   Else NULL end as RefVoucherNo
			, T11.TransactionTypeID
			, T11.APKMInherited,T11.APKDInherited
			, T11.CreateUserID,T11.CreateDate,T11.LastModifyUserID,T11.LastModifyDate
		FROM SHMT2011 T11 WITH (NOLOCK) LEFT JOIN SHMT1010 T10 WITH (NOLOCK) ON T11.ShareTypeID = T10.ShareTypeID
								    LEFT JOIN SHMT2020 T20 WITH (NOLOCK) ON T20.DivisionID = T11.DivisionID and T20.APK = T11.APKMInherited and T20.DeleteFlg = 0
									LEFT JOIN SHMT2030 T30 WITH (NOLOCK) ON T30.DivisionID = T11.DivisionID and T30.APK = T11.APKMInherited and T30.DeleteFlg = 0
		WHERE T11.APKMaster = '''+@APK+''' and T11.DeleteFlg = 0
		ORDER BY '+@OrderBy+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
	 EXEC (@sSQL)
	 
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
