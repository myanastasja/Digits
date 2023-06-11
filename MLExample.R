#https://rstudio-pubs-static.s3.amazonaws.com/288923_11f4a96b94a74590af0ca460b6ce7648.html#/

#installing 'devtools' package for installing Packages from github
install.packages('devtools')

devtools::install_github("rstudio/keras") 
#installing keras 
#It will first install tensorflow then keras.
#The above code will install the keras library from the GitHub repository.

#Installing Keras for R
install.packages("rstudio/keras")

#loading keras in R 
library(keras)
#The R interface to Keras uses TensorFlow as it’s underlying computation engine.

##########
  
#So we need to install Tensorflow engine
reticulate::install_miniconda()
install_tensorflow()
#For installing a gpu version of Tensorflow
#install_tensorflow(gpu = T)

##########

#Getting started with Keras for R
#The core data structure of Keras is a model, a way to organize layers. 
#The simplest type of model is the Sequential model, a linear stack of layers. 
#For more complex architectures, you should use the Keras functional API, 
#which allows to build arbitrary graphs of layers.

#loading the keras inbuilt mnist dataset
data<-dataset_mnist()

##########
  
  #Training Data
  train_x<-data$train$x
train_y<-data$train$y

#Test Data
test_x<-data$test$x
test_y<-data$test$y

#converting a 2D array into a 1D array for feeding 
#into the MLP and normalising the matrix

##########

#Training Data
train_x<-data$train$x
train_y<-data$train$y

#Test Data
test_x<-data$test$x
test_y<-data$test$y

#converting a 2D array into a 1D array for feeding 
#into the MLP and normalising the matrix
train_x <- array(as.numeric(train_x), dim = c(dim(train_x)[[1]], 784))
test_x <- array(as.numeric(test_x), dim = c(dim(test_x)[[1]], 784))
train_x <- train_x / 255
test_x <- test_x / 255