install.packages("tidyverse")
install.packages("purrr")

# Load packages

library(dplyr)
library(purrr)
library(glue)
library(readxl)

############################################### AUTO ########################################

# input folder where data files are saved

##############################################################################################################################################

path <- "C:/Users/ChristianTANKOU/Desktop/Dossier Wis/AUTO/CompanyAuto"

# empty dataframe where all data will be saved

df <- data.frame() 

# vector containing all files saved in `path`

files <- list.files(path)

for (file in files) { 
  # loop on each file
  
df_tmp <- read.txt(paste(path, file, sep="/")) # read the file as a dataframe

df_tmp["company"] <- sub(\\..*, "", file) # add a column with the company name (and remove the extension)
  df <- rbind(df, df_tmp) # concatenate the data to the global dataframe 
  
################################################################################################################################################


  #### Parameters

companies <- c("Allianz", "Axa","Ethias","Belfius")


# Load data

comments <- read_excel("Tables_Auto_24.xlsx",sheet = "Comment")

names(comments)[names(comments)=='Label']<-"Comment"
names(comments)[names(comments) == 'Label_nlbe' ] <- "Comment_nlbe"
names(comments)[names(comments) == 'Id' ] <- "CommentId"

Comments_1 <- read_excel("Comments_1.xlsx")

df_comments <- full_join(comments,comment1, by = "CommentId")

#--------------------------------------------------------------------------------


df_offer <- map(companies, function(x){
  
  read.delim(glue("{x}.txt"))
  
})
names(df_offer)<-companies

View(df_offer)

# Section 1 ---------------------------------------------------------------


# Clé unique ClusterGroup > Cluster > Criteria > Comment

# Section 2 ---------------------------------------------------------------

df_offer <- map_df(df_offer, function(df){df},.id = "company")

names(df_offer)



# Put all together --------------------------------------------------------


donnée <- full_join(df_offer,df_comments , by = c("Cluster", "Criteria", "Comment"))

View(donnée)

autodata <- donnée %>% select(company, Offer, Family,Cluster,Cluster_nlbe,Criteria,Criteria_nlbe,Comment,Comment_nlbe,Rating)
View(autodata)
















########################################################## HABITATION ########################################################
##############################################################################################################################

companies <- c("Allianz", "Axa","Ethias","Belfius")

# Load data

df <- data.frame(ClusterGrp = c("Family"), 
                 Cluster = c("cluster1"), 
                 Criteria = c("criteria1"), 
                 Comment = c("Comment_1"))



View(df)

df_offer <- map(companies, function(x){
  
  read.delim(glue("{x}.txt"))
  
})
names(df_offer)<-companies

View(df_offer)

# Section 1 ---------------------------------------------------------------

# Préparer les données du product tree

# criteria1 <- read_excel("RefTables_Auto_24-01-2023.xlsx",sheet = "Criteria")
# names(criteria1)[names(criteria1)=='Label']<-"Criteria"
# names(criteria1)[names(criteria1)=='Label_nlbe']<-"Criteria_nlbe"
# View(criteria1)

comments <- read_excel("Tables_Auto_24-01.xlsx",sheet = "Comment")

names(comments)[names(comments)=='Label']<-"Comment"

names(comments)[names(comments) == 'Label_nlbe' ] <- "Comment_nlbe"

names(comments)[names(comments) == 'Id' ] <- "CommentId"

View(comments)

comment1 <- read_excel("Comments_1.xlsx")

View(comment1)

df_comments <- full_join(comments,comment1, by = "CommentId")


View(df_comments)

# Clé unique ClusterGroup > Cluster > Criteria > Comment

# Section 2 ---------------------------------------------------------------

df_offer <- map_df(df_offer, function(df){df},.id = "company")

names(df_offer)



# Put all together --------------------------------------------------------


donnée <- full_join(df_offer,df_comments , by = c("Cluster", "Criteria", "Comment"))

View(donnée)

autodata <- donnée %>% select(company, Offer, Family,Cluster,Cluster_nlbe,Criteria,Criteria_nlbe,Comment,Comment_nlbe,Rating)
View(autodata)
