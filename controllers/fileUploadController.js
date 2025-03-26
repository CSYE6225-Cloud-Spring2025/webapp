const FileMetaData = require("../models/fileMetaData");
const AWS = require('aws-sdk');
const _ = require("lodash");
const {errorLogger, infoLogger} = require("../logger");
const statsd = require('../config/statsd');

const s3 = new AWS.S3({
    region: process.env.AWS_REGION
});

const fileUploadController = async (req, res) => {
    infoLogger.info("Received file upload request");
    try{
        if (!req.file) {
            infoLogger.warn("No file detected in the upload request");
            res.status(400).end();
        }
        const fileKey = `FileUploads/${req.file.originalname}_${Date.now()}`;
        infoLogger.info(`File key to upload: ${fileKey}`);

        const s3Params = {
            Bucket: process.env.S3_BUCKET,
            Key: fileKey,
            Body: req.file.buffer,
            ContentType: req.file.mimetype
        };
        const s3StartTime = Date.now();
        const s3Upload = await s3.upload(s3Params).promise();
        statsd.timing('s3.upload.time', Date.now() - s3StartTime);
        infoLogger.info(`File upload successful: ${s3Upload.Location}`);

        const dbStartTime = Date.now();
        const fileMetaData = await FileMetaData.create({file_name: req.file.originalname, url: s3Upload.Location});
        statsd.timing('metadata.insert.time', Date.now() - dbStartTime);

        infoLogger.info(`File metadata save successful: ${JSON.stringify(fileMetaData.toJSON())}`);
        res.status(201).json(fileMetaData.toJSON());
    } catch (error) {
        errorLogger.error("Error during file upload: ", error);
        res.status(503).end();
    }
};

module.exports = fileUploadController;
