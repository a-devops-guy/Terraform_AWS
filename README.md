# Terraform_AWS

### AWS architecture for vue storefront open source eccommerce using packer, terraform and ansible

### Work Pending:
1. cloudflare & data sync setting to sync media files from magento BO node to S3 and make sf to access static content from  cloudfront (s3) endpoint
2. lambda function to start and start ec instance 
3. python script for rabbitmq producer and consumer
4. create a pipeline using aws/devops tools - ref vue_storefront/pipeline repo
5. need to make few changes to terraform custom modules to make this more dynamic and user-friendly to build a multi az HA or single az lower environment archituture for vue storefront project

### Architecture Diagram
![alt text](https://github.com/a-devops-guy/Terraform_AWS/blob/master/aws.png)
## Note: The architecture diagram is subject to changes
