IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QCF_ContentChange]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[QCF_ContentChange]
GO
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 1/21/2016 1:57:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
---Lấy nội dung thay đổi của hệ thống
---Design Date: 05/07/2023
---Design Person: Viết Toàn
----Modified by Mạnh Cường on 28/07/2023: Cải tiến hiệu suất truy vấn

CREATE FUNCTION dbo.QCF_ContentChange
(
    @input NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @tempString NVARCHAR(MAX),
			@delimiter NVARCHAR(1) = '''',
			@subStr NVARCHAR(MAX),
			@newLine NVARCHAR(MAX),
			@rtnStr NVARCHAR(MAX)
	DECLARE @result TABLE (chuoi NVARCHAR(MAX))
	SET @input = REPLACE(@input, '''', '')
	SET @input = REPLACE(@input, '</br>', ' ')

	-- Tách chuỗi thành các phần tử theo dấu khoảng trắng
	DECLARE @inputArray TABLE (
	  Value NVARCHAR(MAX)
	)

	WHILE CHARINDEX(' ', @input) > 0
	BEGIN
	  SET @subStr = LTRIM(RTRIM(SUBSTRING(@input, 1, CHARINDEX(' ', @input) - 1)))
	  SET @newLine = ISNULL((SELECT TOP 1 Name FROM TEMPP_HISTORY WITH (NOLOCK) WHERE @subStr LIKE '%' + ID + '%'), @subStr)
	  INSERT INTO @inputArray (Value)
	  SELECT @newLine

	  SET @input = SUBSTRING(@input, CHARINDEX(' ', @input) + 1, LEN(@input))
	END

	-- Thêm phần tử cuối cùng vào mảng
	INSERT INTO @inputArray (Value)
	SELECT LTRIM(RTRIM(@input))

	SELECT @subStr = STRING_AGG(value, ' ') 
	FROM @inputArray

    RETURN @subStr
END

