--- Created by Le Thi Thu Hien on 17/07/2014
--- Danh mục báo cáo

If Exists (Select * From sysobjects Where name = 'POST8888' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POST8888'  and col.name = 'FormID')
           Alter Table  POST8888 Add FormID nvarchar(50) Not Null Default('')
End 
