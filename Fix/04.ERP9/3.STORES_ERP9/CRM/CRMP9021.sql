IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP9021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP9021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Load màn hình chọn cuộc gọi
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Tấn Lộc Date 02/01/2019
-- Updated by: Hoài Bảo Date 13/10/2021 - Bổ sung load thêm cột Position và CompanyName
-- <Example>
/*
	EXEC CRMP9021 @DivisionID=N'KY',@TxtSearch=N'',@UserID=N'DANH',@PageNumber=N'1',@PageSize=N'10'
*/

CREATE PROCEDURE [dbo].[CRMP9021] (
	 @DivisionID NVARCHAR(2000),
	 @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
	 @sWhere NVARCHAR(MAX),
	 @OrderBy NVARCHAR(500),
	 @TotalRow NVARCHAR(50)

SET @sWhere = 'AND 1=1'
SET @OrderBy = 'M.VoucherBusiness'


IF ISNULL(@TxtSearch,'') != ''

	SET @sWhere = @sWhere + '
				 AND (M.VoucherBusiness LIKE N''%' + @TxtSearch + '%'' 
				OR M.VoucherBusinessName LIKE N''%' + @TxtSearch + '%'' 
				OR M.Address LIKE N''%' + @TxtSearch + '%''  
				OR M.Email LIKE N''%' + @TxtSearch + '%''
				OR M.Tel LIKE N''%' + @TxtSearch + '%'')'


SET @sSQL = '
Declare @TempListCall Table (
					  [APK] UNIQUEIDENTIFIER NULL,
					  [DivisionID] VARCHAR(50) NULL,
					  [VoucherBusiness] VARCHAR(50) NULL,
					  [VoucherBusinessName] NVARCHAR(MAX)  NULL,
					  [Address] NVARCHAR(250) NULL,
					  [Email] NVARCHAR(250) NULL,
					  [Tel] NVARCHAR(250) NULL,
					  [Position] NVARCHAR(MAX) NULL,
					  [CompanyName] NVARCHAR(MAX) NULL
					  )
		 Insert into @TempListCall (APK, DivisionID, VoucherBusiness, VoucherBusinessName, Address, Email, Tel, Position, CompanyName)
		 Select  M.APK, M.DivisionID, M.VoucherBusiness, M.VoucherBusinessName, M.Address, M.Email, M.Tel, M.Position, M.CompanyName
		 FROM (
				Select M.APK, M.DivisionID, M.ContactID as VoucherBusiness, M.ContactName as VoucherBusinessName, M.Address, 
								Isnull(M.HomeEmail, M.BusinessEmail) as Email, Isnull(M.HomeMobile, M.HomeTel) as Tel, M.TitleContact as Position,
								STUFF((SELECT '', '' + CONCAT(C1.AccountID,'' - '',A1.ObjectName)
								FROM CRMT10102 C1 
								LEFT JOIN AT1202 A1 WITH (NOLOCK) ON A1.ObjectID = C1.AccountID
								WHERE C1.ContactID = M.ContactID
								FOR XML PATH('''')), 1, 1, '''') AS CompanyName
				from CRMT10001 M
						Union all
				Select M.APK, M.DivisionID, M.LeadID, M.LeadName, M.Address, M.Email, M.LeadMobile, M.TitleID as Position, M.CompanyName
				from CRMT20301 M
				) M Where M.DivisionID = '''+ @DivisionID+''' AND Isnull(M.Tel, '''') != '''' '+@sWhere+'
			
		DECLARE @count int
		Select @count = Count(VoucherBusiness) From @TempListCall
		SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
						, M.APK, M.DivisionID
						, M.VoucherBusiness, M.VoucherBusinessName, M.Address, M.Email, M.Tel, M.Position, M.CompanyName
				FROM @TempListCall M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
EXEC (@sSQL)
PRINT(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
