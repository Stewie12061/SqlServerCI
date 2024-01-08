-- <Summary>
---- Customize khách hàng CSG
-- <History>
-- CREATE BY Hoàng Long ON 05/09/2023
-- <Return>
-- <Summary>

DECLARE @CustomerName INT
SET @CustomerName = (SELECT CustomerName FROM CustomerIndex)

IF @CustomerName = 152
BEGIN 
	DELETE FROM AT14054 

	INSERT [dbo].[AT14054] ([IDNumber], [Idioms], [Author]) VALUES (1, N'Văn phòng điện tử Cảng Sài Gòn', N'vpdtcsg.com.vn')
END 

