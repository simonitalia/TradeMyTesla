from sklearn.linear_model import LinearRegression
import pandas
import coremltools

data = pandas.read_csv("cars.csv")

print(data)

# Define the model
model = LinearRegression()

# Assess how first datat array influences data price
model.fit(data[["model", "premium", "mileage", "condition"]], data["price"])

# Convert to Swift Core ML model
coreml_model = coremltools.converters.sklearn.convert(model, ["model", "premium", "milegae", "condition"], "price")

# Add Optional meta data descibi the model
coreml_model.author = "Hacking with Swift"
coreml_model.license = "CC0"
coreml_model.short_description = "Predicts Tesla car trade-in price"

# Save coreML model to path.
# Note! File name will become the Class name in Swift Xcode project, and .mlmodel is the file type for Xcode coreML models

coreml_model.save("Cars.mlmodel")
