IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP10004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP10004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Xử lý thêm người dùng vào nhóm người dùng và thêm phân quyền đơn vị
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phan thanh hoàng vũ, Date: 14/02/2017
----Modify by Thị Phượng Date: 04/05/2017 chỉnh sửa tài liệu do dùng bảng ERP
----Modify by Thị Phượng Date: 10/05/2017 chỉnh sửa Xóa quyền vài trò người dùng nếu thay đổi nhóm người dùng
----Modify by Thị Phượng Date: 05/09/2017: Sửa xóa dữ liệu phân quyền màn hình và đơn vị 
----Modify by Học Huy Date: 03/10/2019: Sửa lỗi chọn nhiều quyền mặc định màn hình cập nhật vai trò (SF1051)
----Modify by Tấn Thành Date: 27/08/2020: Thay đổi lấy Vai trò mặc định chung thành lấy Vai trò mặc định theo từng Nhóm khi tạo Người dùng trong nhiều Nhóm (SF1001)
-- <Example>
/*

   EXEC SP10004 'AS','hoangvu003', 3

*/
CREATE PROCEDURE SP10004 ( 
        @DivisionID VARCHAR(50),  
		@EmployeeID nvarchar(250),
		@TypeID as tinyint --1: Thêm, 2:Sửa, 3:xóa
)
AS 
DECLARE @StrDivisionID VARCHAR(50), 
		@StrGroupID VARCHAR(50), 
		@StrEmployeeID VARCHAR(50), 
		@Data nvarchar(250),
		@strGroupUserID nvarchar(250),
		@strUserJoinRoleID nvarchar(250),
		@strRoleDefaultID VARCHAR(50),
		@cur_AllDivision CURSOR,
		@cur_RoleDefaultIDByGroup CURSOR
Declare @GroupUserID table (
					DivisionID varchar(50),
					GroupID varchar(50),
					EmployeeID varchar(50),
					UserJoinRoleID varchar(50))

SET @Data = (SELECT GroupID FROM AT1103 WHERE EmployeeID = @EmployeeID)

--DECLARE @UserJoinRoleID VARCHAR(50)
--SET @UserJoinRoleID = (SELECT TOP 1 RoleID FROM ST10501 WHERE IsDefaultRoleID = 1) -- IsDefaultRoleID: Quyền mặc định

SELECT DATA AS GroupID, A.RoleDefaultID INTO #Tempt FROM Split(@Data, ',') INNER JOIN AT1401 A ON A.GroupID = DATA

IF Isnull(@Data, '')!= ''
Begin
	SET @cur_RoleDefaultIDByGroup = CURSOR SCROLL KEYSET FOR 
	SELECT GroupID, RoleDefaultID FROM #Tempt
	OPEN @cur_RoleDefaultIDByGroup
	FETCH NEXT FROM @cur_RoleDefaultIDByGroup INTO @strGroupID, @strRoleDefaultID
	WHILE @@FETCH_STATUS = 0
		BEGIN
			Insert into @GroupUserID (DivisionID, GroupID, EmployeeID, UserJoinRoleID)
			Select @DivisionID, @strGroupID , @EmployeeID, @strRoleDefaultID

			FETCH NEXT FROM @cur_RoleDefaultIDByGroup INTO @strGroupID, @strRoleDefaultID
		END
	CLOSE @cur_RoleDefaultIDByGroup

	--Insert into @GroupUserID (DivisionID, GroupID, EmployeeID, UserJoinRoleID)
	--Select @DivisionID, Data , @EmployeeID, @UserJoinRoleID From Split(@Data, ',')
End

IF @TypeID = 1 --trường hợp thêm người dùng
Begin
	IF EXISTS (SELECT  TOP 1 1 FROM @GroupUserID)
	Begin
			SET @cur_AllDivision = CURSOR SCROLL KEYSET FOR
			Select DivisionID, GroupID, EmployeeID, UserJoinRoleID From @GroupUserID

			OPEN @cur_AllDivision
			FETCH NEXT FROM @cur_AllDivision INTO @StrDivisionID, @StrGroupID, @StrEmployeeID, @strUserJoinRoleID
			WHILE @@FETCH_STATUS = 0
			  BEGIN	
				--Thêm người dùng vào nhóm người dùng
				IF NOT EXISTS (SELECT  TOP 1 1 FROM AT1402 WHERE DivisionID = @StrDivisionID and GroupID = @StrGroupID and UserID = @StrEmployeeID)
				Begin
					INSERT into AT1402  (DivisionID, GroupID, UserID,UserJoinRoleID )
					SELECT @StrDivisionID, @StrGroupID, @StrEmployeeID, @strUserJoinRoleID
				End
				--Phân quyền đơn vị
				IF NOT EXISTS (SELECT  TOP 1 1 FROM AT1411 WHERE DivisionID = @StrDivisionID and GroupID = @StrGroupID and PermissionDivisionID = @StrDivisionID)
				Begin
					INSERT into AT1411 (DivisionID, GroupID, PermissionDivisionID)
					SELECT @StrDivisionID, @StrGroupID, @StrDivisionID
				End
				--exec CIPT1401 @StrGroupID,@StrDivisionID,@TypeID			
				FETCH NEXT FROM @cur_AllDivision INTO @StrDivisionID, @StrGroupID, @StrEmployeeID, @strUserJoinRoleID
			  END
  
			CLOSE @cur_AllDivision
	End
