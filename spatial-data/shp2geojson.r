library(rgdal)
library(geojsonio)
library(spdplyr)
library(rmapshaper)
library(dplyr)
library(stringr)

#Setar o diretorio do arquivo como diretório de trabalho
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#Pegar todos os nomes dos .shp contidos na pasta ./input
files <- list.files(path=paste(getwd(),"/input", sep = ""), pattern="*.shx", full.names=FALSE, recursive=FALSE)

#Loop realizando a conversão em cada um dos shapes de ./input e colando em input
lapply(files, function(x){
  shpfile <- str_sub(x,1,nchar(x)-4)
  
  #Ler o .shp e transformar na projeção WGS84 (mesmo que ja esteja projetado)
  municutf <- readOGR(paste(getwd(),"/input", sep = ""), layer = shpfile, verbose = FALSE)
  municutf <- spTransform(municutf, CRS("+proj=longlat +datum=WGS84"))
  
  #Transformar em geojson 
  county_json <- geojson_json(municutf)
  #Salvar o arquivo
  geojson_write(county_json, file = paste(getwd(),"/output/", shpfile, ".geojson", sep = ""))
})