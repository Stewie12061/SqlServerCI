IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
----Kiểm tra trùng số điện thoại nhằm đăng nhập bằng số điện thoại thay userID 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo, Date: 7/8/2019
----Modify by : Đình Hòa, Date : 07/04/2021 - Khi edit kiểm tra lại nếu đã tồn tại rồi và đúng số điên thoại phiếu thông tin tư vấn đã nhập sẽ không cảnh báo trùng
-- <Example>
---- 
/*-- <Example>
	EDMP2004 @DivisionID = 'BE', @UserID = '', @ObjectID = '',@Tel = '',@Mode = 0
 
	EDMP2004 @DivisionID, @UserID,@ObjectID,@Tel,@Mode
----*/
CREATE PROCEDURE EDMP2004
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @ObjectID  VARCHAR(50),
	 @Tel VARCHAR(50),
	 @Mode VARCHAR(50),
	 @ApkConsultant VARCHAR(50)
)
AS 

IF @Mode = 0 
BEGIN 
	IF @ApkConsultant IS NULL
		--Bỏ phần kiếm tra đối tượng phụ huynh có mã khác null
		SELECT TOP 1 1  FROM EDMT2000 WHERE Telephone = @Tel AND DeleteFlg = 0 
	ELSE
		--Đúng số điên thoại phiếu thông tin tư vấn đã nhập sẽ không cảnh báo trùng
		SELECT TOP 1 1  FROM EDMT2000 WHERE Telephone = @Tel AND DeleteFlg = 0 AND APK <> @ApkConsultant		
END 

IF @Mode = 1 
BEGIN 
	IF @ApkConsultant IS NULL
		SELECT TOP 1 1 FROM AT1202 WHERE Tel = @Tel AND ISNULL(Tel,'') != '' 
	ELSE
		--Đúng số điên thoại phiếu thông tin tư vấn đã nhập sẽ không cảnh báo trùng
		SELECT TOP 1 1 FROM AT1202 WHERE Tel = @Tel AND ISNULL(Tel,'') != '' AND InheritConsultantID <> @ApkConsultant
END 

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
