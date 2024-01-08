IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP9992]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP9992]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Kết chuyển dữ liệu về bảng chung  ALL và _YEAR
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Trương Ngọc Phương Thảo on 09/08/2016:
---- Create by Kiều Nga on 04/08/2023: [2023/08/IS/0037] Không tạo dữ liệu cho bảng hồ sơ lương (HT2400MThangNam) khi khóa sổ, fix lỗi trùng dữ liệu (customize MEIKO)
-- <Example>
---- 


CREATE PROCEDURE [dbo].[AP9992]
       @DivisionID nvarchar(50),
       @TranMonth AS int ,
       @TranYear AS int ,	   
	   @ModuleID AS Nvarchar(50),
       @FormID AS Nvarchar(50)        
AS
SET NOCOUNT ON

DECLARE @Cur CURSOR,
		@sSQL1 AS Nvarchar(4000) = '', 
		@sSQL2 AS Nvarchar(4000) = '', 
		@sTranMonth Varchar(2), 
		@sTranYear Varchar(4),
		@TableName Varchar(50),
		@TableNameMonth Varchar(50),
		@TableNameYear Varchar(50),
		@MinMonth Int, 
		@MinYear Int


IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)
BEGIN
	
	SELECT DISTINCT TableName
	INTO	#ListTable
	FROM AV9991 
	WHERE	ModuleID LIKE @ModuleID AND FormID LIKE @FormID

	SELECT	@MinMonth = BeginMonth,
			@MinYear = BeginYear
	FROM	AT1101 
	WHERE	DivisionID = @DivisionID


	WHILE (@MinMonth+@MinYear*100 <= @TranMonth+@TranYear*100)
	BEGIN
			SET @Cur = CURSOR SCROLL KEYSET FOR
			SELECT	TableName
			FROM	#ListTable T1	

			OPEN @Cur
			FETCH NEXT FROM @Cur INTO @TableName
			WHILE @@FETCH_STATUS = 0
			BEGIN

				SELECT @sTranMonth = CASE WHEN @MinMonth >= 10 THEN Convert(Varchar(2),@MinMonth) ELSE '0'+ Convert(Varchar(1),@MinMonth) END
				SELECT @sTranYear = Convert(Varchar(4),@MinYear)

				SELECT @sSQL1= '
				IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].['+@TableName+'M'+@sTranMonth+Convert(Varchar(4),@TranYear)+']'') AND type in (N''U''))
				BEGIN
					SELECT *
					INTO [dbo].['+@TableName+'M'+@sTranMonth+Convert(Varchar(4),@TranYear)+'] 
					FROM '+@TableName+'
					WHERE	1 = 0

					IF NOT EXISTS(SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 50) OR '''+@TableName+''' <> ''HT2400''
					BEGIN
						INSERT INTO [dbo].['+@TableName+'M'+@sTranMonth+Convert(Varchar(4),@TranYear)+'] 
						SELECT *
						FROM	'+@TableName+'
						WHERE TranMonth = '+@sTranMonth+' AND TranYear = '+@sTranYear+'
					END
				END


				IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].['+@TableName+'Y'+Convert(Varchar(4),@TranYear)+']'') AND type in (N''U''))
				BEGIN
					SELECT *
					INTO [dbo].['+@TableName+'Y'+Convert(Varchar(4),@TranYear)+']
					FROM '+@TableName+'
					WHERE	1 = 0

					INSERT INTO [dbo].['+@TableName+'Y'+Convert(Varchar(4),@TranYear)+']
					SELECT *
					FROM	'+@TableName+'
					WHERE TranYear = '+@sTranYear+'
				END

				'
				
				--Print (@sSQL1)
				EXEC(@sSQL1)
			FETCH NEXT FROM @Cur INTO @TableName
			END 
			Close @Cur 

			IF @MinMonth = 12
				SELECT @MinMonth = 1, @MinYear = @MinYear + 1
			ELSE
				SET @MinMonth = @MinMonth + 1
	END
	
	----- Chạy đồng bộ cấu trúc cho bảng gốc và bảng được tách mới sinh ra
	EXEC AP0009 @ModuleID
END



SET NOCOUNT OFF

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

