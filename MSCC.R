############
### MSCC ###
############

# Cite: Albert Rivas-Ubach, Yina Liu, Thomas Stephen Bianchi, Nikola Tolic, Christer Jansson, and Ljiljana Paša-Tolic. (2018) Moving beyond the van Krevelen diagram: A new stoichiometric approach for compound classification in organisms. Analytical Chemistry, DOI: 10.1021/acs.analchem.8b00529


# VARIABLES REQUIRED IN THE DATASET (make sure your dataset includes the following variables with the names as described below; variables need to be in columns and the detected features need to be in rows):
# O.C <- O:C ratio column
# H.C <- H:C ratio column
# N.C <- N:C ratio column
# P.C <- P:C ratio column
# N.P <- N:P ratio column
# O <- O column
# N <- N column
# P <- P column
# S <- S column
# Mass <- exact mass column



## THE FOLLOWING 3 SECTIONS HAVE TO BE USED BY THE USER ##
# In "R", directories Paths are written with two backslashes "\\".
# Example: C:\\DATA\\MSCC\\R\\MSCC_Test.csv

# Read the DATASET in CSV format containing all the required variables. 
# Example: C:\\DATA\\MSCC\\R\\MSCC_Test.csv
DATASET <- read.csv("Directory_of_the_dataset_in CSV_File", sep=",", header=T)

# Specify the directory of the resulting matchin results summary
# Example: C:\\DATA\\MSCC\\R\\MSCC_Test_Summary_Table.csv
Destination.File.Dataset <- "Directory_of_the_generated_matching_results_in_CSV_Format"

# Specify the directory for generating a summary of the reults in proportions
# Example: C:\\DATA\\MSCC\\R\\MSCC_Test_Summary_Proportions_Table.csv
Destination.File.Proportions <- "Directory_of_the_summary_proportion_results_in_CSV_Format"









## RUN THE FULL CODE BELOW ##

## 1st. STEP – ASSIGNATION OF COMPOUNDS ##
# Create a list for each compound category to keep the compound matches
list() -> Matching.Lipids
list() -> Matching.Carbohydrates
list() -> Matching.AminoSugars
list() -> Matching.Phytochemical
list() -> Matching.Protein.1
list() -> Matching.Protein.2
list() -> Matching.Nucleotides


# Loops for each compound category (we perform a single loop for each category to facilitate double matching detection)
# LIPID CONSTRAINTS
for (i in 1:nrow(DATASET)){ 
  if((DATASET[i,]$O.C <= 0.6) && 
     (DATASET[i,]$H.C >= 1.32) && 
     (DATASET[i,]$N.C <= 0.126) && 
     (DATASET[i,]$P.C < 0.35) && 
     (DATASET[i,]$N.P <= 5)){
    paste0("Lipid") -> Matching.Lipids[i]
  } else {
    paste0("") -> Matching.Lipids[i]
  }
}

# CARBOHYDRATE CONSTRAINTS  
for (i in 1:nrow(DATASET)){ 
  if((DATASET[i,]$O.C >= 0.8) && 
     (DATASET[i,]$H.C >= 1.65) && 
     (DATASET[i,]$H.C < 2.7) && 
     (DATASET[i,]$N == 0)){
    paste0("Carbohydrate") -> Matching.Carbohydrates[i]
  } else {
    paste0("") -> Matching.Carbohydrates[i]
  }
  }

# AMINO-SUGAR CONSTRAINTS
for (i in 1:nrow(DATASET)){    
  if((DATASET[i,]$O.C >= 0.61) && 
     (DATASET[i,]$H.C >= 1.45) && 
     (DATASET[i,]$N.C <= 0.2) && 
     (DATASET[i,]$N.C > 0.07) && 
     (DATASET[i,]$P.C < 0.3) && 
     (DATASET[i,]$N.P <= 2) && 
     (DATASET[i,]$O >= 3) && 
     (DATASET[i,]$N >= 1)){
    paste0("Amino.Sugar") -> Matching.AminoSugars[i]
  } else {
    paste0("") -> Matching.AminoSugars[i]
  }
}