End

IF @TypeID = 2 --trường hợp sửa người dùng
Begin		
			IF EXISTS (SELECT  TOP 1 1 FROM @GroupUserID)
			Begin
					DELETE AT1402 WHERE DivisionID = @DivisionID AND UserID = @EmployeeID
					DELETE ST10503 WHERE DivisionID = @DivisionID AND UserID = @EmployeeID and  GroupID not in (Select GroupID From @GroupUserID) --Xóa người dùng khỏi nhóm vai trò nếu xóa trong nhóm người dùng
					--DELETE AT1411 WHERE PermissionDivisionID = @DivisionID and GroupID = @StrGroupID AND GroupID !='ADMIN'
					--DELETE AT1403 WHERE DivisionID = @DivisionID AND GroupID in (Select GroupID From @GroupUserID) AND GroupID !='ADMIN'

					SET @cur_AllDivision = CURSOR SCROLL KEYSET FOR
					Select DivisionID, GroupID, EmployeeID, UserJoinRoleID From @GroupUserID

					OPEN @cur_AllDivision
					FETCH NEXT FROM @cur_AllDivision INTO @StrDivisionID, @StrGroupID, @StrEmployeeID, @strUserJoinRoleID
					WHILE @@FETCH_STATUS = 0
					  BEGIN	
						--Thêm người dùng vào nhóm người dùng
						IF NOT EXISTS (SELECT  TOP 1 1 FROM AT1402 WHERE DivisionID = @StrDivisionID and GroupID = @StrGroupID and UserID = @StrEmployeeID)
						Begin
							INSERT into AT1402  (DivisionID, GroupID, UserID, UserJoinRoleID)
							SELECT @StrDivisionID, @StrGroupID, @StrEmployeeID, @strUserJoinRoleID
						End
						--Phân quyền đơn vị
						IF NOT EXISTS (SELECT  TOP 1 1 FROM AT1411 WHERE DivisionID = @StrDivisionID and GroupID = @StrGroupID and PermissionDivisionID = @StrDivisionID)
						Begin
							INSERT into AT1411 (DivisionID, GroupID, PermissionDivisionID)
							SELECT @StrDivisionID, @StrGroupID, @StrDivisionID
						End
						FETCH NEXT FROM @cur_AllDivision INTO @StrDivisionID, @StrGroupID, @StrEmployeeID, @strUserJoinRoleID
					  END
  
					CLOSE @cur_AllDivision
			End
End


IF @TypeID = 3 --trường hợp xóa người dùng
Begin		
			--Xóa những nhóm chứa người dùng
			DELETE AT1402 WHERE DivisionID = @DivisionID And UserID = @EmployeeID
			--Xóa những phân quyền chứa nhóm người dùng
			--DELETE AT1411 WHERE DivisionID = @DivisionID and PermissionDivisionID = @DivisionID AND GroupID !='ADMIN'
			--Xóa người dùng thuộc vai trò 
			DELETE ST10503 WHERE DivisionID = @DivisionID AND UserID = @EmployeeID and  GroupID not in (Select GroupID From @GroupUserID) 

			SET @cur_AllDivision = CURSOR SCROLL KEYSET FOR
			Select Distinct M.DivisionID, M.GroupID
			from AT1402 M 
			Where DivisionID = @DivisionID
			OPEN @cur_AllDivision
			FETCH NEXT FROM @cur_AllDivision INTO @StrDivisionID, @StrGroupID
			WHILE @@FETCH_STATUS = 0
				  BEGIN	
						--Xóa phân quyền màn hình
						--DELETE AT1403 WHERE DivisionID = @StrDivisionID AND GroupID = @StrGroupID AND GroupID !='ADMIN'
						--Phân quyền đơn vị
						IF NOT EXISTS (SELECT  TOP 1 1 FROM AT1411 WHERE DivisionID = @StrDivisionID and GroupID = @StrGroupID and PermissionDivisionID = @StrDivisionID)
						Begin
							INSERT into AT1411 (DivisionID, GroupID, PermissionDivisionID)
							SELECT @StrDivisionID, @StrGroupID, @StrDivisionID
						End
						--exec CIPT1401 @StrGroupID,@StrDivisionID,@TypeID
						FETCH NEXT FROM @cur_AllDivision INTO @StrDivisionID, @StrGroupID
				  END
  
			CLOSE @cur_AllDivision
			
End

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
