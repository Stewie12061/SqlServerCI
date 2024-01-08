/*
 * Xóa Danh mục màn hình => Phân quyền lại
 * Xóa những dữ liệu/màn hình phân quyền sai và đã lỡ commit
 * Created on 25/08/2020 by Tấn Thành
 */

/*Module S*/
------------------ Modify on 25/08/2020 by Tấn Thành - SF3017 ------------------
DELETE FROM AT1404 WHERE ScreenID = 'SF3017' AND ModuleID = 'AsoftS'
DELETE FROM AT1404 WHERE ScreenID = 'CMNF0000'
------------------------------------- END --------------------------------------

/*Module BI*/
------------------ Modify on 03/09/2020 by Tấn Thành - SF3017 ------------------
DELETE FROM AT1404 Where SCREENID IN ('BFR3001', 'BFR3002', 'BFR3003', 'BFR3004','BFR3005','BFR3006')
------------------------------------- END --------------------------------------