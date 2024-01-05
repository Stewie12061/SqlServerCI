IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30111]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30111]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- In bao cao Phễu bán hàng theo công ty - CRMR3011
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Create ON 29/06/2017 by Phan thanh hoàng Vũ
--- Modify by Hoàng Vũ, Date 06/07/2017: Cải tiến tốc độ
--- Modify by Hoàng vũ, Date 25/09/2018: Convert chuyển lấy dữ liệu khách hàng CRM (CRMT10101)-> Khách hàng POS (POST0011)
--- Modify by Hoài Bảo, Date 03/10/2022: Điều chỉnh cách tính tỉ lệ
--- Modify by Anh Đô, Date 05/12/2022: Select thêm các cột TotalContact, ContactToCustomer, TotalOpportunityFromLead, TotalCustomerFromLead, TotalCustomerFromOpportunity, TotalCustomerFromContact
--- Modify by Anh Đô, Date 30/12/2022: Fix lỗi dữ liệu ở các cột TotalCustomerFromLead, TotalContact không chính xác, format lại code.
-- <Example> EXEC CRMP30111 1, 'AS', 'AS'',''GS'',''GC'',''HT', 1, '2017-01-01', '2017-06-30', '06/2017',  '' 

CREATE PROCEDURE [dbo].[CRMP30111] (
				@IsDivisionID		TINYINT,		--1: Tất cả đơn vị; 0: Từng đơn vị
				@DivisionID			NVARCHAR(50),	--Biến môi trường
				@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdownchecklisk đơn vị
				@IsDate				TINYINT,		--1: Theo ngày; 0: Theo kỳ
				@FromDate			DATETIME, 
				@ToDate				DATETIME, 
				@PeriodIDList		NVARCHAR(2000), --Giá trị truyền Dropdownchecklisk theo kỳ
				@UserID				NVARCHAR(50)	--Biến môi trường
				)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(MAX),
			@sWhere NVARCHAR(MAX)
			
	SET @sWhere = ''
    	
	--Search theo điều kiện đơn vị
	IF @IsDivisionID = 1 --Tất cả đơn vị hay công ty
	BEGIN
			--Search theo điều điện thời gian
			IF @IsDate = 1	--Theo ngày
				SET @sWhere = @sWhere + ' CONVERT(VARCHAR,CreateDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
			ELSE --Theo kỳ
				SET @sWhere = @sWhere + ' (CASE WHEN  MONTH(CreateDate) <10 then ''0''+RTRIM(LTRIM(STR(MONTH(CreateDate))))+''/''
												+LTRIM(RTRIM(STR(YEAR(CreateDate)))) Else RTRIM(LTRIM(STR(MONTH(CreateDate))))+''/''
												+LTRIM(RTRIM(STR(YEAR(CreateDate)))) End) IN ('''+@PeriodIDList+''')'

			SET @sSQL = '   SELECT CAST(Count(LeadID) AS Decimal(28,8)) AS TotalLead, CAST(0 AS Decimal(28,8)) AS TotalOpportunity, CAST(0 AS Decimal(28,8)) AS TotalCustomerFromLead, CAST(0 AS Decimal(28,8)) AS TotalCustomerFromOpportunity
							INTO #ResultDivisionID
							FROM CRMT20301 WITH (NOLOCK)
							WHERE ISNULL(DeleteFlg,0) = 0 AND ' + @sWhere +'
							UNION ALL
							SELECT CAST(0 AS Decimal(28,8)), CAST(COUNT(OpportunityID) AS Decimal(28,8)), CAST(0 AS Decimal(28,8)), CAST(0 AS Decimal(28,8))
							FROM CRMT20501 WITH (NOLOCK)
							WHERE ISNULL(DeleteFlg,0) = 0 AND ' + @sWhere +'
							UNION ALL
							SELECT CAST(0 AS Decimal(28,8)), CAST(0 AS Decimal(28,8)), CAST(COUNT(MemberID) AS Decimal(28,8)), CAST(0 AS Decimal(28,8))
							FROM POST0011 WITH (NOLOCK)
							CROSS APPLY (SELECT LeadID FROM CRMT20301 WITH (NOLOCK) WHERE POST0011.InheritConvertID = CRMT20301.LeadID) CRMT20301
							WHERE ' + @sWhere +' AND ISNULL(POST0011.DeleteFlg,0) = 0 AND InheritConvertID IS NOT NULL 
							UNION ALL
							SELECT CAST(0 AS Decimal(28,8)), CAST(0 AS Decimal(28,8)), CAST(0 AS Decimal(28,8)), CAST(COUNT(MemberID) AS Decimal(28,8))
							FROM POST0011 WITH (NOLOCK)
							CROSS APPLY (SELECT OpportunityID FROM CRMT20501 WITH (NOLOCK) WHERE POST0011.InheritConvertID = CRMT20501.OpportunityID) CRMT20501
							WHERE ' + @sWhere +' AND ISNULL(POST0011.DeleteFlg,0) = 0 AND InheritConvertID IS NOT NULL 
					
							Select  '''' AS DivisionID, '''' AS DivisionName
									, SUM(M.TotalLead) AS TotalLead
									, SUM(M.TotalOpportunity) AS TotalOpportunity
									, SUM(M.TotalCustomerFromLead + M.TotalCustomerFromOpportunity) AS TotalCustomer
									, CASE WHEN SUM(M.TotalLead) != 0 then SUM(M.TotalOpportunity)/SUM(M.TotalLead) else 0 end AS LeadToOpportunity
									, CASE WHEN SUM(M.TotalLead) != 0 then SUM(M.TotalCustomerFromLead)/SUM(M.TotalLead) else 0 end AS LeadToCustomer
									, CASE WHEN SUM(M.TotalOpportunity) != 0 then SUM(M.TotalCustomerFromOpportunity)/SUM(M.TotalOpportunity) else 0 end AS OpportunityToCustomer
							From #ResultDivisionID M
							'
	END
	ELSE --Từng đơn vị
	BEGIN
		--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
		IF ISNULL(@DivisionIDList, '') != ''
			SET @sWhere = @sWhere + ' DivisionID IN ('''+@DivisionIDList+''', ''@@@'')'
		ELSE 
			SET @sWhere = @sWhere + ' DivisionID IN ('''+@DivisionID+''', ''@@@'')'

		--Search theo điều điện thời gian
		IF @IsDate = 1	--Theo ngày
			SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,CreateDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
		ELSE --Theo kỳ
			SET @sWhere = @sWhere + ' AND (CASE WHEN MONTH(CreateDate) < 10 then ''0'' +RTRIM(LTRIM(STR(MONTH(CreateDate)))) + ''/''
											+ LTRIM(RTRIM(STR(YEAR(CreateDate)))) ELSE RTRIM(LTRIM(STR(MONTH(CreateDate)))) + ''/''
											+ LTRIM(RTRIM(STR(YEAR(CreateDate)))) END) IN ('''+@PeriodIDList+''')'

	
		SET @sSQL = 'SELECT DivisionID
						, CAST(Count(LeadID) AS Decimal(28,8)) AS TotalLead
						, CAST(0 AS Decimal(28,8)) AS TotalOpportunity
						, CAST(0 AS Decimal(28,8)) AS TotalCustomerFromLead
						, CAST(0 AS Decimal(28,8)) AS TotalCustomerFromOpportunity
						, CAST(0 AS Decimal(28,8)) AS TotalContact
						, CAST(0 AS Decimal(28,8)) AS TotalCustomerFromContact
						, CAST(0 AS Decimal(28,8)) AS TotalOpportunityFromLead
					INTO #ResultDivisionID
					FROM CRMT20301 WITH (NOLOCK)
					WHERE ISNULL(DeleteFlg,0) = 0 AND ' + @sWhere +'
					GROUP BY DivisionID

					UNION ALL
					SELECT DivisionID
						, CAST(0 AS Decimal(28,8))
						, CAST(COUNT(OpportunityID) AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
					FROM CRMT20501 WITH (NOLOCK)
					WHERE ISNULL(DeleteFlg,0) = 0 AND ' + @sWhere +'
					GROUP BY DivisionID

					UNION ALL
					SELECT DivisionID
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(COUNT(MemberID) AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
					FROM POST0011 WITH (NOLOCK)
					WHERE ISNULL(DeleteFlg, 0) = 0 AND ConvertType = 1 AND ' + @sWhere +'
					GROUP BY DivisionID

					UNION ALL
					SELECT DivisionID
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(COUNT(MemberID) AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
					FROM POST0011 P WITH (NOLOCK)
					WHERE P.ConvertType = 4 AND ISNULL(P.DeleteFlg, 0) = 0 AND '+  @sWhere +'
					GROUP BY DivisionID

					UNION ALL
					SELECT
						C.DivisionID
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(COUNT(C.ContactID) AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
					FROM CRMT10001 C WHERE ISNULL(C.DeleteFlg, 0) = 0 AND ' + @sWhere +'
					GROUP BY C.DivisionID

					UNION ALL
					SELECT
						P.DivisionID
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(COUNT(P.MemberID) AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
					FROM POST0011 P WHERE ISNULL(P.DeleteFlg, 0) = 0 AND P.ConvertType = 2 AND ' + @sWhere +'
					GROUP BY P.DivisionID

					UNION ALL
					SELECT
						C.DivisionID
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(0 AS Decimal(28,8))
						, CAST(COUNT(*) AS DECIMAL(28, 8))
					FROM CRMT20501_CRMT20301_REL CR
					LEFT JOIN CRMT20501 C ON C.APK = CR.OpportunityID
					WHERE '+ @sWhere +'
					GROUP BY C.DivisionID

					SELECT
						R.DivisionID
						, A1.DivisionName
						, SUM(R.TotalLead) AS TotalLead
						, SUM(R.TotalOpportunity) AS TotalOpportunity
						, SUM(R.TotalContact) AS TotalContact
						, SUM(R.TotalCustomerFromLead) AS TotalCustomerFromLead
						, SUM(R.TotalCustomerFromOpportunity) AS TotalCustomerFromOpportunity
						, SUM(R.TotalCustomerFromContact) AS TotalCustomerFromContact
						, SUM(R.TotalOpportunityFromLead) AS TotalOpportunityFromLead
						, CASE WHEN SUM(R.TotalLead) != 0 THEN SUM(R.TotalCustomerFromLead) / SUM(R.TotalLead) ELSE 0 END AS LeadToCustomer
						, CASE WHEN SUM(R.TotalOpportunity) != 0 THEN SUM(R.TotalCustomerFromOpportunity) / SUM(R.TotalOpportunity) ELSE 0 END AS OpportunityToCustomer
						, CASE WHEN SUM(R.TotalContact) != 0 THEN SUM(R.TotalCustomerFromContact) / SUM(R.TotalContact) ELSE 0 END AS ContactToCustomer
						, CASE WHEN SUM(R.TotalLead) != 0 THEN SUM(R.TotalOpportunityFromLead) / SUM(R.TotalLead) ELSE 0 END AS LeadToOpportunity
						, (SUM(R.TotalCustomerFromLead) + SUM(R.TotalCustomerFromContact) + SUM(R.TotalCustomerFromOpportunity)) AS TotalCustomer
					FROM #ResultDivisionID R
					LEFT JOIN AT1101 A1 ON A1.DivisionID = R.DivisionID
					GROUP BY A1.DivisionName, R.DivisionID
					'
	END

	PRINT (@sSQL)
	EXEC (@sSQL)
	
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
