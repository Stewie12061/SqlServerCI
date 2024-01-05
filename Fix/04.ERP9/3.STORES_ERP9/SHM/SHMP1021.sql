  IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP1021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP1021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load form xem thông tin danh mục đợt phát hành (Detail)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 11/9/2018 by Xuân Minh
----Edited by Hoàng Vũ, on 18/10/2018
----Edited by Hoàng Vũ, on 03/07/2019: lấy những loại cổ phần dùng chung
-- <Example> EXEC SHMP1021 @DivisionID = 'BS', @UserID = '', @APK = 'EE9A0266-B073-498F-9313-20D8F7B803FD',@PageNumber='1',@PageSize='25'

CREATE PROCEDURE SHMP1021
( 
	 @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50), 
	 @APK VARCHAR(50),
	 @PageNumber INT,		--nếu = null thì load edit, ngược lại là load xem chi tiết
	 @PageSize INT			--nếu = null thì load edit, ngược lại là load xem chi tiết
)
AS 
	DECLARE @sSQL NVARCHAR (MAX) = N'',
     		@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX) = N''
	If Isnull(@PageNumber, '') != ''
	Begin
		SET @OrderBy = N'D.ShareTypeID'
		IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
		SET @sSQL = @sSQL + N'
			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, D.APK, D.APKMaster, M.DivisionID
					, M.SHPublishPeriodID, M.SHPublishPeriodName, M.SHPublishPeriodDate
					, M.QuantityPreferredShare, M.QuantityCommonShare, M.QuantityTotal
					, M.Description, M.Disabled, M.IsCommon
					, D.ShareTypeID, SHMT1010.ShareTypeName, SHMT1010.SharedKind, AT0099.Description as SharedKindName
					, D.UnitPrice, D.Quantity, D.Amount, D.LimitTransferYear
					, M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID
			FROM SHMT1020 M WITH (NOLOCK) inner join SHMT1021 D WITH (NOLOCK) on M.APK = D.APKMaster 
							LEFT JOIN SHMT1010 WITH (NOLOCK) ON D.ShareTypeID = SHMT1010.ShareTypeID and SHMT1010.DivisionID IN ('''+@DivisionID+''',''@@@'')
							Left join AT0099 WITH (NOLOCK) ON SHMT1010.SharedKind = AT0099.ID and AT0099.Codemaster = ''AT00000053''
			WHERE M.APK = '''+@APK+''' 
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	End
	Else 
	Begin
		SET @sSQL = @sSQL + N'
			SELECT D.APK, D.APKMaster, M.DivisionID
					, M.SHPublishPeriodID, M.SHPublishPeriodName, M.SHPublishPeriodDate
					, M.QuantityPreferredShare, M.QuantityCommonShare, M.QuantityTotal
					, M.Description, M.Disabled, M.IsCommon
					, D.ShareTypeID, SHMT1010.ShareTypeName, SHMT1010.SharedKind, AT0099.Description as SharedKindName
					, D.UnitPrice, D.Quantity, D.Amount, D.LimitTransferYear
					, M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID
			FROM SHMT1020 M WITH (NOLOCK) inner join SHMT1021 D WITH (NOLOCK) on M.APK = D.APKMaster 
							LEFT JOIN SHMT1010 WITH (NOLOCK) ON D.ShareTypeID = SHMT1010.ShareTypeID and SHMT1010.DivisionID IN ('''+@DivisionID+''',''@@@'')
							Left join AT0099 WITH (NOLOCK) ON SHMT1010.SharedKind = AT0099.ID and AT0099.Codemaster = ''AT00000053''
			WHERE M.APK = '''+@APK+''''
		
	End
	EXEC (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
