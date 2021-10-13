install.packages("xtable")
install.packages("htmltools")
install.packages("htmlwidgets")
install.packages("jsonlite")

## a dummy data.frame used as an example
library(xtable)
library(htmltools)
library(htmlwidgets)
library(jsonlite)

respuestas<- fromJSON("respuestas2.json", flatten=TRUE)
preguntas<- fromJSON("preguntas.json", flatten=TRUE)

# applies function 'mean' to 2nd dimension (columns)
medias <- sapply(respuestas,mean,na.rm = TRUE)
medianas <- sapply(respuestas,median,na.rm =TRUE)
varianzas <- sapply(respuestas,var,na.rm=TRUE)
desviaciones <- sapply(respuestas,sd,na.rm=TRUE)

nPrim <- data.frame()
# BUCLE MEDIAS

## the html header
html.head <- paste("<head>" ,
                   "<link rel='stylesheet' type='text/css' href='mystyle.css'/>",
                   "</head>")

for(i in 7:29){
  
  assign(paste('parr',i, sep = ''), preguntas[1,c(i-4)])
  #parr <- print(preguntas[1,c(i-4)])
  n <- data.frame(Media = c(medias[[c(i)]]), Mediana =c(medianas[[c(i)]]), Varianza =c(varianzas[[c(i)]]),DesviacionEstandar =c(desviaciones[[c(i)]]))
  nPrim=rbind(nPrim,n)
  
  ## the html body
  html.table <- paste(print(xtable(nPrim),type="html","res.html"),
                      collapse = "n")
  if(parr=='NA'){
    
  }else{
    html.parraf <- paste("<p>",paste('parr',i, sep = ''),"</p>")
    html.body <- paste("<body>",html.parraf,html.table,"</body>")
    print(html.parraf)
  }
}
write(paste(html.head,html.body),"res.html")

char_list <- c("parr")

i <- 1
for (char in char_list) {
  for (i in 7:29) {   
    assign(paste(char,i, sep = ''), i)       
    i <- i + 1
  }
}





