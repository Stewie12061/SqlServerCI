IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30102]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30102]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In bao cao Phễu bán hàng theo nhân viên - CRMR3010
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create ON 29/06/2017 by Phan thanh hoàng Vũ
--- Modify by Thị Phượng, Date 04/07/2017: Bổ sung phân quyền
--- Modify by Hoàng Vũ, Date 06/07/2017: Cải tiến tốc độ
--- Modify by Hoàng vũ, Date 25/09/2018: Convert chuyển lấy dữ liệu khách hàng CRM (CRMT10101)-> Khách hàng POS (POST0011)
--- Modify by Anh Đô, Date 07/12/2022: Bổ sung thêm các cột TotalContact, ContactToCustomer, TotalOpportunityFromLead, TotalCustomerFromLead, TotalCustomerFromOpportunity, TotalCustomerFromContact
--- Modify by Anh Đô, Date 28/12/2022: Fix lỗi dữ liệu cột TotalCustomerFromLead không chính xác.
-- <Example> EXEC CRMP30102 'AS', 'AS'',''GS'',''GC', 1, '2017-01-01', '2017-06-30', '06/2017', '', '', '' , 'Vu', 'Vu', 'Vu'

CREATE PROCEDURE [dbo].[CRMP30102] (
				@DivisionID					NVARCHAR(50),	--Biến môi trường
				@DivisionIDList				NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
				@IsDate						TINYINT,		--1: Theo ngày; 0: Theo kỳ
				@FromDate					DATETIME, 
				@ToDate						DATETIME, 
				@PeriodIDList				NVARCHAR(2000),
				@FromSalesManID				NVARCHAR(MAX),
				@ToSalesManID				NVARCHAR(MAX),
				@UserID						NVARCHAR(50),
				@ConditionLeadID			nvarchar(max),
				@ConditionOpportunityID		nvarchar(max),
				@ConditionObjectID			nvarchar(max)	--Biến môi trường
				)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(max),
		@sWhere NVARCHAR(max),
		@sWhere3 Nvarchar(Max),
		@sWhere4 Nvarchar(Max),
		@sWhere5 Nvarchar(Max),
		@sWhere6 NVARCHAR(MAX)
			
