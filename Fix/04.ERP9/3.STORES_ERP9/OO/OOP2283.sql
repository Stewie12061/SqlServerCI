IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2283]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2283]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
--- store khôi phục dữ liệu
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Tấn Lộc Date 29/01/2021
-- <Example>
/*
	EXEC OOP2283 @DivisionID=N'KY',@TxtSearch=N'',@UserID=N'DANH',@PageNumber=N'1',@PageSize=N'10'
*/

 CREATE PROCEDURE [dbo].[OOP2283] (
	 @APK VARCHAR(250),
	 @TableID VARCHAR(250),
	 @DivisionID VARCHAR(250),
	 @APKRel VARCHAR(250)
)
AS
DECLARE @sSQL NVARCHAR (MAX),
	 @sWhere NVARCHAR(MAX),
	 @OrderBy NVARCHAR(500),
	 @TotalRow NVARCHAR(50)

-- Load phiếu công việc
IF (@TableID = 'OOT2110')
BEGIN
	SET @sSQL = ''
END

-- Load phiếu dự án
IF (@TableID = 'OOT2100')
BEGIN
	
	SET @sSQL = ''
END

-- Load phiếu Milestone
IF (@TableID = 'OOT2190')
BEGIN
	
	SET @sSQL = ''
END

-- Load phiếu Release
IF (@TableID = 'OOT2210')
BEGIN
	SET @sSQL = ' '
END

-- load phiếu vấn đề
IF (@TableID = 'OOT2160')
BEGIN
	SET @sSQL = ''
END

-- Load phiếu Yêu cầu hỗ trợ
IF (@TableID = 'OOT2170')
BEGIN
	
	SET @sSQL = ''
END

-- load phiếu đầu mối
IF (@TableID = 'CRMT20301')
BEGIN
	
	SET @sSQL = ' '
END

-- Load phiếu cơ hội
IF (@TableID = 'CRMT20501')
BEGIN
	
	SET @sSQL = ''
END

-- Load phiếu yêu cầu
IF (@TableID = 'CRMT20801')
BEGIN
	
	SET @sSQL = ''
END

-- Load phiếu khách hàng
IF (@TableID = 'CRMT10001')
BEGIN
	SET @sSQL = ' '
END

-- Load phiếu Liên hệ
IF (@TableID = 'CRMT10101')
BEGIN
	
	SET @sSQL = ''
END

-- Load phiếu chiến dịch
IF (@TableID = 'CRMT20401')
BEGIN
	
	SET @sSQL = ''
END

-- Load phiéu hợp đồng
IF (@TableID = 'CIFT1360')
BEGIN
	
	SET @sSQL = ''
END

-- Load danh sách folder (Public)
IF (@TableID = 'OOT2250')
BEGIN
	
	SET @sSQL = '
	Update OOT2250
	Set DeleteFlg = 0
	WHERE APK = '''+@APK+'''

	Update OOT2260
	SET DeleteFlg = 0
	WHERE APKMaster_OOT2250 = '''+@APK+''' '
END

-- Load danh sách file (Public)
IF (@TableID = 'OOT2260')
BEGIN
	
	SET @sSQL = ' 
	Update OOT2260
	SET DeleteFlg = 0
	WHERE APK = '''+@APK+'''
	 
	Update OOT2250
	SET DeleteFlg = 0
	WHERE APK = '''+@APKRel+''' '
END

-- Load danh sách file (Cá nhân)
IF (@TableID = 'OOT2270')
BEGIN
	

	SET @sSQL = ' Update OOT2270
	SET DeleteFlg = 0
	WHERE APK = '''+@APK+''' '
END



EXEC (@sSQL)
PRINT(@sSQL)









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
