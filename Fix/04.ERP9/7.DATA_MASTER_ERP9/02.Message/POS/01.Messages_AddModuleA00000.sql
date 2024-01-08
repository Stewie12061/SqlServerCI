/*
==============================================================================================
--- Script sinh message cho module
--- Module MT
==============================================================================================
*/

IF NOT EXISTS (SELECT 1 FROM   [A00000] WHERE [Module] =  'POS' and LanguageID = 'vi-VN' and [Type] = 'M')
  INSERT INTO [A00000]([LanguageID],[LanguageName],[Module], [InsertDate], [UpdateDate], [Version], [Type])
  VALUES ('vi-VN', N'Tiếng Việt','POS',GetDate(), GetDate(), 1, 'M');
  
IF NOT EXISTS (SELECT 1 FROM   [A00000] WHERE [Module] =  'POS' and LanguageID = 'en-US' and [Type] = 'M')
  INSERT INTO [A00000]([LanguageID],[LanguageName],[Module], [InsertDate], [UpdateDate], [Version], [Type])
  VALUES ('en-US', N'English','POS',GetDate(), GetDate(), 1, 'M');

--Select * from A00000 where Module = 'MT'