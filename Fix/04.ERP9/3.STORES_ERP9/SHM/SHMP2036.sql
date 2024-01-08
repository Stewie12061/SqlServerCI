IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP2036]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP2036]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
----Màn hình cập nhật chuyển nhượng cổ phần (Theo yêu cầu của Dev chuyển từ câu SQL thường sang store để dễ công chuỗi:  Thêm:  @strWhere = ' '; Sửa: @strWhere = '  and APKMInherited != @APK')
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoàng Vũ , Date: 16/05/2019
----Edited by: 
-- <Example> 
/*	--Thêm
	EXEC SHMP2036 'BE', 'BAONGOC', 0, '2019-05-19', NULL
	--Sửa
	EXEC SHMP2036 'BE', 'BAONGOC', 1, '2019-05-19', '2B95D37D-21C5-45C6-B085-678FCAFC17C3'
*/

CREATE PROCEDURE SHMP2036 ( 
        @DivisionID VARCHAR(50),	--Lấy biến môi trường truyền vào
		@UserID varchar(50),		--Lấy biến môi trường truyền vào
		@Mode tinyint = 0,			--0: Thêm; 1: Sửa
		@VoucherDate Datetime,		--Lấy ngày chứng từ trên màn hình
		@APK nvarchar(max)			--Nếu @mode = 0 thì NUll ngược lại thì @APK
		
) 
AS 
Begin
	Declare @sSQL nvarchar(max),
			@sWhere nvarchar(max)
	Set @sWhere = ''

	IF Isnull(@DivisionID, '') != ''
	Begin
		Set @sWhere = @sWhere + ' AND A02.DivisionID IN (N'''+@DivisionID+''',''@@@'')'
	End

	IF Isnull(@VoucherDate, '') != ''
	Begin
		Set @sWhere = @sWhere + ' AND Convert(nvarchar(50), D.TransactionDate, 103) <='''+Convert(nvarchar(50),@VoucherDate, 103)+''''
	End

	IF Isnull(@Mode, 0) = 1	--Sửa
		Set @sWhere = @sWhere + ' and D.APKMInherited !='''+@APK+''''
	Else
		Set @sWhere = @sWhere

	SET @sSQL = 'SELECT A02.ObjectID, A02.ObjectName
						, Sum(Isnull(D.IncrementQuantity, 0)) - Sum(Isnull(D.DecrementQuantity, 0)) as BeforeFromQuantity
						, Sum(Isnull(D.IncrementQuantity, 0)) - Sum(Isnull(D.DecrementQuantity, 0)) as AfterFromQuantity
					 FROM AT1202 A02 WITH (NOLOCK) Left join SHMT2010 M WITH (NOLOCK) ON M.ObjectID = A02.ObjectID
												   Inner join SHMT2011 D WITH (NOLOCK) ON M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg and M.DeleteFlg = 0
					 WHERE A02.Disabled=0 '+@sWhere+'
					 Group by A02.ObjectID, A02.ObjectName
					 Having Sum(Isnull(D.IncrementQuantity, 0)) - Sum(Isnull(D.DecrementQuantity, 0)) > 0
					 Order by A02.ObjectID'
	Exec (@sSQL)
	Print (@sSQL)

End	
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
