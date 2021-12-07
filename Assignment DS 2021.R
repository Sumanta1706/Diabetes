

#Unsupervised: Principal Component Analysis

install.packages("psych")
library(psych)
KMO(diabetes)
View(cor(diabetes))
x = princomp(x = diabetes[, 1:9], cor = T)
x
Factor = principal(r = diabetes[1:9], nfactors = 3, rotate = "varimax", scores = T)
Factor
Factor$scores
cor(Factor$scores)




#Classification analysis

#Step 1: Installing Packages

install.packages("mlbench")
library(mlbench)
View(diabetes)


#Step 2: k-nearest neighbor

install.packages("caTools")
library(caTools)
library(class)

all_test_accuracies_knn <- matrix(nrow = 100, ncol = 9)
for(split_number in c(1:100)){
  train_ind <- sample.split(diabetes$Pregnancies, SplitRatio = 0.8)
  test_ind <- !train_ind
  neighbours <- c(2:10)
  accuracies <- matrix(nrow = 1, ncol = 9)
  for (n_neighbours in neighbours){
    knn_fit <- knn(diabetes[train_ind, ], diabetes[test_ind, ], diabetes$Outcome[train_ind],
                   k = n_neighbours)
    cm1 <- table(Actual = diabetes$Outcome[test_ind], Predicted = knn_fit)
    print(cm1)
    accuracy1 <- sum(diag(cm1))/sum(test_ind)
    print(accuracy1)
    accuracies[n_neighbours-1] <- accuracy1
  }
  all_test_accuracies_knn[split_number, ] <- accuracies
}

#to find out the Precision, recall and F1 score for KNN regression
precision(cm1)
recall(cm1)
F1_Score <- 2*(0.8252*0.8095)/(0.8252+0.8095)
F1_Score

#Step 3: Logistic Regression

all_test_accuracies_logistic <- matrix(nrow = 100, ncol = 1)
for(split_number in c(1:100)){
  train_ind <- sample.split(diabetes$Pregnancies, SplitRatio = 0.8)
  test_ind <- !train_ind
  
  logit_fit <- glm(Outcome ~ ., data = diabetes[train_ind, ], family = "binomial")
  p <- predict(logit_fit, diabetes[test_ind, ], family = "binomial")
  probs <- exp(p)/(1+exp(p))
  test_outcomes <- probs>0.5
  cm2 <- table(Atual = diabetes$Outcome[test_ind], predicted = test_outcomes)
  print(cm2)
  accuracy2 <- sum(diag(cm2))/sum(test_ind)
  print(accuracy2)
  all_test_accuracies_logistic[split_number] <- accuracy2
}

table(cm2)
cm2
typeof(cm2)
class(cm2)
F1_Score_log = 2*(0.5*0.8437)/(0.5+0.8437)
F1_Score_log

# gradient boosting

install.packages("gbm")
library(gbm)

all_gb_accuracies <- matrix(nrow = 100)
all_gb_relative_inf <- matrix(nrow = 100, ncol = 8)
for (split_number in c(1:100)){
  train_ind <- sample.split(diabetes$Pregnancies, SplitRatio = 0.8)
  test_ind <- !train_ind
  
  gb <- gbm(Outcome ~ ., data = diabetes[train_ind, ], distribution = "bernoulli")
  vals <- predict.gbm(gb, diabetes[test_ind, ], n.trees = 100)
  probs <- exp(vals)/(1+exp(vals))
  class1 <- probs>0.5
  cm3 <- table(class1, diabetes$Outcome[test_ind])
  print(cm3)
  gb_accuracy <- sum(diag(cm3))/sum(test_ind)
  print(gb_accuracy)
  all_gb_accuracies[split_number] <- gb_accuracy
  
  s <- summary.gbm(gb, plotit = F)
  all_gb_relative_inf[split_number, 1] <- s$rel.inf[s$var == "Glucose"]
  all_gb_relative_inf[split_number, 2] <- s$rel.inf[s$var == "BMI"]
  all_gb_relative_inf[split_number, 3] <- s$rel.inf[s$var == "Age"]
  all_gb_relative_inf[split_number, 4] <- s$rel.inf[s$var == "Insulin"]
  all_gb_relative_inf[split_number, 5] <- s$rel.inf[s$var == "DiabetesPedigreeFunction"]
  all_gb_relative_inf[split_number, 6] <- s$rel.inf[s$var == "Pregnancies"]
  all_gb_relative_inf[split_number, 7] <- s$rel.inf[s$var == "BloodPressure"]
  all_gb_relative_inf[split_number, 8] <- s$rel.inf[s$var == "SkinThickness"]
}


table(cm3)
True_positive_gb <- 31
True_negative_gb <- 85
False_positive_gb <- 18
False_negative_gb <- 20
cm3
gb_accuracy
F1_Score_gb = 2*(0.607*.632)/(0.607+0.632)
F1_Score_gb
class(cm3)
typeof(cm3)


