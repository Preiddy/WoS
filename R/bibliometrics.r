#Load library and connect to db
library(DBI)
library (RSQLite)
driver <- dbDriver("SQLite")
mycon <- dbConnect(driver, dbname = "metodologia.db")

#Indicators
#Year
prod.year <- dbGetQuery(mycon,"SELECT PY,  COUNT(PY) AS Frec FROM isi_t_todo GROUP BY PY")
plot(prod.year, type="o",ylim=c(600,800))
write.csv2(prod.year,"Prod_Year.csv")
#Source
prod.source<- dbGetQuery(mycon,"SELECT SO,  COUNT(SO) AS FREC FROM isi_t_todo GROUP BY SO ORDER BY FREC DESC")
plot(prod.source$FREC, type="l", log="y")
write.csv2(prod.source,"Prod_Anio_Rev.csv")
#Document Type
doctype=dbGetQuery(mycon,"SELECT DT,  COUNT(DT) AS Frec FROM isi_t_todo GROUP BY DT")
#Language
lang=dbGetQuery(mycon,"SELECT LA,  COUNT(LA) AS Frec FROM isi_t_todo GROUP BY LA")
#Author
prod.au=dbGetQuery(mycon,"SELECT AU,  COUNT(AU) AS Frec FROM isi_t_autor GROUP BY TRIM(AU) ORDER BY Frec DESC")
#Category
prod.cat=dbGetQuery(mycon,"SELECT WC,  COUNT(WC) AS Frec FROM isi_t_cat GROUP BY TRIM(WC) ORDER BY Frec DESC")

#Close
sqliteCloseConnection(mycon)
sqliteCloseDriver(driver)
