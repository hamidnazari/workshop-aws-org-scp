# Do change
ACC2_EMAIL=hamid.nazari+account2@innablr.com.au

MASTER_ACC_NUMBER=439001261645
ACC1_NUMBER=318100917939
ACC2_NUMBER=987076915755

# Don't change
ACC2_NAME=Workshop Account 2
REGION=ap-southeast-2
STACKSETADMIN_STACKNAME=workshop-stackset-admin
RESTRICTEDADMIN_STACKSETNAME=workshop-restricted-admin

account2:
	@echo "Creating an Account named '$(ACC2_NAME)' using '$(ACC2_EMAIL)'"
	# Add AWS CLI command for Workshop Account 2 here
	aws organizations create-account \
		--account-name '$(ACC2_NAME)' \
		--email '$(ACC2_EMAIL)'

stackset-admin-role:
	@echo "Deploying StackSet Admin Role CloudFormation Stack"
	# Add AWS CLI command for StackSet Admin Role CloudFormation Stack here
	aws cloudformation $(ACTION)-stack \
		--region $(REGION) \
		--stack-name $(STACKSETADMIN_STACKNAME) \
		--capabilities CAPABILITY_NAMED_IAM \
		--template-body file://./templates/stackset-admin-role.cf.yaml

restricted-admin-role:
	@echo "Deploying Restricted Admin Role CloudFormation StackSet"
	# Add AWS CLI command for Restricted Admin Role CloudFormation StackSet here
	aws cloudformation $(ACTION)-stack-set \
		--region $(REGION) \
		--stack-set-name $(RESTRICTEDADMIN_STACKSETNAME) \
		--capabilities CAPABILITY_NAMED_IAM \
		--administration-role-arn arn:aws:iam::$(MASTER_ACC_NUMBER):role/WorkshopCloudFormationStackSetAdministrationRole \
		--execution-role-name WorkshopCloudFormationStackSetExecutionRole \
		--template-body file://./templates/restricted-admin-role.cf.yaml \
		--parameters ParameterKey=AdministratorAccountId,ParameterValue=$(MASTER_ACC_NUMBER)

restricted-admin-role-accounts:
	aws cloudformation $(ACTION)-stack-instances \
		--stack-set-name $(RESTRICTEDADMIN_STACKSETNAME) \
		--accounts $(ACC1_NUMBER) $(ACC2_NUMBER) \
		--regions $(REGION)
