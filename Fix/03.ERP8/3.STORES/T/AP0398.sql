IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0398]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0398]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Kết chuyển dữ liệu YCDV từ POS
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 13/11/2019 by Kiều Nga
-- <Example>
/*
	exec AP0398 @DivisionID=N'HCM',@TranMonth=6,@TranYear=2018,@AnaID=N'50C2101',@VoucherDate='2018-06-01 00:00:00',@UserID=N'ASOFTADMIN',
				@VoucherID=N'a318ab4e-a078-497f-b839-0fc99d4d5190',@IsDetailTransfer=0,@APKPOST0016=NULL,@SalesVoucherNo=N'50A18JAN262',
				@WareVoucherNo=N'50DVC.18.06.007',@ReturnVoucherNo=N'50HDDVH.2018.081',@ImWareVoucherNo=N'50HDDVO.2018.049',@Serial=N'',@InvoiceNo=N''
*/
CREATE PROCEDURE AP0398
( 
	@DivisionID			AS NVARCHAR(50),
	@TranMonth			AS INT,
	@TranYear			AS INT,
	@AnaID				AS NVARCHAR(50),
	@VoucherDate		AS DATETIME,
	@UserID				AS NVARCHAR(50) ,                               
	@VoucherID			AS NVARCHAR(50),
	@IsDetailTransfer	AS Tinyint ,
	@APKPOST2050		AS NVARCHAR(50) = NULL,
	@SalesVoucherNo		AS NVARCHAR(50) = NULL,
	@WareVoucherNo		AS NVARCHAR(50) = NULL,
	@ReturnVoucherNo	AS NVARCHAR(50) = NULL,
	@ImWareVoucherNo	AS NVARCHAR(50) = NULL,
	@Serial				AS NVARCHAR(50)= NULL,
	@InvoiceNo			AS NVARCHAR(50)= NULL,
	@sShopAnaTypeID  AS NVARCHAR(50) = NULL,
	@sEmployeeAnaTypeID  AS NVARCHAR(50) = NULL,
	@sCostAnaTypeID AS NVARCHAR(50) = NULL,
	@sRevenueTypeID AS NVARCHAR(50) = NULL
) 
AS 
BEGIN
		DECLARE @EmployeeAnaTypeID AS NVARCHAR(50),
				@ShopAnaTypeID AS NVARCHAR(50),
				@CostAnaTypeID AS NVARCHAR(50),
				@RevenueTypeID AS NVARCHAR(50)

		SET @ShopAnaTypeID = (SELECT RIGHT(@sShopAnaTypeID, 2)) 
								
		SET @EmployeeAnaTypeID = (SELECT RIGHT(@sEmployeeAnaTypeID, 2)) 
									
		SET @CostAnaTypeID = (SELECT RIGHT(@sCostAnaTypeID, 2))

		SET @RevenueTypeID = (SELECT RIGHT(@sRevenueTypeID, 2)) 

		IF @CostAnaTypeID IS NULL 
			SET @CostAnaTypeID = '02'
			
		INSERT INTO AT1011 (DivisionID, AnaTypeID, AnaID, AnaName)
		SELECT	@DivisionID,'A'+@ShopAnaTypeID, AnaID, AnaName
		FROM	AT1015 WITH (NOLOCK)
		WHERE	DivisionID IN (@DivisionID,'@@@') AND AnaTypeID = (	SELECT TOP 1 ShopTypeID FROM POST0001 WITH (NOLOCK) WHERE POST0001.DivisionID = @DivisionID )
																		AND AnaID NOT IN (SELECT AnaID FROM AT1011 WITH (NOLOCK) WHERE AT1011.DivisionID IN (@DivisionID,'@@@'))

		INSERT INTO AT1011 (DivisionID, AnaTypeID, AnaID, AnaName)
		SELECT DISTINCT @DivisionID,'A'+@EmployeeAnaTypeID, POST2050.CreateUserID, AT1405.UserID
		FROM POST2050 WITH (NOLOCK) LEFT JOIN AT1405 WITH (NOLOCK) ON AT1405.DivisionID = POST2050.DivisionID AND POST2050.CreateUserID = AT1405.UserID
		WHERE POST2050.DivisionID = @DivisionID AND POST2050.CreateUserID NOT IN (SELECT AnaID FROM AT1011 WITH (NOLOCK) WHERE AT1011.DivisionID IN (@DivisionID,'@@@'))	
		
		--1. Hóa đơn bán hàng
			EXEC AP0399  @DivisionID, @TranMonth, @TranYear, @AnaID, @VoucherDate, @UserID, @VoucherID, @IsDetailTransfer, @APKPOST2050, @SalesVoucherNo
							, @WareVoucherNo, @ReturnVoucherNo, @ImWareVoucherNo, @Serial, @InvoiceNo, @ShopAnaTypeID, @EmployeeAnaTypeID,@CostAnaTypeID,@RevenueTypeID

		--2.Xuất kho
			EXEC AP0401  @DivisionID, @TranMonth, @TranYear, @AnaID, @VoucherDate, @UserID, @VoucherID, @IsDetailTransfer, @APKPOST2050, @ShopAnaTypeID, @EmployeeAnaTypeID,@CostAnaTypeID,@RevenueTypeID
			
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
