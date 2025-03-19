require("dotenv").config();
const {Sequelize} = require("sequelize");

const reqEnvVars = ["DB_HOST", "DB_USER", "DB_PASSWORD", "DB_NAME", "AWS_REGION", "S3_BUCKET"];
const missingEnvVars = reqEnvVars.filter((envVar) => !process.env[envVar]);
if (missingEnvVars.length > 0) {
  console.error(`Provide environment variables: ${missingEnvVars.join(", ")}`);
  process.exit(1);
}

const sequelize = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASSWORD, {
  host: process.env.DB_HOST,
  port: 3306,
  dialect: "mysql"
});

sequelize.authenticate().then(() => {
    console.log("Database connection is successful");
  }).catch((error) => {
    console.error("Database connection failed: ", error.message);
    process.exit(1);
  });

module.exports = sequelize;