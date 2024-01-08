/*
 * Update dữ liệu cột RelatedToTypeID_REL = 47 cho bảng Ghi chú, Đính kèm
 * Update dữ liệu cột  RelatedToTypeID = 47 cho bảng Lịch sử 
 * Created on 07/12/2020 by Tấn Lộc
 */

-- Ghi chú
UPDATE CRMT90031_REL
SET RelatedToTypeID_REL = 47

-- Đính kèm
UPDATE CRMT00002_REL
SET RelatedToTypeID_REL = 47

-- Lịch sử
DECLARE @Cur CURSOR, @sSQL NVARCHAR(1000), @currentlistTableDetail VARCHAR(MAX), @DivisionIDList NVARCHAR(1000), @TableID VARCHAR(MAX)
--SET @DivisionIDList = 'DTI'',''DTI'
SET @currentlistTableDetail = 'OOT00003,CRMT00003,CIT00003,SOT00003,POT00003,HRMT00003,KPIT00003,ST00003,ADMT00003,BEMT00003'

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT value
		FROM StringSplit(@currentlistTableDetail, ',')
		where RTRIM(value) <> ''
OPEN @Cur
FETCH NEXT FROM @Cur INTO @TableID
WHILE @@FETCH_STATUS = 0
BEGIN
	--> Bắt đầu update dữ liệu
	SET @sSQL = 'UPDATE '+@TableID+'
				 SET RelatedToTypeID = 47'
	PRINT (@sSQL)
	EXEC (@sSQL)
	FETCH NEXT FROM @Cur INTO @TableID
END
CLOSE @Cur
