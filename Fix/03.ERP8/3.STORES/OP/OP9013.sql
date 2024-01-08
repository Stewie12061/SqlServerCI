IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP9013]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP9013]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created by:Nguyen Thuy Tuyen , date:23/04/2009
---- Purpose: Kiem tra rang buoc du lieu cho phep  Xoa
/********************************************
'* Edited by: [GS] [Thành Nguyên] [04/08/2010]
'********************************************/

-- Modified by Kim Thư on 15/05/2019: Bổ sung mã message khi kiểm tra xóa bút toán mẫu

CREATE PROCEDURE [dbo].[OP9013] @DivisionID nvarchar(50),
				@TemplateVoucherID nvarchar(50)
				
AS

Declare @Status as tinyint, --- 1: Khong cho xoa, sua:    2--- co canh bao nhung  cho xoa cho sua; --3: Cho sua mot phan thoi
	@EngMessage as nvarchar(250),
	@VieMessage as nvarchar(250)

Select @Status =0, 	@EngMessage ='',	 @VieMessage=''

	If exists (select top 1 1 from ET2002 WITH(NOLOCK)
					Inner join OT2002 WITH(NOLOCK) ON OT2002.DivisionID = ET2002.DivisionID AND ET2002.TemplateTransactionID = OT2002.QuotationID 
					Where TemplateVoucherID  = @TemplateVoucherID)
	Begin
			Set @Status =1
			Set @VieMessage =N'OFML000285'
			Set @EngMessage =N'OFML000285'
			Goto EndMess
	End 


EndMess:
	Select @Status as Status, @EngMessage as EngMessage, @VieMessage as VieMessage

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
