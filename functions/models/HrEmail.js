const { DataTypes } = require('sequelize');
const sequelize = require('../database/database');

const HREmail = sequelize.define('HREmail', {
    email_address: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true,
    },
    company_name: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    website: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    added_by: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    visible: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: false,
    },
}, {
    timestamps: true,
});

// Export the model
module.exports = HREmail;
