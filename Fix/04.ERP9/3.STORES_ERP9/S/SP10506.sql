IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP10506]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP10506]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Thực thi Store SP10504 khi load dữ liệu màn hình phân quyền xem tương ứng
---- kiềm tra User đang đăng nhập có thể xem được dữ liệu của những user nào.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phan thanh hoàng vũ, Date: 03/05/2017
----Modify by: Thị Phượng, Date: 07/05/2017: thay thế giá trị trả ra '','' thành ,
----Modify by: Thị Phượng, Date :30/08/2017: Bổ sung thêm phân quyền đính kèm
----Modify by: Hoàng Vũ, Date :12/09/2017: Bổ sung AssessmentSelfID, BonusFeatureID, AppraisalSelfID phân quyền xem dữ liệu/vai trò KPI/DGNL
----Modify by: Thị Phượng, Date :26/09/2017: Bổ sung thêm phân quyền đơn hàng bán dưới APP APPSaleOrderID
----Modify by: Hoàng Vũ, Date :29/09/2017: Chỉnh sửa cách lấy dữ liệu bị sai, xóa điều kiện kiểm tra từng @Data
----Modify by: Tấn Thành, Date :16/09/2020: Bổ sung load Condition bao gồm của Usser UNASIGNED
----Modify by: Văn Tài,   Date :26/07/2022: Kế thừa và tạo store mới để load đồng loạt các phân quyền xem dữ liệu.
-- <Example> Exec SP10506 @DivisionID = N'MSA', @UserID = N'PHUONG', @DataID = 'APPSaleOrderID'

CREATE PROCEDURE SP10506 ( 
		@DivisionID VARCHAR(50), --Biến môi trường
        @UserID  VARCHAR(50),		
		@ListDataID XML
		)