# PHYTOCHEMICAL/OXYAROMATIC COMPOUND CONSTRAINTS
for (i in 1:nrow(DATASET)){
  if((DATASET[i,]$O.C <=1.15) && 
     (DATASET[i,]$H.C < 1.32) && 
     (DATASET[i,]$N.C < 0.126) && 
     (DATASET[i,]$P.C <= 0.2) && 
     (DATASET[i,]$N.P <= 3)){
    paste0("Phytochemical.Oxyaromatic.Compound") -> Matching.Phytochemical[i]
  } else {
    paste0("") -> Matching.Phytochemical[i]
  }
}

# PROTEIN (1) CONSTRAINTS 
for (i in 1:nrow(DATASET)){
  if((DATASET[i,]$O.C > 0.12) && 
     (DATASET[i,]$O.C <= 0.6) && 
     (DATASET[i,]$H.C > 0.9) && 
     (DATASET[i,]$H.C < 2.5) && 
     (DATASET[i,]$N.C >= 0.126) && 
     (DATASET[i,]$N.C <= 0.7) && 
     (DATASET[i,]$P.C < 0.17) && 
     (DATASET[i,]$N >= 1)){
    paste0("Protein") -> Matching.Protein.1[i]
  } else {
    paste0("") -> Matching.Protein.1[i]
  }
}

# PROTEIN (2) CONSTRAINTS
for (i in 1:nrow(DATASET)){
  if((DATASET[i,]$O.C > 0.6) && 
     (DATASET[i,]$O.C <= 1) && 
     (DATASET[i,]$H.C > 1.2) && 
     (DATASET[i,]$H.C < 2.5) && 
     (DATASET[i,]$N.C > 0.2) && 
     (DATASET[i,]$N.C <= 0.7) && 
     (DATASET[i,]$P.C < 0.17) && 
     (DATASET[i,]$N >= 1)){
    paste0("Protein") -> Matching.Protein.2[i]
  } else {
    paste0("") -> Matching.Protein.2[i]
  }
}

# NUCLEOTIDE CONSTRAINTS
for (i in 1:nrow(DATASET)){
  if((DATASET[i,]$O.C >= 0.5) && 
     (DATASET[i,]$O.C < 1.7) && 
     (DATASET[i,]$H.C > 1) && 
     (DATASET[i,]$H.C < 1.8) && 
     (DATASET[i,]$N.C >= 0.2) && 
     (DATASET[i,]$N.C <= 0.5) && 
     (DATASET[i,]$P.C >= 0.1) && 
     (DATASET[i,]$P.C <= 0.35) && 
     (DATASET[i,]$N.P > 0.6) && 
     (DATASET[i,]$N.P <= 5) && 
     (DATASET[i,]$N >= 2) && 
     (DATASET[i,]$P >= 1) && 
     (DATASET[i,]$S == 0) && 
     (DATASET[i,]$Mass > 305) && 
     (DATASET[i,]$Mass < 523)){
    paste0("Nucleotide") -> Matching.Nucleotides[i]
  } else {
    paste0("") -> Matching.Nucleotides[i]
  }
}

# Concatenate all lists into a single one
Matchings.pasted.01 <- as.list(paste(Matching.Nucleotides, Matching.Carbohydrates, Matching.Lipids, Matching.AminoSugars, Matching.Phytochemical, Matching.Protein.1, Matching.Protein.2))

# Trim each row of the list (delete "spaces")
Matchings.pasted.02 <- as.list(gsub(" ", "", Matchings.pasted.01, fixed =TRUE))

# Add "Not.Matched" to those cells that were not matched to any compound category
Matchings.pasted.02[Matchings.pasted.02==""] <- "Not.Matched"

# Mark the potential Double Matches
# Create a new List
Matchings.list <- list()

# Loop on the generated list (double matchings will be marked by "Double.Matched")
for (i in 1:length(Matchings.pasted.02)){
  if (Matchings.pasted.02[i] == "Lipid"){
    paste0("Lipid") -> Matchings.list[i]
  } else if (Matchings.pasted.02[i] == "Carbohydrate"){ 
    paste0("Carbohydrate") -> Matchings.list[i]
  } else if (Matchings.pasted.02[i] == "Amino.Sugar"){ 
    paste0("Amino.Sugar") -> Matchings.list[i]
  } else if (Matchings.pasted.02[i] == "Phytochemical.Oxyaromatic.Compound"){ 
    paste0("Phytochemical.Oxyaromatic.Compound") -> Matchings.list[i]
  } else if (Matchings.pasted.02[i] == "Protein"){ 
    paste0("Protein") -> Matchings.list[i]
  } else if (Matchings.pasted.02[i] == "Nucleotide"){ 
    paste0("Nucleotide") -> Matchings.list[i]
  } else if (Matchings.pasted.02[i] == "Not.Matched"){ 
    paste0("Not.Matched") -> Matchings.list[i]
  } else {
    paste0(paste("Double.Match_",Matchings.pasted.02[i])) -> Matchings.list[i]
  }
}

