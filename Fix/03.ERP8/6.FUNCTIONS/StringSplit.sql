IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE [NAME] = 'StringSplit' AND [TYPE] = 'TF')
	DROP FUNCTION StringSplit
GO
-- <Summary>
---- Hàm cắt chuổi 
---- Hoạt động như string_split (vì Compatibility level không hỗ trợ string_split)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Bảo Toàn on 04/09/2019
-- <Example>
CREATE FUNCTION [dbo].StringSplit
(
    @String  VARCHAR(MAX), @Separator CHAR(1)
)
RETURNS @RESULT TABLE(Value VARCHAR(MAX))
AS
BEGIN     
 DECLARE @SeparatorPosition INT = CHARINDEX(@Separator, @String ),
        @Value VARCHAR(MAX), @StartPosition INT = 1
 
 IF @SeparatorPosition = 0  
  BEGIN
   INSERT INTO @RESULT VALUES(@String)
   RETURN
  END
     
 SET @String = @String + @Separator
 WHILE @SeparatorPosition > 0
  BEGIN
   SET @Value = SUBSTRING(@String , @StartPosition, @SeparatorPosition- @StartPosition)
 
   IF( @Value <> ''  ) 
    INSERT INTO @RESULT VALUES(@Value)
   
   SET @StartPosition = @SeparatorPosition + 1
   SET @SeparatorPosition = CHARINDEX(@Separator, @String , @StartPosition)
  END    
     
 RETURN
END