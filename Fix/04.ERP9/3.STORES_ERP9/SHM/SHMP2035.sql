IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP2035]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP2035]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
----Ghi vào sổ cổ đông khi lập chuyển nhượng/Thu tiền từ đăng ký cổ phần
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoàng Vũ , Date: 23/10/2018
----Edited by: 
-- <Example> EXEC SHMP2035 'BS', '', 'F47B303E-2ACE-4ADF-A5E5-AD6E9F6E732E', 1, 1

CREATE PROCEDURE SHMP2035 ( 
        @DivisionID VARCHAR(50), 
		@UserID varchar(50),
		@APK UNIQUEIDENTIFIER,
		@TransactionTypeID int, --0: Sổ cổ đông; 1: Đăng ký mua cổ phần; 2: Chuyển nhượng	
		@IsTypeID int			--0: Thêm mới phiếu; 1: Sửa phiếu
) 
AS 

	Declare @FromObjectID varchar(50),
			@ToObjectID varchar(50),
			@ObjectID varchar(50),
			@APKregistered UNIQUEIDENTIFIER

	Select @FromObjectID = FromObjectID, @ToObjectID = ToObjectID From SHMT2030 WITH (NOLOCK) Where APK = @APK and DeleteFlg = 0
	Select @ObjectID = ObjectID From SHMT2020 WITH (NOLOCK) Where APK = @APK and DeleteFlg = 0

	IF Isnull(@IsTypeID, 0) = 0 --Trường hợp thêm phiếu mới
	Begin
		IF @TransactionTypeID = 1 --Đăng ký mua cổ phần
		Begin
			--Kiểm tra mã cổ đông đã tồn tại trong sổ cổ đông chưa, nếu chưa có thì thêm vào sổ cổ đông
			IF NOT EXISTS (Select Top 1 1 From SHMT2010 WITH (NOLOCK) Where ObjectID = @ObjectID and DeleteFlg = 0)
			Begin
				Set @APKregistered = NEWID()

				INSERT INTO SHMT2010 (APK, DivisionID, ObjectID, ShareHolderCategoryID, ContactIssueDate, ContactIssueBy, IdentificationNumber
									 , ContactPrefix, DeleteFlg, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
				Select @APKregistered, DivisionID, ObjectID, ShareHolderCategoryID, ContactIssueDate, ContactIssueBy, IdentificationNumber
						, ContactPrefix, DeleteFlg, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate
				From SHMT2020 WITH (NOLOCK)
				Where APK = @APK

				--Ghi tăng cổ phần vào sổ cổ đông (Cổ phần ban đầu)
				IF NOT EXISTS (Select Top 1 1 From SHMT2010 M WITH (NOLOCK) INNER JOIN SHMT2011 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
							   Where M.ObjectID = @ObjectID and M.DeleteFlg = 0)
				Begin
					INSERT INTO SHMT2011 (APKMaster, DivisionID, ShareTypeID, TransactionDate, TransactionTypeID, Description, IncrementQuantity, DecrementQuantity, UnitPrice, OrderNo
											, APKMInherited, APKDInherited, DeleteFlg, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
					Select @APKregistered, M.DivisionID, D.ShareTypeID, M.VoucherDate, 1, N'Cổ phần ban đầu' , D.QuantityApproved, 0, D.UnitPrice, D.OrderNo
							, M.APK, D.APK, D.DeleteFlg, D.CreateUserID, D.CreateDate, D.LastModifyUserID, D.LastModifyDate
					From SHMT2020 M WITH (NOLOCK) Inner join SHMT2021 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
					Where M.APK = @APK and M.DeleteFlg = 0
				End
			End
			Else
			Begin
					--Xóa hết detail, sau đó insert lại 
					Delete From SHMT2011
					Where DivisionID = @DivisionID and APKMInherited = @APK and DeleteFlg = 0

					INSERT INTO SHMT2011 (APKMaster, DivisionID, ShareTypeID, TransactionDate, TransactionTypeID, Description, IncrementQuantity, DecrementQuantity, UnitPrice, OrderNo
											, APKMInherited, APKDInherited, DeleteFlg, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
					Select S10.APK, M.DivisionID, D.ShareTypeID, M.VoucherDate, 1, N'Mua từ đợt chuyển nhượng' , D.QuantityApproved, 0, D.UnitPrice, D.OrderNo
							, M.APK, D.APK, D.DeleteFlg, D.CreateUserID, D.CreateDate, D.LastModifyUserID, D.LastModifyDate
					From SHMT2020 M WITH (NOLOCK) Inner join SHMT2021 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
												  Inner join SHMT2010 S10 WITH (NOLOCK) on S10.ObjectID = M.ObjectID and S10.DeleteFlg = 0
					Where M.APK = @APK and M.DeleteFlg = 0
			End
		End
		IF @TransactionTypeID = 2 --Chuyển nhượng
		Begin
			--Kiểm tra đối tượng nhận chưa có trong sổ cổ đông thì thêm vào sổ cổ đông
			IF NOT EXISTS (Select Top 1 1 From SHMT2010 WITH (NOLOCK) Where ObjectID = @ToObjectID and DeleteFlg = 0)
			Begin
				INSERT INTO SHMT2010 (DivisionID, ObjectID, DeleteFlg, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
				Values (@DivisionID, @ToObjectID, 0, @UserID, Getdate(), @UserID, Getdate())
			End

			--Nếu phiếu chuyển nhượng đã tồn tại thì xóa, sau đó insert lại phiếu chuyển nhượng
			IF EXISTS (Select Top 1 1 From SHMT2011 WITH (NOLOCK) Where DivisionID = @DivisionID and APKMInherited = @APK and DeleteFlg = 0)
			Begin
				Delete From SHMT2011
				Where DivisionID = @DivisionID and APKMInherited = @APK and DeleteFlg = 0
			End

			--Ghi giảm cổ phần vào sổ cổ đông (Cổ đông chuyển)
			IF EXISTS (Select Top 1 1 From SHMT2010 WITH (NOLOCK) Where ObjectID = @FromObjectID and DeleteFlg = 0)
			Begin
				INSERT INTO SHMT2011 (APKMaster, DivisionID, ShareTypeID, TransactionDate, TransactionTypeID, Description, IncrementQuantity, DecrementQuantity, UnitPrice, OrderNo
										, APKMInherited, APKDInherited, DeleteFlg, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
				Select S10.APK, M.DivisionID, D.ShareTypeID, M.VoucherDate, 2, N'Chuyển nhượng' , 0, D.QuantityTransfered, D.UnitPrice, D.OrderNo
						, M.APK, D.APK, D.DeleteFlg, D.CreateUserID, D.CreateDate, D.LastModifyUserID, D.LastModifyDate
				From SHMT2030 M WITH (NOLOCK) Inner join SHMT2031 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
								Inner join SHMT2010 S10 WITH (NOLOCK) on S10.ObjectID = M.FromObjectID and S10.DeleteFlg = 0
				Where M.APK = @APK and M.DeleteFlg = 0
			End
			--Ghi tăng cổ phần vào sổ cổ đông (Đối tượng nhận)
			IF EXISTS (Select Top 1 1 From SHMT2010 Where ObjectID = @ToObjectID and DeleteFlg = 0)
			Begin
				INSERT INTO SHMT2011 (APKMaster, DivisionID, ShareTypeID, TransactionDate, TransactionTypeID, Description, IncrementQuantity, DecrementQuantity, UnitPrice, OrderNo
										, APKMInherited, APKDInherited, DeleteFlg, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
				Select S10.APK, M.DivisionID, D.ShareTypeID, M.VoucherDate, 2, N'Chuyển nhượng', D.QuantityTransfered, 0, D.UnitPrice, D.OrderNo
						, M.APK, D.APK, D.DeleteFlg, D.CreateUserID, D.CreateDate, D.LastModifyUserID, D.LastModifyDate
				From SHMT2030 M WITH (NOLOCK) Inner join SHMT2031 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
								Inner join SHMT2010 S10 WITH (NOLOCK) on S10.ObjectID = M.ToObjectID and S10.DeleteFlg = 0
				Where M.APK = @APK and M.DeleteFlg = 0
			End
		End
	End

	IF Isnull(@IsTypeID, 0) = 1  --Trường hợp sửa phiếu cũ
	Begin
		IF @TransactionTypeID = 1 --Đăng ký mua cổ phần
		Begin
			--Xóa hết detail, sau đó insert lại 
			Delete From SHMT2011
			Where DivisionID = @DivisionID and APKMInherited = @APK and DeleteFlg = 0

			INSERT INTO SHMT2011 (APKMaster, DivisionID, ShareTypeID, TransactionDate, TransactionTypeID, Description, IncrementQuantity, DecrementQuantity, UnitPrice, OrderNo
									, APKMInherited, APKDInherited, DeleteFlg, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			Select S10.APK, M.DivisionID, D.ShareTypeID, M.VoucherDate, 1, N'Mua từ đợt chuyển nhượng' , D.QuantityApproved, 0, D.UnitPrice, D.OrderNo
					, M.APK, D.APK, D.DeleteFlg, D.CreateUserID, D.CreateDate, D.LastModifyUserID, D.LastModifyDate
			From SHMT2020 M WITH (NOLOCK) Inner join SHMT2021 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
											Inner join SHMT2010 S10 WITH (NOLOCK) on S10.ObjectID = M.ObjectID and S10.DeleteFlg = 0
			Where M.APK = @APK and M.DeleteFlg = 0
		End
		IF @TransactionTypeID = 2 --Chuyển nhượng
		Begin
			--Nếu phiếu chuyển nhượng đã tồn tại thì xóa, sau đó insert lại phiếu chuyển nhượng
			IF EXISTS (Select Top 1 1 From SHMT2011 Where DivisionID = @DivisionID and APKMInherited = @APK and DeleteFlg = 0)
			Begin
				Delete From SHMT2011
				Where DivisionID = @DivisionID and APKMInherited = @APK and DeleteFlg = 0
			End
			--Ghi giảm cổ phần vào sổ cổ đông (Cổ đông chuyển)
			IF EXISTS (Select Top 1 1 From SHMT2010 Where ObjectID = @FromObjectID and DeleteFlg = 0)
			Begin
				INSERT INTO SHMT2011 (APKMaster, DivisionID, ShareTypeID, TransactionDate, TransactionTypeID, Description, IncrementQuantity, DecrementQuantity, UnitPrice, OrderNo
										, APKMInherited, APKDInherited, DeleteFlg, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
				Select S10.APK, M.DivisionID, D.ShareTypeID, M.VoucherDate, 2, N'Chuyển nhượng' , 0, D.QuantityTransfered, D.UnitPrice, D.OrderNo, M.APK, D.APK, D.DeleteFlg
						, D.CreateUserID, D.CreateDate, D.LastModifyUserID, D.LastModifyDate
				From SHMT2030 M WITH (NOLOCK) Inner join SHMT2031 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
								Inner join SHMT2010 S10 WITH (NOLOCK) on S10.ObjectID = M.FromObjectID and S10.DeleteFlg = 0
				Where M.APK = @APK and M.DeleteFlg = 0
			End
			--Ghi tăng cổ phần vào sổ cổ đông (Cổ đông nhận)
			IF EXISTS (Select Top 1 1 From SHMT2010 Where ObjectID = @ToObjectID and DeleteFlg = 0)
			Begin
				INSERT INTO SHMT2011 (APKMaster, DivisionID, ShareTypeID, TransactionDate, TransactionTypeID, Description, IncrementQuantity, DecrementQuantity, UnitPrice, OrderNo
										, APKMInherited, APKDInherited, DeleteFlg, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
				Select S10.APK, M.DivisionID, D.ShareTypeID, M.VoucherDate, 2, N'Chuyển nhượng', D.QuantityTransfered, 0, D.UnitPrice, D.OrderNo, M.APK, D.APK, D.DeleteFlg
						, D.CreateUserID, D.CreateDate, D.LastModifyUserID, D.LastModifyDate
				From SHMT2030 M WITH (NOLOCK) Inner join SHMT2031 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
								Inner join SHMT2010 S10 WITH (NOLOCK) on S10.ObjectID = M.ToObjectID and S10.DeleteFlg = 0
				Where M.APK = @APK and M.DeleteFlg = 0
			End
		End
	End


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
