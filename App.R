# Load required libraries
library(ggplot2)
library(dplyr)
library(corrplot)

# 1. Load the data set
data <- read.csv("C:/Users/gandl/Downloads/archive (4)/student-por.csv")
head(data)
str(data)
summary(data)
View(data)
# 2. Data Preprocessing

# Calculate average score
data$score <- rowMeans(data[, c("G1", "G2", "G3")], na.rm = TRUE)

# Impute missing values in 'score' column (if any)
data$score <- ifelse(is.na(data$score), mean(data$score, na.rm = TRUE), data$score)

# Encode gender as factor with labels
data$sex <- factor(data$sex, levels = c("M", "F"), labels = c("Male", "Female"))

# Normalize study time
data$studytime <- scale(data$studytime)

# 3. Data Visualizations

## A. Bar Chart: Gender Distribution

# Bar chart: Gender Distribution
ggplot(data, aes(x = sex, fill = sex)) +
  geom_bar() +
  scale_fill_manual(values = c("skyblue", "lightpink")) +
  labs(title = "Gender Distribution", x = "Gender", y = "Count") +
  theme_minimal()


## B. Pie Chart: Gender Distribution

gender_counts <- table(data$sex)
gender_pct <- round(100 * gender_counts / sum(gender_counts), 1)
pie(gender_counts, 
    labels = paste(names(gender_counts), "-", gender_pct, "%"), 
    col = c("skyblue", "lightpink"), 
main = "Gender Distribution (Pie Chart)")

## C. Box Plot: Score by Gender

ggplot(data, aes(x = sex, y = score, fill = sex)) +
  geom_boxplot() +
  labs(title = "Score Distribution by Gender", x = "Gender", y = "Score") +
  scale_fill_manual(values = c("skyblue", "lightpink")) +
  theme_minimal()

## D. Scatter Plot: Study Time vs Score

ggplot(data, aes(x = studytime, y = score, color = sex)) +
  geom_point(alpha = 0.7, size = 2) +
  labs(title = "Study Time vs Score", x = "Study Time (Normalized)", y = "Score") +
  scale_color_manual(values = c("blue", "red")) +
  theme_minimal()




# (Optional) Histogram: Score distribution

ggplot(data, aes(x = score)) +
  geom_histogram(binwidth = 1, fill = "steelblue", color = "black") +
  labs(title = "Score Distribution", x = "Score", y = "Frequency") +
  theme_minimal()