Matchings <- as.data.frame(do.call(rbind, Matchings.list))

Matchings[Matchings == "Double.Match_NucleotideProtein"] <- "Nucleotide" # Double matches with nucleotides will be Nucleotides
Matchings[Matchings == "Double.Match_NucleotideAmino.Sugar"] <- "Nucleotide" # Double matches with nucleotdies will be Nucleotides
DATASET.MATCHED <- DATASET
DATASET.MATCHED["Compound.Match"] <- Matchings # Add a new column called "Compound.Match" into the DATASET.

# SAVE DATASET INTO A CSV FILE
write.table(data.frame(DATASET.MATCHED), file= Destination.File.Dataset)



## 2nd STEP - CALCULATE THE PROPORTIONS OF EACH COMPOUND CATEGORY ##
Protein.Proportion <- length(which(Matchings == "Protein"))/nrow(Matchings)*100
Phytochemical.Oxyaromatic.Compound.Proportion <- length(which(Matchings == "Phytochemical.Oxyaromatic.Compound"))/nrow(Matchings)*100
Lipid.Proportion <- length(which(Matchings == "Lipid"))/nrow(Matchings)*100
Carbohydrate.Proportion <- length(which(Matchings == "Carbohydrate"))/nrow(Matchings)*100
Amino.Sugar.Proportion <- length(which(Matchings == "Amino.Sugar"))/nrow(Matchings)*100
Nucleotide.Proportion <- length(which(Matchings == "Nucleotide"))/nrow(Matchings)*100
Not.Matched.Proportion <- length(which(Matchings == "Not.Matched"))/nrow(Matchings)*100
Double.Matched.Proportion <- length(which(Matchings != "Protein" & Matchings != "Phytochemical.Oxyaromatic.Compound" & Matchings != "Lipid" & Matchings != "Carbohydrate" & Matchings != "Amino.Sugar" & Matchings != "Nucleotide" & Matchings != "Not.Matched"))/nrow(Matchings)*100# Including double matches

# Integrate all the proportions together into a single categorical vector
Compound.Proportions <- c(Carbohydrate.Proportion, Amino.Sugar.Proportion, Nucleotide.Proportion, Lipid.Proportion, Protein.Proportion, Phytochemical.Oxyaromatic.Compound.Proportion, Not.Matched.Proportion, Double.Matched.Proportion)

# Create a Data Frame with the proportions
Compound.Proportions.DF <- as.data.frame(Compound.Proportions)

# Create the Labels for each proportion (has to follow the same order as the integration of the proportions)
Labels <- c("Carbohydrates", "Amino.Sugars", "Nucleotides", "Lipids", "Proteins", "Phytochemical.Oxyaromatic.Compounds", "Not.Matched", "Double.Matched")

# Add a new column into the Data Frame with the name of the compounds
Compound.Proportions.DF["Compound"] <- Labels

# SAVE DATASET INTO A CSV FILE
write.table(data.frame(Compound.Proportions.DF), file= Destination.File.Proportions)



## 3rd STEP - PIE CHART OF THE COMPOUND PROPORTIONS ##
# Constrain the number of decimals to 2
Pie.Proportions <- list()
for (i in 1:length(Compound.Proportions.DF$Compound.Proportions)){
  format(round(Compound.Proportions.DF$Compound.Proportions[i], 2), nsmall=2) -> Pie.Proportions[i]
}

# Create the labels for the Pie Chart
Labels.Plot <- paste (Labels, Pie.Proportions) # Add The percentage value to each label.
Labels.Plot.2 <- paste(Labels.Plot,"%", sep="") # Add "%" to each label.

# Plot the Pie Chart
pie(Compound.Proportions, labels = Labels.Plot.2, col= rainbow(length(Labels.Plot.2)))
