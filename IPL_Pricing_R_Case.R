
## Getting present working directory
getwd()

## Installing readxl package to import excel files into R
install.packages("readxl")

## Loading the package
library("readxl")

## Setting working directory to R_dataset path to import files from this folder
setwd("/Users/amiteshjk/Desktop/JGBS/R_dataset")

## Storing the input data sets in a variable
input_dataset_1 = read_excel("IPL Player Pricing.xls",sheet=1)
input_dataset_2 = read_excel("IPL Player Pricing.xls",sheet=2)

## Convert to data frame
input_raw_data_df=data.frame(input_dataset_2)
input_modified_data_df=data.frame(input_dataset_1)
input_raw_data_df
## checking the class of the data
class(input_raw_data_df)

## Normally distributed


install.packages("ggpubr")
library("dplyr")
library("ggpubr")
install.packages("dplyr")

shapiro.test(input2$SR..B)
ggdensity(input2$SR..B, 
          main = "Normal distribution of SR",
          xlab = "Strike rate")

shapiro.test(input2$SIXERS)
ggdensity(input2$SIXERS, 
          main = "Normal distribution of Sixers",
          xlab = "Sixers")

## Batsmen strike rate is approximately normally distributed while Sixers is not normally distributed

##----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 1st Question

## Creating a data frame with just 3 columns (sold price and strike rate) which are required for linear regression
input <- input_raw_data_df[,c("SR..B","SOLD.PRICE")]
input

class(input)

##Create a linear regression model with Sold price as response (dependent) variable and Strike rate as explanatory (independent) variable 
model=lm(SOLD.PRICE~SR..B, data = input)
print(model)

x=summary(model)
# Get the Intercept and coefficients as vector elements.
cat("# # # # The Coefficient Values # # # ","\n")

a <- coef(model)[1]
print(a)
X_Strike_rate <- coef(model)[2]
print(X_Strike_rate)


###Inference- Since p- value=0.036 which is <0.05, there is a statistically significant 
##relationship between the batting strike rate and sold price. For one unit increase in strike rate, the sold price of the
##player increases by $2086.394

##Linear regression equation with x1 as 10 (assumed)
##x1=10
##Y = a+X_Strike_rate*x1
##Y

##----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 2nd Question

## Creating a data frame with just 2 columns (sold price and strike rate) which are required for linear regression
input2 <- input_raw_data_df[,c("SR..B","SOLD.PRICE","SIXERS")]
input2

class(input2)

##Create a linear regression model with Sold price as response (dependent) variable and Strike rate as explanatory (independent) variable 
model2=lm(SOLD.PRICE~SR..B+SIXERS, data = input2)
print(model2)

summary(model2)

 
# Get the Intercept and coefficients as vector elements.
cat("# # # # The Coefficient Values # # # ","\n")

a <- coef(model2)[1]
print(a)
X_Strike_rate <- coef(model2)[2]
print(X_Strike_rate)
X_Sixers <- coef(model2)[2]
print(X_Sixers)

## Inference - In model 1, with just SR-B as explanatory variable, the coefficient of SR-B is 2086.394.
## After including SIXERS, coefficient changed from +2086 to -102. This is due to multi-collinearity. Whenever there 
## is a new variable added, the regression coefficient gets changed. The p-value for SR-B is very high (0.91) and
## hence not statistically significant 


##Multiple regression equation with x1 as 10 (assumed)
##x1=10
##x2=20
##Y = a+X_Strike_rate*x1 +X_Sixers*x2
##print(Y)

##----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 3rd Question






## Assume B is the coefficient for batting strike rate; Hypothesis
## H0: B<=1000
## H1: B>1000

estimate_Strike_rate <- coef(model)[2]
hypothesis_value=1000
std_error=x$coefficients[2, 2]

## T-value

t=((estimate_Strike_rate-hypothesis_value)/std_error)
t

## Finding degree of freedom (no.of samples -1)
df=nrow(input_raw_data_df)-1
df

# /*
# H1: μ > μ 0 , where μ0 is the comparator or null value (e.g., μ0 =191 in our example about weight in men in 2006) and an increase is hypothesized - this type of test is called an upper-tailed test;
# H1: μ < μ0 , where a decrease is hypothesized and this is called a lower-tailed test; or
# H1: μ ≠ μ 0, where a difference is hypothesized and this is called a two-tailed test.  
# */

## P value for Upper tail test
p_value=pt(t, df, lower.tail = FALSE)
p_value

## Since the p-value is greater than 0.05, we retain the null hypothesis 
## and conclude that the sold price is unlikely to increase by more than $1000 for every one-unit increase in the batting strike rate at alpha=0.05

##----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

##4th Question
install.packages("olsrr")
library(olsrr)

#fit full model
full_model <- lm(SOLD.PRICE ~ ., data = input_raw_data_df)
input <- lm(SOLD.PRICE ~ SR..B, data = input_raw_data_df)
input <- input_raw_data_df[,c("SR..B","SOLD.PRICE")]
ols_mallows_cp(input, full_model)
 


#fit three smaller models
input_raw_data_df
input <- input_raw_data_df[,c("SR..B","SOLD.PRICE")]
input <- input_raw_data_df[,c("SL.NO.","PLAYER.NAME","AGE","COUNTRY","TEAM",
                              "PLAYING.ROLE","T.RUNS","T.WKTS","ODI.RUNS.S",
                              "ODI.RUNS.B","ODI.WKTS","ODI.SR.BL","CAPTAINCY.EXP",
                              "RUNS.S","HS","AVE","RUNS.C","WKTS","AVE.BL","ECON",
                              "SR.BL","AUCTION.YEAR","BASE.PRICE","SR..B","SOLD.PRICE","SIXERS")]
model1 <- lm(SOLD.PRICE ~ SIXERS+SR..B ,data = input_raw_data_df)
summary(model1)
model2 <- lm(SOLD.PRICE ~ disp + qsec, data = input_raw_data_df)
model3 <- lm(SOLD.PRICE ~ disp + wt, data = input_raw_data_df)

#calculate Mallows' Cp for each model
ols_mallows_cp(model1, full_model)

