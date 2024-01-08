IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CMNP90061') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CMNP90061
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Màn hình dùng chung chọn File đính kèm
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 08/03/2017
--- Modify by Thị Phượng, Date 30/08/2017: Bổ sung phân quyền đính kèm
-- <Example>
----EXEC CMNP90061 'CAN',  N'','NV01',1,10, N'ASOFTADMIN'', ''DANH'', ''HOANG'', ''HUYEN'', ''LIEN'', ''LUAN'', ''PHUONG'', ''QUI'', ''QUYNH'', ''VU'
----
CREATE PROCEDURE CMNP90061 ( 
		 @DivisionID NVARCHAR(2000),
		 @TxtSearch NVARCHAR(250),
		 @UserID VARCHAR(50),
		 @PageNumber INT,
		 @PageSize INT,
		 @ConditionAttachID NVARCHAR(Max)
) 
AS 
BEGIN
			DECLARE @sSQL01 NVARCHAR (MAX),
					@sSQL02 NVARCHAR (MAX),
					@sWhere NVARCHAR(MAX),
					@OrderBy NVARCHAR(500),
					@CountTotal NVARCHAR(Max)
		

				SET @sWhere = ''
				SET @OrderBy = 'AttachName, CreateDate DESC'

				IF Isnull(@DivisionID, '')! = ''
					SET @sWhere = @sWhere + 'DivisionID = '''+ @DivisionID+''''
				
				IF isnull(@TxtSearch, '') != ''
					SET @sWhere = @sWhere +'
									AND (AttachName LIKE N''%'+@TxtSearch+'%'' 
									OR CreateUserID LIKE N''%'+@TxtSearch+'%'')'
				IF Isnull(@ConditionAttachID, '') != ''
					SET @sWhere = @sWhere + ' AND ISNULL(CreateUserID,'''') in (N'''+@ConditionAttachID+''' )'
				--Kiểm tra load mac định thì lấy tổng số trang, ngược lại thì không lấy tổng số trang (Cải tiến tốc độ )
				IF @PageNumber = 1
				Begin
					Set @CountTotal = 'Select Count(AttachID) From CRMT00002 WITH (NOLOCK)
									   WHERE '+@sWhere
				End
					else Set @CountTotal = 'Select 0'
				DECLARE @CountEXEC table (CountRow NVARCHAR(Max))
				Insert into @CountEXEC (CountRow)
				EXEC (@CountTotal)

				SET @sSQL01 = '		SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+(Select CountRow from @CountEXEC)+' AS TotalRow	
									, APK
									, DivisionID
									, AttachID, AttachName, AttachFile, CreateDate, CreateUserID
									From CRMT00002 WITH (NOLOCK) 
									WHERE '+@sWhere
				SET @sSQL02 = '	
							ORDER BY '+@OrderBy+'
							OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
							FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
				EXEC (@sSQL01+@sSQL02)
END	