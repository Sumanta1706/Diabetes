# Diabetes
## Aims & Objective
Diabetes mellitus is a chronic disease that occurs when one’s pancreas no longer able to produce enough insulin.  The  long-term  hyperglycemia  during  diabetes  causes  chronic  damage  and dysfunction  of  various  tissues,  especially  the  eyes,  kidneys,  heart,  blood  vessels,  and  nerves. Nowadays, diabetes is a major public health challenge and a worldwide problem. This study will introduce how to use medical data to analyze the relation between medical indexes and diabetes with machine learning tools. It may be helpful to doctors as a screening tool.
## Method 1: K-Nearest-Neighbours (KNN)
### Model building: 
We’ll begin by applying the k-nearest neighbors method of classifying patients by their similarity to other patients. For this method (and all subsequent methods), we’ll start by separating the data set into “training” and “test” sets. We’ll build our model based on the relationship between the predictors and the outcome on the training set, and then use the model’s specifications to predict the outcome on the test set. We can then compare our predicted outcomes to the test set’s actual diabetes status to give us a measure of model accuracy. For my exercises, I’ll use the sample.split function from the caTools package.
### Validation:
For k-nearest neighbors, we compute the outcome for each test case by comparing that case to the “nearest neighbors” in the training set. The assigned outcome depends on how many of these neighbors you decide to look at; the majority class of the three closest neighbors may be different than the majority class of the five closest neighbors.
To ensure we use a number for k that gives better model performance, I performed a two-part cross-validation. First, I varied the possible values for k from 2 to 10; second, I repeated the splitting of the data into training and test sets 100 times to ensure a robust estimate of model performance for each k. I used the knn function within the class package and computed model accuracy on the test set for each fold.
### Evaluation: 
From this analysis, we can see that k-nearest neighbors performs better for somewhat larger values of k, with performance reaching a maximum of about 75% classification accuracy. Though there is still some variance depending on the exact data split, using 9 or 10 neighbors seems to yield fairly stable model estimates on the test set.
At first, we have to install some of the packages like ‘mlbench’, ‘caTools’ etc. Then after, split the data set into 80% and 20%, and then we checked the accuracy for all of the corresponding neighbors. We can see that for k = 10, we have the best accuracy. 
## Method 2: Logistic Regression
### Model building:
Next, we’ll apply another of the basic workhorses of the machine learning toolset: regression. For this data set, where we’re predicting a binary outcome (diabetes diagnosis), we’re using logistic regression rather than linear regression (to predict a continuous variable). Again, I’ll cross-validate the logistic regression model by repeatedly splitting the data into different training and test sets.
### Validation:
Since the dependent variable ‘Outcome’ in  this  dataset  only  has  the  number  0  and  1,  logistic regression will be most straightforward method people can think of. Logistic regression is used to predict the  probability  of conditions  of  happening event  for  the  yes/no,  or  A/B  situation.  It can estimate probability of occurrence of a categorical response based on one or more predictors.
### Evaluation:
Across all folds, we achieve a mean model accuracy of 79%, with performance ranging from 67–84% depending on the exact training-test split. Logistic regression appears to be somewhat more accurate on this data set than k-nearest neighbors, even with the optimal choices of k.
## Method 3: Gradient Boosting
### Model Building:
Generally, gradient boosting refers to iteratively fitting a model to the residual of the previous model, thereby improving the overall model fit. Gradient boosting “boosts” the decision tree model of classification by consecutively fitting gradually more complex trees to the data, and by using the residuals of the previous tree as a guide to the subsequent tree.
### Validation: 
The gradient here refers to solving the problem of minimization through gradient descent, that is, finding the gradient at your current value and following the gradient in a decreasing direction.
### Evaluation:
For this one we have again split the dataset into 2 parts, training and testing. Then after, we did the GBM testing using the ‘Bernoulli distribution’. 
## Model Comparison:
Between the three models, logistic regression appears to be a slightly better and more accurate than k-nearest model and gradient boost model. In case of logistic regression the accuracy is somewhere around 79% meanwhile for knn regression and gradient boost it stands at 75% each
