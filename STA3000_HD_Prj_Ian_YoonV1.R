#.dat file space separated instead of csv

read.csv("data/heart.csv")
data = read.csv("heart.csv", header = TRUE) #converted outside

summary(data)


data$heart_disease[data$heart_disease == 1] = 0
data$heart_disease[data$heart_disease == 2] = 1




#change categories to factors
data$sex = factor(data$sex,levels = c(0,1),labels = c("female", "male"))

data$fasting_blood_sugar = factor(data$fasting_blood_sugar,levels = c(0,1), labels = c("<= 120 mg/dl", "> 120 mg/dl"))

data$angina = factor(data$angina,levels = c(0,1),labels = c("no", "yes"))

data$heart_disease = factor(data$heart_disease, levels = c(0,1), labels = c("not present", "present"))

data$chest_pain = factor(data$chest_pain, levels = c(1,2,3,4), labels = c("typical angina", "atypical angina", "non-anginal pain", "asymptomatic"))

data$electrocardiographic = factor(data$electrocardiographic, levels = c(0,1,2), labels = c("norm", "ST-T wave abnormality", "Left Ventricular Hypertrophy"))

data$slope = factor(data$slope, levels = c(1,2,3), labels = c("upsloping", "flat", "downsloping"))

data$thal = factor(data$thal, levels = c(3,6,7), labels = c("norm", "fixed defect", "reversible defect"))

data$major_vessels = factor(data$major_vessels, levels = c(0,1,2,3),labels = c("0","1","2","3"))


#https://archive.ics.uci.edu/dataset/45/heart+disease labels



str(data)

summary(data)

par(mfrow = c(2, 3))  # 2 rows, 3 columns

n = nrow(data)
n

hist(data$age, main = "Age Distribution", xlab = "Age", col = "grey")
hist(data$rest_bp, main = "Resting Blood Pressure", xlab = "rest_bp", col = "grey")
hist(data$serum_chol, main = "Serum Cholesterol", xlab = "serum_chol", col = "grey")
hist(data$max_heart_rate, main = "Maximum Heart Rate", xlab = "max_heart_rate", col = "grey")
hist(data$oldpeak, main = "Oldpeak (ST Depression)", xlab = "oldpeak", col = "grey")

par(mfrow = c(2, 3))

boxplot(age ~ heart_disease, data = data,main = "Age vs Heart Disease", col = "grey")

boxplot(rest_bp ~ heart_disease, data = data, main = "Resting BP vs Heart Disease", col = "grey")

boxplot(serum_chol ~ heart_disease, data = data, main = "Cholesterol vs Heart Disease", col = "grey")

boxplot(max_heart_rate ~ heart_disease, data = data, main = "Max Heart Rate vs Heart Disease", col = "grey")

boxplot(oldpeak ~ heart_disease, data = data, main = "Oldpeak vs Heart Disease", col = "grey")

#H0: Sex and heart disease status are independent. Ha: Sex and heart disease status are not independent.
chisq.test(data$sex, data$heart_disease)
#X-squared = 22.667, df = 1, p-value = 1.926e-06

#H0: Fasting blood sugar and heart disease status are independent. Ha: Fasting blood sugar and heart disease status are not independent.
chisq.test(data$fasting_blood_sugar, data$heart_disease)
#X-squared = 0.0091712, df = 1, p-value = 0.9237

#H0: Angina and heart disease status are independent. Ha: Angina and heart disease status are not independent.
chisq.test(data$angina, data$heart_disease)
#X-squared = 45.692, df = 1, p-value = 1.384e-11

#H0: Chest pain and heart disease status are independent. Ha: Chest pain and heart disease status are not independent.
chisq.test(data$chest_pain, data$heart_disease)
#X-squared = 68.588, df = 3, p-value = 8.561e-15

#H0: ECG result and heart disease status are independent. Ha:ECG result and heart disease status are not independent.
chisq.test(data$electrocardiographic, data$heart_disease)
#X-squared = 8.9795, df = 2, p-value = 0.01122

#H0: ST Slope heart disease status are independent. Ha: ST Slope and heart disease status are not independent.
chisq.test(data$slope, data$heart_disease)
#X-squared = 40.37, df = 2, p-value = 1.713e-09

#H0: Thal and heart disease status are independent. Ha: Thal and heart disease status are not independent.
chisq.test(data$thal, data$heart_disease)
#X-squared = 74.569, df = 2, p-value < 2.2e-16

#H0: Major vessels and heart disease status are independent. Ha: Major vessels and heart disease status are not independent.
chisq.test(data$major_vessels, data$heart_disease)
#X-squared = 62.863, df = 3, p-value = 1.437e-13


#logit model 

logit_hd = glm(heart_disease ~ age + sex + angina + chest_pain + max_heart_rate + oldpeak + slope + thal + major_vessels, data = data, family = binomial)

summary(logit_hd)


exp(coef(logit_hd)["sexmale"])
exp(coef(logit_hd)["chest_painasymptomatic"])
exp(coef(logit_hd)["oldpeak"])
exp(coef(logit_hd)["slopeflat"])
exp(coef(logit_hd)["thalreversible defect"])
exp(coef(logit_hd)["major_vessels1"])
exp(coef(logit_hd)["major_vessels2"])
exp(coef(logit_hd)["major_vessels3"])


