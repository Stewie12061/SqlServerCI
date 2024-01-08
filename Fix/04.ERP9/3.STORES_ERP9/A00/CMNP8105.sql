IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CMNP8105]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CMNP8105]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Xử lý các check code mặc định trong định nghĩa nhập dữ liệu từ Excel
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 20/04/2018 by Trương Ngọc Phương Thảo
---- Modify on 08/01/2019 by Tuấn Anh - Chỉnh sửa câu check code mặc định cho phép chạy nhiều CheckExpression trong 1 cột được split bởi dấu |
---- Modify on 06/05/2020 by Kiều Nga - Chỉnh sửa string_split sang dbo.StringSplit
-- <Example>
---- 
CREATE PROCEDURE [DBO].[CMNP8105]
( 
	@ImportTemplateID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@SType TINYINT = NULL
) 
AS 

DECLARE @CheckValue AS NVARCHAR(4000)
DECLARE @CheckCode  AS VARCHAR(50),
		@ParamList AS VARCHAR(4000),
		@ColID AS VARCHAR(50)		

DECLARE @sSQL AS NVARCHAR(4000)
DECLARE @BeginParamPos AS INT
DECLARE @EndParamPos AS INT
DECLARE @BeginCheckCodePos AS INT
DECLARE @EndCheckCodePos AS INT
--Tạo con trỏ duyệt qua các CheckExpression
DECLARE @cCheckCode AS CURSOR
SET @cCheckCode = CURSOR STATIC FOR
	SELECT		LTRIM(RTRIM(BTL.CheckExpression)), BTL.ColID 
	FROM		A00065 BTL
	WHERE		ISNULL(BTL.SType,0) = CASE WHEN @SType IS NULL THEN ISNULL(BTL.SType,0) ELSE @SType END 
			AND	BTL.ImportTransTypeID = @ImportTemplateID
	ORDER BY	BTL.OrderNum
	
OPEN @cCheckCode
FETCH NEXT FROM @cCheckCode	INTO @CheckValue, @ColID
WHILE @@FETCH_STATUS = 0
BEGIN
	--- Tách các CheckExpress con:
	DECLARE @ChildExpression AS CURSOR , @CheckChildValue AS VARCHAR(4000)
	SET @ChildExpression = CURSOR STATIC FOR 
							SELECT CONCAT(value, ';') as Value
							FROM dbo.StringSplit(@CheckValue,'|')
	OPEN @ChildExpression

   FETCH NEXT FROM @ChildExpression	INTO @CheckChildValue
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--PRINT CONCAT(@ColID,':', @CheckChildValue)
		--PRINT  @CheckChildValue
		--PRINT '----------------'
		SET @BeginCheckCodePos = PATINDEX('{Check%}%', @CheckChildValue)				
		SET @EndCheckCodePos = CHARINDEX(';', @CheckChildValue)
		SET @BeginParamPos = CHARINDEX('}', @CheckChildValue, @BeginCheckCodePos)
		 IF(LEN(@CheckChildValue) > 10 AND @EndCheckCodePos > 0)
			BEGIN		
				PRINT CONCAT(@BeginCheckCodePos,',',@EndCheckCodePos,',',@BeginParamPos)
				SET @CheckCode = SUBSTRING(@CheckChildValue, @BeginCheckCodePos + 1, @BeginParamPos - @BeginCheckCodePos - 1)
				SET @ParamList = RTRIM(LTRIM(SUBSTRING(@CheckChildValue, @BeginParamPos + 1, @EndCheckCodePos - @BeginParamPos - 1)))
				SET @sSQL = 'EXEC CMNP8100 @UserID = ''' + @UserID + ''', @ImportTemplateID = ''' + @ImportTemplateID + ''', @CheckCode = ''' +  @CheckCode + ''', @ColID = ''' + @ColID + '''' + CASE WHEN @ParamList <> '' THEN ', ' + @ParamList ELSE '' END
				--PRINT @sSQL
				EXEC (@sSQL)
			--SET @CheckChildValue = RIGHT(@CheckChildValue, LEN(@CheckChildValue) - @EndCheckCodePos)
			END
		FETCH NEXT FROM @ChildExpression INTO @CheckChildValue
	END	
	CLOSE @ChildExpression
	FETCH NEXT FROM @cCheckCode	INTO @CheckValue, @ColID
END	
CLOSE @cCheckCode


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
