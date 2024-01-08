IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AY1011]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[AY1011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Triger insert bang danh muc Ma phan tich
-- <History>
---- Create on 30/11/2015 by Phương Thảo : Customize Meiko: Khi insert dữ liệu Mã PT A02, A03 --> tự động insert vào danh mục Phòng ban, tổ nhóm
---- Modified by Phương Thảo on 16/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 04/11/2020: Bổ sung cho khách Nguyễn Quang Huy
---- Modified by Huỳnh Thử on 21/11/2020: Insert vào bảng phân quyền AT1406
---- Modified by Huỳnh Thử on 21/12/2020: [NQH]Thực hiện CIP11231, CIP11232 vẽ lại sơ đồ tổ chức
-- <Example>


CREATE TRIGGER [dbo].[AY1011] ON [dbo].[AT1011]
FOR INSERT 
AS

DECLARE 
    @Ana_Cursor CURSOR, 
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
	SET @Ana_Cursor = CURSOR SCROLL KEYSET FOR
		SELECT  AnaTypeID, AnaID, AnaName, DivisionID, IsCommon, Notes, ReAnaID,
				CreateDate, CreateUserID, LastModifyUserID, LastModifyDate, ContactPerson, IsOrganizationDiagram
		FROM Inserted
	
	OPEN @Ana_Cursor
	FETCH NEXT FROM @Ana_Cursor INTO @AnaTypeID, @AnaID, @AnaName, @DivisionID, @IsCommon, @Notes, @ReAnaID,
									 @CreateDate, @CreateUserID, @LastModifyUserID, @LastModifyDate, @ContactPerson, @IsOrganizationDiagram

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF (@AnaTypeID = 'A02')
		BEGIN
			IF NOT EXISTS (SELECT TOP 1 1 FROM AT1102 WHERE DivisionID in (@DivisionID,'@@@') AND DepartmentID = @AnaID)
				INSERT INTO AT1102 (DivisionID, DepartmentID, DepartmentName, IsCommon, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, Disabled, ContactPerson, IsOrganizationDiagram)
				VALUES (@DivisionID, @AnaID, @AnaName, @IsCommon, @CreateDate, @CreateUserID, @LastModifyDate, @LastModifyUserID, 0, @ContactPerson, @IsOrganizationDiagram)
				EXEC AP1406 @DivisionID, 'CI', @AnaID, @AnaName, 'DE', @CreateDate, @CreateUserID, 'A', @IsCommon 
		END
		
		IF(@AnaTypeID = 'A03')
		BEGIN
			IF NOT EXISTS (SELECT TOP 1 1 FROM HT1101 WHERE DivisionID = @DivisionID AND TeamID = @AnaID AND DepartmentID = @ReAnaID)
				INSERT INTO HT1101 (DivisionID, DepartmentID, TeamID, TeamName, Notes, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, Disabled, ContactPerson, IsOrganizationDiagram)
				VALUES (@DivisionID, Isnull(@ReAnaID,''), @AnaID, @AnaName, @Notes, @CreateDate, @CreateUserID, @LastModifyDate, @LastModifyUserID, 0, @ContactPerson, @IsOrganizationDiagram)
		END

	FETCH NEXT FROM @Ana_Cursor INTO @AnaTypeID, @AnaID, @AnaName, @DivisionID, @IsCommon, @Notes, @ReAnaID,
									 @CreateDate, @CreateUserID, @LastModifyUserID, @LastModifyDate, @ContactPerson, @IsOrganizationDiagram

	END
	CLOSE @Ana_Cursor
	DEALLOCATE @Ana_Cursor
	exec CIP11231
	exec CIP11232
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