AS 
Begin

		CREATE TABLE #TBL_SP10504 (DivisionID VARCHAR(50), UserID VARCHAR(50), DataID VARCHAR(50))

		INSERT INTO #TBL_SP10504
		SELECT @DivisionID AS DivisionID,
			   @UserID AS UserID,
			   X.Data.query('DataID').value('.', 'VARCHAR(50)') AS DataID
		FROM @ListDataID.nodes('//Data') AS X (Data)

		Declare 
				@strRoleID varchar(50),
				@strGroupID varchar(50),
				@strDataID varchar(50),
				@Condition nvarchar(max),
				@cur_RoleID CURSOR,
				@cur_DataID CURSOR
		Declare @RoleTemp01 table (	
									DataID VARCHAR(50),			--Mã dữ liệu
									RoleID  varchar(50),		--Mã vai trò
									ParentRoleID varchar(50),	--Mã vai trò cha
									RoleName nvarchar(250),		--Tên vai trò
									LevelRoleID int, 			--Cấp bậc vai trò
									GroupID varchar(50) 		--Nhóm
								);

		--Bước 1: Duyệt Role của UserID đăng nhập, để lấy ra tất cả các Role
		SET @cur_RoleID = CURSOR SCROLL KEYSET FOR
		
			SELECT DISTINCT x.RoleID, x.GroupID 
			from (  
					Select RoleID, GroupID from ST10503  With (NOLOCK)
						Where DivisionID = @DivisionID and UserID = @UserID and IsUserOrGroup = 1
					UNION ALL
					Select M.RoleID, M.GroupID from ST10503 M  With (NOLOCK) 
						inner join AT1402 D  With (NOLOCK) on M.GroupID = D.GroupID
						Where M.DivisionID = @DivisionID and D.UserID = @UserID and IsUserOrGroup = 0
					) x

		open @cur_RoleID
		fetch next from @cur_RoleID into @strRoleID, @strGroupID
		while @@fetch_status = 0
		BEGIN

				-- Đệ qui lần lượt các Role của User đăng nhập, lấy tất cả các Role con
				WITH RoleID_CTE (RoleID,RoleName,ParentRoleID,LevelRoleID, GroupID)
				AS  
				(
					SELECT M.RoleID, M.RoleName, M.ParentRoleID, M.LevelRoleID, @strGroupID
					FROM ST10501 M  With (NOLOCK)
					WHERE M.RoleID = @strRoleID
					UNION ALL
					SELECT dm.RoleID, dm.RoleName, dm.ParentRoleID, dm.LevelRoleID, @strGroupID
					FROM ST10501 AS dm WITH (NOLOCK) 
					INNER JOIN RoleID_CTE AS cte ON dm.ParentRoleID = cte.RoleID
				)
				Insert into @RoleTemp01 (RoleID,RoleName, ParentRoleID,LevelRoleID, GroupID)
				Select  M.RoleID, M.RoleName, M.ParentRoleID, M.LevelRoleID, M.GroupID 
				From RoleID_CTE M

			fetch next from @cur_RoleID into  @strRoleID, @strGroupID
		END
		close @cur_RoleID

		--Bước 2: Lấy quyền dữ liệu theo Role và theo người dùng
		Declare @RoleTemp02 table (	UserID  varchar(50),
									GroupID  varchar(50),
									RoleID varchar(50),	
									DataID varchar(50),
									TypeID int 			
								);
		Insert into @RoleTemp02 (UserID, GroupID, RoleID, DataID, TypeID)
		Select  Distinct D.UserID, D.GroupID, D.RoleID, S02.DataID, S02.TypeID
		From (
				--Lấy quyền dữ liệu và quyền người dùng
				Select D.DivisionID, D.UserID, D.GroupID, D.RoleID
				from ST10503 D  With (NOLOCK) inner join @RoleTemp01 y on D.RoleID = y.RoleID and D.GroupID = y.GroupID
				Where D.DivisionID = @DivisionID and D.IsUserOrGroup = 1
				Union all
				--Lấy quyền dữ liệu và quyền nhom người dùng
				Select D.DivisionID, x.UserID, D.GroupID, D.RoleID
				from ST10503 D  With (NOLOCK) Left join AT1402 x  With (NOLOCK)on D.DivisionID = x.DivisionID and D.GroupID = x.GroupID and D.RoleID = x.UserJoinRoleID
											  inner join @RoleTemp01 y on D.RoleID = y.RoleID and D.GroupID = y.GroupID
				Where D.DivisionID = @DivisionID and D.IsUserOrGroup = 0
			)D FULL JOIN ST10502 S02 on D.RoleID = S02.RoleID
		Where D.UserID is not null
		Order by S02.TypeID, S02.DataID, D.UserID
		

		--Bước 3: Duyệt Role và quyền dữ liệu để người đăng nhập có thể xem dữ liệu danh sách người dùng tương ứng
		Declare @ResultRoleID varchar(50),
				@ResultGroupID  varchar(50),
				@ResultDataID varchar(50),
				@ResultType nvarchar(max)

		--SELECT * FROM #TBL_SP10504
		--SELECT * FROM @RoleTemp01
		--SELECT * FROM @RoleTemp02
		
		--Trả ra danh sách dữ liệu có quyền xem những user tương ứng
		Declare @RoleTemp03 table (	DataID varchar(50),
									UserID nvarchar(Max)
								);
		SET @cur_DataID = CURSOR SCROLL KEYSET FOR
			SELECT AT02.GroupID
				, AT02.RoleID
				, AT02.DataID
				, AT02.TypeID 
			FROM @RoleTemp02 AT02
			INNER JOIN #TBL_SP10504 AT04 ON AT04.DataID = AT02.DataID
			WHERE AT02.UserID = @UserID

		open @cur_DataID
		fetch next from @cur_DataID into @ResultGroupID, @ResultRoleID, @ResultDataID, @ResultType
		while @@fetch_status = 0
		BEGIN
			
			--Trường hợp 1: Lấy toàn quyền
			IF EXISTS (SELECT TOP 1 1 FROM @RoleTemp02 WHERE DataID = @ResultDataID and TypeID = 3)
			Begin 
				Insert into @RoleTemp03 (DataID, UserID)
				Select @ResultDataID, UserID from AT1402 Where DivisionID = @DivisionID
			End
			--Trường hợp 2: Lấy quyền nhóm
			ELSE 
			IF EXISTS (SELECT TOP 1 1 FROM @RoleTemp02 WHERE DataID = @ResultDataID  and GroupID = @ResultGroupID and @ResultType = 2)
			Begin 
				Insert into @RoleTemp03 (DataID, UserID)
				Select @ResultDataID, UserID
				from AT1402 
				Where DivisionID = @DivisionID and GroupID = @ResultGroupID
			End
			ELSE
			--Trường hợp 3: Lấy quyền cá nhân
			Begin 
				Insert into @RoleTemp03 (DataID, UserID)
				Select @ResultDataID, UserID 
				from AT1402 
				Where DivisionID = @DivisionID and GroupID = @ResultGroupID and UserID = @UserID
			End
			fetch next from @cur_DataID into @ResultGroupID, @ResultRoleID, @ResultDataID, @ResultType
		END
		close @cur_DataID

		-- User UNASSIGNED, người dùng nào cũng có thể thấy dữ liệu của User này
		INSERT INTO @RoleTemp03(DataID, UserID) VALUES('UNASSIGNED','UNASSIGNED')

		-- Lấy kết quả
		SELECT AT04.DataID AS DataType
			, STUFF((SELECT DISTINCT ',' + UserID 
					  FROM @RoleTemp03 AT03
					  WHERE AT03.DataID IN ('UNASSIGNED', AT04.DataID)
					  FOR XML PATH ('')), 1, 1, ''
					)
				AS Condition
		FROM #TBL_SP10504 AT04
		ORDER BY AT04.DataID

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
