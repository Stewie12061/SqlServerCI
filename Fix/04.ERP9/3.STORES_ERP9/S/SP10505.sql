IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP10505]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP10505]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
---- Load danh sách dữ liệu cập nhật vai trò - SF1051
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tấn Thành, Date 18/08/2020
-- <Example>
/*
 EXEC SP10505 @RoleID = N'NHANVIEN', @TypeID = 1, @ModuleID = N'AsoftBEM'
*/

CREATE PROCEDURE SP10505 
( 
	@ModuleID VARCHAR(50),
	@RoleID VARCHAR(50),
	@TypeID INT
) 
AS 

DECLARE @sSQL NVARCHAR(MAX),	    @sWHERE NVARCHAR(MAX)            IF (ISNULL(@ModuleID,'') != '')	            SET @sWHERE = 'WHERE z.ModuleID IN(''' + @ModuleID + ''')'            ELSE	            SET @sWHERE = ' WHERE 1=1'            SET @sSQL = '	            Select  x.DataID as DataID, z.Description as  DataName, x.TypeID, z.ModuleID, y.Description as TypeName
                        From (
		                        Select DataID, TypeID, NULL AS ModuleID from ST10502 With (NOLOCK) Where RoleID =''' + @RoleID + '''
		                        Union all
		                        Select ID as DataID,' + CAST(@TypeID AS VARCHAR(1)) + ' AS TypeID, ModuleID 
								from ST10504  With (NOLOCK) Where ISNULL([Disabled],0) = 0
			                        and ID not in ( Select DataID from ST10502  With (NOLOCK) Where RoleID ='''+ @RoleID+''')
	                         ) x Inner join CRMT0099 y With (NOLOCK) on CAST(x.TypeID as varchar(50)) = y.ID and y.CodeMaster = N''CRMT00000001''
	 	                         Left join  ST10504 z With (NOLOCK) on x.DataID = z.ID and ISNULL(z.[Disabled],0) = 0' + @sWHERE + '
                                GROUP BY z.ModuleID, x.DataID, z.Description, x.TypeID, y.Description					            Order By z.ModuleID'


EXEC (@sSQL)
PRINT (@sSQL)










GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO