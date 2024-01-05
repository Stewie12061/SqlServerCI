IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP21911]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP21911]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
----Load dữ liệu địa chỉ đối tượng bảo hành
-- <Param>
---- 
-- <Return>
---- 
-- <History
----Created by: Hồng Thắm, Date: 14/11/2023
----Updated by: Nhật Thanh, Date: 26/12/2023
-- <Example>

CREATE   PROCEDURE SOP21911
( 
	 @ObjectID VARCHAR(50),
	 @DivisionID VARCHAR(50)
)
AS 
Begin 
  SELECT 
	ROW_NUMBER () OVER (ORDER BY C.CreateDate) AS Orders   
	, CONCAT(C.DeliveryAddress
				, CASE WHEN ISNULL(C.DeliveryWard, '') = '' THEN '' ELSE ', ' END
				, C.DeliveryWard 
				, CASE WHEN ISNULL(A4.DistrictName, '') = '' THEN '' ELSE ', ' END
				, A4.DistrictName 
				, CASE WHEN ISNULL(A2.CityName, '') = '' THEN '' ELSE ', ' END
				, A2.CityName
				, CASE WHEN ISNULL(A3.AreaName, '') = '' THEN '' ELSE ', ' END
				, A3.AreaName 
				, CASE WHEN ISNULL(A1.CountryName, '') = '' THEN '' ELSE ', ' END
				, A1.CountryName) AS DeliveryAddress 
	, C.APK   
	, C.DeliveryWard   
	, C.DeliveryDistrictID   
	, C.DeliveryCityID   
	, C.DeliveryPostalCode   
	, C.DeliveryCountryID    
	, C.RouteID
	, C.Longitude
	, C.Latitude

  FROM CRMT101011 C WITH (NOLOCK)      
  LEFT JOIN AT1001 A1 WITH(NOLOCK) ON C.DeliveryCountryID = A1.CountryID AND A1.Disabled = 0
  INNER JOIN (select * from POST0011 With (NOLOCK)   where POST0011.MemberID = @ObjectID AND DivisionID IN (@DivisionID, '@@@') ) as A ON CONVERT(VARCHAR(50), A.APK) = C.APKMaster      
  LEFT JOIN AT1002 A2 WITH(NOLOCK) ON C.DeliveryCityID = A2.CityID  AND A2.DivisionID IN ( C.DivisionID , '@@@')     
  LEFT JOIN AT1003 A3 WITH(NOLOCK) ON C.DeliveryPostalCode = A3.AreaID  AND A3.DivisionID IN ( C.DivisionID , '@@@')     
  LEFT JOIN AT1013 A4 WITH(NOLOCK)ON C.DeliveryDistrictID = A4.DistrictID AND A4.DivisionID IN ( C.DivisionID , '@@@')     
  WHERE  C.DivisionID IN (@DivisionID, '@@@')  

end


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


