declare @ID			nvarchar(MAX) 
declare @LanguageID nvarchar(MAX)	
declare @LanguageValue		nvarchar(MAX) 	
declare @ModuleID		nvarchar(MAX)
declare @Deleted	nvarchar(MAX) 		
declare @FormID		nvarchar(MAX)
declare @KeyID nvarchar(max)

set @LanguageID = N'vi-VN'	
set @ModuleID = 'SHM'	
set @FormID =  'SHMF3002'


--------------------		
set @LanguageValue		 = N'Báo cáo cổ tức phải trả'	
set @KeyID		= @FormID + '.Title'	
EXEC ERP9AddLanguage @ModuleID, @KeyID , @FormID, @LanguageValue, @LanguageID;

--------------------		
set @LanguageValue		 = N'Đơn vị'	
set @KeyID		= @FormID + '.DivisionID'
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @LanguageValue, @LanguageID;

--------------------	
set @LanguageValue		 = N'Từ cổ đông'	
set @KeyID		= @FormID + '.FromObjectName'
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @LanguageValue, @LanguageID;
--------------------
set @LanguageValue		 = N'Đến cổ đông'
set @KeyID		= @FormID + '.ToObjectName'	
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @LanguageValue, @LanguageID;

--------------------	
set @LanguageValue		 = N'Từ ngày'	
set @KeyID		= @FormID + '.FromDate'
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @LanguageValue, @LanguageID;

--------------------
set @LanguageValue		 = N'Đến ngày'	
set @KeyID		= @FormID + '.ToDate'
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @LanguageValue, @LanguageID;

--------------------	
set @LanguageValue		 = N'Từ kỳ'	
set @KeyID		= @FormID + '.PeriodID'
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @LanguageValue, @LanguageID;



