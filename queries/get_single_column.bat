sqlcmd -S *server* -d adventureworks2022 -U *user* -P *pass* -Q "select distinct(productid) from purchasing.purchaseorderdetail order by productid;" -s "," -W -o purchase.txt
sqlcmd -S *server* -d adventureworks2022 -U *user* -P *pass* -Q "select distinct(productid) from production.workorder order by productid;" -s "," -W -o produce.txt
sqlcmd -S *server* -d adventureworks2022 -U *user* -P *pass* -Q "select distinct(productid) from production.productinventory order by productid;" -s "," -W -o inventory.txt
