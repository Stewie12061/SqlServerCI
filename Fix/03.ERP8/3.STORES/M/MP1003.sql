IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP1003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)     
DROP PROCEDURE [DBO].[MP1003]  
GO  
SET QUOTED_IDENTIFIER ON  
GO  
SET ANSI_NULLS ON  
GO  

------- Created by Thuy Tuyen, date 08/09/2010
------- Kiem tra ForeignKey --- Thong tin xaut kho tu dong Viet Linh
-- Last Edit: Thuy Tuyen, date 16/09/2010: kiem tra khi phieu xuat da tphan bo chi phi thi khong chp phep xoa sua

CREATE PROCEDURE MP1003 @DivisionID varchar(50), @TableID varchar(50), 	@KeyValues as varchar(50), @TypeID as varchar(50) ='' 

  AS
  
Declare @Status as tinyint
Set @Status =0

--- Canh bao khi xuat xong man hinh  MF0811
If @TableID ='MT0810'
Begin
 If exists (Select top 1 1  From AT2006 WITH (NOLOCK) Where DivisionID = @DivisionID And OrderID = @KeyValues)  
	Begin
		 Set @Status =1
		GOTO RETURN_VALUES
	End

End


 --- Kiem tra khi xoa sua man hinh MF0810
If @TableID ='AT2006'
Begin
  If Exists (Select Top 1  1 From AT2006 WITH (NOLOCK)
				Inner Join AT9000 WITH (NOLOCK)
					on AT9000.VoucherID = AT2006.VoucherID and AT9000.TableID = 'AT2006' And AT9000.DivisionID = AT2006.DivisionID
				where AT2006.DivisionID = @DivisionID And AT2006. OrderID = @KeyValues  and  IsCost<>0 )  and @TableID ='AT2006' 

	Begin
		Set @Status = 2 -- canh bao nhung khong cho phep xoa , sua

		GOTO RETURN_VALUES
	End
  If Exists (Select Top 1  1 From AT2006 WITH (NOLOCK)
			Inner Join AT9000 WITH (NOLOCK) on AT9000.VoucherID = AT2006.VoucherID and AT9000.TableID = 'AT2006' And AT9000.DivisionID = AT2006.DivisionID
			where AT2006.DivisionID = @DivisionID And AT2006.OrderID = @KeyValues  and  IsCost=0 )  and @TableID ='AT2006' 

	Begin
		Set @Status = 1 -- canh bao nhung khong cho phep xoa , sua

		GOTO RETURN_VALUES
	End
End
 --- Kiem tra khi xoa sua





---- 
---- Tra ra gia tri
RETURN_VALUES:
Select @Status as Status
  
GO  
SET QUOTED_IDENTIFIER OFF  
GO  
SET ANSI_NULLS ON  
GO
