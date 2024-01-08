-- Created by Trà Giang
-- Add dữ liệu ngầm Module ASOFT-NM
-- Modified by Lê Hoàng ON 16/11/2020 : kiểm tra insert nếu không tồn tại và cập nhật nếu đã tồn tại
-- Modified by on


DECLARE @CodeMaster VARCHAR(50)
DECLARE @TableID VARCHAR(50) = 'NMT0099'

--DELETE NMT0099

-----------------------------------------Dùng chung, Không hiển thị (Disabled)-------------------------------------
EXEC AddDataMasterERP9 @TableID, 'Disabled', '0', NULL, 1, N'Không', N'No', 0, NULL
EXEC AddDataMasterERP9 @TableID, 'Disabled', '1', NULL, 2, N'Có', N'Yes', 0, NULL

-----------------------------------------Kho -------------------------------------
EXEC AddDataMasterERP9 @TableID, 'WareHouse', '0', NULL, 1, N'Kho khô', N'DryWareHouse', 0, NULL
EXEC AddDataMasterERP9 @TableID, 'WareHouse', '1', NULL, 2, N'Kho chợ', N'MarketWareHouse', 0, NULL
