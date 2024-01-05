IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP0072]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP0072]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




----<Summary>
----
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Tra Giang, Date: 17/10/2018
------------------Kết quả trả về: 
----------------------Status = 0 (Loại Message Info), Status = 1 (Loại Message Warning), Status = 0 (Loại Message Error)
----------------------MessageID: POSM000020 (Kiểm tra khác DivisionID), POSM000019 (Kiểm tra đã khóa sổ), POSM000003 (Kiểm tra đã sử dụng)
----------------------Params (Danh sách VoucherNo không xóa được)
------------------Store xử lý: Xóa danh sách một /nhiều @ID, và chỉ Sửa 1 @ID
----------------------Nếu Xóa thành công
----<Editted by>:Tra Giang, Date: 17/10/2018
------------------Bổ sung: tham số Mode và APK
----------------------Nếu xóa thì truyền danh sách tham số sau @DivisionID, @ShopID, @APKList, @FormID = 'POSF0015', @Mode ='1' , @APK = null
----------------------Nếu sửa thì truyền danh sách tham số sau @DivisionID, @ShopID, @APKList = Null, @FormID = 'POSF0015', @Mode ='0' , @APK
---- Modify on 19/04/2019 by Trà Giang: Bỏ điều kiện lọc kỳ kế toán  
----<Example>
------------------EXEC POSP0072 N'AT', 'CH003', '', 'POSF2035', '0','2EDC6337-F0BF-45EA-B535-CBD9EC1BDED7'





CREATE PROCEDURE POSP0072
		( @DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
		  @ShopID varchar(50),
		  @APKList NVARCHAR(MAX) = NULL,
		  @FormID nvarchar(50),			 --Truyền vào cho trường hợp xóa
		  @Mode tinyint,                 --1: Xóa, 0: Sửa  
		  @APK VARCHAR(50) = NULL        --Truyền vào cho trường hợp sửa
  		) 
