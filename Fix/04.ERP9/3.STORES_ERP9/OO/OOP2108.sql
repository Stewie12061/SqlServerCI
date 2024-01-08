IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2108]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
	DROP PROCEDURE [DBO].[OOP2108]

-- <Summary>
--- Xóa mã phân tích dự án khi xóa dự án có cơ hội.
--- AT9000: Bảng bút toán
--- OT3001:	Master đơn hàng mua (Purchase Order)
--- OT3002:	Detail đơn hàng mua (Purchase Order)
--- OT2001:	Đơn hàng bán (Master)
--- OT2002:	Chi tiết đơn hàng
--- OT3102: Chi tiết mua hàng
--- OT2102: Chi tiết phiếu báo giá
--- OT2002: Chi tiết đơn hàng
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Bảo Toàn Date 26/07/2019
-- <Example>
/*
	
*/
GO
CREATE PROCEDURE [dbo].[OOP2108] (
	 @DivisionID VARCHAR(50),
	 @ProjectID	VARCHAR(50),
	 @OpportunityID	VARCHAR(50)
)
AS
BEGIN
	DECLARE @SQLString		NVARCHAR(MAX)
	SET @SQLString  = N'				
		UPDATE AT9000
		SET Ana01ID = NULL
		WHERE DivisionID = @DivisionID AND Ana02ID = @Ana02ID AND Ana01ID = @AnaID

		UPDATE OT3001
		SET Ana01ID = NULL
		WHERE DivisionID = @DivisionID AND Ana02ID = @Ana02ID AND Ana01ID = @AnaID

		UPDATE OT3002
		SET Ana01ID = NULL
		WHERE DivisionID = @DivisionID AND Ana02ID = @Ana02ID AND Ana01ID = @AnaID

		UPDATE OT2001
		SET Ana01ID = NULL
		WHERE DivisionID = @DivisionID AND Ana02ID = @Ana02ID AND Ana01ID = @AnaID

		UPDATE OT2002
		SET Ana01ID = NULL
		WHERE DivisionID = @DivisionID AND Ana02ID = @Ana02ID AND Ana01ID = @AnaID

		UPDATE OT3102
		SET Ana01ID = NULL
		WHERE DivisionID = @DivisionID AND Ana02ID = @Ana02ID AND Ana01ID = @AnaID

		UPDATE OT2102
		SET Ana01ID = NULL
		WHERE DivisionID = @DivisionID AND Ana02ID = @Ana02ID AND Ana01ID = @AnaID

		UPDATE OT2002
		SET Ana01ID = NULL
		WHERE DivisionID = @DivisionID AND Ana02ID = @Ana02ID AND Ana01ID = @AnaID
	'
	DECLARE @ParmDefinition nvarchar(500) = N'@DivisionID VARCHAR(50),@AnaID NVARCHAR(50), @Ana02ID NVARCHAR(50)'
	EXECUTE sp_executesql @SQLString, @ParmDefinition,  
                      @DivisionID = @DivisionID, 
                      @AnaID = @ProjectID, 
					  @Ana02ID = @OpportunityID
END

