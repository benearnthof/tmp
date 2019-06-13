
#GRUPPE cox 

install.packages("agricolae")
library(agricolae)

#Erstellen des Dataframes von den gesamten Daten

Daten <- matrix(nrow=1008,ncol=3)
data <- matrix(nrow = 1008, ncol = 4)
colnames(Daten) <- c("Strecke","Tag_Tageszeit","Treatment")
colnames(data) <- c("Strecke", "Tag", "Tageszeit", "Treatment")
Tageszeit <- c("morgens","mittags","abends")
tageszeit <- c("morgens","mittags","abends")
Wochentag <- c("Mo","Di","Mi","Do","Fr","Sa","So")
wochentag <- c("Mo","Di","Mi","Do","Fr","Sa","So")
Daten <- as.data.frame(Daten)
data <- as.data.frame.matrix(data)

#Die Zuweisung von den Strecken in die Datentabelle
Strecke <- rep(c("S1","S2", "S3", "S4"),252)
Daten[,1] <- Strecke
data$Strecke <- Strecke
days <- rep(wochentag, each = 3)
# 1008/21 = 48
days <- rep(days, 48)
data$Tag <- days
# 1008/3 = 336
time <- rep(tageszeit, 336)
data$Tageszeit <- time

#Erstellen eines leeren Vektors um die Wochentag und Tageszeit Kombination zu erhalten. Diese dann zuweisen.


Woche_zeit <- c()
k <- 0
for(i in 1:7){
  for(j in 1:3){
    k <- k+1
    Woche_zeit[k] <- paste(Wochentag[i],Tageszeit[j])
  }
}


Woche_zeit <- rep(Woche_zeit, times=12,each=4)
Daten[,2] <- Woche_zeit


#Anhand der design.lsd Funktion die zufällige Treatment-Verteilung ausgewertet, die "T4"-Werte die als NA bezeichnet,
#worden sind entfernt und anschließend die Treatments dem "Daten"- Datensatz hinzugefügt.

varieties <- c("T1","T2","T3","T4")
tag_zeit <- c()
s <- 1
z <- 12
for(x in 1:84) {
  outdesign <- design.lsd(varieties,serie = 2,seed=x)
  lsd <- outdesign$book
  lsd$varieties[lsd$varieties == "T4"] <- NA
  lsd <- na.omit(lsd)
  tag_zeit <- lsd$varieties
  Daten[s:z,3] <- tag_zeit
  s <- s+12
  z<-  z+12
} 

varieties <- c("T1","T2","T3")
tag_zeit <- c()
outdesign <- design.lsd(varieties,serie = 2,seed=1)
lsd <- outdesign$book
# lsd$varieties[lsd$varieties == "T4"] <- NA
lsd <- na.omit(lsd)
tag_zeit <- lsd$varieties
Daten[s:z,3] <- tag_zeit
s <- s+12
z<-  z+12