AS 
BEGIN
	DECLARE @sSQL1 NVARCHAR(MAX)
	DECLARE @sSQL2 NVARCHAR(MAX)
	DECLARE @sSQL3 NVARCHAR(MAX)

	IF @Mode = 1 
		BEGIN
		
		SET @sSQL1 = 
		
		'	DECLARE		@Status TINYINT,
								@Message NVARCHAR(1000),
								@Cur CURSOR,
								@ID VARCHAR(50),
								@DelAPK  uniqueidentifier,
								@DelShopID VARCHAR(50),
								@DelDivisionID VARCHAR(50),
								@DelShiftID VARCHAR(50),
								@DelTranMonth int=null,
								@DelTranYear int=null


						--Luu tru ID message
						Declare @POST0072temp table 
								(
									Status tinyint,
									MessageID varchar(100),
									Params varchar(4000)
								)
			

						SET @Status = 0
						SET @Message = ''''
						SET @ID = ''''
						Insert into @POST0072temp (	Status, MessageID, Params) 
									Select 2 as Status, ''00ML000050'' as MessageID, Null as Params   
									union all
									Select 2 as Status, ''POSM000025'' as MessageID, Null as Params    
									union all
									Select 2 as Status, ''00ML000052'' as MessageID, Null as Params' 
																

		SET @sSQL2 = '	SET @Cur = CURSOR SCROLL KEYSET FOR
							SELECT P.APK, P.DivisionID, P.ShopID, P.ShiftID, @DelTranMonth, @DelTranYear
						FROM POST0069 P 
									
						WHERE P.APK IN ('''+@APKList+''')

							OPEN @Cur
						FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelShopID, @DelShiftID, @DelTranMonth, @DelTranYear
						WHILE @@FETCH_STATUS = 0
						BEGIN
								
								
								--Chay Store kiem tra da su dung
									Exec POSP9000 @DelDivisionID, @DelShopID, @DelTranMonth, @DelTranYear, @ID, @DelAPK, '''+@FormID+''', @Status  output

								--Kiem tra khac DivisionID
									IF @DelDivisionID != '''+@DivisionID+'''
										Begin
											SET @Message = @DelShiftID
											update @POST0072temp set Params = ISNULL(Params,'''') + @Message+'','' where MessageID = ''00ML000050''
										End
								--Kiem tra khac ShopID
									ELSE IF @DelShopID != '''+@ShopID+'''
										Begin
											SET @Message = @DelShiftID
											update @POST0072temp set Params = ISNULL(Params,'''') + @Message+'','' where MessageID = ''POSM000025''
										End
								
								--Kiem tra da su dung
									ELSE IF  (Select @Status) = 1
										Begin
											SET @Message = @DelShiftID
											update @POST0072temp set Params = ISNULL(Params,'''') + @Message+'', '' where MessageID = ''00ML000052''
										End
							
								--Cho phep xoa
								
								ELSE IF  (Select @Status) = 0 and @DelDivisionID = '''+@DivisionID+''' and @DelShopID = '''+@ShopID+'''
								
										Begin'
		SET @sSQL3 = '	
						--Delete [phieu nhap kho] ben POS
								DELETE FROM POST0069 WHERE  ShiftID = @DelShiftID
						
							End
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelShopID, @DelShiftID, @DelTranMonth, @DelTranYear 
			END
			CLOSE @Cur
			SELECT Status, MessageID, Params From  @POST0072temp where Params is not null'
		EXEC (@sSQL1 + @sSQL2 + @sSQL3) 
		--print (@sSQL1 )
		--print ( @sSQL2 )
		--print ( @sSQL3)
		

	END
	IF @Mode = 0
		BEGIN
					DECLARE @Status TINYINT,
					@Status1 TINYINT,
								@Message NVARCHAR(1000),
								@Cur CURSOR,
								@ID VARCHAR(50),
								@DelAPK  uniqueidentifier,
								@DelShopID VARCHAR(50),
								@DelDivisionID VARCHAR(50),
								@DelShiftID VARCHAR(50),
								@DelTranMonth int,
								@DelTranYear int,	
								@Params Varchar(100)
					Declare @POST0072temp table 
							(
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000)
							)
					SELECT	@DelAPK = P.APK, @DelDivisionID = P.DivisionID, @DelShopID = P.ShopID, @ID=P.ShiftID
					FROM POST0069 P 
					Where P.APK = @APK 

					Exec POSP9000 @DelDivisionID, @DelShopID, @DelTranMonth, @DelTranYear, @ID, @DelAPK, @FormID, @Status  output
					
					IF @DelDivisionID != @DivisionID
						Begin --{0} không thuộc đơn vị hiện tại. Bạn không thể Sửa / Xóa
							SET @Message = '00ML000050' 
							SET	@Status1 = 2
							SET @Params = @ID
						End 
					IF @DelShopID != @ShopID
						Begin --{0} không thuộc cửa hàng hiện tại. Bạn không thể Sửa / Xóa
							SET @Message = 'POSM000025' 
							SET	@Status1 = 2
							SET @Params = @ID
						End 
				
					IF (Select @Status) = 1
						Begin --{0} này đã được sử dụng. Bạn không thể Sửa / Xóa
							SET @Message = '00ML000052' 
							SET	@Status1 = 2
							SET @Params = @ID
						End
					--IF @Closing = 0 AND EXISTS (SELECT TOP 1 1 FROM AT2006 M WITH (NOLOCK) inner join AT2007 D WITH (NOLOCK) on M.DivisionID = D.DivisionID and M.VoucherID = D.VoucherID
					--	WHERE M.DivisionID = @DivisionID and InheritTableID ='POST0015' AND  D.InheritVoucherID = @APK and KindVoucherID = 3)
					--	BEGIN
					--		SET @Message = 'POSFML000109' 
					--		SET	@Status1 = 2
					--		SET @Params = @ID
					--		SET @Params = @Params+ ',' + (SELECT TOP 1 M.VoucherNo FROM AT2006 M WITH (NOLOCK) inner join AT2007 D WITH (NOLOCK) on M.DivisionID = D.DivisionID and M.VoucherID = D.VoucherID
					--	WHERE M.DivisionID = @DivisionID and InheritTableID ='POST0015' AND  D.InheritVoucherID = @APK and KindVoucherID = 3)
					--	END
				
					Insert into @POST0072temp (	Status, MessageID, Params) 
					Select	@Status1 as Status, @Message as MessageID, @Params as Params
					SELECT Status, MessageID, Params From  @POST0072temp where Params is not null
		END
END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
