library(dplyr)

# esto me da los nombres de las columnas de las tablas que importemos

colnames(Results.BRONQUIOLO)

#con esto separo los resultados de la columna 

resultados <- select(Results.BRONQUIOLO, Area)

#genera el dato para normalizar los resultados y creo el objeto normalizador

normalizador <-mean(resultados[130:150,])

#aplicamos la normalizacion indicada del excel, esto es el valor dividido la media de los 20 valores antes del fin de perfusión de HBSS

datos_normalizados <- (resultados/normalizador)*100

#resultados normalizados


datos_normalizados$tiempo <- seq(2, by = 2, length.out = nrow(datos_normalizados))

datos_normalizados$Tiempo_Minutos <- datos_normalizados$tiempo / 60

#install.packages("plotly") esto es una libreria para graficar de manera interactiva, esto es poner el cursor sobre un dato y visualizar el dato

library(ggplot2)

# Graficar dosis-respuesta normalizada vs tiempo con ggplot2


p <- ggplot(datos_normalizados, aes(x = Tiempo_Minutos, y = Area)) +
  geom_line(color = "blue") +
  labs(x = "Tiempo (minutos)", y = "Área (%)",
       title = "Curva Dosis respuesta a") +
  
  theme(axis.line = element_line(arrow = arrow(angle = 30,
                                               length = unit(0.15, "inches"),
                                               ends = "last", 
                                               type = "closed")))  #este parrafo marca las lineas de eje x e y




p + theme(panel.grid.major.x = element_line(color = "red", 
                                            size = 0.5, 
                                            linetype = 2))+
  theme(panel.grid.minor = element_blank())+ 
  theme(panel.grid.major = element_blank())





p#necesito iniciar desde 0 en eje x, , agregar marcas en minutos determinados y agregar etiquetas de concentración por dosis



library(plotly)
ggplotly(p) #grafico dinamico, para extraer valores para cuantificar contraccion maxima por concentración 

