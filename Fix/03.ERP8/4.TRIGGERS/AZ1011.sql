IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AZ1011]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[AZ1011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Triger update bang danh muc Ma phan tich
-- <History>
---- Create on 30/11/2015 by Phương Thảo : Customize Meiko: Khi update dữ liệu Mã PT A02, A03 --> tự động update lại danh mục Phòng ban, tổ nhóm
---- Modified by Phương Thảo on 16/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 04/11/2020: Bổ sung cho khách Nguyễn Quang Huy
---- Modified by Huỳnh Thử on 21/11/2020: Insert vào bảng phân quyền AT1406
---- Modified by Huỳnh Thử on 21/12/2020: [NQH] -- Thực hiện CIP11231, CIP11232 vẽ lại sơ đồ tổ chức
-- <Example>


CREATE TRIGGER [dbo].[AZ1011] ON [dbo].[AT1011]
FOR UPDATE 
AS

DECLARE 
@Ana_Cursor CURSOR

DECLARE 
	@AnaTypeID AS NVARCHAR(50),
	@AnaID AS NVARCHAR(50), 
	@AnaName NVARCHAR(250), 
	@DivisionID NVARCHAR(50),
	@IsCommon TINYINT, 
	@ReAnaID NVARCHAR(50),
	@CreateDate DATETIME, 
	@CreateUserID NVARCHAR(50),
	@LastModifyUserID NVARCHAR(50),
	@LastModifyDate DATETIME,
	@Disabled Tinyint,
	@Notes NVARCHAR(250),
	@CustomerName INT,
	@ContactPerson NVARCHAR(250), 
	@IsOrganizationDiagram TINYINT

--Tao bang tam de kiem tra day co phai la khach hang Sieu Thanh khong (CustomerName = 16)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
IF @CustomerName IN (50,131) --- Customize Meiko, NQH
BEGIN
	IF UPDATE(AnaName) OR UPDATE(ReAnaID) OR UPDATE(Disabled) OR UPDATE(IsCommon) OR UPDATE(Notes)
	BEGIN	
		SET @Ana_Cursor = CURSOR SCROLL KEYSET FOR
			SELECT  AnaTypeID, AnaID, AnaName, DivisionID, IsCommon, Notes, Disabled, ReAnaID,
					CreateDate, CreateUserID, LastModifyUserID, LastModifyDate, ContactPerson, IsOrganizationDiagram
			FROM Inserted 
	
		OPEN @Ana_Cursor
		FETCH NEXT FROM @Ana_Cursor INTO @AnaTypeID, @AnaID, @AnaName, @DivisionID, @IsCommon, @Notes, @Disabled, @ReAnaID,
										 @CreateDate, @CreateUserID, @LastModifyUserID, @LastModifyDate, @ContactPerson, @IsOrganizationDiagram

		WHILE @@FETCH_STATUS = 0
		BEGIN
				
			IF (@AnaTypeID = 'A02')
			BEGIN
				UPDATE AT1102 
				SET		DepartmentName = @AnaName,
						Disabled = @Disabled,
						LastModifyDate = @LastModifyDate,
						LastModifyUserID = @LastModifyUserID,
						IsCommon = @IsCommon,
						ContactPerson = @ContactPerson,
						IsOrganizationDiagram = @IsOrganizationDiagram
				WHERE DivisionID in (@DivisionID,'@@@') AND DepartmentID = @AnaID
				EXEC AP1406 @DivisionID, 'CI', @AnaID, @AnaName, 'DE', @CreateDate, @CreateUserID, 'E', @IsCommon
				
			END

			IF(@AnaTypeID = 'A03')
			BEGIN
				UPDATE HT1101
				SET		TeamName = @AnaName,
						DepartmentID = @ReAnaID,
						Disabled = @Disabled,
						LastModifyDate = @LastModifyDate,
						LastModifyUserID = @LastModifyUserID,
						Notes = @Notes,
						ContactPerson = @ContactPerson,
						IsOrganizationDiagram = @IsOrganizationDiagram
				WHERE DivisionID = @DivisionID AND TeamID = @AnaID
			
			END

		FETCH NEXT FROM @Ana_Cursor INTO @AnaTypeID, @AnaID, @AnaName, @DivisionID, @IsCommon, @Notes, @Disabled, @ReAnaID,
										 @CreateDate, @CreateUserID, @LastModifyUserID, @LastModifyDate, @ContactPerson, @IsOrganizationDiagram

		END

		CLOSE @Ana_Cursor
		DEALLOCATE @Ana_Cursor

	END
	
	exec CIP11231
	exec CIP11232
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
