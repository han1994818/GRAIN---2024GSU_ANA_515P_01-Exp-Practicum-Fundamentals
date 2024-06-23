# Install the required packages if not already installed 安装所需的包，如果尚未安装
if (!requireNamespace("readxl", quietly = TRUE)) install.packages("readxl")
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")

# Loading Packages 加载包
library(readxl)
library(dplyr)
library(ggplot2)

# Set the actual file path 设置实际的文件路径
file_path <- "/Users/lichenghan/Desktop/Mcdaniel college/515/GRAIN---2024GSU_ANA_515P_01 Exp Practicum Fundamentals.xltx"

# Read a specific worksheet of an Excel file and convert the Year column to character type读取 Excel 文件的特定工作表，并转换 Year 列为字符型
data1 <- read_excel(file_path, sheet = "Sheet1") %>%
  mutate(Year = as.character(Year))

data2 <- read_excel(file_path, sheet = "Sheet2") %>%
  mutate(Year = as.character(Year))

# Merge data 合并数据
combined_data <- bind_rows(data1, data2)

#Replace all missing values ​​with "Default Value" 替换所有缺失值为 "Default Value"
combined_data <- combined_data %>%
  mutate(across(everything(), ~ ifelse(is.na(.), "Default Value", .)))

#Assume that you need to correct the "Error" in the column named "Production" to "Correction" 假设需要纠正名为 "Production" 的列中的 "Error" 为 "Correction"
combined_data <- combined_data %>%
  mutate(Production = replace(Production, Production == "Error", "Correction"))

#Check the data of the 'Production' column 检查 'Production' 列的数据
print(table(combined_data$Production))

#Plot a bar chart of the 'Production' column 绘制 'Production' 列的条形图
ggplot(combined_data, aes(x = Production)) + 
  geom_bar() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # 旋转 X 轴标签以便阅读


