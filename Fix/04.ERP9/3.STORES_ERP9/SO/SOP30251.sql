IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30251]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30251]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load dữ liệu combo MPT.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tài, Date: 21/12/2021
----Modify by: [], Date: 13/04/2017: 
-- <Example>
/*

EXEC SOP30251 'AS', 'ASOFTADMIN' ,'Sale'

*/
CREATE PROCEDURE SOP30251 ( 
        @DivisionID VARCHAR(50),	-- Biến môi trường
		@UserID VARCHAR(50),		-- Biến môi trường
		@TargetAnaType VARCHAR(50)	-- Các mã khai báo MPT CI / Thiết lập chung. : AREA, SALE, CUSTOMER
)
AS 
BEGIN
DECLARE @sSQL VARCHAR (MAX),
		@sWhere VARCHAR(MAX),
		@OrderBy VARCHAR(500),
        @TotalRow VARCHAR(50),
		@Customerindex INT,
		@sJoin VARCHAR(MAX) = ''

	SET @Customerindex = (SELECT TOP 1 CustomerName FROM Customerindex WITH (NOLOCK))
	
	IF (@TargetAnaType = N'AREA') -- MPT khu vực
	BEGIN
		
		DECLARE @AreaAnaTypeID VARCHAR(50) = (SELECT TOP 1 AreaAnaTypeID FROM AT0000 WITH (NOLOCK) WHERE AT0000.DefDivisionID IN ('@@@', @DivisionID))

		IF (ISNULL(@AreaAnaTypeID, '') <> '')
		BEGIN

			SELECT  AT15.AnaID
					, AT15.AnaName					
			  FROM AT1015 AT15 WITH (NOLOCK)
			  WHERE AT15.DivisionID IN ('DPT', '@@@')
				  AND ISNULL(AT15.Disabled , 0) = 0
				  AND AT15.AnaTypeID  = @AreaAnaTypeID
			  ORDER BY AT15.AnaID
		END

	END

	IF (@TargetAnaType = N'SALE') -- MPT nhân viên bán hàng
	BEGIN
		
		DECLARE @SaleAnaTypeID VARCHAR(50) = (SELECT TOP 1 SaleAnaTypeID FROM AT0000 WITH (NOLOCK) WHERE AT0000.DefDivisionID IN ('@@@', @DivisionID))

		IF (ISNULL(@SaleAnaTypeID, '') <> '')
		BEGIN

			SELECT  AT15.AnaID
					, AT15.AnaName					
			  FROM AT1011 AT15 WITH (NOLOCK)
			  WHERE AT15.DivisionID IN ('DPT', '@@@')
				  AND ISNULL(AT15.Disabled , 0) = 0
				  AND AT15.AnaTypeID  = @SaleAnaTypeID
			  ORDER BY AT15.AnaID
		END

	END

	IF (@TargetAnaType = N'CUSTOMER') -- MPT khách hàng
	BEGIN
		DECLARE @CustomerAnaTypeID VARCHAR(50) = (SELECT TOP 1 CustomerAnaTypeID FROM AT0000 WITH (NOLOCK) WHERE AT0000.DefDivisionID IN ('@@@', @DivisionID))

		IF (ISNULL(@CustomerAnaTypeID, '') <> '')
		BEGIN

			SELECT  AT15.AnaID
					, AT15.AnaName					
			  FROM AT1011 AT15 WITH (NOLOCK)
			  WHERE AT15.DivisionID IN ('DPT', '@@@')
				  AND ISNULL(AT15.Disabled , 0) = 0
				  AND AT15.AnaTypeID  = @CustomerAnaTypeID
			  ORDER BY AT15.AnaID
		END

	END


END





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
