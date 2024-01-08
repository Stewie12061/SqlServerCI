IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP2025]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP2025]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Store Load ComboBox Điều kiện lọc cho Email và Toán tử cho BlackList
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tấn Lộc, Date 25/11/2020

CREATE PROCEDURE [dbo].[SP2025] (
	@DivisionID VARCHAR(50), 	-- Tr??ng h?p @DivisionID ?úng v?i DivisionID ??ng nh?p thì cho xóa
	@TypeRules TINYINT 		-- 1: Email; 2: BlackList
	) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	-- Load danh sách dữ liệu ngầm Điều kiện lọc cho Email
	IF @TypeRules = 1
		BEGIN
			SELECT ID as FilterCondition, Description as FilterConditionName, DescriptionE as FilterConditionNameE
			FROM AT0099 WITH (NOLOCK) 
			WHERE CodeMaster = 'ST2020.FilterConditionRule' 
			ORDER BY OrderNo ASC
		END
	----Load combo Loại công: 
	IF (@TypeRules = 2)
		BEGIN
			SELECT ID as FilterCondition, Description as FilterConditionName, DescriptionE as FilterConditionNameE
			FROM AT0099 WITH (NOLOCK) 
			WHERE CodeMaster = 'Operator' 
			ORDER BY OrderNo ASC
		END 
END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
