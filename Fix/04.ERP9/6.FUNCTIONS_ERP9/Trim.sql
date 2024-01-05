IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE [NAME] = '_Trim' AND [TYPE] = 'FN')
	DROP FUNCTION _Trim
GO
-- <Summary>
---- Hàm cắt chuổi 
---- Hoạt động như TRIM (vì Compatibility level không hỗ trợ TRIM)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Học Huy on 05/02/2020
-- <Example>

CREATE FUNCTION [dbo]._Trim(@string NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
    BEGIN
		RETURN LTRIM(RTRIM(@string))
    END
