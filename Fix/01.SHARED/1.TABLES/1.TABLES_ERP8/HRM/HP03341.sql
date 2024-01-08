IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP03341]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP03341]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- 
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Khanh Van on: 10/12/2013
---- Modified by Thanh Sơn on 31/03/2015: Bổ sung điều kiện chỉ đếm những người còn phụ thuộc
---- Modified by Phương Thảo on 28/09/2017: Bổ sung @Mode = 1: Dùng để xuất excel
-- <Example>
/*
	exec HP03341 'MK',1
*/

CREATE PROCEDURE HP03341
( 
	@DivisionID as nvarchar(50),
	@Mode as Tinyint = 0 -- 0: Đổ lưới truy vấn, 1: export excel
) 
AS 

IF(@Mode = 0)
BEGIN
	SELECT H34.EmployeeID, V40.FullName, V40.DepartmentName, V40.Birthday, V40.FullAddress, V40.HomePhone, H34.[Status],
		MAX(H34.CreateDate) AS CreateDate, COUNT(H34.TransactionID) MemberQuantity
	FROM HT0334 H34
		LEFT JOIN HV1400 V40 ON V40.DivisionID = H34.DivisionID AND V40.EmployeeID = H34.EmployeeID
	WHERE H34.DivisionID = @DivisionID
		AND H34.[Status] = 0 
	GROUP BY H34.EmployeeID, V40.FullName, V40.DepartmentName, V40.Birthday, V40.FullAddress, V40.HomePhone, H34.[Status]
END
ELSE
BEGIN
	SELECT H34.EmployeeID, V40.FullName, V40.DepartmentName, V40.Birthday, V40.FullAddress, V40.HomePhone, 
		   H34.RelationName, H34.RelationBirthday, 	H34.RelationTaxID, H34.NationalityID, H34.RelationIdentifyCardNo,
		   H34.RelationID, A22.RelationName, H34.CertificateNo, H34.CertifiBook, H34.CountryID, A01.CountryName,
		   H34.CityID, A02.CityName, H34.DistrictID, A13.DistrictName, 
		   H34.WardID, A14.WardName, H34.FromPeriod, H34.ToPeriod, 
		   H34.Description, H34.EndDate, H34.Status
	FROM HT0334 H34
	LEFT JOIN HV1400 V40 ON V40.DivisionID = H34.DivisionID AND V40.EmployeeID = H34.EmployeeID
	LEFT JOIN AT1022 A22 WITH(NOLOCK) ON H34.RelationID = A22.RelationID
	LEFT JOIN AT1001 A01 WITH(NOLOCK) ON H34.CountryID = A01.CountryID
	LEFT JOIN AT1002 A02 WITH(NOLOCK) ON H34.CityID = A02.CityID
	LEFT JOIN AT1013 A13 WITH(NOLOCK) ON H34.DistrictID = A13.DistrictID
	LEFT JOIN AT1014 A14 WITH(NOLOCK) ON H34.WardID = A14.WardID
	WHERE H34.DivisionID = @DivisionID
		AND H34.[Status] = 0 
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

