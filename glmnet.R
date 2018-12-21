library(glmnet)
 data = read.table('C:\\Users\\RAVISINGH\\Desktop\\data\\pyrmidine.txt') ;
 data = read.table('C:\\Users\\RAVISINGH\\Desktop\\data\\drosofilaWing-mat.txt');
 data = read.table('C:\\Users\\RAVISINGH\\Desktop\\data\\breatCancer\\wdbc-data-mat.txt') ;
 data = read.table('C:\\Users\\RAVISINGH\\Desktop\\data\\spambase\\spambase.data') ; logit = 1 ;

data = as.matrix(data) ;
ro = length(data[,1]) ;
co = length(data[1,]) ;
me = mean(data) ;
frac = floor(0.30* ro) ;

X = data[,1:(co -1)]; 
Y = data[,co] ;
 
rows1 = 1:ro ;    
randpos = sample( rows1, frac , replace=F) ;
randneg = rows1[-randpos] ;

Ytrain = Y[randpos] ; Xtrain = X[randpos,] ;
Ytest = Y[randneg] ; Xtest = X[randneg, ] ; 
 
set.seed(123) 

################Lasso %%%%%%%%%%%%%%%
fit <- cv.glmnet(Xtrain , Ytrain, alpha = 1)
plot(fit)

# Fit the final model on the training data
model <- glmnet(Xtrain, Ytrain, alpha = 1, lambda = fit$lambda.min)

# Display regression coefficients
#coef(model)

Ypred <- predict(newx = Xtest, model)

error = sum((Ytest - Ypred)^2) ;



#%%%%%%%%%%%%%%%%%%% Ridge %%%%%%%%%%%%%%%%%
fit <- cv.glmnet(Xtrain , Ytrain, alpha = 0)

# Fit the final model on the training data
model <- glmnet(Xtrain, Ytrain, alpha = 0, lambda = fit$lambda.min)

# Display regression coefficients
coef(model)

Ypred <- predict(newx = Xtest, model)
error = sum((Ytest - Ypred)^2) ;

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


For data logistic regression
fit <- cv.glmnet(Xtrain , Ytrain, alpha = 1, )
plot(cv.lasso)

# Fit the final model on the training data
model <- glmnet(Xtrain, Ytrain, alpha = 1, lambda = fit$lambda.min)

# Display regression coefficients
#coef(model)

Ypred <- predict(newx = Xtest, model)

error = sum((Ytest - Ypred)^2) ;
































