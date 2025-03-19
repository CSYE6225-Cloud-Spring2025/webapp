const { DataTypes, Sequelize } = require("sequelize");
const sequelize = require("../config/database");

const HealthCheck = sequelize.define("healthchecks", {
    checkId: {
      type: Sequelize.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
    dateTime: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW,
    },
  }, {timestamps: false}
);

module.exports = HealthCheck;
