
IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH (NOLOCK) WHERE ID = OBJECT_ID(N'CMNP0002') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CMNP0002
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- @Summary>
---- Load Grid Form CMNF0002 Danh mục phiếu cần duyệt
-- @Param>
---- 
-- @Return>
---- 
-- @Reference>
---- 
-- @History>
----Created by: Thị Phượng, Date: 28/03/2017
----Modify by Tấn Đạt 14/03/2018: Bỏ bảng CIT1202. 
----Modify by Tấn Đạt 15/03/2018: Thêm chức năng lọc theo điều kiện đã chọn trước
-- @Example>
----    EXEC CMNP0002 'CAN','','SO',1,'USER01',1,20,''
----
CREATE PROCEDURE CMNP0002 ( 
  @DivisionID VARCHAR(50),
  @DivisionIDList NVARCHAR(2000),  
  @VoucherTypeID  NVARCHAR(250), 
  @Status  NVARCHAR(250),
  @UserID  VARCHAR(50),
  @PageNumber INT,
  @PageSize INT,  
  @SearchWhere NVARCHAR(Max) = null) 
AS 
DECLARE	@sSQL1 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@ColumnID NVARCHAR(MAX),
		@TableID NVARCHAR(MAX),
		@ScreenID NVARCHAR(MAX),
		@DutyID NVARCHAR(MAX),
		@ApproveLevel VARCHAR(50) ,
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
        
SET @sWhere = ''
set @ColumnID = (Select ColumnID From CIT1200 Where DivisionID = @DivisionID and VoucherTypeID = @VoucherTypeID)
set @TableID = (Select TableID From CIT1200 Where DivisionID = @DivisionID and VoucherTypeID = @VoucherTypeID)
set @ScreenID = (Select ScreenID From CIT1200 Where DivisionID = @DivisionID and VoucherTypeID = @VoucherTypeID)
Set @DutyID = (Select isnull(DutyID,'') From AT1103  Where EmployeeID = @UserID)
SET @ApproveLevel = (Select Max(isnull([Level],0)) From CIT1201 M Where M.DivisionID = @DivisionID and M.VoucherTypeID = @VoucherTypeID and M.DutyID =@DutyID)
SET @TotalRow = ''
SET @OrderBy = 'M.DivisionID, M.VoucherDate, M.VoucherNo'
IF isnull(@SearchWhere,'') =''
Begin
--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + 'M.DivisionID = '''+ @DivisionID+''''
	Else 
		SET @sWhere = @sWhere + 'M.DivisionID IN ('''+@DivisionIDList+''')'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

	IF Isnull(@Status,'') !=''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Status, '''') LIKE N''%'+@Status+'%'''
END
-------------
IF isnull(@SearchWhere,'') !=''
Begin
	SET  @sWhere='1 = 1'	
End
set @sSQL1 =N' 
	Select '+@ColumnID+', isnull(A.ApproveLevel,0) as ApproveLevel Into #TempConfirm From '+@TableID+' WITH (NOLOCK) 
	Left Join CIT1203 A WITH (NOLOCK) ON cast('+@TableID+'.APK as Varchar(50)) = A.APKMaster
	Left Join CIT1201 B WITH (NOLOCK) ON  B.VoucherTypeID = '''+@VoucherTypeID+''' AND B.DutyID = isnull('''+@DutyID+''','''')
	Where isnull(A.ApproveLevel,0) >= Cast('+@ApproveLevel+' as Varchar(10)) and isnull(A.Status,0) != 0

	SELECT ROW_NUMBER() OVER (Order BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
	, M.*, AT0099.Description as StatusName, A01.FullName as CreateUserName
	FROM #TempConfirm  M 
	Left join AT1103 A01 on  M.CreateUserID = A01.EmployeeID
	Left join AT0099 on  M.Status = AT0099.ID 

	WHERE '+@sWhere+' '+Isnull(@SearchWhere,'')+'
	Order BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL1)

