IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2107]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2107]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
--- Cập chứng từ nhập liệu ban đầu có gán mã phân tích cơ hội
--- AT9000: Bảng bút toán
--- OT3001:	Master đơn hàng mua (Purchase Order)
--- OT3002:	Detail đơn hàng mua (Purchase Order)
--- OT2001:	Đơn hàng bán (Master)
--- OT2002:	Chi tiết đơn hàng
--- OT3102: Chi tiết mua hàng
--- OT2102: Chi tiết phiếu báo giá
--- AT1031: Chi tiết hàng hóa hợp đồng
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Bảo Toàn Date 09/07/2019
-- Modify by: Bảo Toàn Date 29/08/2019
-- <Example>
/*
	EXEC [OOP2107] @DivisionID=N'KY'
*/

 CREATE PROCEDURE [dbo].[OOP2107] (
	 @DivisionID VARCHAR(50),
	 @ProjectID	VARCHAR(25),
	 @ProjectName	NVARCHAR(250),
	 @OpportunityID	VARCHAR(25)
)
AS
BEGIN
	DECLARE @SQLString		NVARCHAR(MAX)
	SET @SQLString  = N'				
		UPDATE AT9000
		SET Ana01ID = @AnaID
		WHERE DivisionID = @DivisionID AND Ana02ID = @Ana02ID AND ISNULL(Ana01ID,'''') = ''''

		UPDATE OT3001
		SET Ana01ID = @AnaID
		WHERE DivisionID = @DivisionID AND Ana02ID = @Ana02ID AND ISNULL(Ana01ID,'''') = ''''

		UPDATE OT3002
		SET Ana01ID = @AnaID
		WHERE DivisionID = @DivisionID AND Ana02ID = @Ana02ID AND ISNULL(Ana01ID,'''') = ''''

		UPDATE OT2001
		SET Ana01ID = @AnaID
		WHERE DivisionID = @DivisionID AND Ana02ID = @Ana02ID AND ISNULL(Ana01ID,'''') = ''''

		UPDATE OT2002
		SET Ana01ID = @AnaID
		WHERE DivisionID = @DivisionID AND Ana02ID = @Ana02ID AND ISNULL(Ana01ID,'''') = ''''

		UPDATE OT3102
		SET Ana01ID = @AnaID
		WHERE DivisionID = @DivisionID AND Ana02ID = @Ana02ID AND ISNULL(Ana01ID,'''') = ''''

		UPDATE OT2102
		SET Ana01ID = @AnaID
		WHERE DivisionID = @DivisionID AND Ana02ID = @Ana02ID AND ISNULL(Ana01ID,'''') = ''''

		UPDATE OT2002
		SET Ana01ID = @AnaID
		WHERE DivisionID = @DivisionID AND Ana02ID = @Ana02ID AND ISNULL(Ana01ID,'''') = ''''

		UPDATE AT1031
		SET Ana01ID = @AnaID
		WHERE DivisionID = @DivisionID AND Ana02ID = @Ana02ID AND ISNULL(Ana01ID,'''') = ''''
	'
	DECLARE @ParmDefinition nvarchar(500) = N'@DivisionID VARCHAR(50),@AnaID NVARCHAR(50), @AnaTypeID NVARCHAR(50), @AnaName NVARCHAR(250),@Ana02ID NVARCHAR(50)'
	EXECUTE sp_executesql @SQLString, @ParmDefinition,  
                      @DivisionID = @DivisionID, 
                      @AnaID = @ProjectID, 
                      @AnaTypeID = N'A01', 
                      @AnaName = @ProjectName,
					  @Ana02ID = @OpportunityID
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
