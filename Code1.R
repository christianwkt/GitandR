install.packages("tidyverse")
install.packages("purrr")
# Load packages
library(dplyr)
library(purrr)
library(glue)
library(readxl)

# Parameters

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

comments <- read_excel("RefTables_Auto_24-01-2023.xlsx",sheet = "Comment")

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



# hhhhhPut all together --------------------------------------------------------


donnée <- full_join(df_offer,df_comments , by = c("Cluster", "Criteria", "Comment"))
View(donnée)
