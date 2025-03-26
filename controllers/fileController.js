const FileMetaData = require("../models/fileMetaData");
const AWS = require('aws-sdk');
const _ = require("lodash");
const {errorLogger, infoLogger} = require("../logger");
const statsd = require('../config/statsd');

const s3 = new AWS.S3({
    region: process.env.AWS_REGION
});

const fileController = async (req, res) => {
    infoLogger.info(`${req.method} method received for ID: ${req.params.id}`);
    if (req.method != "GET" && req.method != "DELETE"){
        infoLogger.warn(`${req.method} method is invalid for files`);
        res.status(405).end();
    }
    try{      
        const dbStartTime = Date.now();
        const fileMetaData = await FileMetaData.findByPk(req.params.id);
        statsd.timing('metadata.fetch.time', Date.now() - dbStartTime);

        if (!fileMetaData) {
            infoLogger.warn(`No file metadata exists for ID: ${req.params.id}`);
            res.status(404).end();
        }
        else if (req.method == "GET"){
            infoLogger.info(`Get metadata for file ID: ${req.params.id}`);
            res.status(200).json(fileMetaData.toJSON());
        } 
        else if (req.method == "DELETE") {
            const urlObject = new URL(fileMetaData.url);
            const s3Params = {
                Bucket: process.env.S3_BUCKET,
                Key: decodeURIComponent(urlObject.pathname.substring(1))
            };

            infoLogger.info(`Deleting file ID: ${req.params.id} with S3: ${s3Params.Key}`);
            const s3StartTime = Date.now();
            await s3.deleteObject(s3Params).promise();
            statsd.timing('s3.delete.time', Date.now() - s3StartTime);
            infoLogger.info(`File delete successful for S3: ${s3Params.Key}`);

            const dbStartTime = Date.now();
            await fileMetaData.destroy();
            statsd.timing('metadata.delete.time', Date.now() - dbStartTime);

            infoLogger.info(`File metadata delete successful for ID: ${req.params.id}`);
            res.status(204).end();
        }
    } catch (error) {
        errorLogger.error("Error during file request: ", error);
        res.status(503).end();
    }
};

module.exports = fileController;
