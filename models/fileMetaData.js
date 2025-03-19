const {DataTypes, Sequelize} = require("sequelize");
const sequelize = require("../config/database");

const FileMetaData = sequelize.define('filemetadata', {
    id: {
        type: DataTypes.UUID,
        primaryKey: true,
        defaultValue: Sequelize.UUIDV4,
        allowNull: false
    },
    file_name: {
        type: DataTypes.STRING,
        allowNull: false
    },
    url: {
        type: DataTypes.STRING,
        allowNull: false
    },
    upload_date: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW,
    },
    }, {timestamps: false}
);

module.exports = FileMetaData;
