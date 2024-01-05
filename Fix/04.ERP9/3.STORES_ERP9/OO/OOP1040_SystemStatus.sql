IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1040_SYSTEMSTATUS]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1040_SYSTEMSTATUS]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load dữ liệu Combobox OOP1040_CBBSystemStatus  - Load Danh sách trạng thái hệ thống
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Tấn Lộc ON 13/08/2020
---- @StatusType = 5 là trạng thái hệ thống cho Email
-- <Example>
/*
   
*/

CREATE PROCEDURE [dbo].[OOP1040_SystemStatus] 
( 
	@DivisionID NVARCHAR(250),
	@StatusType NVARCHAR(250)
) 
AS
BEGIN
	IF ISNULL(@StatusType, '') != '' AND ISNULL(@StatusType, '') != '7'
		BEGIN
			SELECT cast(A1.ID as Tinyint) as SystemStatusID, A1.Description as SystemStatusName, A1.DescriptionE as SystemStatusNameE, A1.ID1
			FROM AT0099 A1 WITH (NOLOCK)
			WHERE A1.CodeMaster = 'SystemStatus' AND
				((ISNULL(@StatusType, '') != '5' AND ISNULL(A1.ID1, '') != '5')
					OR (ISNULL(@StatusType, '') = '5' AND ISNULL(A1.ID1, '') = '5'))
		END

	--- Trạng thái duyệt đơn.
	IF ISNULL(@StatusType, '') = '7'
		BEGIN
			SELECT cast(A1.ID as Tinyint) as SystemStatusID, A1.Description as SystemStatusName, A1.DescriptionE as SystemStatusNameE, A1.ID1
			FROM OOT0099 A1 WITH (NOLOCK)
			WHERE A1.CodeMaster = 'Status'
		END
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
