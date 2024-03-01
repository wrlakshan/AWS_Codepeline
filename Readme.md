# Code Build

This is related to the create new aws code Build project.

## Configuration

Before running the script, make sure to update the following variables in the script `codeBuild.sh`:

- `STACK_NAME`: The name you want to assign to your CloudFormation stack.
- `CODE_BUILD_PROJECT_NAME`: The name of your AWS CodeBuild project for building the backend container.
- `CODE_DEPLOY_PROJECT_NAME`: The name of your AWS CodeDeploy project for deploying the backend container.
- `S3_BUCKET_NAME`: The name of the S3 bucket where your project artifacts will be stored.
- `ACCESS_KEY_ID`: Your AWS Access Key ID with permissions to create and manage resources.
- `SECRET_ACCESS_KEY`: Your AWS Secret Access Key corresponding to the Access Key ID.
- `REGION`: The AWS region where you want to deploy your codebuild project.

## Instructions

1. Open the `codeBuild.sh` script in a text editor.
2. Update the values of the variables mentioned above with your specific configuration.
3. Save the changes.

## Running the Script

After updating the variables, you can run the script using the following command:

```bash
./codeBuild.sh
```

# Code Pipeline

This is related to the create new aws code Pipelines.

## Configuration

Before running the scripts, make sure to update the following variables in the respective CloudFormation template file (`codePipeline.json`) and bash scripts (`codePipeline.sh`):

### `codePipeline.json`

Update the default values in the `codePipeline.json` file as needed.

1. **BuildEnvironmentVariables**:

   - Update the default environment variables as needed. Modify the `Default` value to reflect your desired environment variable configuration.

2. **DeployEnvironmentVariables**:
   - Update the default environment variables as needed. Modify the `Default` value to reflect your desired environment variable configuration.

### `codePipeline.sh`

1. **Variables**:

   - `REGION`: The AWS region where you want to deploy your code pipeline.
   - `S3_BUCKET_NAME`: The name of the S3 bucket where your project artifacts will be stored.
   - `BUILD_PROJECT_NAME`: The name of your AWS CodeBuild project for building the backend container.
   - `DEPLOY_PROJECT_NAME`: The name of your AWS CodeDeploy project for deploying the backend container.
   - `ENVIRONMENT`: The name of the environment you are deploying to.

2. **repositories_branches Array**:
   - Update the repository and branch pairs as needed. Each entry should be in the format "repository_name branch_name".

## Instructions

1. Open the `codePipeline.json` file in a text editor.
2. Update the default values of the variables mentioned above with your specific configuration.
3. Save the changes.

4. Open the `codePipeline.sh` script in a text editor.
5. Update the variables mentioned above with your specific configuration.
6. Save the changes.

## Running the Scripts

After updating the variables, you can run the scripts using the following commands:

- `./codePipeline.sh` (for deploying the CloudFormation stacks)

## Important Notes

- Review the permissions assigned to the Access Key ID and Secret Access Key to ensure they have sufficient privileges for the intended operations.
- Make sure the AWS CLI profile used has appropriate permissions to create and manage resources mentioned in the script.
