
IF OBJECT_ID('dbo.DecodeHTML') IS NOT NULL
BEGIN
	DROP FUNCTION dbo.DecodeHTML
END
GO

-- <Summary>
----	Hàm decode html lấy từ stackoverflow
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 04/02/2021 by Đức Thông

CREATE FUNCTION dbo.DecodeHTML (@vcWhat NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @vcResult NVARCHAR(MAX)
    DECLARE @siPos INT
        ,@vcEncoded NVARCHAR(7)
        ,@siChar INT

    SET @vcResult = RTRIM(LTRIM(CAST(REPLACE(@vcWhat COLLATE Latin1_General_BIN, CHAR(0), '') AS NVARCHAR(MAX))))

    SELECT @vcResult = REPLACE(REPLACE(@vcResult, '&#160;', ' '), '&nbsp;', ' ')

    IF @vcResult = ''
        RETURN @vcResult

    SELECT @siPos = PATINDEX('%&#[0-9][0-9][0-9];%', @vcResult)

    WHILE @siPos > 0
    BEGIN
        SELECT @vcEncoded = SUBSTRING(@vcResult, @siPos, 6)
            ,@siChar = CAST(SUBSTRING(@vcEncoded, 3, 3) AS INT)
            ,@vcResult = REPLACE(@vcResult, @vcEncoded, NCHAR(@siChar))
            ,@siPos = PATINDEX('%&#[0-9][0-9][0-9];%', @vcResult)
    END

    SELECT @siPos = PATINDEX('%&#[0-9][0-9][0-9][0-9];%', @vcResult)

    WHILE @siPos > 0
    BEGIN
        SELECT @vcEncoded = SUBSTRING(@vcResult, @siPos, 7)
            ,@siChar = CAST(SUBSTRING(@vcEncoded, 3, 4) AS INT)
            ,@vcResult = REPLACE(@vcResult, @vcEncoded, NCHAR(@siChar))
            ,@siPos = PATINDEX('%&#[0-9][0-9][0-9][0-9];%', @vcResult)
    END

    SELECT @siPos = PATINDEX('%#[0-9][0-9][0-9][0-9]%', @vcResult)

    WHILE @siPos > 0
    BEGIN
        SELECT @vcEncoded = SUBSTRING(@vcResult, @siPos, 5)
            ,@vcResult = REPLACE(@vcResult, @vcEncoded, '')
            ,@siPos = PATINDEX('%#[0-9][0-9][0-9][0-9]%', @vcResult)
    END

    SELECT @vcResult = REPLACE(REPLACE(@vcResult, NCHAR(160), ' '), CHAR(160), ' ')

    SELECT @vcResult = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@vcResult, '&amp;', '&'), '&quot;', '"'), '&lt;', '<'), '&gt;', '>'), '&amp;amp;', '&')

    RETURN @vcResult
END

GO