IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2243]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2243]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load màn hình chọn Khách hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by:Hoài Bảo Date 28/03/2022
-- <Example>
/*	EXEC CRMP2243 @DivisionID=N'DTI',@TxtSearch=N'',@UserID=N'ASOFTADMIN',@PageNumber=N'1',@PageSize=N'25'
*/

 CREATE PROCEDURE CRMP2243 (
    @DivisionID NVARCHAR(2000),
    @TxtSearch NVARCHAR(250),
	@UserID VARCHAR(50),
    @PageNumber INT,
    @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
		@sWhere1 NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)


	SET @sWhere = ''
	SET @sWhere1 = ''
	SET @TotalRow = ''
	SET @OrderBy = ' M.MemberID'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'
	
	IF ISNULL(@TxtSearch,'') != ''  SET @sWhere = @sWhere +'
							AND (M.MemberID LIKE N''%'+@TxtSearch+'%'' 
							OR M.MemberName LIKE N''%'+@TxtSearch+'%'' 
							OR M.[Address] LIKE N''%'+@TxtSearch+'%''
							OR M.Phone LIKE N''%'+@TxtSearch+'%''
							OR M.Fax LIKE N''%'+@TxtSearch+'%''
							OR M.Email LIKE N''%'+@TxtSearch+'%'')'

	SET @sWhere1 = @sWhere1 + 'P11.DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND ISNULL(P11.[Disabled], 0) = 0'

	SET @sSQL = '
				Select  ROW_NUMBER() OVER (ORDER BY M.MemberID) AS RowNum, COUNT(*) OVER () AS TotalRow
				 , M.APK, M.DivisionID, M.MemberID, M.MemberName, M.[Address], M.Identify, M.Phone
						   , M.Fax, M.Email, M.Birthday, M.AreaID, M.CityID, M.CountryID, M.AccruedScore, M.[Disabled], M.VATNo, M.CompanyName, M.CompanyAddress
						   , M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
				From (
				   SELECT  APK, DivisionID, MemberID, MemberName, [Address], Identify, IIF(ISNULL(P11.Phone, '''') != '''', P11.Tel, P11.Phone) AS Phone
						   , Fax, Email, Birthday, AreaID, CityID, CountryID, AccruedScore, [Disabled], VATNo, CompanyName, CompanyAddress
						   , CreateUserID, CreateDate, LastModifyUserID, LastModifyDate
				   FROM POST0011 P11
				   WHERE ' + @sWhere1 + '
				 ) M
				Where 1=1  '+@sWhere+'
				Order by M.MemberID
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT  '+STR(@PageSize)+' ROWS ONLY'
	--PRINT (@sSQL)
	EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
