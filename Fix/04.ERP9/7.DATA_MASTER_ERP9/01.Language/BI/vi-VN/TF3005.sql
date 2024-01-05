declare @ID			nvarchar(MAX) 
declare @LanguageID nvarchar(MAX) 			
declare @LanguageValue		nvarchar(MAX) 	
declare @ModuleID		nvarchar(MAX) 	
declare @Deleted	nvarchar(MAX) 		
declare @FormID		nvarchar(MAX) 	

--------------------		
SET @LanguageID = 'vi-VN' 
SET @ModuleID = 'BI';
SET @FormID = 'TF3005';

set @LanguageValue		 = N'Báo cáo ngân sách nhu cầu vốn'	
EXEC ERP9AddLanguage @ModuleID, 'TF3005.Title', @FormID, @LanguageValue, @LanguageID;	

--------------------			
set @LanguageValue		 = N'Đơn vị'	
EXEC ERP9AddLanguage @ModuleID, 'TF3005.DivisionID', @FormID, @LanguageValue, @LanguageID;

--------------------	
set @LanguageValue		 = N'Loại ngân sách'	
EXEC ERP9AddLanguage @ModuleID, 'TF3005.BudgetTypeID', @FormID, @LanguageValue, @LanguageID;		

--------------------
set @LanguageValue		 = N'Kỳ ngân sách'	
EXEC ERP9AddLanguage @ModuleID, 'TF3005.FromMonth', @FormID, @LanguageValue, @LanguageID;

--------------------	
set @LanguageValue		 = N'Đến'	
EXEC ERP9AddLanguage @ModuleID, 'TF3005.FromYear', @FormID, @LanguageValue, @LanguageID;

--------------------	
set @LanguageValue		 = N'Đến'	
EXEC ERP9AddLanguage @ModuleID, 'TF3005.ToMonth', @FormID, @LanguageValue, @LanguageID;

--------------------		
set @LanguageValue		 = N'Đến'	
EXEC ERP9AddLanguage @ModuleID, 'TF3005.ToYear', @FormID, @LanguageValue, @LanguageID;



