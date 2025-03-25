const FileMetaData = require("../models/fileMetaData");
const AWS = require('aws-sdk');
const _ = require("lodash");

const s3 = new AWS.S3({
    region: process.env.AWS_REGION
});

const fileController = async (req, res) => {
    if (req.method != "GET" && req.method != "DELETE"){
        res.status(405).end();
    }
    try{
        const fileMetaData = await FileMetaData.findByPk(req.params.id);
        if (!fileMetaData) {
            res.status(404).end();
        } else if (req.method == "GET"){
            res.status(200).json(fileMetaData.toJSON());
        } else if (req.method == "DELETE") {
            const urlObject = new URL(fileMetaData.url);
            const s3Params = {
                Bucket: process.env.S3_BUCKET,
                Key: decodeURIComponent(urlObject.pathname.substring(1))
            };
            await s3.deleteObject(s3Params).promise();
            await fileMetaData.destroy();
            res.status(204).end();
        }
    } catch (error) {
        res.status(503).end();
    }
};

module.exports = fileController;
