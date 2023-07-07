# Intelligent Image Recognition with AWS

![Image Recognition Logo](assets/AmazonRekognition.gif)

**Automate visual analysis and unlock valuable insights with AWS Lambda, S3, Rekognition, and SNS**

[![LinkedIn](https://img.shields.io/badge/Connect%20with%20me%20on-LinkedIn-blue.svg)](https://www.linkedin.com/in/aman-devops/)
[![GitHub](https://img.shields.io/github/stars/AmanPathak-DevOps.svg?style=social)](https://github.com/AmanPathak-DevOps)
[![Serverless](https://img.shields.io/badge/Serverless-%E2%9A%A1%EF%B8%8F-blueviolet)](https://www.serverless.com)
[![AWS](https://img.shields.io/badge/AWS-%F0%9F%9B%A1-orange)](https://aws.amazon.com)
[![Terraform](https://img.shields.io/badge/Terraform-%E2%9C%A8-lightgrey)](https://www.terraform.io)

---

## Overview

This Terraform repository provides an infrastructure-as-code solution to build intelligent image recognition systems using AWS services. By automating visual analysis, you can detect objects, identify faces, moderate content, and gain valuable insights from images or videos.

## Features

- **Automated Deployment**: Use Terraform to easily and consistently provision the necessary AWS resources for image recognition.
- **Flexible Configuration**: Customize the solution to match your specific requirements and environment.
- **Scalable Architecture**: Leverage the scalability of AWS services to handle varying workloads and data volumes.
- **Easy Management**: Monitor, update, and manage your infrastructure with ease using Terraform.

## Getting Started

Follow these steps to set up the image recognition solution in your AWS environment:

1. Clone the repository: `git clone https://github.com/AmanPathak-DevOps/Terraform-for-AWS.git`
2. Configure AWS credentials: Set up your AWS credentials using the AWS CLI or environment variables.
3. Work Directory will be for this Project: Non-Modularized/Image-Recognistion-using-Amazon-Rekognition
4. Customize the configuration: Modify the `variables.tf` file to adjust the settings and inputs as needed.
5. Initialize Terraform: Run `terraform init` to initialize the Terraform workspace.
6. Review the execution plan: Execute `terraform plan` to view the proposed changes and ensure everything is as expected.
7. Deploy the infrastructure: Run `terraform apply` to create the AWS resources based on the Terraform configuration.
8. Test and validate: Upload sample images or videos to the designated S3 bucket and observe the image recognition results.
9. Cleanup (optional): When you're done, run `terraform destroy` to remove all the created AWS resources.

For detailed instructions, refer to the [documentation](https://github.com/AmanPathak-DevOps/Terraform-for-AWS/tree/master/Non-Modularized/Image-Recognistion-using-Amazon-Rekognition).

## Contributing

Contributions are welcome! If you have ideas, suggestions, or improvements, please open an issue or submit a pull request. Let's collaborate and make this project even better together.


## Resources

- [Medium Blog Post](https://medium.com/@aman.pathak_51134/building-intelligent-image-recognition-systems-with-aws-lambda-s3-rekognition-and-sns-a-b0902404a178): Learn more about the project implementation and best practices.
- [AWS Lambda Documentation](https://aws.amazon.com/lambda/): Official documentation for AWS Lambda.
- [AWS Rekognition Documentation](https://aws.amazon.com/rekognition/): Official documentation for AWS Rekognition.
- [Terraform Documentation](https://www.terraform.io/docs/): Official documentation for Terraform.

---

## Credits

This project was developed by [Aman Pathak](https://github.com/AmanPathak-DevOps).

Special thanks to the open-source community for their valuable contributions and inspiration.
