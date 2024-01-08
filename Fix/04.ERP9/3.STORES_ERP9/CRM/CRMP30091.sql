IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30091]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30091]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- In bao cao Tổng hợp số lượng khách hàng theo nhân viên - CRMR3009
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create ON 27/06/2017 by Cao Thị Phượng
--- Modify by Thị Phượng, Date 04/07/2017: Bổ sung phân quyền
--- Modify by Hoàng vũ, Date 25/09/2018: Convert chuyển lấy dữ liệu khách hàng CRM (CRMT10101)-> Khách hàng POS (POST0011)
-- <Example> EXEC CRMP30091 'AS', '', 1, '2017-01-01', '2017-06-30', '06/2017'',''06/2017', 'B-D-0000000000000002', 'KH0009', 'Hoang', 'VU', '', 'VU' 

CREATE PROCEDURE [dbo].[CRMP30091] (
				@DivisionID			NVARCHAR(50),	--Biến môi trường
				@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
				@IsDate				TINYINT,		--1: Theo ngày; 0: Theo kỳ
				@FromDate			DATETIME, 
				@ToDate				DATETIME, 
				@PeriodIDList		NVARCHAR(2000),
				@FromAccountID		NVARCHAR(MAX) = '',
				@ToAccountID		NVARCHAR(MAX) = '',
				@FromEmployeeID		NVARCHAR(MAX) = '',
				@ToEmployeeID		NVARCHAR(MAX) = '',				
				@UserID				NVARCHAR(50),
				@ConditionObjectID nvarchar(max),	--Biến môi trường
				@AccountID			NVARCHAR(MAX) = '',
				@EmployeeID			NVARCHAR(MAX) = ''
				)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(max),
			@sWhere NVARCHAR(max),
			@sWhere2 Nvarchar(Max),
			@sSELECT nvarchar(max),
			@sGROUPBY nvarchar(max)
	Set @sWhere = ''
    Set @sWhere2 = ''
	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere2 = ' CR01.DivisionID IN ('''+@DivisionIDList+''',''@@@'')'
	ELSE 
		SET @sWhere2 = ' CR01.DivisionID in( N'''+@DivisionID+''',''@@@'')'	

	--Search theo điều điện thời gian
	IF @IsDate = 1	
	BEGIN
	
		SET @sWhere2 = @sWhere2 + ' AND CONVERT(VARCHAR,CR01.CreateDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	
	END
	ELSE
	BEGIN
		
		SET @sWhere2 = @sWhere2 + ' AND (Case When  Month(CR01.CreateDate) <10 then ''0''+rtrim(ltrim(str(Month(CR01.CreateDate))))+''/''+ltrim(Rtrim(str(Year(CR01.CreateDate)))) 
										Else rtrim(ltrim(str(Month(CR01.CreateDate))))+''/''+ltrim(Rtrim(str(Year(CR01.CreateDate)))) End) IN ('''+@PeriodIDList+''')'
	
	END

	--Search theo khách hàng (Dữ liệu khách hàng nhiều nên dùng control từ khách hàng, đến khách hàng)
	IF Isnull(@FromAccountID, '')!= '' and Isnull(@ToAccountID, '') = ''
		SET @sWhere = @sWhere + ' AND Isnull(CR01.MemberID, '''') > = N'''+@FromAccountID +''''
	ELSE IF Isnull(@FromAccountID, '') = '' and Isnull(@ToAccountID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(CR01.MemberID, '''') < = N'''+@ToAccountID +''''
	ELSE IF Isnull(@FromAccountID, '') != '' and Isnull(@ToAccountID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(CR01.MemberID, '''') Between N'''+@FromAccountID+''' AND N'''+@ToAccountID+''''

	--Search theo người bán hàng (Dữ liệu khách hàng nhiều nên dùng control từ người bán hàng, đến người bán hàng)
	IF Isnull(@FromEmployeeID, '')!= '' and Isnull(@ToEmployeeID, '') = ''
		SET @sWhere = @sWhere + ' AND Isnull(CR01.AssignedToUserID, '''') > = N'''+@FromEmployeeID +''''
	ELSE IF Isnull(@FromEmployeeID, '') = '' and Isnull(@ToEmployeeID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(CR01.AssignedToUserID, '''') < = N'''+@ToEmployeeID +''''
	ELSE IF Isnull(@FromEmployeeID, '') != '' and Isnull(@ToEmployeeID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(CR01.AssignedToUserID, '''') Between N'''+@FromEmployeeID+''' AND N'''+@ToEmployeeID+''''

	-- Danh sách khách hàng
	IF ISNULL(@AccountID, '') != ''
		SET @sWhere = @sWhere + 'AND CR01.MemberID IN ( SELECT * FROM StringSplit(REPLACE('''+@AccountID+''', '''', ''''), '','') ) '

	-- Danh sách Nhân viên
	IF ISNULL(@EmployeeID, '') != ''
		SET @sWhere = @sWhere + 'AND CR01.AssignedToUserID IN ( SELECT * FROM StringSplit(REPLACE('''+@EmployeeID+''', '''', ''''), '','') ) '

		--Tab phần quyền chi tiết dữ liệu
	IF Isnull(@ConditionObjectID,'')!=''
		SET @sWhere = @sWhere + ' AND isnull(CR01.AssignedToUserID, CR01.CreateUserID) in ('''+@ConditionObjectID+''' )'

--Lấy kết quả
	
	SET @sSQL = ' 
			SELECT  CR01.DivisionID, CR01.MemberID as AccountID,  CR01.AssignedToUserID as EmployeeID, AT03.FullName as EmployeeName,
			D.OrderQuantity, D.ConvertedAmount, D.OriginalAmount
			Into #CRMP30091
			FROM POST0011 CR01 WITH (NOLOCK)
			LEFT JOIN OT2001 M WITH (NOLOCK) ON CR01.MemberID = M.ObjectID
			LEFT JOIN OT2002 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.SorderID = D.SorderID and M.OrderType = 0 and M.IsConfirm = 1
			LEFT JOIN AT1103 AT03 WITH (NOLOCK) ON AT03.EmployeeID = CR01.AssignedToUserID
			WHERE '+@sWhere2 + @sWHERE + ' AND CR01.AssignedToUserID IS NOT NULL

			Select  M.DivisionID, AT01.DivisionName , M.EmployeeID, M.EmployeeName,  COUNT(Distinct M.AccountID) as Quantity,
			SUM(isnull(M.ConvertedAmount,0)) as ConvertedAmount, SUM(isnull(M.OriginalAmount,0)) as OriginalAmount  
			FROM #CRMP30091 M
			LEFT JOIN AT1101 AT01 WITH (NOLOCK) ON AT01.DivisionID = M.DivisionID
			Group by   M.DivisionID, M.EmployeeID, M.EmployeeName, AT01.DivisionName
			Order by  M.DivisionID,M.EmployeeID'
	EXEC (@sSQL)
	PRINT (@sSQL)
END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
