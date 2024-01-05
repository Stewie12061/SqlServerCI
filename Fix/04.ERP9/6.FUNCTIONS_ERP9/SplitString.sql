IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE [NAME] = 'SplitString' AND [TYPE] = 'TF')
	DROP FUNCTION SplitString
GO
-- <Summary>
---- Cắt chuỗi
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Nhật Thanh on 09/08/2022

-- <Example>
CREATE FUNCTION SplitString ( @stringToSplit VARCHAR(MAX), @stringSplit VARCHAR(MAX))
RETURNS
 @returnList TABLE ([Name] [nvarchar] (500))
AS
BEGIN

 DECLARE @name NVARCHAR(255)
 DECLARE @pos INT

 WHILE CHARINDEX(@stringSplit, @stringToSplit) > 0
 BEGIN
  SELECT @pos  = CHARINDEX(@stringSplit, @stringToSplit)  
  SELECT @name = SUBSTRING(@stringToSplit, 1, @pos-1)

  INSERT INTO @returnList 
  SELECT @name

  SELECT @stringToSplit = SUBSTRING(@stringToSplit, @pos+1, LEN(@stringToSplit)-@pos)
 END

 INSERT INTO @returnList
 SELECT @stringToSplit

 RETURN
END
