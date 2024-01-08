IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1007]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1007]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

------- Created by Nguyen Quoc Huy, Date 02/09/2008
------- Kiem tra trung so chung tu (sử dụng trên API).
-----Edit by Thien Huynh [17/11/2011]: Bo sung AT9004 va AT9010
---- Modified on 06/06/2013 by Lê Thị Thu Hiền : Bổ sung DivisionID
---- Modified on 26/05/2016 by Bảo Thy: Bỏ WITH (NOLOCK) ở bảng AT9000
---- Modified on 01/07/2021 by Nhựt Trường: Điều chỉnh lại thứ tự điều kiện tại các câu query (ưu tiên DivisionID trước).

CREATE PROCEDURE [dbo].[AP1007]  
			@TableID nvarchar(50), 
			@VoucherNo AS nvarchar(50),
			@DivisionID AS NVARCHAR(50) = ''
  AS
Declare @Status AS tinyint,
		@VnMess AS nvarchar(250),
		@EnMess AS nvarchar(250)

SET @Status =0
SET @VnMess =''
SET @EnMess =''
	
If @TableID = N'AT9000'
  IF EXISTS (SELECT TOP 1 1  FROM AT9000 Where DivisionID = @DivisionID AND VoucherNo = @VoucherNo)
	Begin
		 SET @Status =1
		 SET @VnMess =N'AFML000046'
		 SET @EnMess =N'This VoucherNo is exist. Do you want to enter other VoucherNo?'
		GOTO RETURN_VALUES
	End

If @TableID = N'AT9004'--So du dau ky Tai khoan ngoai bang
  IF EXISTS (SELECT TOP 1 1  FROM AT9004 WITH (NOLOCK) Where DivisionID = @DivisionID AND VoucherNo = @VoucherNo)
	Begin
		 SET @Status =1
		 SET @VnMess =N'AFML000046'
		 SET @EnMess =N'This VoucherNo is exist. Do you want to enter other VoucherNo?'
		GOTO RETURN_VALUES
	End

If @TableID = N'AT9010'--Phieu Tam thu, Tam chi
  IF EXISTS (SELECT TOP 1 1  FROM AT9010 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherNo = @VoucherNo)
	Begin
		 SET @Status =1
		 SET @VnMess =N'AFML000046'
		 SET @EnMess =N'This VoucherNo is exist. Do you want to enter other VoucherNo?'
		GOTO RETURN_VALUES
	End


---- Tra ve gia tri
RETURN_VALUES:
Select @Status AS Status , @VnMess AS VnMess, @EnMess AS EnMess



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
