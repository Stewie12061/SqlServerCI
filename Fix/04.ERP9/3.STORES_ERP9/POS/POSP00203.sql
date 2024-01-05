IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00203]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[POSP00203]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create by Thị Phượng on 13/06/2016: In danh muc the hoi vien
-- Edit by Hoàng Vũ on 02/06/2017: Cải tiến
-- Example: EXEC POSP00203 'KC', 'KC'',''GS','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, NULL
CREATE PROCEDURE [dbo].[POSP00203] (
	@DivisionID varchar(50),--DivisionID dùng để đăng nhập
	@DivisionIDList NVARCHAR(max), 
	@MemberCardID VARCHAR(50),
	@MemberCardName NVARCHAR(250),
	@TypeNoList NVARCHAR(max), 
	@ReleaseDate DATETIME,
	@ExpireDate DATETIME,
	@MemberID VARCHAR(50),
	@MemberName NVARCHAR(250),
	@Disabled NVARCHAR(50),
	@IsCommonName NVARCHAR(50),
	@UserID NVARCHAR(50)
	)
AS
BEGIN
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX)
        
	
	 SET @sWhere = ''

	 IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionIDList+''', ''@@@'')'
	 Else 
		SET @sWhere = @sWhere + ' M.DivisionID IN ('''+ @DivisionID+''', ''@@@'')'	

     IF isnull(@TypeNoList, '') != '' 
		SET @sWhere = @sWhere + ' AND M.TypeNo IN ('''+@TypeNoList+''')' 
	
	 IF isnull(@MemberCardID, '') != '' 
		SET @sWhere = @sWhere + ' AND M.MemberCardID LIKE ''%'+ @MemberCardID+ '%'''
	 
	 IF isnull(@MemberCardName, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.MemberCardName,'''') LIKE N''%'+ @MemberCardName +'%'''
     
	 IF isnull(@ReleaseDate, '') != '' 
		SET @sWhere = @sWhere + ' AND M.ReleaseDate ='+ CONVERT( CHAR(10) ,@ReleaseDate,103 )
     
	 IF isnull(@ExpireDate, '') != '' 
		SET @sWhere = @sWhere + ' AND M.ExpireDate ='+ CONVERT( CHAR(10),@ExpireDate,103 )

	 IF isnull(@MemberID, '') != '' 
		SET @sWhere = @sWhere + ' AND M.MemberID LIKE ''%'+ @MemberID+ '%'''

     IF isnull(@MemberName, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.MemberName,'''') LIKE N''%'+ @MemberName +'%'''

     IF isnull(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Disabled,'''') Like N'''+@Disabled+''''

	 IF Isnull(@IsCommonName, '') != ''
		SET @sWhere = @sWhere +  ' AND ISNULL(M.IsCommon,'''') Like N'''+@IsCommonName+''''

	 --Lay danh sach the hoi vien
	 SET @sSQL   = 'Select M.APK, M.DivisionID, M.MemberCardID, M.MemberCardName, M.TypeNo, M.MemberID , M.MemberName, M.ReleaseDate
							, M.ExpireDate, M.Disabled, M.LockedReason, M.Locked, M.IsCommon
					FROM POST0020 M WITH (NOLOCK) 
								left join AT0099 D1 With (NOLOCK) on D1.ID= M.Disabled and  D1.CodeMaster =''AT00000004''
								left join AT0099 D2 With (NOLOCK) on D2.ID= M.IsCommon and  D2.CodeMaster =''AT00000004''
					WHERE '+@sWhere +'
					Order by M.MemberCardID, M.TypeNo, M.DivisionID'
	 EXEC (@sSQL)
END	