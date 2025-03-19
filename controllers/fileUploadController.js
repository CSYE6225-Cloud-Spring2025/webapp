const FileMetaData = require("../models/fileMetaData");
const AWS = require('aws-sdk');
const _ = require("lodash");

const s3 = new AWS.S3({
    region: process.env.AWS_REGION
});

const fileUploadController = async (req, res) => {
    try{
        if (!req.file) {
            res.status(400).end();
        }
        const fileKey = `FileUploads/${req.file.originalname}_${Date.now()}`;
        const s3Params = {
            Bucket: process.env.S3_BUCKET,
            Key: fileKey,
            Body: req.file.buffer,
            ContentType: req.file.mimetype
        };
        const s3Upload = await s3.upload(s3Params).promise();
        const fileMetaData = await FileMetaData.create({file_name: req.file.originalname, url: s3Upload.Location});
        res.status(201).json(fileMetaData.toJSON());
    } catch (error) {
        res.status(400).end();
    }
};

module.exports = fileUploadController;
