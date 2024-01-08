-- <Summary>
---- Customize phân quyền mặc định hiển thị dashboard theo yêu cầu khách hàng CSG
---- 
-- <Return>
-- <Reference>
-- <History>
-- CREATE BY Lê Thanh Lượng ON 30/08/2023
-- <Return>
-- <Reference>
IF (EXISTS (SELECT 1 FROM CustomerIndex WHERE CustomerName = 152)) -- CSG
BEGIN
-------------DASHBOARD----------------															

UPDATE AT1403 set IsView = 0 where ModuleID = 'AsoftOO' AND DivisionID='CSG' 
							AND ScreenID like '%OOD%' AND ScreenID NOT LIKE '%_AP%' 
							AND IsView = 1
UPDATE AT1403 set IsView = 1 where ModuleID = 'AsoftOO' 
							AND DivisionID= 'CSG' 
							AND ScreenID IN ('OOD0028', 'OOD0031', 'OOD0032') 			
										
UPDATE AT1403 set IsView = 1 where ModuleID = 'AsoftOO' 
							AND DivisionID= 'CSG' 
							AND ScreenID IN ('OOD0028', 'OOD0031', 'OOD0032') 	
-------------WS----------------------					
UPDATE  AT14053 SET Visible = 0	WHERE DivisionID= 'CSG'  
	IF NOT EXISTS (SELECT TOP 1 1 FROM AT14053 WITH (NOLOCK) WHERE DivisionID= 'CSG' AND WorkspaceID = 'OOD0028')	
		BEGIN	
		INSERT INTO AT14053 (APK, UserID, DivisionID, WorkspaceID, OrderNo, Visible)
		SELECT NEWID() AS APK, UserID, DivisionID, 'OOD0028' AS WorkspaceID, 1 as OrderNo, 1 AS Visible FROM AT1405 where DivisionID = 'CSG'
		END	
	ELSE
		BEGIN 
		UPDATE  AT14053 SET Visible = 1,OrderNo = 1 WHERE DivisionID= 'CSG'  
										AND WorkspaceID = 'OOD0028'	
		END
	IF NOT EXISTS (SELECT TOP 1 1 FROM AT14053 WITH (NOLOCK) WHERE DivisionID= 'CSG' AND WorkspaceID = 'OOD0031')	
		BEGIN	
		INSERT INTO AT14053 (APK, UserID, DivisionID, WorkspaceID, OrderNo, Visible)
		SELECT NEWID() AS APK, UserID, DivisionID, 'OOD0031' AS WorkspaceID, 2 as OrderNo, 1 AS Visible FROM AT1405 where DivisionID = 'CSG'
		END	
	ELSE
		BEGIN 
		UPDATE  AT14053 SET Visible = 1,OrderNo = 2 WHERE DivisionID= 'CSG'  
										AND WorkspaceID = 'OOD0031' 		
		END		
	IF NOT EXISTS (SELECT TOP 1 1 FROM AT14053 WITH (NOLOCK) WHERE DivisionID= 'CSG' AND WorkspaceID = 'OOD0032')	
		BEGIN	
		INSERT INTO AT14053 (APK, UserID, DivisionID, WorkspaceID, OrderNo, Visible)
		SELECT NEWID() AS APK, UserID, DivisionID, 'OOD0032' AS WorkspaceID, 3 as OrderNo, 1 AS Visible FROM AT1405 where DivisionID = 'CSG'
		END	
	ELSE
		BEGIN 
		UPDATE  AT14053 SET Visible = 1,OrderNo = 3 WHERE DivisionID= 'CSG'  
										AND WorkspaceID = 'OOD0032'		
		END										
END

