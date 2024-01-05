declare @ID			nvarchar(MAX) 
declare @LanguageID nvarchar(MAX) 			
declare @LanguageValue		nvarchar(MAX) 	
declare @ModuleID		nvarchar(MAX) 	
declare @Deleted	nvarchar(MAX) 		
declare @FormID		nvarchar(MAX) 	

--------------------
set @LanguageID  = N'vi-VN'	
set @ModuleID	 = 'SHM'	
set @FormID		 = 'SHMF3000A'

--------------------	
set @LanguageValue		 = N'Danh sách chia cổ tức'
EXEC ERP9AddLanguage @ModuleID, 'SHMF3000A.Title', @FormID, @LanguageValue, @LanguageID;

--------------------	
set @LanguageValue		 = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'SHMF3000A.DivisionID', @FormID, @LanguageValue, @LanguageID;

--------------------	
set @LanguageValue		 = N'Từ cổ đông'
EXEC ERP9AddLanguage @ModuleID, 'SHMF3000A.FromObjectID', @FormID, @LanguageValue, @LanguageID;

--------------------	
set @LanguageValue		 = N'Đến cổ đông'
EXEC ERP9AddLanguage @ModuleID, 'SHMF3000A.ToObjectID', @FormID, @LanguageValue, @LanguageID;

--------------------	
set @LanguageValue		 = N'Từ cổ đông'
EXEC ERP9AddLanguage @ModuleID, 'SHMF3000A.FromObjectName', @FormID, @LanguageValue, @LanguageID;

--------------------	
set @LanguageValue		 = N'Đến cổ đông'
EXEC ERP9AddLanguage @ModuleID, 'SHMF3000A.ToObjectName', @FormID, @LanguageValue, @LanguageID;