Set @sWhere = ''	
SET @sWhere3 = ''
SET @sWhere4 = ''
SET @sWhere5 = ''
SET @sWhere6 = ''
    
	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWHERE = @sWHERE + ' DivisionID IN ('''+@DivisionIDList+''', ''@@@'')'
	ELSE 
		SET @sWHERE = @sWHERE + ' DivisionID IN ('''+@DivisionID+''', ''@@@'')'

	--Search theo điều điện thời gian
	IF @IsDate = 1	
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,CreateDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	ELSE
		SET @sWhere = @sWhere + ' AND (Case When  Month(CreateDate) <10 then ''0''+rtrim(ltrim(str(Month(CreateDate))))+''/''
										+ltrim(Rtrim(str(Year(CreateDate)))) Else rtrim(ltrim(str(Month(CreateDate))))+''/''
										+ltrim(Rtrim(str(Year(CreateDate)))) End) IN ('''+@PeriodIDList+''')'
		SET @sWhere6 = @sWhere
	
	--Search theo người bán hàng (Dữ liệu khách hàng nhiều nên dùng control từ người bán hàng, đến người bán hàng)
	--IF Isnull(@FromSalesManID, '')!= '' and Isnull(@ToSalesManID, '') = ''
	--BEGIN
	--	SET @sWhere = @sWhere + ' AND Isnull(AssignedToUserID, CreateUserID) > = N'''+@FromSalesManID +''''
	--	SET @sWhere6 = @sWhere6 + ' AND Isnull(CreateUserID, '''') > = N'''+@FromSalesManID +''''
	--END
	--ELSE IF Isnull(@FromSalesManID, '') = '' and Isnull(@ToSalesManID, '') != ''
	--BEGIN
	--	SET @sWhere = @sWhere + ' AND Isnull(AssignedToUserID, CreateUserID) < = N'''+@ToSalesManID +''''
	--	SET @sWhere6 = @sWhere6 + ' AND Isnull(CreateUserID, '''') < = N'''+@ToSalesManID +''''
	--END
	--ELSE IF Isnull(@FromSalesManID, '') != '' and Isnull(@ToSalesManID, '') != ''
	--BEGIN
	--	SET @sWhere = @sWhere + ' AND Isnull(AssignedToUserID, CreateUserID) Between N'''+@FromSalesManID+''' AND N'''+@ToSalesManID+''''
	--	SET @sWhere6 = @sWhere6 + ' AND Isnull(CreateUserID, '''') Between N'''+@FromSalesManID+''' AND N'''+@ToSalesManID+''''
	--END
	IF ISNULL(@FromSalesManID, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND ISNULL(AssignedToUserID, CreateUserID) IN ('''+ @FromSalesManID +''') '
		SET @sWhere6 = @sWhere6 + ' AND ISNULL(CreateUserID, '''') IN ('''+ @FromSalesManID +''') '
	END
	--Phân quyền dữ liệu
	IF Isnull(@ConditionLeadID,'')!=''
		SET @sWhere3 = @sWhere3 + ' AND ISNULL(CRMT20301.AssignedToUserID,CRMT20301.CreateUserID) in ('''+@ConditionLeadID+''' )'
	IF Isnull(@ConditionOpportunityID, '') != ''
	Begin
		SET @sWhere4 = @sWhere4 + ' AND ISNULL(CRMT20501.AssignedToUserID,CRMT20501.CreateUserID) in (N'''+@ConditionOpportunityID+''' )'
	End
	IF Isnull(@ConditionObjectID,'')!=''
		SET @sWhere5 = @sWhere5 + ' AND (Case When ISNULL(POST0011.AssignedToUserID,'''') != '''' then POST0011.AssignedToUserID Else POST0011.CreateUserID End ) in ('''+@ConditionObjectID+''' )'

	SET @sSQL = '   
					SELECT DivisionID
						, Isnull(AssignedToUserID, CreateUserID) as SalemanID
						, Cast(Count(LeadID) as Decimal(28,8)) as TotalLead
						, Cast(0 as Decimal(28,8)) as TotalOpportunity
						, Cast(0 as Decimal(28,8)) as TotalCustomer
						, CAST(0 AS DECIMAL(28, 8)) AS TotalContact
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromLead
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromOpportunity
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromContact
						, CAST(0 AS DECIMAL(28, 8)) AS TotalOpportunityFromLead
					into #Result
					FROM CRMT20301 WITH (NOLOCK)
					WHERE '+ @sWhere + @sWhere3 +' AND ISNULL(DeleteFlg, 0) = 0
					GROUP BY DivisionID, Isnull(AssignedToUserID, CreateUserID)
					
					UNION ALL
					SELECT DivisionID
						, Isnull(AssignedToUserID, CreateUserID)
						, Cast(0 as Decimal(28,8)) as TotalLead
						, Cast(COUNT(OpportunityID) as Decimal(28,8)) as TotalOpportunity
						, Cast(0 as Decimal(28,8)) as TotalCustomer
						, CAST(0 AS DECIMAL(28, 8)) AS TotalContact
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromLead
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromOpportunity
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromContact
						, CAST(0 AS DECIMAL(28, 8)) AS TotalOpportunityFromLead
					FROM CRMT20501 WITH (NOLOCK)
					WHERE '+ @sWhere + @sWhere4 +' AND ISNULL(DeleteFlg, 0) = 0
					GROUP BY DivisionID, Isnull(AssignedToUserID, CreateUserID)
					
					UNION ALL
					SELECT DivisionID
						, Isnull(AssignedToUserID, CreateUserID)
						, Cast(0 as Decimal(28,8)) as TotalLead
						, Cast(0 as Decimal(28,8)) as TotalOpportunity
						, Cast(COUNT(MemberID) as Decimal(28,8)) as TotalCustomer
						, CAST(0 AS DECIMAL(28, 8)) AS TotalContact
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromLead
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromOpportunity
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromContact
						, CAST(0 AS DECIMAL(28, 8)) AS TotalOpportunityFromLead
					FROM POST0011 WITH (NOLOCK)
					WHERE '+ @sWhere + @sWhere5 +' AND InheritConvertID IS NOT NULL AND ISNULL(DeleteFlg, 0) = 0
					GROUP BY DivisionID, Isnull(AssignedToUserID, CreateUserID)

					UNION ALL
					SELECT DivisionID
						, CreateUserID
						, Cast(0 as Decimal(28,8)) as TotalLead
						, Cast(0 as Decimal(28,8)) as TotalOpportunity
						, CAST(0 AS DECIMAL(28, 8)) as TotalCustomer
						, COUNT(CreateUserID) AS TotalContact
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromLead
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromOpportunity
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromContact
						, CAST(0 AS DECIMAL(28, 8)) AS TotalOpportunityFromLead
					FROM CRMT10001 c WITH (NOLOCK)
					WHERE '+ @sWhere6 +' AND ISNULL(c.DeleteFlg, 0) = 0
					GROUP BY DivisionID, CreateUserID

					UNION ALL
					SELECT DivisionID
						, Isnull(AssignedToUserID, CreateUserID)
						, Cast(0 as Decimal(28,8)) as TotalLead
						, Cast(0 as Decimal(28,8)) as TotalOpportunity
						, CAST(0 AS DECIMAL(28, 8)) as TotalCustomer
						, CAST(0 AS DECIMAL(28, 8)) AS TotalContact
						, COUNT(p.APK) AS TotalCustomerFromLead
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromOpportunity
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromContact
						, CAST(0 AS DECIMAL(28, 8)) AS TotalOpportunityFromLead
					FROM POST0011 p WITH (NOLOCK)
					WHERE '+ @sWhere +' AND ISNULL(p.DeleteFlg,0) = 0 AND p.ConvertType = 1
					GROUP BY DivisionID, Isnull(AssignedToUserID, CreateUserID)' + '

					UNION ALL
					SELECT DivisionID
						, Isnull(AssignedToUserID, CreateUserID)
						, Cast(0 as Decimal(28,8)) as TotalLead
						, Cast(0 as Decimal(28,8)) as TotalOpportunity
						, CAST(0 AS DECIMAL(28, 8)) as TotalCustomer
						, CAST(0 AS DECIMAL(28, 8)) AS TotalContact
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromLead
						, COUNT(p.APK) AS TotalCustomerFromOpportunity
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromContact
						, CAST(0 AS DECIMAL(28, 8)) AS TotalOpportunityFromLead
					FROM POST0011 p WITH (NOLOCK)
					WHERE '+ @sWhere +' AND p.ConvertType = 4 AND ISNULL(p.DeleteFlg, 0) = 0
					GROUP BY DivisionID, Isnull(AssignedToUserID, CreateUserID)

					UNION ALL
					SELECT DivisionID
						, Isnull(AssignedToUserID, CreateUserID)
						, Cast(0 as Decimal(28,8)) as TotalLead
						, Cast(0 as Decimal(28,8)) as TotalOpportunity
						, CAST(0 AS DECIMAL(28, 8)) as TotalCustomer
						, CAST(0 AS DECIMAL(28, 8)) AS TotalContact
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromLead
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromOpportunity
						, COUNT(p.APK) AS TotalCustomerFromContact
						, CAST(0 AS DECIMAL(28, 8)) AS TotalOpportunityFromLead
					FROM POST0011 p WITH (NOLOCK)
					WHERE '+ @sWhere +' AND p.ConvertType = 2 AND ISNULL(p.DeleteFlg, 0) = 0
					GROUP BY DivisionID, Isnull(AssignedToUserID, CreateUserID)

					UNION ALL
					SELECT DivisionID
						, Isnull(AssignedToUserID, CreateUserID)
						, Cast(0 as Decimal(28,8)) as TotalLead
						, Cast(0 as Decimal(28,8)) as TotalOpportunity
						, CAST(0 AS DECIMAL(28, 8)) as TotalCustomer
						, CAST(0 AS DECIMAL(28, 8)) AS TotalContact
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromLead
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromOpportunity
						, CAST(0 AS DECIMAL(28, 8)) AS TotalCustomerFromContact
						, COUNT(c.APK) AS TotalOpportunityFromLead
					FROM CRMT20501_CRMT20301_REL m WITH (NOLOCK)
					LEFT JOIN CRMT20301 c ON c.APK = m.LeadID
					WHERE '+ @sWhere +' AND ISNULL(c.DeleteFlg, 0) = 0
					GROUP BY DivisionID, Isnull(AssignedToUserID, CreateUserID)

					Select M.DivisionID, Y.DivisionName, M.SalemanID
							, Case when M.SalemanID = N''ASOFTADMIN'' then N''ASOFTADMIN'' Else Isnull(X.FullName, ''-'') end as SalemanName
							, Sum(M.TotalLead) as TotalLead
							, Sum(M.TotalOpportunity) as TotalOpportunity
							, Sum(M.TotalCustomer) as TotalCustomer
							, Case when Sum(M.TotalLead) != 0 then SUM(M.TotalOpportunityFromLead)/SUM(M.TotalLead) else 0 end as LeadToOpportunity
							, Case when Sum(M.TotalLead) != 0 then SUM(M.TotalCustomerFromLead)/SUM(M.TotalLead) else 0 end as LeadToCustomer
							, Case when Sum(M.TotalOpportunity) != 0 then SUM(M.TotalCustomerFromOpportunity)/SUM(M.TotalOpportunity) else 0 end as OpportunityToCustomer
							, CASE WHEN SUM(M.TotalContact) != 0 THEN SUM(M.TotalCustomerFromContact) / SUM(M.TotalContact) ELSE 0 END AS ContactToCustomer
							, SUM(M.TotalContact) AS TotalContact
							, SUM(M.TotalCustomerFromLead) AS TotalCustomerFromLead
							, SUM(M.TotalCustomerFromOpportunity) AS TotalCustomerFromOpportunity
							, SUM(M.TotalCustomerFromContact) AS TotalCustomerFromContact
							, SUM(M.TotalOpportunityFromLead) AS TotalOpportunityFromLead
					From #Result M Left join AT1103 X on M.SalemanID = X.EmployeeID
								   Left join AT1101 Y on M.DivisionID = Y.DivisionID
					Group by M.DivisionID, Y.DivisionName, M.SalemanID, Isnull(X.FullName, ''-'')'
	EXEC (@sSQL)
	PRINT (@sSQL)
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
