import pandas as pd
import os
## Getting present working directory
cwd=os.getcwd()
## Set  working directory
os.chdir("/Users/amiteshjk/Desktop/JGBS/R_dataset/")
cwd

## Check if Strike Rate is normally distributed

import pandas as pd
import matplotlib.pyplot as plt
Strike_rate=df["SR -B"]
Sixers=df["SIXERS"]
Strike_rate.plot.density(color='green')
plt.title('Density plot for Strike Rate')
plt.show()

## Check if Sixers is normally distributed

import pandas as pd
import matplotlib.pyplot as plt
Sixers=df["SIXERS"]
Sixers.plot.density(color='green')
plt.title('Density plot for Sixers')
plt.show()




## Question 1
import pandas as pd
import os
df = pd.read_excel('IPL_Pricing.xlsx','Sheet1')
df.columns
y=df["SOLD PRICE"]
x=df["SR -B"]
print(y)
print(x)



## Question 1
from sklearn import datasets, linear_model
from sklearn.linear_model import LinearRegression
import statsmodels.api as sm

##Create a linear regression model with Sold price as response (dependent)
##variable and Strike rate as explanatory (independent) variable 
x1 = sm.add_constant(x) ## Adding intercept manually since python does not have it as default 
est = sm.OLS(y, x1).fit() ## Ordinary least square regression 
print(est.summary()) ## Regression summary with required coefficients and intercept


## Question 2
x2=df[["SR -B","SIXERS"]]
x2


import statsmodels.api as sm

x2 = sm.add_constant(x2)
est2 = sm.OLS(y, x2).fit()
print(est2.summary())


## Question 3

estimate_Strike_rate=2086.394 ## From model 1/Question 1 output
hypothesis_value=1000 
std_error=983.643 ## From model 1/Question 1 output
t=((estimate_Strike_rate-hypothesis_value)/std_error) ## Find t-score
print(t)



## Find p value from t-score
import scipy.stats
p_value=scipy.stats.t.sf(t, df=129) ## degree of freedom = n-1 (130-1)
p_value
