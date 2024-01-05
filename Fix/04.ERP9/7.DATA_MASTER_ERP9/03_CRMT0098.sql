-- <Summary>
---- Insert dữ liệu ngầm vào bảng CRMT0098
-- <History>
---- Create on 03/04/2017 by Hoàng Vũ: Tạo dữ liệu ngầm cho bảng CRMT0098 thuộc tính mở rỗng của bảng code master CRMT0099, dùng để tamo email template
---- Modified by
DECLARE @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang CustomerIndex 
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

DROP TABLE #CustomerName
DECLARE @CodeMaster VARCHAR(50), @ID VARCHAR(50), @TableID VARCHAR(50), @ScreenID VARCHAR(50), @Note NVARCHAR(250)

----------Loại đối tượng _RelateToTypeID
SET @CodeMaster = 'CRMT00000002' 
SET @ID = '1' 
SET @TableID = 'CRMT20301'
SET @ScreenID = 'CRMF2031'
SET @Note = N'Đầu mối' 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0098 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0098 (CodeMaster, ID, TableID, ScreenID, Note) 
VALUES (@CodeMaster, @ID, @TableID, @ScreenID, @Note) 
ELSE UPDATE CRMT0098 SET TableID = @TableID, ScreenID = @ScreenID, Note = @Note 
WHERE CodeMaster = @CodeMaster AND ID = @ID 

---------
SET @ID = '2' 
SET @TableID = 'CRMT10001'
SET @ScreenID = 'CRMF1001'
SET @Note = N'Liên hệ'  
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0098 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0098 (CodeMaster, ID, TableID, ScreenID, Note) 
VALUES (@CodeMaster, @ID, @TableID, @ScreenID, @Note) 
ELSE UPDATE CRMT0098 SET TableID = @TableID, ScreenID = @ScreenID, Note = @Note 
WHERE CodeMaster = @CodeMaster AND ID = @ID 

----------
SET @ID = '3' 
SET @TableID = 'CRMT10101'
SET @ScreenID = 'CRMF1011'
SET @Note = N'Khách hàng' 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0098 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0098 (CodeMaster, ID, TableID, ScreenID, Note) 
VALUES (@CodeMaster, @ID, @TableID, @ScreenID, @Note) 
ELSE UPDATE CRMT0098 SET TableID = @TableID, ScreenID = @ScreenID, Note = @Note 
WHERE CodeMaster = @CodeMaster AND ID = @ID 

----------
SET @ID = '4' 
SET @TableID = 'CRMT20501'
SET @ScreenID = 'CRMF2051'
SET @Note = N'Cơ hội' 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0098 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0098 (CodeMaster, ID, TableID, ScreenID, Note) 
VALUES (@CodeMaster, @ID, @TableID, @ScreenID, @Note) 
ELSE UPDATE CRMT0098 SET TableID = @TableID, ScreenID = @ScreenID, Note = @Note 
WHERE CodeMaster = @CodeMaster AND ID = @ID 

----------
SET @ID = '5' 
SET @TableID = 'OT2101'
SET @ScreenID = 'SOF2021'
SET @Note = N'Báo giá' 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0098 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0098 (CodeMaster, ID, TableID, ScreenID, Note) 
VALUES (@CodeMaster, @ID, @TableID, @ScreenID, @Note) 
ELSE UPDATE CRMT0098 SET TableID = @TableID, ScreenID = @ScreenID, Note = @Note 
WHERE CodeMaster = @CodeMaster AND ID = @ID 

---------
SET @ID = '6' 
SET @TableID = 'CRMT20401'
SET @ScreenID = 'CRMF2041'
SET @Note = N'Chiến dịch' 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0098 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0098 (CodeMaster, ID, TableID, ScreenID, Note) 
VALUES (@CodeMaster, @ID, @TableID, @ScreenID, @Note) 
ELSE UPDATE CRMT0098 SET TableID = @TableID, ScreenID = @ScreenID, Note = @Note 
WHERE CodeMaster = @CodeMaster AND ID = @ID 

----------
SET @ID = '7' 
SET @TableID = 'OT2001'
SET @ScreenID = 'SOF2001'
SET @Note = N'Đơn hàng bán' 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0098 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0098 (CodeMaster, ID, TableID, ScreenID, Note) 
VALUES (@CodeMaster, @ID, @TableID, @ScreenID, @Note) 
ELSE UPDATE CRMT0098 SET TableID = @TableID, ScreenID = @ScreenID, Note = @Note 
WHERE CodeMaster = @CodeMaster AND ID = @ID 

----------Loại đối tượng _RelateToTypeID

----------Tấn Lộc - Bổ sung dữ liệu ngầm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041 ------------------
SET @ID = '60' 
SET @TableID = 'CRMT10302'
SET @ScreenID = 'CRMF1031Detail'
SET @Note = N'Khác' 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0098 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0098 (CodeMaster, ID, TableID, ScreenID, Note) 
VALUES (@CodeMaster, @ID, @TableID, @ScreenID, @Note) 
ELSE UPDATE CRMT0098 SET TableID = @TableID, ScreenID = @ScreenID, Note = @Note 
WHERE CodeMaster = @CodeMaster AND ID = @ID

----------Tấn Lộc - Bổ sung dữ liệu ngầm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041 ------------------
SET @ID = '60' 
SET @TableID = 'CRMT10302'
SET @ScreenID = 'CRMF1031Detail'
SET @Note = N'Khác' 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0098 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0098 (CodeMaster, ID, TableID, ScreenID, Note) 
VALUES (@CodeMaster, @ID, @TableID, @ScreenID, @Note) 
ELSE UPDATE CRMT0098 SET TableID = @TableID, ScreenID = @ScreenID, Note = @Note 
WHERE CodeMaster = @CodeMaster AND ID = @ID


----------Tấn Lộc - Bổ sung dữ liệu ngầm cho Nhóm Email là "Đăng kí clould online" trong màn hình Cập nhật Email mẫu - SF2121 ------------------
SET @ID = '61' 
SET @TableID = 'CRMT2210'
SET @ScreenID = 'CRMF2211'
SET @Note = N'Đăng kí clould online' 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0098 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0098 (CodeMaster, ID, TableID, ScreenID, Note) 
VALUES (@CodeMaster, @ID, @TableID, @ScreenID, @Note) 
ELSE UPDATE CRMT0098 SET TableID = @TableID, ScreenID = @ScreenID, Note = @Note 
WHERE CodeMaster = @CodeMaster AND ID = @ID 