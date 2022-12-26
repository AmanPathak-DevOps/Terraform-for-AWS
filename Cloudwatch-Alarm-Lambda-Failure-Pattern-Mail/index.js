var zlib = require('zlib');

var AWS = require('aws-sdk');

// Set region

AWS.config.update({ region: 'us-east-1' });

 

/*

* This handler is used to received log data from cloud watch log stream.

*/

exports.handler = (input, context) => {

  var payload = new Buffer(input.awslogs.data, 'base64');

  zlib.gunzip(payload, function (e, result) {

    if (e) {

 

      console.log("Error occured while executing error br_icsdev_delmgr_lambda_error_publisher:", e);

    } else {

      result = JSON.parse(result.toString());

      let mailBody = "\n\rHi,\n\rApplication Log, please take action on the following error:\n\r";

      mailBody += "Date: " + result.logEvents["0"].message;

 

      // Create publish parameters

      var params = {

        Message: mailBody, /* required */

        TopicArn: 'arn:aws:sns:us-east-1:728738226157:sns-topic-for-S3' /* required */

      };

 

      // Create promise and SNS service object

      var publishTextPromise = new AWS.SNS().publish(params).promise();

 

      // Handle promise's fulfilled/rejected states

      publishTextPromise.then(

        function (data) {

          console.log(`Message ${params.Message} sent to the topic ${params.TopicArn}`);

          console.log("MessageID is " + data.MessageId);

        }).catch(

          function (err) {

            console.error(err, err.stack);

          });

 

    }

  });

}