IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[ConvertTimestampToTime]') AND XTYPE IN (N'FN', N'IF', N'TF'))
	DROP FUNCTION [ConvertTimestampToTime]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Hàm convert giá trị số nguyên sang định dạng giờ phút (hh:mm)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
---- Created by Tấn Thành on 24/04/2020
/* <Example>
 SELECT dbo.ConvertTimestampToTime(28800)
 */
CREATE FUNCTION	ConvertTimestampToTime
(
	@tSecond INT	-- Số giây cần chuyển đổi(s)
)
RETURNS VARCHAR(10)

AS
BEGIN
	RETURN RIGHT('0' + CAST(@tSecond / 3600 AS VARCHAR),2) + ':' + RIGHT('0' + CAST((@tSecond / 60) % 60 AS VARCHAR),2) 
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
