IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AX1011]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[AX1011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Triger delete bang danh muc Ma phan tich
-- <History>
---- Create on 30/11/2015 by Phương Thảo : Customize Meiko: Khi delete dữ liệu Mã PT A02, A03 --> tự động delete danh mục Phòng ban, tổ nhóm
---- Modified by Phương Thảo on 16/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 04/11/2020: Bổ sung cho khách Nguyễn Quang Huy
---- Modified by Huỳnh Thử on 21/11/2020: Insert vào bảng phân quyền AT1406
-- <Example>


CREATE TRIGGER [dbo].[AX1011] ON [dbo].[AT1011] 
FOR DELETE 
AS
DECLARE 
@Ana_Cursor CURSOR

DECLARE 
	@AnaTypeID AS NVARCHAR(50),
	@AnaID AS NVARCHAR(50), 	
	@ReAnaID NVARCHAR(50),	
	@DivisionID NVARCHAR(50),	
	@CustomerName INT

--Tao bang tam de kiem tra day co phai la khach hang Sieu Thanh khong (CustomerName = 16)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
IF @CustomerName IN (50,131) --- Customize Meiko, NQH
BEGIN
	
	SET @Ana_Cursor = CURSOR SCROLL KEYSET FOR
			SELECT  AnaTypeID, AnaID,  DivisionID, ReAnaID
			FROM DELETED
	
		OPEN @Ana_Cursor
		FETCH NEXT FROM @Ana_Cursor INTO @AnaTypeID, @AnaID, @DivisionID, @ReAnaID

		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF (@AnaTypeID = 'A02')
			BEGIN
				DELETE AT1102 
				WHERE DivisionID in (@DivisionID,'@@@') AND DepartmentID = @AnaID
				EXEC AP1406 @DivisionID, 'CI', @AnaID, '', 'DE', '', '', 'D', 0
				
			END

			IF(@AnaTypeID = 'A03')
			BEGIN
				DELETE HT1101				
				WHERE DivisionID = @DivisionID AND TeamID = @AnaID 
			
			END

		FETCH NEXT FROM @Ana_Cursor INTO @AnaTypeID, @AnaID, @DivisionID, @ReAnaID

		END

		CLOSE @Ana_Cursor
		DEALLOCATE @Ana_Cursor
	

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

