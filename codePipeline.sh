#!/bin/bash

# Define variables with parameter values
REGION=YourRegion
S3_BUCKET_NAME=YourS3BucketName
BUILD_PROJECT_NAME=YourCodeBuildProjectName
DEPLOY_PROJECT_NAME=YourCodeDeployProjectName
ENVIRONMENT=YourEnvironmentName


# Define an array of tuples containing repository and branch pairs
repositories_branches=(
    "repo_1 dev"
    "repo_2 dev"
    # Add more repository and branch pairs as needed
)

for tuple in "${repositories_branches[@]}"; do
    tuple_array=($tuple)  
    REPOSITORY_NAME=${tuple_array[0]}
    BRANCH_NAME=${tuple_array[1]}
    CODE_PIPELINE_NAME=$REPOSITORY_NAME
    STACK_NAME=$REPOSITORY_NAME-$ENVIRONMENT-PIPELINE-STACK
  
   echo "Repository: $REPOSITORY_NAME, Branch: $BRANCH_NAME"

    # Create CloudFormation Stack
    aws cloudformation create-stack \
      --stack-name $STACK_NAME \
      --template-body file://./codepipeline.json \
      --parameters \
        ParameterKey=CodePipelineName,ParameterValue="$CODE_PIPELINE_NAME" \
        ParameterKey=Environment,ParameterValue="$ENVIRONMENT" \
        ParameterKey=Region,ParameterValue="$REGION" \
        ParameterKey=S3BucketName,ParameterValue="$S3_BUCKET_NAME" \
        ParameterKey=BuildProjectName,ParameterValue="$BUILD_PROJECT_NAME" \
        ParameterKey=DeployProjectName,ParameterValue="$DEPLOY_PROJECT_NAME" \
        ParameterKey=RepositoryName,ParameterValue="$REPOSITORY_NAME" \
        ParameterKey=BranchName,ParameterValue="$BRANCH_NAME" \
      --capabilities CAPABILITY_IAM

    # Wait for Stack Creation to Complete
    if aws cloudformation wait stack-create-complete --stack-name "$STACK_NAME"; then
        echo "Stack creation completed successfully."
    else
        echo "Stack creation failed."
    fi

    # Disable Stage Transition in CodePipeline
    PIPELINE_NAME="CloudFormationCodePipeline-$ENVIRONMENT-cicd-pipeline"
    if aws codepipeline disable-stage-transition --pipeline-name "$CODE_PIPELINE_NAME-$ENVIRONMENT-cicd-pipeline" --stage-name Deploy --transition-type Inbound --reason "stop"; then
        echo "Stage transition disabled successfully."
    else
        echo "Failed to disable stage transition." 
    fi

done