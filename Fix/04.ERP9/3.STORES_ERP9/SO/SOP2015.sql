IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2015]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2015]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



----- Created by Tieu Mai
---- Created Date 04/10/2017
---- Purpose: Kiem tra rang buoc du lieu cho phep Sua, Xoa 

/* 
	EXEC SOP2015 'ANG', 9, 2017, N'SO1/09/2017/001', N'SOF2012', 0
	
	EXEC SOP2015 'ANG', 9, 2017, N'SO1/09/2017/001', N'SOF2012', 1
*/


CREATE PROCEDURE [dbo].[SOP2015] 	
				@DivisionID NVARCHAR(50),
				@TranMonth INT,
				@TranYear INT,
				@VoucherID NVARCHAR(50),
				@FormID NVARCHAR(50),
				@IsEdit TINYINT		--- 0: Xóa
									--- 1: Sửa
AS

Declare @Status as tinyint,
	@EngMessage as nvarchar(250),
	@VieMessage as nvarchar(250)

SET @Status =0
SET @EngMessage =''
SET @VieMessage=''

IF @IsEdit = 0
BEGIN 	
	IF @FormID = 'SOF2012' -- Đơn hàng bán NPP
		BEGIN					
				
				-- Phiếu kết chuyển từ POS
				IF EXISTS (SELECT TOP 1 1 FROM OT2001 WITH (NOLOCK) WHERE 
							(ISNULL(IsConfirm,0) = 1 OR ISNULL(IsConfirm01,0) = 1 OR ISNULL(IsConfirm02,0) = 1) AND DivisionID = @DivisionID  
							AND isnull (Orderstatus,0) = 1 AND  SOrderID =  @VoucherID AND TranMonth = @TranMonth AND TranYear = @TranYear)
					BEGIN
						SET @Status = 1
						SET @VieMessage =N'SOFML000022' 
						SET @EngMessage =N'SOFML000022'
						
					END
				GOTO EndMess
				
		END	
END

IF @IsEdit = 1
BEGIN 	
	IF @FormID = 'SOF2012' -- Đơn hàng bán NPP
		BEGIN					
				
				-- Phiếu kết chuyển từ POS
				IF EXISTS (SELECT TOP 1 1 FROM OT2001 WITH (NOLOCK) WHERE 
							(isnull(IsConfirm,0) = 1 or isnull(IsConfirm01,0) = 1 or isnull(IsConfirm02,0) = 1)  
							AND isnull (Orderstatus,0) = 1 and  SOrderID =  @VoucherID AND TranMonth = @TranMonth AND TranYear = @TranYear)
					BEGIN
						SET @Status = 1
						SET @VieMessage =N'SOFML000022' 
						SET @EngMessage =N'SOFML000022'
						
					END
				GOTO EndMess
				
		END	
END	
--================================================
	EndMess:
	Select @FormID, @Status as Status, @EngMessage as EngMessage, @VieMessage as VieMessage


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
