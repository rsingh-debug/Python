# Example data (replace with your own)

data <- read.csv("C:/path/to/your/file.csv")


FF <-FFpointextract
FFVul <-FF.Vul_Class
FFTop <-FF.Topography
FFSOIL <-FF.SOIPCA
FFNDVI <-FF.NDVI

data <- data.frame(
  x1 = c(1, 2, 3, 4, 5),
  x2 = c(0.5, 1.0, 1.5, 2.0, 2.5),
  fire_occurrence = c(0, 1, 0, 1, 1)  # 0 = no fire, 1 = fire
)
TrainData<-Train_VIIRSFFpoints

Fire_occurrence = TrainData$ocuurence
Ndbi= TrainData$NDBI_1
Anth= TrainData$Anthro
Lst=TrainData$LST
Bio2=TrainData$bio_2
Bio3=TrainData$bio_3
Bio9=TrainData$bio_9
Bio10=TrainData$bio_10
Bio12=TrainData$bio_12
Bio17=TrainData$bio_17
Bio18=TrainData$bio_18
Slp=TrainData$Slope
Ast=TrainData$Aspect
Crv=TrainData$Curvature
Soc=TrainData$SOC
Snt=TrainData$SoilN
SMO=TrainData$SoilMoisture
NDV=TrainData$NDVI
FCM=TrainData$FCM

DataFrame <-data.frame(
                  Focc=as.numeric(TrainData$Ocuurence),
                  Ndbi= as.numeric(TrainData$NDBI_1),
                  Anth= as.numeric(TrainData$Anthro),
                  Lst=as.numeric(TrainData$LST),
                  Bio2=as.numeric(TrainData$bio_2),
                  Bio3=as.numeric(TrainData$bio_3),
                  Bio9=as.numeric(TrainData$bio_9),
                  Bio10=as.numeric(TrainData$bio_10),
                  Bio12=as.numeric(TrainData$bio_12),
                  Bio17=as.numeric(TrainData$bio_17),
                  Bio18=as.numeric(TrainData$bio_18),
                  Slp=as.numeric(TrainData$Slope),
                  Ast=as.numeric(TrainData$Aspect),
                  Crv=as.numeric(TrainData$Curvature),
                  Soc=as.numeric(TrainData$SOC),
                  Snt=as.numeric(TrainData$SoilN),
                  SMO=as.numeric(TrainData$SoilMoisture),
                  NDV=as.numeric(TrainData$NDVI),
                  FCM=as.numeric(TrainData$FCM))

DF<-DataFrame[1:10,]

#replace blank values

#df$a[is.na(df$a)] <- 0

DataFrame$Ndbi[is.na(DataFrame$NDBI)] <-0
DataFrame$Anth[is.na(DataFrame$Anth)] <-0
DataFrame$Lst[is.na(DataFrame$Lst)] <-0
DataFrame$Bio2[is.na(DataFrame$Bio2)] <-0
DataFrame$Bio3[is.na(DataFrame$Bio3)] <-0

DataFrame$Bio9[is.na(DataFrame$Bio9)] <-0
DataFrame$Bio10[is.na(DataFrame$Bio10)] <-0
DataFrame$Bio12[is.na(DataFrame$Bio12)] <-0
DataFrame$Bio17[is.na(DataFrame$Bio17)] <-0
DataFrame$Bio18[is.na(DataFrame$Bio18)] <-0

DataFrame$Slp[is.na(DataFrame$Slp)] <-0
DataFrame$Ast[is.na(DataFrame$Ast)] <-0
DataFrame$Crv[is.na(DataFrame$Crv)] <-0
DataFrame$Soc[is.na(DataFrame$Soc)] <-0
DataFrame$Snt[is.na(DataFrame$Snt)] <-0

DataFrame$SMO[is.na(DataFrame$SMO)] <-0
DataFrame$NDV[is.na(DataFrame$NDV)] <-0
DataFrame$FCM[is.na(DataFrame$FCM)] <-0
DataFrame$Focc[is.na(DataFrame$Focc)] <-0



# Fit the GLM

glm_model1 <- glm(Focc ~ Ndbi + Anth + Lst + Bio2 + Bio3 + Bio9 + Bio10 + Bio12 + Bio17 + Bio18 + Slp + Ast + Crv + Soc + Snt + SMO + NDV + FCM, data = DataFrame, family = binomial(link = "logit"))

glm_model <- glm(TrainData$Ocuurence ~ (TrainData$NDBI_1 + TrainData$Anthro + TrainData$LST + TrainData$bio_2 + TrainData$bio_3 + TrainData$bio_9 + TrainData$bio_10 + TrainData$bio_12 + TrainData$bio_17 + TrainData$bio_18 +
                 TrainData$Slope + TrainData$Curvature + TrainData$SOC + TrainData$SoilN + TrainData$SoilMoisture + TrainData$NDVI + TrainData$FCM), data = TrainData, family = binomial(link = "logit"))

library(raster)

# Load your raster data (replace with your own)
raster_data <- raster("D:/Data/01_LCC_DATA/UK_Layer_Composite/testcomposite1.tif")

#rasterDF <-as.data.frame(raster_data, XY=TRUE)
  
plot(raster_data)


predicted_raster <- ifelse((raster_data > -10), 
                           #value_if_true
                           predict(raster_data, model = glm_model, type = "response", newdata = raster_data), 
                           #value_if_false
                           0)

# Predict fire occurrence on the raster
predicted_raster <- predict(raster_data, model = glm_model, type = "response", newdata = raster_data)
#visualize the prediction
plot(predicted_raster, main = "Fire Occurrence Probability")






RFPfinal<- subset(Firepoints, select = -c(1:2))


cor_matric<-cor(RFPfinal)

corrplot(cor_matric, type = "upper", method = "square", addCoef.col = "black",  
         tl.col = "black", tl.srt = 45)

corrplot(cor_matric, type= "full", method="square", addCoef.col = "black",  
         tl.col = "black", tl.srt = 0)

corrplot(cor_matric, type="upper", method ="square"
           + addCoef.col="black", t1.col="black", t1.srt=45)


plot(Firepoints)

Rpoints<-random_points(Firepoints, n = 100, type = "random", presence = NULL)



rr<-randomNumbers(n =500, min=1, max = 41000, col=15,base=10, check= TRUE)
