IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP2024]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP2024]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Store Load ComboBox Điều kiệu phụ thuộc Rules và Toán tử
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Huỳnh Thử, Date 24/11/2020
----Update by: Tấn Lộc, Date 25/11/2020 - Tách câu load dữ liệu của Đối tượng (Email), Tên công (BlackList) thành sotre SP2024 và Điều kiện lọc (Email), Toán tử (BlackList) thành store SP2025

CREATE PROCEDURE [dbo].[SP2024] (
	@DivisionID VARCHAR(50), 	-- Tr??ng h?p @DivisionID ?úng v?i DivisionID ??ng nh?p thì cho xóa
	@TypeRules TINYINT 		-- 1: Email; 2: BlackList
	) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	-- Load danh sách dữ liệu ngầm Email
	IF (@TypeRules = 1)
		BEGIN
			SELECT ID as ObjectID, Description as ObjectName, DescriptionE as ObjectNameE
			FROM AT0099 WITH (NOLOCK) 
			WHERE CodeMaster = 'ST2020.ObjectID'
			ORDER BY OrderNo ASC
		END
	----Load combo Loại công: 
	IF (@TypeRules = 2)
		BEGIN
			SELECT  AbsentTypeID AS ObjectID, AbsentName As ObjectName
			FROM HT1013 WITH (NOLOCK)
			WHERE DivisionID= @DivisionID
					AND IsMonth= 1 
					AND Disabled = 0
			ORDER BY AbsentTypeID
		END 
END





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
