MH <- read.delim("MexHigh.outlierPBE.txt")
head(MH)
GH <- read.delim("GuaHigh.outlierPBE.txt")
head(GH)
SW_US <- read.delim("SW_US.outlierPBE.txt")
Andes <- read.delim("Andes.outlierPBE.txt")
MH_GH <- c(MH$ID, GH$ID)
MH_GH.labels <- c(rep("MH", length(MH$ID)), rep("GH", length(GH$ID)))
length(MH_GH)
nsims <- 1000000
obs <- length(intersect(MH$ID, GH$ID))
obs
sim.overlap <- rep(NA, nsims)
for (i in 1:nsims){
shuffled_labels <- sample(MH_GH.labels, replace=F)
sim.overlap[i] <- length(intersect(MH_GH[shuffled_labels=="MH"], MH_GH[shuffled_labels=="GH"]))
}
head(sim.overlap)
summary(sim.overlap)
p <- length(sim.overlap[sim.overlap >= obs])/nsims
savehistory("permutationTest.R")
