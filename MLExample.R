#https://rstudio-pubs-static.s3.amazonaws.com/288923_11f4a96b94a74590af0ca460b6ce7648.html#/

#installing 'devtools' package for installing Packages from github
install.packages('devtools')

#
install.packages('keras')
library(keras)
library(reticulate)

#The R interface to Keras uses TensorFlow as it’s underlying computation engine.

##########
  
#So we need to install Tensorflow engine
#reticulate::install_miniconda()
install_tensorflow()
#For installing a gpu version of Tensorflow
#install_tensorflow(gpu = T)

install.packages('tensorflow')
library(tensorflow)

##########

#Getting started with Keras for R
#The core data structure of Keras is a model, a way to organize layers. 
#The simplest type of model is the Sequential model, a linear stack of layers. 
#For more complex architectures, you should use the Keras functional API, 
#which allows to build arbitrary graphs of layers.

#loading the keras inbuilt mnist dataset
data<-dataset_mnist()

########## Training and Test Data

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

########## Convert class vectors to binary class matrices

train_y<-to_categorical(train_y,10)
test_y<-to_categorical(test_y,10)

########## Defining and Configuring The Model


#Now defining a keras MLP sequential model containing a linear stack of layers
model <- keras_model_sequential()

#defining the model with 1 input layer[256 neurons], 1 hidden layer[128 neurons] 
#with dropout rate 0.4 and 1 output layer[10 neurons]
#i.e number of digits from 0 to 9

model %>% 
  #Input layer-256 units
  #Add a densely-connected NN layer to an output
  layer_dense(units=256,activation="relu",
              input_shape=c(784))  %>%
  #dropout layer to prevent Overfitting
  layer_dropout(rate=0.4) %>%
  
  #Hidden Layer-128 units
  #Apply an activation function to an output.
  #Relu can only be used for Hidden layers
  layer_dense(units = 128,activation = "relu") %>%
  layer_dropout(rate=0.4) %>%
  
  #output layer
  layer_dense(units=10,activation="softmax") 
#softmax activation for Output layer which computes the probabilities for the classes

########## Compiling The Model

#Model's summary-showing its architecture
summary(model)


#Compiling the Model and Optimizing the model
#Configure a Keras model for training using compile()
model %>%
  compile(loss ="categorical_crossentropy",
          optimizer = "adam",
          metrics= c("accuracy"))

########## Training The Model

#Now let's train the model on the training dataset  
#epochs = No of iterations on a dataset.
#batchsize = Number of samples per gradient update.
history <- model %>% fit(train_x, train_y, epochs = 10, batch_size = 128,
                       callbacks = callback_tensorboard(log_dir = "logs/run_b"),
                       validation_split = 0.2) #train on 80% of train set and will evaluate 
#model's metrics such as loss and accuracy on leftover data
#after training --model gives

#loss: 0.1085 - acc: 0.9700 - val_loss: 0.0924 - val_acc: 0.9756
summary(history)
history$params
history$metrics # gives loss and acuracy metric for each epoch(iteration over training data)

#plotting Model - epoch vs acc and Loss
plot(history,labels=T)
which.min(history$metrics$acc)
#Accuracy least for 1st epoch and highest for last epoch-10
plot(x = history$metrics$acc,y = history$metrics$loss,
     pch=19,col='red',type='b',
     ylab="Error on trining Data",xlab="Accuracy on Training Data")
title("Plot of accuracy vs Loss")
legend("topright",c("Epochs"),col="red",pch=19)


########## Now Finally evaluating the Model's Perfomance
#Evaluating model on the Test dataset
score <- model %>% 
  evaluate(test_x,test_y,batch_size=128)

score
#loss = 0.0849(error) on Test set = 8.49 % error
#accuracy of 97.74 % on Test set

#This was a short tutorial on implementing Deep learning in R. R is back in the competition Now as The Competition should never end.
#You can find the actual code at “https://github.com/anishsingh20/Deep-Learning-in-R-using-Keras-and-Tensorflow-”

