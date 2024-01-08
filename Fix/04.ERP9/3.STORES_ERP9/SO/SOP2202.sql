IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2202]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2202]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <History>
----Created by: Hoàng Long, Date: 01/12/2023
-- <Example>

CREATE PROCEDURE [dbo].[SOP2202] (
	 @DivisionID VARCHAR(50),
	 @APK VARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',	
		@sWhere  NVARCHAR(max) = ''
			
BEGIN
SET @sWhere = @sWhere + 'AND (CONVERT(VARCHAR(50),S1.APK)= '''+@APK+''')'
END

SET @sSQL= N'SELECT S1.APK, S1.DivisionID, S1.AccountNo, S1.AccountName, S1.Tel
				  , ( CASE WHEN S1.Type = ''0'' THEN N''T-Card''
					       WHEN S1.Type = ''1'' THEN N''D-Card'' 
					  END) AS Type
				  , ( CASE WHEN S1.AccountType = ''0'' THEN N''Doanh nghiệp''
					       WHEN S1.AccountType = ''1'' THEN N''Cá nhân'' 
					  END) AS AccountType
				  , S1.CCCD, S1.BirthDay, S1.Address, S1.Province, S1.District, S1.MstNumber, S1.AccountDate
				  , ( CASE WHEN S1.Status = ''0'' THEN N''Hoạt động''
					       WHEN S1.Status = ''1'' THEN N''Không hoạt động'' 
					  END) AS Status
				  , S1.CompanyName, S1.Representative, S1.MstCompany, S1.ApartmentCompany, S1.RoadCompany, S1.WardCompany, S1.DistrictCompany, S1.ProvinceCompany, S1.ApartmentShop
				  , S1.RoadShop, S1.WardShop, S1.DistrictShop, S1.ProvinceShop, S1.EmailShop, S1.TypeStore, S1.AreaStore, S1.TotalRevenue, S1.AirConditionerSales
				  , S1.CustomerClassification, S1.FinancialCapacity, S1.StrongSelling1, S1.StrongSelling2, S1.StrongSelling3, S1.ImportSource1, S1.ImportSource2, S1.ImportSource3
				  , S1.SellGree, S1.GreeDisplay, S1.SellingCapacity, S1.ClassificationCustomer, S1.CreateDate, S1.CreateUserID, S1.LastModifyUserID, S1.LastModifyDate
				FROM SOT2200 (NOLOCK) AS S1
				WHERE S1.DivisionID = '''+@DivisionID+''' '+@sWhere+''

		EXEC (@sSQL)
		PRINT (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
