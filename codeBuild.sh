#!/bin/bash

# Define parameter values as variables
STACK_NAME=codeBuildStack
CODE_BUILD_PROJECT_NAME=YourCodeBuildProjectName
CODE_DEPLOY_PROJECT_NAME=YourCodeDeployProjectName
S3_BUCKET_NAME=YourS3BucketName
ACCESS_KEY_ID=YourAccessKeyId
SECRET_ACCESS_KEY=YourSecretAccessKey
REGION=YourRegion

# Create CloudFormation stack
aws cloudformation create-stack \
  --stack-name $STACK_NAME \
  --template-body file://./codeBuild.json \
  --parameters \
      ParameterKey=CodeBuildBackendContainerBuildProjectName,ParameterValue="$CODE_BUILD_PROJECT_NAME" \
      ParameterKey=CodeDeployBackendContainerDeployProjectName,ParameterValue="$CODE_DEPLOY_PROJECT_NAME" \
      ParameterKey=S3BucketName,ParameterValue="$S3_BUCKET_NAME" \
      ParameterKey=AwsAccessKeyId,ParameterValue="$ACCESS_KEY_ID" \
      ParameterKey=AwsSecretAccessKey,ParameterValue="$SECRET_ACCESS_KEY" \
      ParameterKey=Region,ParameterValue="$REGION" \
      ParameterKey=AwsProfile,ParameterValue="$AWS_PROFILE" \
      ParameterKey=AmplifyCliVersion,ParameterValue="$AMPLIFY_CLI_VERSION" \
  --capabilities CAPABILITY_IAM

# Wait for Stack Creation to Complete
if aws cloudformation wait stack-create-complete --stack-name "$STACK_NAME"; then
    echo "Stack creation completed successfully."
else
    echo "Stack creation failed."
fi