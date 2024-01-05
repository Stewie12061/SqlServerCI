IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP90021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP90021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load màn hình chọn liên hệ
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Hoàng vũ
---- Modify by Thị Phượng, on 11/04/2017 : Bổ sung lấy thêm APK và điều kiện IsCommon với liên hệ dùng chung
--- Modify by Thị Phượng,	Date 08/05/2017: Bổ sung phân quyền
--- Modify by Văn Tài,		Date 22/03/2023: Bổ sung WITH NOLOCK.
-- <Example>
/*
    EXEC CRMP90021 'AS', '',null,1,25, N'ASOFTADMIN'', ''DANH'', ''HOANG'', ''HUYEN'', ''LIEN'', ''LUAN'', ''PHUONG'', ''QUI'', ''QUYNH'', ''VU'
*/

 CREATE PROCEDURE CRMP90021 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @ConditionContactID NVARCHAR(MAX),
	 @AccountID NVARCHAR (250)='',
	 @OpportunityID NVARCHAR(250)=''
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
 

	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'ContactID, ContactName'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

	IF ISNULL(@AccountID, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND C2.AccountID LIKE N''%'+@AccountID+'%''  '
	END
	
	IF ISNULL(@OpportunityID, '') = ''
	BEGIN
		PRINT('Null')
	END
	IF ISNULL(@AccountID, '') = '' AND ISNULL(@OpportunityID, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND C3.OpportunityID = N'''+@OpportunityID+'''  '
	END
	
	IF Isnull(@TxtSearch,'') != ''  SET @sWhere = @sWhere +'
									AND (C1.ContactID LIKE N''%'+@TxtSearch+'%'' 
									OR C1.LastName LIKE N''%'+@TxtSearch+'%'' 
									OR C1.ContactName LIKE N''%'+@TxtSearch+'%'' 
									OR C1.HomeAddress LIKE N''%'+@TxtSearch+'%'' 
									OR C1.HomeMobile LIKE N''%'+ @TxtSearch+'%'' 
									OR C1.HomeTel LIKE N''%'+@TxtSearch + '%'' 
									OR C1.HomeEmail LIKE N''%'+@TxtSearch+'%'')'
	
	IF Isnull(@ConditionContactID,'')!=''
		SET @sWhere = @sWhere + ' AND ISNULL(C1.CreateUserID,'''') in ('''+@ConditionContactID+''' )'
	SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
				FROM (
						SELECT DISTINCT C1.APK
						, C1.DivisionID
						, C1.ContactID
						, CASE WHEN ISNULL(C1.ContactName, '''')= '''' THEN LastName ELSE C1.ContactName END AS ContactName
						, HomeAddress
						, C1.HomeMobile
						, C1.HomeTel
						, C1.HomeEmail
						, C1.IsCommon
						, C1.Disabled
						, C1.TitleContact
						FROM CRMT10001 C1 WITH (NOLOCK)
						LEFT JOIN CRMT10102 C2 WITH (NOLOCK) ON C1.ContactID = C2.ContactID
						LEFT JOIN CRMT20501_CRMT10001_REL C3 WITH (NOLOCK) ON C1.APK = C3.ContactID
						WHERE C1.Disabled = 0 
								AND C1.DivisionID  IN (''' + @DivisionID + ''' , ''@@@'')
						  ' + @sWhere + ' 
				  ) AS Contact
				ORDER BY ' + @OrderBy + '
				OFFSET ' + STR((@PageNumber-1) * @PageSize) + ' ROWS
				FETCH NEXT ' + STR(@PageSize)+' ROWS ONLY '
EXEC (@sSQL)
PRINT(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
