#!/bin/bash

# Environment variables
ENVIRONMENT=$1

# Function to check the number of arguments
check_num_of_args() {
  if [ "$#" -ne 1 ]; then
      echo "Usage: $0 <environment>"
          exit 1
	    fi
	    }

    # Function to activate infrastructure based on environment
    activate_infra_environment() {
      case "$ENVIRONMENT" in
          local)
        echo "Running script for Local Environment..."
	      ;;
          testing)
echo "Running script for Testing Environment..."
      ;;
          production)
	        echo "Running script for Production Environment..."
		      ;;
		          *)
			        echo "Invalid environment specified. Use 'local', 'testing', or 'production'."
				      exit 2
	            ;;
			      esac
		      }

	  # Function to check if AWS CLI is installed
	      check_aws_cli() {
	      if ! command -v aws &> /dev/null; then
	    echo "AWS CLI is not installed. Please install it before proceeding."
	        exit 3

			else
			echo "Aws is installed"
			fi
	  }
# Function to check if AWS profile is set
check_aws_profile() {
  if [ -z "$AWS_PROFILE" ]; then
      echo "AWS_PROFILE environment variable is not set."
          exit 4

			else
			echo "AWS is found"
			fi
	    }

	    # Function to create EC2 Instances
	    create_ec2_instances() {
	      instance_type="t2.micro"
	        ami_id="ami-72938776480"  # Replace with valid AMI ID for your region
		  count=2
		    region="us-east-1"
		      key_name="Key-name"  # Replace with your key pair name

		        echo "Creating $count EC2 instances in $region..."

			  aws ec2 run-instances \
			      --image-id "$ami_id" \
			          --instance-type "$instance_type" \
				      --count "$count" \
				          --region "$region" \
					      --key-name "$key_name"

					        if [ $? -eq 0 ]; then
						    echo "EC2 instances created successfully."
						      else
						          echo "Failed to create EC2 instances."
							      exit 5
							        fi
								}
# Function to create S3 buckets for different departments
create_s3_buckets() {
  company="datawise"
    region="eu-west-2"
      departments=("Marketing" "Sales" "HR" "Operations" "Media")

        for department in "${departments[@]}"; do
	    bucket_name="${company,,}-${department,,}-data-bucket"
	        bucket_name="${bucket_name// /-}"  # Replace spaces with hyphens

		    echo "Creating S3 bucket: $bucket_name..."
		        aws s3api create-bucket \
			      --bucket "$bucket_name" \
			            --region "$region" \
				          --create-bucket-configuration LocationConstraint="$region"

					      if [ $? -eq 0 ]; then
					            echo "S3 bucket '$bucket_name' created successfully."
						        else
							      echo "Failed to create S3 bucket '$bucket_name'."
							          fi
								    done
								    }

								    # Execute all functions
								    check_num_of_args "$@"
								    activate_infra_environment
								    check_aws_cli
								    check_aws_profile
								    create_ec2_instances
								    create_s3_buckets
