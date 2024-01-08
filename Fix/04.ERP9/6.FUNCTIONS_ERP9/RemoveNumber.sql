IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[RemoveNumber]') AND XTYPE IN (N'FN', N'IF', N'TF')) DROP FUNCTION [RemoveNumber]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Hàm loại bỏ các ký tự số, nhận về chuỗi string
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
---- Created by Hoài Bảo on 07/12/2021
-- <Example>
CREATE FUNCTION [dbo].RemoveNumber
(
    @Value NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	-- Chỉ giữ lại các giá trị số
	DECLARE @KeepValues varchar(50) = '%[^a-zA-Z]%'

	WHILE PATINDEX(@KeepValues, @Value) > 0
		SET @Value = STUFF(@Value, PATINDEX(@KeepValues, @Value), 1, '')

	RETURN @Value
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
